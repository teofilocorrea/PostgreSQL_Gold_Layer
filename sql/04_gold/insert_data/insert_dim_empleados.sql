-- ============================================================
-- Script : ETL INSERT SELECT — Silver → Gold
-- Tabla  : gold.dim_empleados
-- Origen : silver.empleados
-- Autor  : Teofilo Correa Rojas
-- Fecha  : 28 Junio 2026
-- ============================================================

INSERT INTO gold.dim_empleados (nombre, email, cargo, fecha_ingreso, activo)

SELECT
    nombre,
    email,
    cargo,
    fecha_ingreso,
    activo
FROM silver.empleados;