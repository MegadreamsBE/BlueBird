function startclient()
setWaterColor(0,125,255)
setSkyGradient(yellow)
setSkyGradient(0,0,0,0,0,0)
end
addEventHandler( "onClientResourceStart", getResourceRootElement(getThisResource()), startclient )