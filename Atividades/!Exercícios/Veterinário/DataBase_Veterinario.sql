create database VETERINARIO;

use VETERINARIO;

-- Tabela para os tipos de animais
create table TIPO_ANIMAL (
    ID int not null auto_increment primary key,
    NOME varchar(30) not null
);

-- Tabela para os animais
create table ANIMAIS (
    ID int not null auto_increment primary key,
    NOME varchar(100) not null,
    ID_TIPO_ANIMAL int not null,
    DATA_NASCIMENTO datetime not null,
    COR varchar(20),
    PESO float not null,
    ALTURA float not null,
    foreign key (ID_TIPO_ANIMAL) 
    references TIPO_ANIMAL(ID) -- Chave estrangeira para o tipo de animal
);

create table VACINAS (
    ID int not null auto_increment primary key,
    ID_ANIMAL int not null, -- Referência à tabela ANIMAIS
    NOME varchar(30) not null,
    DATA_APLICACAO datetime not null,
    foreign key (ID_ANIMAL) references ANIMAIS(ID) -- Chave estrangeira para o animal
);