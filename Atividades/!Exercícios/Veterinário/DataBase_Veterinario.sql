create database VETERINARIO;
use VETERINARIO;

create table TIPO_ANIMAL (
    ID int not null auto_increment primary key,
    NOME varchar(30) not null
);

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
    NOME varchar(30) not null,
    ID_ANIMAL int not null, -- Referência à tabela ANIMAIS
    DATA_APLICACAO datetime not null,
    foreign key (ID_ANIMAL)
    references ANIMAIS(ID) -- Chave estrangeira para o animal
    on delete cascade -- Permite deletar a vacina quando o animal for deletado
);

INSERT INTO TIPO_ANIMAL (Nome) VALUES 
('Canino'),
('Felino'),
('Suíno'),
('Caprino'),
('Equino');

INSERT INTO ANIMAIS (Nome, ID_Tipo_Animal, Data_Nascimento, Cor, Peso, Altura) VALUES 
('Rex', 1, '2020-05-10', 'Marrom', 25.30, 0.60),
('Texys', 1, '2021-07-20', 'Preto e Branco', 30.20, 0.70),
('Mia', 2, '2021-03-15', 'Branca', 4.50, 0.30),
('Babe', 3, '2019-08-20', 'Rosa', 80.00, 0.90),
('Thor', 4, '2018-07-22', 'Preto', 45.20, 1.10),
('Pé de Pano', 5, '2015-12-05', 'Marrom', 350.00, 1.80);

INSERT INTO VACINAS (Nome, Data_Aplicacao, ID_Animal) VALUES 
('Raiva', '2023-01-10', 1),
('V8', '2023-02-15', 1),
('Leucemia Felina', '2023-03-20', 2),
('Aftosa', '2023-04-10', 3),
('Clostridial', '2023-05-05', 4),
('Influenza Equina', '2023-06-15', 5);

-- Update, atualizando dados de colunas em tabelas
update VACINAS
set Data_aplicacao = '2025-01-15', ID_Animal = 1
where Nome = 'Raiva';

-- Delete, excluindo registros de tabelas
delete from VACINAS
where Nome = 'Aftosa';

insert into VACINAS (Nome, Data_Aplicacao, ID_Animal) values
('Raiva Avançada', '2025-03-25', 2);

delete from VACINAS where NOME = 'Raiva'; 