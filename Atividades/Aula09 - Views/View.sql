-- CRIANDO VIEW PERSONALIZADA

create view DAYSOFWEEK as
select 'SEGUNDA-FEIRA'
union -- Vai unir e apresentar as tabelas horizontalmente
select 'TERÇA-FEIRA'
union
select 'QUARTA-FEIRA'
union
select 'QUINTA-FEIRA'
union
select 'SEXTA-FEIRA'
union
select 'SÁBADO'
union
select 'DOMINGO';

select * from DAYSOFWEEK;

drop view DAYSOFWEEK;