-- ============================================================
-- Script : ETL INSERT SELECT — Silver → Gold
-- Tabla  : gold.dim_productos
-- Origen : silver.productos + categorias + proveedores
-- Autor  : Teofilo Correa Rojas
-- Fecha  : 28 Junio 2026
-- ============================================================

INSERT INTO gold.dim_productos (nombre, descripcion, precio, categoria_nombre, proveedor_nombre, activo)
SELECT
    p.nombre,
    p.descripcion,
    p.precio,
    c.nombre,
    pr.nombre,
    p.activo
FROM silver.productos AS p
JOIN silver.categorias AS c
    ON p.categoria_id = c.id
JOIN silver.proveedores AS pr
    ON p.proveedor_id = pr.id;