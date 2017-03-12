outputChatBox ( "Luis The Boss" )

function txdClient ()
tekstura = engineLoadTXD("vgncarshade1.txd") 
engineImportTXD(tekstura, 3458 )
end
addEventHandler( "onClientResourceStart", resourceRoot, txdClient )

function txdClient ()
tekstura = engineLoadTXD("vgehshade.txd") 
engineImportTXD(tekstura, 8838 )
end
addEventHandler( "onClientResourceStart", resourceRoot, txdClient )

txd = engineLoadTXD ( "gta_tree_palm.txd" )
engineImportTXD ( txd, 622 )
dff = engineLoadDFF ( "veg_palm03.dff", 622 )
engineReplaceModel ( dff, 622 )

function ClientStarted ()
setWaterColor( 0 , 229 , 238 ) -- RGB colors
end 


addEventHandler( "onClientResourceStart", getResourceRootElement(getThisResource()), ClientStarted )