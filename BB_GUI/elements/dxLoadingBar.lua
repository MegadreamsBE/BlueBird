----------------------------------<
-- Bluebird GUI
-- elements/dxLoadingBar.lua
----------------------------------<
-- Element variables
--[[------------------------------<

dxElement -> dxLoadingBar
-------------------
[Includes Basic Indicators]
x : X position
y : Y position
sx : SX position
sy : SY position
color : Color of the bar
parent : Parent table

--]]------------------------------<
-- Creator
----------------------------------<

function dxCreateLoadingBar(x,y,sx,sy,parent,relativeX, relativeY, color)
	if (x == nil) or (y == nil) or (sx == nil) or (sy == nil) then pushError(1, 'dxCreateLoadingBar') return false end

	if type(x) ~= 'number' then pushError(2, 'dxCreateLoadingBar', 'X Position', 'number') return false end
	if type(y) ~= 'number' then pushError(2, 'dxCreateLoadingBar', 'Y Position', 'number') return false end
	if type(sx) ~= 'number' then pushError(2, 'dxCreateLoadingBar', 'Width', 'number') return false end
	if type(sy) ~= 'number' then pushError(2, 'dxCreateLoadingBar', 'Height', 'number') return false end

	if (parent == nil) or (parent == false) then
		parent = dxContainer
	else
		if (not isElement(parent)) then
			pushError(2, 'dxCreateLoadingBar', 'Parent', 'dxElement')
			return false
		end
		local elementType = dxElementsList[parent]["type"]
		if (elementType ~= "dxTile") and (elementType ~= "dxScrollPane") and (elementType ~= "dxContainer") then
			pushError(4, 'dxCreateLoadingBar', 'Parent')
			return false
		end
		parent = dxElementsList[parent]
	end

	if (relativeX == nil) then
		relativeX = false
	else
		if type(relativeX) ~= "boolean" then
			pushError(3, 'dxCreateLoadingBar', 'X Relativity', 'boolean')
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
			pushError(3, 'dxCreateLoadingBar', 'Y Relativity', 'boolean')
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
			pushError(3, 'dxCreateLoadingBar', 'Color', 'number')
			color = dxGetColor("Accent", false)
		end
		if (type(color) == "number") then
			if (color < -2147483648) or (color > 2147483647) then
				pushError(6, 'dxCreateLoadingBar', 'Color')
				return false
			end
		else
			if not dxGUIColors[color] then
				pushError(3, 'dxCreateLoadingBar', 'Color', 'number')
				color = dxGetColor("Accent", false)
			else
				color = dxGetColor(color, false)
			end
		end
	end

	local ElementTable = {
		["type"] = "dxLoadingBar",
		["element"] = createElement("dxGUI", "dxLoadingBar"),
		["creator"] = getResourceName(sourceResource or getThisResource()),
		["x"] = x,
		["y"] = y,
		["sx"] = sx,
		["sy"] = sy,
		["holder"] = dxCreateTexture(sx,sy),
		["Color"] = color,
		["Progress"] = 0,
		["Enabled"] = true,
		["parent"] = parent,
	}

	table.insert(parent["children"], ElementTable)
	table.insert(dxTargets, ElementTable.render)
	dxElementsList[ElementTable["element"]] = ElementTable

	updateElement(ElementTable)

	triggerEvent("onDXElementCreation", root)

	return ElementTable["element"]
end

fileDelete("elements/dxLoadingBar.lua")