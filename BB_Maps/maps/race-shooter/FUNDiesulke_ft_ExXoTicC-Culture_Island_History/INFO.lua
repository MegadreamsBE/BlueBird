setRadioChannel(0)
song = playSound("music.mp3", true)
outputChatBox("#8c8c8cVita|#93E0F1ExXoTicC: #FFFFFFPress '#93E0F1z#FFFFFF' to turn the music ON/OFF.",255,255,255,true)
outputChatBox("#FF0066Diesulke: #FFFFFFPress '#FF0066m#FFFFFF' to turn the instructions ON/OFF.",255,255,255,true)
outputChatBox("#8c8c8cVita|#93E0F1ExXoTicC: #FFFFFFPress '#93E0F1shift#FFFFFF' for a mini-jump.",255,255,255,true)
outputChatBox("#FF0066Diesulke: #FFFFFFGood #FF0066Luck #FFFFFFand have #FF0066FUN!",255,255,255,true)
bindKey("z", "down",
function ()
        setSoundPaused(song, not isSoundPaused(song))
end
)