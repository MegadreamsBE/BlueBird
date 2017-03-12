function ClientStarted ()
billboard = engineLoadTXD("vgsehseing1.txd")
engineImportTXD(billboard, 8558 )

billboard = engineLoadTXD("vgehshade.txd")
engineImportTXD(billboard, 3458 )

engineSetModelLODDistance(6994,170)
end
addEventHandler( "onClientResourceStart", getResourceRootElement(getThisResource()), ClientStarted )