--trocando a data de aniversario

UPDATE customer
SET data_nascimento = "1990-03-24"
WHERE customer_id IN (19, 20, 21);

--1 - Listar os usuários que fazem aniversário hoje e cuja quantidade de vendas realizadas em janeiro de 2020 seja superior a 1500.

SELECT c.customer_id, c.nome, c.data_nascimento, 
       SUM(o.valor_total) AS total_vendas
FROM customer c
JOIN "order" o ON c.customer_id = o.customer_id
WHERE strftime('%m-%d', c.data_nascimento) = strftime('%m-%d', CURRENT_DATE)
  AND o.data_pedido BETWEEN '2020-01-01' AND '2020-01-31'
GROUP BY c.customer_id
HAVING total_vendas > 1500;

--2-Para cada mês de 2020, listar o top 5 de usuários que mais venderam na categoria Celulares.
--O relatório deve conter:
--Mês e ano de análise
--Nome e sobrenome do vendedor
--Quantidade de vendas realizadas
--Quantidade de produtos vendidos
--Montante total transacionado


-- Criação da tabela temporária para armazenar os dados de vendas por mês
CREATE TEMPORARY TABLE vendas_por_mes AS
SELECT 
    strftime('%Y-%m', o.data_pedido) AS mes_ano,  -- Agrupa por mês e ano
    c.customer_id,
    c.nome,
    c.sobrenome,
    SUM(o.valor_total) AS total_vendas,  -- Total de vendas realizadas
    COUNT(o.item_id) AS qtd_produtos_vendidos  -- Contagem dos itens vendidos
FROM "order" o
JOIN customer c ON o.customer_id = c.customer_id
JOIN item i ON o.item_id = i.item_id
JOIN Categoria cat ON i.categoria_id = cat.categoria_id  -- A tabela de categorias
WHERE cat.categoria_id = 16  -- Filtro para a categoria Celulares
AND o.data_pedido BETWEEN '2020-01-01' AND '2020-12-31'  -- Considera apenas o ano de 2020
GROUP BY strftime('%Y-%m', o.data_pedido), c.customer_id;

--Atualizando a tabela de pedidos

UPDATE "Order"
SET item_id= 22
WHERE customer_id IN (22);

-- Consulta os top 5 vendedores por mês
SELECT 
    mes_ano, 
    nome, 
    sobrenome, 
    total_vendas, 
    qtd_produtos_vendidos
FROM vendas_por_mes
ORDER BY total_vendas DESC  -- Ordena por vendas totais em ordem decrescente
LIMIT 5;  -- Limita a 5 resultados


select * from Status



--3 - Preencher uma nova tabela com o preço e o estado dos itens ao final do dia. Tenha em mente que ela deve ser reprocedível. Vale destacar que na tabela Item, teremos apenas o último estado informado, conforme a chave primária (PK) definida. (Isso pode ser resolvido por meio de um Stored Procedure).

-- Apagar registros do dia atual (para garantir que não haja duplicatas)
DELETE FROM Status WHERE data_status = DATE('now');

-- Inserir os dados mais recentes na tabela Item_Historico
INSERT INTO Status (item_id, preco, estado, data_status)
SELECT item_id, preco, estado, DATE('now')
FROM Item
WHERE estado IS NOT NULL;

-- Exericicios extras 

--4 Listar os 5 produtos mais caros por categoria

-- Estou selcionando os 5 produtos mais caros por categoria.

SELECT categoria_id, nome, preco
FROM (
    SELECT categoria_id, nome, preco, 
           ROW_NUMBER() OVER (PARTITION BY categoria_id ORDER BY preco DESC) AS row_num
    FROM Item
) AS ranked_items
WHERE row_num <= 5;

--5-Calcular o total de vendas por mês e ano

-- Selecionando o valor ttoal das venas pelo mes e ano.

SELECT strftime('%Y', data_pedido) AS ano, 
       strftime('%m', data_pedido) AS mes, 
       SUM(quantidade * valor_total) AS total_vendas,
       SUM(quantidade) AS total_itens
FROM "Order"
GROUP BY ano, mes
ORDER BY ano DESC, mes DESC;

--6 - Encontrar os usuários que compraram mais de 3 itens no mesmo dia

-- Selecionando os usuários que nao compram a mais de 3 dias no mercado livre.

SELECT c.customer_id, c.nome, c.email, o.data_pedido, COUNT(o.item_id) AS itens_comprados
FROM "Order" o
JOIN Customer c ON o.customer_id = c.customer_id
GROUP BY c.customer_id, o.data_pedido
HAVING COUNT(o.item_id) > 3;

select * from Order_Item
