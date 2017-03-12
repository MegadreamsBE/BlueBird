Me = getLocalPlayer()
Root = getRootElement()
local screenWidth, screenHeight = guiGetScreenSize() -- Get the screen resolution

function Main () 
Multiplier = 2.2
used = 0
gravityjump2 = createMarker(3950.7575683594, -315, 160.57484436035, "corona", 3, 0, 0, 0, 0)
gravityjump3 = createMarker(3985.9707031251, -315, 160.57484436035, "corona", 3, 0, 0, 0, 0)


addEventHandler ( "onClientMarkerHit", getRootElement(), MainFunction )
end


addEventHandler( "onClientResourceStart", getResourceRootElement(getThisResource()), Main )


function MainFunction ( hitPlayer, matchingDimension )
vehicle = getPedOccupiedVehicle ( hitPlayer )
if hitPlayer ~= Me then return end
	if source == gravityjump2 then
			setElementVelocity(vehicle, 0.8, 2.0, 1.35)
	end
	if source == gravityjump3 then
			setElementVelocity(vehicle, -0.8, 2.0, 1.35)
	end
end

function ClientStarted ()
setWaterColor( 0 , 125 , 255 ) -- RGB colors
setSkyGradient( 83 , 134 , 139 , 93 , 104 , 205 ) -- 1st RGB colors top sky, 2nd RGB colors bottom sky
end 


addEventHandler( "onClientResourceStart", getResourceRootElement(getThisResource()), ClientStarted )

function SpawnJump()
    local veh = getPedOccupiedVehicle(getLocalPlayer())
	local x,y,z = getElementPosition(veh)	
    if z <=46 and used == 0 then
	used = 1
    if x >= 3948.1999511719 and x <= 4018.8000488281 and used == 1 then 
	used = 2
	if y >= -1181.0999755859 and y <= -1100.0999755859 and used == 2 then
	speedx, speedy, speedz = getElementVelocity ( vehicle ) 
	setElementVelocity(veh, -0.05, 1.4, 1.2)
	used = 3
end
end
end
end

addEventHandler("onClientRender",getRootElement(),SpawnJump)



function startMusic()
    setRadioChannel(0)
    song = playSound("song.mp3",true)
	outputChatBox("Toggle the music on/off with 'm'")
end

function makeRadioStayOff()
    setRadioChannel(0)
    cancelEvent()
end

function toggleSong()
    if not songOff then
	    setSoundVolume(song,0)
		songOff = true
		removeEventHandler("onClientPlayerRadioSwitch",getRootElement(),makeRadioStayOff)
	else
	    setSoundVolume(song,1)
		songOff = false
		setRadioChannel(0)
		addEventHandler("onClientPlayerRadioSwitch",getRootElement(),makeRadioStayOff)
	end
end

		setRadioChannel(0)
		song = playSound("files/song.mp3", true)

		bindKey("m", "down",
		function ()
        	setSoundPaused(song, not isSoundPaused(song))
		end
		)

 