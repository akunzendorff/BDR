create database sist_ident_varroa;
use sist_ident_varroa;

create table usuarios(
id int primary key auto_increment,
nome varchar(100),
email varchar(100),
login varchar(100),
senha varchar(50),
telefone varchar(15),
acesso enum("Funcionário", "Gerente", "Supervisor") default ("Funcionário")
);

create table colmeias(
id int primary key auto-increment,
nome varchar(100),
localização varchar(255),
tipo enum("", "") default ("")
);

create table analises(
id int primary key auto_increment,
id_colmeia int,
id_usuario int,
data_analise datetime,
varroa boolean,
constraint id_colmeia_fk foreign key (id_colmeia) references colmeias(id),
constraint id_usuario_fk foreign key (id_usuario) references usuarios(id)); 

insert into usuarios(nome, email, login, senha, telefone, acesso) values
("Ana Flávia", "ana@abelha.com", "ana", "ana123", "(3) 99999-9999", "Funcionário"),
("Gustavo", "gustavo@abelha.com", "gustavo", "gustavo123", "(13) 99999-9990", "Gerente"),
("Isabely", "isabely@abelha.com", "isabely", "isabely123", "(13) 99999-9991", "Supervisor"),
("Yasmin", "yasmin@abelha.com", "yasmin", "yasmin123", "(13) 99999-9992", null);

insert into colmeias (nome, localizacao, abelha) values
("Colmeia 1", "41°24'12.2"N 2°10'26.5"E", "Jataí"),
("Colmeia 2", "41°24'12.2"N 2°10'26.4"E", "Mirim"),
("Colmeia 3", "41°24'12.2"N 2°10'26.3"E", "Borá"),
("Colmeia 4", "41°24'12.2"N 2°10'26.2"E", "Mandaguari");

insert into analises (id_colmeia, id_usuario, data_analise, varroa) values
(1, 4, "2024-09-19 10:00:00", "FALSE"),
(2, 3, "2024-09-19 11:00:00", "FALSE"),
(3, 2, "2024-09-19 12:00:00", "FALSE"),
(4, 1, "2024-09-19 13:00:00", "FALSE");
