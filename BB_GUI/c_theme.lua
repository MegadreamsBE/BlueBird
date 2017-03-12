----------------------------------<
-- Bluebird GUI
-- c_render.lua
----------------------------------<

addEvent("onClientDXColorChange")

----------------------------------<

dxGUIFonts = {
['Segoe UI'] = 'segoeui', 
['Segoe UI Light'] = 'segoeuil',
['Segoe UI Semibold'] = 'seguisb'}

dxGUIStandardFonts = {
['Tahoma'] = 'default',
['Tahoma Bold'] = 'default-bold',
['Verdana'] = 'clear',
['Arial'] = 'arial',
['Comic Sans'] = 'sans',
['Pricedown'] = 'pricedown',
['Bank Gothic'] = 'bankgothic',
['Diploma'] = 'diploma',
['Becket'] = 'beckett',
'default', 'default-bold',
'clear', 'arial', 'sans', 'pricedown', 'bankgothic',
'diploma', 'beckett'}

local dxGUIFontsAvailable = {}

---------------------------------<
-- Functions
---------------------------------<

function dxGetFont(fontName, pixels)
	if type(fontName) ~= 'string' then
		pushError(2, 'dxGetFont', "Font Name", "string")
		return false
	end

	if type(pixels) ~= 'number' then
		pushError(2, 'dxGetFont', "Size", "number")
		return false
	end

	pixels = math.ceil(pixels)

	local fontFile = dxGUIFonts[fontName]
	if not fontFile then
		pushError(4, 'dxGetFont', "Font Name")
		return false
	end
	if pixels < 0 then
		pushError(4, 'dxGetFont', "Size")
		return false
	end
	--[[if pixels > 75 then
		pushError(16, 'dxGetFont')
		return false
	end]]

	-- Store the font if some other script wants to use the SAME font with the SAME pixels.
	if not dxGUIFontsAvailable[fontFile] then
		dxGUIFontsAvailable[fontFile] = {}
	end
	if not dxGUIFontsAvailable[fontFile][pixels] then
		dxGUIFontsAvailable[fontFile][pixels] = dxCreateFont("fonts/"..fontFile..".ttf", pixels)
	end

	-- Return the font with that amount of pixels.
	return dxGUIFontsAvailable[fontFile][pixels]
end

-- Little preset for @ rendering of the dxEdit
dxEditFontHeight = dxGetFontHeight(1,dxGetFont("Segoe UI", 12) )
--

function resetColor()
	dxGUIColors = {}
	dxGUIColorCodes = {}

	dxGUIColors["Accent"] = tocolor(27,161,226,255)
	dxGUIColors["Background"] = tocolor(20,20,20,255)
	dxGUIColors["Text"] = tocolor(255,255,255,255)
	dxGUIColors["Description"] = tocolor(128,128,128,255)
	dxGUIColors["Inverted Text"] = tocolor(0,0,0,255)
	dxGUIColors["Unfocused"] = tocolor(200,200,200,255)

	dxGUIColorCodes["Accent"] = {27,161,226,255}
	dxGUIColorCodes["Background"] = {20,20,20,255}
	dxGUIColorCodes["Text"] = {255,255,255,255}
	dxGUIColorCodes["Description"] = {128,128,128,255}
	dxGUIColorCodes["Inverted Text"] = {0,0,0,255}
	dxGUIColorCodes["Unfocused"] = {200,200,200,255}
end

function dxGetColor(color, bool)
	-- if bool == false > return tocolor(color)

	if not dxGUIColors[color] then
		pushError(4, 'dxGetColor', "Color Name")
		return false
	end

	if (not bool) or (type(bool) ~= 'boolean') then
		return dxGUIColors[color]
	else
		return unpack(dxGUIColorCodes[color])
	end
end

function dxSetColor(color, r,g,b,a)
	-- r can be Red or tocolor()

	if not dxGUIColors[color] then
		pushError(4, 'dxSetColor', "Color Name")
		return false
	end

	if type(r) ~= "number" then
		pushError(2, 'dxSetColor', "Red/HEX")
		return false
	end

	if (type(g) == 'number') and (type(b) == 'number') and (type(a) == 'number') then
		if (r < 0) or (r > 255) or (g < 0) or (g > 255) or (b < 0) or (b > 255) or (a < 0) or (a > 255) then
			pushError(4, 'dxSetColor', "RGBA")
			return false
		end

		dxGUIColors[color] = tocolor(r,g,b,a)
		dxGUIColorCodes[color] = {r,g,b,a}

		triggerEvent("onClientDXColorChange", g_Root, color, r,g,b,a)
	else
		if (r < -2147483648) or (r > 2147483647) then
			pushError(4, 'dxSetColor', "HEX")
			return false
		end
		dxGUIColors[color] = r
		local r,g,b,a = fromcolor(color)
		dxGUIColorCodes[color] = {r,g,b,a} 
		triggerEvent("onClientDXColorChange", g_Root, color, r,g,b,a)
	end
end

---------------------------------<
-- *~ Events/Handlings ~*
---------------------------------<

addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()), resetColor)

fileDelete("c_theme.lua")