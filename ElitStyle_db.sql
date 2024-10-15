-- Criação do banco de dados ElitStyle
CREATE DATABASE ElitStyle;

-- Selecionar o banco de dados
USE ElitStyle;

-- Tabela User_db1 (usuários)
CREATE TABLE User_db1 (
    id_user INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    senha VARCHAR(255) NOT NULL,
    telefone VARCHAR(20),
    dataCriacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabela Endereco
CREATE TABLE Endereco (
    id_endereco INT AUTO_INCREMENT PRIMARY KEY,
    Estado VARCHAR(50) NOT NULL,
    cidade VARCHAR(100) NOT NULL,
    bairro VARCHAR(100),
    rua VARCHAR(100),
    numero VARCHAR(10),
    cep VARCHAR(20) NOT NULL,
    tipo_endereco VARCHAR(50),
    idUser_db1 INT,
    FOREIGN KEY (idUser_db1) REFERENCES User_db1(id_user) ON DELETE CASCADE
);

-- Tabela produto
CREATE TABLE produto (
    id_produto INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    descricao TEXT,
    preco DECIMAL(10, 2) NOT NULL,
    quantidade_estoque INT DEFAULT 0
);

-- Tabela categoria
CREATE TABLE categoria (
    id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    nome_categoria VARCHAR(255) NOT NULL, -- Exemplos: 'conjuntos', 'acessórios', etc.
    idproduto INT,
    FOREIGN KEY (idproduto) REFERENCES produto(id_produto) ON DELETE SET NULL
);

-- Tabela envio
CREATE TABLE envio (
    id_envio INT AUTO_INCREMENT PRIMARY KEY,
    data_envio TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    idproduto INT,
    FOREIGN KEY (idproduto) REFERENCES produto(id_produto) ON DELETE CASCADE
);

-- Tabela historico (histórico de compras)
CREATE TABLE historico (
    id_historico INT AUTO_INCREMENT PRIMARY KEY,
    datacompra TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    idUser_db1 INT,
    idenvio INT,
    idproduto INT,
    FOREIGN KEY (idUser_db1) REFERENCES User_db1(id_user) ON DELETE CASCADE,
    FOREIGN KEY (idenvio) REFERENCES envio(id_envio) ON DELETE CASCADE,
    FOREIGN KEY (idproduto) REFERENCES produto(id_produto) ON DELETE CASCADE
);

-- Tabela venda_item (itens vendidos)
CREATE TABLE venda_item (
    id_venda_item INT AUTO_INCREMENT PRIMARY KEY,
    idproduto INT,
    idhistorico INT,
    idcategoria INT,
    FOREIGN KEY (idproduto) REFERENCES produto(id_produto) ON DELETE CASCADE,
    FOREIGN KEY (idhistorico) REFERENCES historico(id_historico) ON DELETE CASCADE,
    FOREIGN KEY (idcategoria) REFERENCES categoria(id_categoria) ON DELETE SET NULL
);

