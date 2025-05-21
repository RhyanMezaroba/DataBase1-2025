create database FORMULARIO;
use FORMULARIO;

create table FUNCIONARIO (
	MATRICULA int not null auto_increment primary key,
    NOME varchar(100) not null,
    NASCIMENTO date not null,
    NACIONALIDADE varchar(30) not null,
    SEXO enum('Masculino', 'Feminino', 'Animal') not null,
    ESTADO_CIVIL enum('Solteiro', 'Casado', 'Divorciado', 'Viúvo') not null,
    RG char(9) unique,
    CPF char(11) unique not null,
    ENDEREÇO varchar(100) not null,
    ADMISSAO_DATA date not null
);

create table CARGOS_OCUPADOS (
	ID int not null auto_increment primary key,
    CARGO varchar(50),
    DATA_INICIO date,
    DATA_FIM date
);

create table DEPARTAMENTO_LOTACAO (
	ID int not null auto_increment primary key,
    DEPARTAMENTO varchar(50),
    DATA_INICIO date,
    DATA_FIM date
);

create table DEPENDENTES (
	ID int auto_increment primary key,
	NOME varchar(100) not null,
    NASCIMENTO date not null,
    SEXO enum('Masculino', 'Feminino', 'Animal') not null,
    RG char(9) unique,
    CPF char(11) unique not null
    foreign key (FUNCIONARIO) references FUNCIONARIO(MATRICULA) on delete cascade
);