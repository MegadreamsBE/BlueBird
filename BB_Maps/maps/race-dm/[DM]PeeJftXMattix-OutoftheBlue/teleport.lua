marker = createMarker(-197.6337890625, -8049.0029296875, 46.80309677124, "corona", 15, 255, 0, 0, 255)

function teleport(player)
	if getElementType(player)=="player" then
		local vehicle=getPedOccupiedVehicle(player)
		if source == marker then
                                                 
		                setElementPosition(vehicle, 907.91015625, -2589.1767578125, 51.906692504883)
							setVehicleRotation ( vehicle, 270, 0, 180 )
					setVehicleFrozen(vehicle, true)
			setTimer(setVehicleFrozen, 100, 1, vehicle, false)
		end
	end
end
addEventHandler("onClientMarkerHit", getRootElement(), teleport)