----------------------------------<
-- Bluebird GUI
-- elements/dxScrollPane.lua
----------------------------------<
-- Element variables
--[[------------------------------<

dxElement -> dxScrollPane
-------------------
[Includes Basic Indicators]
x : X position
y : Y position
sx : SX position
sy : SY position
render : Drawing target for its children
cOffsets : Current Offsets
mOffsets : Maximal Offsets
autoFocus : Indicates whether the scrollpane has to focus on dxFocusPoints automaticly.
afterMovement : Let the scrollpane move after swiping it.
scrollable : Unable to drag it by move, but still possible with dxFocusPoint focusing.
slideTime : Total time it takes to focus on a dxFocusPoint.
parent : Parent table
children : Children container

--]]------------------------------<
-- Creator
----------------------------------<

function dxCreateScrollPane(x,y,sx,sy,parent,relativeX, relativeY)
	if (x == nil) or (y == nil) or (sx == nil) or (sy == nil) then pushError(1, 'dxCreateScrollPane') return false end

	if type(x) ~= 'number' then pushError(2, 'dxCreateScrollPane', 'X Position', 'number') return false end
	if type(y) ~= 'number' then pushError(2, 'dxCreateScrollPane', 'Y Position', 'number') return false end
	if type(sx) ~= 'number' then pushError(2, 'dxCreateScrollPane', 'Width', 'number') return false end
	if type(sy) ~= 'number' then pushError(2, 'dxCreateScrollPane', 'Height', 'number') return false end

	if (parent == nil) or (parent == false) then
		parent = dxContainer
	else
		if (not isElement(parent)) then
			pushError(2, 'dxCreateScrollPane', 'Parent', 'dxElement')
			return false
		end
		local elementType = dxElementsList[parent]["type"]
		if (elementType ~= "dxTile") and (elementType ~= "dxScrollPane") and (elementType ~= "dxContainer") then
			pushError(4, 'dxCreateScrollPane', 'Parent')
			return false
		end
		parent = dxElementsList[parent]
	end

	if (relativeX == nil) then
		relativeX = false
	else
		if type(relativeX) ~= "boolean" then
			pushError(3, 'dxCreateScrollPane', 'X Relativity', 'boolean')
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
			pushError(3, 'dxCreateScrollPane', 'Y Relativity', 'boolean')
			relativeY = false
		end
		if (relativeY == true) then
			y = parent.sy*y
			sy = parent.sy*sy
		end
	end

	local ElementTable = {
		["type"] = "dxScrollPane",
		["element"] = createElement("dxGUI", "dxScrollPane"),
		["creator"] = getResourceName(sourceResource or getThisResource()),
		["x"] = x,
		["y"] = y,
		["sx"] = sx,
		["sy"] = sy,
		["cOffsets"] = {0,0},
		["mOffsets"] = {0,0},
		["AutoFocus"] = true,
		["AfterMovement"] = true,
		["Scrollable"] = true,
		["SlideTime"] = 500,
		["BlockChildren"] = false,
		["parent"] = parent,
		["Enabled"] = true,
		["render"] = dxCreateRenderTarget(sx,sy,true),
		["children"] = {}
	}

	table.insert(parent["children"], 1,ElementTable)
	table.insert(dxTargets, ElementTable.render)
	dxElementsList[ElementTable["element"]] = ElementTable

	triggerEvent("onDXElementCreation", root)

	return ElementTable["element"]
end

fileDelete("elements/dxScrollPane.lua")