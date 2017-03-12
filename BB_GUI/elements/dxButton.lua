----------------------------------<
-- Bluebird GUI
-- elements/dxButton.lua
----------------------------------<
-- Element variables
--[[------------------------------<

dxElement -> dxButton
-------------------
[Includes Basic Indicators]
x : X position
y : Y position
sx : SX position
sy : SY position
text : The text which appears on the button
state : The button state > Pressed or released
enabled : Make it change the state when clicking on it
holder : Texture of the element used for pre-rendering
parent : Parent table

--]]------------------------------<
-- Creator
----------------------------------<

function dxCreateButton(x,y,sx,sy,text,parent,relativeX, relativeY)
	if (x == nil) or (y == nil) or (sx == nil) or (sy == nil) or (text == nil) then pushError(1, 'dxCreateButton') return false end

	if type(x) ~= 'number' then pushError(2, 'dxCreateButton', 'X Position', 'number') return false end
	if type(y) ~= 'number' then pushError(2, 'dxCreateButton', 'Y Position', 'number') return false end
	if type(sx) ~= 'number' then pushError(2, 'dxCreateButton', 'Width', 'number') return false end
	if type(sy) ~= 'number' then pushError(2, 'dxCreateButton', 'Height', 'number') return false end
	if type(text) ~= 'string' then pushError(2, 'dxCreateButton', 'Text', 'string') return false end

	if (parent == nil) or (parent == false) then
		parent = dxContainer
	else
		if (not isElement(parent)) then
			pushError(2, 'dxCreateButton', 'Parent', 'dxElement')
			return false
		end
		local elementType = dxElementsList[parent]["type"]
		if (elementType ~= "dxTile") and (elementType ~= "dxScrollPane") and (elementType ~= "dxContainer") then
			pushError(4, 'dxCreateButton', 'Parent')
			return false
		end
		parent = dxElementsList[parent]
	end

	if (relativeX == nil) then
		relativeX = false
	else
		if type(relativeX) ~= "boolean" then
			pushError(3, 'dxCreateButton', 'X Relativity', 'boolean')
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
			pushError(3, 'dxCreateButton', 'Y Relativity', 'boolean')
			relativeY = false
		end
		if (relativeY == true) then
			y = parent.sy*y
			sy = parent.sy*sy
		end
	end

	local ElementTable = {
		["type"] = "dxButton",
		["element"] = createElement("dxGUI", "dxButton"),
		["creator"] = getResourceName(sourceResource or getThisResource()),
		["x"] = x,
		["y"] = y,
		["sx"] = sx,
		["sy"] = sy,
		["Text"] = text,
		["State"] = false,
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

local ButtonPressed = false

addEvent("onClientDXClick")
addEventHandler("onClientDXClick",root,
	function(btn,state)
		if (btn ~= 'left') then return end

		if (state == 'down') and ( dxElementsList[source].type == "dxButton") then
			ButtonPressed = source
			dxElementsList[source].State = true
			updateElement(dxElementsList[source])
		elseif state == 'up' then
			if ButtonPressed then
				dxElementsList[ButtonPressed].State = false
				updateElement(dxElementsList[ButtonPressed])
				ButtonPressed = false
			end
		end
	end
)

fileDelete("elements/dxButton.lua")