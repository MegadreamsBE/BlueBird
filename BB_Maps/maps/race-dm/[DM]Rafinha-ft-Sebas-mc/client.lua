Me = getLocalPlayer()
Root = getRootElement()
local screenWidth, screenHeight = guiGetScreenSize() -- Get the screen resolution

function Main () 

Move = createMarker(4660.9794921875, 735.7216796875, 13.498685836792, "ring", 3, 255, 0, 0, 153)
gate1 = createObject(988, 4658.5112304688, 867.72418212891, 8.2736787796021, 0, 0, 0)
gate2 = createObject(988, 4664.6621093750, 867.72418212891, 8.2736787796021, 0, 0, 0)

addEventHandler ( "onClientMarkerHit", getRootElement(), MainFunction )
end

addEventHandler( "onClientResourceStart", getResourceRootElement(getThisResource()), Main )


function MainFunction ( hitPlayer, matchingDimension )
vehicle = getPedOccupiedVehicle ( hitPlayer )
if hitPlayer ~= Me then return end
        if source == Move then
		moveObject(gate1, 9000, 4654.6069335938, 867.72418212891, 8.2736787796021)
		moveObject(gate2, 9000, 4668.61328125, 867.72418212891, 8.2736787796021)
        end

end


function ClientStarted ()
setSkyGradient( 105 , 105 , 105 , 105 , 105 , 105 ) -- 1st RGB colors top sky, 2nd RGB colors bottom sky
end 