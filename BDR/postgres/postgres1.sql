-- Criar banco de dados
create database nomeBanco;
-- Não precisa do "use nomeBanco"

-- Criar tabela
create table tipoProdutos(
	idProd serial primary key, -- serial = int + auto_increment
	descricao varchar(100)
);

create table produtos(
	idProduto serial primary key,
	descricao varchar(100) not null,
	preco money not null, -- Tipo de dado exclusivo para moeda
	idTipoProduto int references tipoProdutos(idProd) -- Criação de foreign key
);

/*Inserindo dados na tabela*/
insert into tipoProdutos (descricao) values
('Computadores'), ('Impressora'); -- Apenas aspas simples quando for texto

insert into produtos (descricao, preco, idTipoProduto) values
('Desktop', 1200.00, 1),
('Laptop', 2200.00, 1),
('Impressora Jato de Tinta', 500.00, 2),
('Impressora Laser', 1200.00, 2);

--Listagem de dados
-- Listar todos os registros da tabela
select * from produtos;

--Listar os produtos em ordem decrescente por descrição
select * from produtos order by descricao desc;

--Listar os produtos em ordem crescente de preço
select * from produtos order by preco asc;

--Listar os produtos que são do tipo 2
select * from produtos where idTipoProduto = 2;

--Listar os produtos que são do tipo computador
select * from produtos 
join tipoProdutos tp on idProd = idTipoProduto  
where tp.descricao = 'Computadores';

-- Retorne o valor total de cada tipo de produto
select sum(preco) as "Total vendas", tp.descricao as "Descrição" from produtos p
join tipoProdutos tp on p.idTipoProduto = tp.idProd
group by tp.descricao;

