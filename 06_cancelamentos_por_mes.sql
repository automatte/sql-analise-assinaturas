-- =====================================================================
-- PERGUNTA 6
-- "Quantos cancelamentos aconteceram por mes e quanto de MRR foi perdido?"
--
-- Por que importa: e o churn em dinheiro, nao so em contagem. Perder 3
-- clientes Starter e muito diferente de perder 1 Enterprise, e a coluna
-- mrr_perdido deixa essa diferenca explicita.
--
-- Comandos: SELECT, FROM, JOIN, WHERE, GROUP BY, ORDER BY
-- =====================================================================

SELECT
    DATE_FORMAT(a.data_cancelamento, '%Y-%m') AS mes_cancelamento,
    COUNT(a.assinatura_id)                    AS cancelamentos,
    SUM(p.preco_mensal)                       AS mrr_perdido
FROM assinaturas AS a
JOIN planos AS p ON p.plano_id = a.plano_id
WHERE a.status = 'cancelada'
GROUP BY DATE_FORMAT(a.data_cancelamento, '%Y-%m')
ORDER BY mes_cancelamento;
