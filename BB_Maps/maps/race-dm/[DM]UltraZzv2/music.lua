function startMusic()
    setRadioChannel(0)
    song = playSound("music.mp3",true)
	outputChatBox(" \n\n\n\n\n\n\n\n\n\n #d1cb77Around the world\n#d1cb77U#999999ltraZz~: Good Luck and have fun.", 0, 0, 0, true)
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
