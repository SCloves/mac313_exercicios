
-- Exercicio 1

CREATE SCHEMA "exercicio1";

/*
PESSOA(nusp, cpf, nome)
→ chave única: cpf 
*/

create table "exercicio1".PESSOA(
	nusp numeric(10,0),
	cpf numeric(12,0) primary key,
	nome varchar(100),
	 UNIQUE(nusp)
	);

/*
PROFESSOR(nusp_prof, sala)
→ chave estrangeira: nusp_prof referencia PESSOA.nusp
*/

create table "exercicio1".PROFESSOR(
	nusp_prof numeric(10,0) primary key
	REFERENCES "exercicio1".PESSOA ON DELETE CASCADE ON UPDATE CASCADE,
	sala varchar(5),
	FOREIGN KEY(nusp_prof) REFERENCES "exercicio1".PESSOA(nusp)
	);
	
-- ALUNO(id_aluno)

create table "exercicio1".ALUNO(
	id_aluno numeric(10,0) primary key
	)
	
/*
 ALUNO_REGULAR(nusp_aluno_reg, curso, nusp_prof, id_aluno)
→ chave estrangeira: nusp_aluno_reg referencia PESSOA.nusp
→ chave estrangeira: nusp_prof referencia PROFESSOR.nusp
→ chave estrangeira: id_aluno referencia ALUNO.id_aluno

O curso seja ‘Bacharelado em Computação’ sempre que o curso não for informado no cadastro
do aluno no BD;
*/
	
create table "exercicio1".ALUNO_REGULAR(
	nusp_aluno_reg numeric(10,0),
	curso varchar(40) default 'Bacharelado em Computação',
	nusp_prof numeric(10,0),
	id_aluno numeric(10,0),
	primary key(nusp_aluno_reg, nusp_prof, id_aluno),
	FOREIGN KEY(nusp_aluno_reg) REFERENCES "exercicio1".PESSOA(nusp)
		ON DELETE CASCADE ON UPDATE cascade,
	FOREIGN KEY(nusp_prof) REFERENCES "exercicio1".PROFESSOR(nusp_prof)
		ON DELETE CASCADE ON UPDATE cascade,
	FOREIGN KEY(id_aluno) REFERENCES "exercicio1".ALUNO(id_aluno)
		ON DELETE CASCADE ON UPDATE cascade
	)	

/*
 ALUNO_ESPECIAL(email, nome, id_aluno)
→ chave estrangeira: id_aluno referencia ALUNO.id_aluno
*/
	
create table "exercicio1".ALUNO_ESPECIAL(
	email varchar(100) primary key,
	nome varchar(100),
	id_aluno numeric(10,0),
	FOREIGN KEY(id_aluno) REFERENCES "exercicio1".ALUNO(id_aluno)
		ON DELETE CASCADE ON UPDATE cascade
	)

-- DISCIPLINA(código, nome)

create table "exercicio1".DISCIPLINA(
	codigo varchar(20) primary key,
	nome varchar(30)
	)
	
/*
 PRE_REQUISITO(cod_disc, cod_disc_pre_requisito)
→ chave estrangeira: cod_disc referencia DISCIPLINA.código
→ chave estrangeira: cod_disc_pre_requisito referencia DISCIPLINA.código
*/
	
create table "exercicio1".PRE_REQUISITO(
	cod_disc varchar(20),
	cod_disc_pre_requisito varchar(20),
	primary key (cod_disc, cod_disc_pre_requisito),
	FOREIGN KEY(cod_disc) REFERENCES "exercicio1".DISCIPLINA(codigo)
		ON DELETE CASCADE ON UPDATE cascade,
	FOREIGN KEY(cod_disc_pre_requisito) REFERENCES "exercicio1".DISCIPLINA(codigo)
		ON DELETE CASCADE ON UPDATE cascade
	)

/*
 MINISTRA(nusp_prof, cod_disc, semestre_ano)
→ chave estrangeira: nusp_prof referencia PROFESSOR.nusp
→ chave estrangeira: cod_disc referencia DISCIPLINA.código
 */
	
create table "exercicio1".MINISTRA(
	nusp_prof numeric(10,0),
	cod_disc varchar(20),
	semestre_ano varchar(10),
	primary key(nusp_prof, cod_disc, semestre_ano),
	FOREIGN KEY(nusp_prof) REFERENCES "exercicio1".PROFESSOR(nusp_prof)
		ON DELETE CASCADE ON UPDATE cascade,
	FOREIGN KEY(cod_disc) REFERENCES "exercicio1".DISCIPLINA(codigo)
		ON DELETE CASCADE ON UPDATE cascade
	)
	
/*
 MATRICULA(nusp_prof, cod_disc, semestre_ano, id_aluno, frequencia, nota,situacao)
 
A frequência de um aluno (em uma dada matrícula) seja sempre um número inteiro entre 0 e
100, enquanto a nota seja um número real entre 0 e 10 com até duas casas decimais;

A situação de um aluno (em uma dada matrícula), se cadastrada, seja sempre “reprovado”,
“aprovado” ou “em recuperação”;

Um aluno que tenha frequência menor que 75% ou nota menor que 5,00 não possa estar na
situação “aprovado”.
*/
	

create table "exercicio1".MATRICULA(
	nusp_prof numeric(10,0),
	cod_disc varchar(20),
	semestre_ano varchar(10),
	id_aluno numeric(10,0),
	frequencia numeric(3, 0),
	nota numeric(2, 0),
	situacao varchar(20),
	constraint chk_frequencia check (frequencia BETWEEN 0 AND 100),
	constraint chk_nota check(nota between 0 and 10),
	CONSTRAINT chk_Situacao CHECK (situacao IN ('reprovado', 'aprovado', 'em recuperação')),
	primary key(cod_disc, semestre_ano, id_aluno),
	FOREIGN KEY(nusp_prof) REFERENCES "exercicio1".PROFESSOR(nusp_prof)
		ON DELETE CASCADE ON UPDATE cascade,
	FOREIGN KEY(cod_disc) REFERENCES "exercicio1".DISCIPLINA(codigo)
		ON DELETE CASCADE ON UPDATE cascade,
	FOREIGN KEY(id_aluno) REFERENCES "exercicio1".ALUNO(id_aluno)
		ON DELETE CASCADE ON UPDATE cascade
	)

----------------------------------------------------------------------

-- Exercício 2

-- a) Liste os nomes dos agricultores de Mogi das Cruzes.

select 
	nomea 
from 
	exercicio2.agricultor
where 
	cidadea = 'Mogi das Cruzes';

/*
b) Liste todas as informações de todo produto cujo nome começa com as letras de “a” a “e” ou
cujo preço por quilo está entre R$2,00 e R$3,00.
*/

select 
	* 
from 
	exercicio2.produto
where 
	nomep SIMILAR TO '[a-e]%'
or
	precoquilo between 2.0 and 3.0;
	
/*
 c) Liste os códigos dos produtos que já foram entregues por agricultores de sobrenome
“Bandeira”.
 */
	
select 
	 DISTINCT codp 
from 
	exercicio2.entrega as ent
inner join
	exercicio2.agricultor as ag
on
	ent.coda = ag.coda
where 
	ag.nomea like '%Bandeira';

	
-- d) Liste os nomes dos restaurantes que já receberam entregas de cebola.

select 
	nomer
from 
	exercicio2.restaurante
where 
	codr in (select 
				distinct codr 
			from 
				exercicio2.entrega
			where 
				codp = 2003);
				
-- e) Liste os códigos dos agricultores que já entregaram cebolas e também já entregaram batatas.

select 
	distinct coda 
from 
	exercicio2.entrega
where 
	codp in (2002, 2003);
	
-- f) Liste os códigos dos agricultores que já entregaram cebolas, mas nunca entregaram batatas.

select 
	coda
from 
	(select 
		coda, count(codp) as n
	from 
		exercicio2.entrega
	where 
		codp in (2002, 2003)
	group by 
		coda) as tb1
where
	tb1.n = 1
and 
	coda in (select 
				distinct coda 
			from 
				exercicio2.entrega
			where 
				codp = 2003);

/* 
 g) Liste todas as triplas (código do agricultor, código do produto, código do restaurante) extraídas
de Entrega tais que o agricultor e o restaurante não estejam na mesma cidade.
 */
	
select 
	ent.coda, 
	ent.codp, 
	ent.codr
from 
	exercicio2.entrega as ent
left join
	exercicio2.agricultor as agr
on 
	ent.coda = agr.coda
left join
	exercicio2.restaurante as rest
on
	ent.codr = rest.codr
where
	agr.nomea != rest.nomer;

-- h) Obtenha a quantidade total em kg de produtos já entregues ao restaurante RU-USP.

select 
	sum(qtdequilos) 
from 
	exercicio2.entrega
where 
	codr = 3005;

-- i) Liste os nomes das cidades que tenham pelo menos dois agricultores.


select 
	cidade
from (select 
		cidadea as cidade, 
		count(coda) as n
	from 
		exercicio2.agricultor
	group by
		cidade) as tb
where
	n >= 2;
	
/*
 j) Obtenha o número de produtos que são fornecidos ou por um agricultor de São Paulo ou para
um restaurante em São Paulo.
 */
	
select 
	count(distinct ent.codp) 
from exercicio2.entrega as ent
left join
	exercicio2.agricultor as agr
on 
	ent.coda = agr.coda
left join
	exercicio2.restaurante as rest
on
	ent.codr = rest.codr
where
	cidadea = 'São Paulo'
or 
	cidader = 'São Paulo'

	
/*
  k) Obtenha pares do tipo (código do restaurante, código do produto) tais que o restaurante
indicado nunca tenha recebido o produto indicado.
 */

select 
	*
from 
	(select 
		codr,
		codp
	from 
		exercicio2.entrega
	order by 
		codr) as tb1
where (tb1.codr, tb1.codp)
not in
	(select 
			(codr, codp_ent) 
	from 
		(select 
				codr, 
				ent.codp as codp_ent, 
				prod.codp as codp_prod 
	     from 
				exercicio2.entrega as ent, 
				exercicio2.produto as prod
		 where 
				ent.codp = prod.codp
		 order by 
				codr) as tb)


/*
 l) Obtenha os códigos dos produtos e suas respectivas quantidades médias por entrega para os
produtos que nunca foram entregues em uma quantidade inferior a 20 quilos.
 */
				
select 
	codp, 
	AVG(qtdequilos) as media_qtdequilos
from 
	exercicio2.entrega
where 
	codp
not in 
		(select 
			codp
		from 
			exercicio2.entrega
		where 
			qtdequilos < 20
		order by codp)
group by
	codp
order by
	codp;
	
/*
 m) Obtenha o(s) nome(s) dos produtos mais fornecidos a restaurantes (ou seja, os produtos dos
quais as somas das quantidades já entregues é a maior possível).
 */

select * from 
(select 
	nomep, 
	sum(qtdequilos) as qtdequilos_soma 
from 
	(select 
		ent.codp, 
		nomep, 
		qtdequilos 
	from 
		exercicio2.entrega as ent
	left join 
		exercicio2.produto as prod
	on 
		ent.codp = prod.codp) as tb1
group by tb1.nomep) as tb4
where
	qtdequilos_soma = (select 
							max(qtdequilos_soma) 
						from
						   (select 
								nomep, 
								sum(qtdequilos) as qtdequilos_soma 
							from 
								(select 
									ent.codp, 
									nomep, 
									qtdequilos 
								from 
									exercicio2.entrega as ent
								left join 
									exercicio2.produto as prod
								on 
									ent.codp = prod.codp) as tb
								group by 
									nomep) as tb2)
									
/*
n) Obtenha o nome do(s) restaurante(es) que recebeu(receberam) a entrega de produtos mais
recente registrada no BD.
 */
									

select  
	nomer
from 
	exercicio2.entrega as ent
left join
	exercicio2.restaurante as rest
on
	ent.codr = rest.codr
where
	dataentrega = (select 
						dataentrega 
					from 
						exercicio2.entrega
					order by 
						dataentrega 
					desc
					limit 1)

/*
 o) Liste os nomes dos produtos que são oferecidos a todos os restaurantes do BD. Ou seja, um
produto não deve aparecer na lista se houver um restaurante que nunca o tenha recebido.
 */
					
select 
	nomep
from
	(select 
		distinct codp
	from 
		exercicio2.entrega
	order by 
		codp) as tb1
left join 
	exercicio2.produto as prod
on
	tb1.codp = prod.codp


/*
 p) Liste todos os pares possíveis do tipo (i,j) tal que i é o nome de um produto, j é o nome de um
agricultor que já entregou i. Mas atenção: o nome de todos os produtos cadastrados no BD deve
aparecer no conjunto resposta. Se um produto nunca foi entregue, então o seu nome deve vir
acompanhado de NULL no conjunto resposta. A resposta deve aparecer em ordem decrescente
de nome de produto.
 */

select 
	nomep,
	nomea
from 
	exercicio2.entrega as ent
right join
	exercicio2.produto as prod
on 
	ent.codp = prod.codp
left join
	exercicio2.agricultor as agr
on
	ent.coda = agr.coda
order by
	nomep











	





