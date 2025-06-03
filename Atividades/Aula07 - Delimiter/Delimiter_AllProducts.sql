DELIMITER $$
create procedure `GetAllProducts`()
begin
	/* Declaração de variáveis*/
    declare TOTALSALE dec(10,2) default 0.0;
    declare x, y, total, qtd int default 0;
    /*--------------------------------------*/
    
    /* Atributos de valroes */
    set TOTAL = 10;
    
    /* Carregando valores de um select em uma variável */
    select COUNT(*)
    into QTD
    FROM PRODUTO;
    
    select QTD;
    
    select * from PRODUTO;
    
end$$
DELIMITER ;

call `GetAllProducts`()