gMe=getLocalPlayer()
blah = createMarker(5363.2001953125, -1532.828125, 14.35000038147, "corona",  15, 0, 0, 0, 255)
 
function teleport(player)
    if isPedInVehicle(player) then
        local vehicle=getPedOccupiedVehicle(player) 
        if source==blah then
setElementFrozen(vehicle,true)
            setElementPosition(vehicle, 4319.0732421875, -51.2802734375, 38.550098419189)
 setTimer(setElementFrozen,1000,1,vehicle,false)
   setElementRotation(vehicle,0,0,180)
        end
    end
end
addEventHandler("onClientMarkerHit", getRootElement(), teleport)