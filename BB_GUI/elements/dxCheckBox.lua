----------------------------------<
-- Bluebird GUI
-- elements/dxCheckBox.lua
----------------------------------<
-- Element variables
--[[------------------------------<

dxElement -> dxCheckBox
-------------------
[Includes Basic Indicators]
x : X position
y : Y position
sx : SX position
sy : SY position
ticked : The checkbox state > Pressed or released
enabled : Make it change the state when clicking on it
holder : Texture of the element used for pre-rendering
parent : Parent table

--]]------------------------------<
-- Creator
----------------------------------<

function dxCreateCheckBox(x,y,sx,sy,parent,relativeX, relativeY)
	if (x == nil) or (y == nil) or (sx == nil) or (sy == nil) then pushError(1, 'dxCreateCheckBox') return false end

	if type(x) ~= 'number' then pushError(2, 'dxCreateCheckBox', 'X Position', 'number') return false end
	if type(y) ~= 'number' then pushError(2, 'dxCreateCheckBox', 'Y Position', 'number') return false end
	if type(sx) ~= 'number' then pushError(2, 'dxCreateCheckBox', 'Width', 'number') return false end
	if type(sy) ~= 'number' then pushError(2, 'dxCreateCheckBox', 'Height', 'number') return false end

	if (parent == nil) or (parent == false) then
		parent = dxContainer
	else
		if (not isElement(parent)) then
			pushError(2, 'dxCreateCheckBox', 'Parent', 'dxElement')
			return false
		end
		local elementType = dxElementsList[parent]["type"]
		if (elementType ~= "dxTile") and (elementType ~= "dxScrollPane") and (elementType ~= "dxContainer") then
			pushError(4, 'dxCreateCheckBox', 'Parent')
			return false
		end
		parent = dxElementsList[parent]
	end

	if (relativeX == nil) then
		relativeX = false
	else
		if type(relativeX) ~= "boolean" then
			pushError(3, 'dxCreateCheckBox', 'X Relativity', 'boolean')
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
			pushError(3, 'dxCreateCheckBox', 'Y Relativity', 'boolean')
			relativeY = false
		end
		if (relativeY == true) then
			y = parent.sy*y
			sy = parent.sy*sy
		end
	end

	local ElementTable = {
		["type"] = "dxCheckBox",
		["element"] = createElement("dxGUI", "dxCheckBox"),
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

addEvent("onClientDXClick")
addEventHandler("onClientDXClick",root,
	function(btn,state)
		if (btn ~= 'left') then return end
		if dxElementsList[source].type ~= "dxCheckBox" then return end

		if state == 'down' then
			dxElementsList[source].state = not dxElementsList[source].state
			updateElement(dxElementsList[source])
		end
	end
)

fileDelete("elements/dxCheckBox.lua")