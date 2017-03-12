gMe = getLocalPlayer()

function gravity()
marker1 = createMarker ( 6470.7001953125, -1683.9000244141, 102.30000305176,"corona", 6, 155, 0, 0, 0 )
end

function MarkerHit ( hitPlayer, matchingDimension )
vehicle = getPedOccupiedVehicle ( hitPlayer )
if hitPlayer ~= gMe then return end
if source == marker1 then
setElementVelocity ( vehicle, -1, 0 , 1.2) 
end
end

addEventHandler( "onClientResourceStart", getResourceRootElement(getThisResource()), gravity )
addEventHandler ( "onClientMarkerHit", getRootElement(), MarkerHit )