function gravity()
marker1 = createMarker (5035, -2418.3000488281, 77.900001525879, "cylinder", 10, 255, 0, 0, 0)
end

function MarkerHit ( hitPlayer, matchingDimension )
vehicle = getPedOccupiedVehicle ( hitPlayer )
if hitPlayer ~= getLocalPlayer() then return end
if source == marker1 then
setElementVelocity ( vehicle, 2, 0, 1.5)
end
end

addEventHandler( "onClientResourceStart", getResourceRootElement(getThisResource()), gravity )
addEventHandler ( "onClientMarkerHit", getRootElement(), MarkerHit )

function ClientStarted ()
setWaterColor( 0, 204, 224, 175 ) -- RGB colors
setSkyGradient( 000 , 000 , 009 , 000 , 000 , 009 ) -- 1st RGB colors top sky, 2nd RGB colors bottom sky
end 


addEventHandler( "onClientResourceStart", getResourceRootElement(getThisResource()), ClientStarted )