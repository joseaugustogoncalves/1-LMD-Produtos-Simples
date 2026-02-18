USE escola;

-- Solução 1: Listar todos os produtos
SELECT * FROM Produto;

-- Solução 2: Obter cliente que realizou mais compras
SELECT c.nome AS cliente, COUNT(v.id) AS total_compras
FROM Cliente c
    JOIN Venda v ON c.id = v.cliente_id
GROUP BY
    c.id,
    c.nome
ORDER BY total_compras DESC
LIMIT 1;

-- Solução 3: Listar vendas entre '2023-01-01' e '2023-01-10'
SELECT v.id, c.nome AS cliente, p.nome AS produto, v.quantidade, v.data_venda
FROM
    Venda v
    JOIN Cliente c ON v.cliente_id = c.id
    JOIN Produto p ON v.produto_id = p.id
WHERE
    v.data_venda BETWEEN '2023-01-01' AND '2023-01-10'
ORDER BY v.data_venda;

-- Solução 4: Receita total (todas as vendas)
SELECT SUM(v.quantidade * p.preco) AS receita_total
FROM Venda v
    JOIN Produto p ON v.produto_id = p.id;

-- Solução 5: Contar as unidades vendidas de cada produto
SELECT p.nome AS produto, SUM(v.quantidade) AS quantidade_vendida
FROM Produto p
    LEFT JOIN Venda v ON p.id = v.produto_id
GROUP BY
    p.id,
    p.nome
ORDER BY quantidade_vendida DESC;