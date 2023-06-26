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