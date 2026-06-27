-- ============================================================
-- Script : ADD FK — Gold Layer
-- Autor  : Teofilo Correa Rojas
-- Fecha  : 27 Junio 2026
-- ============================================================

-- ========================
-- FK: gold.fact_ventas
-- ========================
ALTER TABLE gold.fact_ventas
    ADD CONSTRAINT fk_fact_ventas_cliente
    FOREIGN KEY (cliente_id)
    REFERENCES gold.dim_clientes(id);

ALTER TABLE gold.fact_ventas
    ADD CONSTRAINT fk_fact_ventas_producto
    FOREIGN KEY (producto_id)
    REFERENCES gold.dim_productos(id);

ALTER TABLE gold.fact_ventas
    ADD CONSTRAINT fk_fact_ventas_empleado
    FOREIGN KEY (empleado_id)
    REFERENCES gold.dim_empleados(id);

ALTER TABLE gold.fact_ventas
    ADD CONSTRAINT fk_fact_ventas_tiempo
    FOREIGN KEY (tiempo_id)
    REFERENCES gold.dim_tiempo(id);