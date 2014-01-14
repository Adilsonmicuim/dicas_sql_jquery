/**
* IMPORTANTE!!!
* DESCOMENTE O SCRIPT ABAIXO SOMENTE SE DESEJAR EXCLUIR A TABELA tb_fornecedor
*/
/*DROP TABLE IF EXISTS tb_fornecedor;*/


/**
*Cria a tabela tb_fornecedor.
*/
CREATE TABLE tb_fornecedor
(
    produto character varying(70), 
    segmento character varying(70),
    data date,
    valor numeric
);


/**
*Inclui os dados na tabela tb_fornecedor.
*/
INSERT INTO tb_fornecedor VALUES('DVD', 'Papelaria e inform�tica', '2013-09-12', 2.00);
INSERT INTO tb_fornecedor VALUES('HD 500 GB', 'Papelaria e inform�tica', '2013-10-20', 300.00);
INSERT INTO tb_fornecedor VALUES('Tonner', 'Papelaria e inform�tica', '2013-11-01', 250.00);
INSERT INTO tb_fornecedor VALUES('Cadeira', 'Marcenaria', '2013-09-19', 50.00);
INSERT INTO tb_fornecedor VALUES('Mesa', 'Marcenaria', '2013-10-21', 600.00);
INSERT INTO tb_fornecedor VALUES('Arm�rio', 'Marcenaria', '2013-11-02', 900.00);
INSERT INTO tb_fornecedor VALUES('Corrim�o', 'Serralheria', '2013-09-12', 400.00);
INSERT INTO tb_fornecedor VALUES('Port�o', 'Serralheria', '2013-10-22', 1500.00);
INSERT INTO tb_fornecedor VALUES('Grade de prote��o para janela', 'Serralheria', '2013-11-03', 800.00);
INSERT INTO tb_fornecedor VALUES('Detergente', 'Limpeza e higi�ne', '2013-09-20', 5.00);
INSERT INTO tb_fornecedor VALUES('Desinfetante', 'Limpeza e higi�ne', '2013-11-23', 40.00);
INSERT INTO tb_fornecedor VALUES('Papel toalha', 'Limpeza e higi�ne', '2013-11-04', 60.00);

/**
*Exibe os dados da tabela tb_fornecedor.
*/
SELECT produto, valor, segmento, data FROM tb_fornecedor;


/*1� Exemplo*/

/*calcular o valor total das despesas*/
SELECT SUM(valor) FROM tb_fornecedor;

/*calcular o valor total das despesas e exibir o nome da coluna como total (alias)*/
SELECT SUM(valor) AS total FROM tb_fornecedor;


/*2� Exemplo*/

/* calcular o valor total das despesas por seguimento */

SELECT segmento, SUM(valor) AS total
FROM tb_fornecedor 
GROUP BY segmento;

/* calcular o valor total das despesas por seguimento em ordem crescente */
SELECT
segmento, 
SUM(valor) AS total 
FROM tb_fornecedor 
GROUP BY segmento
ORDER BY total;

/* calcular o valor total das despesas por seguimento em ordem decrescente */
SELECT
segmento, 
SUM(valor) AS total 
FROM tb_fornecedor
GROUP BY segmento
ORDER BY total DESC;


/*3� Exemplo*/

/*Cria a coluna quantidade*/
ALTER TABLE tb_fornecedor ADD COLUMN quantidade SMALLINT UNSIGNED AFTER produto;

/*Atualiza os valores da coluna quantidade*/

UPDATE tb_fornecedor SET quantidade = 10 WHERE produto = 'DVD' ;
UPDATE tb_fornecedor SET quantidade =  2 WHERE produto = 'HD 500 GB';
UPDATE tb_fornecedor SET quantidade =  2 WHERE produto = 'Tonner';
UPDATE tb_fornecedor SET quantidade =  3 WHERE produto = 'Cadeira';
UPDATE tb_fornecedor SET quantidade =  1 WHERE produto = 'Mesa';
UPDATE tb_fornecedor SET quantidade =  1 WHERE produto = 'Arm�rio';
UPDATE tb_fornecedor SET quantidade =  1 WHERE produto = 'Corrim�o';
UPDATE tb_fornecedor SET quantidade =  1 WHERE produto = 'Port�o';
UPDATE tb_fornecedor SET quantidade =  2 WHERE produto = 'Grade de prote��o para janela';
UPDATE tb_fornecedor SET quantidade =  3 WHERE produto = 'Detergente';
UPDATE tb_fornecedor SET quantidade =  5 WHERE produto = 'Desinfetante';
UPDATE tb_fornecedor SET quantidade =  2 WHERE produto = 'Papel toalha';


/*Exibe os registros ap�s a cria��o da coluna quantidade*/
SELECT * FROM tb_fornecedor;


/*Calcula as despesas por segmento, mas agora considerando a quantidade de produtos.*/
SELECT
segmento, 
SUM(quantidade * valor) AS total 
FROM tb_fornecedor 
GROUP BY segmento
ORDER BY total;

/*4� Exemplo*/

/*Exemplo da utiliza��o de extract*/
SELECT
data, 
extract(month from data) AS mes,
extract(year from data) AS ano
FROM tb_fornecedor;

/*Calcula o total das despesas por m�s*/
SELECT
extract(month from data) AS mes,
SUM(quantidade * valor) AS total 
FROM tb_fornecedor
WHERE extract(year from data) = 2013 
GROUP BY mes
ORDER BY mes;


/*Configura localmente a vari�vel de sistema para portugu�s - BR*/
SET LOCAL lc_time_names='pt_BR';


/*Calcular o total das despesas por m�s(extenso)*/

SELECT
/*Formata a data em portugu�s devido a configura��o da vari�vel de sistema do mysql chamada "lc_time_names". Em caso de d�vida veja o artigo de formata��o de data*/
date_format(data, '%M/%Y') AS mes, 
SUM(quantidade * valor) AS total 
FROM tb_fornecedor
WHERE extract(year FROM data) = 2013 
GROUP BY  mes
/*Orderna pela ordem num�rica do m�s (...9,10, 11)* observe o "m" do date_format em min�sculo*/ 
ORDER BY date_format(data, '%m/%Y') ;


/*5� Exemplo*/

/*Calcula o total das despesas por m�s e por segmento.*/
SELECT
extract(month FROM data)  AS mes,
segmento, 
SUM(quantidade * valor) AS total 
FROM tb_fornecedor
WHERE extract(year FROM data) = 2013 
GROUP BY mes, segmento
ORDER BY mes, segmento;


/*Calcula o total das despesas por m�s(extenso) e por segmento.*/
SELECT
/*Formata a data em portugu�s devido a configura��o da vari�vel de sistema do mysql chamada "lc_time_names". Em caso de d�vida veja o artigo de formata��o de data*/ 
date_format(data, '%M/%Y') AS mes, 
segmento, 
SUM(quantidade * valor) AS total 
FROM tb_fornecedor
WHERE extract(year FROM data) = 2013 
GROUP BY mes,  segmento
/*
Orderna pela ordem num�rica do m�s (...9,10, 11)* observe o "m"do date_format
em min�sculo
*/
ORDER BY date_format(data, '%m/%Y'), segmento;


/*6� Exemplo*/
/*
Seleciona quais os meses em que as despesas ultrapassaram R$2000, ou seja,
foram maior que R$2000?
*/

SELECT
/*Formata a data em portugu�s devido a configura��o da vari�vel de sistema do mysql chamada "lc_time_names". Em caso de d�vida veja o artigo de formata��o de data*/ 
date_format(data, '%M/%Y') AS mes,
SUM(quantidade * valor) AS total 
FROM tb_fornecedor
WHERE extract(year FROM data) = 2013 
GROUP BY mes  
HAVING SUM(quantidade * valor) > 2000
/*Orderna pela ordem num�rica do m�s (...9,10, 11)* observe o "m" do date_format em min�sculo*/ 
ORDER BY date_format(data, '%m/%Y');












