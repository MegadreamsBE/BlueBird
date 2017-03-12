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
outputChatBox ("", 255, 255, 255, true)
outputChatBox ("", 255, 255, 255, true)
outputChatBox ("", 255, 255, 255, true)
outputChatBox ("", 255, 255, 255, true)
outputChatBox ("", 255, 255, 255, true)
outputChatBox ("", 255, 255, 255, true)
outputChatBox ("#9E9459[MAP]:  #FFFFFFnX_ {°} Vol.#9E94598 #FFFFFF{°} #9E9459V#FFFFFFAn#505050i#FFFFFFTY™ II.", 27, 89, 224, true)



function ClientStarted ()
end 


addEventHandler( "onClientResourceStart", getResourceRootElement(getThisResource()), ClientStarted )

setRadioChannel(0)
song = playSound("song.mp3", true)

bindKey("m", "down",
function ()
        setSoundPaused(song, not isSoundPaused(song))
end
)