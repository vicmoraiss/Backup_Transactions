create database biblioteca;
use biblioteca;

create table autor(
idAutor int auto_increment primary key,
Nome varchar(45),
Sobrenome varchar(45),
nacionalidade varchar(45)
);

create table editora(
idEditora int auto_increment primary key,
razaoSocial varchar(45),
CNPJ varchar(13),
Endereco varchar(45)
);

create table livro(
idLivro int auto_increment primary key,
titulo varchar(45),
ISBN int(13),
Situação enum('Indisponivel','Disponivel'),
dtPublicacao varchar(12),
codAutor int,
codEditora int,
constraint fk_editora foreign key (codEditora) references editora(idEditora),
constraint fk_autor foreign key (codAutor) references autor(idAutor)
);

create table locador(
idLocador int auto_increment primary key,
Nome varchar(45),
CPF varchar(11),
endereco varchar(45)
);

create table emprestimo(
idEmprestimo int auto_increment primary key,
livro int,
locador int,
situacao enum('Emprestimo','Devolvido'),
dtEmprestimo varchar(10),
dtDevolucao varchar(10) default null,
constraint fk_locador foreign key(locador) references locador(idLocador),
constraint fk_livro_emp foreign key(livro) references livro(idLivro)
);
-- inserindon dados
-- autor
insert into autor(idAutor,Nome,Sobrenome ,nacionalidade) values 
	(1,'Albert','Camus','Frances/Argelia'),
    (2,'Jean-Paul','Sartre','Frances'),
    (3,'Erasmo','de Roterdam','Holandes'),
    (4,'Epicteto','Epicteto','Grego'),
    (5,'Neil','Gaiman','Ingles');
    
-- editora    
insert into editora(idEditora,razaoSocial,CNPJ,Endereco) values
		(1,'Intriseca','110022','R.Independencia'),
        (2,'Sextante','110033','R.15 de Novembro'),
        (3,'Aleph','110044','R. 7 de setembro'),
        (4,'Cia das Letras','110055','R.Independencia'),
        (5,'Arqueiro','110066','R. Bahia');
        
-- livros
insert into livro (idLivro,titulo,ISBN,Situação,dtPublicacao,codAutor,codEditora) values
		(1,'O mito de sisifo',0000,'Disponivel',2020,1,1),
        (2,'O elogio da Loucura',1111,'Disponivel',2019,3,4),
        (3,'A arte de viver',2222,'Disponivel',2018,4,1),
        (4,'Mitologia Nordica',3333,'Indisponivel',2020,5,1),
        (5,'A peste',4444,'Indisponivel',2021,1,2);
        
        
-- locador
insert into locador (idLocador,Nome,CPF,endereco) values
		(1,'Caio',5656,'R dos Bobos'),
        (2,'Vitor',4747,'15 de Novembro'),
        (3,'Zé',8989,'7 de Setembro'),
        (4,'Fulano',1313,'R Rio de Janeiro'),
        (5,'Beltrano',5757,'R Minas Gerais');
        
-- emprestimo
insert into emprestimo(idEmprestimo,livro,locador,situacao,dtEmprestimo,dtDevolucao) values 
		(1,2,3,'Devolvido','11/11','21/11'),
        (2,2,4,'Devolvido','21/11','30/11'),
        (3,1,5,'Devolvido','01/11','21/11'),
        (4,4,2,'Emprestimo','01/12','00/00'),
        (5,5,3,'Emprestimo','01/11','00/00');

-- Parte 1
-- Quais livros se encontram disponiveis?
CREATE INDEX idx_Livro_Situação ON Livro(Situação);
select * from livro
where Situação='Disponivel';


-- Qual a situação dos emprestimos realizados e quais livros foram emprestados?
CREATE INDEX idx_livro_titulo ON livro(titulo);
CREATE INDEX idx_locador_nome ON locador(Nome);
select l.titulo as titulo,c.nome as Nome_cliente, e.situacao as Situacao_Emprestimo from emprestimo e
inner join locador c on e.locador=c.idLocador
inner join livro l on e.livro=l.idLivro; 

-- parte 2
-- procedure para ecommerce

DELIMITER $$
CREATE PROCEDURE CRUD(
	IN opcao int, IN id int
)
BEGIN	
	CASE opcao		
		WHEN 1 THEN
			
			SELECT * FROM emprestimo WHERE idEmprestimo =id; 
        WHEN 2 THEN
  
			UPDATE emprestimo SET situacao = 'Devolvido' WHERE idEmprestimo = id;
		WHEN 3 THEN
	
			DELETE FROM productOrder WHERE idPOorder = id; 
			
	END CASE;
END  $$
DELIMITER ;