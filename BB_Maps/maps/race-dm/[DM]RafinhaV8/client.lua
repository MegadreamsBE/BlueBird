function RafinhaClient ()
tekstura = engineLoadTXD("ballypillar01.txd") 
engineImportTXD(tekstura, 3437 )
end
addEventHandler( "onClientResourceStart", resourceRoot, RafinhaClient )

function txdClient ()
tekstura = engineLoadTXD("vgehshade.txd") 
engineImportTXD(tekstura, 8838 )
end
addEventHandler( "onClientResourceStart", resourceRoot, txdClient )

function RafinhaClient ()
tekstura = engineLoadTXD("vgncarshade1.txd") 
engineImportTXD(tekstura, 3458 )
end
addEventHandler( "onClientResourceStart", resourceRoot, RafinhaClient )

outputChatBox("#000000~~>   Black #ffffffand #FFFF00Yellow   <~~",255,255,255,true)

function ClientStarted ()
setWaterColor( 255, 255, 0 ) -- RGB colors
setSkyGradient( 255 , 255 , 0 , 156, 156 , 156) -- 1st RGB colors top sky, 2nd RGB colors bottom sky
end 


addEventHandler( "onClientResourceStart", getResourceRootElement(getThisResource()), ClientStarted )