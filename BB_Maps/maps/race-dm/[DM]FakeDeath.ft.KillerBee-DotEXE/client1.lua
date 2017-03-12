txd = engineLoadTXD ( "gta_tree_palm.txd" )
engineImportTXD ( txd, 622 )
dff = engineLoadDFF ( "veg_palm03.dff", 622 )
engineReplaceModel ( dff, 622 )