-- ============================================================
-- Script : ETL INSERT SELECT — Silver → Gold
-- Tabla  : gold.dim_clientes
-- Origen : silver.clientes
-- Autor  : Teofilo Correa Rojas
-- Fecha  : 28 Junio 2026
-- ============================================================

INSERT INTO gold.dim_clientes (nombre, email, telefono, ciudad, pais, fecha_registro, activo)
SELECT
    nombre,
    email,
    telefono,
    ciudad,
    pais,
    fecha_registro,
    activo
FROM silver.clientes;