---------------------------------<
-- Logout App
-- c_logout.lua
---------------------------------<

AppWindow = {}
QuickAccesTile = false


function main()
	AppWindow.Tile = exports.BB_Menu:createAppWindow(true)
	AppWindow.Text = exports.BB_GUI:dxCreateText("Are you sure you want to log out?", 0, 220, 800, 80, AppWindow.Tile, false,false, -1, 1, exports.BB_GUI:dxGetFont("Segoe UI Semibold", 20), "center","center")
	AppWindow.Accept = exports.BB_GUI:dxCreateButton(200,300,170,40, "Yes", AppWindow.Tile)
	AppWindow.Decline = exports.BB_GUI:dxCreateButton(430,300,170,40, "No", AppWindow.Tile)

	addEventHandler("onClientDXClick", getRootElement(), doSomething)

	exports.BB_GUI:dxCreateAnimation(AppWindow.Tile, "RotateBackLeft", true, "OutQuad", 400, false)
end

function doSomething(btn, state)
	if (btn == "left") and (state == "up") then
		if source == AppWindow.Accept then
			logPlayerOut()
		elseif source == AppWindow.Decline then
			exports.BB_AppManager:CloseApp()
		end
		removeEventHandler("onClientDXClick", getRootElement(), doSomething)
	end
end

function close()
	exports.BB_GUI:dxCreateAnimation(AppWindow.Tile, "RotateBackLeft", false, "InQuad", 400, false)
	setTimer(
	function()
		exports.BB_GUI:dxDestroyElement(AppWindow.Tile)
	end,600,1)
end

function updateTile(tile,mode)
	-- Note: mode can also be 0, this means that the tile has been removed.
	-- But here it doesn't matter due to the Live Tile of Logout inactiveness.
	local bool
	if tile then
	 	bool = exports.BB_GUI:dxDestroyChildren(tile)
	end
	if bool then
		if mode == 1 then -- 1x1 = 100x100
			exports.BB_GUI:dxCreateRectangle(0,0,1,1,tile,true,true,exports.BB_GUI:dxGetColor("Accent",false))
			exports.BB_GUI:dxCreateImage(0,0,1,1,"images/icon.png",tile,true,true)
		elseif mode == 2 then -- 2x2 = 220x220
			exports.BB_GUI:dxCreateRectangle(0,0,1,1,tile,true,true,exports.BB_GUI:dxGetColor("Accent",false))
			exports.BB_GUI:dxCreateImage(60,60,100,100,"images/icon.png",tile,false,false)
			exports.BB_GUI:dxCreateText("Logout", 20,20,180,180,tile,false,false,exports.BB_GUI:dxGetColor("Text",false), 1, exports.BB_GUI:dxGetFont("Segoe UI",12), "left", "bottom")
		elseif mode == 3 then -- 4x2 = 460x220
			exports.BB_GUI:dxCreateRectangle(0,0,1,1,tile,true,true,exports.BB_GUI:dxGetColor("Accent",false))
			exports.BB_GUI:dxCreateImage(180,60,100,100,"images/icon.png",tile,false,false)
			exports.BB_GUI:dxCreateText("Logout", 20,20,420,180,tile,false,false,exports.BB_GUI:dxGetColor("Text",false), 1, exports.BB_GUI:dxGetFont("Segoe UI",12), "left", "bottom")
		end
	end
end

function logPlayerOut()
	fileDelete("@:BB_Login/autologin.xml")
	triggerServerEvent("onUserSaveAllTheThings", getLocalPlayer())
end

addEvent("onClientDXClick")