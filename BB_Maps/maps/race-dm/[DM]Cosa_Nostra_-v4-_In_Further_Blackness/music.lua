setRadioChannel(0)
song = playSound("music.mp3", true)

bindKey("m", "down",
function ()
setSoundPaused(song, not isSoundPaused(song))
end
)