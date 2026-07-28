let
    Origen = Data_Cruda,
    #"Consultas combinadas" = Table.NestedJoin(Origen, {"customer_name", "segment"}, Dim_Clientes, {"customer_name", "segment"}, "Dim_Clientes", JoinKind.LeftOuter),
    #"Se expandió Dim_Clientes" = Table.ExpandTableColumn(#"Consultas combinadas", "Dim_Clientes", {"Cliente_SK"}, {"Cliente_SK"}),
    #"Consultas combinadas1" = Table.NestedJoin(#"Se expandió Dim_Clientes", {"product_id", "category", "sub_category", "product_name"}, Dim_Productos, {"product_id", "category", "sub_category", "product_name"}, "Dim_Productos", JoinKind.LeftOuter),
    #"Se expandió Dim_Productos" = Table.ExpandTableColumn(#"Consultas combinadas1", "Dim_Productos", {"Producto_SK"}, {"Producto_SK"}),
    #"Consultas combinadas2" = Table.NestedJoin(#"Se expandió Dim_Productos", {"state", "country", "market", "region"}, Dim_Ubicacion, {"state", "country", "market", "region"}, "Dim_Ubicacion", JoinKind.LeftOuter),
    #"Se expandió Dim_Ubicacion" = Table.ExpandTableColumn(#"Consultas combinadas2", "Dim_Ubicacion", {"Ubicacion_SK"}, {"Ubicacion_SK"}),
    #"Columnas quitadas" = Table.RemoveColumns(#"Se expandió Dim_Ubicacion",{"customer_name", "segment", "state", "country", "market", "region", "product_id", "category", "sub_category", "product_name"})
in
    #"Columnas quitadas"
    