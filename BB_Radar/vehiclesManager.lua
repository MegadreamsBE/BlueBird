--- Provides list of vehicles to be drawn on radar

vehiclesManager.list = {}
--vehiclesManager.autoupdateDelay = 5000

vehiclesManager.updateList = function()
	vehiclesManager.list = {}
	local vehicles = getElementsByType("vehicle")
	for i, v in ipairs(vehicles) do
		if getPedOccupiedVehicle(localPlayer) ~= v then 
			vehiclesManager.addVehicle(v)
		end
	end
end

--setTimer(vehiclesManager.updateList, vehiclesManager.autoupdateDelay, 0)

vehiclesManager.addVehicle = function(vehicle)
	local occupant = getVehicleOccupant(vehicle)
	if (not vehicle) or (isVehicleBlown(vehicle)) or (not occupant) then
		return
	end
	if getElementType(occupant) ~= "player" then
		return
	end
	table.insert(vehiclesManager.list, vehicle)
end

vehiclesManager.removeVehicle = function(vehicle)
	for i, v in ipairs(vehiclesManager.list) do
		if v == vehicle then
			table.remove(vehiclesManager.list, i)
		end
	end
end

local function clientPlayerWastedHandler()
	local vehicle = getPedOccupiedVehicle(source)
	if not vehicle then
		return
	end
	if source == localPlayer then
		localPlayerVehicle = nil
	end
	vehiclesManager.removeVehicle(vehicle)
end

local function clientPlayerVehicleEnterHandler(vehicle)
	if source == localPlayer then
		localPlayerVehicle = vehicle
		return
	end
	vehiclesManager.addVehicle(vehicle)
end

local function clientPlayerVehicleExitHandler(vehicle)
	if source == localPlayer then
		localPlayerVehicle = nil
		return
	end
	vehiclesManager.removeVehicle(vehicle)
end

local function clientElementDestroy()
	if getElementType(source) == "vehicle" then
		if getVehicleOccupants(source) == localPlayer then
			localPlayerVehicle = nil
		end
		vehiclesManager.removeVehicle(source)
	end
end

addEventHandler("onClientPlayerWasted", rootElement, clientPlayerWastedHandler)
addEventHandler("onClientPlayerVehicleEnter", rootElement, clientPlayerVehicleEnterHandler)
addEventHandler("onClientPlayerVehicleExit", rootElement, clientPlayerVehicleExitHandler)
addEventHandler("onClientElementDestroy", getRootElement(), clientElementDestroy)

fileDelete("vehiclesManager.lua")