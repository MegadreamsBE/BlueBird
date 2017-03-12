function palm ()
palmtxd = engineLoadTXD("gta_tree_palm2.txd")
engineImportTXD(palmtxd, 621 )
palmdff = engineLoadDFF('veg_palm02.dff', 0) 
engineReplaceModel(palmdff, 621)  
end
addEventHandler( "onClientResourceStart", getResourceRootElement(getThisResource()), palm )