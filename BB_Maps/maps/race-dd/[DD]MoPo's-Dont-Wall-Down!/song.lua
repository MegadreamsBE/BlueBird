setRadioChannel(0)
song = playSound("song.mp3", true)

bindKey("m", "down",
function ()
        setSoundPaused(song, not isSoundPaused(song))
end
)