-- CRIAR BD 
create database greenhouse;

-- Definir BD como padrão / utilizável
use greenhouse;

-- Criar tabela / entidade
-- Plants entre crases ``
create table `Plants` (
	`Plant_Name` char(30) not null,
    `Sensor_Value` float default null,
    `Sensor_Event` timestamp not null default current_timestamp on update current_timestamp,
    primary key `PK_Plants` (`Plant_Name`)
);