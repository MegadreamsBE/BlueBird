setCloudsEnabled ( false )
function ClientStarted ()
	txd = engineLoadTXD ( "gta_tree_palm.txd" )
	engineImportTXD ( txd, 622 )
	dff = engineLoadDFF ( "veg_palm03.dff", 622 )
	engineReplaceModel ( dff, 622 )
end 


addEventHandler( "onClientResourceStart", getResourceRootElement(getThisResource()), ClientStarted )


function palm ()
palmtxd = engineLoadTXD("gta_tree_palm2.txd")
engineImportTXD(palmtxd, 621 )
palmdff = engineLoadDFF('veg_palm02.dff', 0) 
engineReplaceModel(palmdff, 621)  
end
addEventHandler( "onClientResourceStart", getResourceRootElement(getThisResource()), palm )