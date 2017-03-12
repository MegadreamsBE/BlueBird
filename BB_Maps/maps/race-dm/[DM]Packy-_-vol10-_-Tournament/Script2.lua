gMe = getLocalPlayer()
function marker2()
marker2 = createMarker ( 2899.8999023438, -3357.3999023438, 1375.5, "corona", 10, 255, 255, 255, 0)
end

function MarkerHit2 ( hitPlayer, matchingDimension )
vehicle = getPedOccupiedVehicle ( hitPlayer )
if hitPlayer ~= gMe then return end
if source == marker2 then
setElementVelocity ( vehicle, 0, 0, 0)
end
end

addEventHandler( "onClientResourceStart", getResourceRootElement(getThisResource()), marker2)
addEventHandler ( "onClientMarkerHit", getRootElement(), MarkerHit2 )