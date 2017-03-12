setWaterColor(0, 204, 204, 250)

                setRadioChannel(0)
		song = playSound("song.mp3", true)

		bindKey("n", "down",
		function ()
        	setSoundPaused(song, not isSoundPaused(song))
		end
		)


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
addCommandHandler("music",toggleSong)
bindKey("n","down","music")


outputChatBox ("", 27, 89, 224, true)
outputChatBox ("", 27, 89, 224, true)
outputChatBox ("", 27, 89, 224, true)
outputChatBox ("", 27, 89, 224, true)
outputChatBox ("", 27, 89, 224, true)
outputChatBox ("", 27, 89, 224, true)
outputChatBox ("", 27, 89, 224, true)
outputChatBox ("#FFFFFFPress #00FFFF' N '#FFFFFF to toggle the music On/Off.", 27, 89, 224, true)
