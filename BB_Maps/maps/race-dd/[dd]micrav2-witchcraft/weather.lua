setSkyGradient( 0, 0, 128, 0, 0, 0 )
setWaterColor( 0, 0, 128 )

function ClientStarted ()
billboard = engineLoadTXD("vgsn_billboard.txd")
engineImportTXD(billboard, 7301 )
end
addEventHandler( "onClientResourceStart", getResourceRootElement(getThisResource()), ClientStarted )