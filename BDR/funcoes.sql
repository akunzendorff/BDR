create database sistemaVendasLivro;
use sistemaVendasLivro;

create table Autores(
idAutor int primary key auto_increment,
nome varchar (255),
pais varchar (50)
);

create table livros(
idLivro int auto_increment primary key,
titulo varchar (255),
idAutor int,
preco decimal (10,2),
estoque int default 0,
constraint fk_idAutor foreign key (idAutor) references Autores (idAutor)
);

create table vendas(
idVenda int primary key auto_increment,
idLivro int,
dataVenda date,
quantidade int,
constraint fk_idLivro foreign key (idLivro) references livros (idLivro)
);

alter table vendas add column valorTotal decimal (10,2);

insert into Autores (nome, pais) values 
('Machado de Assis', 'Brasil'),
('Clarice Lispector', 'Brasil'),
('Jorge Amado', 'Brasil');

insert into Livros (titulo, idAutor, preco, estoque) values 
('Dom Casmurro', 1, 34.90, 12),
('A Hora da Estrela', 2, 29.90, 7),
('Capitães de Areia', 3, 39.90, 9);

insert into vendas (idLivro, dataVenda, quantidade, valorTotal) values
(1, '2024-09-01', 3, 104.70),
(2, '2024-09-02', 2, 59.80),
(3, '2024-09-03', 1, 39.90);

select * from autores;
select * from livros;
select * from vendas;

#Criar Funções
#Mudar Delimitador MySQL
Delimiter //
create function TotalVendas() returns decimal(10,2)
begin
declare total decimal (10,2);
select sum(valorTotal) into total from vendas;
return ifnull(total, 0);
end //
Delimiter ;

#Executar Função
select TotalVendas();

# Criar Função CalculaVenda
delimiter //
create function calculaVenda(id int, qtd int) returns decimal(10,2)
begin
 -- Declarar Variaveis
 declare valorTotal decimal(10,2);
 declare precoUnit decimal(10,2);
 
 -- Buscar o preço unitário do livro na tabela livros
 select preco into precoUnit from livros where livros.idLivro = id limit 1;
 
 -- Verificar se o retorno é nulo
 if precoUnit is null then
 return 0;
 end if;
 
 -- Calcular o valor total do produto
 set valorTotal = precoUnit * qtd;
 return valorTotal;
 
 end //
 delimiter ;
 
 select * from livros;
 
 #Executar Função
select calculaVenda(3, 3);

# Criar Função calculaEstoque
delimiter //
create function calculaEstoque(id int, qtd int) returns decimal(10,2)
begin
declare estoqueAtual int;
declare estoqueAtualizado int;

select estoque into estoqueAtual from livros where idLivro = id;
set estoqueAtualizado = estoqueAtual - qtd;
return estoqueAtualizado;
end //
delimiter ;

select * from livros;
 
 #Executar Função
select calculaEstoque(3, 2);

# Procedure RegistrarVenda
delimiter //
create procedure registrarVenda(in id int, in qtd int)
begin

declare valorTotal decimal(10, 2);

set valorTotal = calculaVenda(id, qtd);
insert into Vendas (idLivro, dataVenda, quantidade, valorTotal) values (id, curdate(), qtd, valorTotal);

end //
delimiter ;

select * from vendas;

 #Executar Procedure
call registrarVenda (3, 2);

delimiter //
create procedure baixarEstoque(in id int, in qtd int)
begin
	declare estoqueAtualizado int;
    
    set estoqueAtualizado = calculaEstoque(id,qtd);
    
    update livros set estoque = estoqueAtualizado where idLivro = id;
end//
delimiter ;

call baixarEstoque(2,5);

#Criar Trigger
delimiter //
create trigger vender
after insert on vendas
for each row

begin
call baixarEstoque(new.idLivro, new.quantidade);
end //
delimiter ;

select * from livros;
select * from vendas;

call registrarVenda(1,8);

create view listaVendas as
select idVenda, vendas.idLivro, livros.titulo, quantidade, valorTotal from vendas
inner join livros on vendas.idLivro=livros.idLivro;

select * from listaVendas;
