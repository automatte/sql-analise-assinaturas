-- =====================================================================
-- PERGUNTA 10
-- "Quais clientes ativos avaliaram o suporte com nota baixa (1 ou 2)?"
--
-- Por que importa: junta base ativa + sinal de insatisfacao. E uma lista
-- de risco de churn ordenada pelo preco do plano: o time de CS ataca
-- primeiro quem custa mais caro perder.
--
-- Comandos: SELECT, FROM, JOIN, WHERE, GROUP BY, ORDER BY
-- =====================================================================

SELECT
    c.nome_empresa,
    p.nome                AS plano,
    p.preco_mensal,
    COUNT(t.ticket_id)    AS tickets_nota_baixa,
    AVG(t.satisfacao)     AS satisfacao_media
FROM tickets_suporte AS t
JOIN clientes    AS c ON c.cliente_id    = t.cliente_id
JOIN assinaturas AS a ON a.cliente_id    = c.cliente_id
JOIN planos      AS p ON p.plano_id      = a.plano_id
WHERE a.status = 'ativa'
  AND t.satisfacao IN (1, 2)
GROUP BY c.nome_empresa, p.nome, p.preco_mensal
ORDER BY p.preco_mensal DESC, tickets_nota_baixa DESC;
