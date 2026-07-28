# Catálogo de Medidas DAX - Global Superstore

## 1. Métricas Principales de Venta (Core Financials)

### Total Ventas

Suma total de los ingresos generados por las transacciones.

```dax

Total Ventas := SUM(Fact_Orders[sales])
Resultado Actual: $12.642.905,00

Total Margen Bruto

Utilidad bruta acumulada considerando únicamente la relación precio/costo base por producto.
Total Margen Bruto := SUM(Fact_Orders[profit])
Resultado Actual: $1.469.034,82

Porcentaje de Margen Bruto (%)

Eficiencia del margen bruto sobre el total de ventas brutas.
% Margen Bruto := DIVIDE([Total Margen Bruto], [Total Ventas], 0)
Resultado Actual: 11,62%

2. Métricas Logísticas y de Eficiencia Operativa

Total Costo de Envío

Costo acumulado asumido o gestionado en concepto de transporte e intermediación logística.
Total Costo Envio := SUM(Fact_Orders[shipping_cost])
Resultado Actual: $1.352.820,69

Porcentaje de Costo de Envío sobre Ventas (%)

Impacto directo del gasto logístico sobre los ingresos totales.
% Costo Envio := DIVIDE([Total Costo Envio], [Total Ventas], 0)
Resultado Actual: 10,70%

Descuento Promedio Aplicado (%)

Porcentaje promedio de rebaja concedido en el catálogo comercial.
Descuento Promedio := AVERAGE(Fact_Orders[discount])
Resultado Actual: 14,29%


3. Métricas de Volumen y Ticket

Total Unidades Vendidas
Total Unidades := SUM(Fact_Orders[quantity])
Resultado Actual: 178.312 unidades

Total de Órdenes Únicas
Total Ordenes := DISTINCTCOUNT(Fact_Orders[order_id])
Resultado Actual: 25.035 órdenes

Ticket Promedio por Órden
Ticket Promedio := DIVIDE([Total Ventas], [Total Ordenes], 0)

Resultado Actual: $505,01
