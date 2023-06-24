-------------------------------------------------------------------------------------------------------------
				---------------------------- Inserindo dados  ----------------------------
--------------------------------------------------------------------------------------------------------------
 
-- -----------------------------------------------------
-- Inserindo dados na tabela Supermercado
-- -----------------------------------------------------

INSERT INTO Supermercado ( CNPJ, NOME_SUP, TIPO, LOUGRADOURO, CIDADE, ESTADO)
VALUES ( '11.111.111/0001-11', 'Carrefor', 'M', 'Paulista', 'São Paulo', 'SP');

INSERT INTO Supermercado (NRO_INT_SUP, CNPJ, NOME_SUP, TIPO, LOUGRADOURO, CIDADE, ESTADO)
VALUES (2, '11.111.111/0001-12', 'Carrefor', 'F', 'Brás', 'São Paulo', 'SP');

INSERT INTO Supermercado (NRO_INT_SUP, CNPJ, NOME_SUP, TIPO, LOUGRADOURO, CIDADE, ESTADO)
VALUES (3, '22.222.222/0001-22', 'Mercado Municipal', 'M', 'Avenida Atlantica', 'Rio de Janeiro', 'RJ');

INSERT INTO Supermercado (NRO_INT_SUP, CNPJ, NOME_SUP, TIPO, LOUGRADOURO, CIDADE, ESTADO)
VALUES (4, '33.333.333/0001-33', 'Pão de açucar', 'M', 'Rua da praia', 'Porto Alegre', 'RS');

-- -----------------------------------------------------
-- Inserindo dados na tabela Produto
-- -----------------------------------------------------

INSERT INTO Produto (NRO_INT_PRO, NRO_INT_SUP, NOME_PRO, CODIGO_DE_BARRAS, VLR_VENDA, IND_IS_CAIXA, NRO_QUANTIDADE_CONTIDA)
VALUES (1, 1, 'Arroz', '1212123', 10.00, 'N', 1);

INSERT INTO Produto (NRO_INT_PRO, NRO_INT_SUP, NOME_PRO, CODIGO_DE_BARRAS, VLR_VENDA, IND_IS_CAIXA, NRO_QUANTIDADE_CONTIDA)
VALUES (2, 1, 'Skol', '1234', 20.00, 'S', 4);

INSERT INTO Produto (NRO_INT_PRO, NRO_INT_SUP, NOME_PRO, CODIGO_DE_BARRAS, VLR_VENDA, IND_IS_CAIXA, NRO_QUANTIDADE_CONTIDA)
VALUES (3, 1, 'Leite', '12', 5.00, 'N', 1);

INSERT INTO Produto (NRO_INT_PRO, NRO_INT_SUP, NOME_PRO, CODIGO_DE_BARRAS, VLR_VENDA, IND_IS_CAIXA, NRO_QUANTIDADE_CONTIDA)
VALUES (4, 1, 'Skol', '12345', 5.00, 'N', 1);

INSERT INTO Produto (NRO_INT_PRO, NRO_INT_SUP, NOME_PRO, CODIGO_DE_BARRAS, VLR_VENDA, IND_IS_CAIXA, NRO_QUANTIDADE_CONTIDA)
VALUES (5, 1, 'Leite', '123', 50.00, 'S', 10);

INSERT INTO Produto (NRO_INT_PRO, NRO_INT_SUP, NOME_PRO, CODIGO_DE_BARRAS, VLR_VENDA, IND_IS_CAIXA, NRO_QUANTIDADE_CONTIDA)
VALUES (6, 1, 'Creme de leite', '12342131', 12.00, 'S', 12);

INSERT INTO Produto (NRO_INT_PRO, NRO_INT_SUP, NOME_PRO, CODIGO_DE_BARRAS, VLR_VENDA, IND_IS_CAIXA, NRO_QUANTIDADE_CONTIDA)
VALUES (7, 1, 'Creme de leite', '123421', 2.00, 'n', 1);

-- -----------------------------------------------------
-- Inserindo dados na tabela Fornecedor
-- -----------------------------------------------------

INSERT INTO Fornecedor (NRO_INT_FOR, CNPJ_FOR, NOME_FOR)
VALUES (1, '12.345.678/0001-34', 'Fornecedor A');

INSERT INTO Fornecedor (NRO_INT_FOR, CNPJ_FOR, NOME_FOR)
VALUES (2, '98.765.432/0001-76', 'Fornecedor B');

-- -----------------------------------------------------
-- Inserindo dados na tabela Lote
-- -----------------------------------------------------

INSERT INTO Lote (NRO_INT_LOT, NRO_INT_FOR, NRO_QUANTIDADE)
VALUES (1, 1, 100);

INSERT INTO Lote (NRO_INT_LOT, NRO_INT_FOR, NRO_QUANTIDADE)
VALUES (2, 1, 50);

INSERT INTO Lote (NRO_INT_LOT, NRO_INT_FOR, NRO_QUANTIDADE)
VALUES (3, 2, 200);

-- -----------------------------------------------------
-- Relacionando os produtos com os lotes
-- -----------------------------------------------------

INSERT INTO Controle_Produto (NRO_INT_CON_PRO, NRO_INT_PRO, NRO_INT_LOT, DT_VENCIMENTO, DT_FABRICACAO, NRO_QUANTIDADE)
VALUES (1, 1, 1, '2023-06-30', '2023-06-01', 50);

INSERT INTO Controle_Produto (NRO_INT_CON_PRO, NRO_INT_PRO, NRO_INT_LOT, DT_VENCIMENTO, DT_FABRICACAO, NRO_QUANTIDADE)
VALUES (2, 2, 1, '2023-06-30', '2023-06-01', 25);

INSERT INTO Controle_Produto (NRO_INT_CON_PRO, NRO_INT_PRO, NRO_INT_LOT, DT_VENCIMENTO, DT_FABRICACAO, NRO_QUANTIDADE)
VALUES (3, 3, 2, '2023-07-31', '2023-06-15', 30);

INSERT INTO Controle_Produto (NRO_INT_CON_PRO, NRO_INT_PRO, NRO_INT_LOT, DT_VENCIMENTO, DT_FABRICACAO, NRO_QUANTIDADE)
VALUES (4, 4, 3, '2023-08-31', '2023-06-20', 100);

INSERT INTO Controle_Produto (NRO_INT_CON_PRO, NRO_INT_PRO, NRO_INT_LOT, DT_VENCIMENTO, DT_FABRICACAO, NRO_QUANTIDADE)
VALUES (5, 5, 3, '2023-09-30', '2023-06-25', 150);

INSERT INTO Controle_Produto (NRO_INT_CON_PRO, NRO_INT_PRO, NRO_INT_LOT, DT_VENCIMENTO, DT_FABRICACAO, NRO_QUANTIDADE)
VALUES (6, 6, 3, '2023-09-30', '2023-06-25', 100);

INSERT INTO Controle_Produto (NRO_INT_CON_PRO, NRO_INT_PRO, NRO_INT_LOT, DT_VENCIMENTO, DT_FABRICACAO, NRO_QUANTIDADE)
VALUES (7, 7, 3, '2023-09-30', '2023-06-25', 100);
-- -----------------------------------------------------
-- Inserindo dados na Caixa_Registradora
-- -----------------------------------------------------

INSERT INTO Caixa_Registradora (NRO_INT_CAI_REG, NRO_INT_SUP, TIPO, STATUS, NRO_CAIXA)
VALUES (1, 1, 'Comum', 'Ativo', 1);

INSERT INTO Caixa_Registradora (NRO_INT_CAI_REG, NRO_INT_SUP, TIPO, STATUS, NRO_CAIXA)
VALUES (2, 1, 'Comum', 'Ativo', 2);

INSERT INTO Caixa_Registradora (NRO_INT_CAI_REG, NRO_INT_SUP, TIPO, STATUS, NRO_CAIXA)
VALUES (3, 1, 'Preferencial', 'Ativo', 3);

INSERT INTO Caixa_Registradora (NRO_INT_CAI_REG, NRO_INT_SUP, TIPO, STATUS, NRO_CAIXA)
VALUES (4, 1, 'Caixa rapido', 'Ativo', 4);

-- -----------------------------------------------------
-- Inserindo dados na tabela Funcionario
-- -----------------------------------------------------

INSERT INTO Funcionario (NRO_INT_FUN, NRO_INT_SUP, NOME_FUN, CPF_FUN)
VALUES (1, 1, 'João Silva', '123.456.789-01');

INSERT INTO Funcionario (NRO_INT_FUN, NRO_INT_SUP, NOME_FUN, CPF_FUN)
VALUES (2, 1, 'Maria Santos', '987.654.321-09');

INSERT INTO Funcionario (NRO_INT_FUN, NRO_INT_SUP, NOME_FUN, CPF_FUN)
VALUES (3, 1, 'Pedro Almeida', '456.789.123-45');

INSERT INTO Funcionario (NRO_INT_FUN, NRO_INT_SUP, NOME_FUN, CPF_FUN)
VALUES (4, 1, 'Ana Pereira', '789.123.456-78');

INSERT INTO Funcionario (NRO_INT_FUN, NRO_INT_SUP, NOME_FUN, CPF_FUN)
VALUES (5, 1, 'Carlos Fernandes', '321.654.987-09');

INSERT INTO Funcionario (NRO_INT_FUN, NRO_INT_SUP, NOME_FUN, CPF_FUN)
VALUES (6, 1, 'Lúcia Oliveira', '654.321.789-06');

INSERT INTO Funcionario (NRO_INT_FUN, NRO_INT_SUP, NOME_FUN, CPF_FUN)
VALUES (7, 1, 'Mariana Costa', '987.654.123-09');

INSERT INTO Funcionario (NRO_INT_FUN, NRO_INT_SUP, NOME_FUN, CPF_FUN)
VALUES (8, 1, 'Paulo Santos', '789.456.321-01');

-- -----------------------------------------------------
-- Inserindo dados na Jornada_Caixa
-- -----------------------------------------------------

-- Funcionário 1
INSERT INTO Jornada_Caixa (NRO_INT_JOR_CAI, NRO_INT_CAI_REG, NRO_INT_FUN, DTH_ABERTURA, DTH_FECHAMENTO, VLR_CAIXA_INICIAL, VLR_CAIXA_FINAL)
VALUES (1, 1, 1, '2023-06-01 08:00:00', '2023-06-01 17:00:00', 500.00, 700.00);

INSERT INTO Jornada_Caixa (NRO_INT_JOR_CAI, NRO_INT_CAI_REG, NRO_INT_FUN, DTH_ABERTURA, DTH_FECHAMENTO, VLR_CAIXA_INICIAL, VLR_CAIXA_FINAL)
VALUES (2, 2, 1, '2023-06-02 08:30:00', '2023-06-02 17:30:00', 600.00, 800.00);

-- Funcionário 2
INSERT INTO Jornada_Caixa (NRO_INT_JOR_CAI, NRO_INT_CAI_REG, NRO_INT_FUN, DTH_ABERTURA, DTH_FECHAMENTO, VLR_CAIXA_INICIAL, VLR_CAIXA_FINAL)
VALUES (3, 3, 2, '2023-06-01 08:00:00', '2023-06-01 17:00:00', 550.00, 750.00);

INSERT INTO Jornada_Caixa (NRO_INT_JOR_CAI, NRO_INT_CAI_REG, NRO_INT_FUN, DTH_ABERTURA, DTH_FECHAMENTO, VLR_CAIXA_INICIAL, VLR_CAIXA_FINAL)
VALUES (4, 4, 2, '2023-06-02 08:30:00', '2023-06-02 17:30:00', 650.00, 850.00);

-- Funcionário 3
INSERT INTO Jornada_Caixa (NRO_INT_JOR_CAI, NRO_INT_CAI_REG, NRO_INT_FUN, DTH_ABERTURA, DTH_FECHAMENTO, VLR_CAIXA_INICIAL, VLR_CAIXA_FINAL)
VALUES (5, 1, 3, '2023-06-03 08:00:00', '2023-06-03 17:00:00', 700.00, 900.00);

INSERT INTO Jornada_Caixa (NRO_INT_JOR_CAI, NRO_INT_CAI_REG, NRO_INT_FUN, DTH_ABERTURA, DTH_FECHAMENTO, VLR_CAIXA_INICIAL, VLR_CAIXA_FINAL)
VALUES (6, 2, 3, '2023-06-04 08:30:00', '2023-06-04 17:30:00', 800.00, 1000.00);

-- Funcionário 4
INSERT INTO Jornada_Caixa (NRO_INT_JOR_CAI, NRO_INT_CAI_REG, NRO_INT_FUN, DTH_ABERTURA, DTH_FECHAMENTO, VLR_CAIXA_INICIAL, VLR_CAIXA_FINAL)
VALUES (7, 3, 4, '2023-06-03 08:00:00', '2023-06-03 17:00:00', 750.00, 950.00);

INSERT INTO Jornada_Caixa (NRO_INT_JOR_CAI, NRO_INT_CAI_REG, NRO_INT_FUN, DTH_ABERTURA, DTH_FECHAMENTO, VLR_CAIXA_INICIAL, VLR_CAIXA_FINAL)
VALUES (8, 4, 4, '2023-06-04 08:30:00', '2023-06-04 17:30:00', 850.00, 1050.00);

-- Funcionário 5
INSERT INTO Jornada_Caixa (NRO_INT_JOR_CAI, NRO_INT_CAI_REG, NRO_INT_FUN, DTH_ABERTURA, DTH_FECHAMENTO, VLR_CAIXA_INICIAL, VLR_CAIXA_FINAL)
VALUES (9, 1, 5, '2023-06-05 08:00:00', '2023-06-05 17:00:00', 900.00, 1100.00);

INSERT INTO Jornada_Caixa (NRO_INT_JOR_CAI, NRO_INT_CAI_REG, NRO_INT_FUN, DTH_ABERTURA, DTH_FECHAMENTO, VLR_CAIXA_INICIAL, VLR_CAIXA_FINAL)
VALUES (10, 2, 5, '2023-06-06 08:30:00', '2023-06-06 17:30:00', 1000.00, 1200.00);

-- Funcionário 6
INSERT INTO Jornada_Caixa (NRO_INT_JOR_CAI, NRO_INT_CAI_REG, NRO_INT_FUN, DTH_ABERTURA, DTH_FECHAMENTO, VLR_CAIXA_INICIAL, VLR_CAIXA_FINAL)
VALUES (11, 3, 6, '2023-06-05 08:00:00', '2023-06-05 17:00:00', 950.00, 1150.00);

INSERT INTO Jornada_Caixa (NRO_INT_JOR_CAI, NRO_INT_CAI_REG, NRO_INT_FUN, DTH_ABERTURA, DTH_FECHAMENTO, VLR_CAIXA_INICIAL, VLR_CAIXA_FINAL)
VALUES (12, 4, 6, '2023-06-06 08:30:00', '2023-06-06 17:30:00', 1050.00, 1250.00);

-- Funcionário 7
INSERT INTO Jornada_Caixa (NRO_INT_JOR_CAI, NRO_INT_CAI_REG, NRO_INT_FUN, DTH_ABERTURA, DTH_FECHAMENTO, VLR_CAIXA_INICIAL, VLR_CAIXA_FINAL)
VALUES (13, 1, 7, '2023-06-07 08:00:00', '2023-06-07 17:00:00', 1000.00, 1200.00);

INSERT INTO Jornada_Caixa (NRO_INT_JOR_CAI, NRO_INT_CAI_REG, NRO_INT_FUN, DTH_ABERTURA, DTH_FECHAMENTO, VLR_CAIXA_INICIAL, VLR_CAIXA_FINAL)
VALUES (14, 2, 7, '2023-06-08 08:30:00', '2023-06-08 17:30:00', 1100.00, 1300.00);

-- Funcionário 8
INSERT INTO Jornada_Caixa (NRO_INT_JOR_CAI, NRO_INT_CAI_REG, NRO_INT_FUN, DTH_ABERTURA, DTH_FECHAMENTO, VLR_CAIXA_INICIAL, VLR_CAIXA_FINAL)
VALUES (15, 3, 8, '2023-06-07 08:00:00', '2023-06-07 17:00:00', 1050.00, 1250.00);

INSERT INTO Jornada_Caixa (NRO_INT_JOR_CAI, NRO_INT_CAI_REG, NRO_INT_FUN, DTH_ABERTURA, DTH_FECHAMENTO, VLR_CAIXA_INICIAL, VLR_CAIXA_FINAL)
VALUES (16, 4, 8, '2023-06-08 08:30:00', '2023-06-08 17:30:00', 1150.00, 1350.00);

-- -----------------------------------------------------
-- Inserindo dados na item_venda
-- -----------------------------------------------------

INSERT INTO Item_Venda ( NRO_INT_VEN, NRO_INT_CON_PRO, NRO_QUANTIDADE, VLR_DESCONTO)
VALUES ( 1, 1, 2, 0),
       ( 2, 2, 1, 0),
       ( 3, 2, 3, 0),
       ( 3, 3, 2, 0),
       ( 4, 4, 4, 0);

-- -----------------------------------------------------
-- Inserindo dados na venda
-- -----------------------------------------------------

INSERT INTO Venda ( NRO_INT_JOR_CAI, DTH_VENDA, VLR_TOTAL)
VALUES ( 1, '2023-01-02', 21.00),
       ( 2, '2023-01-05', 8.99),
       ( 3, '2023-02-10', 53.25),
       ( 4, '2023-01-20', 63.00);