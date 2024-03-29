-- APAGANDO AS TABELAS
DROP TABLE FABRICANTE CASCADE CONSTRAINTS;
DROP TABLE DEPARTAMENTO CASCADE CONSTRAINTS;
DROP TABLE SOFTWARE CASCADE CONSTRAINTS;
DROP TABLE EQUIPAMENTO CASCADE CONSTRAINTS;
DROP TABLE COMPUTADOR CASCADE CONSTRAINTS;
DROP TABLE REDE CASCADE CONSTRAINTS;
DROP TABLE PERIFERICO CASCADE CONSTRAINTS;
DROP TABLE ITENS_HARDWARE_INSTALADO CASCADE CONSTRAINTS;
DROP TABLE ITENS_SOFTWARE_INSTALADO CASCADE CONSTRAINTS;


-- FABRICANTE
CREATE TABLE FABRICANTE 
	(
		COD_FAB			INTEGER 		PRIMARY KEY,
		NOME_FAB		VARCHAR2(50)		NOT NULL,
		NOME_FANTASIA_FAB	VARCHAR2(50)		NOT NULL,
		ENDERECO_FAB		VARCHAR2(100)		NOT NULL,
		TIPO_PRODUTO		VARCHAR2(50)		NOT NULL		
	);
  
-- DEPARTAMENTO
CREATE TABLE DEPARTAMENTO
  (
    COD_DEPTO          NUMBER(3)       PRIMARY KEY,
    NOME_DEPTO         VARCHAR2(30)    NOT NULL,
    RAMAL_DEPTO        CHAR(5),
    LOCALIZACAO_DEPTO  VARCHAR2(30)    NOT NULL  
  );
  
-- SOFTWARE
CREATE TABLE SOFTWARE
  (
    COD_SOFT      INTEGER          PRIMARY KEY,
    NOME_SOFT     VARCHAR2(50)     NOT NULL,
    COD_FAB       INTEGER          REFERENCES FABRICANTE,
    VERSAO        VARCHAR2(10)     ,
    TIPO_SOFT     VARCHAR2(50)     
  );
  
--EQUIPAMENTO
CREATE TABLE EQUIPAMENTO
  (
    NUM_PATRI     INTEGER         PRIMARY KEY,
    MODELO        VARCHAR2(50)    NOT NULL,
    NUM_SERIE     VARCHAR2(40)    NOT NULL,
    DT_AQUISICAO  DATE            NOT NULL,
    NOTA_FISCAL   VARCHAR2(30)    NOT NULL,
    VALOR         NUMBER(11,2)    NOT NULL,
    TEMPO_GARANTIA NUMBER(3)      NOT NULL,                -- TEMPO DADO EM MESES
    TIPO_EQ       CHAR(10)        NOT NULL,
    COD_DEPTO     NUMBER(3)       REFERENCES DEPARTAMENTO,
    COD_FABRICANTE INTEGER        REFERENCES FABRICANTE
  );
  
-- COMPUTADOR
CREATE TABLE COMPUTADOR
  (
    NUM_PATRI     INTEGER       REFERENCES EQUIPAMENTO ON DELETE CASCADE,
    TIPO_CPU      VARCHAR2(20)  NOT NULL,
    VELOCIDADE_CPU NUMBER(5,2)  NOT NULL,  -- VELOCIDADE EM GIGA Hz
    CAPACIDADE_HD NUMBER(6,2)   NOT NULL,  -- CAPACIDADE EM GIGABYTES
    MEMORIA       NUMBER(4)     NOT NULL,  -- CAPACIADE EM GIGABYTES
    TIPO_COMPUTADOR CHAR(8)     ,
    PRIMARY KEY(NUM_PATRI)
  );
  
-- REDE
CREATE TABLE REDE
  (
    NUM_PATRI     INTEGER     REFERENCES EQUIPAMENTO ON DELETE CASCADE,
    TIPO_REDE     CHAR(8)     NOT NULL,
    TIPO_CONEXAO  CHAR(20)    NOT NULL,
    NUM_PORTAS    NUMBER(3)   NOT NULL,
    PRIMARY KEY(NUM_PATRI)
  );

-- PERIFERICO
CREATE TABLE PERIFERICO
  (
      NUM_PATRI   INTEGER   REFERENCES EQUIPAMENTO ON DELETE CASCADE,
      TIPO_PERIFERICO CHAR(10)     NOT  NULL,
      CARACTERISTICA  VARCHAR2(50) NOT NULL,
      PRIMARY KEY(NUM_PATRI)
  );
  
-- ITENS_HARDWARE_INSTALADO
CREATE TABLE ITENS_HARDWARE_INSTALADO
  (
    NUM_PATRI_COMPUTADOR    INTEGER REFERENCES COMPUTADOR ON DELETE CASCADE,
    NUM_PATRI_PERIFERICO    INTEGER REFERENCES PERIFERICO ON DELETE CASCADE,
    DT_INICIO       DATE    NOT NULL,
    DT_RETIRADA     DATE,
    PRIMARY KEY(NUM_PATRI_COMPUTADOR,NUM_PATRI_PERIFERICO, DT_INICIO)
  );
  
-- ITENS_SOFTWARE_INSTALADO
CREATE TABLE ITENS_SOFTWARE_INSTALADO
  (
    COD_SOFT              INTEGER     REFERENCES SOFTWARE ON DELETE CASCADE,
    NUM_PATRI_COMPUTADOR  INTEGER     REFERENCES COMPUTADOR ON DELETE CASCADE,
    DT_HORA_INSTALACAO    TIMESTAMP   NOT NULL,
    DT_HORA_REMOCAO       TIMESTAMP,
    NUM_LICENCA           VARCHAR(40) NOT NULL,
    PRIMARY KEY(COD_SOFT, NUM_PATRI_COMPUTADOR, DT_HORA_INSTALACAO)
  );
