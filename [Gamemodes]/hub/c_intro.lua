---------------------------------<
-- Hub
-- intro.lua
--[[-----------------------------<
This script contains the intro, which is airplane + parachute jump
+ small notifications while jumping + Navigate to UAG Center initialising.
--]]-----------------------------<

g_Me = getLocalPlayer()
g_ScreenX, g_ScreenY = guiGetScreenSize()
g_ScreenStartX = g_ScreenX/2-400
g_ScreenStartY = g_ScreenY/2-300

-- Start Pos: x = 2155.9047851563 | y = 1333.107421875 | z = 73.980514526367
-- End Pos: x = 2121.3635253906 | y = 1333.107421875 | z = <retrieve at runIntro>

local endX,endY,endZ,tarX,tarY,tarZ
local startTick

local introText = {false,false,false,false,false,false,false}
local Offsets = {0,0}
--[1] = Welcome,[2] = to,[3] = the,[4] = Ultimate,[5] = AIR,[6] = Gamers,[7] = server

function runIntro()
	toggleAllControls(false, true,false)
	fadeCamera(false, 0)
	-- Disable BB_Menu
	spawnPlayer(2121.3635253906,1333.107421875,10.8203125,90, 0, 0,1)
	introText = {false,false,false,false,false,false,false}
	Offsets = {g_ScreenStartX+50,g_ScreenStartX+100}
	setTimer(setCameraTarget, 400, 1, g_Me)
	setTimer(function()
		endX,endY,endZ,tarX,tarY,tarZ = getCameraMatrix()

		startTick = getTickCount()

		addEventHandler("onClientRender", root, updateCamera)

		fadeCamera(true, 1)
	end, 800,1)
end

function updateCamera()
	local tick = getTickCount()
	local ran = tick-startTick
	local prog = (ran)/9000
	local x = 2155.9047851563-(2155.9047851563-endX)*prog
	local y = 1333.107421875
	local z = 73.980514526367-(73.980514526367-endZ)*getEasingValue(prog, "OutQuad")
	setCameraMatrix(x,y,z,tarX,tarY,tarZ)

	if (ran > 3000) and (not introText[1]) then
		introText[1] = true
		Offsets[1] = Offsets[1] + quickText("Welcome ", Offsets[1], g_ScreenStartY+200, 30, 3000,tocolor(255,255,255,255))
	end

	if (ran > 3150) and (not introText[2]) then
		introText[2] = true
		Offsets[1] = Offsets[1] + quickText("to ", Offsets[1], g_ScreenStartY+200, 30, 3000,tocolor(255,255,255,255))
	end

	if (ran > 3300) and (not introText[3]) then
		introText[3] = true
		Offsets[1] = Offsets[1] + quickText("the ", Offsets[1], g_ScreenStartY+200, 30, 3000,tocolor(255,255,255,255))
	end

	if (ran > 3500) and (not introText[4]) then
		introText[4] = true
		Offsets[2] = Offsets[2] + quickText("Ultimate ", Offsets[2], g_ScreenStartY+255, 40, 3000,tocolor(0,125,255,255))
	end

	if (ran > 3700) and (not introText[5]) then
		introText[5] = true
		Offsets[2] = Offsets[2] + quickText("AIR ", Offsets[2], g_ScreenStartY+255, 40, 3000,tocolor(0,125,255,255))
	end

	if (ran > 3900) and (not introText[6]) then
		introText[6] = true
		Offsets[2] = Offsets[2] + quickText("Gamers ", Offsets[2], g_ScreenStartY+255, 40, 3000,tocolor(0,125,255,255))
	end

	if (ran > 4150) and (not introText[7]) then
		introText[7] = true
		quickText("server", g_ScreenStartX+500, g_ScreenStartY+325, 30, 3000,tocolor(255,255,255,255))
	end

	if prog >= 1 then
		setCameraTarget(g_Me)
		removeEventHandler("onClientRender", root, updateCamera)
		toggleAllControls(true, true,false)
	end
end

function spawnPlayer(x,y,z,rotation, skinID, interior, dimension)
	setElementPosition(g_Me, x,y,z)
	setElementRotation(g_Me, 0,0,rotation)
	if skinID then
		setElementModel(g_Me, skinID)
	end
	if interior then
		setElementInterior(g_Me, interior)
	end
	if dimension then
		triggerServerEvent("onPlayermovePlayerToDim", g_Me, dimension)
	end
end

addEvent("onClientHubIntro")
addEventHandler("onClientHubIntro", root, runIntro)