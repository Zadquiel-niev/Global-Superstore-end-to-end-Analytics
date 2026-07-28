let
    Origen = Csv.Document(File.Contents("C:\Users\EQUIPO\Documents\GitHub\Global-Superstore-end-to-end-Analytics\data\raw\SuperStoreOrders.csv"),[Delimiter=",", Columns=21, Encoding=65001, QuoteStyle=QuoteStyle.None]),
    #"Encabezados promovidos" = Table.PromoteHeaders(Origen, [PromoteAllScalars=true]),
    #"Tipo cambiado" = Table.TransformColumnTypes(#"Encabezados promovidos",{{"order_id", type text}, {"order_date", type date}, {"ship_date", type date}, {"ship_mode", type text}, {"customer_name", type text}, {"segment", type text}, {"state", type text}, {"country", type text}, {"market", type text}, {"region", type text}, {"product_id", type text}, {"category", type text}, {"sub_category", type text}, {"product_name", type text}, {"sales", Int64.Type}, {"quantity", Int64.Type}, {"discount", type number}, {"profit", type number}, {"shipping_cost", type number}, {"order_priority", type text}, {"year", Int64.Type}}),
    #"Columnas de texto recortadas" = Table.TransformColumns(#"Tipo cambiado",{{"ship_mode", Text.Trim, type text}, {"customer_name", Text.Trim, type text}, {"segment", Text.Trim, type text}, {"state", Text.Trim, type text}, {"country", Text.Trim, type text}, {"market", Text.Trim, type text}, {"region", Text.Trim, type text}, {"category", Text.Trim, type text}, {"sub_category", Text.Trim, type text}, {"product_name", Text.Trim, type text}, {"order_priority", Text.Trim, type text}}),
    #"Columnas de texto limpiadas" = Table.TransformColumns(#"Columnas de texto recortadas",{{"ship_mode", Text.Clean, type text}, {"customer_name", Text.Clean, type text}, {"segment", Text.Clean, type text}, {"state", Text.Clean, type text}, {"country", Text.Clean, type text}, {"market", Text.Clean, type text}, {"region", Text.Clean, type text}, {"category", Text.Clean, type text}, {"sub_category", Text.Clean, type text}, {"product_name", Text.Clean, type text}, {"order_priority", Text.Clean, type text}}),
    #"Otras columnas quitadas" = Table.SelectColumns(#"Columnas de texto limpiadas",{"state", "country", "market", "region"}),
    #"Duplicados quitados" = Table.Distinct(#"Otras columnas quitadas"),
    #"Índice agregado" = Table.AddIndexColumn(#"Duplicados quitados", "Índice", 1, 1, Int64.Type),
    #"Columnas con nombre cambiado" = Table.RenameColumns(#"Índice agregado",{{"Índice", "Ubicacion_SK"}}),
    #"Columnas reordenadas" = Table.ReorderColumns(#"Columnas con nombre cambiado",{"Ubicacion_SK", "state", "country", "market", "region"})
in
    #"Columnas reordenadas"
    