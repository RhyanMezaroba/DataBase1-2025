CREATE DATABASE UNIVERSIDADE;
USE UNIVERSIDADE;

-- Criação de tabela simposio
-- Armazenamento de ID como chave primária
-- Nome do mini curso ou artigo
-- Datas de início e fim das apresentações / artigos
CREATE TABLE SIMPOSIO (
    ID_SIMPOSIO INT PRIMARY KEY,
    NOME VARCHAR(50),
    DATA_INICIO DATE,
    DATA_FIM DATE
);

-- Criação de tabela pessoa
-- Armazenamento de ID como chave primária
-- Nome da pessoa
-- Email da pessoa
-- Idade da pessoa
CREATE TABLE PESSOA (
    ID_PESSOA INT PRIMARY KEY,
    NOME VARCHAR(50),
    EMAIL VARCHAR(50),
    IDADE INT
);

-- Criação de tabela minicurso
-- Armazenamento de ID como chave primária
-- Titulo do minicurso
-- Descrição do minicurso
-- Data de início e fim da apresentação do minicurso
-- Relação de chave estrangeira para referenciar as tabelas PESSOA e SIMPOSIO (linkando elas)
CREATE TABLE MINICURSO (
    ID_MINICURSO INT PRIMARY KEY,
    TITULO VARCHAR(50),
    DESCRICAO TEXT,
    DATA_INICIO DATE,
    DATA_FIM DATE,
    ID_PESSOA INT,
    ID_SIMPOSIO INT,
    FOREIGN KEY (ID_PESSOA) REFERENCES PESSOA(ID_PESSOA),
    FOREIGN KEY (ID_SIMPOSIO) REFERENCES SIMPOSIO(ID_SIMPOSIO)
);

-- Criação de tabela tema
-- Armazenamento de ID como chave primária
-- Armazenamento de tema que fará relação com artigo e comissão
CREATE TABLE TEMA(
	ID_TEMA INT PRIMARY KEY,
    NOME_TEMA VARCHAR(50),
    ID_SIMPOSIO INT, 
    FOREIGN KEY (ID_SIMPOSIO) REFERENCES SIMPOSIO (ID_SIMPOSIO)
);

-- Criação de tabela artigo
-- Armazenamento do titulo do artigo
-- Armazenamento de um resumo do artigo
-- Relação de chave estrangeira para referenciar as tabelas SIMPOSIO e TEMA (linkando elas)
CREATE TABLE ARTIGO (
    ID_ARTIGO INT PRIMARY KEY,
    TITULO VARCHAR(50),
    RESUMO TEXT,
    ID_TEMA INT,
    ID_SIMPOSIO INT,
    FOREIGN KEY (ID_SIMPOSIO) REFERENCES SIMPOSIO(ID_SIMPOSIO),
    FOREIGN KEY (ID_TEMA) REFERENCES TEMA(ID_TEMA)
);

-- Criação de tabela comissao cientifica
-- Relação de chave estrangeira para referenciar as tabelas SIMPOSIO e TEMA (linkando elas)
CREATE TABLE COMISSAO_CIENTIFICA (
    ID_COMISSAO INT PRIMARY KEY,
    ID_TEMA INT,
    ID_SIMPOSIO INT,
    FOREIGN KEY (ID_SIMPOSIO) REFERENCES SIMPOSIO(ID_SIMPOSIO),
	FOREIGN KEY (ID_TEMA) REFERENCES TEMA(ID_TEMA)
);

-- Criação de tabela parecer
-- Armazenamento de descrição do parecer referente ao artigo
-- Armazenamento da data que foi feito o parecer
-- Relação ede chave estrangeira para referenciar as tabelas ARTIGO e COMISSAO_CIENTIFICA
CREATE TABLE PARECER (
    ID_PARECER INT PRIMARY KEY,
    DESCRICAO TEXT,
    DATA DATE,
    ID_ARTIGO INT,
    ID_COMISSAO INT,
    FOREIGN KEY (ID_ARTIGO) REFERENCES ARTIGO(ID_ARTIGO),
    FOREIGN KEY (ID_COMISSAO) REFERENCES COMISSAO_CIENTIFICA(ID_COMISSAO)
);

-- Criação de tabela INSCRICAO
-- Armazenamento de uma ID como chave primária
-- Armazenamento da data que foi feito a inscrição
-- Relação de chave estrangeira para referenciar as tabelas PESSOA e SIMPOSIO
CREATE TABLE INSCRICAO (
    ID_INSCRICAO INT PRIMARY KEY,
    DATA_INSCRICAO DATE,
    ID_PESSOA INT,
    FOREIGN KEY (ID_PESSOA) REFERENCES PESSOA(ID_PESSOA)
);

-- Criação de tabela INSCRICAO_MINICURSO
-- Relação de chave estrangeira para referenciar as tabelas INSCRICAO e MINICURSO
CREATE TABLE INSCRICAO_MINICURSO (
    ID_INSCRICAO INT,
	ID_MINICURSO INT,
    PRIMARY KEY (ID_INSCRICAO, ID_MINICURSO),
    FOREIGN KEY (ID_INSCRICAO) REFERENCES INSCRICAO(ID_INSCRICAO),
    FOREIGN KEY (ID_MINICURSO) REFERENCES MINICURSO(ID_MINICURSO)
);

-- Criação de tabela ARTIGO_AUTOR
-- Relação de chave estrangeira para referenciar as tabelas ARTIGO e PESSOA
CREATE TABLE ARTIGO_AUTOR (
    ID_ARTIGO INT,
    ID_PESSOA INT,
    PRIMARY KEY (ID_ARTIGO, ID_PESSOA),
    FOREIGN KEY (ID_ARTIGO) REFERENCES ARTIGO(ID_ARTIGO),
    FOREIGN KEY (ID_PESSOA) REFERENCES PESSOA(ID_PESSOA)
);

-- Criação de tabela COMISSAO_PESSOA
-- Relação de chave estrangeira para referenciar as tabelas COMISSAO_CIENTIFICA e PESSOA
CREATE TABLE COMISSAO_PESSOA (
    ID_COMISSAO INT,
    ID_PESSOA INT,
    PRIMARY KEY (ID_COMISSAO, ID_PESSOA),
    FOREIGN KEY (ID_COMISSAO) REFERENCES COMISSAO_CIENTIFICA(ID_COMISSAO),
    FOREIGN KEY (ID_PESSOA) REFERENCES PESSOA(ID_PESSOA)
);

-- Inserindo Semeadura de Dados

-- Inserindo dados na tabela SIMPOSIO
INSERT INTO SIMPOSIO (ID_SIMPOSIO, NOME, DATA_INICIO, DATA_FIM) VALUES
(1, 'Simpósio de Tecnologia', '2025-03-31', '2025-04-06');

-- Inserindo dados na tabela PESSOA
INSERT INTO PESSOA (ID_PESSOA, NOME, EMAIL, IDADE) VALUES
(1, 'João da Silva', 'joao.silva@email.com', 19),
(2, 'Maria Oliveira', 'maria.oliveira@email.com', 23),
(3, 'Carlos Souza', 'carlos.souza@email.com', 25),
(4, 'Ana Pereira', 'ana.pereira@email.com', 27),
(5, 'Ricardo Santos', 'ricardo.santos@email.com', 34),
(6, 'Fernanda Lima', 'fernanda.lima@email.com', 22),
(7, 'Thigo Thomasi', 'rolisso@gmail.com', 19),
(8, 'Thiago Balbinot', 'magrão@gmail.com', 19),
(9, 'Mateus Ferreira', 'megamente@gmail.com', 20),
(10, 'Rhyan', 'aqui.nabranch@gmail.com', 19),
(11, 'Mauricio da Silva', 'mauricio.silva@gmail.com', 32),
(12, 'Fernanda Silva', 'fernanda.silva@email.com', 20),
(13, 'João Pedro', 'joao.pedro@email.com', 19),
(14, 'Maria Bastos', 'maria.bastos@email.com', 27),
(15, 'Carlos Assunção', 'carlos.assuncao@email.com', 25),
(16, 'Ana Pinto', 'ana.pinto@email.com', 28);


-- Inserindo dados na tabela MINICURSO
INSERT INTO MINICURSO (ID_MINICURSO, TITULO, DESCRICAO, DATA_INICIO, DATA_FIM, ID_PESSOA, ID_SIMPOSIO) VALUES
(1, 'Introdução ao Banco de Dados', 'Conceitos básicos de BD', '2025-03-31', '2025-04-06', 1, 1),
(2, 'Redes de Computadores', 'Princípios de redes', '2025-03-31', '2025-04-06', 2, 1),
(3, 'Realidade Virtual', 'Desenvolvimento de aplicações VR', '2025-03-31', '2025-04-06', 3, 1);

-- Inserindo dados na tabela TEMA
INSERT INTO TEMA (ID_TEMA, NOME_TEMA, ID_SIMPOSIO) VALUES
(1, 'BANCO DE DADOS', 1),
(2, 'REDES', 1),
(3, 'REALIDADE VIRTUAL', 1),
(4, 'LINUX', 1),
(5, 'SERVIDORES', 1);

-- Inserindo dados na tabela ARTIGO
INSERT INTO ARTIGO (ID_ARTIGO, TITULO, RESUMO, ID_TEMA, ID_SIMPOSIO) VALUES
(1, 'O Futuro dos Bancos de Dados', 'Análise de tendências em BD', 1, 1),
(2, 'Segurança de Redes', 'Estudo sobre protocolos de segurança VPN', 2, 1),
(3, 'Aplicações de Realidade Virtual na Educação', 'Uso de VR no ensino', 3, 1),
(4, 'Aplicações em Linux', 'Ensinamentos básicos em Linux', 4, 1),
(5, 'Visão técnica em Servidores', 'Instalação e uso de Servidores', 5, 1);

-- Inserindo dados na tabela COMISSAO_CIENTIFICA
INSERT INTO COMISSAO_CIENTIFICA (ID_COMISSAO, ID_TEMA, ID_SIMPOSIO) VALUES
(1, 1, 1),
(2, 2, 1),
(3, 3, 1),
(4, 4, 1),
(5, 5, 1);

-- Inserindo dados na tabela PARECER
INSERT INTO PARECER (ID_PARECER, DESCRICAO, DATA, ID_ARTIGO, ID_COMISSAO) VALUES
(1, 'Artigo aprovado com ressalvas', '2025-04-05', 1, 1),
(2, 'Artigo recusado', '2025-04-05', 2, 2),
(3, 'Artigo aprovado', '2025-04-05', 3, 3),
(4, 'Artigo aprovado com ressalvas', '2025-04-05', 4, 4),
(5, 'Artigo aprovado', '2025-04-05', 5, 5);


-- Inserindo dados na tabela INSCRICAO
INSERT INTO INSCRICAO (ID_INSCRICAO, DATA_INSCRICAO, ID_PESSOA) VALUES
(1, '2025-03-30', 4),
(2, '2025-03-30', 5),
(3, '2025-03-30', 6),
(4, '2025-03-30', 1),
(5, '2025-03-30', 2),
(6, '2025-03-30', 3);

-- Inserindo dados na tabela INSCRICAO_MINICURSO
INSERT INTO INSCRICAO_MINICURSO (ID_INSCRICAO, ID_MINICURSO) VALUES
(1, 3),
(2, 2),
(3, 1);

-- Inserindo dados na tabela ARTIGO_AUTOR
INSERT INTO ARTIGO_AUTOR (ID_ARTIGO, ID_PESSOA) VALUES
(1, 4),
(2, 5),
(3, 6),
(4, 2),
(5, 3);

-- Inserindo dados na tabela COMISSAO_PESSOA
INSERT INTO COMISSAO_PESSOA (ID_COMISSAO, ID_PESSOA) VALUES
(1, 7),
(1, 8),
(2, 9),
(2, 10),
(3, 11),
(3, 12),
(4, 13),
(4, 14),
(5, 15),
(5, 16);