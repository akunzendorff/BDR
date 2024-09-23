create database if not exists sist_ident_varroa;
use sist_ident_varroa;

create table usuarios(
id int primary key auto_increment,
nome varchar(100),
email varchar(100),
login varchar(100),
senha varchar(50),
acesso enum("Funcionário", "Gerente", "Supervisor") default ("Funcionário")
);

create table colmeias(
id int primary key auto_increment,
nome varchar(100),
localizacao varchar(255),
tamanho varchar(50),
tipo_abelha enum("Jataí", "Mirim", "Mandaguari", "Borá") default (null)
);

create table registroBackups (
id int primary key auto_increment,
data_backup datetime,
tipo_backup enum('completo', 'incremental', 'diferencial'),
caminho_arquivo varchar(255),
sucesso boolean
);

create table analises(
id int primary key auto_increment,
id_colmeia int,
id_usuario int,
data_analise datetime,
varroa boolean,
imagens blob,
temperatura decimal(5,2) not null,
umidade decimal(5,2) not null,
constraint id_colmeia_fk foreign key (id_colmeia) references colmeias(id),
constraint id_usuario_fk foreign key (id_usuario) references usuarios(id)
); 

insert into usuarios(nome, email, login, senha, acesso) values
("Ana Flávia", "ana@abelha.com", "ana", "ana123", "Funcionário"),
("Gustavo", "gustavo@abelha.com", "gustavo", "gustavo123", "Gerente"),
("Isabely", "isabely@abelha.com", "isabely", "isabely123", "Supervisor"),
("Yasmin", "yasmin@abelha.com", "yasmin", "yasmin123", null);

insert into colmeias (nome, localizacao, tamanho, tipo_abelha) values
("Colmeia 1", "41°24'12.2'N 2°10'26.5'E", "Grande", "Jataí"),
("Colmeia 2", "41°24'12.2'N 2°10'26.4'E", "Média", "Mirim"),
("Colmeia 3", "41°24'12.2'N 2°10'26.3'E", "Pequena", "Borá"),
("Colmeia 4", "41°24'12.2'N 2°10'26.2'E", null, "Mandaguari");

insert into registroBackups (data_backup, tipo_backup, caminho_arquivo, sucesso) values
(now(), 'completo', '/caminho/do/backup.bak', true);

insert into analises (id_colmeia, id_usuario, data_analise, varroa, temperatura, umidade) values
(1, 4, "2024-09-19 10:00:00", "FALSE", 20.0, 20.0),
(2, 3, "2024-09-19 11:00:00", "FALSE", 15.5, 15.5),
(3, 2, "2024-09-19 12:00:00", "FALSE", 18.0, 18.8),
(4, 1, "2024-09-19 13:00:00", "FALSE", 19.0, 17.5);


select 
    u.id as "ID do Usuário",
    u.nome as "Nome do Usuário",
    u.email as "Email do Usuário",
    u.login as "Login do Usuário",
    u.acesso as "Acesso do Usuário",
    c.id as "ID da Colmeia",
    c.nome as "Nome da Colmeia",
    c.localizacao as "Localização da Colmeia",
    c.tamanho as "Tamanho da Colmeia",
    c.tipo_abelha as "Tipo de abelha",
    a.id as "ID da Análise",
    a.data_analise as "Data da Análise",
    a.varroa as "Infestação",
    a.temperatura as "Temperatura da Colmeia",
    a.umidade as "Umidade da Colmeia"
from  usuarios u
left join analises a on u.id = a.id_usuario
left join colmeias c on a.id_colmeia = c.id;
