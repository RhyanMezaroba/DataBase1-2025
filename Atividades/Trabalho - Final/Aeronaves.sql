CREATE DATABASE aeronaves_controle;
USE aeronaves_controle;

CREATE TABLE Aeronave (
    id INT AUTO_INCREMENT PRIMARY KEY,
    tipo VARCHAR(100) NOT NULL,
    numero_poltronas INT NOT NULL
);

CREATE TABLE Poltrona (
    id INT AUTO_INCREMENT PRIMARY KEY,
    aeronave_id INT NOT NULL,
    localizacao VARCHAR(50),
    FOREIGN KEY (aeronave_id) REFERENCES Aeronave(id)
);

CREATE TABLE Voo (
    id INT AUTO_INCREMENT PRIMARY KEY,
    aeronave_id INT NOT NULL,
    aeroporto_origem VARCHAR(100) NOT NULL,
    aeroporto_destino VARCHAR(100) NOT NULL,
    horario_saida DATETIME NOT NULL,
    horario_previsto_chegada DATETIME NOT NULL,
    FOREIGN KEY (aeronave_id) REFERENCES Aeronave(id)
);

CREATE TABLE Escala (
    id INT AUTO_INCREMENT PRIMARY KEY,
    voo_id INT NOT NULL,
    aeroporto_saida VARCHAR(100) NOT NULL,
    horario_saida DATETIME NOT NULL,
    ordem INT, -- ordem da escala no voo
    FOREIGN KEY (voo_id) REFERENCES Voo(id)
);

CREATE TABLE HorarioDisponivel (
    id INT AUTO_INCREMENT PRIMARY KEY,
    voo_id INT NOT NULL,
    data_horario DATETIME NOT NULL,
    FOREIGN KEY (voo_id) REFERENCES Voo(id)
);

CREATE TABLE DisponibilidadePoltrona (
    id INT AUTO_INCREMENT PRIMARY KEY,
    poltrona_id INT NOT NULL,
    voo_id INT NOT NULL,
    data_voo DATETIME NOT NULL,
    disponivel BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (poltrona_id) REFERENCES Poltrona(id),
    FOREIGN KEY (voo_id) REFERENCES Voo(id)
);

CREATE TABLE Cliente (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100),
    telefone VARCHAR(20),
    preferencial BOOLEAN DEFAULT FALSE
);

CREATE TABLE Reserva (
    id INT AUTO_INCREMENT PRIMARY KEY,
    cliente_id INT NOT NULL,
    voo_id INT NOT NULL,
    poltrona_id INT,
    data_reserva DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (cliente_id) REFERENCES Cliente(id),
    FOREIGN KEY (voo_id) REFERENCES Voo(id),
    FOREIGN KEY (poltrona_id) REFERENCES Poltrona(id)
);
