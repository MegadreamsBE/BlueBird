setCloudsEnabled ( false )
function palm ()
palmtxd = engineLoadTXD("621.txd")
engineImportTXD(palmtxd, 621 )
palmtxd2 = engineLoadTXD("gta_tree_palm.txd")
engineImportTXD(palmtxd2, 622 )
local palmdff = engineLoadDFF('621.dff', 0) 
engineReplaceModel(palmdff, 621)
local palmdff2 = engineLoadDFF('veg_palm03.dff', 0) 
engineReplaceModel(palmdff2, 622)

end
addEventHandler( "onClientResourceStart", getResourceRootElement(getThisResource()), palm )
