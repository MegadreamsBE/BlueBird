addEventHandler( "onClientResourceStart", resourceRoot, txdClient )

txd = engineLoadTXD ( "tree1.txd" )
engineImportTXD ( txd, 623 )
txd = engineLoadTXD ( "tree3.txd" )
engineImportTXD ( txd, 622 )
txd = engineLoadTXD ( "tree2.txd" )
engineImportTXD ( txd, 621 )
dff = engineLoadDFF ( "tree3.dff", 622 )
engineReplaceModel ( dff, 622 )
dff = engineLoadDFF ( "tree2.dff", 621 )
engineReplaceModel ( dff, 621 )
dff = engineLoadDFF ( "tree1.dff", 623 )
engineReplaceModel ( dff, 623 )

function ClientStarted ()
end 


addEventHandler( "onClientResourceStart", getResourceRootElement(getThisResource()), ClientStarted )