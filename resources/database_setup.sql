CREATE DATABASE IF NOT EXISTS escola;

USE escola;

-- Criar tabela Produto
CREATE TABLE Produto (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    preco DECIMAL(10, 2) NOT NULL
);

-- Criar tabela Cliente
CREATE TABLE Cliente (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE
);

-- Criar tabela Venda
CREATE TABLE Venda (
    id INT AUTO_INCREMENT PRIMARY KEY,
    cliente_id INT,
    produto_id INT,
    quantidade INT NOT NULL,
    data_venda DATE NOT NULL,
    FOREIGN KEY (cliente_id) REFERENCES Cliente (id),
    FOREIGN KEY (produto_id) REFERENCES Produto (id)
);

-- Inserir produtos
INSERT INTO
    Produto (nome, preco)
VALUES ('Produto A', 12.50),
    ('Produto B', 25.90),
    ('Produto C', 9.90),
    ('Produto D', 15.00),
    ('Produto E', 50.00);

-- Inserir clientes
INSERT INTO
    Cliente (nome, email)
VALUES (
        'João Silva',
        'joao@email.com'
    ),
    ('Ana Costa', 'ana@email.com'),
    (
        'Carlos Santos',
        'carlos@email.com'
    );

-- Inserir vendas
INSERT INTO
    Venda (
        cliente_id,
        produto_id,
        quantidade,
        data_venda
    )
VALUES (1, 1, 2, '2023-01-01'),
    (2, 3, 1, '2023-01-03'),
    (1, 2, 2, '2023-01-05'),
    (2, 5, 1, '2023-01-10'),
    (3, 4, 3, '2023-01-15');