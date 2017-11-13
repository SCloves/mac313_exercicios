/*
a) Uma visão ExecutivoRico que fornece o nome, endereço, número do certificado e patrimônio de
todos os executivos com um patrimônio de pelo menos R$120.000.000,00.
*/

create view ExecutivoRico as
select nome, endereco, num_certificado from executivodecinema
where patrimonio >= 120000000

select * from ExecutivoRico

/*
b) Uma visão PresidenteEstudio que fornece o nome, endereço e número do certificado de todos os
executivos que são presidentes de estúdios.
*/

create view PresidenteEstudio as
(select executivodecinema.nome, 
	   executivodecinema.endereco, 
	   executivodecinema.num_certificado 
from executivodecinema 
inner join estudio 
on executivodecinema.num_certificado = estudio.num_certificado_presidente)

select * from PresidenteEstudio

/*
 c) Uma visão ExecutivoEstrela que fornece o nome, endereço, sexo, data de nascimento, número de
certificado e patrimônio de todos os indivíduos que são, ao mesmo tempo, executivos e estrelas.
*/

create view ExecutivoEstrela as
select estreladecinema.nome,
	  estreladecinema.endereco,
	  estreladecinema.sexo,
	  estreladecinema.data_nascimento,
	  executivodecinema.num_certificado,
	  executivodecinema.patrimonio
from estreladecinema
inner join executivodecinema
on estreladecinema.nome = executivodecinema.nome

select * from ExecutivoEstrela

--Exercício 2: Quais das funções do Exercício 1 são atualizáveis? Justifique sua resposta.

/* Resposta:

A questão a) pois envolve a visão em cima de uma única tabela e a 
questão b) pois envolve a visão em cima de uma relação.
*/

-- Exercício 3: Usando as visões criadas no Exercício 1, escreva consultas SQL para:

--a) Encontrar os nomes das mulheres que são, ao mesmo tempo, executivas e estrelas.

select nome from ExecutivoEstrela
where sexo = 'F';

/* b) Encontrar os nomes de executivos que são presidentes de estúdio e têm patrimônio de pelo
menos R$120.000.000,00.
*/

select ExecutivoRico.nome from ExecutivoRico
inner join PresidenteEstudio
on ExecutivoRico.nome = PresidenteEstudio.nome

/*c) Encontrar os nomes de presidentes de estúdio que são estrelas e têm patrimônio de pelo menos
R$150.000.000,00.*/

/*
 Exercício 4:
a) Defina uma visão que dê, para cada estrela de cinema que tenha atuado em um filme da década
de 70, o nome da estrela, sua data de nascimento, o título do filme, o ano do filme e a sua duração.*/
 
create view EstrelaAnos70 as
select nome_estrela,
	data_nascimento,
	titulo_filme,
	ano_filme,
	duracao
from  elencodefilme
inner join estreladecinema
on estreladecinema.nome = elencodefilme.nome_estrela
inner join filme
on elencodefilme.titulo_filme = filme.titulo
where ano_filme between 1970 and 1979;

select * from EstrelaAnos70

/*
 b) Escreva uma consulta usando a visão do item (a) que devolva, para cada estrela de filmes da
década de 70 que atualmente tenha(ou teria) menos de 60 anos, o seu nome e a sua idade. Dica: use
a função now() para pegar a data atual ou a função age(<data>) para pegar o tempo (em anos, meses
e dias) que se passou desde <data>.
*/

select EstrelaAnos70.nome_estrela,
	   EXTRACT(year from age(EstrelaAnos70.data_nascimento)) as idade
from EstrelaAnos70
where EXTRACT(year from age(EstrelaAnos70.data_nascimento)) >= 60;


