-- ============================================================
-- Tabla: gold.fact_ventas
-- Descripción: Tabla de hechos central del modelo dimensional.
--              Cada registro representa una línea de venta
--              con sus medidas y claves a las dimensiones.
-- Autor: Teofilo Correa Rojas
-- Fecha: 27 Junio 2026
-- ============================================================

CREATE TABLE IF NOT EXISTS gold.fact_ventas (

    id              SERIAL,
    cliente_id      INTEGER         NOT NULL,
    producto_id     INTEGER         NOT NULL,
    empleado_id     INTEGER         NOT NULL,
    tiempo_id       INTEGER         NOT NULL,
    cantidad        INTEGER         NOT NULL,
    precio_unitario NUMERIC(10,2)   NOT NULL,
    subtotal        NUMERIC(10,2)   NOT NULL,

    -- Constraints: gold.fact_ventas
    CONSTRAINT pk_fact_ventas               PRIMARY KEY (id),
    CONSTRAINT chk_fact_ventas_cantidad     CHECK (cantidad > 0),
    CONSTRAINT chk_fact_ventas_precio       CHECK (precio_unitario > 0),
    CONSTRAINT chk_fact_ventas_subtotal     CHECK (subtotal > 0)

);