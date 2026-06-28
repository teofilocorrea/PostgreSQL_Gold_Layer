-- ============================================================
-- Script : ETL INSERT SELECT — Silver → Gold
-- Tabla  : gold.dim_tiempo
-- Origen : silver.ordenes (fechas únicas)
-- Autor  : Teofilo Correa Rojas
-- Fecha  : 28 Junio 2026
-- ============================================================

INSERT INTO gold.dim_tiempo (fecha, dia, mes, trimestre, anio)
SELECT DISTINCT
    fecha_orden,
    EXTRACT(DAY FROM fecha_orden),
    EXTRACT(MONTH FROM fecha_orden),
    EXTRACT(QUARTER FROM fecha_orden),
    EXTRACT(YEAR FROM fecha_orden)
FROM silver.ordenes;