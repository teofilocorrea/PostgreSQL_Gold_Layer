# Project Closure — PostgreSQL Gold Layer

## 📋 Información del proyecto

| Campo | Detalle |
|---|---|
| **Proyecto** | PostgreSQL Gold Layer |
| **Autor** | Teófilo Correa Rojas |
| **Fecha inicio** | Junio 2026 |
| **Fecha cierre** | Junio 2026 |
| **Estado** | ✅ Completado |

---

## 🎯 Objetivos — ¿Se cumplieron?

| Objetivo | Estado |
|---|---|
| Diseñar un modelo dimensional Star Schema puro | ✅ Completado |
| Crear tablas de dimensiones y una fact table | ✅ Completado |
| Aplicar desnormalización intencional | ✅ Completado |
| Construir dimensión de tiempo con EXTRACT | ✅ Completado |
| Implementar ETL Silver → Gold con JOINs | ✅ Completado |
| Aplicar el patrón Surrogate Key Lookup | ✅ Completado |

---

## 🧱 Lo que se construyó

### Dimensiones

| Tabla | Campos clave | Origen |
|---|---|---|
| `gold.dim_clientes` | nombre, ciudad, pais, activo | silver.clientes |
| `gold.dim_empleados` | nombre, cargo, activo | silver.empleados |
| `gold.dim_productos` | nombre, categoria_nombre, proveedor_nombre | silver.productos + JOINs |
| `gold.dim_tiempo` | fecha, dia, mes, trimestre, anio | silver.ordenes + EXTRACT |

### Fact Table

| Tabla | Medidas | FK |
|---|---|---|
| `gold.fact_ventas` | cantidad, precio_unitario, subtotal | 4 FK hacia dimensiones |

### Relaciones FK

| Constraint | Relación |
|---|---|
| `fk_fact_ventas_cliente` | fact_ventas → dim_clientes |
| `fk_fact_ventas_producto` | fact_ventas → dim_productos |
| `fk_fact_ventas_empleado` | fact_ventas → dim_empleados |
| `fk_fact_ventas_tiempo` | fact_ventas → dim_tiempo |

---

## 📚 Lo que aprendí en este proyecto

### Conceptos nuevos

| Concepto | Descripción |
|---|---|
| Star Schema | Modelo dimensional con la fact table en el centro |
| Dimensión vs Fact | Cualitativo (describe) vs cuantitativo (mide) |
| Star puro vs Snowflake | Puro desnormaliza; Snowflake mantiene dimensiones separadas |
| Desnormalización | Traer categoría y proveedor como texto dentro de dim_productos |
| `EXTRACT` | Desglosar una fecha en día, mes, trimestre y año |
| `DISTINCT` | Evitar fechas repetidas en dim_tiempo |
| Surrogate Key Lookup | Traducir el ID de Silver al ID nuevo de Gold vía nombre |

### Decisiones técnicas importantes

- Star Schema puro: categoría y proveedor desnormalizados en dim_productos
- Las dimensiones no se conectan entre sí, solo la fact table tiene FK
- Gold omite campos operativos (created_at), solo conserva valor analítico
- dim_tiempo se construye con EXTRACT y DISTINCT sobre las fechas de órdenes
- La fact table usa los IDs de Gold, no los de Silver

---

## 🔍 El reto principal — fact_ventas

La tabla de hechos fue la más compleja de todo el portafolio.
Combina 9 tablas mediante 8 JOINs, separados en dos propósitos:

```
JOINs de navegación (Silver)
→ recorrer las tablas para obtener los nombres

JOINs de traducción (Silver → Gold)
→ convertir cada nombre en el ID correcto de la dimensión Gold
```

```sql
SELECT
    dc.id,   -- cliente_id de Gold
    dp.id,   -- producto_id de Gold
    de.id,   -- empleado_id de Gold
    t.id,    -- tiempo_id de Gold
    od.cantidad,
    od.precio_unitario,
    od.subtotal
FROM silver.orden_detalle AS od
JOIN silver.ordenes AS o ON od.orden_id = o.id
JOIN gold.dim_tiempo AS t ON o.fecha_orden = t.fecha
JOIN silver.clientes AS c ON o.cliente_id = c.id
JOIN gold.dim_clientes AS dc ON c.nombre = dc.nombre
JOIN silver.productos AS p ON od.producto_id = p.id
JOIN gold.dim_productos AS dp ON p.nombre = dp.nombre
JOIN silver.empleados AS e ON o.empleado_id = e.id
JOIN gold.dim_empleados AS de ON e.nombre = de.nombre;
```

---

## 🔑 Lección más importante

```
La fact table es la tabla más
COMPLEJA de construir,
pero la más SIMPLE de consultar.
Ese es el propósito de Gold:
hacer el trabajo difícil una vez,
para que el análisis sea fácil
siempre.
```

---

## 🔍 Diferencias entre Silver y Gold

| Aspecto | Silver | Gold |
|---|---|---|
| Modelo | Normalizado | Dimensional (Star Schema) |
| Propósito | Datos validados completos | Datos listos para análisis |
| Estructura | Tablas operativas | Dimensiones + fact table |
| Campos | Todos, incluyendo operativos | Solo valor analítico |
| Consulta | Requiere conocimiento técnico | Simple para negocio |
| Audiencia | Analista avanzado | Cualquier usuario de negocio |

---

## 🎉 Cierre de la serie completa

Con este proyecto se cierra la construcción de una plataforma
de datos end-to-end, desde la infraestructura hasta el modelo
analítico final:

| # | Proyecto | Estado |
|---|---|---|
| 1 | PostgreSQL_Database_Infrastructure | ✅ Completado |
| 2 | PostgreSQL_Table_Design (STG) | ✅ Completado |
| 3 | PostgreSQL_Bronze_Layer | ✅ Completado |
| 4 | PostgreSQL_Silver_Layer | ✅ Completado |
| 5 | PostgreSQL_SQL_Queries | ⏸️ Parcial (subconsultas pendiente) |
| 6 | PostgreSQL_Gold_Layer | ✅ Completado |

---

## 🔜 Próximos pasos
```
✅ Completar curso de subconsultas
✅ Actualizar Milestone 4 de SQL_Queries
✅ Crear consultas analíticas sobre el modelo Gold
(ventas por mes, productos top, rendimiento por empleado)
✅ Posible conexión a herramienta BI (Power BI / Metabase)
```

---

## 👤 Autor

### Teófilo Correa Rojas

**Project Manager Digital | Data analytic**

🔗 [LinkedIn](https://www.linkedin.com/in/teófilo-correa-rojas/)