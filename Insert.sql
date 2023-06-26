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