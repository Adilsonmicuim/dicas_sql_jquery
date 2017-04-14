/*
 *Este script � complemento do artigo "Postgresql - Exemplo CASE WHEN"
 *Exemplo de "CASE WHEN ANINHADO", ou seja, um case when dentro de outro case when
 *Veja o Link em:
  http://jquerydicas.blogspot.com.br/2013/10/postgresql-exemplo-case-when.html
*/

/*CRIA��O DE UMA TABELA*/

CREATE TABLE TB_NOTA
(
  id serial,
  sexo varchar(1),
  nota numeric (5,2)
);

/*INCLUS�O DE DADOS NA TABELA*/

INSERT INTO TB_NOTA (sexo, nota) VALUES ('F',  9.00);
INSERT INTO TB_NOTA (sexo, nota) VALUES ('F',  8.50);
INSERT INTO TB_NOTA (sexo, nota) VALUES ('F',  6.40);
INSERT INTO TB_NOTA (sexo, nota) VALUES ('F',  4.20);
INSERT INTO TB_NOTA (sexo, nota) VALUES ('F',  10.0);
INSERT INTO TB_NOTA (sexo, nota) VALUES ('F',  8.50);
INSERT INTO TB_NOTA (sexo, nota) VALUES ('F',  6.40);
INSERT INTO TB_NOTA (sexo, nota) VALUES ('F',  4.20);
INSERT INTO TB_NOTA (sexo, nota) VALUES ('M', 10.00);
INSERT INTO TB_NOTA (sexo, nota) VALUES ('M',  8.25);
INSERT INTO TB_NOTA (sexo, nota) VALUES ('M',  7.40);
INSERT INTO TB_NOTA (sexo, nota) VALUES ('M',  6.20);
INSERT INTO TB_NOTA (sexo, nota) VALUES ('M',   3.5);
INSERT INTO TB_NOTA (sexo, nota) VALUES ('M',   2.5);


/*EXEMPLO DO SELECT COM CASE WHEN ANINHADO, OU SEJA COM MAIS DE UMA CONDI��O */

/*Neste exemplo, classificaremos os alunos de acordo com o sexo e com a nota*/

SELECT
id,
sexo, 
nota,
CASE                                                   
    /*Quando a nota for maior ou igual que 9*/
    WHEN (nota >= 9) THEN 
        CASE
	    /*Quando o sexo for feminino*/ 
            WHEN (sexo = 'F') THEN 
	            'Garota voc� tirou uma �tima nota'
	    /*Quando o sexo for masculino*/ 
	        WHEN (sexo = 'M') THEN
	            'Garoto voc� tirou uma �tima nota'
        END
    WHEN (nota >= 8) THEN 
        CASE
	    /*Quando o sexo for feminino*/ 
            WHEN (sexo = 'F') THEN 
	        'Garota voc� tirou uma Boa nota'
	    /*Quando o sexo for masculino*/ 
	    WHEN (sexo = 'M') THEN
	        'Garoto voc� tirou uma Boa nota'
        END
    WHEN (nota >= 5) THEN 
        CASE
	    /*Quando o sexo for feminino*/ 
            WHEN (sexo = 'F') THEN 
	        'Garota voc� tirou uma nota Regular'
	    /*Quando o sexo for masculino*/ 
	    WHEN (sexo = 'M') THEN
	        'Garoto voc� tirou uma nota Regular'
        END
    ELSE
        CASE
	    /*Quando o sexo for feminino*/ 
            WHEN (sexo = 'F') THEN 
	        'Garota voc� tirou uma nota Ruim'
	    /*Quando o sexo for masculino*/ 
	    WHEN (sexo = 'M') THEN
	        'Garoto voc� tirou uma nota Ruim'
        END 
END AS classificacao_nota
FROM TB_NOTA;


/*****************************RESULTADO DO SELECT********************************/

id	sexo	nota	classificacao_nota
114	F	9	Garota voc� tirou uma �tima nota
115	F	8.5	Garota voc� tirou uma Boa nota
116	F	6.4	Garota voc� tirou uma nota Regular
117	F	4.2	Garota voc� tirou uma nota Ruim
118	F	10	Garota voc� tirou uma �tima nota
119	F	8.5	Garota voc� tirou uma Boa nota
120	F	6.4	Garota voc� tirou uma nota Regular
121	F	4.2	Garota voc� tirou uma nota Ruim
122	M	10	Garoto voc� tirou uma �tima nota
123	M	8.25	Garoto voc� tirou uma Boa nota
124	M	7.4	Garoto voc� tirou uma nota Regular
125	M	6.2	Garoto voc� tirou uma nota Regular
126	M	3.5	Garoto voc� tirou uma nota Ruim
127	M	2.5	Garoto voc� tirou uma nota Ruim
/******************************************************************************/