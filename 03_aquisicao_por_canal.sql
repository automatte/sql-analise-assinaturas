-- =====================================================================
-- PERGUNTA 3
-- "Qual canal de aquisicao traz mais clientes e qual traz mais receita?"
--
-- Por que importa: volume e receita nao andam juntos. Um canal pode
-- trazer muitos clientes de plano baixo e outro poucos clientes grandes.
-- Essa leitura orienta onde colocar orcamento de midia.
--
-- Comandos: SELECT, FROM, JOIN, WHERE, GROUP BY, ORDER BY
-- =====================================================================

SELECT
    c.canal_aquisicao,
    COUNT(a.assinatura_id)  AS assinantes_ativos,
    SUM(p.preco_mensal)     AS mrr,
    AVG(p.preco_mensal)     AS ticket_medio_mensal
FROM clientes AS c
JOIN assinaturas AS a ON a.cliente_id = c.cliente_id
JOIN planos      AS p ON p.plano_id   = a.plano_id
WHERE a.status = 'ativa'
GROUP BY c.canal_aquisicao
ORDER BY mrr DESC;
