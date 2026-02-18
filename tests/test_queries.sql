use escola;

-- Teste 1: Listar todos os produtos
SELECT 'TESTE 1' AS Teste, COUNT(*) AS resultado_esperado
FROM Produto;

-- Teste 2: Obter cliente que realizou mais compras
SELECT 'TESTE 2' AS Teste, MAX(total_compras) AS resultado_esperado
FROM (
        SELECT cliente_id, COUNT(*) AS total_compras
        FROM Venda
        GROUP BY
            cliente_id
    ) AS subquery;

-- Teste 3: Listar vendas entre '2023-01-01' e '2023-01-10'
SELECT 'TESTE 3' AS Teste, COUNT(*) AS resultado_esperado
FROM Venda
WHERE
    data_venda BETWEEN '2023-01-01' AND '2023-01-10';

-- Teste 4: Receita total (todas as vendas)
SELECT 'TESTE 4' AS Teste, SUM(v.quantidade * p.preco) AS resultado_esperado
FROM Venda v
    JOIN Produto p ON v.produto_id = p.id;

-- Teste 5: Contar as unidades vendidas de cada produto
SELECT 'TESTE 5' AS Teste, p.nome, SUM(v.quantidade) AS quantidade_vendida
FROM Produto p
    LEFT JOIN Venda v ON p.id = v.produto_id
GROUP BY
    p.id
ORDER BY quantidade_vendida DESC;