----------------------------------<
-- Bluebird GUI
-- c_mouse.lua
----------------------------------<

addEvent("onClientDXClick")
addEvent("onClientDXPerhapsScrolling")

----------------------------------<

g_Root = getRootElement()
g_Me = getLocalPlayer()

Mouse = {}
Mouse.x = 0
Mouse.y = 0
Mouse.sx = 0
Mouse.sy = 0

function getCursorSpeed()
	return Mouse.sx, Mouse.sy
end

function calcCursorSpeed(interval)
	if isCursorShowing() then
		local x,y = getCursorPosition()
		if not x then x = 0 end; if not y then y = 0 end
		local x = x*g_ScreenX
		local y = y*g_ScreenY
		local diffx = x-Mouse.x
		local diffy = y-Mouse.y
		Mouse.sx = diffx*(1000/interval)
		Mouse.sy = diffy*(1000/interval)
		Mouse.x = x
		Mouse.y = y
	end
end

addEventHandler("onClientPreRender", g_Root, calcCursorSpeed)

----------------------------------<

scrollOptions = false
scrollPerformed = false
scrollRotation = false

function decideClicking(btn, state, mx, my)
	local tick = getTickCount()
	local dxElementPointer = {}
	local dxElementsAtPoint = {dxContainer.element}
	local dxScrollPanesAtPoint = {}
	local dxScrollPaneIsMoving = false
	local MousePointData = {mx,my,mx,my}

	local function getLowerElementsAtPoint(parent,nx,ny, pOffsets, row)
		for key, child in ipairs(parent.children) do
			if not child.Enabled then return end

			local function Allowed()
				local x,y,sx,sy = child.x, child.y, child.sx, child.sy
				local cOffsets = child.cOffsets or {0,0}
				local x = nx+x-pOffsets[1]
				local y = ny+y-pOffsets[2]

				if (mx > x) and (my > y) and (mx < x+sx) and (my <y+sy) then
					if dxScrollPaneIsMoving then return false end
					if (child.type == 'dxScrollPane') then
						if isMoving(child) then
							dxScrollPaneIsMoving = true
						end
						if child.Scrollable then
							table.insert(dxScrollPanesAtPoint, child.element) -- NOT PASSING TABLE, must be the dummy element, passing elements through triggerEvent causes copy instead.
						end
					end

					table.insert(dxElementsAtPoint, child.element)

					MousePointData = {mx,my, mx-x, my-y}
					if not dxElementPointer[row] then
						dxElementPointer[row] = key
					end
					if child.children and (not child.BlockChildren) then
						getLowerElementsAtPoint(child, x,y,cOffsets, row+1)
					end
					return
				end
			end

			if child.type == 'dxTile' then
				if (not isAnimating(child)) and (child.Alpha ~= 0) then
 					Allowed()
				end
			elseif child.type ~= "dxFocusPoint" then
				Allowed()
			end
		end
	end
	getLowerElementsAtPoint(dxContainer, 0,0, {0,0}, 1)

	local dxElement = dxContainer
	for k = 1, #dxElementPointer, 1 do
		if dxElement.children then
			dxElement = dxElement.children[dxElementPointer[k]]
		end
	end


	-- dxElement is here the most front element > Which hadn't any moving dxScrollPane as parent.
	-- BUT: This element can be a moving dxScrollPane though, if so, just block the triggerEvent.
	if (not dxScrollPaneIsMoving) then
		triggerEvent("onClientDXClick", dxElement.element, btn, state, dxElementsAtPoint,unpack(MousePointData))
	end

	if (dxElement.type ~= "dxEdit") and (dxElement.type ~= "dxSlider") then -- It's possible to drag dxEdits & dxSliders
		triggerEvent("onClientDXPerhapsScrolling", g_Me, btn, state, mx,my, dxScrollPanesAtPoint)
	end
end

addEventHandler("onClientClick", g_Root, decideClicking)

----------------------------------<

function possibleScrolling(btn, state,x,y, scrollPanes)
	if (btn ~= 'left') and (state ~= 'down') then
		return
	elseif (btn == 'left') and (state == 'up') then
		local x,y = getCursorSpeed()
		if scrollRotation then
			local pane = scrollOptions[scrollRotation]
			local hasFocusPoint = false
			for k, v in ipairs(pane.children) do
				if v.type == 'dxFocusPoint' then
					hasFocusPoint = true
				end
			end
			if (pane.AfterMovement) or ((pane.AutoFocus) and hasFocusPoint) then
				createScrollPaneSlowDownSession(pane, x,y, getTickCount())
			end
		else
			-- Hm.. Thus clicked while still moving to focus point... Okay.. :C

			if scrollOptions then
				if scrollOptions.all then
					createScrollPaneSlowDownSession(scrollOptions.all, 0,0, getTickCount())
				end
				if scrollOptions.hor then
					createScrollPaneSlowDownSession(scrollOptions.hor, 0,0, getTickCount())
				end
				if scrollOptions.vert then
					createScrollPaneSlowDownSession(scrollOptions.vert, 0,0, getTickCount())
				end
			end
		end
		scrollRotation = false
		scrollOptions = false
		removeEventHandler("onClientPreRender", g_Root, performScrolling)
		scrollPerformed = false
		return
	end
	removeEventHandler("onClientPreRender", g_Root, performScrolling) -- It's possible to skip the part up here due to moveing the cursor out of the screen.

	local selectedPane = false
	local selectedPaneHor = false
	local selectedPaneVert = false
	if #scrollPanes == 0 then
		return
	else
		for i = #scrollPanes, 1, -1 do
			local pane = dxElementsList[scrollPanes[i]]
			local offsets = {pane.cOffsets[1],pane.cOffsets[2], pane.mOffsets[1],pane.mOffsets[2]}
			if not (table.compare(offsets, {0,0,0,0})) and (pane.Scrollable) then
				if (offsets[3] > 0) and (offsets[4] > 0) then
					if (not selectedPaneVert) and (not selectedPaneHor) and (not selectedPane) then
						selectedPane = pane
					else
						break
					end
				elseif (offsets[3] > 0) and (offsets[4] == 0) then
					if (not selectedPane) and (not selectedPaneHor) then
						selectedPaneHor = pane
					else
						break
					end
				elseif (offsets[3] == 0) and (offsets[4] > 0) then
					if (not selectedPane) and (not selectedPaneVert) then
						selectedPaneVert = pane
					else
						break
					end
				end
			end
		end
	end

	-- So if it reaches this, there should be a pane, but it might be possible that all aren't dragable.

	if (not selectedPane) and (not selectedPaneVert) and (not selectedPaneHor) then
		return
	end

	if selectedPane then
		if isSlowDownPlaying(selectedPane) then
			stopScrollPaneSlowDownSession(selectedPane)
		end
	end
	if selectedPaneVert then
		if isSlowDownPlaying(selectedPaneVert) then
			stopScrollPaneSlowDownSession(selectedPaneVert)
		end
	end
	if selectedPaneHor then
		if isSlowDownPlaying(selectedPaneHor) then
			stopScrollPaneSlowDownSession(selectedPaneHor)
		end
	end

	-- Now move these possibilities to a table for making it possible to use it later when moving the mouse while the LMB is still down.

	scrollOptions = {all = selectedPane, hor = selectedPaneHor, vert = selectedPaneVert, x=x,y=y}
	if selectedPane then
		scrollOptions["allX"] = selectedPane.cOffsets[1]
		scrollOptions["allY"] = selectedPane.cOffsets[2]
	end
	if selectedPaneHor then
		scrollOptions["horX"] = selectedPaneHor.cOffsets[1]
		scrollOptions["horY"] = selectedPaneHor.cOffsets[2]
	end
	if selectedPaneVert then
		scrollOptions["vertX"] = selectedPaneVert.cOffsets[1]
		scrollOptions["vertY"] = selectedPaneVert.cOffsets[2]
	end

	-- It might be possible that one of the selectedPanes at the (vert+hor) part might be false, but that doesn't matter.

	addEventHandler("onClientPreRender", g_Root, performScrolling)
end

addEventHandler("onClientDXPerhapsScrolling", g_Root, possibleScrolling)

----------------------------------<

function performScrolling()
	local mx, my = getCursorPosition()
	if not mx then
		return
	end
	local mx, my = mx*g_ScreenX, my*g_ScreenY
	local distance = math.sqrt(  ((scrollOptions.x-mx)^2)  +  ((scrollOptions.y-my)^2)   )
	if (not (distance < 5)) or (scrollPerformed) then
		scrollPerformed = true

		if not scrollRotation then
			local rot
			if not scrollOptions.all then
				rot = findRotation(scrollOptions.x,scrollOptions.y,mx,my)
				if (rot > 45) and (rot < 135) then
					rot = "hor"
				elseif (rot >= 135) and (rot <= 225) then
					rot = "vert"
				elseif (rot > 255) and (rot < 315) then
					rot = "hor"
				else
					rot = "vert"
				end

				if not scrollOptions.hor then
					rot = "vert"
				elseif not scrollOptions.vert then
					rot = "hor"
				end
			else
				rot = "all"
			end
			scrollRotation = rot
		end

		if scrollOptions[scrollRotation] then
			local pane = scrollOptions[scrollRotation]
			local startX, startY, maxX, maxY = scrollOptions[scrollRotation.."X"],scrollOptions[scrollRotation.."Y"],pane.mOffsets[1],pane.mOffsets[2]
			newX = startX-(mx-scrollOptions.x)
			newY = startY-(my-scrollOptions.y)
			if newX < 0 then newX = 0 end
			if newY < 0 then newY = 0 end
			if newX > maxX then newX = maxX end
			if newY > maxY then newY = maxY end
			pane.cOffsets = {newX, newY}
		end
	end
end

fileDelete("c_mouse.lua")