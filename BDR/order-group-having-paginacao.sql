create database if not exists loja_online;
use loja_online;
 
create table if not exists categorias (
id int not null primary key auto_increment,
nome varchar (50) not null
);
 
create table if not exists produtos (
id int auto_increment primary key,
nome varchar (100) not null,
categoria_id int,
preco decimal (10,2),
quantidade_estoque int,
foreign key (categoria_id) references categorias (id)
);
 
insert into categorias (nome) values
('Roupas'), ('Calçados'), ('Acessórios');
 
insert into produtos (nome, categoria_id, preco, quantidade_estoque) values
('Camiseta', 1, 29.90,100),
('Calça Jeans', 1, 49.99, 75),
('Tênis Esportivo',2,89.99,50),
('Relógio',3, 199.99,20),
('Óculos de Sol', 3, 129.99,30),
('Jaqueta',1,79.99, 40),
('Bota',2,199.99,25),
('Mochila',3,59.99,60),
('Camisa Polo',1,39.99,80),
('Tênis Causal',2,69.99,70);

select * from categorias;
select * from produtos;

#Ordenação de dados
/*Order By: é uma clausula usada em SQL para ordenar o resultado de uma consulta.
Podendo ordenar os resultados em ordem crescente (ASC - Padrão de Ordenação)  e em ordem decrescente (desc)*/

#Ordenar os produtos por preço em ordem crescente e decrescente
select nome, preco from produtos order by preco ASC;
select nome, preco from produtos order by preco;
select nome, preco from produtos order by preco desc;

#Ordenar os produtos por nome em ordem crescente e decrescente
select nome, preco from produtos order by nome;
select nome, preco from produtos order by nome desc;

/*Agrupamentos (Group By): Usada para agrupar linhas que tem valores iguais
em colunas específicas em grupo. Normalmente é usada com função de agregação
(sum, count, avg, etc) para calcular valores agregados para cada grupo.*/

#Contar o número de produtos em cada categoria:
select c.nome as "Categoria", count(p.id) as "Total de Produtos"
from produtos p
join categorias c on p.categoria_id = c.id
group by c.nome;

#Calcular a média de preço dos produtos em cada categoria
select c.nome as "Categoria", round(avg(p.preco), 2) as "Valor Médio"
from produtos p
join categorias c on p.categoria_id = c.id
group by c.nome;

/*Condição em Grupos (having) - É usada para filtrar os resultados que usa GROUP BY
Ela é similar ao WHERE, mas é aplicada após a agregação dos dados, permitindo
filtrar grupos em vez de linhas individuais*/

#Encontrar categorias com mais de três produtos
select c.nome as "Categoria", count(p.id) as "Total de Produtos"
from produtos p
join categorias c on p.categoria_id = c.id
group by c.nome
having count(p.id) > 3;

#Encontrar categorias em que a média de preço é superior a 50
select c.nome as "Categoria", round(avg(p.preco), 2) as "Valor Médio"
from produtos p
join categorias c on p.categoria_id = c.id
group by c.nome
having round(avg(p.preco), 2) > 50;

/* Paginação - Refere-se ao processo de dividir um conjunto de resultados em páginas
menores, geralmente para melhorar a performance e a usabilidade em interfaces. Em SQL,
isso é feito usando clausulas como LIMIT e OFFSET
LIMIT -> Quantidade de Registros a serem mostrados
OFFSET -> Quantidade de Registros a serem pulados */

#Mostrar 3 produtos por página
select * from produtos order by preco;
#Pagina 1:
select p.nome as "Produto", p.preco as "Preço", c.nome as "Categoria"
from produtos p
join categorias c on p.categoria_id = c.id
order by p.preco
limit 3 offset 0;

#Pagina 2:
select p.nome as "Produto", p.preco as "Preço", c.nome as "Categoria"
from produtos p
join categorias c on p.categoria_id = c.id
order by p.preco
limit 3 offset 3;

#Pagina 3:
select p.nome as "Produto", p.preco as "Preço", c.nome as "Categoria"
from produtos p
join categorias c on p.categoria_id = c.id
order by p.preco
limit 3 offset 6;

#Pagina 4:
select p.nome as "Produto", p.preco as "Preço", c.nome as "Categoria"
from produtos p
join categorias c on p.categoria_id = c.id
order by p.preco
limit 3 offset 9;
