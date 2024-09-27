create database credito;
use credito;

create table clientes(
id_cliente int auto_increment primary key,
nome varchar(100),
endereco varchar(100),
dt_nasc date
);

create table cartoes_credito(
id_cart int auto_increment primary key,
num_cart int(20),
dt_validade date,
limite double(8,2)
);