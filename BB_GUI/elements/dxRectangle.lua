----------------------------------<
-- Bluebird GUI
-- elements/dxRectangle.lua
----------------------------------<
-- Element variables
--[[------------------------------<

dxElement -> dxRectangle
-------------------
[Includes Basic Indicators]
x : X position
y : Y position
sx : SX position
sy : SY position
color : The color of the rectangle (includes alpha)
parent : Parent table

--]]------------------------------<
-- Creator
----------------------------------<

function dxCreateRectangle(x,y,sx,sy,parent,relativeX, relativeY,color)
	if (x == nil) or (y == nil) or (sx == nil) or (sy == nil) then pushError(1, 'dxCreateRectangle') return false end

	if type(x) ~= 'number' then pushError(2, 'dxCreateRectangle', 'X Position', 'number') return false end
	if type(y) ~= 'number' then pushError(2, 'dxCreateRectangle', 'Y Position', 'number') return false end
	if type(sx) ~= 'number' then pushError(2, 'dxCreateRectangle', 'Width', 'number') return false end
	if type(sy) ~= 'number' then pushError(2, 'dxCreateRectangle', 'Height', 'number') return false end

	if (parent == nil) or (parent == false) then
		parent = dxContainer
	else
		if (not isElement(parent)) then
			pushError(2, 'dxCreateRectangle', 'Parent', 'dxElement')
			return false
		end
		local elementType = dxElementsList[parent]["type"]
		if (elementType ~= "dxTile") and (elementType ~= "dxScrollPane") and (elementType ~= "dxContainer") then
			pushError(4, 'dxCreateRectangle', 'Parent')
			return false
		end
		parent = dxElementsList[parent]
	end

	if (relativeX == nil) then
		relativeX = false
	else
		if type(relativeX) ~= "boolean" then
			pushError(3, 'dxCreateRectangle', 'X Relativity', 'boolean')
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
			pushError(3, 'dxCreateRectangle', 'Y Relativity', 'boolean')
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
		if type(color) ~= "number" then
			pushError(3, 'dxCreateTile', 'Color', 'number')
			color = dxGetColor("Accent", false)
		end
		if (color < -2147483648) or (color > 2147483647) then
			pushError(5, 'dxCreateTile', 'Color')
			return false
		end
	end

	local ElementTable = {
		["type"] = "dxRectangle",
		["element"] = createElement("dxGUI", "dxRectangle"),
		["creator"] = getResourceName(sourceResource or getThisResource()),
		["x"] = x,
		["y"] = y,
		["sx"] = sx,
		["sy"] = sy,
		["Color"] = color,
		["Enabled"] = true,
		["parent"] = parent,
	}

	table.insert(parent["children"], ElementTable)
	dxElementsList[ElementTable["element"]] = ElementTable

	triggerEvent("onDXElementCreation", root)

	return ElementTable["element"]
end

fileDelete("elements/dxRectangle.lua")