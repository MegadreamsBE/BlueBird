Me = getLocalPlayer()
Root = getRootElement()
local screenWidth, screenHeight = guiGetScreenSize() -- Get the screen resolution

function Main () 
bumper1 = createMarker(4059.2751464844,-2627.1892089844,8.0232172012329, "arrow", 10, 0, 0, 0, 0)
bumper2 = createMarker(6106.748046875,-3444.1865234375,177.95942687988, "arrow", 0, 0, 0, 0, 0)
addEventHandler ( "onClientMarkerHit", getRootElement(), MainFunction )
end

addEventHandler( "onClientResourceStart", getResourceRootElement(getThisResource()), Main )


function MainFunction ( hitPlayer, matchingDimension )
vehicle = getPedOccupiedVehicle ( hitPlayer )
if hitPlayer ~= Me then return end
	if source == bumper1 then
		setElementVelocity(vehicle,2,0,2)
	end
	if source == bumper2 then
		setElementVelocity(vehicle,1, -2, 1)
	end

end