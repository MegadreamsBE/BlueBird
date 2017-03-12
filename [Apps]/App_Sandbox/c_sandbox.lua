---------------------------------<
-- Sandbox Application
-- c_sandbox.lua
---------------------------------<

AppWindow = {}

function main()
	AppWindow.Tile = exports.BB_Menu:createAppWindow(true)
	AppWindow.Slider = exports.BB_GUI:dxCreateSlider(0.2,0.4,0.6,0.2, false,AppWindow.Tile, true,true)
	AppWindow.Sticky = exports.BB_GUI:dxCreateButton(0.4,0.65,0.2,0.1, "Free", AppWindow.Tile,true,true)
	AppWindow.RealTime = exports.BB_GUI:dxCreateText("Real Time Value: 0", 0.2, 0.1, 0.6, 0.1, AppWindow.Tile, true,true, -1, 1, exports.BB_GUI:dxGetFont("Segoe UI Semibold", 20), "left","center")
	AppWindow.FinalValue = exports.BB_GUI:dxCreateText("Final Value: 0", 0.2, 0.2, 0.6, 0.1, AppWindow.Tile, true,true, -1, 1, exports.BB_GUI:dxGetFont("Segoe UI Semibold", 20), "left","center")


	addEventHandler("onClientDXClick", getRootElement(), updateSlider)
	addEventHandler("onClientDXSliderMove", getRootElement(), updateRealTimeText)
	addEventHandler("onClientDXSliderFinalMove", getRootElement(), updateFinalText)

	exports.BB_GUI:dxCreateAnimation(AppWindow.Tile, "RotateBackLeft", true, "OutQuad", 400, false)
end

function updateSlider(btn, state)
	if (btn == "left") and (state == "up") then
		if source == AppWindow.Sticky then
			local foo = exports.BB_GUI:dxGetRawData(AppWindow.Sticky, "Text")
			if foo == "Free" then
				exports.BB_GUI:dxSetProperty(AppWindow.Sticky, "Text", "Sticky")
				exports.BB_GUI:dxSetRawData(AppWindow.Slider, "Sticky", true)
			else
				exports.BB_GUI:dxSetProperty(AppWindow.Sticky, "Text", "Free")
				exports.BB_GUI:dxSetRawData(AppWindow.Slider, "Sticky", false)
			end
		end
	end	
end

function updateRealTimeText(prog)
	exports.BB_GUI:dxSetRawData(AppWindow.RealTime, "Text", "Real Time Value: "..prog)
end

function updateFinalText(prog)
	exports.BB_GUI:dxSetRawData(AppWindow.FinalValue, "Text", "Final Value: "..prog)
end

function close()
	exports.BB_GUI:dxCreateAnimation(AppWindow.Tile, "RotateBackLeft", false, "InQuad", 400, false)
	removeEventHandler("onClientDXClick", getRootElement(), updateSlider)
	removeEventHandler("onClientDXSliderMove", getRootElement(), updateRealTimeText)
	removeEventHandler("onClientDXSliderFinalMove", getRootElement(), updateFinalText)
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
			exports.BB_GUI:dxCreateText("Sandbox", 20,20,180,180,tile,false,false,exports.BB_GUI:dxGetColor("Text",false), 1, exports.BB_GUI:dxGetFont("Segoe UI",12), "left", "bottom")
		elseif mode == 3 then -- 4x2 = 460x220
			exports.BB_GUI:dxCreateRectangle(0,0,1,1,tile,true,true,exports.BB_GUI:dxGetColor("Accent",false))
			exports.BB_GUI:dxCreateImage(180,60,100,100,"images/icon.png",tile,false,false)
			exports.BB_GUI:dxCreateText("Sandbox", 20,20,420,180,tile,false,false,exports.BB_GUI:dxGetColor("Text",false), 1, exports.BB_GUI:dxGetFont("Segoe UI",12), "left", "bottom")
		end
	end
end