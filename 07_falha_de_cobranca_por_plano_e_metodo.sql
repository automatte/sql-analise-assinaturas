-- =====================================================================
-- PERGUNTA 7
-- "Onde a cobranca falha mais: em qual plano e em qual meio de pagamento?"
--
-- Por que importa: cobranca que falha e churn involuntario - o cliente
-- queria continuar e a empresa perdeu a receita por problema operacional.
-- Cruzar plano x metodo mostra exatamente onde agir.
--
-- Comandos: SELECT, FROM, JOIN, WHERE, GROUP BY, ORDER BY
-- =====================================================================

SELECT
    p.nome                  AS plano,
    cb.metodo,
    COUNT(cb.cobranca_id)   AS cobrancas_com_falha,
    SUM(cb.valor)           AS valor_nao_recebido
FROM cobrancas AS cb
JOIN assinaturas AS a ON a.assinatura_id = cb.assinatura_id
JOIN planos      AS p ON p.plano_id      = a.plano_id
WHERE cb.status = 'falha'
GROUP BY p.nome, cb.metodo
ORDER BY valor_nao_recebido DESC;
