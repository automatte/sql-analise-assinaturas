-- =====================================================================
-- PERGUNTA 1
-- "Quem sao os clientes com assinatura ativa hoje e em que plano estao?"
--
-- Por que importa: e a foto da base atual. Toda conversa de receita,
-- suporte ou upsell comeca sabendo exatamente quem esta dentro.
--
-- Comandos: SELECT, FROM, JOIN, WHERE, ORDER BY
-- =====================================================================

SELECT
    c.nome_empresa,
    c.pais,
    p.nome            AS plano,
    p.preco_mensal,
    a.data_inicio
FROM assinaturas AS a
JOIN clientes AS c ON c.cliente_id = a.cliente_id
JOIN planos   AS p ON p.plano_id   = a.plano_id
WHERE a.status = 'ativa'
ORDER BY p.preco_mensal DESC, c.nome_empresa;
