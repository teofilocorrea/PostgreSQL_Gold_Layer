![Banner](asset/cover_gold_layer_SQL.png)

## 📌 Descripción

Este proyecto implementa la **capa Gold** de una arquitectura
Medallion en PostgreSQL, aplicando un **modelo dimensional
Star Schema** sobre un e-commerce. Los datos se transforman
desde la capa Silver hacia dimensiones y una tabla de hechos
optimizadas para análisis.

---

## 🎯 Objetivos del proyecto

- Diseñar un modelo dimensional Star Schema puro
- Crear tablas de dimensiones y una fact table
- Aplicar desnormalización intencional para análisis
- Construir una dimensión de tiempo con EXTRACT
- Implementar ETL Silver → Gold con JOINs múltiples
- Aplicar el patrón Surrogate Key Lookup

---

## 🏗️ Arquitectura — Capa Gold

```
Arquitectura Medallion
│
├── STG     ← Proyecto 2
├── Bronze  ← Proyecto 3
├── Silver  ← Proyecto 4
└── Gold    ← este proyecto (modelo dimensional)
```
La capa Gold es la capa analítica final. A diferencia de Silver
(normalizada), Gold usa un modelo dimensional desnormalizado
optimizado para reportería y análisis de negocio.

---

## 🌟 Modelo Star Schema

```
gold.dim_clientes
                     │
gold.dim_productos ──┼── gold.dim_empleados
│
gold.fact_ventas
│
gold.dim_tiempo
```
**Star Schema PURO:** las dimensiones no se conectan entre sí.
Solo `fact_ventas` tiene FK hacia las dimensiones. Las categorías
y proveedores están desnormalizados dentro de `dim_productos`.

---

## 🧱 Estructura del proyecto

```
PostgreSQL_Gold_Layer/

│
├── asset/
│   ├── table_design_SQL_gold.png
│   └── diagram_star_schema.png
│
├── docs/
│   └── project_closure.md
│
├── sql/
│   └── 04_gold/
│       ├── create_tables/
│       │   ├── 01_create_dim_clientes.sql
│       │   ├── 02_create_dim_empleados.sql
│       │   ├── 03_create_dim_productos.sql
│       │   ├── 04_create_dim_tiempo.sql
│       │   └── 05_create_fact_ventas.sql
│       ├── add_constraints/
│       │   └── 01_add_fk_gold.sql
│       ├── insert_data/
│       │   ├── 01_insert_dim_clientes.sql
│       │   ├── 02_insert_dim_empleados.sql
│       │   ├── 03_insert_dim_productos.sql
│       │   ├── 04_insert_dim_tiempo.sql
│       │   └── 05_insert_fact_ventas.sql
│       ├── README.md
│       └── data_dictionary_gold.md
│
├── .gitignore
└── README.md
```
---

## 📊 Tablas del modelo

| Tabla | Tipo | Descripción |
|---|---|---|
| `gold.dim_clientes` | Dimensión | Atributos del cliente |
| `gold.dim_empleados` | Dimensión | Atributos del empleado |
| `gold.dim_productos` | Dimensión | Producto + categoría + proveedor |
| `gold.dim_tiempo` | Dimensión | Fechas desglosadas |
| `gold.fact_ventas` | Hechos | Cada línea de venta |

---

## 🔑 Conceptos clave aplicados

| Concepto | Descripción |
|---|---|
| Star Schema | Modelo dimensional con fact en el centro |
| Dimensión vs Fact | Cualitativo (describe) vs cuantitativo (mide) |
| Desnormalización | Categoría y proveedor dentro de dim_productos |
| `EXTRACT` | Desglose de fechas en dim_tiempo |
| Surrogate Key Lookup | Traducción de IDs Silver → Gold vía JOIN |

---

## 🔄 ETL — El reto de fact_ventas

La carga de `fact_ventas` combina 9 tablas con 8 JOINs. El patrón
clave es navegar por Silver para obtener los nombres, y luego
traducirlos al ID correspondiente en cada dimensión Gold:

```sql
SELECT dc.id, dp.id, de.id, t.id,
       od.cantidad, od.precio_unitario, od.subtotal
FROM silver.orden_detalle AS od
JOIN silver.ordenes AS o ON od.orden_id = o.id
JOIN gold.dim_tiempo AS t ON o.fecha_orden = t.fecha
-- + JOINs de navegación y traducción para
--   cliente, producto y empleado
```

---

## 🔗 Proyectos relacionados

| # | Proyecto | Descripción |
|---|---|---|
| 1 | [PostgreSQL_Database_Infrastructure](https://github.com/teofilocorrea/PostgreSQL_Database_Infrastructure) | Base de datos y esquemas |
| 2 | [PostgreSQL_Table_Design](https://github.com/teofilocorrea/PostgreSQL_Table_Design) | STG Layer |
| 3 | [PostgreSQL_Bronze_Layer](https://github.com/teofilocorrea/PostgreSQL_Bronze_Layer) | Bronze Layer |
| 4 | [PostgreSQL_Silver_Layer](https://github.com/teofilocorrea/PostgreSQL_Silver_Layer) | Silver Layer |
| 5 | [PostgreSQL_SQL_Queries](https://github.com/teofilocorrea/PostgreSQL_SQL_Queries) | Consultas SQL |
| 6 | PostgreSQL_Gold_Layer | Modelo dimensional ← estás aquí |

---

## 👤 Autor

### Teófilo Correa Rojas

**Project Manager Digital | Data analytic**

🔗 [LinkedIn](https://www.linkedin.com/in/teófilo-correa-rojas/)
