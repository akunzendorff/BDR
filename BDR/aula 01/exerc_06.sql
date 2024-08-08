create database inventario;
use inventario;

create table categorias(
id_categ int auto_increment primary key,
nome varchar(100),
descricao varchar(500)
);

create table produtos(
id_prod int auto_increment primary key,
nome varchar(100),
preco double(4,2),
quant_estoq int,
categoria int,
constraint categoria_fk foreign key (categoria) references categorias(id_categ)
);