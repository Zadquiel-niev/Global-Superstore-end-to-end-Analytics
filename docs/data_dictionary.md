# Diccionario de Datos: Global Superstore Analytics

Este documento detalla la estructura del modelo dimensional en estrella (*Star Schema*) implementado en el proyecto. Especifica tipos de datos, cardinalidades, claves primarias, claves foráneas y la descripción técnica de cada atributo.

---

## Resumen del Modelo Dimensional

| Tabla | Tipo de Tabla | Cantidad de Filas | Clave Primaria / FK | Descripción |
| :--- | :--- | :--- | :--- | :--- |
| **`Fact_Orders`** | Tabla de Hechos | 51.290 | `order_id` / SKs | Contiene las métricas cuantitativas y transaccionales del negocio. |
| **`Dim_Clientes`** | Dimensión | 795 | `Cliente_SK` (PK) | Atributos e identificación de los clientes. |
| **`Dim_Productos`** | Dimensión | 10.768 | `Producto_SK` (PK) | Catálogo de productos, categorías y subcategorías. |
| **`Dim_Ubicacion`** | Dimensión | 1.126 | `Ubicacion_SK` (PK) | Jerarquía geográfica de mercados, regiones, países y ciudades. |
| **`Data_Cruda`** | Origen (Staging) | 51.290 | N/A | Dataset sin estructurar extraído de la fuente original. |

---

## Detalles de Tablas y Atributos

### 1. Fact_Orders (Tabla de Hechos)

Consolida las transacciones operativas. Se conecta con las dimensiones mediante claves subrogadas de tipo entero (`INT64`).

| Campo | Tipo de Dato | Tipo de Clave | Descripción |
| :--- | :--- | :--- | :--- |
| `order_id` | Texto / String | Business Key | Código identificador de la orden de compra. |
| `order_date` | Fecha / Date | Atributo | Fecha en la que el cliente realizó el pedido. |
| `ship_date` | Fecha / Date | Atributo | Fecha en la que la orden fue despachada. |
| `ship_mode` | Texto / String | Atributo | Método de envío (`Standard Class`, `Second Class`, `First Class`, `Same Day`). |
| `sales` | Decimal / Currency | Métrica | Monto bruto facturado en la transacción ($ USD). |
| `quantity` | Entero / Int64 | Métrica | Unidades vendidas en la línea de detalle. |
| `discount` | Decimal / Percentage | Métrica | Porcentaje de descuento aplicado a la línea (0.00 a 0.80). |
| `profit` | Decimal / Currency | Métrica | Utilidad o margen bruto generado por la transacción ($ USD). |
| `shipping_cost` | Decimal / Currency | Métrica | Costo logístico de transporte y flete ($ USD). |
| `order_priority` | Texto / String | Atributo | Prioridad de despacho (`Critical`, `High`, `Medium`, `Low`). |
| `year` | Entero / Int64 | Atributo | Año numérico extraído de `order_date` (2011–2014). |
| `Cliente_SK` | Entero / Int64 | Foreign Key (FK) | Vincula con `Dim_Clientes[Cliente_SK]`. |
| `Producto_SK` | Entero / Int64 | Foreign Key (FK) | Vincula con `Dim_Productos[Producto_SK]`. |
| `Ubicacion_SK` | Entero / Int64 | Foreign Key (FK) | Vincula con `Dim_Ubicacion[Ubicacion_SK]`. |

---

### 2. Dim_Clientes (Dimensión)

Almacena la información de los compradores y su segmentación.

| Campo | Tipo de Dato | Tipo de Clave | Descripción |
| :--- | :--- | :--- | :--- |
| `Cliente_SK` | Entero / Int64 | Primary Key (PK) | Clave subrogada única generada durante el proceso ETL. |
| `customer_name` | Texto / String | Atributo | Nombre completo del cliente. |
| `segment` | Texto / String | Atributo | Segmento de cliente (`Consumer`, `Corporate`, `Home Office`). |

---

### 3. Dim_Productos (Dimensión)

Jerarquía comercial y detalle de los productos ofertados.

| Campo | Tipo de Dato | Tipo de Clave | Descripción |
| :--- | :--- | :--- | :--- |
| `Producto_SK` | Entero / Int64 | Primary Key (PK) | Clave subrogada única generada durante el proceso ETL. |
| `product_id` | Texto / String | Business Key | Código natural de identificación del producto. |
| `category` | Texto / String | Atributo | Categoría principal (`Furniture`, `Office Supplies`, `Technology`). |
| `sub_category` | Texto / String | Atributo | Subcategoría de producto (`Phones`, `Copiers`, `Chairs`, `Tables`, etc.). |
| `product_name` | Texto / String | Atributo | Nombre descriptivo del producto. |

---

### 4. Dim_Ubicacion (Dimensión)

Estructura geográfica para el análisis territorial y de fletes logísticos.

| Campo | Tipo de Dato | Tipo de Clave | Descripción |
| :--- | :--- | :--- | :--- |
| `Ubicacion_SK` | Entero / Int64 | Primary Key (PK) | Clave subrogada única generada a partir de la combinación de `country + state + city`. |
| `state` | Texto / String | Atributo | Estado, provincia o entidad federal. |
| `country` | Texto / String | Atributo | País de destino. |
| `market` | Texto / String | Atributo | Mercado regional global (`APAC`, `EU`, `LATAM`, `US`, `EMEA`, `Africa`, `Canada`). |
| `region` | Texto / String | Atributo | Región comercial interna (`Central`, `South`, `North`, `Oceania`, `West`, `East`, etc.). |
