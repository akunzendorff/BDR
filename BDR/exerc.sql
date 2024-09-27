create database bd_fatec;
use bd_fatec;

create table Alunos(
Id_Aluno int auto_increment primary key,
nome varchar(100),
cpf varchar(14)
);

insert into Alunos (nome, cpf) values ("Pedro", "123.456.789-01"), ("Ana", "234.567.890-12"), ("Isabely", "345.678.901-23");

# Seleção de todos os registros da tabela
select * from matricula;
 
# Seleção de todos os registros mostrando apenas alguns campos criados na tabela
select nome, cpf from alunos;
 
# Seleção de Registro específico
select * from Alunos where id_Aluno=2;
 
# Atualizando dados em tabela
update Alunos set cpf="123.456.789-01" where id_Aluno=2;

#Adicionar dados em tabela
update Alunos set cpf="111.222.333-44" where Id_Aluno=2;

#Adicionar campos em tabela
alter table Alunos add column rg varchar(13);

alter table Alunos add column tel varchar(14);

#Mudar nome da coluna
alter table Alunos change tel celular varchar(14);

#Deletar coluna em tabela
alter table Alunos drop column rg;

#Apelidos de campos
select Id_Aluno as ID, nome as "Nome do Aluno", cpf as CPF, celular as Telefone from Alunos;

#Apelido de tabela
select a.nome, a.cpf from alunos a;

create table disciplinas(
Id_Disc int auto_increment primary key,
Nome_Disc varchar(100)
);

insert into disciplinas (nome_disc) values ("Banco de Dados Relacional"), ("Desenvolvimento Web II"), ("Design Digital");

create table matricula(
id_matric int auto_increment primary key,
id_aluno int,
id_disc int,
constraint foreign key (id_aluno) references alunos(id_aluno),
constraint foreign key (id_disc) references disciplinas(id_disc)
);

insert into matricula (id_aluno, id_disc) values (1,1), (1,2), (1,3), (2,1), (2,2), (2,3), (3,1), (3,2), (3,3);

select id_aluno, id_disc from matricula where id_aluno=1;

#Relacionamento entre tabelas usando INNER JOIN
select a.nome as "Nome do Aluno", d.nome_Disc as Disciplina from matricula
inner join alunos a on matricula.id_aluno = a.id_aluno
inner join disciplinas d on matricula.id_disc = d.id_disc;
