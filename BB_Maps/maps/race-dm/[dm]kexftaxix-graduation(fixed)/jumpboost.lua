dicsak = getLocalPlayer()

function markers ()
boost1 = createMarker(135.37770080566, -6707.109375, 7.3896656036377,"corona", 5, 160,148,93,255)
end


function ClientMarkerHit  ( hitPlayer, matchingDimension )
	if hitPlayer ~= dicsak then return end
	   voertuig = getPedOccupiedVehicle(hitPlayer)
       if source == boost1 then
          setElementVelocity ( voertuig, 0, 1, 2)
       end
end


--addEventHandler( "onClientResourceStart", getResourceRootElement(getThisResource()), ClientStarted )

addEventHandler ( "onClientMarkerHit", getRootElement(), ClientMarkerHit )
addEventHandler ( "onClientResourceStart", getResourceRootElement(getThisResource()), markers	)
