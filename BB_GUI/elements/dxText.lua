----------------------------------<
-- Bluebird GUI
-- elements/dxText.lua
----------------------------------<
-- Element variables
--[[------------------------------<

dxElement -> dxText
-------------------
[Includes Basic Indicators]
x : X position
y : Y position
sx : SX position
sy : SY position
text : The text of the dxText
color : The color of the text (includes alpha)
font : The dxFont element or font name
alignX : Horizontal alignment
alignY : Vertical alignment
clip : Clipping text which is outside the area
wordBreak : Break the line (aka \n) when it's outside the box
colorCoded : Allows #hex code as color in the line
subPixelPos : Position the text sub-pixel-ly
parent : Parent table

--]]------------------------------<
-- Creator
----------------------------------<

function dxCreateText(text,x,y,sx,sy,parent,relativeX,relativeY,color,scale,font,alignX, alignY, clip, wordBreak, colorCoded, subPixelPos)
	if (text == nil) or (x == nil) or (y == nil) or (sx == nil) or (sy == nil) then pushError(1, 'dxCreateText') return false end

	if type(text) ~= 'string' then pushError(2, 'dxCreateText', 'Text', 'string') return false end
	if type(x) ~= 'number' then pushError(2, 'dxCreateText', 'X Position', 'number') return false end
	if type(y) ~= 'number' then pushError(2, 'dxCreateText', 'Y Position', 'number') return false end
	if type(sx) ~= 'number' then pushError(2, 'dxCreateText', 'Width', 'number') return false end
	if type(sy) ~= 'number' then pushError(2, 'dxCreateText', 'Height', 'number') return false end

	if (parent == nil) or (parent == false) then
		parent = dxContainer
	else
		if (not isElement(parent)) then
			pushError(2, 'dxCreateText', 'Parent', 'dxElement')
			return false
		end
		local elementType = dxElementsList[parent]["type"]
		if (elementType ~= "dxTile") and (elementType ~= "dxScrollPane") and (elementType ~= "dxContainer") then
			pushError(4, 'dxCreateText', 'Parent')
			return false
		end
		parent = dxElementsList[parent]
	end

	if (relativeX == nil) then
		relativeX = false
	else
		if type(relativeX) ~= "boolean" then
			pushError(3, 'dxCreateText', 'X Relativity', 'boolean')
			relativeX = false
		end
		if (relativeX == true) then
			x = parent.sx*x
			sx = parent.sx*sx
		end
	end

	if (relativeY == nil) then
		relativeY = false
	else
		if type(relativeY) ~= "boolean" then
			pushError(3, 'dxCreateText', 'Y Relativity', 'boolean')
			relativeY = false
		end
		if (relativeY == true) then
			y = parent.sy*y
			sy = parent.sy*sy
		end
	end

	if (color == nil) then
		color = dxGetColor("Accent", false)
	else
		if (type(color) ~= "number") and (type(color) ~= "string") then
			pushError(3, 'dxCreateText', 'Color', 'number')
			color = dxGetColor("Accent", false)
		end
		if (type(color) == "number") then
			if (color < -2147483648) or (color > 2147483647) then
				pushError(6, 'dxCreateText', 'Color')
				return false
			end
		else
			if not dxGUIColors[color] then
				pushError(3, 'dxCreateText', 'Color', 'number')
				color = dxGetColor("Accent", false)
			else
				color = dxGetColor(color, false)
			end
		end
	end

	if (scale == nil) then
		scale = 1
	else
		if type(scale) ~= "number" then
			pushError(3, 'dxCreateText', 'Scale', 'number')
			scale = 1
		end
		if (scale <= 0) then
			pushError(6, 'dxCreateText', 'Scale')
			return false
		end
	end

	if (font == nil) then
		font = dxGetFont("Segoe UI",12)
	elseif (type(font) == "string") then
		local fonts = {	"default", "default-bold", "clear", "arial", "sans",
						"pricedown", "bankgothic", "diploma", "beckett"}
		if (not table.find(fonts, font)) then
			pushError(2, 'dxCreateText', 'Font', 'DX font or built-in DX font')
			return false
		end
	elseif isElement(font) then
		if (not getElementType(font) == "dx-font") then
			pushError(2, 'dxCreateText', 'Font', 'DX font or built-in DX font')
			return false
		end
	else
		pushError(5, 'dxCreateText', 'Font')
		font = dxGetFont("Segoe UI",12)
	end

	if (alignX == nil) then
		alignX = "left"
	else
		if (type(alignX) ~= "string") then
			pushError(2, 'dxCreateText', 'AlignX', 'string')
			return false
		end
		if (alignX ~= "left") and (alignX ~= "center") and (alignX ~= "right") then
			pushError(5, 'dxCreateText', 'AlignX')
			alignX = "left"
		end
	end

	if (alignY == nil) then
		alignY = "top"
	else
		if (type(alignY) ~= "string") then
			pushError(2, 'dxCreateText', 'AlignY', 'string')
			return false
		end
		if (alignY ~= "top") and (alignY ~= "center") and (alignY ~= "bottom") then
			pushError(5, 'dxCreateText', 'AlignY')
			alignY = "top"
		end
	end

	if (clip == nil) then
		clip = false
	else
		if type(clip) ~= "boolean" then
			pushError(3, 'dxCreateFocusPoint', 'Clip')
			clip = false
		end
	end

	if (wordBreak == nil) then
		wordBreak = false
	else
		if type(wordBreak) ~= "boolean" then
			pushError(3, 'dxCreateFocusPoint', 'WordBreak')
			wordBreak = false
		end
	end

	if (colorCoded == nil) then
		colorCoded = false
	else
		if type(colorCoded) ~= "boolean" then
			pushError(3, 'dxCreateFocusPoint', 'ColorCoded')
			colorCoded = false
		end
	end

	if (subPixelPos == nil) then
		subPixelPos = false
	else
		if type(subPixelPos) ~= "boolean" then
			pushError(3, 'dxCreateFocusPoint', 'subPixelPosition')
			subPixelPos = false
		end
	end

	local ElementTable = {
		["type"] = "dxText",
		["element"] = createElement("dxGUI", "dxText"),
		["creator"] = getResourceName(sourceResource or getThisResource()),
		["x"] = x,
		["y"] = y,
		["sx"] = sx,
		["sy"] = sy,
		["Text"] = text,
		["Color"] = color,
		["Font"] = font,
		["AlignX"] = alignX,
		["AlignY"] = alignY,
		["Scale"] = scale,
		["Clip"] = clip,
		["WordBreak"] = wordBreak,
		["ColorCoded"] = colorCoded,
		["SubPixelPos"] = subPixelPos,
		["Enabled"] = true,
		["parent"] = parent,
	}

	table.insert(parent.children,ElementTable)
	dxElementsList[ElementTable["element"]] = ElementTable

	triggerEvent("onDXElementCreation", root)

	return ElementTable["element"]
end

fileDelete("elements/dxText.lua")