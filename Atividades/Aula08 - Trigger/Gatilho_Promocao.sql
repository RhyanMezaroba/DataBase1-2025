use NOTA_FISCAL_NORMALIZADA;

DELIMITER $$

create trigger PROMO_CHECK -- criado um gatilho que vai identificar se o produto está em promoção
before update on PRODUTO
for each row
begin
	declare NOME varchar(256);
    
    select DESC_PRODUTO
    into NOME
    from PRODUTO
    where COD_PRODUTO = new.COD_PRODUTO;
    
    if new.VL_PRODUTO < 100 then
		set new.DESC_PRODUTO = CONCAT('PROMOÇÃO', ' ', NOME);
	elseif new.VL_PRODUTO >= 100 and new.VL_PRODUTO <= 200 then
    set new.DESC_PRODUTO = concat('OFERTA', ' ', NOME);
    end if;
end$$

DELIMITER ;

drop trigger PROMO_CHECK;