DELIMITER $$

create procedure `GetProductById`(
	in pPRODUCTID int,
    out pPRODUCTLEVEL varchar(20)
)
begin
	declare VALOR decimal(10,2) default 0;
    
    select COUNT(*)
    into VALOR
    from PRODUTO as P
    where P.COD_PRODUTO = pPRODUCTID;
    
    if ( VALOR >= 5 and VALOR <=10 ) then
		set pPRODUCTLEVEL = 'CRÍTICO';
	elseif ( VALOR >= 10 and VALOR <=20 ) then
		set pPRODUCTLEVEL = 'PREOCUPANTE';
	elseif ( VALOR > 20 ) then
		set pPRODUCTLEVEL = 'TA SUAVE';
	else
		set pPRODUCTLEVEL = 'FUJA';
	end if;
end$$
DELIMITER ;

call GetProductById(1, @teste);

select @teste;