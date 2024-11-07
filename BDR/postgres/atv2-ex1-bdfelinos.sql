create table felinos(
	idGato serial primary key,
	nome varchar(20),
	raca varchar(30),
	coloracao varchar(30),
	idade int,
	brinquedoFavorito varchar(30)
)

insert into felinos(nome, raca, coloracao, idade, brinquedoFavorito) values
('Mickey', 'Maine Coon', 'Multicor', 3, 'Bolinha vermelha'),
('Nine', 'Ragamuffin', 'Bege', 2, 'Bolinha verde'),
('Carmen', 'Persian', 'Marrom', 2, 'Ratinho de borracha'),
('Luna', 'Abyssinian', 'Multicor', 12, 'Bolinha de papel'),
('Bella', 'Siamese', 'Laranja', 15, 'Arranhador'),
('Simba', 'Bengal', 'Amarelo com Manchas', 5, 'Corda'),
('Nina', 'Sphynx', 'Pele Nua', 4, 'Bolinha de lã'),
('Zorro', 'Persian', 'Cinza', 10, 'Ratinho de borracha'),
('Chester', 'British Shorthair', 'Cinza', 7, 'Pneu de borracha'),
('Tina', 'Maine Coon', 'Branco e Preto', 8, 'Peixe de borracha');

/*1) Crie uma consulta para listar a média de idade dos gatos agrupados pela raça,
mostrando também a quantidade de gatos por raça. Ordene os resultados pela
média de idade, da raça mais velha para a mais nova.*/
select 
	raca as "Raça", 
	round(avg(idade),2) as "Média de idade",
	count(raca) as "Quantidade"
from felinos
group by raca
order by round(avg(idade),2) desc; 

/*2)Crie uma consulta para listar o nome e a idade dos gatos cujo brinquedo favorito é
"Ratinho de borracha" ou "Bolinha de Lã", e que possuem uma idade maior que a
média de idade de todos os gatos.*/

select avg(idade) from felinos; -- Mostrar a média de idade de todos os gatos

select 
	nome as "Nome",
	idade as "Idade",
	brinquedoFavorito as "Brinquedo favorito"
from felinos
where (brinquedoFavorito = 'Ratinho de borracha' or brinquedoFavorito = 'Bolinha de lã')
and idade > (select avg(idade) from felinos);

/*3)Crie uma consulta para listar os gatos que têm mais de 5 anos de idade e que têm
como brinquedo favorito "Ratinho de borracha", ordenando os resultados por
idade, da mais velha para a mais nova.*/
select
	nome as "Nome",
	idade as "Idade",
	brinquedoFavorito as "Brinquedo favorito"
from felinos
where idade > 5
	and brinquedoFavorito = 'Ratinho de borracha'
order by idade desc;
