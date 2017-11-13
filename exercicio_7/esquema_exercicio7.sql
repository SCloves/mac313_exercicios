-- Tabelas e dados para os exercícios 2 e 3

create table "exercicio2".Agricultor(
	CodA	integer	primary key,
	NomeA	varchar(30)	unique,
	CidadeA	varchar(20)
);

create table "exercicio2".Produto(
	CodP	integer	primary key,
	NomeP	varchar(20)	unique,
	PrecoQuilo numeric(6,2)
);

create table "exercicio2".Restaurante(
	CodR	integer	primary key,
	NomeR	varchar(20),
	CidadeR varchar(20));

create table "exercicio2".Entrega(
	CodA	integer	references Agricultor(CodA),
	CodP	integer	references Produto(CodP),
	CodR	integer	references Restaurante(CodR),
	DataEntrega	date,
	QtdeQuilos	integer,
	primary key (CodA, CodP, CodR));

insert into "exercicio2".Agricultor values (1001, 'Ana Maria Machado', 'Mogi das Cruzes');
insert into "exercicio2".Agricultor values (1002, 'José de Alencar', 'Mogi das Cruzes');
insert into "exercicio2".Agricultor values (1003, 'Manuel Bandeira', 'Mogi das Cruzes');
insert into "exercicio2".Agricultor values (1004, 'Machado de Assis', 'Atibaia');
insert into "exercicio2".Agricultor values (1005, 'Oswald de Andrade', 'Atibaia');
insert into "exercicio2".Agricultor values (1006, 'Lima Barreto', 'São Paulo');
insert into "exercicio2".Agricultor values (1007, 'Cecília Meireles', 'São Paulo');
insert into "exercicio2".Agricultor values (1008, 'Castro Alves', 'Campinas');
insert into "exercicio2".Agricultor values (1009, 'Monteiro Lobato', 'Taubaté');

insert into "exercicio2".Produto values (2001, 'tomate', 4.98);
insert into "exercicio2".Produto values (2002, 'batata', 0.98);
insert into "exercicio2".Produto values (2003, 'cebola', 2.98);
insert into "exercicio2".Produto values (2004, 'cenoura', 1.98);
insert into "exercicio2".Produto values (2005, 'chuchu', 2.49);
insert into "exercicio2".Produto values (2006, 'mandioca', 1.98);
insert into "exercicio2".Produto values (2007, 'couve-flor', 3.90);
insert into "exercicio2".Produto values (2008, 'quiabo', 8.98);
insert into "exercicio2".Produto values (2009, 'pimentão', 3.98);
insert into "exercicio2".Produto values (2010, 'repolho', 1.49);
insert into "exercicio2".Produto values (2011, 'beterraba', 2.49);
insert into "exercicio2".Produto values (2012, 'alface', 2.98);
insert into "exercicio2".Produto values (2013, 'tomate cereja', 5.98);

insert into "exercicio2".Restaurante values (3001, 'Brasileirinho', 'São Paulo');
insert into "exercicio2".Restaurante values (3002, 'Sabor de Minas', 'Santo André');
insert into "exercicio2".Restaurante values (3003, 'Bom Gosto', 'Atibaia');
insert into "exercicio2".Restaurante values (3004, 'Panela de Ouro', 'São Paulo');
insert into "exercicio2".Restaurante values (3005, 'RU-USP', 'São Paulo');
insert into "exercicio2".Restaurante values (3006, 'Bom de Garfo', 'Osasco');
insert into "exercicio2".Restaurante values (3007, 'Sabores do Interior', 'Osasco');
insert into "exercicio2".Restaurante values (3008, 'Brasil a Gosto', 'São Caetano');
insert into "exercicio2".Restaurante values (3009, 'Prato-Cheio', 'Diadema');
insert into "exercicio2".Restaurante values (3010, 'A Todo Sabor', 'Mogi das Cruzes');

insert into "exercicio2".Entrega values (1001,2005,3010,'2014-10-01', 15);
insert into "exercicio2".Entrega values (1004,2002,3005,'2014-10-01', 40);
insert into "exercicio2".Entrega values (1006,2011,3002,'2014-10-03', 37);
insert into "exercicio2".Entrega values (1003,2003,3009,'2014-10-03', 21);
insert into "exercicio2".Entrega values (1004,2008,3008,'2014-10-04', 12);
insert into "exercicio2".Entrega values (1007,2008,3003,'2014-10-04', 45);
insert into "exercicio2".Entrega values (1005,2002,3002,'2014-10-04', 60);
insert into "exercicio2".Entrega values (1005,2001,3002,'2014-10-05', 36);
insert into "exercicio2".Entrega values (1002,2002,3010,'2014-10-05', 28);
insert into "exercicio2".Entrega values (1002,2007,3006,'2014-10-06', 15);
insert into "exercicio2".Entrega values (1004,2010,3006,'2014-10-08', 52);
insert into "exercicio2".Entrega values (1007,2003,3004,'2014-10-10', 45);
insert into "exercicio2".Entrega values (1002,2005,3002,'2014-10-10', 38);
insert into "exercicio2".Entrega values (1002,2003,3004,'2014-10-10', 35);
insert into "exercicio2".Entrega values (1004,2005,3002,'2014-10-10', 25);
insert into "exercicio2".Entrega values (1005,2011,3002,'2014-10-14', 30);
insert into "exercicio2".Entrega values (1001,2003,3002,'2014-10-17', 57);
insert into "exercicio2".Entrega values (1003,2002,3010,'2014-10-18', 10);
insert into "exercicio2".Entrega values (1003,2012,3006,'2014-10-18', 36);
insert into "exercicio2".Entrega values (1007,2007,3006,'2014-10-19', 42);
insert into "exercicio2".Entrega values (1006,2003,3001,'2014-10-22', 28);
insert into "exercicio2".Entrega values (1002,2003,3003,'2014-10-22', 45);
insert into "exercicio2".Entrega values (1001,2003,3005,'2014-10-22', 37);
insert into "exercicio2".Entrega values (1007,2003,3006,'2014-10-22', 51);
insert into "exercicio2".Entrega values (1003,2003,3007,'2014-10-22', 24);
insert into "exercicio2".Entrega values (1003,2003,3008,'2014-10-22', 36);
insert into "exercicio2".Entrega values (1004,2003,3010,'2014-10-22', 40);
