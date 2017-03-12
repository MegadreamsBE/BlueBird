function startMusic()
    setRadioChannel(0)
    song = playSound("bonfire.mp3",true)
	outputChatBox("",255,255,255,true)
	outputChatBox("",255,255,255,true)
	outputChatBox("",255,255,255,true)
	outputChatBox("",255,255,255,true)
	outputChatBox("",255,255,255,true)
	outputChatBox("",255,255,255,true)
	outputChatBox("",255,255,255,true)
	outputChatBox("Map by: #0895D6aXiX",255,255,255,true)
	outputChatBox("Song name: #0895D6Knife Party - Bonfire (Original Mix) ", 255, 255, 255, true)
	outputChatBox("Toggle music #0895D6on#FFFFFF/#0895D6off #FFFFFFusing #0895D6M", 255, 255, 255, true)
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