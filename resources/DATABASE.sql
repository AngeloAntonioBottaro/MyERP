/******************************************************************************/
/****        Generated by IBExpert 2015.12.21.1 14/03/2023 09:39:51        ****/
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

CREATE GENERATOR GEN_FORNECEDORES_ID START WITH 0 INCREMENT BY 1;
SET GENERATOR GEN_FORNECEDORES_ID TO 0;

CREATE GENERATOR GEN_FUNCIONARIOS_ID START WITH 0 INCREMENT BY 1;
SET GENERATOR GEN_FUNCIONARIOS_ID TO 1;



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
    DATA_CADASTRO       DATE
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
    DATA_CADASTRO       DATE
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
    SENHA               VARCHAR(20)
);



/******************************************************************************/
/****                             Primary keys                             ****/
/******************************************************************************/

ALTER TABLE CIDADES ADD CONSTRAINT PK_CIDADES PRIMARY KEY (ID);
ALTER TABLE CLIENTES ADD CONSTRAINT PK_CLIENTES PRIMARY KEY (ID);
ALTER TABLE FORNECEDORES ADD CONSTRAINT PK_FORNECEDORES PRIMARY KEY (ID);
ALTER TABLE FUNCIONARIOS ADD CONSTRAINT PK_FUNCIONARIOS PRIMARY KEY (ID);


/******************************************************************************/
/****                             Foreign keys                             ****/
/******************************************************************************/

ALTER TABLE CLIENTES ADD CONSTRAINT FK_CLIENTES_CIDADE FOREIGN KEY (CIDADE) REFERENCES CIDADES (ID);
ALTER TABLE FORNECEDORES ADD CONSTRAINT FK_FORNECEDORES_CIDADE FOREIGN KEY (CIDADE) REFERENCES CIDADES (ID);
ALTER TABLE FUNCIONARIOS ADD CONSTRAINT FK_FUNCIONARIOS_CIDADE FOREIGN KEY (CIDADE) REFERENCES CIDADES (ID);


/******************************************************************************/
/****                               Indices                                ****/
/******************************************************************************/

CREATE INDEX IDX_CIDADES_NOME ON CIDADES (NOME);
CREATE INDEX IDX_CLIENTES_CNPJ ON CLIENTES (CNPJ);
CREATE INDEX IDX_CLIENTES_CPF ON CLIENTES (CPF);
CREATE INDEX IDX_CLIENTES_NOMEFANTASIA ON CLIENTES (NOME_FANTASIA);
CREATE INDEX IDX_CLIENTES_RAZAOSOCIAL ON CLIENTES (RAZAO_SOCIAL);
CREATE INDEX IDX_FORNECEDORES_CNPJ ON FORNECEDORES (CNPJ);
CREATE INDEX IDX_FORNECEDORES_CPF ON FORNECEDORES (CPF);
CREATE INDEX IDX_FORNECEDORES_NOMEFANTASIA ON FORNECEDORES (NOME_FANTASIA);
CREATE INDEX IDX_FORNECEDORES_RAZAOSOCIAL ON FORNECEDORES (RAZAO_SOCIAL);
CREATE INDEX IDX_FUNCIONARIOS_CNPJ ON FUNCIONARIOS (CNPJ);
CREATE INDEX IDX_FUNCIONARIOS_CPF ON FUNCIONARIOS (CPF);
CREATE INDEX IDX_FUNCIONARIOS_NOMEFANTASIA ON FUNCIONARIOS (NOME_FANTASIA);
CREATE INDEX IDX_FUNCIONARIOS_RAZAOSOCIAL ON FUNCIONARIOS (RAZAO_SOCIAL);


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
SET TERM ; ^

