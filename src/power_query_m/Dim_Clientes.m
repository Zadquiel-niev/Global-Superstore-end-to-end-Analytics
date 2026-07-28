let
    Origen = Data_Cruda,
    #"Otras columnas quitadas" = Table.SelectColumns(Origen,{"customer_name", "segment"}),
    #"Duplicados quitados" = Table.Distinct(#"Otras columnas quitadas"),
    #"Índice agregado" = Table.AddIndexColumn(#"Duplicados quitados", "Índice", 1, 1, Int64.Type),
    #"Columnas con nombre cambiado" = Table.RenameColumns(#"Índice agregado",{{"Índice", "Cliente_SK"}}),
    #"Columnas reordenadas" = Table.ReorderColumns(#"Columnas con nombre cambiado",{"Cliente_SK", "customer_name", "segment"})
in
    #"Columnas reordenadas"