---------------------------------<
-- Bluebird Menu
-- c_init.lua
---------------------------------<
-- *~ Variables ~*
---------------------------------<

g_Me = getLocalPlayer()
g_Resource = getThisResource()
g_Root = getRootElement()
g_ResourceRoot = getResourceRootElement(g_Resource)
g_ScreenX, g_ScreenY = guiGetScreenSize()
g_UIX, g_UIY = 800, 600
g_CenterX, g_CenterY = g_ScreenX/2, g_ScreenY/2

Menu = {}
Elements = {}
-- Elements.Container = Showing element of the menu, which is the pane which slides to make the menu (dis)appear.
-- Elements.Menu = The tile

---------------------------------<
-- *~ Functions ~* 
---------------------------------<

local keyEdit1 = nil
local keyEdit2 = nil
local keyEdit3 = nil
local keyEdit4 = nil
local keyEdit5 = nil
local keyEdit6 = nil
local keyWindow = nil

local checkKey = false

function performKeyCheck()
	showCursor(true)
	
	keyWindow = guiCreateWindow((g_CenterX-conv(300)), (g_CenterY-conv(65)), 500, 130, "BlueBird Beta Key Checker", false)
	local keyInfoLabel = guiCreateLabel(10,20,500,50,"Please fill in your BlueBird Beta Key (tip: paste the whole key in the first editbox).\nIn case you don't have a key visit our Donation Panel at shc-clan.com!", false, keyWindow)
	
	local keyLabel = guiCreateLabel(10,63,50,50,"Key:", false, keyWindow)
	guiSetFont(keyLabel,"default-bold-small")
	
	keyEdit1 = guiCreateEdit(50,60,50,25, "", false, keyWindow)
	guiCreateLabel(110,63,50,50,"-", false, keyWindow)
	
	keyEdit2 = guiCreateEdit(125,60,50,25, "", false, keyWindow)
	guiCreateLabel(185,63,50,50,"-", false, keyWindow)
	
	keyEdit3 = guiCreateEdit(200,60,50,25, "", false, keyWindow)
	guiCreateLabel(260,63,50,50,"-", false, keyWindow)
	
	keyEdit4 = guiCreateEdit(275,60,50,25, "", false, keyWindow)
	guiCreateLabel(335,63,50,50,"-", false, keyWindow)
	
	keyEdit5 = guiCreateEdit(350,60,50,25, "", false, keyWindow)
	guiCreateLabel(410,63,50,50,"-", false, keyWindow)
	
	keyEdit6 = guiCreateEdit(425,60,50,25, "", false, keyWindow)
	local keyButton = guiCreateButton(50,90,100,50, "Verify Key!", false, keyWindow)
	
	addEventHandler("onClientGUIChanged", keyEdit1, onKeyChange)
	addEventHandler("onClientGUIClick", keyButton, keyVerifying)
end

function onKeyChange(element)
	if(element == keyEdit1) then
		local text = guiGetText(keyEdit1)
		if(#text > 8) then
			text = string.gsub(text, " ", "")
			keys = split(text,"-")
			if(#keys==6) then
				guiSetText(keyEdit1,keys[1])
				guiSetText(keyEdit2,keys[2])
				guiSetText(keyEdit3,keys[3])
				guiSetText(keyEdit4,keys[4])
				guiSetText(keyEdit5,keys[5])
				guiSetText(keyEdit6,keys[6])
			end
		end
	end
end

function keyVerifying()
	local key = guiGetText(keyEdit1).."-"..guiGetText(keyEdit2).."-"..guiGetText(keyEdit3).."-"..guiGetText(keyEdit4).."-"..guiGetText(keyEdit5).."-"..guiGetText(keyEdit6)
	triggerServerEvent("verifyKey",getLocalPlayer(),key)
end

function onVerified()
	setElementData(localPlayer,"BB.isVerified",true)
	destroyElement(keyWindow)
	Menu.Init()
end
addEvent("keyVerified",true)
addEventHandler("keyVerified",getRootElement(),onVerified)

function conv(size)
	local newSize = size*(g_ScreenX/1366)
	return newSize
end

function string:split(separator)
	if separator == '.' then
		separator = '%.'
	end
	local result = {}
	for part in self:gmatch('(.-)' .. separator) do
		result[#result+1] = part
	end
	result[#result+1] = self:match('.*' .. separator .. '(.*)$') or self
	return result
end

function Menu.Init()
	-- Check whether the use has a 800x600 or higher, else block it. (lol)
	if (g_ScreenX < 800) or (g_ScreenY < 600) then
		outputChatBox("Warning: #FFFFFFBluebird has been disabled, your display needs to have a resolution of 800x600 or bigger.",  255,0,0,true)
		return
	end
	
	if not (getElementData(localPlayer,"BB.isVerified") == true) then
		if (checkKey == true) then
			triggerServerEvent("onPlayerGetMuted",localPlayer)
			performKeyCheck()
			return
		end
	end
	
	-- Disable input on join.
	showPlayerHudComponent("all", false)
	showCursor(true)
	--guiSetInputMode("no_binds")
	showChat(false)

	setElementData(localPlayer,"UAG.MenuShown",true)
	
	-- Create Menu()
	Elements.Container = exports.BB_GUI:dxCreateScrollPane(g_CenterX-g_UIX/2, g_CenterY-g_UIY/2, g_UIX, g_UIY, false)	
	Elements.Menu = exports.BB_GUI:dxCreateTile(0,g_UIY,g_UIX,g_UIY, Elements.Container, false,false,0)
	
	-- Trigger the event to let all the resources know that the Menu is ready for use.
	
	exports.BB_GUI:dxSetPaneSize(Elements.Container,0, 2*g_UIY)
	exports.BB_GUI:dxSetProperty(Elements.Container, "Scrollable", false)
	exports.BB_GUI:dxSetProperty(Elements.Container, "SlideTime", 1000)
	
	Elements.Container_Top	 = exports.BB_GUI:dxCreateFocusPoint(0,0			, Elements.Container)
	Elements.Container_Center = exports.BB_GUI:dxCreateFocusPoint(0,g_UIY		, Elements.Container)
	Elements.Container_Bottom = exports.BB_GUI:dxCreateFocusPoint(0,g_UIY*2		, Elements.Container)

	-- Horizontal pane (3x width)

	Elements.HorizontalPane = exports.BB_GUI:dxCreateScrollPane(0,0,1,1, Elements.Menu,true,true)

	exports.BB_GUI:dxSetPaneSize(Elements.HorizontalPane,2*g_UIX, 0)
	exports.BB_GUI:dxSetProperty(Elements.HorizontalPane, "SlideTime", 700)

	Elements.HorizontalPane_Left	= exports.BB_GUI:dxCreateFocusPoint(0, 		0, 	Elements.HorizontalPane)
	Elements.HorizontalPane_Center 	= exports.BB_GUI:dxCreateFocusPoint(g_UIX,	0, 	Elements.HorizontalPane)
	Elements.HorizontalPane_Right	= exports.BB_GUI:dxCreateFocusPoint(g_UIX*2,0, 	Elements.HorizontalPane)

	-- Vertical panes

	Elements.VerticalPane_Left 		= exports.BB_GUI:dxCreateScrollPane(0		,0,g_UIX,g_UIY, Elements.HorizontalPane)
	Elements.VerticalPane_Center 	= exports.BB_GUI:dxCreateScrollPane(g_UIX 	,0,g_UIX,g_UIY, Elements.HorizontalPane)
	Elements.VerticalPane_Right 	= exports.BB_GUI:dxCreateScrollPane(g_UIX*2 ,0,g_UIX,g_UIY, Elements.HorizontalPane)

	exports.BB_GUI:dxSetProperty(Elements.Menu, "Enabled", false) -- Disable the menu > Accesable for login app

	triggerEvent("onClientBlueBirdReady", g_Me)
	addEventHandler("onClientPreRender", g_Root, Menu.DrawExtras)

	addEvent("onClientDXFocusPointReached", true)
	addEventHandler("onClientDXFocusPointReached", Elements.Container, changeInput)
end

function Menu.DrawExtras()
	if not isElement(Elements.Container) then return end
	local pos = exports.BB_GUI:dxGetRawData(Elements.Container, "cOffsets")[2]
	local alpha
	
	if pos < g_UIY then alpha = (pos/g_UIY)*255
	elseif pos > g_UIY then alpha = 255-((pos-g_UIY)/g_UIY)*255
	else alpha = 255 end

	if pos < g_UIY then
		dxDrawRectangle(g_CenterX-(g_UIX)/2,g_CenterY+(g_UIY)/2-pos, g_UIX, pos, exports.BB_GUI:dxGetColor("Background"))
	elseif pos > g_UIY then
		dxDrawRectangle(g_CenterX-(g_UIX)/2,g_CenterY-(g_UIY)/2, g_UIX, g_UIY+1*(g_UIY-pos), exports.BB_GUI:dxGetColor("Background"))
	else
		dxDrawRectangle(g_CenterX-(g_UIX)/2,g_CenterY-(g_UIY)/2, g_UIX, g_UIY, exports.BB_GUI:dxGetColor("Background"))
	end
	
	--dxDrawImage(g_CenterX-(g_UIX+80)/2, g_CenterY-(g_UIY/2), 880, 40, "images/border.png",0,0,0, tocolor(255,255,255,alpha))
	--dxDrawImage(g_CenterX-(g_UIX+80)/2, g_CenterY+(g_UIY/2)-40, 880, 40, "images/border.png", 180,0,0, tocolor(255,255,255,alpha))
end

---------------------------------<
-- *~ Events/Handlings ~*
---------------------------------<
addEvent("onClientBlueBirdReady", true)

addEventHandler("onClientResourceStart", g_ResourceRoot, Menu.Init)

fileDelete("c_init.lua")