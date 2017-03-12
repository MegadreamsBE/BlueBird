outputChatBox ("#ff6464Type: #ffffff[DM]", 27, 89, 224, true)
outputChatBox ("#ff6464Name: #ffffffSea Style III", 27, 89, 224, true)
outputChatBox ("#ff6464Authors: #ffffffMicra & TNT & SebaS & CooL", 27, 89, 224, true)

gMe = getLocalPlayer()
function gravity()
marker1 = createMarker (6230.2861328125, -7092.6694335938, 135.83360290527, "corona", 7, 255, 0, 0, 0)
end

function MarkerHit ( hitPlayer, matchingDimension )
vehicle = getPedOccupiedVehicle ( hitPlayer )
if hitPlayer ~= gMe then return end
if source == marker1 then
setElementVelocity ( vehicle, 0, -1, 1.0)
end
end

addEventHandler( "onClientResourceStart", getResourceRootElement(getThisResource()), gravity )
addEventHandler ( "onClientMarkerHit", getRootElement(), MarkerHit )