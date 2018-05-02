-- DDL
create database cep_correios;
use cep_correios;

create table estados (
id bigint(20) not null auto_increment,
sigla varchar (2) not null unique,
estado varchar(50) not null unique,
primary key(id,sigla))
engine = InnoDB
default character set = utf8;

create table cidades (
id bigint(20) not null auto_increment,
cidade varchar(255) not null,
estado_sigla varchar(2) not null,
primary key (id),
constraint fk_cidade_estado
	foreign key (estado_sigla) 
    references estados(sigla)
    on delete no action
    on update no action)
engine = InnoDB
default character set = utf8;

create table bairros (
id bigint primary key auto_increment,
bairro varchar (100) not null,
id_cidade bigint(20) not null,
constraint fk_bairro_cidade
	foreign key (id_cidade) 
    references cidades(id)
	on delete no action
    on update no action)
engine = InnoDB
default character set = utf8;

create table logradouros (
id bigint primary key auto_increment,
cep varchar(20) not null unique,
logradouro varchar(100) not null,
id_bairro bigint not null,
constraint fk_logradouro_bairro
	foreign key (id_bairro) 
    references bairros(id)
	on delete no action
    on update no action)
engine = InnoDB
default character set = utf8;

 -- DML
insert into estados(sigla, estado) values 
('BA', 'Bahia'),
('MG', 'Minas Gerais'),
('SP', 'São Paulo');

insert into cidades(cidade, estado_sigla) values
('Vitoria da Conquista', 'BA'),
('Sete Lagoas', 'MG'),
('São Paulo', 'SP');

insert into bairros(bairro, id_cidade) values
('Recreio', 1),
('Lontra', 2),
('Jardim Santa Adélia', 3);

insert into logradouros(cep, logradouro, id_bairro) values
('45020-750', 'Avenida Otávio Santos', 1),
('35701-805', 'Rua Otávio Santos', 2),
('03974-110', 'Rua Otávio Santos Calheiros ', 3);

-- DQL
select l.cep, l.logradouro, e.estado, e.sigla, c.cidade, b.bairro from logradouros as l inner join estados as e on l.id=e.id inner join cidades c on c.estado_sigla = e.sigla inner join bairros b on b.id = l.id where cep like'%ot%' or logradouro like'%ot%';