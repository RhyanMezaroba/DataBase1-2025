create database Imobiliaria;
use Imobiliaria;

create table `Imovel` (
	`ID_Imovel` int not null,
    `Imovel_Name` varchar(50) not null,
    `Room_Number` int not null,
    `Price` float not null,
    primary key `PK_Imovel` (`ID_Imovel`) 
);

select * from `Imovel`;

INSERT INTO Imovel (ID_Imovel, Imovel_Name, Room_Number, Price) VALUES
(1, 'Casa 1', 4, 675000.00),
(2, 'Casa 2', 3, 550000.00),
(3, 'Apartamento 1', 2, 350000.00),
(4, 'Casa 3', 5, 800000.00),
(5, 'Apartamento 2', 3, 450000.00),
(6, 'Casa 4', 4, 700000.00),
(7, 'Apartamento 3', 1, 300000.00),
(8, 'Casa 5', 3, 600000.00),
(9, 'Apartamento 4', 2, 400000.00),
(10, 'Casa 6', 5, 850000.00);

select * from Imovel;

select * from Imovel where ID_Imovel = 3;

Select * from Imovel where Price <= 500000
