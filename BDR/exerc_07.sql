create database biblioteca;
use biblioteca;

create table livros(
cod_livro int auto_increment primary key,
ISBN bigint(13),
titulo varchar(255),
subtitulo varchar (255),
ano_publicacao int(4),
genero varchar(100),
descricao varchar(255)
);

create table autores(
id_autor int auto_increment primary key,
nome varchar(255),
data_nasc date,
biografia varchar(255)
);

create table livrosXautores(
id int auto_increment primary key,
id_livro int,
id_autores int,
constraint foreign key (id_livro) references livros (cod_livro),
constraint foreign key (id_autores) references autores (id_autor)
);

create table usuarios(
id_usuario int auto_increment primary key,
nome varchar(255),
endereco varchar(255),
bairro varchar(100),
cidade varchar(100),
estado varchar(2)
);

alter table usuarios add column assinatura enum("Aluno", "Professor", "Funcionário") default "Aluno";
insert into usuarios (nome, assinatura) values ("Robson", "Diretor");
alter table usuarios change assinatura assinatura enum("Aluno", "Professor", "Funcionário", "Diretor");

select * from usuarios;

create table telefones(
id_telefone int auto_increment primary key,
telefone int (11),
id_usuario int,
constraint foreign key (id_usuario) references usuarios(id_usuario)
);

alter table telefones change telefone telefone bigint(11);

create table emails(
id_email int auto_increment primary key,
id_usuario int,
email varchar(255),
constraint foreign key (id_usuario) references usuarios (id_usuario)
);

create table emprestimos(
id_emp int auto_increment primary key,
data_emp date not null,
data_devolucaoPrevista date not null,
data_devolucaoReal date,
id_usuario int,
constraint foreign key (id_usuario) references usuarios(id_usuario)
);


create table empXlivros(
id int auto_increment primary key,
id_livro int,
id_emp int,
constraint foreign key (id_livro) references livros (cod_livro),
constraint foreign key (id_emp) references emprestimos (id_emp)
);

insert into livros (ISBN, titulo, subtitulo, ano_publicacao, genero, descricao) values 
(9780140449136, 'A Odisséia', 'Traduzido por: João Pereira', 800, 'Épico', 'A história épica de 
Odisseu e sua jornada de volta para casa.'),
(9780321125217, 'Clean Code', 'A Handbook of Agile Software Craftsmanship', 2008, 
'Tecnologia', 'Conselhos e melhores práticas para escrever código limpo e manutenível.'),
(9780201616224, 'Design Patterns', 'Elements of Reusable Object-Oriented Software', 1994, 
'Tecnologia', 'Padrões de design de software e suas aplicações em programação orientada a 
objetos.');

select * from livros;

INSERT INTO autores (nome, data_nasc, biografia) VALUES
('Homero', '0800-01-01', 'Poeta grego da Antiguidade, autor da Ilíada e da Odisséia.'),
('Robert C. Martin', '1952-12-05', 'Engenheiro de software e autor conhecido por seu trabalho 
em princípios de design de software.'),
('Erich Gamma', '1960-03-22', 'Um dos autores do famoso livro "Design Patterns", professor e 
consultor em design de software.');

select * from autores;

INSERT INTO livrosXautores (id_livro, id_autores)
VALUES
(1, 1), -- A Odisséia por Homero
(2, 2), -- Clean Code por Robert C. Martin
(3, 3); -- Design Patterns por Erich Gamma

select * from livrosXautores;

INSERT INTO usuarios (nome, endereco, bairro, cidade, estado, assinatura)
VALUES
('Ana Silva', 'Rua das Flores, 123', 'Jardim Primavera', 'São Paulo', 'SP', 'Aluno'),
('João Souza', 'Avenida Central, 456', 'Centro', 'Rio de Janeiro', 'RJ', 'Professor'),
('Maria Oliveira', 'Praça da Liberdade, 789', 'Liberdade', 'Belo Horizonte', 'MG', 'Funcionário');

-- Inserir dados na tabela usuarios
INSERT INTO usuarios (nome, assinatura) VALUES 
('Maria', 'Funcionário'),
('João', 'Funcionário'),
('Ana', 'Professor'),
('Carlos', 'Aluno'),
('Robson', 'Diretor');


select * from usuarios;

INSERT INTO telefones (id_usuario, telefone) VALUES
(1, 11987654321),
(2, 21987654321),
(3, 31987654321);

select * from telefones;

INSERT INTO emails (id_usuario, email) VALUES
(1, 'ana.silva@example.com'),
(2, 'joao.souza@example.com'),
(3, 'maria.oliveira@example.com');

-- Inserir dados na tabela emails
INSERT INTO emails (id_usuario, email) VALUES 
(1, 'maria@example.com'),  -- supondo que o id_usuario de Maria é 1
(2, 'joao@example.com'),   -- supondo que o id_usuario de João é 2
(3, 'ana@example.com'),    -- supondo que o id_usuario de Ana é 3
(4, 'carlos@example.com'), -- supondo que o id_usuario de Carlos é 4
(5, 'robson@example.com'); -- supondo que o id_usuario de Robson é 5


select * from emails;

INSERT INTO emprestimos (data_emp, data_devolucaoPrevista, data_devolucaoReal, id_usuario) VALUES
('2024-08-01', '2024-08-15', NULL, 1),
('2024-08-05', '2024-08-20', NULL, 2),
('2024-08-10', '2024-08-25', NULL, 3);

select * from emprestimos;

INSERT INTO empXlivros (id_livro, id_emp) VALUES
(1, 1), -- A Odisséia emprestado no empréstimo 1
(2, 2), -- Clean Code emprestado no empréstimo 2
(3, 3); -- Design Patterns emprestado no empréstimo 3

select * from emprestimos;

-- 1. Listar todos os livros disponíveis na biblioteca. 
select titulo from livros;

-- 2. Encontrar todos os autores que têm mais de 50 anos.
select nome from autores where data_nasc < '1976-12-31';

-- 3. Mostrar todos os usuários que têm assinatura de 'Professor'.
select nome from usuarios where assinatura = "Professor";

-- 4. Listar todos os emprestimos que ainda não foram devolvidos.
select id_emp from emprestimos where data_devolucaoReal is null;

-- 5. Exibir todos os livros junto com os nomes dos autores que os escreveram.
select l.titulo as "Título do Livro", a.nome as "Nome do Autor" from livrosXautores
inner join livros l on livrosXautores.id_livro = l.cod_livro
inner join autores a on livrosXautores.id_autores = a.id_autor;

-- 6. Mostrar todos os empréstimos com o nome do usuário que fez o empréstimo e o título do livro emprestado.
select l.titulo as "Título do Livro", u.nome as "Nome do Usuário" from empXlivros e
inner join livros l on e.id_livro = l.cod_livro
inner join emprestimos emp on e.id_emp = emp.id_emp
inner join usuarios u on emp.id_usuario = u.id_usuario;

-- 7. Listar todos os usuários e seus números de telefone.
select u.nome as "Nome do Usuário", telefone as "Telefone" from telefones
inner join usuarios u on telefones.id_usuario = u.id_usuario;

-- 8. Mostrar todos os e-mails dos usuários que têm assinatura 'Funcionario'.
select e.email from emails e 
inner join usuarios u on e.id_usuario = u.id_usuario where u.assinatura = 'Funcionário';

-- 9.Encontrar todos os livros publicados após 2000 e ordená-los pelo ano de publicação.
select titulo from livros where ano_publicacao = 2008 order by ano_publicacao;

-- 10. Listar todos os autores cuja biografia contém a palavra 'design'.
select nome from autores where biografia like '%design%';

-- 11. Mostrar os detalhes dos empréstimos que foram feitos por usuários da cidade 'São Paulo'.
select * from emprestimos
inner join usuarios u on emprestimos.id_usuario = u.id_usuario where u.cidade = 'São Paulo';

-- 12.Contar o número de livros de cada gênero na biblioteca.
select genero, count(*) as num_livros from livros group by genero;

-- 13. Encontrar o autor com o maior número de livros na biblioteca.
select a.nome as autor, count(lxa.id_livro) as num_livros from livrosXautores lxa
inner join autores a on lxa.id_autores = a.id_autor
group by a.id_autor, a.nome order by num_livros desc limit 1;

-- 14. Mostrar todos os usuários que nunca fizeram um empréstimo. 
select * from usuarios u
left join emprestimos e on u.id_usuario = e.id_usuario
where e.id_usuario is null;

-- 15.Listar os livros que foram emprestados, mas ainda não foram devolvidos.
select l.* from livros l
inner join empXlivros exl on l.cod_livro = exl.id_livro
inner join emprestimos e on exl.id_emp = e.id_emp
where e.data_devolucaoReal is null;