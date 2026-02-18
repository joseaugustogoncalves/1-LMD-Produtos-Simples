#!/bin/bash

# Cores para output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Contadores
PASSED=0
FAILED=0

echo "=========================================="
echo "  VALIDAÇÃO AUTOMÁTICA DE TESTES SQL"
echo "=========================================="
echo ""

# Função para comparar resultados
compare_results() {
    local test_name=$1
    local student_result=$2
    local expected_result=$3
    
    if [ "$student_result" == "$expected_result" ]; then
        echo -e "${GREEN}✓ PASSOU${NC} - $test_name"
        ((PASSED++))
        return 0
    else
        echo -e "${RED}✗ FALHOU${NC} - $test_name"
        echo -e "  ${YELLOW}Esperado:${NC} $expected_result"
        echo -e "  ${YELLOW}Obtido:${NC}   $student_result"
        ((FAILED++))
        return 1
    fi
}

# TESTE 1: Listar todos os produtos (verificar quantidade)
echo "Teste 1: Listar todos os produtos..."
STUDENT_COUNT=$(mysql -h 127.0.0.1 -u root -ppassword -N -e "USE escola; SELECT COUNT(*) FROM Produto;")
EXPECTED_COUNT=5
compare_results "Contagem de produtos" "$STUDENT_COUNT" "$EXPECTED_COUNT"
echo ""

# TESTE 2: Cliente que realizou mais compras
echo "Teste 2: Cliente com mais compras..."
STUDENT_CLIENT=$(mysql -h 127.0.0.1 -u root -ppassword -N -e "USE escola; SELECT c.nome FROM Cliente c JOIN Venda v ON c.id = v.cliente_id GROUP BY c.id, c.nome ORDER BY COUNT(v.id) DESC LIMIT 1;")
EXPECTED_CLIENT="João Silva"
compare_results "Cliente com mais compras" "$STUDENT_CLIENT" "$EXPECTED_CLIENT"
echo ""

# TESTE 3: Vendas entre datas (verificar quantidade)
echo "Teste 3: Vendas entre '2023-01-01' e '2023-01-10'..."
STUDENT_SALES_COUNT=$(mysql -h 127.0.0.1 -u root -ppassword -N -e "USE escola; SELECT COUNT(*) FROM Venda WHERE data_venda BETWEEN '2023-01-01' AND '2023-01-10';")
EXPECTED_SALES_COUNT=4
compare_results "Contagem de vendas no período" "$STUDENT_SALES_COUNT" "$EXPECTED_SALES_COUNT"
echo ""

# TESTE 4: Receita total
echo "Teste 4: Receita total de todas as vendas..."
STUDENT_REVENUE=$(mysql -h 127.0.0.1 -u root -ppassword -N -e "USE escola; SELECT SUM(v.quantidade * p.preco) FROM Venda v JOIN Produto p ON v.produto_id = p.id;")
EXPECTED_REVENUE="181.70"
compare_results "Receita total" "$STUDENT_REVENUE" "$EXPECTED_REVENUE"
echo ""

# TESTE 5: Produto mais vendido
echo "Teste 5: Produto mais vendido..."
STUDENT_TOP_PRODUCT=$(mysql -h 127.0.0.1 -u root -ppassword -N -e "USE escola; SELECT p.nome FROM Produto p LEFT JOIN Venda v ON p.id = v.produto_id GROUP BY p.id, p.nome ORDER BY SUM(v.quantidade) DESC LIMIT 1;")
EXPECTED_TOP_PRODUCT="Produto D"
compare_results "Produto mais vendido" "$STUDENT_TOP_PRODUCT" "$EXPECTED_TOP_PRODUCT"
echo ""

# Resumo final
echo "=========================================="
echo "           RESUMO DOS TESTES"
echo "=========================================="
echo -e "${GREEN}Testes Aprovados:${NC} $PASSED"
echo -e "${RED}Testes Falhados:${NC}  $FAILED"
echo "=========================================="

# Retornar código de erro se algum teste falhou
if [ $FAILED -gt 0 ]; then
    exit 1
else
    echo -e "${GREEN}Todos os testes passaram com sucesso!${NC}"
    exit 0
fi