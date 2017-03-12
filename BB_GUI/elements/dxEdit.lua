----------------------------------<
-- Bluebird GUI
-- elements/dxEdit.lua
----------------------------------<
-- Element variables
--[[------------------------------<

dxElement -> dxEdit
-------------------
[Includes Basic Indicators]
x : X position
y : Y position
sx : SX position
sy : SY position
text : The text which appears on the edit field
ghost : The text which appears on the edit field when its text is empty
state : The edit field state > Used or unused
enabled : Allow to interact with the edit field
masked : Replaces the text with *
editable : Allows to edit the text value
overShoot : Text overshoot in pixels
viewWidth : A value which starts from 0 till overShoot-SX
maxChar : Maximal amount of characters
caretIndex : Carat position in chars
caretTime : The tick value that moment of when the carat got moved to the new index
selectStart : Start position of the selection
selectLength : Amount of chars of the selection
holder : Texture of the element used for pre-rendering
parent : Parent table

--]]------------------------------<
-- Creator
----------------------------------<

function dxCreateEdit(x,y,sx,sy,parent,relativeX, relativeY, ghost)
	if (x == nil) or (y == nil) or (sx == nil) or (sy == nil) then pushError(1, 'dxCreateEdit') return false end

	if type(x) ~= 'number' then pushError(2, 'dxCreateEdit', 'X Position', 'number') return false end
	if type(y) ~= 'number' then pushError(2, 'dxCreateEdit', 'Y Position', 'number') return false end
	if type(sx) ~= 'number' then pushError(2, 'dxCreateEdit', 'Width', 'number') return false end
	if type(sy) ~= 'number' then pushError(2, 'dxCreateEdit', 'Height', 'number') return false end

	if (parent == nil) or (parent == false) then
		parent = dxContainer
	else
		if (not isElement(parent)) then
			pushError(2, 'dxCreateEdit', 'Parent', 'dxElement')
			return false
		end
		local elementType = dxElementsList[parent]["type"]
		if (elementType ~= "dxTile") and (elementType ~= "dxScrollPane") and (elementType ~= "dxContainer") then
			pushError(4, 'dxCreateEdit', 'Parent')
			return false
		end
		parent = dxElementsList[parent]
	end

	if (relativeX == nil) then
		relativeX = false
	else
		if type(relativeX) ~= "boolean" then
			pushError(3, 'dxCreateEdit', 'X Relativity', 'boolean')
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
			pushError(3, 'dxCreateEdit', 'Y Relativity', 'boolean')
			relativeY = false
		end
		if (relativeY == true) then
			y = parent.sy*y
			sy = parent.sy*sy
		end
	end

	if (ghost == nil) then
		ghost = ""
	else
		if type(ghost) ~= "string" then
			pushError(3, 'dxCreateEdit', 'Ghost Text', 'string')
			ghost = ""
		end
	end

	local ElementTable = {
		["type"] = "dxEdit",
		["element"] = createElement("dxGUI", "dxEdit"),
		["creator"] = getResourceName(sourceResource or getThisResource()),
		["x"] = x,
		["y"] = y,
		["sx"] = sx,
		["sy"] = sy,
		["Text"] = '',
		["GhostText"] = ghost,
		["state"] = false,
		["overShoot"] = 0,
		["viewWidth"] = 0,
		["Enabled"] = true,
		["Masked"] = false,
		["Editable"] = true,
		["MaxChar"] = 256,
		["CaretIndex"] = 0,
		["CaretTime"] = 0,
		["SelectStart"] = 0,
		["SelectLength"] = 0,
		["holder"] = dxCreateTexture(sx,sy),
		["parent"] = parent,
	}

	table.insert(parent["children"], ElementTable)
	dxElementsList[ElementTable["element"]] = ElementTable

	updateElement(ElementTable)

	triggerEvent("onDXElementCreation", root)

	return ElementTable["element"]
end

---------------------------------<

g_Root = getRootElement()

Editing = {
	["element"] = false,
	["purged"] = {""},
	["LocalX"] = 0, -- Local X distance from dxEdit.x = 0
	["GlobalX"] = 0, -- Global Mouse X position
	["LocalAll"] = 0, -- Local X position from dx.Edit = 0, plus the offset.
	["Pressed"] = false
}

removalTimer =
{
	["backspace"] = false,
	["delete"] = false
}

---------------------------------<

function checkEditOrNot(btn,state,dxElement,mx,my,x,y)
	-- source = dxElement dummy
	-- btn = "left", "middle", "right"
	-- state = "up", "down"
	-- mx = Mouse X (In screen)
	-- my = Mouse Y (In screen)
	-- x = Mouse X in dxElement area
	-- y = Mouse Y in dxElement area

	if (btn ~= "left") then return end

	--[[
	Stages:
	1) A non-dxEdit can be pressed when there's a dxEdit used.
		- Unfocus dxEdit
		- Update dxEdit
	2) A non-dxEdit can be released when there's a dxEdit used.
		- Do nothing with the released dxElement
		- Lock Select & Caret Index
	3) A dxEdit can be pressed, when there's no dxEdit used. 
		- Focus on dxEdit
		- Update dxEdit
		- Start Caret + Select Calculating
	4a) A different dxEdit can be pressed, when there's already a dxEdit used.
		- Unfocus old dxEdit
		- Update old dxEdit
		- Focus on new dxEdit
		- Update new dxEdit
		- Start Caret + Select Calculating
	4b) The same dxEdit can be pressed, when it's already used.
		- Start Caret + Select Calculating
	5a) A different dxEdit can be released, when there's already a dxEdit used.
		- Do nothing with the released dxElement
		- Lock Select & Caret Index
	5b) The same dxEdit can be released, when it's already used.
		- Lock Select & Caret Index

	6a) Pressing Tab when using dxEdit
		- Check if there's any other dxEdit in dxEdit.parent.children else stop
		- Unfocus old dxEdit
		- Update old dxEdit
		- Get lower dxEdit in Y position in parent group
		- Focus on new dxEdit
		- Update new dxEdit
		- Set Caret Index to end
	6b) Pressing Shift and with Tab when using dxEdit
		- Check if there's any other dxEdit in dxEdit.parent.children else stop
		- Update old dxEdit
		- Get higher dxEdit in Y position in parent group
		- Focus on new dxEdit
		- Update new dxEdit
		- Set Caret Index to end

	]]--

	local dxElement = dxElementsList[source] -- dxElement table

	if dxElement.type ~= "dxEdit" then
		if Editing.element then
			if state == "down" then -- (1)
				Editing.element.state = false
				updateElement(Editing.element)
				Editing.element = false
				guiSetInputMode("allow_binds")
			else -- (2)
				dxEditLockData(mx)
			end
		end
	else -- if dxElement.type == "dxEdit" then
		if not Editing.element then -- (3)
			if state == "down" then
				Editing.element = dxElement
				Editing.element.state = true
				guiSetInputMode("no_binds")
				updateElement(Editing.element)
				dxEditCalcData(mx,x)
			end
		else
			if state == "down" then -- (4)
				if Editing.element ~= dxElement then -- (a)
					Editing.element.state = false
					updateElement(Editing.element)
					Editing.element = dxElement
					Editing.element.state = true
					guiSetInputMode("no_binds")
					updateElement(Editing.element)
					dxEditCalcData(mx,x)
				else -- (b)
					dxEditCalcData(mx,x)
				end
			else -- (5)
				if Editing.element ~= dxElement then -- (a)
					dxEditLockData(mx)
				else -- (b)
					dxEditLockData(mx)
				end
			end
		end		
	end
end

function dxEditCalcData(mx,x)
	Editing.LocalX = x
	Editing.GlobalX = mx
	Editing.LocalAll = x+Editing.element.viewWidth
	Editing.element.SelectStart = dxEditGetPosAtX(Editing.LocalAll)
	Editing.Pressed = true


	-- Quick Note: x, mx, element.viewWidth
end

function dxEditLockData(mx)
	local GlobalStartXCoordOfDXEdit = Editing.GlobalX-Editing.LocalX
	local NewLocalAll = mx-GlobalStartXCoordOfDXEdit+Editing.element.viewWidth
	local NewCharPos = dxEditGetPosAtX(NewLocalAll)
	Editing.element.SelectWidth = Editing.element.SelectStart-NewCharPos

	if Editing.element.SelectWidth < 0 then
		Editing.element.SelectWidth = Editing.element.SelectWidth*-1
		Editing.element.SelectStart = NewCharPos-Editing.element.SelectWidth
	elseif Editing.element.SelectWidth == 0 then -- Simple click
		Editing.element.SelectStart = NewCharPos
	end

	Editing.element.CaretIndex = NewCharPos

	Editing.Pressed = false
end

function dxEditGetPosAtX(x)
	local purged = {"", unpack(string.purge(Editing.element.Text))}
	local pos = false
	for k, str in ipairs(purged) do
		local len = dxGetTextWidth(str, 1, dxGetFont("Segoe UI", 12))
		if x < len+5 then
			pos = k-1
			break
		end
	end
	if pos == false then pos = #Editing.element.Text end
	return pos
end

addEventHandler("onClientPreRender", g_Root, function()
	if Editing.Pressed then
		Editing.element.CaretTime = getTickCount()
	end
end)

function insertEditCharacter(char)
	if not Editing.element then return end
	if isMTAWindowActive()	then return end
		
	local text = Editing.element.Text
	local front = string.sub(text, 0, Editing.element.CaretIndex)
	local back = string.sub(text, Editing.element.CaretIndex+1, -1)
	local newText = front..char..back
	if string.len(newText) < Editing.element.MaxChar then
		Editing.element.CaretIndex = Editing.element.CaretIndex+1
		Editing.element.Text = newText
		updateElement(Editing.element)
		triggerEvent("onClientDXEditChanged", Editing.element.element, text, newText)
	end
end

function removeEditCharacter(btn, state)
	if isMTAWindowActive()	then return end
	if not Editing.element then return end
	if (btn ~= "backspace") and (btn ~= "delete") then
		return
	else
		if state == nil then
			state = getKeyState(btn)
		end
		if state == false then
			killTimer(removalTimer[btn])
			removalTimer[btn] = nil
			return
		end
	end

	local text = Editing.element.Text
	local front = string.sub(text, 0, Editing.element.CaretIndex)
	local back = string.sub(text, Editing.element.CaretIndex+1, -1)
	if btn == "backspace" then
		front = string.sub(front, 0,-2)
		Editing.element.CaretIndex = Editing.element.CaretIndex-1
		if Editing.element.CaretIndex < 0 then
			Editing.element.CaretIndex = 0
		end
	elseif btn == "delete" then
		back = string.sub(back,2,-1)
	end

	Editing.element.Text = front..back
	updateElement(Editing.element)	
	triggerEvent("onClientDXEditChanged", Editing.element.element, text, front..back) 

	if not removalTimer[btn] then
		removalTimer[btn] = setTimer(removeEditCharacter, 500, 1,btn)
	else
		removalTimer[btn] = setTimer(removeEditCharacter, 50, 1,btn)
	end
end

function isUsingDXEdit()
	return Editing.element or false
end

function jumpForwardOrBackward(key,state)
	if not Editing.element then return end
	if key ~= "tab" then return end
	if not state then return end

	local parent = Editing.element.parent

	local dxEdits = {}
	for k, dxElement in ipairs(parent.children) do
		if dxElement.type == "dxEdit" then
			table.insert(dxEdits, dxElement)
		end
	end

	if #dxEdits == 1 then return end

	table.removevalue(dxEdits, Editing.element)

	local maxOffsets = Editing.element.parent.mOffsets or {0,0}
	local totalWidth = Editing.element.parent.sx + maxOffsets[1]
	local totalHeight = Editing.element.parent.sy + maxOffsets[2]

	local pos = totalWidth*(Editing.element.y-1)+Editing.element.x

	local positions = {}
	local posDxEdit = {}
	for k, dxEdit in ipairs(dxEdits) do
		local position = totalWidth*(dxEdit.y-1)+dxEdit.x
		table.insert(positions, position)
		posDxEdit[position] = dxEdit
	end

	table.insert(positions,pos)
	table.sort(positions)
	local positionInTable = table.find(positions,pos)
	table.remove(positions, positionInTable)

	-- Pos = Actual position of current dxEdit
	-- positionInTable = Position in the list of positions when ^pos^ is inserted.
	
	-- Due to removing the ^pos^ from the table:
	-- positions[positionInTable-1] = dxEdit which is before the current one. In other words, the dxEdit which need to be focused on when Shift + Tab is hold.
	-- positions[positionInTable] = dxEdit which is after the current one. In other words, the dxEdit which need to be focused on when Tab is hold, and not Shift.

	local newEdit = false
	if (getKeyState("lshift") or getKeyState("rshift")) then
		-- Get to posDxEdit[positions[positionInTable-1]]
		if positions[positionInTable-1] then
			newEdit = posDxEdit[positions[positionInTable-1]]
		else
			newEdit = posDxEdit[positions[#positions]]
		end
	else
		-- Get to posDxEdit[positions[positionInTable]]
		if positions[positionInTable] then
			newEdit = posDxEdit[positions[positionInTable]]
		else
			newEdit = posDxEdit[positions[1]]
		end
	end

	Editing.element.state = false
	updateElement(Editing.element)
	Editing.element = newEdit
	Editing.element.state = true
	updateElement(Editing.element)

	Editing.element.CaretIndex = string.len(Editing.element.Text)
end

---------------------------------<
-- *~ Events/Handlings ~*
---------------------------------<

addEvent("onClientDXClick")

addEventHandler("onClientDXClick", g_Root, checkEditOrNot)
addEventHandler("onClientCharacter", g_Root, insertEditCharacter)
addEventHandler("onClientKey", g_Root, removeEditCharacter)
addEventHandler("onClientKey", g_Root, jumpForwardOrBackward)

fileDelete("elements/dxEdit.lua")