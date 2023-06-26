-- -----------------------------------------------------
-- Tabela Supermercado
-- -----------------------------------------------------

CREATE TABLE Supermercado (
  NRO_INT_SUP SERIAL PRIMARY KEY,
  CNPJ CHAR(18) NOT NULL UNIQUE,
  NOME_SUP VARCHAR(100) NOT NULL,
  LOUGRADOURO VARCHAR(45) NULL,
  CIDADE VARCHAR(45) NOT NULL,
  ESTADO VARCHAR(45) NOT NULL
);

-- -----------------------------------------------------
-- Tabela Funcionario
-- -----------------------------------------------------

CREATE TABLE Funcionario (
  NRO_INT_FUN SERIAL PRIMARY KEY,
  NRO_INT_SUP INT NOT NULL,
  NOME_FUN VARCHAR(100) NOT NULL,
  CPF_FUN VARCHAR(14) NOT NULL,
  FOREIGN KEY (NRO_INT_SUP) REFERENCES Supermercado (NRO_INT_SUP)
);

-- -----------------------------------------------------
-- Tabela Caixa_Registradora
-- -----------------------------------------------------

CREATE TABLE Caixa_Registradora (
  NRO_INT_CAI_REG SERIAL PRIMARY KEY,
  NRO_INT_SUP INT NOT NULL,
  TIPO VARCHAR(20) NOT NULL,
  STATUS VARCHAR(45) NOT NULL,
  NRO_CAIXA INT NOT NULL,
  FOREIGN KEY (NRO_INT_SUP) REFERENCES Supermercado (NRO_INT_SUP)
);

-- -----------------------------------------------------
-- Tabela Jornada_Caixa
-- -----------------------------------------------------

CREATE TABLE Jornada_Caixa (
  NRO_INT_JOR_CAI SERIAL PRIMARY KEY,
  NRO_INT_CAI_REG INT NOT NULL,
  NRO_INT_FUN INT NOT NULL,
  DTH_ABERTURA TIMESTAMP NOT NULL,
  DTH_FECHAMENTO TIMESTAMP NULL,
  VLR_CAIXA_INICIAL DECIMAL(11,2) NOT NULL,
  VLR_CAIXA_FINAL DECIMAL(11,2) NULL,
  FOREIGN KEY (NRO_INT_CAI_REG) REFERENCES Caixa_Registradora (NRO_INT_CAI_REG),
  FOREIGN KEY (NRO_INT_FUN) REFERENCES Funcionario (NRO_INT_FUN)
);

-- -----------------------------------------------------
-- Tabela Venda
-- -----------------------------------------------------

CREATE TABLE Venda (
  NRO_INT_VEN SERIAL PRIMARY KEY,
  NRO_INT_JOR_CAI INT NOT NULL,
  DTH_VENDA TIMESTAMP NOT NULL,
  VLR_TOTAL DECIMAL(11,2) NULL,
  FOREIGN KEY (NRO_INT_JOR_CAI) REFERENCES Jornada_Caixa (NRO_INT_JOR_CAI)
);

-- -----------------------------------------------------
-- Tabela Nota_Fiscal
-- -----------------------------------------------------

CREATE TABLE Nota_Fiscal (
  NRO_INT_VEN INT NOT NULL,
  NRO_INT_SUP INT NOT NULL,
  VLR_TRIBUTARIO DECIMAL(11,2) NOT NULL,
  CODIGO_DE_BARRAS VARCHAR(45) NOT NULL UNIQUE,
  CPF_CLIENTE VARCHAR(14) NULL,
  DTH_EMISSAO DATE NOT NULL,
  PRIMARY KEY (NRO_INT_VEN),
  FOREIGN KEY (NRO_INT_VEN) REFERENCES Venda (NRO_INT_VEN),
  FOREIGN KEY (NRO_INT_SUP) REFERENCES Supermercado (NRO_INT_SUP)
);

-- -----------------------------------------------------
-- Tabela Fornecedor
-- -----------------------------------------------------

CREATE TABLE Fornecedor (
  NRO_INT_FOR SERIAL PRIMARY KEY,
  CNPJ_FOR CHAR(18) NOT NULL UNIQUE,
  NOME_FOR VARCHAR(100) NOT NULL
);

-- -----------------------------------------------------
-- Tabela Lote
-- -----------------------------------------------------

CREATE TABLE Lote (
  NRO_INT_LOT SERIAL PRIMARY KEY,
  NRO_INT_FOR INT NOT NULL,
  NRO_QUANTIDADE INT NOT NULL,
  FOREIGN KEY (NRO_INT_FOR) REFERENCES Fornecedor (NRO_INT_FOR)
);

-- -----------------------------------------------------
-- Table Produto
-- -----------------------------------------------------

CREATE TABLE Produto (
  NRO_INT_PRO SERIAL PRIMARY KEY,
  NRO_INT_SUP INT NOT NULL,
  NOME_PRO VARCHAR(45) NOT NULL,
  CODIGO_DE_BARRAS VARCHAR(45) NOT NULL UNIQUE,
  VLR_VENDA DECIMAL(11,2) NOT NULL,
  IND_IS_CAIXA CHAR(1)NOT NULL,
  NRO_QUANTIDADE_CONTIDA INT NOT NULL,
  FOREIGN KEY (NRO_INT_SUP) REFERENCES Supermercado (NRO_INT_SUP),
  CHECK (IND_IS_CAIXA IN ('S', 'N')
));

-- -----------------------------------------------------
-- Table Controle_Produto
-- -----------------------------------------------------

CREATE TABLE Controle_Produto (
  NRO_INT_CON_PRO SERIAL PRIMARY KEY,
  NRO_INT_PRO INT NOT NULL,
  NRO_INT_LOT INT NOT NULL,
  DT_VENCIMENTO DATE NOT NULL,
  DT_FABRICACAO DATE NOT NULL,
  NRO_QUANTIDADE INT NOT NULL,
  VLR_COMPRA decimal(11,2) NOT NULL,
  FOREIGN KEY (NRO_INT_LOT) REFERENCES Lote (NRO_INT_LOT),
  FOREIGN KEY (NRO_INT_PRO) REFERENCES Produto (NRO_INT_PRO)
);

-- -----------------------------------------------------
-- Table Item_Venda
-- -----------------------------------------------------

CREATE TABLE Item_Venda (
  NRO_INT_ITE_VEN SERIAL NOT NULL,
  NRO_INT_VEN INT NOT NULL,
  NRO_INT_CON_PRO INT NOT NULL,
  NRO_QUANTIDADE INT NOT NULL,
  PRIMARY KEY (NRO_INT_ITE_VEN, NRO_INT_VEN, NRO_INT_CON_PRO),
  FOREIGN KEY (NRO_INT_VEN) REFERENCES Venda (NRO_INT_VEN),
  FOREIGN KEY (NRO_INT_CON_PRO) REFERENCES Controle_Produto (NRO_INT_CON_PRO)
);

-- -----------------------------------------------------
-- Table Pagamento
-- -----------------------------------------------------

CREATE TABLE Pagamento (
  NRO_INT_PAG SERIAL PRIMARY KEY,
  NRO_INT_VEN INT NOT NULL,
  VLR_PAGO DECIMAL(11,2) NOT NULL,
  FORMA_DE_PAGAMENTO VARCHAR(45) NOT NULL,
  CONSTRAINT fk_Pagamento_Venda1 FOREIGN KEY (NRO_INT_VEN) REFERENCES Venda (NRO_INT_VEN));
  

  
  
-------------------------------------------------------------------------------------------------------------
		    		---------------------------- Inserindo dados  ----------------------------
--------------------------------------------------------------------------------------------------------------  

-- -----------------------------------------------------
-- Inserindo dados na tabela Supermercado
-- -----------------------------------------------------
INSERT INTO Supermercado ( CNPJ, NOME_SUP, LOUGRADOURO, CIDADE, ESTADO) VALUES
('11.111.111/0001-11', 'Carrefor', 'Paulista', 'São Paulo', 'SP'),
('11.111.111/0001-12', 'Carrefor', 'Brás', 'São Paulo', 'SP'),
('22.222.222/0001-22', 'Mercado Municipal', 'Avenida Atlantica', 'Rio de Janeiro', 'RJ'),
('33.333.333/0001-33', 'Pão de açucar', 'Rua da praia', 'Porto Alegre', 'RS');

-- -----------------------------------------------------
-- Inserindo dados na tabela Produto
-- -----------------------------------------------------
INSERT INTO Produto (NRO_INT_SUP, NOME_PRO, CODIGO_DE_BARRAS, VLR_VENDA, IND_IS_CAIXA, NRO_QUANTIDADE_CONTIDA) VALUES
(1, 'Arroz', '1212123', 10.00, 'N', 1),
(1, 'Skol', '1234', 20.00, 'S', 4),
(1, 'Leite', '12', 5.00, 'N', 1),
(1, 'Skol', '12345', 5.00, 'N', 1),
(1, 'Leite', '123', 50.00, 'S', 10),
(1, 'Creme de leite', '12342131', 12.00,'S', 12),
(1, 'Creme de leite', '123421', 2.00, 'N', 1);

-- -----------------------------------------------------
-- Inserindo dados na tabela Fornecedor
-- -----------------------------------------------------
INSERT INTO Fornecedor (CNPJ_FOR, NOME_FOR) VALUES
('12.345.678/0001-34', 'Fornecedor A'),
('98.765.432/0001-76', 'Fornecedor B');

-- -----------------------------------------------------
-- Inserindo dados na tabela Lote
-- -----------------------------------------------------
INSERT INTO Lote (NRO_INT_FOR, NRO_QUANTIDADE) VALUES
(1, 100),
(1, 50),
(2, 200);

-- -----------------------------------------------------
-- Relacionando os produtos com os lotes
-- -----------------------------------------------------
INSERT INTO Controle_Produto (NRO_INT_PRO, NRO_INT_LOT, DT_VENCIMENTO, DT_FABRICACAO, VLR_COMPRA,NRO_QUANTIDADE) VALUES
(1, 1, '2023-06-30', '2023-06-01',1.00 ,50),
(2, 1, '2023-06-30', '2023-06-01',1.00 ,25),
(3, 2, '2023-07-31', '2023-06-15',1.00 ,30),
(4, 3, '2023-08-31', '2023-06-20',1.00 ,100),
(5, 3, '2023-09-30', '2023-06-25',1.00 ,150),
(6, 3, '2023-09-30', '2023-06-25',1.00 ,100),
(7, 3, '2023-09-30', '2023-06-25',1.00 ,100);

-- -----------------------------------------------------
-- Inserindo dados na Caixa_Registradora
-- -----------------------------------------------------
INSERT INTO Caixa_Registradora (NRO_INT_SUP, TIPO, STATUS, NRO_CAIXA) VALUES
(1, 'Comum', 'Ativo', 1),
(1, 'Comum', 'Ativo', 2),
(1, 'Preferencial', 'Ativo', 3),
(1, 'Caixa rapido', 'Ativo', 4);

-- -----------------------------------------------------
-- Inserindo dados na tabela Funcionario
-- -----------------------------------------------------
INSERT INTO Funcionario (NRO_INT_SUP, NOME_FUN, CPF_FUN) VALUES
(1, 'João Silva', '123.456.789-01'),
(1, 'Maria Santos', '987.654.321-09'),
(1, 'Pedro Almeida', '456.789.123-45'),
(1, 'Ana Pereira', '789.123.456-78'),
(1, 'Carlos Fernandes', '321.654.987-09'),
(1, 'Lúcia Oliveira', '654.321.789-06'),
(1, 'Mariana Costa', '987.654.123-09'),
(1, 'Paulo Santos', '789.456.321-01');

-- -----------------------------------------------------
-- Inserindo dados na Jornada_Caixa
-- -----------------------------------------------------

-- Funcionário 1
INSERT INTO Jornada_Caixa (NRO_INT_CAI_REG, NRO_INT_FUN, DTH_ABERTURA, DTH_FECHAMENTO, VLR_CAIXA_INICIAL, VLR_CAIXA_FINAL) VALUES
(1, 1, '2023-06-01 08:00:00', '2023-06-01 17:00:00', 500.00, 700.00),
(2, 1, '2023-06-02 08:30:00', '2023-06-02 17:30:00', 600.00, 800.00);

-- Funcionário 2
INSERT INTO Jornada_Caixa (NRO_INT_CAI_REG, NRO_INT_FUN, DTH_ABERTURA, DTH_FECHAMENTO, VLR_CAIXA_INICIAL, VLR_CAIXA_FINAL) VALUES
(3, 2, '2023-06-01 08:00:00', '2023-06-01 17:00:00', 550.00, 750.00),
(4, 2, '2023-06-02 08:30:00', '2023-06-02 17:30:00', 650.00, 850.00);

-- Funcionário 3
INSERT INTO Jornada_Caixa (NRO_INT_CAI_REG, NRO_INT_FUN, DTH_ABERTURA, DTH_FECHAMENTO, VLR_CAIXA_INICIAL, VLR_CAIXA_FINAL) VALUES
(1, 3, '2023-06-03 08:00:00', '2023-06-03 17:00:00', 700.00, 900.00),
(2, 3, '2023-06-04 08:30:00', '2023-06-04 17:30:00', 800.00, 1000.00);

-- Funcionário 4
INSERT INTO Jornada_Caixa (NRO_INT_CAI_REG, NRO_INT_FUN, DTH_ABERTURA, DTH_FECHAMENTO, VLR_CAIXA_INICIAL, VLR_CAIXA_FINAL) VALUES
(3, 4, '2023-06-03 08:00:00', '2023-06-03 17:00:00', 750.00, 950.00),
(4, 4, '2023-06-04 08:30:00', '2023-06-04 17:30:00', 850.00, 1050.00);

-- Funcionário 5
INSERT INTO Jornada_Caixa (NRO_INT_CAI_REG, NRO_INT_FUN, DTH_ABERTURA, DTH_FECHAMENTO, VLR_CAIXA_INICIAL, VLR_CAIXA_FINAL) VALUES
(1, 5, '2023-06-05 08:00:00', '2023-06-05 17:00:00', 900.00, 1100.00),
(2, 5, '2023-06-06 08:30:00', '2023-06-06 17:30:00', 1000.00, 1200.00);

-- Funcionário 6
INSERT INTO Jornada_Caixa (NRO_INT_CAI_REG, NRO_INT_FUN, DTH_ABERTURA, DTH_FECHAMENTO, VLR_CAIXA_INICIAL, VLR_CAIXA_FINAL) VALUES
(3, 6, '2023-06-05 08:00:00', '2023-06-05 17:00:00', 950.00, 1150.00),
(4, 6, '2023-06-06 08:30:00', '2023-06-06 17:30:00', 1050.00, 1250.00);

-- Funcionário 7
INSERT INTO Jornada_Caixa (NRO_INT_CAI_REG, NRO_INT_FUN, DTH_ABERTURA, DTH_FECHAMENTO, VLR_CAIXA_INICIAL, VLR_CAIXA_FINAL) VALUES
(1, 7, '2023-06-07 08:00:00', '2023-06-07 17:00:00', 1000.00, 1200.00),
(2, 7, '2023-06-08 08:30:00', '2023-06-08 17:30:00', 1100.00, 1300.00);

-- Funcionário 8
INSERT INTO Jornada_Caixa (NRO_INT_CAI_REG, NRO_INT_FUN, DTH_ABERTURA, DTH_FECHAMENTO, VLR_CAIXA_INICIAL, VLR_CAIXA_FINAL) VALUES
(3, 8, '2023-06-07 08:00:00', '2023-06-07 17:00:00', 1050.00, 1250.00),
(4, 8, '2023-06-08 08:30:00', '2023-06-08 17:30:00', 1150.00, 1350.00);

-- -----------------------------------------------------
-- Inserindo dados na venda
-- -----------------------------------------------------
INSERT INTO Venda (NRO_INT_JOR_CAI, DTH_VENDA, VLR_TOTAL) VALUES
(1, '2023-01-02', 21.00),
(2, '2023-01-05', 8.99),
(3, '2023-02-10', 53.25),
(4, '2023-01-20', 63.00);


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