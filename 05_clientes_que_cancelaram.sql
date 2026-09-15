-- =====================================================================
-- PERGUNTA 5
-- "Quem cancelou, de que plano saiu e quanto tempo ficou na base?"
--
-- Por que importa: tempo de vida curto em um plano especifico costuma
-- indicar problema de expectativa na venda ou de onboarding. Essa lista
-- e o ponto de partida de qualquer analise de churn.
--
-- Comandos: SELECT, FROM, JOIN, WHERE, ORDER BY
--
-- Nota: DATEDIFF(data_maior, data_menor) devolve a diferenca em dias.
-- =====================================================================

SELECT
    c.nome_empresa,
    p.nome                                                AS plano,
    c.canal_aquisicao,
    a.data_inicio,
    a.data_cancelamento,
    DATEDIFF(a.data_cancelamento, a.data_inicio)          AS dias_na_base
FROM assinaturas AS a
JOIN clientes AS c ON c.cliente_id = a.cliente_id
JOIN planos   AS p ON p.plano_id   = a.plano_id
WHERE a.status = 'cancelada'
ORDER BY dias_na_base;
