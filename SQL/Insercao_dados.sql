-- Usando a database correta para as repostas do SQL.
use challenge_engineer_sql

-- Retirando a referencia da chave estrangeira para apagar os dados das tabelas.
SET FOREIGN_KEY_CHECKS = 0;

-- Retornando a referencia da chave estrangeira para as tabelas.
SET FOREIGN_KEY_CHECKS = 1;

-- Limpando os dados das tabelas para fazser os testes.
TRUNCATE TABLE Item_Log;
TRUNCATE TABLE order_item;
TRUNCATE TABLE `Order`;
TRUNCATE TABLE Item_Log;
TRUNCATE TABLE Item;
TRUNCATE TABLE Customer;
TRUNCATE TABLE Categoria;

-- Inserindo os dados na tabela user type
INSERT INTO User_Type (tipo_usuario_nome)
VALUES 
('Comprador'),
('Vendedor');

-- Inserindo os dados na tabela categoria.

INSERT INTO Categoria (nome, descricao, path)
VALUES 
('Tecnologia', 'Produtos eletrônicos e gadgets', 'Tecnologia > Eletrônicos'),
('Moda', 'Roupas, acessórios e calçados', 'Moda > Roupas e Acessórios'),
('Casa e Decoração', 'Produtos para casa e decoração', 'Casa e Decoração > Móveis'),
('Beleza', 'Produtos de cuidados pessoais e beleza', 'Beleza > Cosméticos'),
('Automóveis', 'Peças e acessórios para carros', 'Automóveis > Peças e Acessórios');

-- Inserindo os dados na tabela customer
INSERT INTO customer (nome, sobrenome, email, tipo_usuario_id, endereco, data_nascimento, telefone)
VALUES 
('João', 'Silva', 'joao.silva@mail.com', 1, 'Rua X, 123', '1985-01-01', '123456789'),
('Maria', 'Oliveira', 'maria.oliveira@mail.com', 2, 'Rua Y, 456', '1990-02-01', '987654321'),
('Pedro', 'Santos', 'pedro.santos@mail.com', 1, 'Rua Z, 789', '1995-03-01', '555123456'),
('Ana', 'Costa', 'ana.costa@mail.com', 2, 'Rua A, 101', '1980-04-01', '555654321'),
('Carlos', 'Almeida', 'carlos.almeida@mail.com', 1, 'Rua B, 202', '1992-05-01', '555987654'),
('Julia', 'Martins', 'julia.martins@mail.com', 2, 'Rua C, 303', '1988-06-01', '555654987'),
('Ricardo', 'Pereira', 'ricardo.pereira@mail.com', 1, 'Rua D, 404', '1991-07-01', '555321654'),
('Fernanda', 'Souza', 'fernanda.souza@mail.com', 2, 'Rua E, 505', '1994-08-01', '555789321'),
('Lucas', 'Gomes', 'lucas.gomes@mail.com', 1, 'Rua F, 606', '1997-09-01', '555321987'),
('Larissa', 'Rocha', 'larissa.rocha@mail.com', 2, 'Rua G, 707', '1999-10-01', '555456123');

-- Inserindo os dados na tabela Item.

INSERT INTO Item (nome, descricao, preco, estado, data_publicacao, data_baixa, data_compra, categoria_id)
VALUES
('Celular', 'Celular modelo X', 2500.00, 'Ativo', '2025-02-01', NULL, '2025-02-01', 1),
('Fone de Ouvido', 'Fone de ouvido sem fio', 300.00, 'Ativo', '2025-02-01', NULL, '2025-02-01', 1),
('Camiseta', 'Camiseta feminina', 80.00, 'Ativo', '2025-02-01', NULL, '2025-02-01', 2),
('Sofá', 'Sofá 3 lugares', 1500.00, 'Ativo', '2025-02-01', NULL, '2025-02-01', 3),
('Perfume', 'Perfume feminino', 200.00, 'Ativo', '2025-02-01', NULL, '2025-02-01', 4),
('Peça de Carro', 'Peça de suspensão', 500.00, 'Ativo', '2025-02-01', NULL, '2025-02-01', 5),
('Smartphone', 'Smartphone modelo Y', 3500.00, 'Ativo', '2025-02-01', NULL, '2025-02-01', 1),
('Bolsa', 'Bolsa de couro', 350.00, 'Ativo', '2025-02-01', NULL, '2025-02-01', 2),
('Cadeira', 'Cadeira ergonômica', 800.00, 'Ativo', '2025-02-01', NULL, '2025-02-01', 3),
('Maquiagem', 'Kit de maquiagem', 150.00, 'Ativo', '2025-02-01', NULL, '2025-02-01', 4);

-- Inserindo os dados na tabela order.

INSERT INTO `Order` (customer_id, item_id, data_pedido, quantidade, valor_total)
VALUES
(1, 1, '2025-03-01', 2, 5000.00),
(2, 2, '2025-03-02', 1, 300.00),
(3, 3, '2025-03-03', 1, 80.00),
(4, 4, '2025-03-04', 1, 1500.00),
(5, 5, '2025-03-05', 1, 200.00),
(6, 6, '2025-03-06', 1, 500.00),
(7, 7, '2025-03-07', 1, 3500.00),
(8, 8, '2025-03-08', 1, 350.00),
(9, 9, '2025-03-09', 1, 800.00),
(10, 10, '2025-03-10', 1, 150.00);


-- Inserindo os dados na tabela order item.

INSERT INTO order_item (order_id, item_id, quantidade, valor_total)
SELECT o.order_id, i.item_id, o.quantidade, (o.quantidade * i.preco) AS valor_total
FROM `Order` o
JOIN Item i ON o.item_id = i.item_id

-- Trigger para atualziar a data-baixa na tabela item.


DELIMITER $$

CREATE TRIGGER set_data_baixa
BEFORE UPDATE ON Item
FOR EACH ROW
BEGIN
    -- Se o estado do item mudar para 'Inativo' e data_baixa for NULL
    IF NEW.estado = 'Inativo' AND OLD.estado <> 'Inativo' AND NEW.data_baixa IS NULL THEN
        -- Atribui a data de baixa diretamente no NEW.data_baixa antes da atualização
        SET NEW.data_baixa = CURDATE();
    END IF;
END $$

DELIMITER ;

-- testando a funcionalidade da trigger 

INSERT INTO Item ( nome, descricao, preco, estado, data_publicacao, data_baixa, categoria_id)
VALUES ('Celular Samsung', 'Celular modelo A52', 1500.00, 'Ativo', '2025-03-01', NULL, 1);

SELECT * FROM Item WHERE item_id = 1;

UPDATE Item
SET estado = 'Inativo'
WHERE item_id = 1;

SELECT * FROM Item WHERE item_id = 1;



