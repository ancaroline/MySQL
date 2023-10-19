/* PRIMEIRA FORMA NORMAL

REGRAS:
1. TODO CAMPO VETORIZADO SE TORNARÁ OUTRA TABELA.
2. TODO CAMPO MULTIVALORADO SE TORNARÁ OUTRA TABELA.
QUANTO O CAMPO FOR DIVISÍVEL.
3. TODA TABELA NECESSITA DE PELO MENOS UM CAMPO QUE IDENTIFIQUE
TODO O REGISTRO COMO SENDO ÚNICO. ISSO É O QUE CHAMAMOS DE CHAVE PRIMÁRIA
OU PRIMARY KEY. -> A CHAVE PRIMÁRIA IDENTIFICA UM REGISTRO INTEIRO (LINHA) COMO SENDO ÚNICO.
EXISTEM DOIS TIPOS DE CHAVES:
-> NATURAL - PERTENCE A ALGO NATURALMENTE (EX: CPF)
-> ARTIFICIAL - PERTENCE A ALGO ARTIFICIALMENTE (EX: ID)


NO EXEMPLO DA TABELA CLIENTE, TELEFONE É UM CAMPO MULTIVALORADO E ENDEREÇO TAMBÉM, ENTÃO
SÃO TABELAS DIFERENTES, ONDE CLIENTE POSSUI TELEFONE E CLIENTE POSSUI ENDEREÇO.
-> QUEM DEFINE A CARDINALIDADE É A REGRA DE NEGÓCIO

EXEMPLO:
ESTAMOS NO INÍCIO DA MODELAGEM PARA UM SISTEMA E O NOSSO GESTOR NOS PEDIU A MODELAGEM DA TABELA
DE CLIENTES COM A SEGUINTE REGRA DE NEGÓCIO:
ENDERECO - OBRIGATÓRIO O CADASTRO DE UM ENDERECO (NO MÁXIMO 1). (1, 1)
TELEFONE - O CLIENTE NÃO É OBRIGADO A INFORMAR TELEFONE (0, N)
POREM, CASO QUEIRA, ELE PODE INFORMAR MAIS DE UM.

> CARDINALIDADE:
(0,N)
(0,1)
(1,N)
(1,1)
A PRIMEIRA COLUNA: OBRIGATORIEDADE (SE 0 É FALSO, SE 1 É VERDADEIRO)
A SEGUNDA COLUNA: CARDINALIDADE (CARDINALIDADE DEFINE O MÁXIMO: 1 OU MAIS DE 1)

> O ENDEREÇO PRECISA TER CLIENTE? SIM (1) - OBRIGATORIO
> QUANTOS CLIENTES PERTENCEM AO UM ENDEREÇO? 1 (1) - CARDINALIDADE
(1,1)

O RELACIONAMENTO DE CLIENTE E ENDEREÇO É 1X1, POIS UM CLIENTE PERTENCE A UM ENDEREÇO E É OBRIGATÓRIO UM CADASTRO DE ENDEREÇO.
A CARDINALIDADE DE ENDEREÇO É (1,1) E DE CLIENTE É (1,1), LOGO SELECIONA A SEGUNDA COLUNA DE CADA CARDINALIDADE.
ENTÃO, É UM RELACIONAMENTO DE 1 PARA 1.

 */

CREATE DATABASE COMERCIO;
USE COMERCIO;
SHOW DATABASES;

DROP TABLE CLIENTE; -- APAGAR CLIENTE

CREATE TABLE CLIENTE (
	IDCLIENTE INT PRIMARY KEY AUTO_INCREMENT,  -- INCREMENTAR O IDCLIENTE. PK POSSUI VALORES EXCLUSIVOS POR TODA A TABELA.
	NOME VARCHAR (30) NOT NULL,  -- COLUNA NÃO PODE SER NULA 
	SEXO ENUM('M', 'F') NOT NULL, -- ENUM SÓ EXISTE EM MYSQL
	EMAIL VARCHAR(50) UNIQUE, -- EMAIL UNICOM NÃO PODE SE REPETIR
	CPF VARCHAR(15) UNIQUE
);

CREATE TABLE ENDERECO (
	IDENDERECO INT PRIMARY KEY AUTO_INCREMENT,
	RUA VARCHAR (30) NOT NULL,
	BAIRRO VARCHAR (30) NOT NULL,
	CIDADE VARCHAR (30) NOT NULL,
	ESTADO CHAR(2) NOT NULL,
	ID_CLIENTE INT UNIQUE, -- POIS O TIPO DA CHAVE PRIMARIA DE CLIENTE É INT. UNIQUE, POIS O RELACIONAMENTO É DE 1X1.
	FOREIGN KEY(ID_CLIENTE)
	REFERENCES CLIENTE(IDCLIENTE)
);

CREATE TABLE TELEFONE (
	IDTELEFONE INT PRIMARY KEY AUTO_INCREMENT,
	TIPO ENUM('RES','COM','CEL') NOT NULL,
	NUMERO VARCHAR(10) NOT NULL,
	ID_CLIENTE INT,
	FOREIGN KEY(ID_CLIENTE)
	REFERENCES CLIENTE(IDCLIENTE)
);

/* ENDERECO - OBRIGATÓRIO
CADASTRO DE SOMENTE UM.
TELEFONE - NÃO OBRIGATÓRIO
CADASTRO DE MAIS DE UM (OPCIONAL)*/

-- FOREIGN KEY (FK)--
/*É A CHAVE PRIMÁRIA DE UMA TABELA QUE VAI ATÉ OUTRA
TABELA PARA FAZER REFERÊNCIA ENTRE REGISTROS. */

/* 
-> EM RELACIONAMENTO 1 X 1 A CHAVE ESTRANGEIRA FICA NA TABELA MAIS FRACA
-> EM RELACIONAMENTO 1 X N A CHAVE ESTRANGEIRA SEMPRE FICARÁ NA CARDINALIDADE N
*/

DESC CLIENTE; -- SABER COMO A TABELA FOI FORMADA
INSERT INTO CLIENTE VALUES(NULL, 'JOÃO ALMEIDA', 'M', 'JOAOGUI@GMAIL.COM', '438473864');  -- O NULL: PARA O PRÓPRIO SISTEMA INCREMENTAR
INSERT INTO CLIENTE VALUES(NULL, 'CLARA RUIZ', 'F', 'CLARARUIZ@GMAIL.COM', '756533864');
INSERT INTO CLIENTE VALUES(NULL, 'LUCAS PEDRO', 'M', NULL, '9877233864');
INSERT INTO CLIENTE VALUES(NULL, 'TONI ALMEIDA', 'M', 'TONI@GMAIL.COM', '4092223864');
INSERT INTO CLIENTE VALUES(NULL, 'IAGO ABAX', 'M', 'IGO@GMAIL.COM', '232313864');
INSERT INTO CLIENTE VALUES(NULL, 'LUNA CALS', 'F', 'LUNA@GMAIL.COM', '1212123864');

SELECT * FROM CLIENTE;

+-----------+--------------+------+---------------------+------------+
| IDCLIENTE | NOME         | SEXO | EMAIL               | CPF        |
+-----------+--------------+------+---------------------+------------+
|         1 | JOÃO ALMEIDA | M    | JOAOGUI@GMAIL.COM   | 438473864  |
|         2 | CLARA RUIZ   | F    | CLARARUIZ@GMAIL.COM | 756533864  |
|         3 | LUCAS PEDRO  | M    | NULL                | 9877233864 |
|         4 | TONI ALMEIDA | M    | TONI@GMAIL.COM      | 4092223864 |
|         5 | IAGO ABAX    | M    | IGO@GMAIL.COM       | 232313864  |
|         6 | LUNA CALS    | F    | LUNA@GMAIL.COM      | 1212123864 |
+-----------+--------------+------+---------------------+------------+

INSERT INTO ENDERECO VALUES(NULL, 'ANTONIO SÁ', 'CENTRO', 'BELO HORIZONTE', 'MG', 4);
INSERT INTO ENDERECO VALUES(NULL, 'DO VALE', 'RENASCENÇA', 'SÃO LUÍS', 'MA', 1);
INSERT INTO ENDERECO VALUES(NULL, 'DOM QUIXOTE', 'FLORES', 'SÃO PAULO', 'SP', 2);
INSERT INTO ENDERECO VALUES(NULL, 'DA VILLA', 'CENTRO', 'NITERÓI', 'RJ', 3);
INSERT INTO ENDERECO VALUES(NULL, 'ANTONIO SÁ', 'CENTRO', 'BELO HORIZONTE', 'MG', 5);
INSERT INTO ENDERECO VALUES(NULL, 'AUGUSTO', 'NIVEA', 'SÃO JOSÉ DOS CAMPOS', 'PR', 6);

+------------+-------------+------------+---------------------+--------+------------+
| IDENDERECO | RUA         | BAIRRO     | CIDADE              | ESTADO | ID_CLIENTE |
+------------+-------------+------------+---------------------+--------+------------+
|          1 | ANTONIO SÁ  | CENTRO     | BELO HORIZONTE      | MG     |          4 |
|          2 | DO VALE     | RENASCENÇA | SÃO LUÍS            | MA     |          1 |
|          3 | DOM QUIXOTE | FLORES     | SÃO PAULO           | SP     |          2 |
|          4 | DA VILLA    | CENTRO     | NITERÓI             | RJ     |          3 |
|          5 | ANTONIO SÁ  | CENTRO     | BELO HORIZONTE      | MG     |          5 |
|          6 | AUGUSTO     | NIVEA      | SÃO JOSÉ DOS CAMPOS | PR     |          6 |
+------------+-------------+------------+---------------------+--------+------------+

INSERT INTO TELEFONE VALUES(NULL, 'CEL', '87834394', 5);
INSERT INTO TELEFONE VALUES(NULL, 'RES', '92831232', 5);
INSERT INTO TELEFONE VALUES(NULL, 'RES', '94232032', 1);
INSERT INTO TELEFONE VALUES(NULL, 'CEL', '32038922', 2);
INSERT INTO TELEFONE VALUES(NULL, 'COM', '12782378', 3);
INSERT INTO TELEFONE VALUES(NULL, 'RES', '34243121', 2);

+------------+------+----------+------------+
| IDTELEFONE | TIPO | NUMERO   | ID_CLIENTE |
+------------+------+----------+------------+
|          1 | CEL  | 87834394 |          5 |
|          2 | RES  | 92831232 |          5 |
|          3 | RES  | 94232032 |          1 |
|          4 | CEL  | 32038922 |          2 |
|          5 | COM  | 12782378 |          3 |
|          6 | RES  | 34243121 |          2 |
+------------+------+----------+------------+

/* SELECAO, PROJECAO E JUNCAO */

/* PROJECAO -> É TUD QUE VOCÊ QUER VER NA TELA ( SELECT * FROM ... ) */
SELECT NOW() AS DATA_ATUAL;
SELECT 2 + 2 AS SOMA;
SELECT 2 + 2 AS SOMA, NOME, NOW()
FROM CLIENTE;
-- Exemplo: 'quero o nome, sexo, tipo, telefone, bairro'
-- SELECT NOME, SEXO, TIPO, TELEFONE, BAIRRO

/* SELECAO -> É UM SUBCONJUNTO DO CONJUNTO TOTAL DE REGISTROS DE UMA TABELA
A CLÁUSULA DE SELEÇÃO É O WHERE*/
-- Exemplo: trazer nome e email das mulheres
SELECT NOME, SEXO, EMAIL  -- PROJECAO
FROM CLIENTE  -- ORIGEM
WHERE SEXO = 'F';  -- SELECAO

SELECT NUMERO
FROM TELEFONE
WHERE TIPO = 'CEL';

/* JUNCAO -> JOIN */  -- JUNTAR TABELAS
SELECT NOME, EMAIL, IDCLIENTE
FROM CLIENTE;
+--------------+---------------------+-----------+
| NOME         | EMAIL               | IDCLIENTE |
+--------------+---------------------+-----------+
| JOÃO ALMEIDA | JOAOGUI@GMAIL.COM   |         1 |
| CLARA RUIZ   | CLARARUIZ@GMAIL.COM |         2 |
| LUCAS PEDRO  | NULL                |         3 |
| TONI ALMEIDA | TONI@GMAIL.COM      |         4 |
| IAGO ABAX    | IGO@GMAIL.COM       |         5 |
| LUNA CALS    | LUNA@GMAIL.COM      |         6 |
+--------------+---------------------+-----------+

SELECT ID_CLIENTE, BAIRRO, CIDADE
FROM ENDERECO;
+------------+------------+---------------------+
| ID_CLIENTE | BAIRRO     | CIDADE              |
+------------+------------+---------------------+
|          4 | CENTRO     | BELO HORIZONTE      |
|          1 | RENASCENÇA | SÃO LUÍS            |
|          2 | FLORES     | SÃO PAULO           |
|          3 | CENTRO     | NITERÓI             |
|          5 | CENTRO     | BELO HORIZONTE      |
|          6 | NIVEA      | SÃO JOSÉ DOS CAMPOS |
+------------+------------+---------------------+

/* NOME, SEXO, BAIRRO, CIDADE */

-- NÃO RECOMENDADO
SELECT NOME, SEXO, BAIRRO, CIDADE -- PROJECAO
FROM CLIENTE, ENDERECO -- ORIGEM
WHERE IDCLIENTE = ID_CLIENTE; -- JUNCAO

+--------------+------+------------+---------------------+
| NOME         | SEXO | BAIRRO     | CIDADE              |
+--------------+------+------------+---------------------+
| JOÃO ALMEIDA | M    | RENASCENÇA | SÃO LUÍS            |
| CLARA RUIZ   | F    | FLORES     | SÃO PAULO           |
| LUCAS PEDRO  | M    | CENTRO     | NITERÓI             |
| TONI ALMEIDA | M    | CENTRO     | BELO HORIZONTE      |
| IAGO ABAX    | M    | CENTRO     | BELO HORIZONTE      |
| LUNA CALS    | F    | NIVEA      | SÃO JOSÉ DOS CAMPOS |
+--------------+------+------------+---------------------+

/* WHERE - SELECAO */
-- NÃO RECOMENDADO
SELECT NOME, SEXO, BAIRRO, CIDADE
FROM CLIENTE, ENDERECO
WHERE IDCLIENTE = ID_CLIENTE  -- SEMPRE IRÁ VERIFICAR PRIMEIRO O IDCLIENTE = ID_CLIENTE, MAS SEMPRE DARÁ TRUE
AND SEXO = 'F';

/* INNER JOIN */
SELECT NOME, SEXO, BAIRRO, CIDADE
FROM CLIENTE
	INNER JOIN ENDERECO
	ON IDCLIENTE = ID_CLIENTE;
+--------------+------+------------+---------------------+
| NOME         | SEXO | BAIRRO     | CIDADE              |
+--------------+------+------------+---------------------+
| JOÃO ALMEIDA | M    | RENASCENÇA | SÃO LUÍS            |
| CLARA RUIZ   | F    | FLORES     | SÃO PAULO           |
| LUCAS PEDRO  | M    | CENTRO     | NITERÓI             |
| TONI ALMEIDA | M    | CENTRO     | BELO HORIZONTE      |
| IAGO ABAX    | M    | CENTRO     | BELO HORIZONTE      |
| LUNA CALS    | F    | NIVEA      | SÃO JOSÉ DOS CAMPOS |
+--------------+------+------------+---------------------+

SELECT NOME, SEXO, BAIRRO, CIDADE -- PROJECAO
FROM CLIENTE -- ORIGEM
	INNER JOIN ENDERECO -- JUNCAO
	ON IDCLIENTE = ID_CLIENTE 
WHERE SEXO = 'F'; -- SELECAO
+------------+------+--------+---------------------+
| NOME       | SEXO | BAIRRO | CIDADE              |
+------------+------+--------+---------------------+
| CLARA RUIZ | F    | FLORES | SÃO PAULO           |
| LUNA CALS  | F    | NIVEA  | SÃO JOSÉ DOS CAMPOS |
+------------+------+--------+---------------------+

/* NOME, SEXO, EMAIL, TIPO, NUMERO */
SELECT NOME, SEXO, EMAIL, TIPO, NUMERO
FROM CLIENTE
	INNER JOIN TELEFONE
	ON IDCLIENTE = ID_CLIENTE;

-- INNER JOIN - JUNÇÃO DE TABELAS
/* NOME, SEXO, BAIRRO, CIDADE, TIPO, NUMERO */

SELECT CLIENTE.NOME, CLIENTE.SEXO, ENDERECO.BAIRRO, ENDERECO.CIDADE, TELEFONE.TIPO, TELEFONE.NUMERO
FROM CLIENTE
INNER JOIN ENDERECO
ON CLIENTE.IDCLIENTE = ENDERECO.ID_CLIENTE
INNER JOIN TELEFONE
ON CLIENTE.IDCLIENTE = TELEFONE.ID_CLIENTE;

+--------------+------+------------+----------------+------+----------+
| NOME         | SEXO | BAIRRO     | CIDADE         | TIPO | NUMERO   |
+--------------+------+------------+----------------+------+----------+
| JOÃO ALMEIDA | M    | RENASCENÇA | SÃO LUÍS       | RES  | 94232032 |
| CLARA RUIZ   | F    | FLORES     | SÃO PAULO      | RES  | 34243121 |
| CLARA RUIZ   | F    | FLORES     | SÃO PAULO      | CEL  | 32038922 |
| LUCAS PEDRO  | M    | CENTRO     | NITERÓI        | COM  | 12782378 |
| IAGO ABAX    | M    | CENTRO     | BELO HORIZONTE | RES  | 92831232 |
| IAGO ABAX    | M    | CENTRO     | BELO HORIZONTE | CEL  | 87834394 |
+--------------+------+------------+----------------+------+----------+

/* MAIS COMUM - PONTEIRAMENTO. [AJUDA NA PERFORMANCE]*/
SELECT C.NOME, C.SEXO, E.BAIRRO, E.CIDADE, T.TIPO, T.NUMERO
FROM CLIENTE C
INNER JOIN ENDERECO E
ON C.CLIENTE = E.ID_CLIENTE
INNER JOIN TELEFONE T
ON C.IDCLIENTE = T.ID_CLIENTE;

/* COMANDOS DE DML - DATA MANIPULATION LANGUAGE
DDL - DATA DEFINITION LANGUAGE
DCL - DATA CONTROL LANGUAGE
TCL - TRANSACTION CONTROL LANGUAGE
*/
-- DML
/* INSERT */
INSERT INTO CLIENTE VALUES(NULL, 'PAULA', 'M', NULL, '777545335');
INSERT INTO ENDERECO VALUES(NULL, 'RUA JOAQUIM', 'ALVORADA', 'NITEROI', 'RJ', '7');

/* FILTROS */
SELECT * FROM CLIENTE
WHERE SEXO = 'M';

/* UPDATE */
-- VERIFICANDO SE IREI ALTERAR O CORRETO
SELECT * FROM CLIENTE
WHERE IDCLIENTE = 7;
--
UPDATE CLIENTE
SET SEXO = 'F'
WHERE IDCLIENTE = 7;

/* DELETE */
INSERT INTO CLIENTE VALUES(NULL, 'XXX', 'M', NULL, 'XXX');

SELECT CLIENTE, IDCLIENTE FROM CLIENTE
WHERE IDCLIENTE = 8;

DELETE FROM CLIENTE WHERE IDCLIENTE = 8;

-- DDL

CREATE TABLE PRODUTO(
	IDPRODUTO INT PTIMARY KEY AUTO_INCREMENT,
	NOME_PRODUTO VARCHAR(30) NOT NULL,
	PRECO INT,
	FRETE FLOAT(10, 2) NOT NULL
);

/* ALTER TABLE 
ALTERANDO O NOME DE UMA COLUNA - CHANGE */

ALTER TABLE PRODUTO
CHANGE PRECO VALOR_UNITARIO INT NOT NULL;  -- ALTERANDO O NOME

ALTER TABLE PRODUTO
CHANGE VALOR_UNITARIO VALOR_UNITARIO INT;  -- ALTERANDO O TIPO

/* MODIFY */
ALTER TABLE PRODUTO
MODIFY VALOR_UNITARIO VARCHAR(50) NOT NULL;  -- ALTERANDO O TIPO

/* ADICIONANDO COLUNAS */
ALTER TABLE PRODUTO
ADD PESO FLOAT(10, 2) NOT NULL;

/* APAGANDO UMA COLUNA */
ALTER TABLE PRODUTO
DROP COLUMN PESO;

/* ADICIONANDO COLUNA EM ORDEM ESPECÍFICA */ -- FUNÇÃO DO MYSQL
-- AFTER - DEPOIS DE UMA COLUNA ESPECÍFICA
ALTER TABLE PRODUTO
ADD COLUMN PESO FLOAT(10, 2) NOT NULL
AFTER NOME_PRODUTO;

-- FIRST - ANTES DE UMA COLUNA ESPECÍFICA
ALTER TABLE PRODUTO
ADD COLUMN PESO FLOAT(10, 2) NOT NULL
FIRST;

-- EXERCÍCIO DE DML
/* CADASTRAR CLIENTES */
INSERT INTO CLIENTE VALUES(NULL, 'FLAVIO', 'M', 'FLAVIO@GMAIL.COM', '5432313');
INSERT INTO CLIENTE VALUES(NULL, 'ANDRE', 'M', 'ANDRE@GMAIL.COM', '9839282');
INSERT INTO CLIENTE VALUES(NULL, 'GIOVANNA', 'F', NULL, '2832983');
INSERT INTO CLIENTE VALUES(NULL, 'KARLA', 'M', 'KARLA@GMAIL.COM', '9889222');
INSERT INTO CLIENTE VALUES(NULL, 'DANIELLE', 'M', 'DANIELLE@GMAIL.COM', '2837233');
INSERT INTO CLIENTE VALUES(NULL, 'LORENA', 'M', 'LORENA@GMAIL.COM', '19283732')
INSERT INTO CLIENTE VALUES(NULL, 'AMANDA', 'F', 'AMANDA@GMAIL.COM', '832983298');

/* CADASTRAR UM ENDEREÇO PARA CADA CLIENTE */
INSERT INTO ENDERECO VALUES(NULL, 'RUA GUEDES', 'CASCADURA', 'B. HORIZONTE', 'MG',9);
INSERT INTO ENDERECO VALUES(NULL, 'RUA FRANCISCO CORTE', 'AMERICO', 'BAHIA', 'BH',10);
INSERT INTO ENDERECO VALUES(NULL, 'AV FAUSTO OLIVA', 'CENTRO', 'SÃO LUÍS', 'MA',11);
INSERT INTO ENDERECO VALUES(NULL, 'RUA JORGE', 'JARDINS', 'CURITIBA', 'PR',12);
INSERT INTO ENDERECO VALUES(NULL, 'RUA BOIADA', 'BOM RETIRO', 'CURITIBA', 'PR',13);
INSERT INTO ENDERECO VALUES(NULL, 'AV DO REI', 'CENTRO', 'NITERÓI', 'RJ',14);
INSERT INTO ENDERECO VALUES(NULL, 'AV MOLHARES', 'CENTRO', 'SÃO LUÍS', 'MA',16);

/* CADASTRAR TELEFONES PARA OS CLIENTES */
INSERT INTO TELEFONE VALUES(NULL, 'CEL', '746377266', 9);
INSERT INTO TELEFONE VALUES(NULL, 'CEL', '239232938', 11);
INSERT INTO TELEFONE VALUES(NULL, 'COM', '653423232', 11);
INSERT INTO TELEFONE VALUES(NULL, 'CEL', '873827827', 12);
INSERT INTO TELEFONE VALUES(NULL, 'COM', '373121211', 13);
INSERT INTO TELEFONE VALUES(NULL, 'CEL', '623562536', 13);
INSERT INTO TELEFONE VALUES(NULL, 'RES', '534223232', 14);
INSERT INTO TELEFONE VALUES(NULL, 'RES', '983783728', 16);

/* RELATÓRIO GERAL DE TODOS OS CLIENTES */

DESC CLIENTE;

+-----------+---------------+------+-----+---------+----------------+
| Field     | Type          | Null | Key | Default | Extra          |
+-----------+---------------+------+-----+---------+----------------+
| IDCLIENTE | int           | NO   | PRI | NULL    | auto_increment |
| NOME      | varchar(30)   | NO   |     | NULL    |                |
| SEXO      | enum('M','F') | NO   |     | NULL    |                |
| EMAIL     | varchar(50)   | YES  | UNI | NULL    |                |
| CPF       | varchar(15)   | YES  | UNI | NULL    |                |
+-----------+---------------+------+-----+---------+----------------+

DESC TELEFONE;

+------------+-------------------------+------+-----+---------+----------------+
| Field      | Type                    | Null | Key | Default | Extra          |
+------------+-------------------------+------+-----+---------+----------------+
| IDTELEFONE | int                     | NO   | PRI | NULL    | auto_increment |
| TIPO       | enum('RES','COM','CEL') | NO   |     | NULL    |                |
| NUMERO     | varchar(10)             | NO   |     | NULL    |                |
| ID_CLIENTE | int                     | YES  | MUL | NULL    |                |
+------------+-------------------------+------+-----+---------+----------------+

DESC ENDERECO;

+------------+-------------+------+-----+---------+----------------+
| Field      | Type        | Null | Key | Default | Extra          |
+------------+-------------+------+-----+---------+----------------+
| IDENDERECO | int         | NO   | PRI | NULL    | auto_increment |
| RUA        | varchar(30) | NO   |     | NULL    |                |
| BAIRRO     | varchar(30) | NO   |     | NULL    |                |
| CIDADE     | varchar(30) | NO   |     | NULL    |                |
| ESTADO     | char(2)     | NO   |     | NULL    |                |
| ID_CLIENTE | int         | YES  | UNI | NULL    |                |
+------------+-------------+------+-----+---------+----------------+

SELECT C.IDCLIENTE, C.NOME, C.SEXO, C.EMAIL, C.CPF, 
	E.RUA, E.BAIRRO, E.CIDADE, E.ESTADO, 
	T.TIPO, T.NUMERO
FROM CLIENTE C
INNER JOIN ENDERECO E 
ON IDCLIENTE = E.ID_CLIENTE
INNER JOIN TELEFONE T
ON IDCLIENTE = T.ID_CLIENTE;

+-----------+--------------+------+---------------------+------------+-----------------+------------+----------------+--------+------+-----------+
| IDCLIENTE | NOME         | SEXO | EMAIL               | CPF        | RUA             | BAIRRO     | CIDADE         | ESTADO | TIPO | NUMERO    |
+-----------+--------------+------+---------------------+------------+-----------------+------------+----------------+--------+------+-----------+
|         5 | IAGO ABAX    | M    | IGO@GMAIL.COM       | 232313864  | ANTONIO SÁ      | CENTRO     | BELO HORIZONTE | MG     | CEL  | 87834394  |
|         5 | IAGO ABAX    | M    | IGO@GMAIL.COM       | 232313864  | ANTONIO SÁ      | CENTRO     | BELO HORIZONTE | MG     | RES  | 92831232  |
|         1 | JOÃO ALMEIDA | M    | JOAOGUI@GMAIL.COM   | 438473864  | DO VALE         | RENASCENÇA | SÃO LUÍS       | MA     | RES  | 94232032  |
|         2 | CLARA RUIZ   | F    | CLARARUIZ@GMAIL.COM | 756533864  | DOM QUIXOTE     | FLORES     | SÃO PAULO      | SP     | CEL  | 32038922  |
|         3 | LUCAS PEDRO  | M    | NULL                | 9877233864 | DA VILLA        | CENTRO     | NITERÓI        | RJ     | COM  | 12782378  |
|         2 | CLARA RUIZ   | F    | CLARARUIZ@GMAIL.COM | 756533864  | DOM QUIXOTE     | FLORES     | SÃO PAULO      | SP     | RES  | 34243121  |
|         9 | FLAVIO       | M    | FLAVIO@GMAIL.COM    | 5432313    | RUA GUEDES      | CASCADURA  | B. HORIZONTE   | MG     | CEL  | 746377266 |
|        11 | GIOVANNA     | F    | NULL                | 2832983    | AV FAUSTO OLIVA | CENTRO     | SÃO LUÍS       | MA     | CEL  | 239232938 |
|        11 | GIOVANNA     | F    | NULL                | 2832983    | AV FAUSTO OLIVA | CENTRO     | SÃO LUÍS       | MA     | COM  | 653423232 |
|        12 | KARLA        | M    | KARLA@GMAIL.COM     | 9889222    | RUA JORGE       | JARDINS    | CURITIBA       | PR     | CEL  | 873827827 |
|        13 | DANIELLE     | M    | DANIELLE@GMAIL.COM  | 2837233    | RUA BOIADA      | BOM RETIRO | CURITIBA       | PR     | COM  | 373121211 |
|        13 | DANIELLE     | M    | DANIELLE@GMAIL.COM  | 2837233    | RUA BOIADA      | BOM RETIRO | CURITIBA       | PR     | CEL  | 623562536 |
|        14 | LORENA       | M    | LORENA@GMAIL.COM    | 19283732   | AV DO REI       | CENTRO     | NITERÓI        | RJ     | RES  | 534223232 |
+-----------+--------------+------+---------------------+------------+-----------------+------------+----------------+--------+------+-----------+


/* RELATÓRIO DE HOMENS */

SELECT C.IDCLIENTE, C.NOME, C.SEXO, C.EMAIL, C.CPF, 
	E.RUA, E.BAIRRO, E.CIDADE, E.ESTADO, 
	T.TIPO, T.NUMERO
FROM CLIENTE C
INNER JOIN ENDERECO E 
ON IDCLIENTE = E.ID_CLIENTE
INNER JOIN TELEFONE T
ON IDCLIENTE = T.ID_CLIENTE
WHERE SEXO = 'M';

+-----------+--------------+------+--------------------+------------+------------+------------+----------------+--------+------+-----------+
| IDCLIENTE | NOME         | SEXO | EMAIL              | CPF        | RUA        | BAIRRO     | CIDADE         | ESTADO | TIPO | NUMERO    |
+-----------+--------------+------+--------------------+------------+------------+------------+----------------+--------+------+-----------+
|         1 | JOÃO ALMEIDA | M    | JOAOGUI@GMAIL.COM  | 438473864  | DO VALE    | RENASCENÇA | SÃO LUÍS       | MA     | RES  | 94232032  |
|         3 | LUCAS PEDRO  | M    | NULL               | 9877233864 | DA VILLA   | CENTRO     | NITERÓI        | RJ     | COM  | 12782378  |
|         5 | IAGO ABAX    | M    | IGO@GMAIL.COM      | 232313864  | ANTONIO SÁ | CENTRO     | BELO HORIZONTE | MG     | CEL  | 87834394  |
|         5 | IAGO ABAX    | M    | IGO@GMAIL.COM      | 232313864  | ANTONIO SÁ | CENTRO     | BELO HORIZONTE | MG     | RES  | 92831232  |
|         9 | FLAVIO       | M    | FLAVIO@GMAIL.COM   | 5432313    | RUA GUEDES | CASCADURA  | B. HORIZONTE   | MG     | CEL  | 746377266 |
|        12 | KARLA        | M    | KARLA@GMAIL.COM    | 9889222    | RUA JORGE  | JARDINS    | CURITIBA       | PR     | CEL  | 873827827 |
|        13 | DANIELLE     | M    | DANIELLE@GMAIL.COM | 2837233    | RUA BOIADA | BOM RETIRO | CURITIBA       | PR     | COM  | 373121211 |
|        13 | DANIELLE     | M    | DANIELLE@GMAIL.COM | 2837233    | RUA BOIADA | BOM RETIRO | CURITIBA       | PR     | CEL  | 623562536 |
|        14 | LORENA       | M    | LORENA@GMAIL.COM   | 19283732   | AV DO REI  | CENTRO     | NITERÓI        | RJ     | RES  | 534223232 |
+-----------+--------------+------+--------------------+------------+------------+------------+----------------+--------+------+-----------+

/* CORRIGINDO A TABELA */
-- 12 13 14

SELECT * FROM CLIENTE
WHERE IDCLIENTE IN (12, 13, 14);

+-----------+----------+------+--------------------+----------+
| IDCLIENTE | NOME     | SEXO | EMAIL              | CPF      |
+-----------+----------+------+--------------------+----------+
|        12 | KARLA    | M    | KARLA@GMAIL.COM    | 9889222  |
|        13 | DANIELLE | M    | DANIELLE@GMAIL.COM | 2837233  |
|        14 | LORENA   | M    | LORENA@GMAIL.COM   | 19283732 |
+-----------+----------+------+--------------------+----------+

UPDATE CLIENTE SET SEXO = 'F'
WHERE IDCLIENTE IN (12, 13, 14);

+-----------+----------+------+--------------------+----------+
| IDCLIENTE | NOME     | SEXO | EMAIL              | CPF      |
+-----------+----------+------+--------------------+----------+
|        12 | KARLA    | F    | KARLA@GMAIL.COM    | 9889222  |
|        13 | DANIELLE | F    | DANIELLE@GMAIL.COM | 2837233  |
|        14 | LORENA   | F    | LORENA@GMAIL.COM   | 19283732 |
+-----------+----------+------+--------------------+----------+

/* RELATORIO DE MULHERES */

SELECT C.IDCLIENTE, C.NOME, C.SEXO, C.EMAIL, C.CPF, 
	E.RUA, E.BAIRRO, E.CIDADE, E.ESTADO, 
	T.TIPO, T.NUMERO
FROM CLIENTE C
INNER JOIN ENDERECO E 
ON IDCLIENTE = E.ID_CLIENTE
INNER JOIN TELEFONE T
ON IDCLIENTE = T.ID_CLIENTE
WHERE SEXO = 'F';

+-----------+------------+------+---------------------+-----------+-----------------+------------+-----------+--------+------+-----------+
| IDCLIENTE | NOME       | SEXO | EMAIL               | CPF       | RUA             | BAIRRO     | CIDADE    | ESTADO | TIPO | NUMERO    |
+-----------+------------+------+---------------------+-----------+-----------------+------------+-----------+--------+------+-----------+
|         2 | CLARA RUIZ | F    | CLARARUIZ@GMAIL.COM | 756533864 | DOM QUIXOTE     | FLORES     | SÃO PAULO | SP     | CEL  | 32038922  |
|         2 | CLARA RUIZ | F    | CLARARUIZ@GMAIL.COM | 756533864 | DOM QUIXOTE     | FLORES     | SÃO PAULO | SP     | RES  | 34243121  |
|        11 | GIOVANNA   | F    | NULL                | 2832983   | AV FAUSTO OLIVA | CENTRO     | SÃO LUÍS  | MA     | CEL  | 239232938 |
|        11 | GIOVANNA   | F    | NULL                | 2832983   | AV FAUSTO OLIVA | CENTRO     | SÃO LUÍS  | MA     | COM  | 653423232 |
|        12 | KARLA      | F    | KARLA@GMAIL.COM     | 9889222   | RUA JORGE       | JARDINS    | CURITIBA  | PR     | CEL  | 873827827 |
|        13 | DANIELLE   | F    | DANIELLE@GMAIL.COM  | 2837233   | RUA BOIADA      | BOM RETIRO | CURITIBA  | PR     | COM  | 373121211 |
|        13 | DANIELLE   | F    | DANIELLE@GMAIL.COM  | 2837233   | RUA BOIADA      | BOM RETIRO | CURITIBA  | PR     | CEL  | 623562536 |
|        14 | LORENA     | F    | LORENA@GMAIL.COM    | 19283732  | AV DO REI       | CENTRO     | NITERÓI   | RJ     | RES  | 534223232 |
+-----------+------------+------+---------------------+-----------+-----------------+------------+-----------+--------+------+-----------+

/* QUANTIDADE DE HOMENS E MULHERES */

SELECT COUNT(*) AS QUANTIDADE, SEXO
FROM CLIENTE
GROUP BY SEXO;

+------------+------+
| QUANTIDADE | SEXO |
+------------+------+
|          7 | M    |
|          6 | F    |
+------------+------+

/* IDS E EMAIL DAS MULHERES QUE MORAM NO CENTRO DE SÃO LUÍS E NÃO TENHAM CELULAR */
SELECT C.IDCLIENTE, C.EMAIL, C.NOME, C.SEXO
FROM CLIENTE C
INNER JOIN ENDERECO E
ON C.IDCLIENTE = E.ID_CLIENTE
INNER JOIN TELEFONE T
ON C.IDCLIENTE = T.ID_CLIENTE;

/*FILTRO*/
SELECT C.IDCLIENTE, C.EMAIL, C.NOME, C.SEXO
FROM CLIENTE C
INNER JOIN ENDERECO E
ON C.IDCLIENTE = E.ID_CLIENTE
INNER JOIN TELEFONE T
ON C.IDCLIENTE = T.ID_CLIENTE
WHERE SEXO = 'F'
AND BAIRRO = 'CENTRO' AND CIDADE = 'SÃO LUÍS';

+-----------+------------------+----------+------+
| IDCLIENTE | EMAIL            | NOME     | SEXO |
+-----------+------------------+----------+------+
|        11 | NULL             | GIOVANNA | F    |
|        11 | NULL             | GIOVANNA | F    |
|        16 | AMANDA@GMAIL.COM | AMANDA   | F    |
+-----------+------------------+----------+------+

SELECT C.IDCLIENTE, C.EMAIL, C.NOME, C.SEXO, T.TIPO
FROM CLIENTE C
INNER JOIN ENDERECO E
ON C.IDCLIENTE = E.ID_CLIENTE
INNER JOIN TELEFONE T
ON C.IDCLIENTE = T.ID_CLIENTE
WHERE SEXO = 'F'
AND BAIRRO = 'CENTRO' AND CIDADE = 'SÃO LUÍS';

+-----------+------------------+----------+------+------+
| IDCLIENTE | EMAIL            | NOME     | SEXO | TIPO |
+-----------+------------------+----------+------+------+
|        11 | NULL             | GIOVANNA | F    | CEL  |
|        11 | NULL             | GIOVANNA | F    | COM  |
|        16 | AMANDA@GMAIL.COM | AMANDA   | F    | RES  |
+-----------+------------------+----------+------+------+

SELECT C.IDCLIENTE, C.EMAIL, C.NOME, C.SEXO, T.TIPO, E.BAIRRO, E.CIDADE
FROM CLIENTE C
INNER JOIN ENDERECO E
ON C.IDCLIENTE = E.ID_CLIENTE
INNER JOIN TELEFONE T
ON C.IDCLIENTE = T.ID_CLIENTE
WHERE SEXO = 'F'
AND BAIRRO = 'CENTRO' AND CIDADE = 'SÃO LUÍS';

+-----------+------------------+----------+------+------+--------+----------+
| IDCLIENTE | EMAIL            | NOME     | SEXO | TIPO | BAIRRO | CIDADE   |
+-----------+------------------+----------+------+------+--------+----------+
|        11 | NULL             | GIOVANNA | F    | CEL  | CENTRO | SÃO LUÍS |
|        11 | NULL             | GIOVANNA | F    | COM  | CENTRO | SÃO LUÍS |
|        16 | AMANDA@GMAIL.COM | AMANDA   | F    | RES  | CENTRO | SÃO LUÍS |
+-----------+------------------+----------+------+------+--------+----------+

SELECT C.IDCLIENTE, C.EMAIL, C.NOME, C.SEXO, T.TIPO, E.BAIRRO, E.CIDADE
FROM CLIENTE C
INNER JOIN ENDERECO E
ON C.IDCLIENTE = E.ID_CLIENTE
INNER JOIN TELEFONE T
ON C.IDCLIENTE = T.ID_CLIENTE
WHERE SEXO = 'F'
AND BAIRRO = 'CENTRO' AND CIDADE = 'SÃO LUÍS'
AND (TIPO = 'RES' OR TIPO = 'COM'); /* Continua errado */

/*PARA UMA CAMPANHA DE MARKETING, O SETOR SOLICITOU UM RELATÓRIO
COM O NOME, EMAIL E TELEFONE CELULAR DOS CLIENTES QUE MORAM NO ESTADO DO PR
VOCÊ TERÁ QUE PASSAR A QUERY PARA GERAR O RELATÓRIO PARA O PROGRAMADOR*/

SELECT C.NOME, C.EMAIL, T.NUMERO AS CELULAR
FROM CLIENTE C
INNER JOIN ENDERECO E
ON C.IDCLIENTE = E.ID_CLIENTE
INNER JOIN TELEFONE T
ON C.IDCLIENTE = T.ID_CLIENTE
WHERE TIPO = 'CEL' AND ESTADO = 'PR';

/*PARA UMA CAMPANHA DE PRODUTOS DE BELEZA, O COMERCIAL SOLICITOU UM RELATÓRIO
COM O NOME, EMAIL E TELEFONE CELULAR DAS MULHERES QUE MORAM NO ESTADO DE SP
VOCÊ TERÁ QUE PASSAR A QUERY PARA GERAR O RELATÓRIO PARA O PROGRAMADOR*/

SELECT C.NOME, C.EMAIL, T.NUMERO AS CELULAR
FROM CLIENTE C
INNER JOIN ENDERECO E
ON C.IDCLIENTE = E.ID_CLIENTE
INNER JOIN TELEFONE T
ON C.IDCLIENTE = T.ID_CLIENTE
WHERE SEXO = 'F'
AND ESTADO = 'SP';

/* IFNULL */

/* NOME, EMAIL, NUMERO, ESTADO */
SELECT C.NOME, C.EMAIL, E.ESTADO, T.NUMERO
FROM CLIENTE C
INNER JOIN ENDERECO E
ON C.IDCLIENTE = E.ID_CLIENTE
INNER JOIN TELEFONE T
ON C.IDCLIENTE = T.ID_CLIENTE;

+--------------+---------------------+--------+-----------+
| NOME         | EMAIL               | ESTADO | NUMERO    |
+--------------+---------------------+--------+-----------+
| IAGO ABAX    | IGO@GMAIL.COM       | MG     | 87834394  |
| IAGO ABAX    | IGO@GMAIL.COM       | MG     | 92831232  |
| JOÃO ALMEIDA | JOAOGUI@GMAIL.COM   | MA     | 94232032  |
| CLARA RUIZ   | CLARARUIZ@GMAIL.COM | SP     | 32038922  |
| LUCAS PEDRO  | NULL                | RJ     | 12782378  |
| CLARA RUIZ   | CLARARUIZ@GMAIL.COM | SP     | 34243121  |
| FLAVIO       | FLAVIO@GMAIL.COM    | MG     | 746377266 |
| GIOVANNA     | NULL                | MA     | 239232938 |
| GIOVANNA     | NULL                | MA     | 653423232 |
| KARLA        | KARLA@GMAIL.COM     | PR     | 873827827 |
| DANIELLE     | DANIELLE@GMAIL.COM  | PR     | 373121211 |
| DANIELLE     | DANIELLE@GMAIL.COM  | PR     | 623562536 |
| LORENA       | LORENA@GMAIL.COM    | RJ     | 534223232 |
| AMANDA       | AMANDA@GMAIL.COM    | MA     | 983783728 |
+--------------+---------------------+--------+-----------+

SELECT C.NOME, 
	IFNULL(C.EMAIL, '*******'), 
	E.ESTADO, 
	T.NUMERO
FROM CLIENTE C
INNER JOIN ENDERECO E
ON C.IDCLIENTE = E.ID_CLIENTE
INNER JOIN TELEFONE T
ON C.IDCLIENTE = T.ID_CLIENTE;

+--------------+----------------------------+--------+-----------+
| NOME         | IFNULL(C.EMAIL, '*******') | ESTADO | NUMERO    |
+--------------+----------------------------+--------+-----------+
| IAGO ABAX    | IGO@GMAIL.COM              | MG     | 87834394  |
| IAGO ABAX    | IGO@GMAIL.COM              | MG     | 92831232  |
| JOÃO ALMEIDA | JOAOGUI@GMAIL.COM          | MA     | 94232032  |
| CLARA RUIZ   | CLARARUIZ@GMAIL.COM        | SP     | 32038922  |
| LUCAS PEDRO  | *******                    | RJ     | 12782378  |
| CLARA RUIZ   | CLARARUIZ@GMAIL.COM        | SP     | 34243121  |
| FLAVIO       | FLAVIO@GMAIL.COM           | MG     | 746377266 |
| GIOVANNA     | *******                    | MA     | 239232938 |
| GIOVANNA     | *******                    | MA     | 653423232 |
| KARLA        | KARLA@GMAIL.COM            | PR     | 873827827 |
| DANIELLE     | DANIELLE@GMAIL.COM         | PR     | 373121211 |
| DANIELLE     | DANIELLE@GMAIL.COM         | PR     | 623562536 |
| LORENA       | LORENA@GMAIL.COM           | RJ     | 534223232 |
| AMANDA       | AMANDA@GMAIL.COM           | MA     | 983783728 |
+--------------+----------------------------+--------+-----------+

SELECT C.NOME, 
	IFNULL(C.EMAIL, '*******') AS "E-MAIL", 
	E.ESTADO, 
	T.NUMERO
FROM CLIENTE C
INNER JOIN ENDERECO E
ON C.IDCLIENTE = E.ID_CLIENTE
INNER JOIN TELEFONE T
ON C.IDCLIENTE = T.ID_CLIENTE;

+--------------+---------------------+--------+-----------+
| NOME         | E-MAIL              | ESTADO | NUMERO    |
+--------------+---------------------+--------+-----------+
| IAGO ABAX    | IGO@GMAIL.COM       | MG     | 87834394  |
| IAGO ABAX    | IGO@GMAIL.COM       | MG     | 92831232  |
| JOÃO ALMEIDA | JOAOGUI@GMAIL.COM   | MA     | 94232032  |
| CLARA RUIZ   | CLARARUIZ@GMAIL.COM | SP     | 32038922  |
| LUCAS PEDRO  | *******             | RJ     | 12782378  |
| CLARA RUIZ   | CLARARUIZ@GMAIL.COM | SP     | 34243121  |
| FLAVIO       | FLAVIO@GMAIL.COM    | MG     | 746377266 |
| GIOVANNA     | *******             | MA     | 239232938 |
| GIOVANNA     | *******             | MA     | 653423232 |
| KARLA        | KARLA@GMAIL.COM     | PR     | 873827827 |
| DANIELLE     | DANIELLE@GMAIL.COM  | PR     | 373121211 |
| DANIELLE     | DANIELLE@GMAIL.COM  | PR     | 623562536 |
| LORENA       | LORENA@GMAIL.COM    | RJ     | 534223232 |
| AMANDA       | AMANDA@GMAIL.COM    | MA     | 983783728 |
+--------------+---------------------+--------+-----------+

/* VIEW - funciona como um ponteiro que aponta para a query*/

SELECT C.NOME, 
	C.SEXO, 
	C.EMAIL, 
	T.TIPO, 
	T.NUMERO, 
	E.BAIRRO, 
	E.CIDADE, 
	E.ESTADO
FROM CLIENTE C
INNER JOIN TELEFONE T
ON C.IDCLIENTE = T.ID_CLIENTE
INNER JOIN ENDERECO E
ON C.IDCLIENTE = E.ID_CLIENTE;


CREATE VIEW RELATORIO AS
SELECT C.NOME, 
	C.SEXO, 
	C.EMAIL, 
	T.TIPO, 
	T.NUMERO, 
	E.BAIRRO, 
	E.CIDADE, 
	E.ESTADO
FROM CLIENTE C
INNER JOIN TELEFONE T
ON C.IDCLIENTE = T.ID_CLIENTE
INNER JOIN ENDERECO E
ON C.IDCLIENTE = E.ID_CLIENTE;

SELECT * FROM RELATORIO;

+--------------+------+---------------------+------+-----------+------------+----------------+--------+
| NOME         | SEXO | EMAIL               | TIPO | NUMERO    | BAIRRO     | CIDADE         | ESTADO |
+--------------+------+---------------------+------+-----------+------------+----------------+--------+
| IAGO ABAX    | M    | IGO@GMAIL.COM       | CEL  | 87834394  | CENTRO     | BELO HORIZONTE | MG     |
| IAGO ABAX    | M    | IGO@GMAIL.COM       | RES  | 92831232  | CENTRO     | BELO HORIZONTE | MG     |
| JOÃO ALMEIDA | M    | JOAOGUI@GMAIL.COM   | RES  | 94232032  | RENASCENÇA | SÃO LUÍS       | MA     |
| CLARA RUIZ   | F    | CLARARUIZ@GMAIL.COM | CEL  | 32038922  | FLORES     | SÃO PAULO      | SP     |
| LUCAS PEDRO  | M    | NULL                | COM  | 12782378  | CENTRO     | NITERÓI        | RJ     |
| CLARA RUIZ   | F    | CLARARUIZ@GMAIL.COM | RES  | 34243121  | FLORES     | SÃO PAULO      | SP     |
| FLAVIO       | M    | FLAVIO@GMAIL.COM    | CEL  | 746377266 | CASCADURA  | B. HORIZONTE   | MG     |
| GIOVANNA     | F    | NULL                | CEL  | 239232938 | CENTRO     | SÃO LUÍS       | MA     |
| GIOVANNA     | F    | NULL                | COM  | 653423232 | CENTRO     | SÃO LUÍS       | MA     |
| KARLA        | F    | KARLA@GMAIL.COM     | CEL  | 873827827 | JARDINS    | CURITIBA       | PR     |
| DANIELLE     | F    | DANIELLE@GMAIL.COM  | COM  | 373121211 | BOM RETIRO | CURITIBA       | PR     |
| DANIELLE     | F    | DANIELLE@GMAIL.COM  | CEL  | 623562536 | BOM RETIRO | CURITIBA       | PR     |
| LORENA       | F    | LORENA@GMAIL.COM    | RES  | 534223232 | CENTRO     | NITERÓI        | RJ     |
| AMANDA       | F    | AMANDA@GMAIL.COM    | RES  | 983783728 | CENTRO     | SÃO LUÍS       | MA     |
+--------------+------+---------------------+------+-----------+------------+----------------+--------+


/* COMO LOCALIZAR AS VIEWS */
SHOW TABLES;

/*APAGANDO UMA VIEW */
DROP VIEW RELATORIO;

/* INSERINDO UM PREFIXO */

CREATE VIEW V_RELATORIO AS
SELECT C.NOME, 
	C.SEXO, 
	IFNULL(C.EMAIL, 'CLIENTE SEM EMAIL') AS "E-MAIL", 
	T.TIPO, 
	T.NUMERO, 
	E.BAIRRO, 
	E.CIDADE, 
	E.ESTADO
FROM CLIENTE C
INNER JOIN TELEFONE T
ON C.IDCLIENTE = T.ID_CLIENTE
INNER JOIN ENDERECO E
ON C.IDCLIENTE = E.ID_CLIENTE;


SELECT NOME, NUMERO, ESTADO
FROM V_RELATORIO;

/* OPERAÇÕES DE DML EM VIEWS */
INSERT INTO V_RELATORIO VALUES(
'ANDREIA', 'F', 'ANDREIA@UOL.COM.BR', 'CEL', '90328392', 'CENTRO', 'VITORIA', 'ES'
);

ERROR 1394 (HY000): Can not insert into join view 'comercio.v_relatorio' without fields list
/* não é possível fazer insert em views que contém join */

DELETE FROM V_RELATORIO WHERE NOME = 'JORGE';

ERROR 1395 (HY000): Can not delete from join view 'comercio.v_relatorio'
/* não é possível fazer insert em views que contém join */

UPDATE V_RELATORIO INSERT NOME = 'JOSE'  WHERE NOME = 'JORGE'     
/* É permitido fazer updates em views com join */   

SELECT * FROM V_RELATORIO
WHERE SEXO = 'F';            