addEvent("onMapStarting", true )
addEvent("onClientResourceStart", true )

function waterLevel ()
 setWaterLevel ( 0.001 )

end

addEventHandler ("onMapStarting", getRootElement(), waterLevel )
addEventHandler ("onClientResourceStart", getRootElement(), waterLevel )