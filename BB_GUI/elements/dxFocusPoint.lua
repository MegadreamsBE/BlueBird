----------------------------------<
-- Bluebird GUI
-- elements/dxFocusPoint.lua
----------------------------------<
-- Element variables
--[[------------------------------<

dxElement -> dxFocusPoint
-------------------
[Includes Basic Indicators]
x : X position
y : Y position
parent : Parent table

--]]------------------------------<
-- Creator
----------------------------------<

function dxCreateFocusPoint(x,y,parent,relativeX, relativeY)
	if (x == nil) or (y == nil) then pushError(1, 'dxCreateFocusPoint') return false end

	if type(x) ~= 'number' then pushError(2, 'dxCreateFocusPoint', 'X Position', 'number') return false end
	if type(y) ~= 'number' then pushError(2, 'dxCreateFocusPoint', 'Y Position', 'number') return false end

	if (parent == nil) or (parent == false) then
		parent = dxContainer
	else
		if (not isElement(parent)) then
			pushError(2, 'dxCreateFocusPoint', 'Parent', 'dxElement')
			return false
		end
		local elementType = dxElementsList[parent]["type"]
		if (elementType ~= "dxScrollPane") then
			pushError(4, 'dxCreateFocusPoint', 'Parent')
			return false
		end
		parent = dxElementsList[parent]
	end

	if (relativeX == nil) then
		relativeX = false
	else
		if type(relativeX) ~= "boolean" then
			pushError(3, 'dxCreateFocusPoint', 'X Relativity', 'boolean')
			relativeX = false
		end
		if (relativeX == true) then
			x = parent.sx*x
		end
	end

	if (relativeY == nil) then
		relativeY = false
	else
		if type(relativeY) ~= "boolean" then
			pushError(3, 'dxCreateFocusPoint', 'Y Relativity', 'boolean')
			relativeY = false
		end
		if (relativeY == true) then
			y = parent.sy*y
		end
	end

	local ElementTable = {
		["type"] = "dxFocusPoint",
		["element"] = createElement("dxGUI", "dxFocusPoint"),
		["creator"] = getResourceName(sourceResource or getThisResource()),
		["x"] = x,
		["y"] = y,
		["parent"] = parent,
	}

	table.insert(parent["children"], ElementTable)
	dxElementsList[ElementTable["element"]] = ElementTable

	triggerEvent("onDXElementCreation", root)

	return ElementTable["element"]
end

fileDelete("elements/dxFocusPoint.lua")