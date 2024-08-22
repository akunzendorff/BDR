create database biblioteca;
use biblioteca;

create table livros(
cod_livro int auto_increment primary key,
ISBN int(13),
titulo varchar(255),
subtitulo varchar (255),
ano_publicacao int(4),
genero varchar(100),
descricao varchar(255)
);

create table autores(
id_autor int auto_increment primary key,
nome varchar(255),
data_nasc date,
biografia varchar(255)
);

create table livrosXautores(
id int auto_increment primary key,
id_livro int,
id_autores int,
constraint foreign key (id_livro) references livros (cod_livro),
constraint foreign key (id_autores) references autores (id_autor)
);

create table usuarios(
id_usuario int auto_increment primary key,
nome varchar(255),
endereco varchar(255),
bairro varchar(100),
cidade varchar(100),
estado varchar(2)
);

alter table usuarios add column assinatura enum("Aluno", "Professor", "Funcionário") default "Aluno";
insert into usuarios (nome, assinatura) values ("Robson", "Diretor");
alter table usuarios change assinatura assinatura enum("Aluno", "Professor", "Funcionário", "Diretor") default "Aluno";

select * from usuarios;

create table telefones(
id_telefone int auto_increment primary key,
telefone int (11),
id_usuario int,
constraint foreign key (id_usuario) references usuarios(id_usuario)
);

create table emails(
id_email int auto_increment primary key,
id_usuario int,
email varchar(255),
constraint foreign key (id_usuario) references usuarios (id_usuario)
);

create table emprestimos(
id_emp int auto_increment primary key,
data_emp date not null,
data_devolucaoPrevista date not null,
data_devolucaoReal date,
id_usuario int,
constraint foreign key (id_usuario) references usuarios(id_usuario)
);

create table empXlivros(
id int auto_increment primary key,
id_livro int,
id_emp int,
constraint foreign key (id_livro) references livros (cod_livro),
constraint foreign key (id_emp) references emprestimos (id_emp)
);