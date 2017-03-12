Me = getLocalPlayer()
Root = getRootElement()
local screenWidth, screenHeight = guiGetScreenSize() -- Get the screen resolution

function Main () 
used = 0
gravityjump2 = createMarker(1620.0999755859, -3615.6999511719, 48, "corona", 3, 0, 0, 0, 0)
gravityjump3 = createMarker(1621.5, -3959.3999023438, 60.200000762939, "corona", 3, 0, 0, 0, 0)


addEventHandler ( "onClientMarkerHit", getRootElement(), MainFunction )
end


addEventHandler( "onClientResourceStart", getResourceRootElement(getThisResource()), Main )


function MainFunction ( hitPlayer, matchingDimension )
vehicle = getPedOccupiedVehicle ( hitPlayer )
if hitPlayer ~= Me then return end
	if source == gravityjump2 then
			setElementVelocity(vehicle, 0, -1.2, 1.5)
	end
	if source == gravityjump3 then
			setElementVelocity(vehicle, 0, 2.4, 1.55)
	end
end



addEventHandler( "onClientResourceStart", getResourceRootElement(getThisResource()), ClientStarted )

function SpawnJump()
    local veh = getPedOccupiedVehicle(getLocalPlayer())
	local x,y,z = getElementPosition(veh)	
		if y >= -930.70001220703 and used == 0 then
				speedx, speedy, speedz = getElementVelocity ( vehicle ) 
				speedcnx = (speedx)
				speedcny = (speedy)
				speedcnz = (speedz)
				setElementVelocity ( vehicle, speedcnx, speedcny,-0.3 )
				used = 1
	else
    if z <=46 then
    if x >= 3948.1999511719 and x <= 4018.8000488281  then 
	if y >= -1181.0999755859 and y <= -1100.0999755859  then
	setElementVelocity(veh, -0.07, 1.4, 1.2)
end
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
		song = playSound("song.mp3", true)

		bindKey("m", "down",
		function ()
        	setSoundPaused(song, not isSoundPaused(song))
		end
		)

 