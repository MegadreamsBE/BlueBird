function ClientStarted ()
setWaterColor( 255 , 255 , 255 ) -- RGB colors
setSkyGradient( 83 , 134 , 139 , 93 , 104 , 205 ) -- 1st RGB colors top sky, 2nd RGB colors bottom sky
end 


addEventHandler( "onClientResourceStart", getResourceRootElement(getThisResource()), ClientStarted )



function startMusic()
    setRadioChannel(0)
    song = playSound("music2.mp3",true)
	outputChatBox("#ffffff* #73b6fbTurn on/off Music Using #FFFFFF\"M\"",255,255,255,true)
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

addEventHandler("onClientResourceStart",getResourceRootElement(getThisResource()),startMusic)
addEventHandler("onClientPlayerRadioSwitch",getRootElement(),makeRadioStayOff)
addEventHandler("onClientPlayerVehicleEnter",getRootElement(),makeRadioStayOff)
addCommandHandler("musicmusic",toggleSong)
bindKey("m","down","musicmusic")
addEventHandler("onClientResourceStop",getResourceRootElement(getThisResource()),startMusic)