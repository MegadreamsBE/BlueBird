----------------------------------<
-- Bluebird GUI
-- c_scroll.lua
----------------------------------<

addEvent("onClientDXFocusPointReached")

g_Root = getRootElement()

SlowDown = {}
SlowDown.__index = SlowDown

SlowDown.all = {}
SlowDown.panes = {}

sessionID = 0

local Easings = {"Linear",
"InQuad", "OutQuad", "InOutQuad","OutInQuad",
"InElastic", "OutElastic", "InOutElastic", "OutInElastic",
"InBack", "OutBack", "InOutBack", "OutInBack",
"InBounce", "OutBounce", "InOutBounce", "OutInBounce"}

---------------------------------<
-- *~ Functions ~*
---------------------------------<

-- It's possible to use createScrollPaneSlowDownSession for Edit fields, the ElementID doesn't matter.

function createScrollPaneSlowDownSession(scrollPane, speedX, speedY, tick, easing)
	SlowDown.new(scrollPane, speedX, speedY, tick, easing)
end

function stopScrollPaneSlowDownSession(pane)
	triggerEvent("onClientDXScrollPaneHold", pane.pane)
	if SlowDown.panes[pane] then
		SlowDown.stop(SlowDown.panes[pane])
	end
end

function isSlowDownPlaying(pane)
	if SlowDown.panes[pane] then
		return true
	else
		return false
	end
end

function SlowDown.new(scrollPane, speedX, speedY, tick, easing)
	if SlowDown.panes[scrollPane] then
		SlowDown.stop(SlowDown.panes[scrollPane])
	end
	local id = getNewSessionID()
	local session
	if scrollPane.AutoFocus then
		local newX, newY, dxFocusPoint = getClosestFocusPoint(scrollPane, speedX, speedY)
		local duration = scrollPane.SlideTime
		session = setmetatable({offsets = {scrollPane.cOffsets[1], scrollPane.cOffsets[2], scrollPane.mOffsets[1], scrollPane.mOffsets[2]}, sx = newX, sy = newY, tick = tick, time = duration, pane = scrollPane, id = id, point = dxFocusPoint, easing = easing}, SlowDown)
		triggerEvent("onClientDXFocusPointStart", session.pane.element, session.point)
	else
		session = setmetatable({offsets = {scrollPane.cOffsets[1], scrollPane.cOffsets[2], scrollPane.mOffsets[1], scrollPane.mOffsets[2]}, sx = speedX*0.3, sy = speedY*0.3, tick = tick, time = 3000, pane = scrollPane, id = id, easing = easing}, SlowDown)
	end
	table.insert(SlowDown.all, session)
	SlowDown.panes[scrollPane] = session
end

function SlowDown.stop(session,bool)
	if type(session) == "userdata" then
		session = SlowDown.panes[session] -- Fix it*
	end
	table.removevalue(SlowDown.all, session)
	SlowDown.panes[session.pane] = nil
end

function SlowDown.toEnd(session)
	local startX = session.offsets[1]
	local startY = session.offsets[2]
	local maxX = session.offsets[3]
	local maxY = session.offsets[4]

	local newX = startX - session.sx
	local newY = startY - session.sy

	if newX < 0 then newX = 0 end
	if newX > maxX then newX = maxX end
	if newY < 0 then newY = 0 end
	if newY > maxY then newY = maxY end

	session.pane.cOffsets = {newX, newY}
end

function updateSlowDowns()
	for id, session in ipairs(SlowDown.all) do
		local tick = getTickCount()
		local length = (tick - session.tick)/1000
		local prog = length/(session.time/1000)

		if length <= (session.time/1000) then
			local startX = session.offsets[1]
			local startY = session.offsets[2]
			local maxX = session.offsets[3]
			local maxY = session.offsets[4]

			local easing
			if not session.easing then 
				easing = getEasingValue(prog, "OutQuad")
			else
				easing = getEasingValue(prog, session.easing)
			end

			local addX = easing*(session.sx)
			local addY = easing*(session.sy)
			
			local newX = startX - addX
			local newY = startY - addY

			if newX < 0 then newX = 0 end
			if newX > maxX then newX = maxX end
			if newY < 0 then newY = 0 end
			if newY > maxY then newY = maxY end

			session.pane.cOffsets = {newX, newY}
		else
			if session.point then
				triggerEvent("onClientDXFocusPointReached", session.pane.element, session.point)
			end
			SlowDown.toEnd(session)
			SlowDown.stop(session,true)
		end
	end
end

function getClosestFocusPoint(scrollPane, speedX, speedY)
	local offsets = {scrollPane.cOffsets[1], scrollPane.cOffsets[2], scrollPane.mOffsets[1], scrollPane.mOffsets[2]}
	local newX = offsets[1]-speedX
	local newY = offsets[2]-speedY

	if newX < 0 then newX = 0 end
	if newX > offsets[3] then newX = offsets[3] end
	if newY < 0 then newY = 0 end
	if newY > offsets[4] then newY = offsets[4] end

	local focusPoints = {}
	local focusPointsDistances = {}

	for k, dxElement in ipairs(scrollPane.children) do
		if dxElement.type == "dxFocusPoint" then
			local x,y = dxElement.x, dxElement.y
			local distance = math.floor(math.sqrt(  ((newX-x)^2)  +  ((newY-y)^2)   )+0.5)
			focusPoints[distance] = dxElement
			table.insert(focusPointsDistances, distance)
		end
	end

	if #focusPointsDistances > 0 then
		local shortest = math.min(unpack(focusPointsDistances))
		local focusPoint = focusPoints[shortest]

		local x,y = focusPoint.x, focusPoint.y

		local speedX = x-offsets[1]
		local speedY = y-offsets[2]

		return speedX*-1, speedY*-1, focusPoint
	else
		return speedX*0.5, speedY*0.5, false
	end
end

function getNewSessionID()
	sessionID = sessionID+1
	return sessionID
end

function dxScrollPaneFocusTo(scrollPane, focusPoint, easing)
	if (not scrollPane) or (not focusPoint) then 
		pushError(1, 'dxScrollPaneFocusTo')
		return false
	end

	local scrollPane = dxElementsList[scrollPane]
	if not scrollPane then
		pushError(2, 'dxScrollPaneFocusTo', "scrollPane", "dxScrollPane")
		return false
	else
		if scrollPane.type ~= "dxScrollPane" then
			pushError(2, 'dxScrollPaneFocusTo', "scrollPane", "dxScrollPane")
			return false
		end
	end

	local focusPoint = dxElementsList[focusPoint]
	if not focusPoint then
		pushError(2, 'dxScrollPaneFocusTo', "focusPoint", "dxFocusPoint")
		return false
	else
		if focusPoint.type ~= "dxFocusPoint" then
			pushError(2, 'dxScrollPaneFocusTo', "focusPoint", "dxFocusPoint")
			return false
		end
	end

	if not easing then
		easing = 'OutQuad'
	else
		if not table.find(Easings, easing) then
			pushError(4, 'dxScrollPaneFocusTo', "easing")
			return false
		end
	end

	local speedX, speedY = scrollPane.cOffsets[1]-focusPoint.x, scrollPane.cOffsets[2]-focusPoint.y
	local tick = getTickCount()

	SlowDown.new(scrollPane, speedX, speedY, tick, easing or false)
end

function isMoving(scrollPane)
	if SlowDown.panes[scrollPane] then
		return true
	elseif scrollOptions then
		if scrollOptions[scrollRotation] == scrollPane then
			return true
		else
			return false
		end
	else
		return false
	end
end

---------------------------------<
-- *~ Events ~*
---------------------------------<

addEvent("onClientDXFocusPointReached")
addEvent("onClientDXFocusPointStart")
addEvent("onClientDXScrollPaneHold")
addEventHandler("onClientRender", g_Root, updateSlowDowns)

fileDelete("c_scroll.lua")
