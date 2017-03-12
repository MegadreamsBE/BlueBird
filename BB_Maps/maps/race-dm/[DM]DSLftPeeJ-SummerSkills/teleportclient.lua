teleport = createMarker(3240.05859375, -2085.65820312, 12.081700325012, "corona", 4, 0, 255, 255, 0)

function Ninjastele(player)
  if getElementType(player)=="player" then
     local vehicle = getPedOccupiedVehicle(player)
      if source == teleport then
           setElementPosition(vehicle, 2264.021484375, -5022.5854492188,  998.03167724609)
            setVehicleFrozen(vehicle, true)
          setTimer(setVehicleFrozen, 100, 1, vehicle, false)
           setElementRotation(vehicle,0, 0, 0)
        end
    end
end
addEventHandler("onClientMarkerHit", resourceRoot, Ninjastele)