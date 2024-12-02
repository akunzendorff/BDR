create database if not exists miteScan;
use miteScan;

create table if not exists usuarios(
id_usuario int primary key auto_increment,
nome varchar(100),
email varchar(100),
login varchar(100),
senha varchar(50),
acesso varchar(50)
);

create table if not exists abelhas(
id_abelha int auto_increment primary key,
nome varchar(100),
caracteristicas varchar(100),
tamanho varchar(100),
ferrao boolean
);

create table if not exists colmeias(
id_colmeia int primary key auto_increment,
nome varchar(100),
locLat varchar(255),
locLong varchar(255),
tamanho varchar(50),
id_abelha int,
constraint id_abelha_fk foreign key (id_abelha) references abelhas(id_abelha)
);

create table if not exists registroBackups (
id_backup int primary key auto_increment,
data_backup datetime,
tipo_backup enum('completo', 'incremental', 'diferencial'),
caminho_arquivo varchar(255),
sucesso boolean
);

create table if not exists analises(
id_analise int primary key auto_increment,
id_colmeia int,
id_usuario int,
data_analise datetime,
varroa boolean,
imagens blob,
temperatura decimal(5,2) not null,
umidade decimal(5,2) not null,
constraint id_colmeia_fk foreign key (id_colmeia) references colmeias(id_colmeia),
constraint id_usuario_fk foreign key (id_usuario) references usuarios(id_usuario)
); 

insert into usuarios(nome, email, login, senha, acesso) values
("Ana Flávia", "ana@abelha.com", "ana", "ana123", "Funcionário"),
("Gustavo", "gustavo@abelha.com", "gustavo", "gustavo123", "Gerente"),
("Isabely", "isabely@abelha.com", "isabely", "isabely123", "Supervisor"),
("Yasmin", "yasmin@abelha.com", "yasmin", "yasmin123", null);

insert into abelhas(nome, caracteristicas, tamanho, ferrao) values
("Jataí", "", "", false),
("Manadaguari", "", "", true),
("Uruçu", "", "", false),
("Cauí", "", "", true);

insert into colmeias (nome, locLat, LocLong, tamanho, id_abelha) values
("Colmeia 1", "41°24'12.2'N", "2°10'26.5'E", "Grande", 1),
("Colmeia 2", "41°24'12.2'N", "2°10'26.4'E", "Média", 2),
("Colmeia 3", "41°24'12.2'N", "2°10'26.3'E", "Pequena", 3),
("Colmeia 4", "41°24'12.2'N", "2°10'26.2'E", null, 4);

insert into registroBackups (data_backup, tipo_backup, caminho_arquivo, sucesso) values
(now(), 'completo', '/caminho/do/backup.bak', true);

insert into analises (id_colmeia, id_usuario, data_analise, varroa, temperatura, umidade) values
(1, 4, "2024-09-19 10:00:00", false, 20.0, 20.0),
(2, 3, "2024-09-19 11:00:00", false, 15.5, 15.5),
(3, 2, "2024-09-19 12:00:00", false, 18.0, 18.8),
(4, 1, "2024-09-19 13:00:00", false, 19.0, 17.5);


select 
    u.id_usuario as "ID do Usuário",
    u.nome as "Nome do Usuário",
    u.email as "Email do Usuário",
    u.login as "Login do Usuário",
    u.acesso as "Acesso do Usuário",
    c.id_colmeia as "ID da Colmeia",
    c.nome as "Nome da Colmeia",
    c.locLat as "Latitude da Colmeia",
    c.locLong as "Longitude da Colmeia",
    c.tamanho as "Tamanho da Colmeia",
    ab.id_abelha as "Id da abelha",
    ab.nome as "Nome da abelha",
    a.id_analise as "ID da Análise",
    a.data_analise as "Data da Análise",
    a.varroa as "Infestação",
    a.temperatura as "Temperatura da Colmeia",
    a.umidade as "Umidade da Colmeia"
from  usuarios u
left join analises a on u.id_usuario = a.id_usuario
left join colmeias c on a.id_colmeia = c.id_colmeia
left join abelhas ab on ab.id_abelha = c.id_abelha;
