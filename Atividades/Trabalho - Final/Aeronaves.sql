CREATE DATABASE TRANSPORTE_AEREO;
USE TRANSPORTE_AEREO;

CREATE TABLE AERONAVE (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    TIPO VARCHAR(100) NOT NULL,
    NUMERO_POLTRONAS INT NOT NULL
);

CREATE TABLE POLTRONA (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    ID_AERONAVE INT NOT NULL,
    NUMERO_POLTRONA VARCHAR(5) NOT NULL,
    LOCALIZACAO ENUM('JANELA', 'CORREDOR', 'MEIO') NOT NULL,
    LADO ENUM('ESQUERDA', 'DIREITA') NOT NULL,
    DISPONIVEL BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (ID_AERONAVE) REFERENCES AERONAVE(ID)
);

CREATE TABLE AEROPORTO (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    NOME VARCHAR(100) NOT NULL,
    CIDADE VARCHAR(100),
    ESTADO VARCHAR(100),
    PAIS VARCHAR(100)
);

CREATE TABLE VOO (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    ID_AERONAVE INT NOT NULL,
    ID_ORIGEM INT NOT NULL,
    ID_DESTINO INT NOT NULL,
    HORARIO_SAIDA DATETIME NOT NULL,
    HORARIO_CHEGADA DATETIME NOT NULL,
    FOREIGN KEY (ID_AERONAVE) REFERENCES AERONAVE(ID),
    FOREIGN KEY (ID_ORIGEM) REFERENCES AEROPORTO(ID),
    FOREIGN KEY (ID_DESTINO) REFERENCES AEROPORTO(ID)
);

CREATE TABLE ESCALA (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    ID_VOO INT NOT NULL,
    ID_AEROPORTO_ESCALA INT NOT NULL,
    HORARIO_CHEGADA DATETIME NOT NULL,
    HORARIO_SAIDA DATETIME NOT NULL,
    FOREIGN KEY (ID_VOO) REFERENCES VOO(ID),
    FOREIGN KEY (ID_AEROPORTO_ESCALA) REFERENCES AEROPORTO(ID)
);

CREATE TABLE CLIENTE (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    NOME VARCHAR(100) NOT NULL,
    CPF VARCHAR(11) NOT NULL UNIQUE,
    IDADE INT,
    SEXO ENUM('MASCULINO', 'FEMININO') NOT NULL,
    PREFERENCIAL ENUM ('NORMAL' , 'PREFERENCIAL') NOT NULL
);

CREATE TABLE VOO_POLTRONA (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    ID_VOO INT NOT NULL,
    ID_POLTRONA INT NOT NULL,
    STATUS ENUM('DISPONIVEL', 'RESERVADO', 'OCUPADO', 'INDISPONIVEL') NOT NULL DEFAULT 'DISPONIVEL',
    UNIQUE (ID_VOO, ID_POLTRONA),
    FOREIGN KEY (ID_VOO) REFERENCES VOO(ID),
    FOREIGN KEY (ID_POLTRONA) REFERENCES POLTRONA(ID)
);

CREATE TABLE RESERVA (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    ID_CLIENTE INT NOT NULL,
    ID_VOO_POLTRONA INT NOT NULL,
    DATA_RESERVA DATETIME DEFAULT CURRENT_TIMESTAMP,
    STATUS_RESERVA ENUM('PENDENTE', 'CONFIRMADA', 'CANCELADA') DEFAULT 'PENDENTE',
    FOREIGN KEY (ID_CLIENTE) REFERENCES CLIENTE(ID),
    FOREIGN KEY (ID_VOO_POLTRONA) REFERENCES VOO_POLTRONA(ID)
);

CREATE TABLE LOG_CANCELAMENTOS (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    ID_RESERVA INT NOT NULL,
    DATA_HORA_CANCELAMENTO DATETIME NOT NULL,
    MOTIVO VARCHAR(255),
    FOREIGN KEY (ID_RESERVA) REFERENCES RESERVA(ID)
);

DELIMITER $$

CREATE TRIGGER TRG_AtualizaStatusPoltronaReserva
AFTER INSERT ON RESERVA
FOR EACH ROW
BEGIN
    UPDATE VOO_POLTRONA
    SET STATUS = 'RESERVADO'
    WHERE ID = NEW.ID_VOO_POLTRONA;
END$$

CREATE TRIGGER TRG_AtualizaStatusPoltronaCancelamento
AFTER UPDATE ON RESERVA
FOR EACH ROW
BEGIN
    IF OLD.STATUS_RESERVA != 'CANCELADA' AND NEW.STATUS_RESERVA = 'CANCELADA' THEN
        UPDATE VOO_POLTRONA
        SET STATUS = 'DISPONIVEL'
        WHERE ID = NEW.ID_VOO_POLTRONA;
    END IF;
END$$

DELIMITER ;

DELIMITER $$

CREATE PROCEDURE SP_RealizaReserva(
    IN p_ID_CLIENTE INT,
    IN p_ID_VOO_POLTRONA INT,
    OUT p_ID_RESERVA INT,
    OUT p_MENSAGEM VARCHAR(255)
)
BEGIN
    DECLARE v_status_poltrona VARCHAR(50);

    SELECT STATUS INTO v_status_poltrona
    FROM VOO_POLTRONA
    WHERE ID = p_ID_VOO_POLTRONA;

    IF v_status_poltrona = 'DISPONIVEL' THEN
        INSERT INTO RESERVA (ID_CLIENTE, ID_VOO_POLTRONA, STATUS_RESERVA)
        VALUES (p_ID_CLIENTE, p_ID_VOO_POLTRONA, 'CONFIRMADA');

        SET p_ID_RESERVA = LAST_INSERT_ID();
        SET p_MENSAGEM = 'Reserva realizada com sucesso!';
    ELSE
        SET p_ID_RESERVA = NULL;
        SET p_MENSAGEM = CONCAT('Poltrona ', p_ID_VOO_POLTRONA, ' não está disponível (Status: ', v_status_poltrona, ').');
    END IF;

END$$

DELIMITER ;

DELIMITER $$

CREATE FUNCTION FN_CalculaDuracaoVoo(p_ID_VOO INT)
RETURNS INT
READS SQL DATA
BEGIN
    DECLARE duracao_minutos INT;

    SELECT TIMESTAMPDIFF(MINUTE, HORARIO_SAIDA, HORARIO_CHEGADA)
    INTO duracao_minutos
    FROM VOO
    WHERE ID = p_ID_VOO;

    RETURN duracao_minutos;
END$$

DELIMITER ;

CREATE VIEW VW_VoosDisponiveis AS
SELECT
    V.ID AS ID_VOO,
    AER_O.NOME AS Aeroporto_Origem,
    AER_O.CIDADE AS Cidade_Origem,
    AER_D.NOME AS Aeroporto_Destino,
    AER_D.CIDADE AS Cidade_Destino,
    V.HORARIO_SAIDA,
    V.HORARIO_CHEGADA,
    AERO.TIPO AS Tipo_Aeronave,
    AERO.NUMERO_POLTRONAS AS Total_Poltronas_Aeronave,
    (SELECT COUNT(*) FROM VOO_POLTRONA VP WHERE VP.ID_VOO = V.ID AND VP.STATUS = 'DISPONIVEL') AS Poltronas_Disponiveis
FROM
    VOO V
INNER JOIN
    AEROPORTO AER_O ON V.ID_ORIGEM = AER_O.ID
INNER JOIN
    AEROPORTO AER_D ON V.ID_DESTINO = AER_D.ID
INNER JOIN
    AERONAVE AERO ON V.ID_AERONAVE = AERO.ID;

DELIMITER $$

CREATE TRIGGER TRG_LogCancelamentoReserva
AFTER UPDATE ON RESERVA
FOR EACH ROW
BEGIN
    IF OLD.STATUS_RESERVA != 'CANCELADA' AND NEW.STATUS_RESERVA = 'CANCELADA' THEN
        INSERT INTO LOG_CANCELAMENTOS (ID_RESERVA, DATA_HORA_CANCELAMENTO, MOTIVO)
        VALUES (NEW.ID, NOW(), 'Cancelamento feito pelo usuário ou sistema.');
    END IF;
END$$

CREATE PROCEDURE SP_CancelarReserva(
    IN p_ID_RESERVA INT,
    OUT p_MENSAGEM VARCHAR(255)
)
BEGIN
    DECLARE v_status_atual VARCHAR(50);

    SELECT STATUS_RESERVA INTO v_status_atual
    FROM RESERVA
    WHERE ID = p_ID_RESERVA;

    IF v_status_atual IS NULL THEN
        SET p_MENSAGEM = 'Reserva não encontrada.';
    ELSEIF v_status_atual = 'CANCELADA' THEN
        SET p_MENSAGEM = 'A reserva já estava cancelada.';
    ELSE
        UPDATE RESERVA
        SET STATUS_RESERVA = 'CANCELADA'
        WHERE ID = p_ID_RESERVA;

        SET p_MENSAGEM = 'Reserva cancelada com sucesso.';
    END IF;
END$$

CREATE FUNCTION FN_QuantidadeReservasCliente(p_ID_CLIENTE INT)
RETURNS INT
READS SQL DATA
BEGIN
    DECLARE total_reservas INT;

    SELECT COUNT(*) INTO total_reservas
    FROM RESERVA
    WHERE ID_CLIENTE = p_ID_CLIENTE;

    RETURN total_reservas;
END$$

DELIMITER ;

-- Frequência de Clientes
-- Fazendo o cliente 1 ter 3 reservas
CALL SP_RealizaReserva(1, 1, @id1, @msg1);
CALL SP_RealizaReserva(1, 2, @id2, @msg2);
CALL SP_RealizaReserva(1, 3, @id3, @msg3);

-- Cliente 2 com 2 reservas
CALL SP_RealizaReserva(2, 4, @id4, @msg4);
CALL SP_RealizaReserva(2, 5, @id5, @msg5);

-- Cliente 3 com 1 reserva (não deve aparecer na View)
CALL SP_RealizaReserva(3, 6, @id6, @msg6);

-- Cliente 4 com 2 reservas
CALL SP_RealizaReserva(4, 7, @id7, @msg7);
CALL SP_RealizaReserva(4, 8, @id8, @msg8);

-- Cliente 5 sem nenhuma reserva (não vai aparecer)

CREATE VIEW VW_ClientesFrequentes AS
SELECT
    C.ID AS ID_CLIENTE,
    C.NOME,
    COUNT(R.ID) AS Total_Reservas
FROM
    CLIENTE C
INNER JOIN
    RESERVA R ON C.ID = R.ID_CLIENTE
GROUP BY
    C.ID, C.NOME
HAVING
    COUNT(R.ID) > 1;


USE TRANSPORTE_AEREO;

INSERT INTO AERONAVE (TIPO, NUMERO_POLTRONAS) VALUES
('Boeing 737', 150),
('Airbus A320', 180),
('Embraer E195', 120);

INSERT INTO POLTRONA (ID_AERONAVE, NUMERO_POLTRONA, LOCALIZACAO, LADO, DISPONIVEL) VALUES
(1, '1A', 'JANELA', 'ESQUERDA', TRUE),
(1, '1B', 'MEIO', 'ESQUERDA', TRUE),
(1, '1C', 'CORREDOR', 'ESQUERDA', TRUE),
(1, '2A', 'JANELA', 'DIREITA', TRUE),
(1, '2B', 'MEIO', 'DIREITA', TRUE),
(1, '2C', 'CORREDOR', 'DIREITA', TRUE),
(1, '3A', 'JANELA', 'ESQUERDA', TRUE),
(1, '3B', 'MEIO', 'ESQUERDA', TRUE),
(1, '3C', 'CORREDOR', 'ESQUERDA', TRUE);

INSERT INTO POLTRONA (ID_AERONAVE, NUMERO_POLTRONA, LOCALIZACAO, LADO, DISPONIVEL) VALUES
(2, '1A', 'JANELA', 'ESQUERDA', TRUE),
(2, '1B', 'CORREDOR', 'ESQUERDA', TRUE),
(2, '2A', 'JANELA', 'DIREITA', TRUE),
(2, '2B', 'CORREDOR', 'DIREITA', TRUE);

INSERT INTO POLTRONA (ID_AERONAVE, NUMERO_POLTRONA, LOCALIZACAO, LADO, DISPONIVEL) VALUES
(3, '1A', 'JANELA', 'ESQUERDA', TRUE),
(3, '1B', 'CORREDOR', 'ESQUERDA', TRUE),
(3, '2A', 'JANELA', 'DIREITA', TRUE);

INSERT INTO AEROPORTO (NOME, CIDADE, ESTADO, PAIS) VALUES
('Aeroporto de Congonhas', 'São Paulo', 'SP', 'Brasil'),
('Aeroporto Santos Dumont', 'Rio de Janeiro', 'RJ', 'Brasil'),
('Aeroporto Internacional de Brasília', 'Brasília', 'DF', 'Brasil'),
('Aeroporto Internacional de Guarulhos', 'Guarulhos', 'SP', 'Brasil');

INSERT INTO VOO (ID_AERONAVE, ID_ORIGEM, ID_DESTINO, HORARIO_SAIDA, HORARIO_CHEGADA) VALUES
(1, 1, 2, '2025-07-20 08:00:00', '2025-07-20 09:10:00');

INSERT INTO VOO (ID_AERONAVE, ID_ORIGEM, ID_DESTINO, HORARIO_SAIDA, HORARIO_CHEGADA) VALUES
(2, 2, 4, '2025-07-20 10:00:00', '2025-07-20 11:30:00');

INSERT INTO VOO (ID_AERONAVE, ID_ORIGEM, ID_DESTINO, HORARIO_SAIDA, HORARIO_CHEGADA) VALUES
(1, 4, 3, '2025-07-21 14:00:00', '2025-07-21 15:45:00');

INSERT INTO VOO (ID_AERONAVE, ID_ORIGEM, ID_DESTINO, HORARIO_SAIDA, HORARIO_CHEGADA) VALUES
(3, 3, 1, '2025-07-22 18:00:00', '2025-07-22 19:50:00');

INSERT INTO VOO (ID_AERONAVE, ID_ORIGEM, ID_DESTINO, HORARIO_SAIDA, HORARIO_CHEGADA) VALUES
(1, 1, 2, '2025-07-20 16:00:00', '2025-07-20 17:10:00');

INSERT INTO ESCALA (ID_VOO, ID_AEROPORTO_ESCALA, HORARIO_CHEGADA, HORARIO_SAIDA) VALUES
(3, 1, '2025-07-21 14:50:00', '2025-07-21 15:10:00');

INSERT INTO CLIENTE (NOME, CPF, IDADE, SEXO, PREFERENCIAL) VALUES
('João Silva', '11122233344', 35, 'MASCULINO', 'PREFERENCIAL'),
('Maria Souza', '22233344455', 28, 'FEMININO', 'PREFERENCIAL'),
('Pedro Lima', '33344455566', 42, 'MASCULINO', 'NORMAL'),
('Ana Costa', '44455566677', 19, 'FEMININO', 'NORMAL'),
('Carlos Pereira', '55566677788', 50, 'MASCULINO', 'PREFERENCIAL');

INSERT INTO VOO_POLTRONA (ID_VOO, ID_POLTRONA, STATUS) VALUES
(1, 1, 'DISPONIVEL'),
(1, 2, 'DISPONIVEL'),
(1, 3, 'DISPONIVEL'),
(1, 4, 'DISPONIVEL'),
(1, 5, 'DISPONIVEL'),
(1, 6, 'DISPONIVEL'),
(1, 7, 'DISPONIVEL'),
(1, 8, 'DISPONIVEL'),
(1, 9, 'DISPONIVEL');

INSERT INTO VOO_POLTRONA (ID_VOO, ID_POLTRONA, STATUS) VALUES
(2, 10, 'DISPONIVEL'),
(2, 11, 'DISPONIVEL'),
(2, 12, 'DISPONIVEL'),
(2, 13, 'DISPONIVEL');

INSERT INTO VOO_POLTRONA (ID_VOO, ID_POLTRONA, STATUS) VALUES
(3, 1, 'DISPONIVEL'),
(3, 2, 'DISPONIVEL'),
(3, 3, 'DISPONIVEL');

CALL SP_RealizaReserva(1, 1, @idReserva1, @mensagemErro1);
SELECT @idReserva1, @mensagemErro1;

CALL SP_RealizaReserva(2, 2, @idReserva2, @mensagemErro2);
SELECT @idReserva2, @mensagemErro2;

CALL SP_RealizaReserva(3, 10, @idReserva3, @mensagemErro3);
SELECT @idReserva3, @mensagemErro3;

CALL SP_RealizaReserva(4, 1, @idReserva4, @mensagemErro4);
SELECT @idReserva4, @mensagemErro4;

SELECT FN_CalculaDuracaoVoo(1) AS DuracaoVoo1Minutos;
SELECT FN_CalculaDuracaoVoo(2) AS DuracaoVoo2Minutos;

SELECT * FROM CLIENTE;

SELECT * FROM VW_VoosDisponiveis;

SELECT ID_VOO, Aeroporto_Origem, Cidade_Destino, HORARIO_SAIDA, Poltronas_Disponiveis FROM VW_VoosDisponiveis WHERE Poltronas_Disponiveis > 0;

UPDATE RESERVA SET STATUS_RESERVA = 'CANCELADA' WHERE ID = @idReserva1;

SELECT STATUS FROM VOO_POLTRONA WHERE ID = 1;