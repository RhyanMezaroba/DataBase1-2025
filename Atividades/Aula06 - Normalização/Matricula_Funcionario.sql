create database FORMULARIO;
use FORMULARIO;

CREATE TABLE ENDERECO (
	ID int not null auto_increment primary key,
	LOGRADOURO varchar(100) not null,
	NUMERO varchar(10),
	BAIRRO varchar(50),
	CIDADE varchar(50) not null,
	ESTADO varchar(2) not null,
	CEP varchar(10),
	PAIS varchar(30) not null
);

-- Tabela principal de funcionários
create table FUNCIONARIO (
	MATRICULA int not null auto_increment primary key,
    NOME varchar(100) not null,
    NASCIMENTO date not null,
    NACIONALIDADE varchar(30) not null,
    SEXO enum('Masculino', 'Feminino', 'Animal') not null,
    ESTADO_CIVIL enum('Solteiro', 'Casado', 'Divorciado', 'Viúvo') not null,
    RG varchar(12) unique,
    CPF char(14) unique not null,
    ENDERECO_ID int not null,
    ADMISSAO_DATA date not null,
    foreign key (ENDERECO_ID) references ENDERECO(ID) on delete cascade
);

-- Tabela de cargos ocupados
create table CARGOS_OCUPADOS (
	ID int not null auto_increment primary key,
    FUNCIONARIO_ID int not null,
    CARGO varchar(50) not null,
    DATA_INICIO date not null,
    DATA_FIM date,
    foreign key (FUNCIONARIO_ID) references FUNCIONARIO(MATRICULA) on delete cascade
);

-- Tabela de lotação por departamento
create table DEPARTAMENTO_LOTACAO (
	ID int not null auto_increment primary key,
    FUNCIONARIO_ID int not null,
    DEPARTAMENTO varchar(50) not null,
    DATA_INICIO date not null,
    DATA_FIM date,
    foreign key (FUNCIONARIO_ID) references FUNCIONARIO(MATRICULA) on delete cascade
);

-- Tabela de dependentes
create table DEPENDENTES (
	ID int auto_increment primary key,
    FUNCIONARIO_ID int not null,
	NOME varchar(100) not null,
    NASCIMENTO date not null,
    SEXO enum('Masculino', 'Feminino', 'Animal') not null,
    RG varchar(12),
    CPF char(14) unique not null,
    foreign key (FUNCIONARIO_ID) references FUNCIONARIO(MATRICULA) on delete cascade
);

INSERT INTO ENDERECO
  (ID, LOGRADOURO, NUMERO, BAIRRO, CIDADE, ESTADO, CEP, PAIS)
VALUES
  (1, 'Núcleo da Paz',        NULL, 'Jardim Leblon',          'Carvalho de Minas', 'RN', '17868-853',  'Brasil'),
  (2, 'Vila Thiago das Neves','83',  'Vila Cloris',       	  'Correia do Campo',  'PR', '89063-259',  'Brasil'),
  (3, 'Rua do Sol',           '45',  'Centro',            	  'Salvador',          'BA', NULL,         'Brasil'),
  (4, 'Av. das Palmeiras',    '100', 'Paulista',              'Rio de Janeiro',    'RJ', NULL,         'Brasil'),
  (5, 'Rua da Saudade',       '12',  'Costa Boa',             'Lisboa',            'PI', NULL,         'Portugal'),
  (6, 'Rua do Campo',         '21',  'Centro Uruguai',        'Curitiba',          'PR', NULL,         'Brasil'),
  (7, 'Av. das Nações',       '300', 'Legacio',               'Luanda',            'JI', NULL,         'Angola'),
  (8, 'Rua Azul',             '90',  'Guimarães',             'Recife',            'PE', NULL,         'Brasil'),
  (9, 'Av. Central',          '60',  'Centro Liga Norte',     'Porto Alegre',      'RS', NULL,         'Brasil'),
  (10,'Calle Libertad',       '50',  'Centro',                'Buenos Aires',      'LM', NULL,         'Argentina'),
  (11,'Rua do Mercado',       '77',  'Paulistana',            'Fortaleza',         'CE', NULL,         'Brasil'),
  (12,'Rua das Flores',       '23',  'Fortal',                'Goiânia',           'GO', NULL,         'Brasil'),
  (13,'Rua Chile',            '78',  'Fazenda',               'Santiago',          'HM', NULL,         'Chile'),
  (14,'Rua Laranja',          '15',  'Porto',                 'Belém',             'PA', NULL,         'Brasil'),
  (15,'Rua Brasil',           '100', 'Costa Grossa',          'São Paulo',         'SP', NULL,         'Brasil'),
  (16,'Rua da Praia',         '32',  'Buenhopólis',           'Montevideo',        'PI', NULL,         'Uruguai'),
  (17,'Rua da Alegria',       '88',  'Atabum',                'Salvador',          'BA', NULL,         'Brasil'),
  (18,'Carrera 45',           NULL,  'Centro',                'Bogotá',            'CL', NULL,         'Colômbia'),
  (19,'Rua das Árvores',      '29',  'Zona Leste',            'Campinas',          'SP', NULL,         'Brasil'),
  (20,'Rua das Rosas',        '50',  'Casa Velha',            'Teresina',          'PI', NULL,         'Brasil');

INSERT INTO FUNCIONARIO (NOME, NASCIMENTO, NACIONALIDADE, SEXO, ESTADO_CIVIL, RG, CPF, ENDERECO_ID, ADMISSAO_DATA)
VALUES 
('Bárbara da Luz', '1992-06-21', 'Egito', 'Animal', 'Casado', '51741145', '70924631570', 1, '2022-07-24'),
('Alícia Porto', '1998-08-04', 'Guam', 'Feminino', 'Divorciado', '407909199', '26051798340', 2, '2020-03-27'),
('Lucas Almeida', '1985-03-15', 'Brasil', 'Masculino', 'Casado', '121212121', '12345678901', 3, '2018-09-15'),
('Joana Silva', '1990-11-22', 'Brasil', 'Feminino', 'Solteiro', '232323232', '23456789012', 4, '2019-01-10'),
('Carlos Souza', '1978-06-30', 'Portugal', 'Masculino', 'Divorciado', '343434343', '34567890123', 5, '2021-03-05'),
('Fernanda Costa', '1982-12-05', 'Brasil', 'Feminino', 'Casado', '454545454', '45678901234', 6, '2022-06-18'),
('André Mendes', '1995-07-19', 'Angola', 'Masculino', 'Solteiro', '565656565', '56789012345', 7, '2023-01-01'),
('Mariana Lopes', '1987-04-11', 'Brasil', 'Feminino', 'Viúvo', '676767676', '67890123456', 8, '2020-10-30'),
('Thiago Ramos', '1993-09-25', 'Brasil', 'Masculino', 'Solteiro', '787878787', '78901234567', 9, '2019-12-12'),
('Paula Rocha', '1988-02-14', 'Argentina', 'Feminino', 'Casado', '898989898', '89012345678', 10, '2021-08-08'),
('Henrique Dias', '1975-08-20', 'Brasil', 'Masculino', 'Casado', '909090909', '90123456789', 11, '2017-07-07'),
('Lívia Martins', '1991-05-03', 'Brasil', 'Feminino', 'Solteiro', '112233445', '11223344556', 12, '2022-02-02'),
('Rafael Nunes', '1986-01-17', 'Chile', 'Masculino', 'Divorciado', '223344556', '22334455667', 13, '2016-05-05'),
('Juliana Teixeira', '1994-10-29', 'Brasil', 'Feminino', 'Casado', '334455667', '33445566778', 14, '2019-11-11'),
('Eduardo Vieira', '1983-03-07', 'Brasil', 'Masculino', 'Solteiro', '445566778', '44556677889', 15, '2020-04-04'),
('Tatiane Melo', '1996-12-30', 'Uruguai', 'Feminino', 'Solteiro', '556677889', '55667788990', 16, '2021-06-06'),
('Rodrigo Ferreira', '1997-07-07', 'Brasil', 'Masculino', 'Solteiro', '667788990', '66778899001', 17, '2020-10-10'),
('Camila Barbosa', '1989-09-09', 'Colômbia', 'Feminino', 'Viúvo', '778899001', '77889900112', 18, '2018-08-08'),
('Bruno Lima', '1990-02-20', 'Brasil', 'Masculino', 'Casado', '889900112', '88990011223', 19, '2021-09-09'),
('Ana Clara Pinto', '1984-06-15', 'Brasil', 'Feminino', 'Casado', '990011223', '99001122334', 20, '2015-05-15');

INSERT INTO CARGOS_OCUPADOS (FUNCIONARIO_ID, CARGO, DATA_INICIO, DATA_FIM) VALUES
(1, 'Analista de Sistemas', '2019-01-01', '2021-06-30'),
(2, 'Desenvolvedor Back-end', '2020-03-01', '2023-01-15'),
(3, 'Gerente de Projetos', '2018-05-20', '2022-12-31'),
(4, 'Analista de RH', '2019-07-01', '2023-05-10'),
(5, 'Coordenador Financeiro', '2020-02-15', '2023-04-20'),
(6, 'Designer UX/UI', '2021-08-01', '2023-08-01'),
(7, 'Estagiário de TI', '2023-01-01', '2024-01-01'),
(8, 'Scrum Master', '2020-11-01', '2022-11-01'),
(9, 'Analista de Dados', '2019-04-01', '2022-04-01'),
(10, 'Suporte Técnico', '2021-01-01', '2022-01-01'),
(11, 'Diretor Comercial', '2017-01-01', '2020-01-01'),
(12, 'Assistente Administrativo', '2022-03-01', '2023-03-01'),
(13, 'Desenvolvedor Back-end Junior', '2019-03-01', '2022-05-27'),
(14, 'Desenvolvedor Back-end Senior', '2022-05-19', '2023-01-15'),
(15, 'Desenvolvedor Back-end Pleno', '2017-08-01', '2019-03-01'),
(16, 'Estagiário de Manutenção', '2023-01-01', '2024-01-01'),
(17, 'Scrum Master', '2020-11-01', '2022-11-01'),
(18, 'Constrole de Qualidade', '2019-04-01', '2022-04-01'),
(19, 'Suporte Técnico', '2021-01-01', '2022-01-01'),
(20, 'Diretor Empresarial', '2017-01-01', '2020-01-01');

INSERT INTO DEPARTAMENTO_LOTACAO (FUNCIONARIO_ID, DEPARTAMENTO, DATA_INICIO, DATA_FIM) VALUES
(1, 'TI', '2019-01-01', '2021-06-30'),
(2, 'Desenvolvimento', '2020-03-01', '2023-01-15'),
(3, 'Projetos', '2018-05-20', '2022-12-31'),
(4, 'Recursos Humanos', '2019-07-01', '2023-05-10'),
(5, 'Financeiro', '2020-02-15', '2023-04-20'),
(6, 'Design', '2021-08-01', '2023-08-01'),
(7, 'Tecnologia', '2023-01-01', '2024-01-01'),
(8, 'Agilidade', '2020-11-01', '2022-11-01'),
(9, 'Análise de Dados', '2019-04-01', '2022-04-01'),
(10, 'Suporte', '2021-01-01', '2022-01-01'),
(11, 'Comercial', '2017-01-01', '2020-01-01'),
(12, 'Administrativo', '2022-03-01', '2023-03-01'),
(13, 'TI', '2019-01-01', '2021-06-30'),
(14, 'Desenvolvimento', '2020-03-01', '2023-01-15'),
(15, 'Projetos', '2018-05-20', '2022-12-31'),
(16, 'Recursos Humanos', '2019-07-01', '2023-05-10'),
(17, 'Financeiro', '2020-02-15', '2023-04-20'),
(18, 'Design', '2021-08-01', '2023-08-01'),
(19, 'Tecnologia', '2023-01-01', '2024-01-01'),
(20, 'Agilidade', '2020-11-01', '2022-11-01');

INSERT INTO DEPENDENTES (FUNCIONARIO_ID, NOME, NASCIMENTO, SEXO, RG, CPF) VALUES
(1, 'Laura da Luz', '2010-04-15', 'Feminino', '123456781', '11111111111'),
(2, 'Gabriel Porto', '2012-09-30', 'Masculino', '123456782', '22222222222'),
(3, 'Lucas Almeida Filho', '2008-11-22', 'Masculino', '123456783', '33333333333'),
(3, 'Fernanda Almeida', '2015-06-14', 'Feminino', '123456784', '44444444444'),
(4, 'Beatriz Silva', '2007-07-10', 'Feminino', '123456785', '55555555555'),
(5, 'Carlos Souza Jr.', '2006-03-08', 'Masculino', '123456786', '66666666666'),
(6, 'Rafael Costa', '2011-12-01', 'Masculino', '123456787', '77777777777'),
(6, 'Daniela Costa', '2013-05-19', 'Feminino', '123456788', '88888888888'),
(7, 'Pedro Mendes', '2014-02-22', 'Masculino', '123456789', '99999999999'),
(8, 'Ana Lopes', '2010-08-15', 'Feminino', '123456790', '10101010101'),
(9, 'Tiago Ramos Jr.', '2016-01-05', 'Masculino', '123456791', '12121212121'),
(10, 'Mariana Rocha', '2009-11-25', 'Feminino', '123456792', '13131313131'),
(11, 'Henrique Dias Filho', '2005-12-12', 'Masculino', '123456793', '14141414141'),
(12, 'Lucas Martins', '2013-03-03', 'Masculino', '123456794', '15151515151'),
(13, 'Juliana Nunes', '2014-06-16', 'Feminino', '123456795', '16161616161'),
(14, 'Eduardo Teixeira', '2011-07-20', 'Masculino', '123456796', '17171717171'),
(15, 'Tatiane Vieira', '2008-10-10', 'Feminino', '123456797', '18181818181');

-- 1. Lista de todos os funcionários
SELECT * FROM FUNCIONARIO;

-- 2. Funcionários com cargo de 'Gerente'
SELECT f.NOME, c.CARGO 
FROM FUNCIONARIO f 
JOIN CARGOS_OCUPADOS c ON f.MATRICULA = c.FUNCIONARIO_ID 
WHERE c.CARGO = 'Gerente';

-- 3. Funcionários do departamento de 'TI'
SELECT f.NOME, d.DEPARTAMENTO 
FROM FUNCIONARIO f 
JOIN DEPARTAMENTO_LOTACAO d ON f.MATRICULA = d.FUNCIONARIO_ID 
WHERE d.DEPARTAMENTO = 'TI';

-- 4. Funcionários admitidos após 2020
SELECT NOME, ADMISSAO_DATA 
FROM FUNCIONARIO 
WHERE ADMISSAO_DATA > '2020-01-01';

-- 5. Número de funcionários por sexo
SELECT SEXO, COUNT(*) 
FROM FUNCIONARIO 
GROUP BY SEXO;

-- 6. Funcionários com dependentes
SELECT DISTINCT f.NOME 
FROM FUNCIONARIO f 
JOIN DEPENDENTES d ON f.MATRICULA = d.FUNCIONARIO_ID;

-- 7. Total de dependentes por funcionário
SELECT FUNCIONARIO_ID, COUNT(*) AS TOTAL_DEPENDENTES 
FROM DEPENDENTES 
GROUP BY FUNCIONARIO_ID;

-- 8. Funcionários que são 'Casado'
SELECT NOME 
FROM FUNCIONARIO 
WHERE ESTADO_CIVIL = 'Casado';

-- 9. Funcionários com idade maior que 40 anos
SELECT NOME, YEAR(CURDATE()) - YEAR(NASCIMENTO) AS IDADE 
FROM FUNCIONARIO 
WHERE YEAR(CURDATE()) - YEAR(NASCIMENTO) > 40;

-- 10. Funcionários ordenados por data de admissão
SELECT NOME, ADMISSAO_DATA 
FROM FUNCIONARIO 
ORDER BY ADMISSAO_DATA ASC;

-- 11. Listar cada funcionário com seu endereço completo
SELECT 
  f.MATRICULA,
  f.NOME,
  e.LOGRADOURO,
  e.NUMERO,
  e.BAIRRO,
  e.CIDADE,
  e.ESTADO,
  e.CEP,
  e.PAIS
FROM FUNCIONARIO f
JOIN ENDERECO e ON f.ENDERECO_ID = e.ID;

-- 12. Contar quantos funcionários moram em cada cidade
SELECT 
  e.CIDADE,
  COUNT(*) AS TOTAL_FUNCIONARIOS
FROM FUNCIONARIO f
JOIN ENDERECO e ON f.ENDERECO_ID = e.ID
GROUP BY e.CIDADE
ORDER BY TOTAL_FUNCIONARIOS DESC;

-- 13. Listar endereços (logradouro + número) que têm mais de um funcionário
SELECT 
  e.LOGRADOURO,
  e.NUMERO,
  e.BAIRRO,
  e.CIDADE,
  COUNT(*) AS QTD_FUNCIONARIOS
FROM FUNCIONARIO f
JOIN ENDERECO e ON f.ENDERECO_ID = e.ID
GROUP BY e.LOGRADOURO, e.NUMERO, e.BAIRRO, e.CIDADE
HAVING COUNT(*) > 1;

-- Atualizar Cargos
UPDATE CARGOS_OCUPADOS 
SET CARGO = 'Engenheiro de Software', DATA_INICIO = '2020-01-01', DATA_FIM = '2023-01-01' 
WHERE FUNCIONARIO_ID = 16;

UPDATE CARGOS_OCUPADOS 
SET CARGO = 'Especialista em Redes', DATA_INICIO = '2021-02-15', DATA_FIM = '2023-02-15' 
WHERE FUNCIONARIO_ID = 17;

UPDATE CARGOS_OCUPADOS 
SET CARGO = 'Arquiteto de Soluções', DATA_INICIO = '2018-05-10', DATA_FIM = '2022-05-10' 
WHERE FUNCIONARIO_ID = 18;

UPDATE CARGOS_OCUPADOS 
SET CARGO = 'Analista de Segurança', DATA_INICIO = '2019-09-01', DATA_FIM = '2022-09-01' 
WHERE FUNCIONARIO_ID = 19;

UPDATE CARGOS_OCUPADOS 
SET CARGO = 'Desenvolvedor Front-end', DATA_INICIO = '2020-06-20', DATA_FIM = '2023-06-20' 
WHERE FUNCIONARIO_ID = 20;