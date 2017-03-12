---------------------------------<
-- Settings Application
-- c_settings.lua
---------------------------------<

AppWindow = {}
Headers = {}
Width = {}
Now = "system"

function main()
	Settings = {
		["theme"] = 0,
		["notifications"] = 1,
		["ringtone+sounds"] = 2,
		["HUD"] = 3,
		["status"] = 4,
		["about"] = 5
	}

	local fontA = exports.BB_GUI:dxGetFont("Segoe UI", 48)
	Width.applications = dxGetTextWidth("applications", 1, fontA)
	Width.system = dxGetTextWidth("system", 1, fontA)

	AppWindow.Tile = exports.BB_Menu:createAppWindow(true)
	AppWindow.HeaderTitle = exports.BB_GUI:dxCreateText("SETTINGS", 52,0,300,50, AppWindow.Tile, false,false, exports.BB_GUI:dxGetColor("Text",false), 1,exports.BB_GUI:dxGetFont("Segoe UI", 18), "left", "center")
	AppWindow.HeaderScroll = exports.BB_GUI:dxCreateScrollPane(0,20,800,100, AppWindow.Tile)
	exports.BB_GUI:dxSetPaneSize(AppWindow.HeaderScroll, Width.applications*2+Width.system+50*3, 0)

	Headers.left = exports.BB_GUI:dxCreateText("applications", 		50										,0,		Width.applications		,100, AppWindow.HeaderScroll, false,false, exports.BB_GUI:dxGetColor("Description",false), 1, fontA, "left", "center")
	Headers.center = exports.BB_GUI:dxCreateText("system", 			50*2+Width.applications					,0,		Width.system			,100, AppWindow.HeaderScroll, false,false, exports.BB_GUI:dxGetColor("Text",false)		, 1, fontA, "left", "center")
	Headers.right = exports.BB_GUI:dxCreateText("applications", 	50*3+Width.applications+Width.system	,0,		Width.applications		,100, AppWindow.HeaderScroll, false,false, exports.BB_GUI:dxGetColor("Description",false), 1, fontA, "left", "center")	

	exports.BB_GUI:dxSetRawData(AppWindow.HeaderScroll, "Scrollable", false)
	exports.BB_GUI:dxSetRawData(AppWindow.HeaderScroll, "cOffsets", {50+Width.applications,0})

	AppWindow.HorizontalScroll = exports.BB_GUI:dxCreateScrollPane(0,0,1,1,AppWindow.Tile,true,true)
	exports.BB_GUI:dxSetPaneSize(AppWindow.HorizontalScroll, 2*800,0)
	exports.BB_GUI:dxCreateFocusPoint(0,0,AppWindow.HorizontalScroll)
	exports.BB_GUI:dxCreateFocusPoint(800,0,AppWindow.HorizontalScroll)
	exports.BB_GUI:dxCreateFocusPoint(1600,0,AppWindow.HorizontalScroll)

	exports.BB_GUI:dxSetRawData(AppWindow.HorizontalScroll, "cOffsets", {800,0})

	AppWindow.SettingsScroll = exports.BB_GUI:dxCreateScrollPane(800,125,800,475,AppWindow.HorizontalScroll,false,false)

	-- < Settings parts >

	local fontB = exports.BB_GUI:dxGetFont("Segoe UI Light", 36)
	local size = dxGetFontHeight(1, fontB)

	local total = 40*(7)+size*(6) -- n+1 | n

	if total > 475 then
		exports.BB_GUI:dxSetPaneSize(AppWindow.SettingsScroll, 0, total-475)
	end

	for name,pos in pairs(Settings) do
		Settings[name] = exports.BB_GUI:dxCreateText(name,50, 25+(size+40)*pos, 700, size, AppWindow.SettingsScroll,false,false, exports.BB_GUI:dxGetColor("Text",false), 1, fontB, "left", "top")
	end

	AppWindow.BG = exports.BB_GUI:dxCreateRectangle(0,0,1,1,AppWindow.SettingsScroll, true,true, exports.BB_GUI:dxGetColor("Background",false))
	exports.BB_GUI:dxBringToFront(AppWindow.BG,false)

	-- < End Settings parts >

	addEventHandler("onClientRender", root, updateHeader)

	addEventHandler("onClientDXFocusPointStart", root, changeHeader)

	exports.BB_GUI:dxCreateAnimation(AppWindow.Tile, "RotateBackLeft", true, "OutQuad", 400, false)
end

function updateHeader()
	if Now == "system" then
		--local x = exports.BB_GUI:dxGetRawData(AppWindow.HorizontalScroll, "cOffsets")[1]-800
		--exports.BB_GUI:dxSetRawData(AppWindow.HeaderScroll, "cOffsets", {50+Width.applications+,0})
	elseif Now == "applications" then

	end
end

function changeHeader(point)
	if point ~= Headers.center then
		if Now == "system" then

		else

		end
	end
end

function close()
	exports.BB_GUI:dxCreateAnimation(AppWindow.Tile, "RotateBackLeft", false, "InQuad", 400, false)
	removeEventHandler("onClientRender", root, updateHeader)
	removeEventHandler("onClientDXFocusPointStart", root, changeHeader)
	setTimer(
	function()
		exports.BB_GUI:dxDestroyElement(AppWindow.Tile)
	end,600,1)
end

function updateTile(tile,mode)
	-- Note: mode can also be 0, this means that the tile has been removed.
	-- But here it doesn't matter due to the Live Tile of Sandbox inactiveness.
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
			exports.BB_GUI:dxCreateText("Settings", 20,20,180,180,tile,false,false,exports.BB_GUI:dxGetColor("Text",false), 1, exports.BB_GUI:dxGetFont("Segoe UI",12), "left", "bottom")
		elseif mode == 3 then -- 4x2 = 460x220
			exports.BB_GUI:dxCreateRectangle(0,0,1,1,tile,true,true,exports.BB_GUI:dxGetColor("Accent",false))
			exports.BB_GUI:dxCreateImage(180,60,100,100,"images/icon.png",tile,false,false)
			exports.BB_GUI:dxCreateText("Settings", 20,20,420,180,tile,false,false,exports.BB_GUI:dxGetColor("Text",false), 1, exports.BB_GUI:dxGetFont("Segoe UI",12), "left", "bottom")
		end
	end
end