Global Superstore: End-to-End Analytics & Financial Diagnosis🚨
Resumen Ejecutivo y Diagnóstico FinancieroGlobal Superstore es un gigante multinacional del retail y e-commerce que procesó 51.290 transacciones (25.035 órdenes únicas) entre 2011 y 2014 en más de 140 países.En apariencia, la compañía goza de una salud comercial impecable, registrando una facturación bruta acumulada de $12,64M USD (top-line). Sin embargo, la auditoría analítica revela una crisis de rentabilidad estructural severa:[ Facturación Bruta ]  --->  $12.642.905,00 USD  (100.00%)
[ Utilidad Bruta ]     --->   $1.469.034,82 USD  ( 11.62%)  <-- ¡MARGEN EN ZONA DE RIESGO!
[ Gastos Operativos ]  --->  ~ $710.000,00 USD  (  5.62%)  (Nómina, almacenamiento, impuestos)
========================================================================================

[ Utilidad Neta Real ] --->  ~ $759.034,82 USD  ( ~6.00%)  <-- ¡AL BORDE DE LA QUIEBRA!
El Espejismo de la Facturación: Mantener un 11,62% de Margen Bruto en retail global (donde el estándar saludable oscila entre 25% y 35%) sitúa a la empresa en una posición críticamente frágil. Margen Neto Estimado (~6%): Al deducir los costos fijos operativos (OPEX) —tales como nómina, servicios públicos (agua, luz), almacenamiento, licencias de software e impuestos—, la rentabilidad final cae a niveles de supervivencia. Cualquier fluctuación de mercado coloca a la empresa al borde del punto de quiebre (break-even) o la bancarrota.

El Rescate Financiero: Mediante un modelo paramétrico de simulación What-If en DAX, se diseñó una política de control comercial que logra rescatar $1.032.502,98 USD en utilidad bruta, incrementando el beneficio bruto un +70,28% y elevando el margen bruto al 19,79%.

🎯 Definición del Problema e Hipótesis Fugas Críticas de Capital Descuentos Desmedidos e Incondicionales: La fuerza comercial otorga un descuento promedio del 14,29%, registrando transacciones con rebajas agresivas del 50% al 80% destinadas a cerrar volumen sin considerar la rentabilidad unitaria.

Absorción Ineficiente de Costos Logísticos: La empresa gastó $1,35M USD en fletes (10,70% de las ventas totales). Esta absorción logística devora directamente el 92,15% de la utilidad bruta global ($1,47M USD), provocado por no cobrar gastos de envío escalonados en productos pesados y voluminosos.

Hipótesis Inicial de Negocio"La baja rentabilidad de Global Superstore no responde a un déficit de demanda ni a precios de lista inviables, sino a una política comercial permisiva que subvenciona envíos pesados y concede promociones por encima del punto de quiebre operativo (20%). Limitar el descuento máximo al 20% mediante gobernanza en el ERP recuperará más de $1,00M USD en margen sin destruir volumen comercial.

📊 Objetivos del Proyecto Objetivo General: Diseñar e implementar una solución analítica integral end-to-end en Power BI / Excel Power Pivot que diagnostique las causas raíz de la erosión de margen y proporcione un modelo de simulación interactivo (What-If) para la toma de decisiones directivas.

Objetivos Específicos:Identificar subcategorías de productos y regiones geográficas que actúen como sumideros de capital. Determinar el punto de inflexión (break-even) donde el porcentaje de descuento convierte en deficitaria una orden. Construir un modelo relacional en estrella (Star Schema) con claves subrogadas para garantizar la máxima velocidad de procesamiento en el motor VertiPaq. Cuantificar el capital recuperable mediante lógica avanzada en DAX bajo escenarios de control comercial

🏗️ Arquitectura de Datos y Metodología TécnicaPlaintextGLOBAL-SUPERSTORE-END-TO-END-ANALYTICS/

├── data/
│   ├── processed/                      # Datasets estructurados
│   └── raw/                            # Dataset original de Kaggle (51.290 filas)
├── docs/
│   ├── data_dictionary.md              # Diccionario de datos y cardinalidades
│   └── dax_measures_catalog.md         # Catálogo completo de medidas DAX
├── models/
│   ├── Global_Superstore_Dashboard.pbix# Tablero interactivo en Power BI
│   └── Global_Superstore_ETL_Model.xlsx# Modelo relacional en Excel Power Pivot
├── reports/
│   └── assets/
│       ├── dashboard_diagnostico_ejecutivo.png
│       ├── dashboard_plan_accion_whatif.png
│       ├── etl_power_query_flow.png
│       ├── modelling_dax_data_post_etl.jpeg
│       ├── star_schema_diagram.png
│       └── Reporte de Diagnóstico Financiero.docx
└── src/
    └── power_query_m/                  # Scripts de extracción en Lenguaje M
        ├── Dim_Clientes.m
        ├── Dim_Productos.m
        ├── Dim_Ubicacion.m
        └── Fact_Orders.m

1. Pipeline de ETL (Power Query / Lenguaje M)Sanitización: Estandarización de tipos de datos, limpieza de caracteres especiales en campos geográficos y normalización de fechas [order_date, ship_date].
Claves Subrogadas Numéricas (Surrogate Keys): Para evitar relaciones pesadas basadas en texto, se generaron claves enteras de tipo INT64
Cliente_SK: Identificador numérico único de cliente.
Producto_SK: Identificador numérico único de producto.
Ubicacion_SK: Hash/Índice entero derivado de la combinación País + Estado + Ciudad.
 2.Modelado Dimensional (Star Schema)El modelo relacional fue diseñado siguiendo las mejores prácticas de Kimbal con relaciones 1 a Muchos (1:N) unidireccionales[cite: 9]:Plaintext       ┌──────────────────┐               ┌──────────────────┐
       │   Dim_Clientes   │               │  Dim_Productos   │
       │  (795 registros) │               │(10.768 registros)│
       └────────┬─────────┘               └────────┬─────────┘
                │ (1)                              │ (1)
                │                                  │
                │              ┌───┐               │
                └─────────────►│ N │◄──────────────┘
                               │   │
                               │ F │
                               │ a │
                               │ c │
                               │ t │
                               │_ │
                               │ O │
                               │ r │
                               │ d │
                               │ e │
                               │ r │
                               │ s │
                               │   │
                               │(51.290)
                               └───┘
                                 ▲
                                 │ (N)
                                 │
                                 │ (1)
                       ┌─────────┴────────┐
                       │  Dim_Ubicacion   │
                       │ (1.126 registros)│
                       └──────────────────┘
🔍 Hallazgos Principales por Pilares de Análisis

 Pilar Producto: Destrucción de Valor en Subcategorías Motores de Rentabilidad: Subcategorías como Copiers (Copiadoras) ($258,57K USD en margen) y Phones (Teléfonos) ($216,72K USD en margen) sostienen la operación global con márgenes superiores al 12% El Foco de Pérdida: Tables (Mesas) facturó $757,03K USD, pero destruyó capital con una pérdida neta de -$64,08K USD.Causa Raíz: La subcategoría Mesas acumuló $79,86K USD en fletes absorvidos por la empresa, superando la totalidad del margen bruto generado. Subcategoría Ventas Totales (USD) Margen Bruto Real (USD)% Margen Bruto Estado Operativo Copiers $1.509.436,00 $258.567,0017 13%🟢 Alta RentabilidadPhones $1.706.824,00 $216.717,0012 70%🟢 Sostenible Chairs $1.501.682,00 $141.973,009 45%🟡 Margen Ajustado Bookcases $1.466.572,00$161.924,0011 04%🟡 Margen Ajustado Tables $757.030,00-$64.083 -8,46%🔴 Destrucción de Capital. Pilar Geografía: Eficiencia y Fugas Regionales LATAM: Presenta un impacto erosivo alto por descuentos incondicionales aplicados en casi el 20% del volumen comercial. EMEA: Registra fugas promocionales severas; en periodos clave perdió hasta una cuarta parte de su rentabilidad potencial. Canadá: Constituye el modelo ideal de gestión, registrando $0,00 USD en pérdidas por descuento, demostrando alta disciplina en precios de lista .🚀 La Solución "What-If" y Cuantificación del Rescate Mediante parámetros dinámicos y medidas de simulación en DAX, se evaluó el impacto de implementar un tope de descuento del 20% máximo. :$$Precio\_Lista = \frac{Sales}{1 - Discount}$$$$Sales\_Simulada = \begin{cases} Sales & \text{si } Discount \le 0.20 \\ Precio\_Lista \times (1 - 0.20) & \text{si } Discount > 0.20 \end{cases}$$Impacto Directo de la SimulaciónMétrica Financiera Escenario Actual (Sin Control) Escenario Simulado (Tope 20%)Impacto / Rescate NetUtilidad Bruta Total $1.469.034,82 USD$2.501.537,80 USD +$1.032.502,98 USD % Margen Bruto 11,62% 19,79% +8,17% p.p. Crecimiento de Utilidad Base +70,28% Incremento Directo. Rentabilidad en Tables -$64.083,00 USD Positiva (> $0,00 USD)Recuperación Total Nota Metodológica: El cálculo paramétrico asume una demanda inelástica ($Elasticidad = 0$) como escenario de control base. Se recomienda ejecutar pruebas A/B en el CRM para validar la elasticidad real de la demanda antes del despliegue global.
🗺️ Roadmap de Ejecución y Recomendaciones Plan de Acción Estratégico Horizonte Objetivo Operativo Acción Clave KPI de Control Corto Plazo (0–30 días) Gobernanza de Precios Bloquear en ERP/CRM descuentos superiores al 20% sin aprobación directiva.Cap de Descuento $\le 20\%$
Mediano Plazo (1–3 meses) Saneamiento de Portafolio Rediseñar precios de lista o descontinuar ítems en pérdidas crónicas (Tables).
Margen Bruto Mesas $> 0\%$
Largo Plazo (3–6 meses) Optimización Logística Trasladar fletes pesados al cliente final y renegociar tarifas con transportistas
Costo Envío / Ventas $< 8\%$[cite: 9]

👤 Autor Zadquiel E. Nieves – Estudiante de la Escuela de Estadística y Ciencias Actuariales (EECA) - Universidad Central de Venezuela [UCV].
GitHub: @Zadquiel-niev.
Repositorio del Proyecto: Global-Superstore-end-to-end-Analytics.
