-- =====================================================================
-- PERGUNTA 2
-- "Quantos assinantes ativos e quanto de MRR cada plano gera?"
--
-- Por que importa: mostra de onde vem a receita recorrente. Um plano com
-- muitos clientes pode faturar menos que outro com poucos - e isso muda
-- onde o time comercial deve investir esforco.
--
-- Comandos: SELECT, FROM, JOIN, WHERE, GROUP BY, ORDER BY
-- =====================================================================

SELECT
    p.nome                    AS plano,
    p.segmento,
    COUNT(a.assinatura_id)    AS assinantes_ativos,
    SUM(p.preco_mensal)       AS mrr
FROM planos AS p
JOIN assinaturas AS a ON a.plano_id = p.plano_id
WHERE a.status = 'ativa'
GROUP BY p.nome, p.segmento
ORDER BY mrr DESC;
