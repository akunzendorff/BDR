CREATE DATABASE quaggio;
USE quaggio;
 
CREATE TABLE sistemas (
idSistema INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR (100) NOT NULL,
funcionalidade VARCHAR(100) NOT NULL);
 
CREATE TABLE remessas(
idRemessa INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
qtdQueijos INT NOT NULL,
dtCadastro DATE NOT NULL, 
localizacao VARCHAR (100) NOT NULL,
descricao VARCHAR (100) NOT NULL,
idSistema INT NOT NULL,
CONSTRAINT fk_idSistema FOREIGN KEY (idSistema) REFERENCES sistemas (idSistema));
 
CREATE TABLE queijos(
idQueijo INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
tipoQueijo VARCHAR (100) NOT NULL,
tempoMaturacao INT NOT NULL);
 
CREATE TABLE producoes (
idProducao INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
idQueijo INT NOT NULL,
idRemessa INT NOT NULL,
CONSTRAINT fk_idQueijo FOREIGN KEY (idQueijo) REFERENCES queijos (idQueijo),
CONSTRAINT fk_idRemessa FOREIGN KEY (idRemessa) REFERENCES remessas (idRemessa));
 
CREATE TABLE usuarios (
idUsuario INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR (100) NOT NULL,
senha VARCHAR (20) NOT NULL,
email VARCHAR (100) NOT NULL,
idEmpresa INT NOT NULL,
idTipoUsuario INT NOT NULL,
CONSTRAINT fk_idEmpresa FOREIGN KEY (idEmpresa) REFERENCES empresas (idEmpresa),
CONSTRAINT fk_idTipoUsuario FOREIGN KEY (idTipoUsuario) REFERENCES tiposUsuarios (idTipoUsuario));
 
CREATE TABLE empresas (
idEmpresa INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR (100) NOT NULL,
cnpj VARCHAR (14) NOT null);
 
CREATE TABLE telefones (
idTelefone INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
telefone VARCHAR (14) NOT NULL,
idUsuario INT NOT NULL,
CONSTRAINT fk_idUsuario FOREIGN KEY (idUsuario) REFERENCES usuarios (idUsuario));
 
CREATE TABLE tiposUsuarios (
idTipoUsuario INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
tipo VARCHAR (100) NOT NULL,
idAcesso INT NOT NULL,
CONSTRAINT fk_idAcesso FOREIGN KEY (idAcesso) REFERENCES acessos (idAcesso));
 
CREATE TABLE acessos (
idAcesso INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
tipoAcesso VARCHAR (100));
/*,
idPermissao INT,
CONSTRAINT fk_idPermissao FOREIGN KEY (idPermissao) REFERENCES permissoes (idPermissao));
 
CREATE TABLE permissoes (
idPermissao INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
permissao VARCHAR (100));*/
 
insert into sistemas (nome, funcionalidade) values ("Quaggio System", "Controle de qualidade de queijo de Búfala");
select * from sistemas;
 
insert into queijos (tipoQueijo, tempoMaturacao) values ("Burrata", "15");
select * from queijos;

insert into empresas (nome, cnpj) values ("Ollintech","56787021000153");
select * from empresas;

insert into remessas (qtdQueijos, dtCadastro, localizacao, descricao, idSistema) values ("30", "2024-02-28", "casa da mae joana", "queijo lindo de bonito");
select * from remessas;

