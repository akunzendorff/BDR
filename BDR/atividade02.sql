create database if not exists fazenda_palmitos_ana;
use fazenda_palmitos_ana;

create table if not exists palmitos(
id_palmito int primary key auto_increment,
tipo_palmito varchar(50),
preco_venda decimal(5,2),
estoque_atual int,
data_plantio date,
data_colheita date
);

insert into palmitos(tipo_palmito, preco_venda, estoque_atual, data_plantio, data_colheita) values
("Pupunha", 15.50, 200, "2023-02-15", "2024-02-15"),
("Açaí", 10.00, 150, "2023-01-10", "2024-01-10"),
("Jussara", 18.75, 80, "2023-03-05", "2024-03-05"),
("Real", 20.00, 60, "2023-04-20", "2024-04-20"),
("Pupunha Premium", 25.00, 40, "2023-05-15", "2024-05-15"),
("Açaí Orgânico", 12.50, 100, "2023-06-10", "2024-06-10"),
("Jussara Orgânico", 19.00, 70, "2023-07-22", "2024-07-22"),
("Real Orgânico", 22.50, 30, "2023-08-01", "2024-08-01"),
("Pupunha Orgânico", 16.50, 50, "2023-09-05", "2024-09-05"),
("Açaí Premium", 13.50, 120, "2023-10-12", "2024-10-12");

select * from palmitos;

create table if not exists fornecedores(
id_fornecedor int primary key auto_increment,
nome_fornecedor varchar(50),
contato varchar(15),
cidade varchar(50)
);

insert into fornecedores(nome_fornecedor, contato, cidade) values
("Fazenda Verde", "(11) 98765-4321", "São Paulo"),
("AgroPalm", "(21) 91234-5678", "Rio de Janeiro"),
("Orgânicos S.A.", "(47) 99876-5432", "Florianópolis"),
("EcoPlanta", "(31) 92345-6789", "Belo Horizonte"),
("Sustenta Verde", "(61) 99999-9999", "Brasília"),
("HortiVida", "(81) 97654-3210", "Recife"),
("AgroPalmito", "(19) 93210-5678", "Campinas"),
("VerdeOrg", "(41) 94321-7654", "Curitiba"),
("PlantarBem", "(62) 95432-1098", "Goiânia"),
("BioPalm", "(85) 98765-1234", "Fortaleza");

select * from fornecedores;

create table if not exists compras(
id_compra int primary key auto_increment,
id_palmito int,
quantidade_comprada int,
data_compra date,
preco_total decimal(10,2),
constraint id_palmito_fk foreign key (id_palmito) references palmitos (id_palmito)
);

insert into compras(id_palmito, quantidade_comprada, data_compra, preco_total) values
(1, 100, "2024-01-05", 1550.00),
(2, 50, "2024-01-12", 500.00),
(3, 40, "2024-01-18", 750.00),
(4, 20, "2024-02-01", 400.00),
(5, 10, "2024-02-15", 250.00),
(6, 80, "2024-02-20", 1000.00),
(7, 50, "2024-02-25", 950.00),
(8, 30, "2024-03-02", 675.00),
(9, 40, "2024-03-10", 660.00),
(10, 70, "2024-03-18", 945.00);

select * from compras;

create table if not exists vendas(
id_venda int primary key auto_increment,
id_palmito int,
quantidade_vendida int,
data_venda date,
preco_total decimal(10,2),
constraint id_palmito_fk_vendas foreign key (id_palmito) references palmitos (id_palmito)
);

insert into vendas(id_palmito, quantidade_vendida, data_venda, preco_total) values
(1, 50, "2024-03-10", 1550.00),
(2, 30, "2024-03-15", 500.00),
(3, 20, "2024-03-20", 750.00),
(4, 10, "2024-03-25", 400.00),
(5, 5, "2024-04-05", 250.00),
(6, 40, "2024-04-10", 1000.00),
(7, 35, "2024-04-12", 950.00),
(8, 20, "2024-04-18", 675.00),
(9, 25, "2024-04-20", 660.00),
(10, 60, "2024-04-22", 945.00);

select * from vendas;

#1. Consultas SQL utilizando WHERE, ORDER BY, GROUP BY, HAVING:
#a) Consulta 1 - Listar todas as vendas de um tipo de palmito específico.
select 
	v.id_venda as "ID da venda",
	p.tipo_palmito as "Tipo de palmito", 
	v.quantidade_vendida as "Quantidade", 
	v.data_venda as "Data",
	v.preco_total as "Preço total"
from vendas v
join palmitos p using (id_palmito)
where p.tipo_palmito = "Pupunha";

#1. b) Consulta 2 - Ordenar as vendas por data, da mais recente para a mais antiga.
select
	v.id_venda as "ID da venda",
	v.id_palmito as "ID do palmito", 
	v.quantidade_vendida as "Quantidade", 
	v.data_venda as "Data",
	v.preco_total as "Preço total"
from vendas v
order by data_venda desc;

#1. c) Consulta 3 - Exibir o total de vendas por tipo de palmito, agrupando pelo id_palmito.
select
	p.tipo_palmito as "Tipo de palmito",
	count(v.id_palmito) as "Total de vendas"
from palmitos p
join vendas v using (id_palmito)
group by p.tipo_palmito;

#1. d) Consulta 4 - Listar os tipos de palmito cuja venda total excedeu 500 unidades, utilizando HAVING.
select
	p.tipo_palmito as "Tipo de palmito",
    count(v.quantidade_vendida) as "Total de vendas"
from palmitos p 
join vendas v using (id_palmito)
group by p.tipo_palmito
having count(v.quantidade_vendida) > 500;

#2. Criação de Funções, Procedures e Triggers:
#a) Calcular o total de vendas de um palmito
delimiter //
create function calculaVendas(id int) returns decimal(10,2)
begin
declare totalVendas int;

select sum(quantidade_vendida) into totalVendas from vendas where id_palmito = id;

return totalVendas;
end //
delimiter ;

select calculaVendas(1);

#b) Inserir uma nova venda e atualizar o estoque.
delimiter //
create procedure novaVenda(id int, qtd_vendida int)
begin

declare preco_unit int;
declare estoque_atualizado int;
declare preco_total int;

select estoque_atual, preco_venda into estoque_atualizado, preco_unit from palmitos where id = id_palmito;

if estoque_atualizado >= qtd_vendida then
set preco_total = qtd_vendida * preco_unit;

insert into vendas (id_palmito, quantidade_vendida, data_venda, preco_total) values (id, qtd_vendida, curdate(), preco_total);

update palmitos set estoque_atual = estoque_atual - qtd_vendida where id = id_palmito;
end if;
end//
delimiter ;

call novaVenda(5, 20);
select * from vendas;

#c) Atualizar o estoque automaticamente ao inserir uma nova compra.

select * from palmitos;

delimiter //
create trigger atualizarEstoquePosCompra
after insert on compras
for each row

begin
update palmitos
set estoque_atual = estoque_atual + new.quantidade_comprada
where id_palmito = new.id_palmito;

end//
delimiter ;

insert into compras (id_palmito, quantidade_comprada, data_compra, preco_total) values
(1, 100, "2024-01-05", 1550.00);

select * from palmitos;

#3. Criação de Views:
#a) Mostrar a situação atual do estoque.
create view situacao_estoque as
select p.id_palmito, p.tipo_palmito, p.estoque_atual from palmitos p group by p.id_palmito;

select * from situacao_estoque;

#b) Exibir o histórico de vendas por tipo de palmito.
create view historico_vendas as
select p.id_palmito, p.tipo_palmito, p.estoque_atual, p.preco_venda, v.quantidade_vendida as total_vendido 
from palmitos p
join vendas v on p.id_palmito = v.id_palmito
where p.tipo_palmito = "Pupunha";

select * from historico_vendas;
