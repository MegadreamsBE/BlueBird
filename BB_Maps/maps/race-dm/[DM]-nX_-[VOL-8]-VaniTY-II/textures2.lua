addEventHandler( "onClientResourceStart", resourceRoot, txdClient )

txd = engineLoadTXD ( "tree4.txd" )
engineImportTXD ( txd, 733 )

txd = engineLoadTXD ( "tree5.txd" )
engineImportTXD ( txd, 732 )

txd = engineLoadTXD ( "tree6.txd" )
engineImportTXD ( txd, 730 )

dff = engineLoadDFF ( "tree4.dff", 733 )
engineReplaceModel ( dff, 733 )

dff = engineLoadDFF ( "tree5.dff", 732 )
engineReplaceModel ( dff, 732 )

dff = engineLoadDFF ( "tree6.dff", 730 )
engineReplaceModel ( dff, 730 )


engineSetModelLODDistance(733, 2000)
engineSetModelLODDistance(732, 2000)
engineSetModelLODDistance(730, 2000)


function ClientStarted ()
end 


addEventHandler( "onClientResourceStart", getResourceRootElement(getThisResource()), ClientStarted )

