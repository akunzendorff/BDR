create database banco;
use banco;

create table clientes(
id int auto_increment primary key,
nome varchar(100),
email varchar(100)
);

create table contas(
id int auto_increment primary key,
cliente_id int,
saldo decimal(10,2),
foreign key (cliente_id) references clientes(id)
);

create table transacoes(
id int auto_increment primary key,
conta_id int,
valor decimal(10,2),
data_transacao datetime,
tipo_transacao enum("Depósito", "Saque", "Qual Operação") default ("Qual Operação"),
constraint conta_id_fk foreign key (conta_id) references contas(id)
);

insert into clientes(nome, email) values
("João Silva", "joao@gmail.com"),
("Maria Santos", "maria@gmail.com"),
("Carlos Pereira", "carlos@gmail.com");

insert into contas(cliente_id, saldo) values
(1, 1000.00),
(2, 500.00),
(3, 1200.00);

insert into transacoes (conta_id, valor, tipo_transacao, data_transacao) values
(1, 500.00, 'Depósito', '2024-09-18 10:00:00'),
(1, 200.00, 'Saque', '2024-09-18 11:00:00'),
(2, 300.00, 'Depósito', '2024-09-18 12:00:00');

/*1. Indexes
Os índices em MySQL são usados para melhorar o desempenho das consultas, permitindo uma recuperação de dados mais rápida.
Eles funcionam como índices em um livro, ajudando a localizar rapidamente as linhas sem ter que fazer uma busca completa na tabela.
- Explicação básica: Um índice cria uma estrutura de dados adicional que permite uma busca mais rápida, mas também ocupa espaço
 e pode desacelerar a inserção e atualização de dados.*/
 
#Exemplo 1:  Index em coluna frequentemente utilizada
 
 create index idx_cliente_nome on clientes(nome);
 select * from clientes where nome = 'João Silva';
 
  #Exemplo 2:  Index em colunas para busca complexa
  /*Se as consultas frequentemente busca por combinações de saldo e cliente_id, criar um índice pode melhorar o desempenho.*/
  
  create index idx_cliente_saldo on contas(cliente_id, saldo);
  select * from contas where cliente_id = 1 and saldo > 500;
  
#Exemplo 3:  Index para melhorar o Order By
/* Ao usar a clausula ORDER BY em uma coluna específica, o uso de índices pode acelerar o processo de ordenação.*/

create index idx_transacoes_data on transacoes(data_transacao);
select * from transacoes order by data_transacao desc;

#Excluir index
drop index idx_cliente_nome on cliente;

#Listar os index criados
show index from clientes;

/*2. Transactions
Transações permitem que um conjunto de operações seja tratado como uma única unidade de trabalho, garantindo que todas sejam executadas
com sucesso ou que nenhuma seja aplicada, no caso de falha.
Conceitos chave:
- BEGIN: Inicia uma transação.
- COMMIT: Confirma todas as operações realizadas na transação.clientes
- ROLLBACK: Reverte todas as operações realizadas na transação em caso de erro.*/

#Exemplo 1: Transferência entre contas
/* Transferência de saldo entre contas, onde ambas as atualizações precisam ocorrer ou nenhuma delas.*/

Start transaction;
update contas set saldo = saldo - 100 where id = 1; #Saque de dinheiro
update contas set saldo = saldo + 100 where id = 2; #Depósito de dinheiro
commit;

select * from contas;

/*Se houver um erro em qualquer um dos UPDATEs, o sistema deve fazer um ROLLBACK para desfazer as alterações.*/
Start transaction;
update contas set saldo = saldo - 100 where id = 1; #Saque de dinheiro
update contas set saldo = saldo + 100 where id = 2; #Depósito de dinheiro
select * from contas; # Verificar saldos
rollback;
