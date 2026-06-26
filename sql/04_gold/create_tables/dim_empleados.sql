-- ============================================================
-- Tabla: gold.dim_empleados
-- Descripción: Dimensión de empleados para análisis de
--              rendimiento de ventas.
-- Autor: Teofilo Correa Rojas
-- Fecha: 26 Junio 2026
-- ============================================================

CREATE TABLE IF NOT EXISTS gold.dim_empleados (

    id              SERIAL,
    nombre          VARCHAR(250)    NOT NULL,
    email           VARCHAR(100)    NOT NULL,
    cargo           VARCHAR(250)    NOT NULL,
    fecha_ingreso   DATE            NOT NULL,
    activo          BOOLEAN         NOT NULL,

    -- Constraints: gold.dim_empleados
    CONSTRAINT pk_dim_empleados PRIMARY KEY (id)

);