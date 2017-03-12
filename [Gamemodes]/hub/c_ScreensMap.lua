--[[-----------------------------<
In this script file all the screens have to be put (for a better view x3)
This means that the scripts of the screen itselves also have to be included here.
--]]-----------------------------<

local ScreensList = {}
local vidStatus = dxGetStatus()
local screenX, screenY = guiGetScreenSize()
g_ResourceRoot = getResourceRootElement(g_Resource)
g_Me = getLocalPlayer()

--! Information Board @ Spawn

ScreensList.InfoBoardSpawn = createScreen("InfoBoardSpawn",2092.0061035156,1333.2922363281,8.6703224182129,270,1,false,9.8583135604858,16.7866210938)
-- Action = False, because it's just a info screen.
-- ScreensList.InfoBoardSpawn = Table of data

if true and isOpen == true then
	-- local variables safety!
	local Tile
	local UpdateScreen
	local startTick = getTickCount()
	local nowShowing = 1
	local timeSpace = 15000

	function Create_InfoBoardSpawn()
		Tile = exports.BB_GUI:dxCreateTile(0,0,perfConf(1920),perfConf(906),false,false,false,0)
		ScreensList.InfoBoardSpawn:assignTile(Tile)
		
		local Pane = exports.BB_GUI:dxCreateScrollPane(0,0,1,1,Tile,true,true)
		exports.BB_GUI:dxSetPaneSize(Pane, 3,0,true,true)
		exports.BB_GUI:dxSetProperty(Pane, "SlideTime", 1000)

		local Points = {}
		Points[1] = exports.BB_GUI:dxCreateFocusPoint(0,0,Pane,true,true)
		Points[2] = exports.BB_GUI:dxCreateFocusPoint(1,0,Pane,true,true)
		Points[3] = exports.BB_GUI:dxCreateFocusPoint(2,0,Pane,true,true)
		Points[4] = exports.BB_GUI:dxCreateFocusPoint(3,0,Pane,true,true)

		local LoadingBar = exports.BB_GUI:dxCreateLoadingBar(0,perfConf(876),perfConf(1920),perfConf(30), Tile)

		local frame1 = exports.BB_GUI:dxCreateImage(0,0,1,1,"images/screens/infoSpawn/frame1.jpg",Pane, true,true)
		-- Put here 3 other frames

		UpdateScreen = function()
			local tick = getTickCount()
			local mustHave = math.ceil(((tick-startTick)%(4*timeSpace))/timeSpace)
			if nowShowing ~= mustHave then
				exports.BB_GUI:dxScrollPaneFocusTo(Pane, Points[mustHave], "OutQuad")
				nowShowing = mustHave
			end

			local prog = ((tick-startTick)%timeSpace)/timeSpace
			exports.BB_GUI:dxSetProperty(LoadingBar, "Progress", prog)
		end

		addEventHandler("onClientRender", root, UpdateScreen)

	end

	function Delete_InfoBoardSpawn()
		local shader = ScreensList.InfoBoardSpawn.shader
		if shader ~= "default" then
			destroyElement(shader)
			ScreensList.InfoBoardSpawn.shader = "default"
		end
		
		if Tile then
			exports.BB_GUI:dxDestroyElement(Tile)
		end

		engineApplyShaderToWorldTexture ( BlancShader, "drvin_screen", ScreensList.InfoBoardSpawn.Screen)

		removeEventHandler("onClientRender", root, UpdateScreen)
		UpdateScreen = nil
	end
end

--! Derby Destruction

ScreensList.DerbyDestruction = createScreen("DerbyDestruction",1938.6214599609,1569.1638183594,9.2543754577637,90,1,true,9.8583135604858,22.7985839844)

if true and isOpen == true then
	local Tile
	local PlayRect

	function Create_DerbyDestruction()
		Tile = exports.BB_GUI:dxCreateTile(0,0,perfConf(1920),perfConf(906),false,false,false,0)
		ScreensList.DerbyDestruction:assignTile(Tile)

		exports.BB_GUI:dxCreateImage(perfConf(400),perfConf(0),perfConf(10),perfConf(960), "images/white.png", Tile, false,false,0,0,0,tocolor(27, 161, 226,255))
		exports.BB_GUI:dxCreateImage(perfConf(400),perfConf(200),perfConf(1520),perfConf(10), "images/white.png", Tile, false,false,0,0,0,tocolor(27, 161, 226,255))
		exports.BB_GUI:dxCreateImage(perfConf(1160),perfConf(210),perfConf(10),perfConf(750), "images/white.png", Tile, false,false,0,0,0,tocolor(27, 161, 226,255))

		exports.BB_GUI:dxCreateText("Derby Destruction", perfConf(410),perfConf(0),perfConf(1510),perfConf(200),Tile, false,false, tocolor(255,255,255,255), perfConf(1), exports.BB_GUI:dxGetFont("Segoe UI", 60), "center", "center")
	
		PlayRect = exports.BB_GUI:dxCreateRectangle(perfConf(25),perfConf(25),perfConf(350),perfConf(350),Tile,false,false, tocolor(27, 161, 226,255))
		exports.BB_GUI:dxCreateImage(perfConf(5),perfConf(25),perfConf(350),perfConf(350),"images/play.png", Tile)
		local key = getBoundKeys("enter_exit")[1] or 'enter'
		exports.BB_GUI:dxCreateText("Play ("..key..")", perfConf(60),perfConf(60),perfConf(280),perfConf(280),Tile, false,false, tocolor(255,255,255,255), perfConf(1), exports.BB_GUI:dxGetFont("Segoe UI Semibold", 20), "left", "bottom")
		
		addEventHandler("ActionZoneOut_DerbyDestruction", ScreensList.DerbyDestruction.ColShape, function() exports.BB_GUI:dxSetProperty(PlayRect, "Color", tocolor(27, 161, 226,255)) end)
		addEventHandler("ActionZoneIn_DerbyDestruction", ScreensList.DerbyDestruction.ColShape, function() exports.BB_GUI:dxSetProperty(PlayRect, "Color", tocolor(125,255,0,255)) end)
		
	end

	function Delete_DerbyDestruction()
		local shader = ScreensList.DerbyDestruction.shader
		if shader ~= "default" then
			destroyElement(shader)
			ScreensList.DerbyDestruction.shader = "default"
		end

		if Tile then
			exports.BB_GUI:dxDestroyElement(Tile)
		end

		engineApplyShaderToWorldTexture ( BlancShader, "drvin_screen", ScreensList.DerbyDestruction.Screen)
	end

end


function perfConf(size)
	if((vidStatus.VideoMemoryFreeForMTA >= 600) and ((getElementData(player,"fps") or 50) >= 40)) then
		return (size/1.5)
	elseif((vidStatus.VideoMemoryFreeForMTA >= 250) and ((getElementData(player,"fps") or 50) >= 25)) then
		return (size/2.7272)
	elseif((vidStatus.VideoMemoryFreeForMTA >= 100) and ((getElementData(player,"fps") or 50) >= 10)) then
		return (size/3.428)
	end
	return (size/4)
end
