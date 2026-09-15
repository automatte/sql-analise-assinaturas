-- =====================================================================
-- PERGUNTA 9
-- "Qual o volume de tickets e a satisfacao media por categoria?"
--
-- Por que importa: separa o que da trabalho do que da insatisfacao. Uma
-- categoria com muitos tickets e nota alta e operacional; poucos tickets
-- com nota baixa e um problema de produto que precisa subir na fila.
--
-- Comandos: SELECT, FROM, WHERE, GROUP BY, ORDER BY
-- =====================================================================

SELECT
    t.categoria,
    COUNT(t.ticket_id)   AS tickets_avaliados,
    AVG(t.satisfacao)    AS satisfacao_media
FROM tickets_suporte AS t
WHERE t.satisfacao IS NOT NULL
GROUP BY t.categoria
ORDER BY satisfacao_media;
