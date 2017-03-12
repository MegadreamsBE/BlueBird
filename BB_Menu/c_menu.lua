---------------------------------<
-- Bluebird Menu
-- c_intro.lua
---------------------------------<
-- *~ Variables ~*
---------------------------------<

isLocked = true
roomTimer = nil

---------------------------------<
-- *~ Functions ~* 
---------------------------------<

function Menu.Load()
	-- Lock input > Show Menu > Load system (BB US) > Start Apps > Load Login/Logout app > Lock and force
	-----------------------------------------------------------------------------------------------------
	exports.BB_GUI:dxScrollPaneFocusTo(Elements.Container, Elements.Container_Center)
	exports.BB_GUI:dxScrollPaneFocusTo(Elements.HorizontalPane, Elements.HorizontalPane_Center)

	exports.BB_Login:main()
end

-- Fade Out/In > Opening/Closing App moment.

function FadeOutMenu()
	exports.BB_GUI:dxCreateAnimation(Elements.Menu, "RotateFrontLeft", false, "InQuad", 400)
	exports.BB_GUI:dxSetProperty(Elements.Menu, "Enabled", false)
	
	killTimer(roomTimer)
end

function FadeInMenu()
	exports.BB_GUI:dxCreateAnimation(Elements.Menu, "RotateFrontLeft", true, "OutQuad", 400)
	exports.BB_GUI:dxSetProperty(Elements.Menu, "Enabled", true)
	
	roomTimer = setTimer(updateServerRooms,5000,0)
end

function ToggleMenu(state)
	local offsets = exports.BB_GUI:dxGetRawData(Elements.Container, "cOffsets")
	if (state) then
		exports.BB_GUI:startRender()
		setElementData(localPlayer,"UAG.MenuShown",true)
		
		exports.BB_GUI:dxSetRawData(Elements.Container, "cOffsets", {offsets[1], 0})
		exports.BB_GUI:dxScrollPaneFocusTo(Elements.Container, Elements.Container_Center)
			
		setTimer(function()
			--showPlayerHudComponent("all", false)
			showCursor(true)
		end, 1000,1)
		
		updateServerRooms()
		roomTimer = setTimer(updateServerRooms,5000,0)
	else
		exports.BB_GUI:dxScrollPaneFocusTo(Elements.Container, Elements.Container_Bottom, 'InQuad')
		setTimer(function()
			setElementData(localPlayer,"UAG.MenuShown",false)
		end,1000,1)
		showCursor(false)
		--showPlayerHudComponent("all", true)
		showPlayerHudComponent("crosshair", true)
		showPlayerHudComponent("radio", true)
			
		killTimer(roomTimer)
		
		setTimer(function()
			exports.BB_GUI:stopRender()
		end, 1000,1)
	end
end


-- Forcing the menu to show up or hide, or to return to the home screen.

function Menu.Force(key, state)
	if isMTAWindowActive()	then return end
	if exports.BB_GUI:isUsingDXEdit() then return end
	if isLocked then return end
	if (key == "u") and (state == false) and (not Menu.IsAnimating()) then -- Show/Hide Menu
		if Menu.IsShown() then
			ToggleMenu(false)
		else
			ToggleMenu(true)
		end
	elseif (key == "i") and (state == false) then -- Go to home screen (which includes closing the current app if it's possible.)
		local bool = exports.BB_AppManager:IsRunningApp()
		if bool then
			exports.BB_AppManager:CloseApp() -- Already includes the Fade-back-to-home-menu function & Block if running app is locked (For example the login app)
		else
			exports.BB_GUI:dxScrollPaneFocusTo(Elements.HorizontalPane, Elements.HorizontalPane_Center)
		end
	end
end

-- Check whether the menu is fully shown, or (barely) hidden.

function Menu.IsShown()
	local offsets = exports.BB_GUI:dxGetRawData(Elements.Container, "cOffsets")
	if offsets[2] == g_UIY then 
		setElementData(localPlayer,"UAG.MenuShown",true)
		return true 
	else 
		setElementData(localPlayer,"UAG.MenuShown",false)
		return false 
	end
end

function Menu.IsAnimating()
	local offsets = exports.BB_GUI:dxGetRawData(Elements.Container, "cOffsets")
	if (offsets[2] ~= 0) and (offsets[2] ~= g_UIY) and (offsets[2] ~= g_UIY*2) then
		return true
	else
		return false
	end
end

function createAppWindow(bool)
	if bool == nil then bool = false end
	if type(bool) ~= "boolean" then
		exports.BB_GUI:kickError(18, 'createAppWindow', 1, "boolean")
		return false
	end

	local function alpha() 
		if bool then 
			return 0
		else 
			return 255
		end 
	end

	return exports.BB_GUI:dxCreateTile(0,g_UIY,g_UIX,g_UIY, Elements.Container,false,false,alpha())
end

function changeInput(Point)
	if Point == Elements.Container_Bottom then
		showPlayerHudComponent("all", true)
		showChat(true)
		showCursor(false)
	end
end

function setMenuEnabled(bool)
	isLocked = bool
	exports.BB_GUI:dxSetProperty(Elements.Menu, "Enabled", bool)
end

---------------------------------<
-- *~ Events/Handlings ~*
---------------------------------<

addEventHandler("onClientBlueBirdReady", g_Root, Menu.Load)
addEventHandler("onClientKey", root, Menu.Force)

fileDelete("c_menu.lua")