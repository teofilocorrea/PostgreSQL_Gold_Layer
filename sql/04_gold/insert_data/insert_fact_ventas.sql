-- ============================================================
-- Script : ETL INSERT SELECT — Silver → Gold
-- Tabla  : gold.fact_ventas
-- Origen : silver.ordenes (fechas únicas)
-- Autor  : Teofilo Correa Rojas
-- Fecha  : 29 Junio 2026
-- ============================================================

INSERT INTO gold.fact_ventas (cliente_id, producto_id, empleado_id, tiempo_id, cantidad, precio_unitario, subtotal)

SELECT
    dc.id,
    dp.id,
    de.id,
    t.id,
    od.cantidad,
    od.precio_unitario,
    od.subtotal

-- INTERNA
FROM silver.orden_detalle AS od
JOIN silver.ordenes AS o
    ON od.orden_id = o.id
JOIN gold.dim_tiempo AS t
    ON o.fecha_orden = t.fecha

-- EXTERNA - Clientes
JOIN silver.clientes AS c
    ON o.cliente_id = c.id
JOIN gold.dim_clientes AS dc
    ON c.nombre = dc.nombre
-- EXTERNA - Producto
JOIN silver.productos AS p
    ON od.producto_id = p.id
JOIN gold.dim_productos AS dp
    ON p.nombre = dp.nombre
-- EXTERNA - Empleado
JOIN silver.empleados AS e
    ON o.empleado_id = e.id
JOIN gold.dim_empleados AS de
    ON e.nombre = de.nombre;