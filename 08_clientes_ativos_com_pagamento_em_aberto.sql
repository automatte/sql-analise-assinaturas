-- =====================================================================
-- PERGUNTA 8
-- "Quais clientes ativos tem cobranca em aberto (falha ou pendente)?"
--
-- Por que importa: essa e a lista de trabalho do time de cobranca. Sao
-- clientes que continuam usando o produto sem ter pago - receita
-- recuperavel se alguem falar com eles esta semana.
--
-- Comandos: SELECT, FROM, JOIN, WHERE, GROUP BY, ORDER BY
-- =====================================================================

SELECT
    c.nome_empresa,
    c.pais,
    p.nome                  AS plano,
    COUNT(cb.cobranca_id)   AS cobrancas_em_aberto,
    SUM(cb.valor)           AS valor_em_aberto
FROM cobrancas AS cb
JOIN assinaturas AS a ON a.assinatura_id = cb.assinatura_id
JOIN clientes    AS c ON c.cliente_id    = a.cliente_id
JOIN planos      AS p ON p.plano_id      = a.plano_id
WHERE a.status = 'ativa'
  AND cb.status IN ('falha', 'pendente')
GROUP BY c.nome_empresa, c.pais, p.nome
ORDER BY valor_em_aberto DESC;
