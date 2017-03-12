----------------------------------<
-- Bluebird GUI
-- elements/dxRadioButton.lua
----------------------------------<
-- Element variables
--[[------------------------------<

dxElement -> dxRadioButton
-------------------
[Includes Basic Indicators]
x : X position
y : Y position
sx : SX position
sy : SY position
state : The radiobutton state > Pressed or released
enabled : Make it change the state when clicking on it
holder : Texture of the element used for pre-rendering
parent : Parent table

--]]------------------------------<
-- Creator
----------------------------------<

function dxCreateRadioButton(x,y,sx,sy,parent,relativeX, relativeY)
	if (x == nil) or (y == nil) or (sx == nil) or (sy == nil) then pushError(1, 'dxCreateRadioButton') return false end

	if type(x) ~= 'number' then pushError(2, 'dxCreateRadioButton', 'X Position', 'number') return false end
	if type(y) ~= 'number' then pushError(2, 'dxCreateRadioButton', 'Y Position', 'number') return false end
	if type(sx) ~= 'number' then pushError(2, 'dxCreateRadioButton', 'Width', 'number') return false end
	if type(sy) ~= 'number' then pushError(2, 'dxCreateRadioButton', 'Height', 'number') return false end

	if (parent == nil) or (parent == false) then
		parent = dxContainer
	else
		if (not isElement(parent)) then
			pushError(2, 'dxCreateRadioButton', 'Parent', 'dxElement')
			return false
		end
		local elementType = dxElementsList[parent]["type"]
		if (elementType ~= "dxTile") and (elementType ~= "dxScrollPane") and (elementType ~= "dxContainer") then
			pushError(4, 'dxCreateRadioButton', 'Parent')
			return false
		end
		parent = dxElementsList[parent]
	end

	if (relativeX == nil) then
		relativeX = false
	else
		if type(relativeX) ~= "boolean" then
			pushError(3, 'dxCreateRadioButton', 'X Relativity', 'boolean')
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
			pushError(3, 'dxCreateRadioButton', 'Y Relativity', 'boolean')
			relativeY = false
		end
		if (relativeY == true) then
			y = parent.sy*y
			sy = parent.sy*sy
		end
	end

	local ElementTable = {
		["type"] = "dxRadioButton",
		["element"] = createElement("dxGUI", "dxRadioButton"),
		["creator"] = getResourceName(sourceResource or getThisResource()),
		["x"] = x,
		["y"] = y,
		["sx"] = sx,
		["sy"] = sy,
		["Ticked"] = false,
		["Enabled"] = true,
		["holder"] = dxCreateTexture(sx,sy),
		["parent"] = parent,
	}

	table.insert(parent["children"], ElementTable)
	dxElementsList[ElementTable["element"]] = ElementTable

	updateElement(ElementTable)

	triggerEvent("onDXElementCreation", root)

	return ElementTable["element"]
end

fileDelete("elements/dxRadioButton.lua")