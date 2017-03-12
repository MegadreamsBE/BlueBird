gMe = getLocalPlayer()
function marker4()
marker4 = createMarker ( 2811, -4080.1999511719, 523.09997558594, "corona", 10, 0, 0, 255, 0)
end

function MarkerHit4 ( hitPlayer, matchingDimension )
vehicle = getPedOccupiedVehicle ( hitPlayer )
if hitPlayer ~= gMe then return end
if source == marker4 then
setElementVelocity ( vehicle, 0, 0, 0)
end
end

addEventHandler( "onClientResourceStart", getResourceRootElement(getThisResource()), marker4)
addEventHandler ( "onClientMarkerHit", getRootElement(), MarkerHit4 )