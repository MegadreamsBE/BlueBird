local marker = createMarker( 4369.314453125, 7501.837890625, 52.014598846436, "arrow", 4,255, 200, 0, 0 )


function teleport (player)

if source == marker then
    if isPedInVehicle(player) then
        local vehicle=getPedOccupiedVehicle(player)
            setElementPosition (vehicle , 3173.4162597656, 6355.7890625, 44.153099060059 )
            setElementRotation (vehicle , 0, 0, 90 )
            setElementFrozen ( vehicle , true )
            setTimer( setElementFrozen, 1000, 1, vehicle, false )

        end
    
end
end
addEventHandler( "onClientMarkerHit", getRootElement(), teleport )



local marker = createMarker( 5439.3798828125, 7501.837890625, 52.014598846436, "arrow", 4,255, 200, 0, 0 )


function teleport (player)

if source == marker then
    if isPedInVehicle(player) then
        local vehicle=getPedOccupiedVehicle(player)
            setElementPosition (vehicle , 3173.4162597656, 6355.7890625, 44.153099060059 )
            setElementRotation (vehicle , 0, 0, 90 )
            setElementFrozen ( vehicle , true )
            setTimer( setElementFrozen, 1000, 1, vehicle, false )

        end
    
end
end
addEventHandler( "onClientMarkerHit", getRootElement(), teleport )

