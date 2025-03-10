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

-- Visuaizar todas as ocorrências em Plants, listar todos os registros de dados
select * from `Plants`;

-- Visualizar colunas específicas
select Plant_Name, Sensor_Value, Sensor_Event
from Plants;

-- Inserir dados na tabela / entidade plants
insert into Plants (Plant_Name, Sensor_Value)
values ('Rosa', 0.2319);

-- Inserir múltiplos registros de uma vez 
insert into Plants (Plant_Name, Sensor_Value)
Values ('Cactus', 0.2411), ('Girassol', 0.3112), ('Orquídea', 0.4102), ('Lírio', 0.5566);

-- Consulta aplicando filtros
select * from Plants where Plant_Name = 'Cactus';

-- Filtros compostos com operadores AND OR XOR etc
select * from Plants where Plant_Name <> 'Cannabis' and Sensor_Value < 0.5566 and Sensor_Value > 0.2411;

