create database ecommerce;
use ecommerce;

create table clientes(
id_cliente int auto_increment primary key,
nome varchar(100),
endereco varchar(200),
email varchar(100)
);

create table pedidos(
id_pedido int auto_increment primary key,
dt_pedido date,
total double(4,2),
status_pedido varchar(100),
id_cliente int,
constraint id_cliente_fk foreign key (id_cliente) references clientes (id_cliente)
);