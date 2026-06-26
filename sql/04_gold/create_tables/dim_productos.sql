-- ============================================================
-- Tabla: gold.dim_productos
-- Descripción: Dimensión de productos para análisis de
--              rendimiento de ventas.
-- Autor: Teofilo Correa Rojas
-- Fecha: 26 Junio 2026
-- ============================================================

CREATE TABLE IF NOT EXISTS gold.dim_productos (

    id                  SERIAL,
    nombre              VARCHAR(250)    NOT NULL,
    descripcion         TEXT            NOT NULL,
    precio              NUMERIC(10,2)   NOT NULL,
    categoria_nombre    VARCHAR(100)    NOT NULL,
    proveedor_nombre    VARCHAR(100)    NOT NULL,
    activo              BOOLEAN         NOT NULL,

    -- Constraints: gold.dim_empleados
    CONSTRAINT pk_dim_productos PRIMARY KEY (id)
);