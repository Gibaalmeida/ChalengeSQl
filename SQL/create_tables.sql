-- Criando a tabela Customer do modelo.
use challenge_engineer_sql;

CREATE TABLE Customer (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,     
    nome VARCHAR(255) NOT NULL,                      
    sobrenome VARCHAR(255) NOT NULL,                 
    email VARCHAR(255) UNIQUE NOT NULL,              
    tipo_usuario_id INT,                            
    endereco TEXT,                             
    data_nascimento DATE,                        
    telefone VARCHAR(20),                           
    FOREIGN KEY (tipo_usuario_id) REFERENCES User_Type(tipo_usuario_id) 
);

-- Consulando os dados da tabela Costumer
select * from customer

-- Criando a tabela Item do modelo.

CREATE TABLE Item (
    item_id INT AUTO_INCREMENT PRIMARY KEY,  
    nome VARCHAR(255) NOT NULL,             
    descricao TEXT,                        
    preco DECIMAL(10, 2) NOT NULL,         
    estado ENUM('Ativo', 'Inativo') NOT NULL, 
    data_publicacao DATE,                   
    data_baixa DATE,                        
    data_compra DATE,                       
    categoria_id INT,                       
    FOREIGN KEY (categoria_id) REFERENCES Categoria(categoria_id)  
);

-- Consulando os dados da tabela Item.
select * from item


-- Criando a tabela Categoria do modelo.
CREATE TABLE Categoria (
    categoria_id INT AUTO_INCREMENT PRIMARY KEY, 
    nome VARCHAR(255) NOT NULL,                  
    descricao TEXT,                    
    path VARCHAR(255) NOT NULL                  
);

-- Consulando os dados da tabela Categoria.
select * from categoria

-- Criando a tabela User Type do modelo.
CREATE TABLE User_Type (
    tipo_usuario_id INT AUTO_INCREMENT PRIMARY KEY,  
    tipo_usuario_nome VARCHAR(255) NOT NULL         
);

-- Consulando os dados da tabela User Type.
select * from user_type

-- Criando a tabela Order Type do modelo.
CREATE TABLE `Order` (
    order_id INT AUTO_INCREMENT PRIMARY KEY,       
    customer_id INT,                              
    item_id INT,                                 
    data_pedido DATE,                              
    quantidade INT NOT NULL,                      
    valor_total DECIMAL(10, 2) NOT NULL,          
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id),  
    FOREIGN KEY (item_id) REFERENCES Item(item_id)               
);

-- Consulando os dados da tabela Order.
select * from `Order`

-- Criar a tabela Order_Item do modelo.
CREATE TABLE order_item (
    order_item_id INT AUTO_INCREMENT PRIMARY KEY,  
    order_id INT,                                 
    item_id INT,                                  
    quantidade INT NOT NULL,                       
    valor_total DECIMAL(10, 2) NOT NULL,        
    FOREIGN KEY (order_id) REFERENCES `order`(order_id), 
    FOREIGN KEY (item_id) REFERENCES item(item_id)   
);

-- Consulando os dados da order_item.
select * from order_item

-- Criar a tabela item log do modelo.
CREATE TABLE Item_Log (
    log_id INT AUTO_INCREMENT PRIMARY KEY,      
    item_id INT,                                 
    estado_anterior VARCHAR(255),               
    estado_atual VARCHAR(255),                     
    data_hora TIMESTAMP DEFAULT CURRENT_TIMESTAMP,  
    descricao TEXT,                                
    usuario VARCHAR(255),                           
    FOREIGN KEY (item_id) REFERENCES Item(item_id) 
);

-- Consulando os dados da item log.
select * from Item_Log






