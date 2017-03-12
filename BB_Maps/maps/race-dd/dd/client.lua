
 local delayvalue = false
datmarker = createMarker (4216.8994140625,-479.3994140625,37.299999237061,"corona",5,12,7,77,153)



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


