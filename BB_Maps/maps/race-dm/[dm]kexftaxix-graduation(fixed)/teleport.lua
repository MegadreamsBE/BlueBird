jozsi = createMarker(827.6357421875, -4485.5947265625, 46.685077667236, "corona", 3.5, 255, 0, 0, 255)
bela = createMarker(-1514.599609375, -4915.7001953125, 3.5999999046326, "corona", 3.5, 255, 0, 0, 255)
bela2 = createMarker(293, -4802, 3.5999999046326, "corona", 3.5, 255, 0, 0, 255)

function teleport(player)
if getElementType(player)=="player" then
local vehicle=getPedOccupiedVehicle(player)
if source == jozsi then
x, y, z = getElementRotation ( vehicle ) 
setElementPosition(vehicle, 690.60504150391, -4610.919921875, 53.209167480469)
setVehicleRotation ( vehicle, 0, 0, z )
setVehicleFrozen(vehicle, true)
setTimer(setVehicleFrozen, 1000, 1, vehicle, false)
end
if source == bela then
setElementPosition(vehicle, -1792.5, -5729.2001953125, 7.5999999046326)
setVehicleRotation(vehicle,0,0,135)
setVehicleFrozen(vehicle, true)
setTimer(setVehicleFrozen, 1000, 1, vehicle, false)
end
if source == bela2 then
setElementPosition(vehicle, -1792.5, -5729.2001953125, 7.5999999046326)
setVehicleRotation(vehicle,0,0,135)
setVehicleFrozen(vehicle, true)
setTimer(setVehicleFrozen, 1000, 1, vehicle, false)
end
end
end
addEventHandler("onClientMarkerHit", getRootElement(), teleport) 