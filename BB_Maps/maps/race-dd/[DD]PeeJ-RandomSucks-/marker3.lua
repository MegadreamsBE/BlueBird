
 local delayvalue = false
datmarker = createMarker (2301.115234375,-3401.3896484375,5.7112998962402,"Checkpoint",5,12,149,98,10)



function changeVehFunc ( hitPlayer, matchingDimension )
 if (matchingDimension and hitPlayer == localPlayer) then
  if delayvalue == false then
   triggerServerEvent("changeVeh", localPlayer)
   delayvalue = true
   setTimer(function ()
    delayvalue = false
    end, 15000, 1)
  end
 end
end



addEventHandler("onClientMarkerHit", datmarker, changeVehFunc)


