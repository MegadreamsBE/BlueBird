addEventHandler("onClientResourceStart",getRootElement(),
function(res)
	if res == getThisResource() then
		setElementData(localPlayer,"Lisa.rocket.timeout", 0)
	end
end )

function shoot()
	local theVehicle = getPedOccupiedVehicle(localPlayer)
	if not isPlayerDead(localPlayer) and getElementData(localPlayer,"Lisa.rocket.timeout")	== 0 then
		local x, y, z = getElementPosition(theVehicle)
		local rX, rY, rZ = getVehicleRotation(theVehicle)
		local x = x+4*math.cos(math.rad(rZ+90))
		local y = y+4*math.sin(math.rad(rZ+90))
		createProjectile(theVehicle, 19, x, y, z, 1.0, nil)
		setElementData(localPlayer,"Lisa.rocket.timeout", 1)
		setTimer(function() setElementData(localPlayer,"Lisa.rocket.timeout", 0) end, 3000, 1)
	end
end
bindKey("lctrl","down",shoot)
bindKey("rctrl","down",shoot)
bindKey("mouse1","down",shoot)