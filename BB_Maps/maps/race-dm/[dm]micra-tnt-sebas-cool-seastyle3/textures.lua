addEventHandler( "onClientResourceStart", resourceRoot, txdClient )

txd = engineLoadTXD ( "gta_tree_palm.txd" )
engineImportTXD ( txd, 622 )
txd = engineLoadTXD ( "gta_tree_palm.txd" )
engineImportTXD ( txd, 621 )
dff = engineLoadDFF ( "veg_palm03.dff", 622 )
engineReplaceModel ( dff, 622 )
dff = engineLoadDFF ( "veg_palm02.dff", 621 )
engineReplaceModel ( dff, 621 )

function ClientStarted ()
end 


addEventHandler( "onClientResourceStart", getResourceRootElement(getThisResource()), ClientStarted )