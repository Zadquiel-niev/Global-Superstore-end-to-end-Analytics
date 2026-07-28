let
    Origen = Data_Cruda,
    #"Otras columnas quitadas" = Table.SelectColumns(Origen,{"category", "sub_category", "product_name", "product_id"}),
    #"Duplicados quitados" = Table.Distinct(#"Otras columnas quitadas"),
    #"Columnas reordenadas" = Table.ReorderColumns(#"Duplicados quitados",{"product_id", "category", "sub_category", "product_name"}),
    #"Índice agregado" = Table.AddIndexColumn(#"Columnas reordenadas", "Índice", 1, 1, Int64.Type),
    #"Columnas con nombre cambiado" = Table.RenameColumns(#"Índice agregado",{{"Índice", "Producto_SK"}}),
    #"Columnas reordenadas1" = Table.ReorderColumns(#"Columnas con nombre cambiado",{"Producto_SK", "product_id", "category", "sub_category", "product_name"})
in
    #"Columnas reordenadas1"
    