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

