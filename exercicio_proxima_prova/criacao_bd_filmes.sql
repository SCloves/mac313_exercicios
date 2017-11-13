CREATE SCHEMA exercicio8;

SET SEARCH_PATH TO exercicio8;

----- Create Tables -----

CREATE TABLE exercicio8.Filme (
 titulo VARCHAR(255) NOT NULL,
 ano INTEGER NOT NULL,
 duracao INTEGER,
 colorido CHAR(1),
 nome_estudio CHAR(50),
 num_certificado_produtor INTEGER
);

CREATE TABLE exercicio8.EstrelaDeCinema (
 nome CHAR(30) NOT NULL,
 endereco VARCHAR(255),
 sexo CHAR(1),
 data_nascimento TIMESTAMP WITH TIME ZONE
);

CREATE TABLE exercicio8.ElencoDeFilme (
    titulo_filme VARCHAR(255) NOT NULL,
    ano_filme INTEGER NOT NULL,
    nome_estrela CHAR(30) NOT NULL
);

CREATE TABLE exercicio8.ExecutivoDeCinema (
    num_certificado INTEGER NOT NULL,
    nome CHAR(30),
    endereco VARCHAR(255),
    patrimonio INTEGER
);

CREATE TABLE exercicio8.Estudio (
    nome CHAR(50) NOT NULL,
    endereco VARCHAR(255),
    num_certificado_presidente INTEGER
);

----- Create Constraints -----
ALTER TABLE exercicio8.Filme ADD CONSTRAINT PK_Filme PRIMARY KEY(titulo,ano);

ALTER TABLE exercicio8.EstrelaDeCinema ADD CONSTRAINT PK_EstrelaDeCinema PRIMARY KEY(nome);

ALTER TABLE exercicio8.ExecutivoDeCinema ADD CONSTRAINT PK_ExecutivoDeCinema PRIMARY KEY(num_certificado);

ALTER TABLE exercicio8.Estudio ADD CONSTRAINT PK_Estudio PRIMARY KEY(nome);

ALTER TABLE exercicio8.ElencoDeFilme ADD CONSTRAINT PK_ElencoDeFilme PRIMARY KEY(titulo_filme,ano_filme,nome_estrela);

ALTER TABLE exercicio8.Filme ADD CONSTRAINT FK_Filme_ExecutivoDeCinema FOREIGN KEY(num_certificado_produtor) REFERENCES ExecutivoDeCinema(num_certificado);

ALTER TABLE exercicio8.Filme ADD CONSTRAINT FK_Filme_Estudio FOREIGN KEY(nome_estudio) REFERENCES Estudio(nome);

ALTER TABLE exercicio8.ElencoDeFilme ADD CONSTRAINT FK_ElencoDeFilme_Filme FOREIGN KEY(titulo_filme, ano_filme) REFERENCES Filme(titulo, ano);

ALTER TABLE exercicio8.ElencoDeFilme ADD CONSTRAINT FK_ElencoDeFilme_EstrelaDeCinema FOREIGN KEY(nome_estrela) REFERENCES EstrelaDeCinema(nome);

------- Insert Estudio ------------
INSERT INTO exercicio8.Estudio
  VALUES ('Disney','500 S. Buena Vista Street',555);

INSERT INTO exercicio8.Estudio
  VALUES ('USA Entertainm.','', 777);

INSERT INTO exercicio8.Estudio
  VALUES ('Fox','10201 Pico Boulevard', 222);

INSERT INTO exercicio8.Estudio
  VALUES ('Paramount','5555 Melrose Ave', 111);

INSERT INTO exercicio8.Estudio
  VALUES ('MGM','MGM Boulevard', 123);
  
------- Insert ExecutivoDeCinema ------------  
INSERT INTO exercicio8.ExecutivoDeCinema (nome, endereco, num_certificado, patrimonio)
  VALUES ('George Lucas', '90 Oak Rd.', 555, 200000000);

INSERT INTO exercicio8.ExecutivoDeCinema (nome, endereco, num_certificado, patrimonio)
  VALUES ('Ted Turner', '23 Turner Av.', 333, 125000000);

INSERT INTO exercicio8.ExecutivoDeCinema (nome, endereco, num_certificado, patrimonio)
  VALUES ('Stephen Spielberg', '123 ET road', 222, 100000000);

INSERT INTO exercicio8.ExecutivoDeCinema (nome, endereco, num_certificado, patrimonio)
  VALUES ('Merv Griffin', '867 Riot Rd.', 444, 112000000);

INSERT INTO exercicio8.ExecutivoDeCinema (nome, endereco, num_certificado, patrimonio)
  VALUES ('Jack Nicholson', 'One Washington Square', 888, 20000000);

INSERT INTO exercicio8.ExecutivoDeCinema (nome, endereco, num_certificado, patrimonio)
  VALUES ('Sandra Bullock', '456 5th Street', 111, 175000000);

------- Insert Filme ------------
INSERT INTO exercicio8.Filme
  VALUES ('Pretty Woman', 1990, 119, 'Y', 'Disney', 444);

INSERT INTO exercicio8.Filme
  VALUES ('The Man Who Wasn''t There', 2001, 116, 'N', 'USA Entertainm.',
    555);

INSERT INTO exercicio8.Filme
  VALUES ('Logan''s run', 1976, NULL, 'Y', 'Fox', 333);

INSERT INTO exercicio8.Filme
  VALUES ('Star Wars', 1977, 124, 'Y', 'Fox', 555);

INSERT INTO exercicio8.Filme
  VALUES ('Empire Strikes Back', 1980, 111, 'Y', 'Fox', 555);

INSERT INTO exercicio8.Filme
  VALUES ('Star Trek', 1979, 132, 'Y', 'Paramount', 222);

INSERT INTO exercicio8.Filme
  VALUES ('Star Trek: Nemesis', 2002, 116, 'Y', 'Paramount', 888);

INSERT INTO exercicio8.Filme
  VALUES ('Terms of Endearment', 1983, 132, 'Y', 'MGM', 888);

INSERT INTO exercicio8.Filme
  VALUES ('The Usual Suspects', 1995, 106, 'Y', 'MGM', 444);

INSERT INTO exercicio8.Filme
  VALUES ('Gone With the Wind', 1938, 238, 'Y', 'MGM', 888);

------- Insert EstrelaDeCinema ------------

INSERT INTO exercicio8.EstrelaDeCinema
  VALUES ('Jane Fonda', 'Turner Av.', 'F', '1977-07-07');

INSERT INTO exercicio8.EstrelaDeCinema
  VALUES ('Alec Baldwin', 'Baldwin Av.', 'M', '1977-07-06');

INSERT INTO exercicio8.EstrelaDeCinema
  VALUES ('Kim Basinger', 'Baldwin Av.', 'F', '1979-07-05');

INSERT INTO exercicio8.EstrelaDeCinema
  VALUES ('Harrison Ford', 'Prefect Rd.', 'M', '1955-05-05');

INSERT INTO exercicio8.EstrelaDeCinema
  VALUES ('Debra Winger', 'A way', 'F', '1978-06-05');

INSERT INTO exercicio8.EstrelaDeCinema
  VALUES ('Jack Nicholson', 'One Washington Square', 'M', '1949-05-05');
  
INSERT INTO exercicio8.EstrelaDeCinema
  VALUES ('Sandra Bullock', '456 5th Street', 'F', '1948-12-05');

------- Insert ElencoDeFilme ------------
INSERT INTO exercicio8.ElencoDeFilme
  VALUES ('Star Wars', 1977, 'Kim Basinger');

INSERT INTO exercicio8.ElencoDeFilme
  VALUES ('Star Wars', 1977, 'Alec Baldwin');

INSERT INTO exercicio8.ElencoDeFilme
  VALUES ('Star Wars', 1977, 'Harrison Ford');

INSERT INTO exercicio8.ElencoDeFilme
  VALUES ('Empire Strikes Back', 1980, 'Harrison Ford');

INSERT INTO exercicio8.ElencoDeFilme
  VALUES ('The Usual Suspects', 1995, 'Jack Nicholson');

INSERT INTO exercicio8.ElencoDeFilme
  VALUES ('Terms of Endearment', 1983, 'Jane Fonda');

INSERT INTO exercicio8.ElencoDeFilme
  VALUES ('Terms of Endearment', 1983, 'Jack Nicholson');

INSERT INTO exercicio8.ElencoDeFilme
  VALUES ('The Usual Suspects', 1995, 'Sandra Bullock');
