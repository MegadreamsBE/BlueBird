kecske = createMarker(615.05859375, -4471.5810546875, 44.768772125244, "corona", 3.5, 255, 0, 0, 255)

function teleport(player)
if getElementType(player)=="player" then
local vehicle=getPedOccupiedVehicle(player)
if source == kecske then
setElementPosition(vehicle, 690.60504150391, -4610.919921875, 53.209167480469)
setVehicleFrozen(vehicle, true)
setTimer(setVehicleFrozen, 1000, 1, vehicle, false)
end
end
end
addEventHandler("onClientMarkerHit", getRootElement(), teleport) 