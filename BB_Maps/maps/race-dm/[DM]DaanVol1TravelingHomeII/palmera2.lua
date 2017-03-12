addEventHandler( "onClientResourceStart", resourceRoot, txdClient )

txd = engineLoadTXD ( "gta_tree_palm.txd" )
engineImportTXD ( txd, 621 )
dff = engineLoadDFF ( "veg_palm02.dff", 621 )
engineReplaceModel ( dff, 621 )

function ClientStarted ()
end 


addEventHandler( "onClientResourceStart", getResourceRootElement(getThisResource()), ClientStarted )