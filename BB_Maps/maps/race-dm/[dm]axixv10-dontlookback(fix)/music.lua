function startMusic()
    setRadioChannel(0)
    song = playSound("song.mp3",true)
	outputChatBox("",255,255,255,true)
	outputChatBox("",255,255,255,true)
	outputChatBox("",255,255,255,true)
	outputChatBox("",255,255,255,true)
	outputChatBox("",255,255,255,true)
	outputChatBox("",255,255,255,true)
	outputChatBox("",255,255,255,true)
	outputChatBox("Map by: #A5C1D1aXiX",255,255,255,true)
	outputChatBox("Song name: #A5C1D1Fonik - Infectious ", 255, 255, 255, true)
	outputChatBox("Toggle music #A5C1D1on#FFFFFF/#A5C1D1off #FFFFFFusing #A5C1D1M", 255, 255, 255, true)
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
addCommandHandler("mkmap1_racetheme",toggleSong)
bindKey("m","down","mkmap1_racetheme")