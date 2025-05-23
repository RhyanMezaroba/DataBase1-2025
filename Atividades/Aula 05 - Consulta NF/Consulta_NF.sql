use NOTA_FISCAL_NORMALIZADA;

-- Forma clássica de consultas combinadas
select NOTA_FISCAL.*, ITEM_NOTA_FISCAL.* -- .* Seleciona todas as colunas dentro dessas tabelas
from NOTA_FISCAL, ITEM_NOTA_FISCAL
where NOTA_FISCAL.NRO_NOTA = ITEM_NOTA_FISCAL.NRO_NOTA;

-- Podemos definir ALIAS(apelidos) para as tabelas e facilitar a codificação. Utilizando o AS (ALIAS)
select NF.NRO_NOTA, NF.DT_EMISSAO, NF.VL_TOTAL,
INF.COD_PRODUTO, P.DESC_PRODUTO, P.UN_MED,
INF.QTD_PRODUTO, INF.VL_PRECO, INF.VL_TOTAL

from 
	NOTA_FISCAL as NF, 
	ITEM_NOTA_FISCAL as INF,
    PRODUTO as P
where NF.NRO_NOTA = INF.NRO_NOTA
and INF.COD_PRODUTO = P.COD_PRODUTO
order by NF.NRO_NOTA desc, INF.COD_PRODUTO asc; -- Menor para o maior

-- Inner Join
select NF.NRO_NOTA, NF.DT_EMISSAO, NF.VL_TOTAL,
INF.COD_PRODUTO, P.DESC_PRODUTO, P.UN_MED,
INF.QTD_PRODUTO, INF.VL_PRECO, INF.VL_TOTAL

from 
	NOTA_FISCAL as NF
    inner join 
		ITEM_NOTA_FISCAL as INF on NF.NRO_NOTA = INF.NRO_NOTA
    inner join
        PRODUTO as P on INF.COD_PRODUTO = P.COD_PRODUTO
where NF.NRO_NOTA = 2 -- Podemos trocar para o valor da nota que queremos buscar
order by 
	NF.NRO_NOTA desc, INF.COD_PRODUTO asc;

-- Funções de agregação
-- Contando e quantificando registros
 
 -- Quantas notas fiscais tem emitidas?
select COUNT(*)
from NOTA_FISCAL;

-- Notas fiscais por período
select COUNT(*)
from NOTA_FISCAL
where DT_EMISSAO between '2025-03-21' and '2025-03-25';

-- Total de notas no ano
select COUNT(*)
from NOTA_FISCAL
where YEAR(DT_EMISSAO = 2025);

-- Max() --> Obtendo o cliente que mais comprou determinado produto em uma única NF
select NF.NM_CLIENTE as CLIENTE,
P.DESC_PRODUTO as PRODUTO,
MAX(QTD_PRODUTO) as QTD
from ITEM_NOTA_FISCAL as INF
inner join NOTA_FISCAL as NF
	on INF.NRO_NOTA = NF.NRO_NOTA
inner join PRODUTO as P
	on INF.COD_PRODUTO = P.COD_PRODUTO
where INF.COD_PRODUTO = 2
group by NF.NM_CLIENTE, P.DESC_PRODUTO
order by CLIENTE, QTD desc;