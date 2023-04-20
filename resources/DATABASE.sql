/******************************************************************************/
/****        Generated by IBExpert 2015.12.21.1 30/03/2023 12:04:10        ****/
/******************************************************************************/

SET SQL DIALECT 3;

SET NAMES WIN1252;

CREATE DATABASE 'C:\AABSoft\ERP\Database\DATABASE.FDB'
USER 'SYSDBA' PASSWORD 'masterkey'
PAGE_SIZE 16384
DEFAULT CHARACTER SET WIN1252 COLLATION WIN_PTBR;



/******************************************************************************/
/****                              Generators                              ****/
/******************************************************************************/

CREATE GENERATOR GEN_AGENDA_ID START WITH 0 INCREMENT BY 1;
SET GENERATOR GEN_AGENDA_ID TO 0;

CREATE GENERATOR GEN_CAIXA_ID START WITH 0 INCREMENT BY 1;
SET GENERATOR GEN_CAIXA_ID TO 0;

CREATE GENERATOR GEN_CIDADES_ID START WITH 0 INCREMENT BY 1;
SET GENERATOR GEN_CIDADES_ID TO 0;

CREATE GENERATOR GEN_CLIENTES_ID START WITH 0 INCREMENT BY 1;
SET GENERATOR GEN_CLIENTES_ID TO 0;

CREATE GENERATOR GEN_CONFIGURACOES_GRID_ID START WITH 0 INCREMENT BY 1;
SET GENERATOR GEN_CONFIGURACOES_GRID_ID TO 0;

CREATE GENERATOR GEN_EMPRESAS_ID START WITH 0 INCREMENT BY 1;
SET GENERATOR GEN_EMPRESAS_ID TO 0;

CREATE GENERATOR GEN_FORMA_PAGAMENTO_ID START WITH 0 INCREMENT BY 1;
SET GENERATOR GEN_FORMA_PAGAMENTO_ID TO 0;

CREATE GENERATOR GEN_FORNECEDORES_ID START WITH 0 INCREMENT BY 1;
SET GENERATOR GEN_FORNECEDORES_ID TO 0;

CREATE GENERATOR GEN_FUNCIONARIOS_FUNCOES_ID START WITH 0 INCREMENT BY 1;
SET GENERATOR GEN_FUNCIONARIOS_FUNCOES_ID TO 0;

CREATE GENERATOR GEN_FUNCIONARIOS_ID START WITH 0 INCREMENT BY 1;
SET GENERATOR GEN_FUNCIONARIOS_ID TO 0;

CREATE GENERATOR GEN_LOGS_ID START WITH 0 INCREMENT BY 1;
SET GENERATOR GEN_LOGS_ID TO 0;

CREATE GENERATOR GEN_PERMISSOES_GRUPO_ID START WITH 0 INCREMENT BY 1;
SET GENERATOR GEN_PERMISSOES_GRUPO_ID TO 0;

CREATE GENERATOR GEN_PRODUTOS_GRUPOS_ID START WITH 0 INCREMENT BY 1;
SET GENERATOR GEN_PRODUTOS_GRUPOS_ID TO 0;

CREATE GENERATOR GEN_PRODUTOS_ID START WITH 0 INCREMENT BY 1;
SET GENERATOR GEN_PRODUTOS_ID TO 0;

CREATE GENERATOR GEN_PRODUTOS_SUBGRUPOS_ID START WITH 0 INCREMENT BY 1;
SET GENERATOR GEN_PRODUTOS_SUBGRUPOS_ID TO 0;

CREATE GENERATOR GEN_PRODUTOS_UNIDADES_ID START WITH 0 INCREMENT BY 1;
SET GENERATOR GEN_PRODUTOS_UNIDADES_ID TO 0;



/******************************************************************************/
/****                                Tables                                ****/
/******************************************************************************/



CREATE TABLE AGENDA (
    ID                     INTEGER NOT NULL,
    CLIENTE                INTEGER,
    FUNCIONARIO            INTEGER,
    DATA                   DATE,
    HORA                   TIME,
    TITULO                 VARCHAR(50),
    OBSERVACAO             VARCHAR(1000),
    STATUS                 VARCHAR(20),
    DATA_CADASTRO          TIMESTAMP,
    DATA_ULTIMA_ALTERACAO  TIMESTAMP
);

CREATE TABLE CAIXA (
    ID                  INTEGER NOT NULL,
    DATA                DATE,
    HORA                TIME,
    HISTORICO           VARCHAR(300),
    CLIENTE             INTEGER,
    FORNECEDOR          INTEGER,
    VALOR_ENTRADA       DOUBLE PRECISION,
    VALOR_SAIDA         DOUBLE PRECISION,
    OBSERVACAO          BLOB SUB_TYPE 1 SEGMENT SIZE 80,
    OBSERVACAO_SISTEMA  VARCHAR(100),
    FORMA_PAGAMENTO     INTEGER,
    DATA_LANCAMENTO     TIMESTAMP
);

CREATE TABLE CIDADES (
    ID    INTEGER NOT NULL,
    NOME  VARCHAR(60),
    UF    VARCHAR(2),
    IBGE  INTEGER
);

CREATE TABLE CLIENTES (
    ID                  INTEGER NOT NULL,
    RAZAO_SOCIAL        VARCHAR(100),
    NOME_FANTASIA       VARCHAR(100),
    ENDERECO            VARCHAR(100),
    NUMERO              VARCHAR(10),
    BAIRRO              VARCHAR(80),
    CEP                 VARCHAR(10),
    CIDADE              INTEGER,
    DATA_NASCIMENTO     DATE,
    TELEFONE            VARCHAR(14),
    TELEFONE2           VARCHAR(14),
    CELULAR             VARCHAR(14),
    FAX                 VARCHAR(14),
    EMAIL               VARCHAR(50),
    TIPO_JURIDICO       CHAR(1),
    CNPJ                VARCHAR(14),
    INSCRICAO_ESTADUAL  VARCHAR(20),
    CPF                 VARCHAR(11),
    RG                  VARCHAR(20),
    RG_ORGAO_EXPEDIDOR  VARCHAR(5),
    DATA_CADASTRO       DATE,
    STATUS              CHAR(1)
);

CREATE TABLE CONFIGURACOES (
    EMPRESA       INTEGER,
    NOME          VARCHAR(100),
    VALOR         CHAR(1),
    VALOR_STRING  VARCHAR(200),
    VALOR_DOUBLE  DOUBLE PRECISION
);

CREATE TABLE CONFIGURACOES_GRID (
    ID         INTEGER NOT NULL,
    NOME       VARCHAR(100),
    FONT_SIZE  INTEGER,
    FONT_BOLD  CHAR(1)
);

CREATE TABLE CONFIGURACOES_GRID_COLUNAS (
    GRID            INTEGER,
    FIELD_NAME      VARCHAR(50),
    TITLE           VARCHAR(50),
    TITLE_ALIGNMENT INTEGER,
    WIDTH           INTEGER,
    ORDEM           INTEGER
);

CREATE TABLE CONFIGURACOES_ICONES (
    FUNCIONARIO  INTEGER,
    ICONE        VARCHAR(50)
);

CREATE TABLE EMPRESAS (
    ID                  INTEGER NOT NULL,
    RAZAO_SOCIAL        VARCHAR(100),
    NOME_FANTASIA       VARCHAR(100),
    ENDERECO            VARCHAR(100),
    NUMERO              VARCHAR(10),
    BAIRRO              VARCHAR(80),
    CEP                 VARCHAR(10),
    CIDADE              INTEGER,
    DATA_NASCIMENTO     DATE,
    TELEFONE            VARCHAR(14),
    TELEFONE2           VARCHAR(14),
    CELULAR             VARCHAR(14),
    FAX                 VARCHAR(14),
    EMAIL               VARCHAR(50),
    TIPO_JURIDICO       CHAR(1),
    CNPJ                VARCHAR(14),
    INSCRICAO_ESTADUAL  VARCHAR(20),
    CPF                 VARCHAR(11),
    RG                  VARCHAR(20),
    RG_ORGAO_EXPEDIDOR  VARCHAR(5),
    DATA_CADASTRO       DATE,
    SERVIDOR_HASH       VARCHAR(50)
);

CREATE TABLE FORMA_PAGAMENTO (
    ID               INTEGER NOT NULL,
    NOME             VARCHAR(30),
    STATUS           CHAR(1),
    TIPO_LANCAMENTO  CHAR(1)
);

CREATE TABLE FORNECEDORES (
    ID                  INTEGER NOT NULL,
    RAZAO_SOCIAL        VARCHAR(100),
    NOME_FANTASIA       VARCHAR(100),
    ENDERECO            VARCHAR(100),
    NUMERO              VARCHAR(10),
    BAIRRO              VARCHAR(80),
    CEP                 VARCHAR(10),
    CIDADE              INTEGER,
    DATA_NASCIMENTO     DATE,
    TELEFONE            VARCHAR(14),
    TELEFONE2           VARCHAR(14),
    CELULAR             VARCHAR(14),
    FAX                 VARCHAR(14),
    EMAIL               VARCHAR(50),
    TIPO_JURIDICO       CHAR(1),
    CNPJ                VARCHAR(14),
    INSCRICAO_ESTADUAL  VARCHAR(20),
    CPF                 VARCHAR(11),
    RG                  VARCHAR(20),
    RG_ORGAO_EXPEDIDOR  VARCHAR(5),
    DATA_CADASTRO       DATE,
    STATUS              CHAR(1)
);

CREATE TABLE FUNCIONARIOS (
    ID                  INTEGER NOT NULL,
    RAZAO_SOCIAL        VARCHAR(100),
    NOME_FANTASIA       VARCHAR(100),
    ENDERECO            VARCHAR(100),
    NUMERO              VARCHAR(10),
    BAIRRO              VARCHAR(80),
    CEP                 VARCHAR(10),
    CIDADE              INTEGER,
    DATA_NASCIMENTO     DATE,
    TELEFONE            VARCHAR(14),
    TELEFONE2           VARCHAR(14),
    CELULAR             VARCHAR(14),
    FAX                 VARCHAR(14),
    EMAIL               VARCHAR(50),
    TIPO_JURIDICO       CHAR(1),
    CNPJ                VARCHAR(14),
    INSCRICAO_ESTADUAL  VARCHAR(20),
    CPF                 VARCHAR(11),
    RG                  VARCHAR(20),
    RG_ORGAO_EXPEDIDOR  VARCHAR(5),
    DATA_CADASTRO       DATE,
    FUNCAO              INTEGER,
    SALARIO             DOUBLE PRECISION,
    LOGIN               VARCHAR(20),
    SENHA               VARCHAR(20),
    STATUS              CHAR(1),
    GRUPO_PERMISSOES    INTEGER
);

CREATE TABLE FUNCIONARIOS_FUNCOES (
    ID    INTEGER NOT NULL,
    NOME  VARCHAR(50)
);

CREATE TABLE LOGS (
    ID             INTEGER NOT NULL,
    DATA_HORA      TIMESTAMP,
    ID_FUNCIONARIO INTEGER,
    MODULO         VARCHAR(50),
    ACAO           VARCHAR(50),
    DESCRICAO      VARCHAR(500),
    REFERENCIA     INTEGER    
);

CREATE TABLE PERMISSOES (
    GRUPO  INTEGER,
    NOME   VARCHAR(100),
    VALOR  CHAR(1)
);

CREATE TABLE PERMISSOES_GRUPO (
    ID         INTEGER NOT NULL,
    NOME       VARCHAR(50),
    DESCRICAO  VARCHAR(200)
);

CREATE TABLE PRODUTOS (
    ID                          INTEGER NOT NULL,
    NOME                        VARCHAR(80),
    DESCRICAO                   VARCHAR(80),
    CODIGO_BARRAS               VARCHAR(30),
    CUSTO                       DOUBLE PRECISION,
    PRECO_VENDA_VISTA           DOUBLE PRECISION,
    PORCENTO_LUCRO_VENDA_VISTA  DOUBLE PRECISION,
    PRECO_VENDA_PRAZO           DOUBLE PRECISION,
    PORCENTO_LUCRO_VENDA_PRAZO  DOUBLE PRECISION,
    SUBGRUPO                    INTEGER,
    UNIDADE                     INTEGER,
    ESTOQUE                     DOUBLE PRECISION,
    ESTOQUE_MINIMO              DOUBLE PRECISION,
    ESTOQUE_MAXIMO              DOUBLE PRECISION,
    DATA_CADASTRO               DATE,
    STATUS                      CHAR(1)
);

CREATE TABLE PRODUTOS_GRUPOS (
    ID    INTEGER NOT NULL,
    NOME  VARCHAR(50)
);

CREATE TABLE PRODUTOS_SUBGRUPOS (
    ID     INTEGER NOT NULL,
    NOME   VARCHAR(50),
    GRUPO  INTEGER NOT NULL
);

CREATE TABLE PRODUTOS_UNIDADES (
    ID     INTEGER NOT NULL,
    NOME   VARCHAR(30),
    SIGLA  VARCHAR(3)
);



/******************************************************************************/
/****                             Primary keys                             ****/
/******************************************************************************/

ALTER TABLE AGENDA ADD CONSTRAINT PK_AGENDA PRIMARY KEY (ID);
ALTER TABLE CAIXA ADD CONSTRAINT PK_CAIXA PRIMARY KEY (ID);
ALTER TABLE CIDADES ADD CONSTRAINT PK_CIDADES PRIMARY KEY (ID);
ALTER TABLE CLIENTES ADD CONSTRAINT PK_CLIENTES PRIMARY KEY (ID);
ALTER TABLE CONFIGURACOES_GRID ADD CONSTRAINT PK_CONFIGURACOES_GRID PRIMARY KEY (ID);
ALTER TABLE EMPRESAS ADD CONSTRAINT PK_EMPRESAS PRIMARY KEY (ID);
ALTER TABLE FORMA_PAGAMENTO ADD CONSTRAINT PK_FORMA_PAGAMENTO PRIMARY KEY (ID);
ALTER TABLE FORNECEDORES ADD CONSTRAINT PK_FORNECEDORES PRIMARY KEY (ID);
ALTER TABLE FUNCIONARIOS ADD CONSTRAINT PK_FUNCIONARIOS PRIMARY KEY (ID);
ALTER TABLE FUNCIONARIOS_FUNCOES ADD CONSTRAINT PK_FUNCIONARIOS_FUNCOES PRIMARY KEY (ID);
ALTER TABLE LOGS ADD CONSTRAINT PK_LOGS PRIMARY KEY (ID);
ALTER TABLE PERMISSOES_GRUPO ADD CONSTRAINT PK_PERMISSOES_GRUPO PRIMARY KEY (ID);
ALTER TABLE PRODUTOS ADD CONSTRAINT PK_PRODUTOS PRIMARY KEY (ID);
ALTER TABLE PRODUTOS_GRUPOS ADD CONSTRAINT PK_PRODUTOS_GRUPOS PRIMARY KEY (ID);
ALTER TABLE PRODUTOS_SUBGRUPOS ADD CONSTRAINT PK_PRODUTOS_SUBGRUPOS PRIMARY KEY (ID);
ALTER TABLE PRODUTOS_UNIDADES ADD CONSTRAINT PK_PRODUTOS_UNIDADES PRIMARY KEY (ID);


/******************************************************************************/
/****                             Foreign keys                             ****/
/******************************************************************************/

ALTER TABLE AGENDA ADD CONSTRAINT FK_AGENDA_CLIENTE FOREIGN KEY (CLIENTE) REFERENCES CLIENTES (ID);
ALTER TABLE AGENDA ADD CONSTRAINT FK_AGENDA_FUNCIONARIO FOREIGN KEY (FUNCIONARIO) REFERENCES FUNCIONARIOS (ID);
ALTER TABLE CAIXA ADD CONSTRAINT FK_CAIXA_CLIENTE FOREIGN KEY (CLIENTE) REFERENCES CLIENTES (ID);
ALTER TABLE CAIXA ADD CONSTRAINT FK_CAIXA_FORMAPAGAMENTO FOREIGN KEY (FORMA_PAGAMENTO) REFERENCES FORMA_PAGAMENTO (ID);
ALTER TABLE CAIXA ADD CONSTRAINT FK_CAIXA_FORNECEDOR FOREIGN KEY (FORNECEDOR) REFERENCES FORNECEDORES (ID);
ALTER TABLE CLIENTES ADD CONSTRAINT FK_CLIENTES_CIDADE FOREIGN KEY (CIDADE) REFERENCES CIDADES (ID);
ALTER TABLE CONFIGURACOES ADD CONSTRAINT FK_CONFIGURACOES_EMPRESA FOREIGN KEY (EMPRESA) REFERENCES EMPRESAS (ID);
ALTER TABLE CONFIGURACOES_GRID_COLUNAS ADD CONSTRAINT FK_CONFGRIDCOLUNAS_GRID FOREIGN KEY (GRID) REFERENCES CONFIGURACOES_GRID (ID);
ALTER TABLE EMPRESAS ADD CONSTRAINT FK_EMPRESAS_CIDADES FOREIGN KEY (CIDADE) REFERENCES CIDADES (ID);
ALTER TABLE FORNECEDORES ADD CONSTRAINT FK_FORNECEDORES_CIDADE FOREIGN KEY (CIDADE) REFERENCES CIDADES (ID);
ALTER TABLE FUNCIONARIOS ADD CONSTRAINT FK_FUNCIONARIOS_CIDADE FOREIGN KEY (CIDADE) REFERENCES CIDADES (ID);
ALTER TABLE FUNCIONARIOS ADD CONSTRAINT FK_FUNCIONARIOS_FUNCOES FOREIGN KEY (FUNCAO) REFERENCES FUNCIONARIOS_FUNCOES (ID);
ALTER TABLE FUNCIONARIOS ADD CONSTRAINT FK_FUNCIONARIOS_GRUPOPERMISSOES FOREIGN KEY (GRUPO_PERMISSOES) REFERENCES PERMISSOES_GRUPO (ID);
ALTER TABLE LOGS ADD CONSTRAINT FK_LOGS_FUNCIONARIOS FOREIGN KEY (ID_FUNCIONARIO) REFERENCES FUNCIONARIOS (ID);
ALTER TABLE PERMISSOES ADD CONSTRAINT FK_PERMISSOES_GRUPO FOREIGN KEY (GRUPO) REFERENCES PERMISSOES_GRUPO (ID);
ALTER TABLE PRODUTOS ADD CONSTRAINT FK_PRODUTOS_SUBGRUPOS FOREIGN KEY (SUBGRUPO) REFERENCES PRODUTOS_SUBGRUPOS (ID);
ALTER TABLE PRODUTOS ADD CONSTRAINT FK_PRODUTOS_UNIDADES FOREIGN KEY (UNIDADE) REFERENCES PRODUTOS_UNIDADES (ID);
ALTER TABLE PRODUTOS_SUBGRUPOS ADD CONSTRAINT FK_PRODUTOS_SUBGRUPOS_GRUPO FOREIGN KEY (GRUPO) REFERENCES PRODUTOS_GRUPOS (ID);


/******************************************************************************/
/****                               Indices                                ****/
/******************************************************************************/

CREATE INDEX IDX_CAIXA_DATA ON CAIXA (DATA);
CREATE INDEX IDX_CAIXA_DATALANCA ON CAIXA (DATA_LANCAMENTO);
CREATE INDEX IDX_CAIXA_HORA ON CAIXA (HORA);
CREATE INDEX IDX_CIDADES_NOME ON CIDADES (NOME);
CREATE INDEX IDX_CLIENTES_CNPJ ON CLIENTES (CNPJ);
CREATE INDEX IDX_CLIENTES_CPF ON CLIENTES (CPF);
CREATE INDEX IDX_CLIENTES_NOMEFANTASIA ON CLIENTES (NOME_FANTASIA);
CREATE INDEX IDX_CLIENTES_RAZAOSOCIAL ON CLIENTES (RAZAO_SOCIAL);
CREATE INDEX IDX_CLIENTES_STATUS ON CLIENTES (STATUS);
CREATE INDEX IDX_CONFIGURACOES_NOME ON CONFIGURACOES (NOME);
CREATE INDEX IDX_CONFIGURACOESGRID_NOME ON CONFIGURACOES_GRID (NOME);
CREATE INDEX IDX_EMPRESAS_CNPJ ON EMPRESAS (CNPJ);
CREATE INDEX IDX_EMPRESAS_CPF ON EMPRESAS (CPF);
CREATE INDEX IDX_EMPRESAS_NOMEFANTASIA ON EMPRESAS (NOME_FANTASIA);
CREATE INDEX IDX_EMPRESAS_RAZAOSOCIAL ON EMPRESAS (RAZAO_SOCIAL);
CREATE INDEX IDX_FORMAPAG_STATUS ON FORMA_PAGAMENTO (STATUS);
CREATE INDEX IDX_FORMAPAG_TIPOLANCAMENTO ON FORMA_PAGAMENTO (TIPO_LANCAMENTO);
CREATE INDEX IDX_FORNECEDORES_CNPJ ON FORNECEDORES (CNPJ);
CREATE INDEX IDX_FORNECEDORES_CPF ON FORNECEDORES (CPF);
CREATE INDEX IDX_FORNECEDORES_NOMEFANTASIA ON FORNECEDORES (NOME_FANTASIA);
CREATE INDEX IDX_FORNECEDORES_RAZAOSOCIAL ON FORNECEDORES (RAZAO_SOCIAL);
CREATE INDEX IDX_FORNECEDORES_STATUS ON FORNECEDORES (STATUS);
CREATE INDEX IDX_FUNCIONARIOS_CNPJ ON FUNCIONARIOS (CNPJ);
CREATE INDEX IDX_FUNCIONARIOS_CPF ON FUNCIONARIOS (CPF);
CREATE INDEX IDX_FUNCIONARIOS_NOMEFANTASIA ON FUNCIONARIOS (NOME_FANTASIA);
CREATE INDEX IDX_FUNCIONARIOS_RAZAOSOCIAL ON FUNCIONARIOS (RAZAO_SOCIAL);
CREATE INDEX IDX_FUNCIONARIOS_STATUS ON FUNCIONARIOS (STATUS);
CREATE INDEX IDX_LOGS_DATAHORA ON LOGS (DATA_HORA);
CREATE INDEX IDX_LOGS_MODULO ON LOGS (MODULO);
CREATE INDEX IDX_LOGS_ACAO ON LOGS (ACAO);
CREATE INDEX IDX_LOGS_REFERENCIA ON LOGS (REFERENCIA);
CREATE INDEX IDX_PERMISSOES_NOME ON PERMISSOES (NOME);
CREATE INDEX IDX_PRODUTOS_ESTOQUE ON PRODUTOS (ESTOQUE);
CREATE INDEX IDX_PRODUTOS_NOME ON PRODUTOS (NOME);
CREATE INDEX IDX_PRODUTOS_STATUS ON PRODUTOS (STATUS);


/******************************************************************************/
/****                               Triggers                               ****/
/******************************************************************************/



SET TERM ^ ;



/******************************************************************************/
/****                         Triggers for tables                          ****/
/******************************************************************************/



/* Trigger: AGENDA_BI */
CREATE TRIGGER AGENDA_BI FOR AGENDA
ACTIVE BEFORE INSERT POSITION 0
as
begin
  if (new.id is null) then
    new.id = gen_id(gen_agenda_id,1);
end
^

/* Trigger: CAIXA_BI */
CREATE TRIGGER CAIXA_BI FOR CAIXA
ACTIVE BEFORE INSERT POSITION 0
as
begin
  if (new.id is null) then
    new.id = gen_id(gen_caixa_id,1);
end
^

/* Trigger: CIDADES_BI */
CREATE TRIGGER CIDADES_BI FOR CIDADES
ACTIVE BEFORE INSERT POSITION 0
as
begin
  if (new.id is null) then
    new.id = gen_id(gen_cidades_id,1);
end
^

/* Trigger: CLIENTES_BI */
CREATE TRIGGER CLIENTES_BI FOR CLIENTES
ACTIVE BEFORE INSERT POSITION 0
as
begin
  if (new.id is null) then
    new.id = gen_id(gen_clientes_id,1);
end
^

/* Trigger: CONFIGURACOES_GRID_BI */
CREATE TRIGGER CONFIGURACOES_GRID_BI FOR CONFIGURACOES_GRID
ACTIVE BEFORE INSERT POSITION 0
as
begin
  if (new.id is null) then
    new.id = gen_id(gen_configuracoes_grid_id,1);
end
^

/* Trigger: EMPRESAS_BI */
CREATE TRIGGER EMPRESAS_BI FOR EMPRESAS
ACTIVE BEFORE INSERT POSITION 0
as
begin
  if (new.id is null) then
    new.id = gen_id(gen_empresas_id,1);
end
^

/* Trigger: FORMA_PAGAMENTO_BI */
CREATE TRIGGER FORMA_PAGAMENTO_BI FOR FORMA_PAGAMENTO
ACTIVE BEFORE INSERT POSITION 0
as
begin
  if (new.id is null) then
    new.id = gen_id(gen_forma_pagamento_id,1);
end
^

/* Trigger: FORNECEDORES_BI */
CREATE TRIGGER FORNECEDORES_BI FOR FORNECEDORES
ACTIVE BEFORE INSERT POSITION 0
as
begin
  if (new.id is null) then
    new.id = gen_id(gen_fornecedores_id,1);
end
^

/* Trigger: FUNCIONARIOS_BI */
CREATE TRIGGER FUNCIONARIOS_BI FOR FUNCIONARIOS
ACTIVE BEFORE INSERT POSITION 0
as
begin
  if (new.id is null) then
    new.id = gen_id(gen_funcionarios_id,1);
end
^

/* Trigger: FUNCIONARIOS_FUNCOES_BI */
CREATE TRIGGER FUNCIONARIOS_FUNCOES_BI FOR FUNCIONARIOS_FUNCOES
ACTIVE BEFORE INSERT POSITION 0
as
begin
  if (new.id is null) then
    new.id = gen_id(gen_funcionarios_funcoes_id,1);
end
^

/* Trigger: LOGS_BI */
CREATE TRIGGER LOGS_BI FOR LOGS
ACTIVE BEFORE INSERT POSITION 0
as
begin
  if (new.id is null) then
    new.id = gen_id(gen_logs_id,1);
end
^

/* Trigger: PERMISSOES_GRUPO_BI */
CREATE TRIGGER PERMISSOES_GRUPO_BI FOR PERMISSOES_GRUPO
ACTIVE BEFORE INSERT POSITION 0
as
begin
  if (new.id is null) then
    new.id = gen_id(gen_permissoes_grupo_id,1);
end
^

/* Trigger: PRODUTOS_BI */
CREATE TRIGGER PRODUTOS_BI FOR PRODUTOS
ACTIVE BEFORE INSERT POSITION 0
as
begin
  if (new.id is null) then
    new.id = gen_id(gen_produtos_id,1);
end
^

/* Trigger: PRODUTOS_GRUPOS_BI */
CREATE TRIGGER PRODUTOS_GRUPOS_BI FOR PRODUTOS_GRUPOS
ACTIVE BEFORE INSERT POSITION 0
as
begin
  if (new.id is null) then
    new.id = gen_id(gen_produtos_grupos_id,1);
end
^

/* Trigger: PRODUTOS_SUBGRUPOS_BI */
CREATE TRIGGER PRODUTOS_SUBGRUPOS_BI FOR PRODUTOS_SUBGRUPOS
ACTIVE BEFORE INSERT POSITION 0
as
begin
  if (new.id is null) then
    new.id = gen_id(gen_produtos_subgrupos_id,1);
end
^

/* Trigger: PRODUTOS_UNIDADES_BI */
CREATE TRIGGER PRODUTOS_UNIDADES_BI FOR PRODUTOS_UNIDADES
ACTIVE BEFORE INSERT POSITION 0
as
begin
  if (new.id is null) then
    new.id = gen_id(gen_produtos_unidades_id,1);
end
^
SET TERM ; ^

