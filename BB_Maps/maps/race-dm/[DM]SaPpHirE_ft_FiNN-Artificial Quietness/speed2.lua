addEventHandler( "onClientResourceStart", getResourceRootElement(getThisResource()), startClient )
marker = createMarker ( 3834.275, -2573.202,0, 87.59999, "corona", 0, 0, 0, 0, 0 )
     
    function onMarkerHit ( thePlayer, matchingDimension )
            setElementVelocity ( getPedOccupiedVehicle(thePlayer), 0, 1.5,1  )
    end
addEventHandler ( "onClientMarkerHit",marker, onMarkerHit )