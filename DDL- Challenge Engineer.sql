-- Tabela Customer
DROP TABLE IF EXISTS Customer;
-- Criação da tabela Customer com a coluna data_nascimento
CREATE TABLE Customer (
    customer_id INTEGER PRIMARY KEY, 
    nome TEXT,
    sobrenome TEXT,
    email TEXT,
    data_nascimento DATE
);

-- Inserção de 15 registros de clientes, incluindo a data de nascimento
INSERT INTO Customer (customer_id, nome, sobrenome, email, data_nascimento) 
VALUES 
(1, 'João', 'Silva', 'joao.silva@email.com', '1990-01-15'),
(2, 'Maria', 'Oliveira', 'maria.oliveira@email.com', '1985-03-22'),
(3, 'Carlos', 'Pereira', 'carlos.pereira@email.com', '1992-05-30'),
(4, 'Ana', 'Costa', 'ana.costa@email.com', '1988-07-07'),
(5, 'Lucas', 'Souza', 'lucas.souza@email.com', '1991-08-10'),
(6, 'Fernanda', 'Santos', 'fernanda.santos@email.com', '1990-11-25'),
(7, 'Rafael', 'Alves', 'rafael.alves@email.com', '1987-12-02'),
(8, 'Juliana', 'Rocha', 'juliana.rocha@email.com', '1989-04-14'),
(9, 'Ricardo', 'Martins', 'ricardo.martins@email.com', '1993-02-19'),
(10, 'Patricia', 'Lima', 'patricia.lima@email.com', '1990-06-23'),
(11, 'Diego', 'Barbosa', 'diego.barbosa@email.com', '1995-09-10'),
(12, 'Simone', 'Gomes', 'simone.gomes@email.com', '1987-05-12'),
(13, 'Gabriel', 'Dias', 'gabriel.dias@email.com', '1992-03-05'),
(14, 'Larissa', 'Cavalcante', 'larissa.cavalcante@email.com', '1991-10-29'),
(15, 'José', 'Ribeiro', 'jose.ribeiro@email.com', '1994-12-17'),
(16, 'João', 'Silva', 'joao.silva@email.com', '1990-03-22'),
(17, 'Maria', 'Oliveira', 'maria.oliveira@email.com', '1985-03-22'),
(18, 'Carlos', 'Souza', 'carlos.souza@email.com', '1992-05-15'),
(19, 'Gilberto', 'Almeida', 'gilberto.almeida@email.com', '1990-03-23'),
(20, 'Alexandre', 'Jonatan', 'alexandre.jonatan@email.com', '1985-03-23'),
(21, 'Renan', 'Soares', 'renan.soares@email.com', '1992-05-15');

-- Criar a tabela Item
CREATE TABLE Item (
    item_id INTEGER PRIMARY KEY AUTOINCREMENT,  
    categoria_id INTEGER,                       
    nome TEXT NOT NULL,                          
    descricao TEXT,                             
    preco REAL NOT NULL,                        
    estado TEXT,                                
    data_compra DATE,                            
    data_baixa DATE,                            
    FOREIGN KEY (categoria_id) REFERENCES Categoria(categoria_id) 
);


-- Inserir itens
INSERT INTO Item (categoria_id, nome, descricao, preco, estado, data_compra, data_baixa) 
VALUES
(1, 'Celular', 'Celular de última geração com 128GB de memória interna', 1000.00, 'Novo', '2025-01-01', NULL),
(1, 'Notebook', 'Notebook para trabalho, com processador i7 e 16GB de RAM', 3000.00, 'Novo', '2025-01-02', NULL),
(1, 'Fone de ouvido', 'Fone Bluetooth com cancelamento de ruído', 300.00, 'Novo', '2025-01-03', NULL),
(1, 'Smartwatch', 'Relógio inteligente com monitoramento de saúde', 500.00, 'Novo', '2025-01-04', NULL),
(2, 'Cadeira de Escritório', 'Cadeira ergonômica com ajuste de altura e apoio lombar', 600.00, 'Novo', '2025-01-05', NULL),
(2, 'Mesa de Escritório', 'Mesa com espaço para computador e gavetas', 800.00, 'Usado', '2025-01-06', NULL),
(2, 'Sofá', 'Sofá de 3 lugares em tecido sintético', 1500.00, 'Novo', '2025-01-07', NULL),
(3, 'Mouse', 'Mouse sem fio ergonômico', 100.00, 'Novo', '2025-01-08', NULL),
(3, 'Teclado', 'Teclado mecânico para gamers', 250.00, 'Usado', '2025-01-09', NULL),
(4, 'Geladeira', 'Geladeira frost-free 400L', 2500.00, 'Novo', '2025-01-10', NULL),
(4, 'Micro-ondas', 'Micro-ondas 20L com função grill', 800.00, 'Novo', '2025-01-11', NULL),
(4, 'Lavadora de Roupas', 'Máquina de lavar roupas 10kg', 1500.00, 'Usado', '2025-01-12', NULL),
(5, 'Cabo USB', 'Cabo USB tipo C para carregar dispositivos', 20.00, 'Novo', '2025-01-13', NULL),
(5, 'Capinha para celular', 'Capinha protetora para celular modelo iPhone', 50.00, 'Novo', '2025-01-14', NULL),
(5, 'Carregador portátil', 'Power bank de 10000mAh', 150.00, 'Novo', '2025-01-15', NULL),
(16, 'Celular', 'Celular de última geração com 128GB de pouca memória', 1500.00, 'Novo', '2020-01-01', NULL),
(16, 'Celular', 'Celular de última geração com 128GB de pouca memória', 3000.00, 'Novo', '2020-01-01', NULL),
(16, 'Celular', 'Celular de última geração com 128GB de pouca memória', 4500.00, 'Novo', '2020-01-01', NULL),
(16, 'Celular', 'Celular de última geração com 128GB de pouca memória', 4500.00, 'Novo', '2020-01-01', NULL),
(16, 'Celular', 'Celular de última geração com 128GB de pouca memória', 4500.00, 'Novo', '2020-01-01', NULL),
(16, 'Celular', 'Celular de última geração com 128GB de pouca memória', 4500.00, 'Novo', '2020-01-01', NULL),
(16, 'Celular', 'Celular de última geração com 128GB de pouca memória', 4500.00, 'Novo', '2020-01-01', NULL);

-- Tabela Categoria
DROP TABLE IF EXISTS Categoria;
CREATE TABLE Categoria (
    categoria_id INTEGER PRIMARY KEY,   -- Chave Primária
    nome TEXT,
    path TEXT
);

select * from Item

INSERT OR REPLACE INTO Categoria (categoria_id, nome, path)
VALUES
(1, 'Eletrônicos', '/eletronicos'),
(2, 'Móveis', '/moveis'),
(3, 'Informática', '/informatica'),
(4, 'Telefonia', '/telefonia'),
(5, 'Esportes', '/esportes'),
(6, 'Casa e Decoração', '/casa-e-decoracao'),
(7, 'Moda', '/moda'),
(8, 'Beleza', '/beleza'),
(9, 'Automotivo', '/automotivo'),
(10, 'Livros', '/livros'),
(11, 'Eletrodomésticos', '/eletrodomesticos'),
(12, 'Brinquedos', '/brinquedos'),
(13, 'Alimentos', '/alimentos'),
(14, 'Saúde', '/saude'),
(15, 'Ferramentas', '/ferramentas');
INSERT OR REPLACE INTO Categoria (categoria_id, nome, path)
(16, 'Celular', '/eletronicos');
-- Tabela Order
DROP TABLE IF EXISTS "Order";
CREATE TABLE "Order" (
    order_id INTEGER PRIMARY KEY,         
    customer_id INTEGER,                  
    item_id INTEGER,                      
    data_pedido DATE,
    quantidade INTEGER,
    valor_total REAL,
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id),  
    FOREIGN KEY (item_id) REFERENCES Item(item_id)               
);

-- Inserir 15 dados na tabela Order
INSERT INTO "Order" (order_id, customer_id, item_id, data_pedido, quantidade, valor_total)
VALUES
(1, 1, 1, '2025-03-01', 1, 1000.00),
(2, 2, 2, '2025-03-02', 1, 3000.00),
(3, 3, 3, '2025-03-03', 2, 1000.00),
(4, 4, 4, '2025-03-04', 1, 800.00),
(5, 5, 5, '2025-03-05', 1, 1200.00),
(6, 6, 6, '2025-03-06', 2, 500.00),
(7, 7, 7, '2025-03-07', 1, 100.00),
(8, 8, 8, '2025-03-08', 1, 1500.00),
(9, 9, 9, '2025-03-09', 2, 600.00),
(10, 10, 10, '2025-03-10', 1, 900.00),
(11, 11, 11, '2025-03-11', 2, 800.00),
(12, 12, 12, '2025-03-12', 1, 2200.00),
(13, 13, 13, '2025-03-13', 1, 350.00),
(14, 14, 14, '2025-03-14', 2, 600.00),
(15, 15, 15, '2025-03-15', 1, 2000.00),
(16, 16, 1, '2020-01-10', 3, 500.0),  
(17, 17, 2, '2020-02-20', 2, 3000.0),
(18, 18, 3, '2020-03-25', 1, 200.0),
(19, 19, 1, '2020-01-10', 3, 5000.0),  
(20, 20, 2, '2020-01-10', 2, 15000.0), 
(21, 21, 3, '2020-01-10', 1, 3000.0); 

-- Tabela Order_Item
DROP TABLE IF EXISTS Order_Item;
CREATE TABLE Order_Item (
    item_id INTEGER,                      
    order_id INTEGER,                    
    quantidade INTEGER,
    valor_total REAL,
    PRIMARY KEY (item_id, order_id),     
    FOREIGN KEY (item_id) REFERENCES Item(item_id),            
    FOREIGN KEY (order_id) REFERENCES "Order"(order_id)           
);

-- Inserir 15 dados na tabela Order_Item
INSERT INTO Order_Item (item_id, order_id, quantidade, valor_total)
VALUES
(1, 1, 1, 1000.00),
(2, 2, 1, 3000.00),
(3, 3, 2, 1000.00),
(4, 4, 1, 800.00),
(5, 5, 1, 1200.00),
(6, 6, 2, 500.00),
(7, 7, 1, 100.00),
(8, 8, 1, 1500.00),
(9, 9, 2, 600.00),
(10, 10, 1, 900.00),
(11, 11, 2, 800.00),
(12, 12, 1, 2200.00),
(13, 13, 1, 350.00),
(14, 14, 2, 600.00),
(15, 15, 1, 2000.00),
(16, 15, 1, 5000.00),
(17, 1, 1, 1000.00),
(18, 1, 2, 1850.00),
(19, 1, 3, 3000.00),
(20, 1, 1, 7500.00);

select * from Order_Item
select * from Item

-- Tabela Clientes_Inativos
DROP TABLE IF EXISTS Clientes_Inativos;
CREATE TABLE Clientes_Inativos (
    inativo_id INTEGER PRIMARY KEY,        
    cliente_id INTEGER,                    
    nome TEXT,
    ultima_compra DATE,
    dias_inativos INTEGER,
    FOREIGN KEY (cliente_id) REFERENCES Customer(customer_id)  
);

-- Inserir 15 dados na tabela Clientes_Inativos
INSERT INTO Clientes_Inativos (inativo_id, cliente_id, nome, ultima_compra, dias_inativos)
VALUES
(1, 1, 'João Silva', '2025-01-01', 60),
(2, 2, 'Maria Oliveira', '2025-01-02', 55),
(3, 3, 'Carlos Santos', '2025-01-03', 50),
(4, 4, 'Ana Costa', '2025-01-04', 45),
(5, 5, 'Pedro Lima', '2025-01-05', 40),
(6, 6, 'Julia Ferreira', '2025-01-06', 35),
(7, 7, 'Ricardo Pereira', '2025-01-07', 30),
(8, 8, 'Fernanda Almeida', '2025-01-08', 25),
(9, 9, 'Lucas Rocha', '2025-01-09', 20),
(10, 10, 'Gabriela Martins', '2025-01-10', 15),
(11, 11, 'Roberto Gomes', '2025-01-11', 10),
(12, 12, 'Camila Dias', '2025-01-12', 5),
(13, 13, 'Renato Moraes', '2025-01-13', 3),
(14, 14, 'Larissa Souza', '2025-01-14', 2),
(15, 15, 'Felipe Barros', '2025-01-15', 1);

-- Tabela Vendas_Mensais
DROP TABLE IF EXISTS Vendas_Mensais;
CREATE TABLE Vendas_Mensais (
    mes TEXT PRIMARY KEY,       
    total_vendas REAL,
    crescimento REAL
);

-- Inserir 12 dados na tabela Vendas_Mensais
INSERT INTO Vendas_Mensais (mes, total_vendas, crescimento)
VALUES
('Janeiro', 15000.00, 10.0),
('Fevereiro', 16000.00, 7.5),
('Março', 18000.00, 15.0),
('Abril', 19000.00, 5.0),
('Maio', 20000.00, 10.5),
('Junho', 22000.00, 12.0),
('Julho', 23000.00, 5.0),
('Agosto', 25000.00, 8.0),
('Setembro', 27000.00, 10.0),
('Outubro', 30000.00, 15.0),
('Novembro', 32000.00, 7.5),
('Dezembro', 35000.00, 10.0);


-- Tabela de Log
DROP TABLE IF EXISTS tabela_log;
CREATE TABLE tabela_log (
    log_id INTEGER PRIMARY KEY,  
    acao TEXT,
    descricao TEXT,
    data_acao DATE
);

-- Inserir dados na tabela de Log
INSERT INTO tabela_log (log_id, acao, descricao, data_acao)
VALUES
(1, 'Inserção', 'Inserção de dados na tabela Customer', '2025-03-01'),
(2, 'Atualização', 'Atualização de dados na tabela Item', '2025-03-02'),
(3, 'Exclusão', 'Exclusão de dados na tabela Categoria', '2025-03-03'),
(4, 'Inserção', 'Inserção de dados na tabela Order', '2025-03-04'),
(5, 'Atualização', 'Atualização de dados na tabela Order_Item', '2025-03-05');

CREATE TABLE Status (
    status_id INTEGER PRIMARY KEY AUTOINCREMENT,
    item_id INTEGER,
    preco DECIMAL(10, 2),
    estado TEXT,
    data_status DATE,
    FOREIGN KEY(item_id) REFERENCES Item(item_id)
);

DELETE FROM Status;

INSERT INTO Status (item_id, preco, estado, data_status)
SELECT I.item_id, I.preco, I.estado, DATE('now')
FROM Item I;


