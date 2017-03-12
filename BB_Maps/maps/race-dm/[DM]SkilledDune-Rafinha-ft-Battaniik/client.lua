function txdClient ()
tekstura = engineLoadTXD("cs_ebridge.txd") 
engineImportTXD(tekstura, 18450 )
end
addEventHandler( "onClientResourceStart", resourceRoot, txdClient )

gMe = getLocalPlayer()
function marker1()
marker1 = createMarker ( 3822.9807128906, -211.72375488281, 1.0564565658569, "corona", 3, 0, 0, 255, 0)
end

function MarkerHit1 ( hitPlayer, matchingDimension )
vehicle = getPedOccupiedVehicle ( hitPlayer )
if hitPlayer ~= gMe then return end
if source == marker1 then
setElementVelocity ( vehicle, 0, 0.5, 1)
end
end

addEventHandler( "onClientResourceStart", getResourceRootElement(getThisResource()), marker1)
addEventHandler ( "onClientMarkerHit", getRootElement(), MarkerHit1 )