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











	


