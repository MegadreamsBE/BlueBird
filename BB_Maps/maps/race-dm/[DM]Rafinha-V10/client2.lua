outputChatBox ("", 255, 255, 255, true)
outputChatBox ("", 255, 255, 255, true)
outputChatBox ("", 255, 255, 255, true)
outputChatBox ("", 255, 255, 255, true)
outputChatBox ("", 255, 255, 255, true)
outputChatBox ("", 255, 255, 255, true)
outputChatBox ("", 255, 255, 255, true)
outputChatBox ("", 255, 255, 255, true)
outputChatBox ("", 255, 255, 255, true)
outputChatBox ("", 255, 255, 255, true)
outputChatBox ("", 255, 255, 255, true)
outputChatBox ("", 255, 255, 255, true)
outputChatBox ("#FF1493Rafinh#ffffffa:  #FF1493[DM]#FFFFFF Rafinha V10 - Skrillex.", 255, 255, 255, true)
outputChatBox ("#FF1493Rafinh#ffffffa:  #FFFFFFPress #FF1493'M'#FFFFFF to toggle the music On/Off.", 255, 255, 255, true)
outputChatBox ("#FF1493Rafinh#ffffffa:  #FFFFFFGood Luck & Have Fun!", 255, 255, 255, true)
outputChatBox ("#FF1493Rafinh#ffffffa:  #FFFFFFMusic - My Name is Skrillex (Skrillex Remix)", 255, 255, 255, true)

function startMusic()
    setRadioChannel(0)
    song = playSound("music2.mp3",true)

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