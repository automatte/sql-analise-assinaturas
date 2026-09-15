-- =====================================================================
-- schema.sql
-- Modelo de dados de uma empresa de assinaturas (SaaS)
-- MySQL 8.0+ / MariaDB 10.4+
-- =====================================================================

CREATE DATABASE IF NOT EXISTS saas_demo
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_general_ci;

USE saas_demo;

-- A ordem do DROP respeita as chaves estrangeiras:
-- as tabelas "filhas" caem antes das "pais".
DROP TABLE IF EXISTS tickets_suporte;
DROP TABLE IF EXISTS cobrancas;
DROP TABLE IF EXISTS assinaturas;
DROP TABLE IF EXISTS clientes;
DROP TABLE IF EXISTS planos;

-- ---------------------------------------------------------------------
-- planos: catalogo de planos vendidos
-- ---------------------------------------------------------------------
CREATE TABLE planos (
    plano_id      INT           NOT NULL,
    nome          VARCHAR(30)   NOT NULL,   -- Starter, Pro, Business, Enterprise
    preco_mensal  DECIMAL(10,2) NOT NULL,
    segmento      VARCHAR(20)   NOT NULL,   -- PME, Mid-Market, Enterprise
    PRIMARY KEY (plano_id)
) ENGINE = InnoDB;

-- ---------------------------------------------------------------------
-- clientes: quem contratou
-- ---------------------------------------------------------------------
CREATE TABLE clientes (
    cliente_id       INT         NOT NULL,
    nome_empresa     VARCHAR(60) NOT NULL,
    pais             VARCHAR(20) NOT NULL,
    canal_aquisicao  VARCHAR(20) NOT NULL,  -- Google Ads, Meta Ads, Indicacao, Organico, Outbound
    data_cadastro    DATE        NOT NULL,
    PRIMARY KEY (cliente_id)
) ENGINE = InnoDB;

-- ---------------------------------------------------------------------
-- assinaturas: contrato entre cliente e plano
-- status: ativa | cancelada
-- ---------------------------------------------------------------------
CREATE TABLE assinaturas (
    assinatura_id      INT         NOT NULL,
    cliente_id         INT         NOT NULL,
    plano_id           INT         NOT NULL,
    data_inicio        DATE        NOT NULL,
    data_cancelamento  DATE        NULL,     -- NULL = ainda ativa
    status             VARCHAR(10) NOT NULL,
    PRIMARY KEY (assinatura_id),
    FOREIGN KEY (cliente_id) REFERENCES clientes(cliente_id),
    FOREIGN KEY (plano_id)   REFERENCES planos(plano_id)
) ENGINE = InnoDB;

-- ---------------------------------------------------------------------
-- cobrancas: tentativas de cobranca recorrente
-- status: paga | falha | pendente
-- ---------------------------------------------------------------------
CREATE TABLE cobrancas (
    cobranca_id    INT           NOT NULL,
    assinatura_id  INT           NOT NULL,
    data_cobranca  DATE          NOT NULL,
    valor          DECIMAL(10,2) NOT NULL,
    status         VARCHAR(10)   NOT NULL,
    metodo         VARCHAR(20)   NOT NULL,   -- Cartao, Boleto, Pix
    PRIMARY KEY (cobranca_id),
    FOREIGN KEY (assinatura_id) REFERENCES assinaturas(assinatura_id)
) ENGINE = InnoDB;

-- ---------------------------------------------------------------------
-- tickets_suporte: atendimentos abertos pelos clientes
-- satisfacao: nota de 1 a 5 (NULL = ticket sem avaliacao)
-- ---------------------------------------------------------------------
CREATE TABLE tickets_suporte (
    ticket_id      INT         NOT NULL,
    cliente_id     INT         NOT NULL,
    data_abertura  DATE        NOT NULL,
    categoria      VARCHAR(20) NOT NULL,     -- Financeiro, Bug, Duvida, Integracao, Onboarding
    satisfacao     INT         NULL,
    PRIMARY KEY (ticket_id),
    FOREIGN KEY (cliente_id) REFERENCES clientes(cliente_id)
) ENGINE = InnoDB;
