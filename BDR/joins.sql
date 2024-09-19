#Criação de banco de dados caso não exista
create database if not exists emptech;

#apontar o banco para uso
use emptech;

#Criação de tabelas
create table if not exists funcionarios(
idFunc int primary key auto_increment,
nome varchar(255) not null
);

create table if not exists veiculos(
idVeic int primary key auto_increment,
modelo varchar(255) not null,
placas varchar(20) not null,
idFunc int
);

#Inserindo dados nas tabelas
insert into funcionarios (nome) values
('João da Silva'),
('Maria Oliveira'),
('Pedro Santos'),
('Ana Costa'),
('Lucas Almeida'),
('Fernanda Lima');

insert into veiculos (modelo, placas, idFunc) values
('Fiat Uno', 'ABC1D23', 1),
('Honda Civic', 'XYZ1E23', 2),
('Toyota Corolla', 'LMN1F23', 3),
('Chevrolet Onix', 'OPQ1G23', 4),
('Volkswagen Gol', 'UVW1H23', 5),
('Peugeot 208', 'YZA1I23', null);

#ESTRUTURA INNER JOIN
#select campo, campo, campo(campos a serem mostrados) from nomeTabelaResult
#join nomeTabelaJunção on nomeTabela.campo_fk = nomeTabela.campo_fk;

#Inner Join
select funcionarios.nome as Nome, veiculos.modelo from veiculos
join funcionarios on veiculos.idFunc = funcionarios.idFunc;

#Equi Join
#Usado quando o nome da chave estrangeira e da primária são iguais
select f.nome, v.modelo from veiculos v
join funcionarios f using (idFunc);

#Left Join
/*Retorna todos os campos do lado esquerdo do Join que se relaciona com o lado direito do Join,
 mais os regsitros que não relacionam com o lado direito e que sejam do lado esquerdo*/
select f.nome, v.modelo from veiculos v
left join funcionarios f using (idFunc);

#Right Join
/*Retorna todos os campos do lado direito do Join que se relaciona com o lado esquerdo do Join, 
mais os regsitros que não relacionam com o lado esquerdo e que sejam do lado direito*/
select f.nome, v.modelo from veiculos v
right join funcionarios f using (idFunc);

#Full Join
/*o Full Join não funciona para mySQL, porém uma solução para obter o resultado de uma tabela contendo,
 dados que se relacionam ou não do lado esquerdo com o lado direito do join,
 mais os dados que se relacionam ou não do lado direito com o lado esquerdo do Join,
 é necessário que seja feito as querys Left Join e Right Join, porém
 utilizando o UNION para unir as duas querys para realizar a pesquisa.*/
select f.nome, v.modelo from veiculos v
left join funcionarios f using (idFunc) 
union
select f.nome, v.modelo from veiculos v
right join funcionarios f using (idFunc);

/*View - Estrutura de seleção que encapsula querys complexas para
simplificar o uso ao usuário e facilitar as chamadas em aplicações externas. */
create view func_veic as 
select f.nome, v.modelo from veiculos v
left join funcionarios f using (idFunc) 
union
select f.nome, v.modelo from veiculos v
right join funcionarios f using (idFunc);

#Chamando View
select * from func_veic;

create table atuacaoVendas(
idAtuacao int primary key auto_increment,
descricao varchar (255) not null
);

insert into atuacaoVendas (descricao) values
('Vendas de Veículos Novos'),
('Vendas de Veículos Usados'),
('Manutenção e reparo de veículos'),
('Serviços de pós-vendas'),
('Consultoria de Vendas'),
('Programações e eventos especiais');

select * from atuacaoVendas;

#Cross Join
/*Este join ira criar relatorio onde irá fazer todas as combinações
possiveis entre as tabelas*/

/*Exemplo: Se cruzarmos as Tabelas Funcionário, Veículos e AtuaçãoVendas, onde a tabela Funcionários com 6 registros,
a tabela veículos com 7 registros e a tabela atuaçãoVendas com 6 registros, teremos um resultado de combinação 6 x 7 x 6
que totalizará 252 combinações.*/

select f.idFunc, f.nome, v.modelo, v.placas, a.descricao from funcionarios f
cross join veiculos v 
cross join atuacaoVendas a;

create table indicacoes(
codIndicador int,
codIndicado int,
primary key (codIndicador, codIndicado),
foreign key (codIndicador) references funcionarios(idFunc),
foreign key (codIndicado) references funcionarios(idFunc)
);

insert into indicacoes (codIndicador, codIndicado) values
(1,2), (1,3), (2,4), (2,5), (4,6);

#Self Join
/*Gera um resultado de relacionamento de dados de uma tabela com ela mesma, ou seja, um auto-relacionamento*/

select i1.codIndicador as "ID Indicador", f1.nome as "Nome indicador", i1.codIndicado as "ID Indicado",
f2.nome as "Nome indicado" from indicacoes i1
join funcionarios f1 on i1.codIndicador = f1.idFunc
join funcionarios f2 on i1.codIndicador = f2.idFunc;
