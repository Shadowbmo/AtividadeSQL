-- -----------------------------------------------------
-- View relatorio de vendas
-- -----------------------------------------------------

CREATE OR REPLACE VIEW relatorio_vendas AS
SELECT
    produto.codigo_de_barras,
    produto.nome_pro AS nome,
    COALESCE(SUM(item_venda.nro_quantidade), 0) AS quantidade_vendida,
    produto.vlr_venda as valor_do_produto,
    COALESCE(SUM(item_venda.nro_quantidade * produto.vlr_venda), 0) AS valor_total_vendido,
  	produto.ind_is_caixa AS ìsCaixa,
    supermercado.cnpj
FROM
    produto
LEFT JOIN
    controle_produto ON produto.nro_int_pro = controle_produto.nro_int_pro
LEFT JOIN
    item_venda ON controle_produto.nro_int_con_pro = item_venda.nro_int_con_pro
LEFT JOIN
    venda ON item_venda.nro_int_ven = venda.nro_int_ven
    LEFT JOIN
    supermercado ON produto.nro_int_sup = supermercado.nro_int_sup
    
GROUP BY
    produto.codigo_de_barras,
    produto.nome_pro,
    produto.vlr_venda,
	  produto.ind_is_caixa,
    supermercado.cnpj
ORDER BY
    valor_total_vendido DESC;

-- -----------------------------------------------------
-- Chamar a view
-- -----------------------------------------------------

SELECT * FROM relatorio_vendas;

-- -----------------------------------------------------
-- Criar a função que calcula impostos sobre as vendas
-- -----------------------------------------------------

CREATE OR REPLACE FUNCTION CalculaImpostosVendas(parametro_nro_int_ven INT, parametro_cnpj TEXT) 
RETURNS DECIMAL AS $$
DECLARE 
    variavel_vlr_venda DECIMAL;
    variavel_vlr_impostos DECIMAL(11,2);
BEGIN
    SELECT VLR_TOTAL INTO variavel_vlr_venda
    FROM Venda v
     JOIN Jornada_Caixa jc ON v.NRO_INT_JOR_CAI = jc.NRO_INT_JOR_CAI
     JOIN Caixa_Registradora cr ON jc.NRO_INT_CAI_REG = cr.NRO_INT_CAI_REG
     JOIN Supermercado s ON cr.NRO_INT_SUP = s.NRO_INT_SUP
    WHERE v.NRO_INT_VEN = parametro_nro_int_ven
        AND s.CNPJ = parametro_cnpj;

    variavel_vlr_impostos := variavel_vlr_venda * 0.10; -- Exemplo de calculo de impostos (10% do valor total da venda)
    RETURN variavel_vlr_impostos;
END;
$$ LANGUAGE plpgsql;

-- -----------------------------------------------------
-- Chamar a função (1)
-- -----------------------------------------------------

select * from supermercado;
SELECT CalculaImpostosVendas(1, '11.111.111/0001-11') AS Impostos;

-- -----------------------------------------------------
-- Criar a função (2) Calcular lucro por periodo informado
-- -----------------------------------------------------

CREATE OR REPLACE FUNCTION calcular_lucro_periodo(parametro_data_inicio DATE, parametro_data_fim DATE, parametro_codigo_barras TEXT, parametro_cnpj TEXT)
RETURNS TABLE (
    nome_produto VARCHAR(45),
    valor_unitario DECIMAL,
    valor_lucro DECIMAL,
    quantidade_restante DECIMAL,
    valor_compra DECIMAL
) AS $$
BEGIN
  RETURN QUERY
  SELECT p.NOME_PRO, p.VLR_VENDA, 
    SUM((cp.NRO_QUANTIDADE * cp.VLR_COMPRA) - (iv.NRO_QUANTIDADE * p.VLR_VENDA) ) AS valor_lucro,
    (cp.NRO_QUANTIDADE - SUM(iv.NRO_QUANTIDADE))::DECIMAL AS quantidade_restante,
    cp.VLR_COMPRA AS valor_compra
  FROM Produto p
   JOIN Controle_Produto cp ON p.NRO_INT_PRO = cp.NRO_INT_PRO
   JOIN Item_Venda iv ON cp.NRO_INT_CON_PRO = iv.NRO_INT_CON_PRO
   JOIN Venda v ON iv.NRO_INT_VEN = v.NRO_INT_VEN
   JOIN Jornada_Caixa jc ON v.NRO_INT_JOR_CAI = jc.NRO_INT_JOR_CAI
   JOIN Caixa_Registradora cr ON jc.NRO_INT_CAI_REG = cr.NRO_INT_CAI_REG
   JOIN Supermercado s ON cr.NRO_INT_SUP = s.NRO_INT_SUP
  WHERE v.DTH_VENDA BETWEEN parametro_data_inicio AND parametro_data_fim
    AND p.CODIGO_DE_BARRAS = parametro_codigo_barras
    AND s.CNPJ = parametro_cnpj
  GROUP BY p.NOME_PRO, p.VLR_VENDA, DATE_TRUNC('month', v.DTH_VENDA), cp.NRO_QUANTIDADE, cp.VLR_COMPRA;
  
  RETURN;
END;
$$ LANGUAGE plpgsql;


-- -----------------------------------------------------
-- Chamar a função (2)
-- -----------------------------------------------------

SELECT nome_produto, valor_unitario, valor_compra, quantidade_restante, valor_lucro
FROM calcular_lucro_periodo('2023-01-01', '2023-12-30', '12', '11.111.111/0001-11');

-- -----------------------------------------------------
-- Criar um indice para o codigo de barras do produto
-- -----------------------------------------------------

CREATE INDEX idx_produto_codigo_barras ON Produto (CODIGO_DE_BARRAS);

-- -----------------------------------------------------
-- Usando o indice (1)
-- -----------------------------------------------------

SELECT * FROM produto INDEX (idx_produto_codigo_barras) where codigo_de_barras = '12';

-- -----------------------------------------------------
-- Criar um indice para o codigo de barras da nota fiscal
-- -----------------------------------------------------

CREATE INDEX idx_nota_fiscal_codigo_barras ON Nota_Fiscal (CODIGO_DE_BARRAS);

-- -----------------------------------------------------
-- Usando o indice (2)
-- -----------------------------------------------------

SELECT * FROM produto INDEX (idx_nota_fiscal_codigo_barras) where codigo_de_barras = '';

-- -----------------------------------------------------
-- Criando procedure Destroir caixas
-- -----------------------------------------------------

CREATE OR REPLACE PROCEDURE destroi_caixa(
  parametro_nome_produto VARCHAR(45),
  parametro_quantidade_pegou INT
)
LANGUAGE plpgsql
AS $$
DECLARE
  variavel_id_produto_caixa INT;
  variavel_id_produto_unidade INT;
  variavel_nro_quantidade_caixa INT;
  variavel_nro_quantidade_unidade int;
  variavel_nro_quantidade_contida_caixa INT;
BEGIN
  -- Verificar se o produto caixa existe
  SELECT NRO_INT_PRO, NRO_QUANTIDADE_CONTIDA
  INTO variavel_id_produto_caixa, variavel_nro_quantidade_contida_caixa
  FROM Produto
  WHERE NOME_PRO = parametro_nome_produto AND IND_IS_CAIXA = 'S';

  IF variavel_id_produto_caixa IS NULL THEN
    RAISE EXCEPTION 'O produto caixa "%", não existe.', parametro_nome_produto;
  END IF;

  -- Verificar se o produto unidade existe
  SELECT NRO_INT_PRO
  INTO variavel_id_produto_unidade
  FROM Produto
  WHERE NOME_PRO = parametro_nome_produto AND IND_IS_CAIXA = 'N';

  IF variavel_id_produto_unidade IS NULL THEN
    RAISE EXCEPTION 'O produto unidade "%", não existe.', parametro_nome_produto;
  END IF;

  -- Obter a quantidade de caixas
  SELECT SUM(NRO_QUANTIDADE)
  INTO variavel_nro_quantidade_caixa
  FROM Controle_Produto
  WHERE NRO_INT_PRO = variavel_id_produto_caixa;

  -- Obter a quantidade de unidades
  SELECT SUM(NRO_QUANTIDADE)
  INTO variavel_nro_quantidade_unidade
  FROM Controle_Produto
  WHERE NRO_INT_PRO = variavel_id_produto_unidade;

  IF variavel_nro_quantidade_caixa IS NULL THEN
    RAISE EXCEPTION 'A quantidade de caixas do produto "%s" é nula.', parametro_nome_produto;
  END IF;

  -- Calcular a quantidade total de unidades
  DECLARE
    variavel_nro_quantidade_total INT;
  BEGIN
    SELECT (variavel_nro_quantidade_contida_caixa - parametro_quantidade_pegou)
    INTO variavel_nro_quantidade_total
    FROM Produto
    WHERE NRO_INT_PRO = variavel_id_produto_caixa;

    -- Iniciar uma transação
    BEGIN
      -- Atualizar a quantidade de caixas
      UPDATE Controle_Produto
      SET NRO_QUANTIDADE = variavel_nro_quantidade_caixa - 1
      WHERE NRO_INT_PRO = variavel_id_produto_caixa;

      -- Atualizar a quantidade total de unidades
      UPDATE Controle_Produto
      SET NRO_QUANTIDADE = variavel_nro_quantidade_unidade + variavel_nro_quantidade_total
      WHERE NRO_INT_PRO = variavel_id_produto_unidade;

      -- Verificar se houve erro durante as atualizações
      IF NOT FOUND THEN
        ROLLBACK;
        RAISE EXCEPTION 'Erro ao atualizar as quantidades.';
      END IF;
      COMMIT;
    END;
  END;
END;
$$;

-- -----------------------------------------------------
-- Chamara procedure
-- -----------------------------------------------------

select * from produto;
select * from controle_produto where nro_int_pro = 6 or nro_int_pro = 7;
CALL destroi_caixa('Creme de leite', 13);

-- -----------------------------------------------------
-- Criar a procedure de realizar compra
-- -----------------------------------------------------

CREATE OR REPLACE PROCEDURE realizar_compra(produtos_quantidades TEXT, cpf_funcionario TEXT) AS $$
DECLARE
    variavel_produto_quantidade TEXT;
    vaiavel_nro_int_pro INT;
    variavel_quantidade INT;
    variavel_valor_total_soma DECIMAL := 0;
    variavel_nro_int_jor_caixa INT;
    variavel_nro_int_venda INT;
    variavel_nro_int_con_produto INT;
BEGIN
    -- Iniciar a transação
    BEGIN
        -- Obter o nro_int_jor_caixa com base na data atual e no CPF do funcionário
        SELECT jor.nro_int_jor_cai INTO variavel_nro_int_jor_caixa
        FROM jornada_caixa jor
        JOIN funcionario fun ON jor.nro_int_fun = fun.nro_int_fun
        WHERE jor.DTH_ABERTURA = current_date
        AND fun.cpf_FUN = cpf_funcionario;

        -- Verificar se a jornada do caixa foi encontrada
        IF variavel_nro_int_jor_caixa IS NULL THEN
            -- Realizar o ROLLBACK e retornar uma mensagem de erro
            RAISE EXCEPTION 'Jornada do caixa não encontrada para o funcionário e data atual';
        END IF;

        -- Criar uma nova venda com o valor total, a data atual, o nro_int_jor_cai e o variavel_nro_int_jor_caixa
        INSERT INTO venda (nro_int_jor_cai, dth_venda, vlr_total)
        VALUES (variavel_nro_int_jor_caixa, current_timestamp, variavel_valor_total_soma)
        RETURNING nro_int_ven INTO variavel_nro_int_venda;

        -- Loop através dos produtos e quantidades fornecidos
        FOR variavel_produto_quantidade IN SELECT regexp_split_to_table(produtos_quantidades, ';') AS p_q LOOP
            vaiavel_nro_int_pro := (
                SELECT pro.nro_int_pro
                FROM produto pro
                WHERE pro.codigo_de_barras = split_part(variavel_produto_quantidade, ',', 1)
            )::INT;

            variavel_quantidade := split_part(variavel_produto_quantidade, ',', 2)::INT;

            -- Verificar se a quantidade fornecida é maior do que a disponível em Controle_Produto
            IF variavel_quantidade > (SELECT sum(nro_quantidade) FROM controle_produto WHERE nro_int_pro = vaiavel_nro_int_pro) THEN
                ROLLBACK;
                RAISE EXCEPTION 'Quantidade fornecida é maior do que a disponível em Controle_Produto';
            END IF;

            -- Atualizar o valor_total_soma com base no valor do produto e quantidade
            variavel_valor_total_soma := variavel_valor_total_soma + (SELECT vlr_venda FROM produto WHERE nro_int_pro = vaiavel_nro_int_pro) * variavel_quantidade;

            -- Obter o ID do Controle_Produto 
            SELECT cp.nro_int_con_pro INTO variavel_nro_int_con_produto
            FROM controle_produto cp
            WHERE cp.nro_int_pro = vaiavel_nro_int_pro
            AND cp.nro_quantidade > 0
            ORDER BY cp.dt_vencimento ASC
            LIMIT 1;

            -- Subtrair a quantidade do Controle_Produto
            UPDATE controle_produto SET nro_quantidade = nro_quantidade - variavel_quantidade WHERE nro_int_con_pro = variavel_nro_int_con_produto;

            -- Inserir o item vendido na tabela item_venda
            INSERT INTO item_venda (nro_int_ven, nro_int_con_pro, nro_quantidade) VALUES (variavel_nro_int_venda, variavel_nro_int_con_produto, variavel_quantidade);
        END LOOP;

        -- Atualizar o valor total da venda
        UPDATE venda SET vlr_total = variavel_valor_total_soma WHERE nro_int_ven = variavel_nro_int_venda;

        COMMIT;
      EXCEPTION WHEN OTHERS THEN
            ROLLBACK;
            RAISE EXCEPTION 'Ocorreu um erro ao realizar a compra. A transação foi revertida (ROLLBACK)';
    END;
END;
$$ LANGUAGE plpgsql;

-- -----------------------------------------------------
-- Chamara a procedure 
-- -----------------------------------------------------

CALL realizar_compra('12,2;1234,2', '123.456.789-01');

-- -----------------------------------------------------
-- ABRIR CAIXA
-- -----------------------------------------------------

CREATE OR REPLACE FUNCTION abrir_caixa(
  parametro_nro_caixa INT,
  parametro_cpf_funcionario VARCHAR(14),
  parametro_valor_inicial DECIMAL
)
RETURNS VOID
AS $$
DECLARE
  variavel_nro_int_caixa INT;
  variavel_dth_abertura TIMESTAMP;
  variavel_nro_int_funcionario INT;
BEGIN
  -- Verificar se já existe um caixa aberto para o mesmo CPF no mesmo dia
  SELECT Jornada_Caixa.NRO_INT_CAI_REG, DTH_ABERTURA
  INTO variavel_nro_int_caixa, variavel_dth_abertura
  FROM Caixa_Registradora
  JOIN Jornada_Caixa ON Caixa_Registradora.NRO_INT_CAI_REG = Jornada_Caixa.NRO_INT_CAI_REG
  JOIN Funcionario ON Jornada_Caixa.NRO_INT_FUN = Funcionario.NRO_INT_FUN
  WHERE Funcionario.CPF_FUN = parametro_cpf_funcionario
    AND Jornada_Caixa.DTH_ABERTURA::DATE = current_date
    AND Caixa_Registradora.NRO_CAIXA = parametro_nro_caixa;
  IF FOUND THEN
    -- Existe um caixa aberto para o mesmo CPF no mesmo dia
    RAISE EXCEPTION 'Caixa com o CPF % já está aberto. Por favor, finalize o caixa para iniciar outro.', parametro_cpf_funcionario;
  END IF;

  -- Obter o ID do funcionário a partir do CPF
  SELECT NRO_INT_FUN INTO variavel_nro_int_funcionario
  FROM Funcionario
  WHERE CPF_FUN = parametro_cpf_funcionario;

  -- Inserir um novo registro na tabela Jornada_Caixa com os valores informados
  INSERT INTO Jornada_Caixa (NRO_INT_CAI_REG, NRO_INT_FUN, DTH_ABERTURA, DTH_FECHAMENTO, VLR_CAIXA_INICIAL)
  VALUES ((SELECT NRO_INT_CAI_REG FROM Caixa_Registradora WHERE NRO_CAIXA = parametro_nro_caixa), variavel_nro_int_funcionario, current_date, NULL, parametro_valor_inicial);

END;
$$ LANGUAGE plpgsql;