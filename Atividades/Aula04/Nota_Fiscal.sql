create database NOTA_FISCAL_NORMALIZADA;

use `NOTA_FISCAL_NORMALIZADA`;

create table `NOTA_FISCAL`(
	`NRO_NOTA` int not null auto_increment primary key,
    `NM_CLIENTE` varchar(256) not null,
    `END_CLIENTE` varchar (256) not null,
    `NM_VENDEDOR` varchar (256) not null,
    `DT_EMISSAO` datetime default current_timestamp,
    `VL_TOTAL` float not null
);
    
create table `PRODUTO` (
	`COD_PRODUTO` int not null auto_increment primary key,
    `DESC_PRODUTO` varchar (256) not null,
    `UN_MED` char(2) not null,
    `VL_PRODUTO` float not null
);

create table `ITEM_NOTA_FISCAL` (
	`NRO_NOTA` int not null,
    `COD_PRODUTO` int not null,
    `QTD_PRODUTO` int not null,
    `VL_PRECO` float not null,
    `VL_TOTAL` float not null,
    primary key (NRO_NOTA, COD_PRODUTO),
    constraint FK_NRO_NOTA_NOTA_FISCAL
		foreign key (NRO_NOTA)
        references NOTA_FISCAL (NRO_NOTA),
	constraint FK_COD_PRODUTO_PRODUTO
		foreign key (COD_PRODUTO)
        references PRODUTO (COD_PRODUTO)
);

insert into `NOTA_FISCAL` (NM_CLIENTE, END_CLIENTE, NM_VENDEDOR, VL_TOTAL) values
('Aragorn', 'Terra Média', 'Bilbo', 100.00),
('Gandalf', 'Terra Média', 'Frodo', 100.00),
('Boromir', 'Mordor', 'Sam', 100.00);

insert into `PRODUTO` (COD_PRODUTO, DESC_PRODUTO, UN_MED, VL_PRODUTO) values
(1, 'Produto1', 'UN' , 90.00),
(2, 'Produto2', 'UN' , 40.00),
(3, 'Produto3', 'UN' , 10.00);

insert into `ITEM_NOTA_FISCAL` (NRO_NOTA, COD_PRODUTO, QTD_PRODUTO, VL_PRECO, VL_TOTAL) values
(1, 1, 1, 90.00, 90.00),
(1, 2, 2, 40.00, 80.00),
(1, 3, 2, 10.00, 20.00),
(2, 1, 1, 90.00, 90.00),
(2, 2, 2, 40.00, 80.00),
(2, 3, 2, 10.00, 20.00),
(3, 1, 1, 90.00, 90.00),
(3, 2, 2, 40.00, 80.00),
(3, 3, 2, 10.00, 20.00);

select * from PRODUTO where COD_PRODUTO = 3;

update PRODUTO
set VL_PRODUTO = 15
where COD_PRODUTO =3;