-- 1.	Listar os usuários que fazem aniversário no dia de hoje, cujas vendas realizadas em janeiro de 2020 foram superiores a 1500.

-- Usando a database correta para as repostas do SQL.
use challenge_engineer_sql

-- Inserindo os dados na tabela customer para respodner as questões.

INSERT INTO customer (nome, sobrenome, email, tipo_usuario_id, endereco, data_nascimento, telefone)
VALUES 
('Gilberto', 'Almeida', 'gilberto.almeida@mail.com', 1, 'Rua X, 123', '1992-03-30', '123456789'),
('Matheus', 'Dias', 'matheus.dias@mail.com', 1, 'Rua X, 123', '1996-03-30', '123456789'),
('Alexandre', 'Jhonatan', 'alexandre.jhonatan@mail.com', 1, 'Rua X, 123', '1992-03-30', '123456789');

-- Inserindo os dados na tabela customer para respodner as questões.
INSERT INTO `Order` (customer_id, item_id, data_pedido, quantidade, valor_total)
VALUES
(11, 1, '2020-01-01', 2, 5000.00),
(12, 2, '2020-01-01', 1, 300.00),
(13, 3, '2020-01-31', 1, 80.00);

-- Atualziando a tabela customer para reponder as questões.
UPDATE customer
SET tipo_usuario_id = 2  
WHERE customer_id IN (11,12,13);

-- Atualziando a tabela order para reponder as questões.
UPDATE `Order`
SET quantidade = 2, valor_total = 1600.00
WHERE order_id = 12;

-- Atualziando a tabela order para reponder as questões.
UPDATE `Order`
SET quantidade = 3, valor_total = 8000.00
WHERE order_id = 13;

-- Código que responde a questão 1.

SELECT 
    c.customer_id,
    c.nome,
    c.sobrenome,
    c.email,
    ut.tipo_usuario_nome, 
    o.data_pedido,         
    SUM(o.valor_total) AS total_vendas_jan_2020
FROM 
    Customer c
JOIN 
    `Order` o ON c.customer_id = o.customer_id
JOIN 
    User_Type ut ON c.tipo_usuario_id = ut.tipo_usuario_id 
WHERE 
    MONTH(c.data_nascimento) = MONTH(CURDATE())  
    AND DAY(c.data_nascimento) = DAY(CURDATE())  
    AND o.data_pedido BETWEEN '2020-01-01' AND '2020-01-31' 
GROUP BY 
    c.customer_id, ut.tipo_usuario_nome, o.data_pedido  
HAVING 
    total_vendas_jan_2020 > 1500;  
    
  ---------------------------------------------------------------------------------------------------
  
    -- 2.	Para cada mês de 2020, fornecer o top 5 dos usuários que mais venderam em termos de valor ($) na categoria "Celulares". É necessário incluir o mês e ano de análise, nome e sobrenome do vendedor, quantidade de vendas realizadas, quantidade de produtos vendidos e o valor total transacionado.

SELECT 
    o.data_pedido, 
    YEAR(o.data_pedido) AS ano,                       
    MONTH(o.data_pedido) AS mes,                        
    c.nome,                                       
    c.sobrenome,                                      
    COUNT(o.order_id) AS quantidade_vendas,           
    SUM(o.quantidade) AS quantidade_produtos_vendidos,
    SUM(o.valor_total) AS valor_total_transacionado,
    ut.tipo_usuario_nome AS tipo_usuario
FROM 
    `Order` o
JOIN 
    Customer c ON o.customer_id = c.customer_id
JOIN 
    Item i ON o.item_id = i.item_id
JOIN 
    Categoria cat ON i.categoria_id = cat.categoria_id
JOIN 
    User_Type ut ON c.tipo_usuario_id = ut.tipo_usuario_id  
WHERE 
    cat.nome = 'Celulares e Smartphones'                          
    AND o.data_pedido BETWEEN '2020-01-01' AND '2020-12-31'  
GROUP BY 
    o.data_pedido, YEAR(o.data_pedido), MONTH(o.data_pedido), c.customer_id, tipo_usuario_nome  
ORDER BY 
    valor_total_transacionado DESC              
LIMIT 5;

------------------------------------------------------------------------------------------------------------------------------------------------------

-- 3.	Preencher uma nova tabela com o preço e estado dos itens ao final do dia. Tenha em mente que deve ser um processo reprocessável. Vale ressaltar que na tabela "Item", vamos ter apenas o último estado informado pela chave primária definida. (Pode ser resolvido através de StoredProcedure)

-- 
DELIMITER $$

-- Vai ser acionada após uma atualização na tabela Item
-- Trigger que monitora o estado da tabela item e registra as mudanças de estado e preço.

CREATE TRIGGER after_item_update
AFTER UPDATE ON Item
FOR EACH ROW
BEGIN
    -- Verifica se o estado foi alterado
    IF OLD.estado <> NEW.estado THEN
        -- Log de alteração de estado
        INSERT INTO Item_Log (item_id, estado_anterior, estado_atual, descricao, usuario)
        VALUES (NEW.item_id, OLD.estado, NEW.estado, 'Alteração de estado do item', 'Sistema');
    END IF;

    -- Verifica se o preço foi alterado
    IF OLD.preco <> NEW.preco THEN
        -- Log de alteração de preço
        INSERT INTO Item_Log (item_id, estado_anterior, estado_atual, descricao, usuario)
        VALUES (NEW.item_id, OLD.preco, NEW.preco, 'Alteração de preço do item', 'Sistema');
    END IF;
END $$

DELIMITER ;

-- Trigger que monitora a inserção de novos itens na tabela item, insere os itens antigos e novos e preço na tabela de log.

DELIMITER $$

CREATE TRIGGER after_item_insert
AFTER INSERT ON Item
FOR EACH ROW
BEGIN
    -- Registro de inserção de item
    INSERT INTO Item_Log (item_id, estado_anterior, estado_atual, descricao, usuario)
    VALUES (NEW.item_id, 'N/A', NEW.estado, 'Novo item inserido', 'Sistema');
    
    -- Também registra o preço inicial
    INSERT INTO Item_Log (item_id, estado_anterior, estado_atual, descricao, usuario)
    VALUES (NEW.item_id, 'N/A', NEW.preco, 'Preço inicial do item', 'Sistema');
END $$

DELIMITER ;

select * from item_log
-- testando a trigger de inserção de um item

INSERT INTO Item (nome, descricao, preco, estado, data_publicacao, data_baixa, data_compra, categoria_id)
VALUES
('Celular', 'Celular modelo Iphone', 2500.00, 'Ativo', '2025-02-01', NULL, '2025-02-01', 1);


-- testando a trigger de mudança de estado e preço do item.

UPDATE item
SET estado = "Ativo"  -- Atualizando o id do cliente para um vendedor (ou qualquer id de vendedor)
WHERE item_id IN (1);

-- Questão Bonus

-- 4-Liste os 5 melhores vendedores do ano de 2020 em termos de volume de vendas realizadas, considerando a quantidade de produtos vendidos e o valor total transacionado. Para cada vendedor, forneça o nome, sobrenome, o total de produtos vendidos, o valor total transacionado, e o mês em que ele teve a maior quantidade de vendas.

SELECT 
    c.nome,
    c.sobrenome,
    MONTH(o.data_pedido) AS mes,
    SUM(o.quantidade) AS total_produtos_vendidos,
    SUM(o.valor_total) AS total_transacionado,
    MAX(SUM(o.quantidade)) OVER (PARTITION BY c.customer_id) AS maior_quantidade_vendas
FROM 
    `Order` o
JOIN 
    Customer c ON o.customer_id = c.customer_id
JOIN 
    Item i ON o.item_id = i.item_id
JOIN 
    Categoria cat ON i.categoria_id = cat.categoria_id
WHERE 
    YEAR(o.data_pedido) = 2020
    AND cat.nome = 'Celulares e Smartphones'
GROUP BY 
    c.customer_id, mes
ORDER BY 
    total_transacionado DESC
LIMIT 5;


-- 5 - Calcular o total de vendas por categoria, considerando o valor total transacionado de todos os itens vendidos, no ano de 2020.

SELECT 
    cat.nome AS categoria,
    SUM(o.valor_total) AS total_vendas
FROM 
    `Order` o
JOIN 
    Item i ON o.item_id = i.item_id
JOIN 
    Categoria cat ON i.categoria_id = cat.categoria_id
WHERE 
    o.data_pedido BETWEEN '2020-01-01' AND '2020-12-31'
GROUP BY 
    cat.nome
ORDER BY 
    total_vendas DESC;




