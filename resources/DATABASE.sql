/******************************************************************************/
/****        Generated by IBExpert 2015.12.21.1 16/03/2023 10:34:53        ****/
/******************************************************************************/

SET SQL DIALECT 3;

SET NAMES NONE;

CREATE DATABASE 'C:\AABSoft\ERP\DATABASE.fdb'
USER 'SYSDBA' PASSWORD 'masterkey'
PAGE_SIZE 16384
DEFAULT CHARACTER SET NONE COLLATION NONE;



/******************************************************************************/
/****                              Generators                              ****/
/******************************************************************************/

CREATE GENERATOR GEN_CIDADES_ID START WITH 0 INCREMENT BY 1;
SET GENERATOR GEN_CIDADES_ID TO 0;

CREATE GENERATOR GEN_CLIENTES_ID START WITH 0 INCREMENT BY 1;
SET GENERATOR GEN_CLIENTES_ID TO 0;

CREATE GENERATOR GEN_EMPRESAS_ID START WITH 0 INCREMENT BY 1;
SET GENERATOR GEN_EMPRESAS_ID TO 0;

CREATE GENERATOR GEN_FORNECEDORES_ID START WITH 0 INCREMENT BY 1;
SET GENERATOR GEN_FORNECEDORES_ID TO 0;

CREATE GENERATOR GEN_FUNCIONARIOS_FUNCOES_ID START WITH 0 INCREMENT BY 1;
SET GENERATOR GEN_FUNCIONARIOS_FUNCOES_ID TO 0;

CREATE GENERATOR GEN_FUNCIONARIOS_ID START WITH 0 INCREMENT BY 1;
SET GENERATOR GEN_FUNCIONARIOS_ID TO 0;

CREATE GENERATOR GEN_PERMISSOES_GRUPO_ID START WITH 0 INCREMENT BY 1;
SET GENERATOR GEN_PERMISSOES_GRUPO_ID TO 0;

CREATE GENERATOR GEN_PRODUTOS_GRUPOS_ID START WITH 0 INCREMENT BY 1;
SET GENERATOR GEN_PRODUTOS_GRUPOS_ID TO 0;

CREATE GENERATOR GEN_PRODUTOS_SUBGRUPOS_ID START WITH 0 INCREMENT BY 1;
SET GENERATOR GEN_PRODUTOS_SUBGRUPOS_ID TO 0;



/******************************************************************************/
/****                                Tables                                ****/
/******************************************************************************/



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
    CEP                 INTEGER,
    CIDADE              INTEGER,
    DATA_NASCIMENTO     DATE,
    TELEFONE            VARCHAR(14),
    TELEFONE2           VARCHAR(14),
    CELULAR             VARCHAR(14),
    FAX                 VARCHAR(14),
    EMAIL               VARCHAR(50),
    TIPO_JURIDICO       CHAR(1),
    CNPJ                VARCHAR(14),
    INSCRICAO_ESTADUAL  VARCHAR(15),
    CPF                 VARCHAR(11),
    RG                  VARCHAR(15),
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

CREATE TABLE EMPRESAS (
    ID                  INTEGER NOT NULL,
    RAZAO_SOCIAL        VARCHAR(100),
    NOME_FANTASIA       VARCHAR(100),
    ENDERECO            VARCHAR(100),
    NUMERO              VARCHAR(10),
    BAIRRO              VARCHAR(80),
    CEP                 INTEGER,
    CIDADE              INTEGER,
    DATA_NASCIMENTO     DATE,
    TELEFONE            VARCHAR(14),
    TELEFONE2           VARCHAR(14),
    CELULAR             VARCHAR(14),
    FAX                 VARCHAR(14),
    EMAIL               VARCHAR(50),
    TIPO_JURIDICO       CHAR(1),
    CNPJ                VARCHAR(14),
    INSCRICAO_ESTADUAL  VARCHAR(15),
    CPF                 VARCHAR(11),
    RG                  VARCHAR(15),
    RG_ORGAO_EXPEDIDOR  VARCHAR(5),
    DATA_CADASTRO       DATE,
    STATUS              CHAR(1)
);

CREATE TABLE FORNECEDORES (
    ID                  INTEGER NOT NULL,
    RAZAO_SOCIAL        VARCHAR(100),
    NOME_FANTASIA       VARCHAR(100),
    ENDERECO            VARCHAR(100),
    NUMERO              VARCHAR(10),
    BAIRRO              VARCHAR(80),
    CEP                 INTEGER,
    CIDADE              INTEGER,
    DATA_NASCIMENTO     DATE,
    TELEFONE            VARCHAR(14),
    TELEFONE2           VARCHAR(14),
    CELULAR             VARCHAR(14),
    FAX                 VARCHAR(14),
    EMAIL               VARCHAR(50),
    TIPO_JURIDICO       CHAR(1),
    CNPJ                VARCHAR(14),
    INSCRICAO_ESTADUAL  VARCHAR(15),
    CPF                 VARCHAR(11),
    RG                  VARCHAR(15),
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
    CEP                 INTEGER,
    CIDADE              INTEGER,
    DATA_NASCIMENTO     DATE,
    TELEFONE            VARCHAR(14),
    TELEFONE2           VARCHAR(14),
    CELULAR             VARCHAR(14),
    FAX                 VARCHAR(14),
    EMAIL               VARCHAR(50),
    TIPO_JURIDICO       CHAR(1),
    CNPJ                VARCHAR(14),
    INSCRICAO_ESTADUAL  VARCHAR(15),
    CPF                 VARCHAR(11),
    RG                  VARCHAR(15),
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
    ID      INTEGER NOT NULL,
    FUNCAO  VARCHAR(50)
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

CREATE TABLE PRODUTOS_GRUPOS (
    ID      INTEGER NOT NULL,
    GRUPO   INTEGER,
    STATUS  CHAR(1)
);

CREATE TABLE PRODUTOS_SUBGRUPOS (
    ID        INTEGER NOT NULL,
    SUBGRUPO  VARCHAR(50),
    GRUPO     INTEGER NOT NULL,
    STATUS    CHAR(1)
);



/******************************************************************************/
/****                             Primary keys                             ****/
/******************************************************************************/

ALTER TABLE CIDADES ADD CONSTRAINT PK_CIDADES PRIMARY KEY (ID);
ALTER TABLE CLIENTES ADD CONSTRAINT PK_CLIENTES PRIMARY KEY (ID);
ALTER TABLE EMPRESAS ADD CONSTRAINT PK_EMPRESAS PRIMARY KEY (ID);
ALTER TABLE FORNECEDORES ADD CONSTRAINT PK_FORNECEDORES PRIMARY KEY (ID);
ALTER TABLE FUNCIONARIOS ADD CONSTRAINT PK_FUNCIONARIOS PRIMARY KEY (ID);
ALTER TABLE FUNCIONARIOS_FUNCOES ADD CONSTRAINT PK_FUNCIONARIOS_FUNCOES PRIMARY KEY (ID);
ALTER TABLE PERMISSOES_GRUPO ADD CONSTRAINT PK_PERMISSOES_GRUPO PRIMARY KEY (ID);
ALTER TABLE PRODUTOS_GRUPOS ADD CONSTRAINT PK_PRODUTOS_GRUPOS PRIMARY KEY (ID);
ALTER TABLE PRODUTOS_SUBGRUPOS ADD CONSTRAINT PK_PRODUTOS_SUBGRUPOS PRIMARY KEY (ID);


/******************************************************************************/
/****                             Foreign keys                             ****/
/******************************************************************************/

ALTER TABLE CLIENTES ADD CONSTRAINT FK_CLIENTES_CIDADE FOREIGN KEY (CIDADE) REFERENCES CIDADES (ID);
ALTER TABLE CONFIGURACOES ADD CONSTRAINT FK_CONFIGURACOES_EMPRESA FOREIGN KEY (EMPRESA) REFERENCES EMPRESAS (ID);
ALTER TABLE EMPRESAS ADD CONSTRAINT FK_EMPRESAS_CIDADES FOREIGN KEY (CIDADE) REFERENCES CIDADES (ID);
ALTER TABLE FORNECEDORES ADD CONSTRAINT FK_FORNECEDORES_CIDADE FOREIGN KEY (CIDADE) REFERENCES CIDADES (ID);
ALTER TABLE FUNCIONARIOS ADD CONSTRAINT FK_FUNCIONARIOS_GRUPOPERMISSOES FOREIGN KEY (GRUPO_PERMISSOES) REFERENCES PERMISSOES_GRUPO (ID);
ALTER TABLE FUNCIONARIOS ADD CONSTRAINT FK_FUNCIONARIOS_CIDADE FOREIGN KEY (CIDADE) REFERENCES CIDADES (ID);
ALTER TABLE FUNCIONARIOS ADD CONSTRAINT FK_FUNCIONARIOS_FUNCOES FOREIGN KEY (FUNCAO) REFERENCES FUNCIONARIOS_FUNCOES (ID);
ALTER TABLE PERMISSOES ADD CONSTRAINT FK_PERMISSOES_GRUPO FOREIGN KEY (GRUPO) REFERENCES PERMISSOES_GRUPO (ID);
ALTER TABLE PRODUTOS_SUBGRUPOS ADD CONSTRAINT FK_PRODUTOS_SUBGRUPOS_GRUPO FOREIGN KEY (GRUPO) REFERENCES PRODUTOS_GRUPOS (ID);


/******************************************************************************/
/****                               Indices                                ****/
/******************************************************************************/

CREATE INDEX IDX_CIDADES_NOME ON CIDADES (NOME);
CREATE INDEX IDX_CLIENTES_CNPJ ON CLIENTES (CNPJ);
CREATE INDEX IDX_CLIENTES_CPF ON CLIENTES (CPF);
CREATE INDEX IDX_CLIENTES_NOMEFANTASIA ON CLIENTES (NOME_FANTASIA);
CREATE INDEX IDX_CLIENTES_RAZAOSOCIAL ON CLIENTES (RAZAO_SOCIAL);
CREATE INDEX IDX_EMPRESAS_CNPJ ON EMPRESAS (CNPJ);
CREATE INDEX IDX_EMPRESAS_CPF ON EMPRESAS (CPF);
CREATE INDEX IDX_EMPRESAS_NOMEFANTASIA ON EMPRESAS (NOME_FANTASIA);
CREATE INDEX IDX_EMPRESAS_RAZAOSOCIAL ON EMPRESAS (RAZAO_SOCIAL);
CREATE INDEX IDX_FORNECEDORES_CNPJ ON FORNECEDORES (CNPJ);
CREATE INDEX IDX_FORNECEDORES_CPF ON FORNECEDORES (CPF);
CREATE INDEX IDX_FORNECEDORES_NOMEFANTASIA ON FORNECEDORES (NOME_FANTASIA);
CREATE INDEX IDX_FORNECEDORES_RAZAOSOCIAL ON FORNECEDORES (RAZAO_SOCIAL);
CREATE INDEX IDX_FUNCIONARIOS_CNPJ ON FUNCIONARIOS (CNPJ);
CREATE INDEX IDX_FUNCIONARIOS_CPF ON FUNCIONARIOS (CPF);
CREATE INDEX IDX_FUNCIONARIOS_NOMEFANTASIA ON FUNCIONARIOS (NOME_FANTASIA);
CREATE INDEX IDX_FUNCIONARIOS_RAZAOSOCIAL ON FUNCIONARIOS (RAZAO_SOCIAL);
CREATE INDEX IDX_PERMISSOES_NOME ON PERMISSOES (NOME);


/******************************************************************************/
/****                               Triggers                               ****/
/******************************************************************************/



SET TERM ^ ;



/******************************************************************************/
/****                         Triggers for tables                          ****/
/******************************************************************************/



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

/* Trigger: EMPRESAS_BI */
CREATE TRIGGER EMPRESAS_BI FOR EMPRESAS
ACTIVE BEFORE INSERT POSITION 0
as
begin
  if (new.id is null) then
    new.id = gen_id(gen_empresas_id,1);
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

/* Trigger: PERMISSOES_GRUPO_BI */
CREATE TRIGGER PERMISSOES_GRUPO_BI FOR PERMISSOES_GRUPO
ACTIVE BEFORE INSERT POSITION 0
as
begin
  if (new.id is null) then
    new.id = gen_id(gen_permissoes_grupo_id,1);
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
SET TERM ; ^
