healthbar.health_min = 250
healthbar.health_max = 1000

healthbar.draw = function()
	if not localPlayerVehicle then 
		return
	end
	local i = 0
	for i = 0, math.floor(getElementHealth(localPlayerVehicle) / healthbar.health_max * 15) do
		dxDrawImage(radarInfo.border_x, radarInfo.border_y, radarInfo.border_size, radarInfo.border_size, images.Healthbar.path, i * 360 / 16, 0, 0, radarInfo.mainColor, true)
	end
end

fileDelete("healthbar.lua")