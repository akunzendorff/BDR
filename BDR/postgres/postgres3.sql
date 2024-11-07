-- Criando tabelas

create table Alunos(
	id serial primary key,
	nome varchar(100) not null	
);

create table Notas(
	id serial primary key,
	id_alunos int references Alunos(id),
	disciplina varchar(50) not null,
	nota numeric(4,2) check (nota >= 0 and nota <=10) --
);

--Populando tabelas
insert into alunos (nome) values
('João Silva'),
('Maria Oliveira'),
('Carlos Souza'),
('Ana Martins');

select * from alunos;

insert into notas (id_alunos, disciplina, nota) values
(1, 'Matemática', 8.0),
(1, 'Português', 6.0),
(1, 'História', 7.5),
(2, 'Matemática', 5.5),
(2, 'Português', 4.0),
(2, 'História', 6.0),
(3, 'Matemática', 3.0),
(3, 'Português', 5.0),
(3, 'História', 4.0),
(4, 'Matemática', 6.0),
(4, 'Português', 7.5),
(4, 'História', 7.5);

select * from notas;

create view view_status_alunos as
select a.nome as Aluno, round(avg(n.nota), 2) as Media,
case 
when avg (n.nota)>=7 then 'Aprovado'
when avg (n.nota)>=5 then 'Recuperação'
else 'Reprovado'
end as status
from alunos a
join notas n on a.id = n.id_alunos
group by a.nome;

select * from view_status_alunos;
select * from view_status_alunos where status='Recuperação';