# Diccionario de Datos — Gold Layer

## Propósito de la capa
Capa analítica final con modelo dimensional (Star Schema).
Los datos vienen de Silver y se transforman en dimensiones
y una tabla de hechos optimizadas para análisis y reportería.

## Reglas generales de la capa
- Modelo dimensional Star Schema puro
- Las dimensiones NO se conectan entre sí
- Solo la fact table tiene FK hacia las dimensiones
- Desnormalización intencional (categoria y proveedor dentro de productos)
- Sin columnas operativas (created_at, record_status)
- Solo campos con valor analítico
- Datos cargados con ETL desde Silver

## Tipo de tablas

| Tipo | Descripción | Tablas |
|---|---|---|
| Dimensión | Atributos descriptivos (cualitativo) | dim_clientes, dim_empleados, dim_productos, dim_tiempo |
| Hechos | Eventos y medidas (cuantitativo) | fact_ventas |

---

## Tabla: gold.dim_clientes

### Descripción
Dimensión que almacena los atributos descriptivos de los clientes
para análisis de ventas.

### Campos

| Campo | ¿Qué guarda? | Tipo | Constraint | Origen |
|---|---|---|---|---|
| id | Identificador único de la dimensión | SERIAL | PRIMARY KEY | autogenerado |
| nombre | Nombre del cliente | VARCHAR(250) | NOT NULL | silver.clientes |
| email | Correo del cliente | VARCHAR(100) | NOT NULL | silver.clientes |
| telefono | Teléfono de contacto | VARCHAR(30) | NOT NULL | silver.clientes |
| ciudad | Ciudad del cliente | VARCHAR(250) | NOT NULL | silver.clientes |
| pais | País del cliente | VARCHAR(250) | NOT NULL | silver.clientes |
| fecha_registro | Fecha de registro como cliente | DATE | NOT NULL | silver.clientes |
| activo | Si el cliente está activo | BOOLEAN | NOT NULL | silver.clientes |

---

## Tabla: gold.dim_empleados

### Descripción
Dimensión que almacena los atributos descriptivos de los empleados
para análisis de rendimiento de ventas.

### Campos

| Campo | ¿Qué guarda? | Tipo | Constraint | Origen |
|---|---|---|---|---|
| id | Identificador único de la dimensión | SERIAL | PRIMARY KEY | autogenerado |
| nombre | Nombre del empleado | VARCHAR(250) | NOT NULL | silver.empleados |
| email | Correo corporativo | VARCHAR(100) | NOT NULL | silver.empleados |
| cargo | Puesto del empleado | VARCHAR(250) | NOT NULL | silver.empleados |
| fecha_ingreso | Fecha de ingreso a la empresa | DATE | NOT NULL | silver.empleados |
| activo | Si el empleado está activo | BOOLEAN | NOT NULL | silver.empleados |

---

## Tabla: gold.dim_productos

### Descripción
Dimensión que almacena los atributos descriptivos de los productos.
Aplica desnormalización Star Schema puro: incluye el nombre de la
categoría y del proveedor directamente, sin dimensiones separadas.

### Campos

| Campo | ¿Qué guarda? | Tipo | Constraint | Origen |
|---|---|---|---|---|
| id | Identificador único de la dimensión | SERIAL | PRIMARY KEY | autogenerado |
| nombre | Nombre del producto | VARCHAR(100) | NOT NULL | silver.productos |
| descripcion | Descripción del producto | TEXT | NOT NULL | silver.productos |
| precio | Precio de venta | NUMERIC(10,2) | NOT NULL | silver.productos |
| categoria_nombre | Nombre de la categoría | VARCHAR(100) | NOT NULL | silver.categorias (JOIN) |
| proveedor_nombre | Nombre del proveedor | VARCHAR(100) | NOT NULL | silver.proveedores (JOIN) |
| activo | Si el producto está disponible | BOOLEAN | NOT NULL | silver.productos |

---

## Tabla: gold.dim_tiempo

### Descripción
Dimensión de tiempo que desglosa las fechas de las órdenes en
componentes para análisis temporal. Se construye extrayendo las
fechas únicas de silver.ordenes.

### Campos

| Campo | ¿Qué guarda? | Tipo | Constraint | Origen |
|---|---|---|---|---|
| id | Identificador único de la dimensión | SERIAL | PRIMARY KEY | autogenerado |
| fecha | Fecha completa | DATE | NOT NULL | silver.ordenes (fecha única) |
| dia | Día del mes | INTEGER | NOT NULL | EXTRACT(DAY) |
| mes | Número del mes | INTEGER | NOT NULL | EXTRACT(MONTH) |
| trimestre | Trimestre del año | INTEGER | NOT NULL | EXTRACT(QUARTER) |
| anio | Año | INTEGER | NOT NULL | EXTRACT(YEAR) |

---

## Tabla: gold.fact_ventas

### Descripción
Tabla de hechos central del modelo. Cada registro representa una
línea de venta (orden_detalle). Combina las claves de las dimensiones
con las medidas cuantitativas de la venta.

### Campos

| Campo | ¿Qué guarda? | Tipo | Tipo de campo | Constraint | Origen |
|---|---|---|---|---|---|
| id | Identificador único del hecho | SERIAL | PK | PRIMARY KEY | autogenerado |
| cliente_id | Referencia al cliente | INTEGER | FK | NOT NULL + FK | dim_clientes (vía nombre) |
| producto_id | Referencia al producto | INTEGER | FK | NOT NULL + FK | dim_productos (vía nombre) |
| empleado_id | Referencia al empleado | INTEGER | FK | NOT NULL + FK | dim_empleados (vía nombre) |
| tiempo_id | Referencia a la fecha | INTEGER | FK | NOT NULL + FK | dim_tiempo (vía fecha) |
| cantidad | Unidades vendidas | INTEGER | Medida | NOT NULL + CHECK > 0 | silver.orden_detalle |
| precio_unitario | Precio al momento de venta | NUMERIC(10,2) | Medida | NOT NULL + CHECK > 0 | silver.orden_detalle |
| subtotal | cantidad x precio_unitario | NUMERIC(10,2) | Medida | NOT NULL + CHECK > 0 | silver.orden_detalle |

---

## Relaciones — FK de la Fact Table

| Tabla origen | Campo | Tabla destino | Constraint |
|---|---|---|---|
| `gold.fact_ventas` | `cliente_id` | `gold.dim_clientes` | `fk_fact_ventas_cliente` |
| `gold.fact_ventas` | `producto_id` | `gold.dim_productos` | `fk_fact_ventas_producto` |
| `gold.fact_ventas` | `empleado_id` | `gold.dim_empleados` | `fk_fact_ventas_empleado` |
| `gold.fact_ventas` | `tiempo_id` | `gold.dim_tiempo` | `fk_fact_ventas_tiempo` |

---

## Star Schema