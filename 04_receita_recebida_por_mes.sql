-- =====================================================================
-- PERGUNTA 4
-- "Quanto de receita foi efetivamente recebida em cada mes?"
--
-- Por que importa: receita contratada nao e receita no caixa. Aqui contam
-- so as cobrancas com status 'paga' - e essa serie mostra se a empresa
-- esta crescendo, estavel ou encolhendo mes a mes.
--
-- Comandos: SELECT, FROM, WHERE, GROUP BY, ORDER BY
--
-- Nota: DATE_FORMAT(data, '%Y-%m') transforma cada data no seu mes
-- ('2026-03-14' -> '2026-03'), que e o que permite agrupar por mes.
-- =====================================================================

SELECT
    DATE_FORMAT(cb.data_cobranca, '%Y-%m') AS mes,
    COUNT(cb.cobranca_id)                  AS cobrancas_pagas,
    SUM(cb.valor)                          AS receita_recebida
FROM cobrancas AS cb
WHERE cb.status = 'paga'
GROUP BY DATE_FORMAT(cb.data_cobranca, '%Y-%m')
ORDER BY mes;
