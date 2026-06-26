-- ============================================================
-- Tabla: gold.dim_clientes
-- Descripción: Dimensión de clientes para análisis de ventas.
--              Contiene atributos descriptivos del cliente.
-- Autor: Teofilo Correa Rojas
-- Fecha: 26 Junio 2026
-- ============================================================

CREATE TABLE IF NOT EXISTS gold.dim_clientes (

    id              SERIAL,
    nombre          VARCHAR(250)    NOT NULL,
    email           VARCHAR(100)    NOT NULL,
    telefono        VARCHAR(30)     NOT NULL,
    ciudad          VARCHAR(250)    NOT NULL,
    pais            VARCHAR(250)    NOT NULL,
    fecha_registro  DATE            NOT NULL,
    activo          BOOLEAN         NOT NULL,

    -- Constraints: gold.dim_clientes
    CONSTRAINT pk_dim_clientes PRIMARY KEY (id)

);