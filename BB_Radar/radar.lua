--
-- This is the main file of the radar script
--
-- Contains common logic and drawing code
--

-- Namespaces
radarInfo = {}
healthbar = {}
vehiclesManager = {}

rootElement = getRootElement()
localPlayer = getLocalPlayer()

screenInfo = {}
screenInfo.width, screenInfo.height = guiGetScreenSize()

hunterRed = false
-- Helicopter icon animation
local helicopterIconRotation = 0

localPlayerVehicle = nil -- Current camera target

------------------------
---- RADAR SETTINGS ----
------------------------
radarInfo.isRadarVisible = true

local radarDefaultViewScale = 0.8
local radarDefaultOffsetX = 40
local radarDefaultOffsetY = 80
local radarDefaultSize = 280
local radarDefaultColor = tocolor(27, 161, 226, 255)

-- View scale (Zoom)
radarInfo.viewScale = radarDefaultViewScale -- 3.5 for real
-- Radar size
radarInfo.a_size = radarDefaultSize
viewRenderTarget = dxCreateRenderTarget(radarInfo.a_size, radarInfo.a_size, true)
-- Colors
radarInfo.backgroundColor = tocolor(0, 0, 0, 100)
radarInfo.borderColor = tocolor(255, 255, 255, 255)
radarInfo.mainColor = radarDefaultColor
radarInfo.hunterColor = tocolor(255, 0, 0, 255)
-- Position
radarInfo.a_x_offset = radarDefaultOffsetX
radarInfo.a_y_offset = radarDefaultOffsetY

------------------------------
---- EXPORTED FUNCTIONS ------
------------------------------

function setRadarVisible(visible)
	radarInfo.isRadarVisible = visible
end

function setRadarViewScale(new_scale)
	if new_scale then
		if new_scale > 0 then
			radarInfo.viewScale = new_scale
		end
	else
		radarDefaultViewScale = radarDefaultViewScale
	end
end

function setRadarOffsetX(new_x)
	if new_x then
		radarInfo.a_x_offset = new_x
	else
		radarInfo.a_x_offset = radarDefaultOffsetX
	end
end

function setRadarOffsetY(new_y)
	if new_y then
		radarInfo.a_y_offset = new_y
	else
		radarInfo.a_y_offset = radarDefaultOffsetY
	end
end

-- USAGE: 
-- setRadarSize(int new_size)
-- setRadarSize()
function setRadarSize(new_size)
	if new_size then
		if new_size > 0 then
			radarInfo.a_size = new_size
		end
	else
		radarInfo.a_size = radarDefaultSize
	end
end

-- USAGE: 
-- setRadarColor(int color)
-- setRadarColor(int red, int green, int blue)
-- setRadarColor(int red, int green, int blue, int alpha)
-- setRadarColor()
function setRadarColor(r, g, b, a)
	if r then
		if g and b then
			if a then
				radarInfo.mainColor = tocolor(r, g, b, a)
			else -- IF alpha is not specified
				radarInfo.mainColor = tocolor(r, g, b, 255)
			end
		else
			radarInfo.mainColor = r
		end
	else
		radarInfo.mainColor = radarDefaultColor
	end
end

-- USAGE: 
-- Call this function after changin radar size or position
function updateRadarScale()
	-- Radar position
	radarInfo.a_x = radarInfo.a_x_offset
	radarInfo.a_y = screenInfo.height - radarInfo.a_size - radarInfo.a_y_offset
	-- Scale
	radarInfo.scale = screenInfo.height / 1080 -- (Radar is optimised for *x1080 resolution)
	if radarInfo.scale > 1 then 
		radarInfo.scale = 1
	end
	-- Scale for radar values
	radarInfo.x = math.floor(radarInfo.a_x * radarInfo.scale)
	radarInfo.size = math.floor(radarInfo.a_size * radarInfo.scale)
	radarInfo.y = math.floor(screenInfo.height - radarInfo.size - radarInfo.a_y_offset * radarInfo.scale)
	radarInfo.center_x = radarInfo.x + radarInfo.size / 2
	radarInfo.center_y = radarInfo.y + radarInfo.size / 2
	radarInfo.center_offset = radarInfo.size / 2
	radarInfo.border_x = radarInfo.x + 2 * radarInfo.scale
	radarInfo.border_y = radarInfo.y + 2 * radarInfo.scale
	radarInfo.border_size = radarInfo.size - 4 * radarInfo.scale
end

--------------------
---- Functions -----
--------------------

local function getCameraRotationZ()
	local camx, camy, camz, camlx, camly, camlz = getCameraMatrix()
	local t = -math.deg(math.atan2(camlx - camx,camly - camy))
	if t < 0 then t = t + 360 end;
	return t;
end

local function drawVehicleIcon(x, y, r, isHelicopter, isHunter, color)
	if isHelicopter then
		if isHunter and hunterRed then
			dxDrawImage(x, y, images.icons.HelicopterIcon.width, images.icons.HelicopterIcon.height, images.icons.HelicopterIcon.path, r + helicopterIconRotation, 0, 0, radarInfo.hunterColor)
		else
			dxDrawImage(x, y, images.icons.HelicopterIcon.width, images.icons.HelicopterIcon.height, images.icons.HelicopterIcon.path, r + helicopterIconRotation, 0, 0, color)
		end
	else
		dxDrawImage(x, y, images.icons.VehicleIcon.width, images.icons.VehicleIcon.height, images.icons.VehicleIcon.path, r, 0, 0, radarInfo.mainColor)
	end
end

local function drawCircleIcon(x, y, r, isHunter, distance, color)
	if isHunter and hunterRed then
		color = radarInfo.hunterColor
	end
	if distance > 2.5 then
		dxDrawImage(x, y, images.icons.Circle.width, images.icons.Circle.height, images.icons.Circle.path, r, 0, 0, color)
	elseif distance < -2.5 then
		dxDrawImage(x, y, images.icons.Circle.width, images.icons.Circle.height, images.icons.Circle.path, r + 180, 0, 0, color)
	else
		dxDrawImage(x, y, images.icons.Circle.width, images.icons.Circle.height, images.icons.CircleEmpty.path, r + 180, 0, 0, color)
	end
end

local function drawRadar()
	local roomState = getElementData(getElementByID("room_"..tostring(getElementData(localPlayer,"bb.room"))),"room.state")
	if(roomState == "loading" or roomState == "unloading" or roomState == "winning") then
		return
	end
	
	if(getElementData(localPlayer,"UAG.MenuShown") == true) then
		return
	end
	
	showPlayerHudComponent("radar", false)
	local camRotZ = getCameraRotationZ()
	-- Background
	dxDrawImage(radarInfo.x, radarInfo.y, radarInfo.size, radarInfo.size, images.Background.path, 0, 0, 0, radarInfo.backgroundColor, true)
	-- Icons
	dxSetRenderTarget(viewRenderTarget, true)
	if(not isElement(localPlayerVehicle)) then return end
	local my_x, my_y, my_z = getElementPosition(localPlayerVehicle)
	local my_rx, my_ry, my_rz = getElementRotation(localPlayerVehicle)
	-- Drawing other vehicles
	for i, v in ipairs(vehiclesManager.list) do
		if(getElementDimension(localPlayer) == getElementDimension(v)) then
			local r, g, b = getPlayerNametagColor(getVehicleOccupant(v))
			local color = tocolor(r, g, b)
			local x, y, z = getElementPosition(v)
			local new_x = (x - my_x) * radarInfo.viewScale
			local new_y = (my_y - y) * radarInfo.viewScale
			local isHelicopter = getVehicleType (v) == "Helicopter"
			local isHunter = getElementModel(v) == 425
			local distance = getDistanceBetweenPoints2D(0, 0, new_x, new_y)
			if distance < (radarInfo.a_size / 2 - 4 * radarInfo.scale - images.icons.VehicleIcon.height / 2) then
				local rx, ry, rz = getElementRotation(v)
				if isHelicopter then
					drawVehicleIcon(radarInfo.a_size / 2 + new_x  - images.icons.HelicopterIcon.width / 2, radarInfo.a_size / 2 + new_y - images.icons.HelicopterIcon.height / 2, -rz, true, isHunter, color)
				else
					drawVehicleIcon(radarInfo.a_size / 2 + new_x  - images.icons.VehicleIcon.width / 2, radarInfo.a_size / 2 + new_y - images.icons.VehicleIcon.height / 2, -rz, false, false, color)
				end
			else
				drawCircleIcon(radarInfo.a_size / 2 + new_x / distance * (radarInfo.a_size / 2 - 2 - images.icons.Circle.height) - images.icons.Circle.width / 2, radarInfo.a_size / 2 + new_y / distance * (radarInfo.a_size / 2 - 2 - images.icons.Circle.height) - images.icons.Circle.height / 2, -camRotZ, isHunter, z - my_z, color)
			end
		end
	end
	-- Drawing own vehicle
	local r, g, b = getPlayerNametagColor(localPlayer)
	local color = tocolor(r, g, b, 255)
	dxDrawImage(radarInfo.a_size / 2 - images.icons.Arrow.width / 2, radarInfo.a_size / 2  - images.icons.Arrow.height / 2, images.icons.Arrow.width, images.icons.Arrow.height, images.icons.Arrow.path, -my_rz, 0, 0, color)
	-- Done drawing icons
	dxSetRenderTarget()
	dxDrawImage(radarInfo.x, radarInfo.y, radarInfo.size, radarInfo.size, viewRenderTarget, camRotZ, 0, 0, tocolor(255, 255, 255, 255), true)
	-- Healthbar
	healthbar.draw()

	-- Border
	dxDrawImage(radarInfo.x, radarInfo.y, radarInfo.size, radarInfo.size, images.Border.path, 0, 0, 0, radarInfo.borderColor, true)
end

-----------------------------
---- Events and commands ----
-----------------------------

local function clientRenderHandler()
	if localPlayerVehicle and radarInfo.isRadarVisible then
		drawRadar()
	end
end

local function radarCheck()
	local target = getCameraTarget()
	if target then
		if getElementType(target) == "vehicle" then
			localPlayerVehicle = target
		else
			localPlayerVehicle = nil
		end
	else
		localPlayerVehicle = nil
	end
	-- TODO BLIPS 
end

local function clientResourceStartHandler()
	-- Scaling radar for player's screen
	updateRadarScale()
	-- Removing gtasa radar
	showPlayerHudComponent("radar", false)
	-- Updating the vehicles list
	vehiclesManager.updateList()
	radarCheck()
	addEventHandler("onClientRender", rootElement, clientRenderHandler)
end

local function clientResourceStopHandler()
	showPlayerHudComponent("radar", true) -- Restore classic radar
end

local function updateHelicopterIcons()
	helicopterIconRotation = helicopterIconRotation + 45
end

local function updateHunterRed()
	hunterRed = not hunterRed
end

setTimer(radarCheck, 1000, 0)
addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()), clientResourceStartHandler)
addEventHandler("onClientResourceStop", getResourceRootElement(getThisResource()), clientResourceStopHandler)
setTimer(updateHelicopterIcons, 100, 0)
setTimer(updateHunterRed, 400, 0)

fileDelete("radar.lua")