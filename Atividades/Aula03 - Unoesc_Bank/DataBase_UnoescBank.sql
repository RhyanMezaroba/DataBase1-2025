create database UNOESC_BANK;

use UNOESC_BANK;

create table CLIENTE(
ID int not null auto_increment primary key, 
NOME varchar(255)
);

create table CONTA(
ID int not null auto_increment primary key,
NRO_CONTA varchar(10) not null,
ID_CLIENTE int not null,
constraint FK_ID_CLIENTE_CONTA
	foreign key (ID_CLIENTE)
    references CLIENTE(ID)
);

create table TRANSACAO (
	ID int not null auto_increment primary key,
    ID_CONTA int not null,
    TIPO_TRANSACAO int not null,
    DATA_HORA datetime not null,
    VALOR float not null
);

-- Definindo uma FK posteriormente a criação da tabela
alter table TRANSACAO
add foreign key (ID_CONTA)
references CONTA(ID);

-- Criando índices
create index IDX_TRANSACAO_TP_TRANSACAO
on TRANSACAO (TIPO_TRANSACAO);

create index IDX_TRANSACAO_DATA_HORA
on TRANSACAO (DATA_HORA);

