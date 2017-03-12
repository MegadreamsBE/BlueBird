song = playSound("music.mp3", true)

bindKey("m", "down",
function ()
        setSoundPaused(song, not isSoundPaused(song))
end
)

outputChatBox ("#FF6666[SONG]: #FFFFFFPress #FF8800'M' #FFFFFFto turn the music ON / OFF", 255, 0, 0, true)

setCloudsEnabled ( false )

function shotlimit (creator)
 if (creator) then
  if getElementType (creator) == "vehicle" then 
   if (creator == getPedOccupiedVehicle(getLocalPlayer())) then   
    if getElementModel(getPedOccupiedVehicle(getLocalPlayer())) == 425 then
     toggleControl ( "vehicle_fire", false )   
     setTimer (function ()
       toggleControl ( "vehicle_fire", true )
       end
      ,800, 1)
    end
   end
  end
 end
end
addEventHandler("onClientProjectileCreation", getRootElement(), shotlimit )