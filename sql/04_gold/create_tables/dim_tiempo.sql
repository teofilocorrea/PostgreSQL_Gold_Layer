-- ============================================================
-- Tabla: gold.dim_tiempo
-- Descripción: Dimensión de tiempo que desglosa las fechas
--              de las órdenes para análisis temporal.
-- Autor: Teofilo Correa Rojas
-- Fecha: 26 Junio 2026
-- ============================================================

CREATE TABLE IF NOT EXISTS gold.dim_tiempo (

    id          SERIAL,
    fecha       DATE        NOT NULL,
    dia         INTEGER     NOT NULL,
    mes         INTEGER     NOT NULL,
    trimestre   INTEGER     NOT NULL,
    anio        INTEGER     NOT NULL,

    -- Constraints: gold.dim_tiempo
    CONSTRAINT pk_dim_tiempo PRIMARY KEY (id)

);