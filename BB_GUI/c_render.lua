----------------------------------<
-- Bluebird GUI
-- c_render.lua
----------------------------------<
-- Note
--[[------------------------------<

The current element tree is made out of tables instead of elements.
With this it'll be very easy to draw the dxElements, since it's not needed
anymore to use getElementData on every data ever frame.

To see how the element tree is built, see elements/dxContainer.lua
The every child group will get drawn from the lowest key up to the highest key,
which is actually the sorting system. To bring an item in that group to the back,
simply move its table to the first key, this will make it draw first and then
the others.

The example at dxContainer.lua will be drawn this way:

(1) = dxButton	 	> (1) dxTile 	> (1) dxContainer
					> (2) dxImage

The children have to get drawn first, in order to make it appear on its parent.
So the dxButton gets drawn first onto the dxTile, and then the dxTile
will get drawn first on the dxContainer, dxImage afterwards.

--]]------------------------------<
-- Render system
----------------------------------<

dxTargets = {}
dxDrawingList = {}
g_Rendering = false

blancImage = dxCreateTexture("images/blanc.png")

function renderUI()
	for k, target in ipairs(dxTargets) do
		if target ~= nil then
			dxSetRenderTarget(target, true)
		else
			table.remove(dxTargets,k)
		end
	end
	dxSetRenderTarget()

	for k, dxElement in ipairs(dxDrawingList) do
		if dxElement.alpha ~= 0 then
			drawElement(dxElement, id)
		end
	end
end

function updateList()
	local t = {}
	local function insert(parent)
		if parent.children then
			for i = #parent.children, 1, -1 do
				local child = parent.children[i]
				table.insert(t, 1, child)
				insert(child)
			end
		end
	end
	insert(dxContainer)
	dxDrawingList = t
end

addEvent("onDXElementCreation")
addEventHandler("onDXElementCreation", root, updateList)
addEvent("onDXElementDeletion")
addEventHandler("onDXElementDeletion", root, updateList)

function drawElement(element)
	if element.parent.render then
		dxSetBlendMode("modulate_add")
	else
		dxSetBlendMode("add")
	end
	dxSetRenderTarget(element.parent.render) -- If the parent is the dxContainer, it will simply return nil, which causes the main screen to be the render target. ;)

	if element.type == "dxTile" then
		dxSetBlendMode("add")
		dxSetShaderTransform(element.shader, unpack(element.transform))
		dxDrawImage(element.x+element.temp[1], element.y+element.temp[2], element.sx+element.temp[3], element.sy+element.temp[4], element.shader,0,0,0,tocolor(255,255,255,element.Alpha))
	
	elseif element.type == "dxScrollPane" then
		dxSetBlendMode("add")
		dxDrawImageSection(element.x,element.y,element.sx,element.sy,element.cOffsets[1],element.cOffsets[2],element.sx,element.sy, element.render)
	
	elseif element.type == "dxEdit" then
		dxDrawImageSection(element.x,element.y,element.sx,element.sy,element.viewWidth,0,element.sx,element.sy, element.holder)

		-- Selector coming later (perhaps)

		if element.state then
			local front = string.sub(element.Text, 0, element.CaretIndex)
			if element.Masked then
				front = string.rep("*",string.len(front))
			end
			local totalWidth = 5 + dxGetTextWidth(front, 1, dxGetFont("Segoe UI", 12))
			local posOfCaret = totalWidth-element.viewWidth
			local color = dxGetColor("Inverted Text", false)

			local tick = getTickCount()
			local startTick = element.CaretTime
			local interval = ((tick-startTick+900)%1000)/100
			if (interval > 5) then color = 0 end
			dxDrawLine(posOfCaret+element.x, element.y+element.sy/2-dxEditFontHeight/2, posOfCaret+element.x, element.y+element.sy/2+dxEditFontHeight/2,color, 1)
		end
	elseif element.type == "dxSlider" then
		dxDrawImageSection(element.x,element.y,element.sx,element.sy,0,0,element.sx,element.sy, element.holder)
		local color = dxGetColor("Accent", false)
		if not element.Enabled then color = dxGetColor("Unfocused", false) end
		if element.Background then
			local width = (element.sx-20)*element.Position
			dxDrawRectangle(element.x+10, element.y+10, (element.sx-20)*element.Position, element.sy-20, color)
		end

		if element.Rotation then 
			dxDrawImageSection(element.x,element.y+(element.sy-30)*element.Position,element.sx,30,0,element.sy,element.sx,30,element.holder)
		else
			dxDrawImageSection(element.x+(element.sx-30)*element.Position,element.y,30,element.sy,element.sx,0,30,element.sy,element.holder)
		end

	elseif element.type == "dxText" then
		dxDrawText(element.Text, element.x, element.y, element.sx+element.x, element.sy+element.y, element.Color, element.Scale, element.Font,
			element.AlignX, element.AlignY, element.Clip, element.WordBreak, false,element.ColorCoded, element.SubPixelPos)

	elseif element.type == "dxImage" then
		-- Little fix when something like an gamemode is using images and gets unloaded (to prevent debugscript spamming)
		dxDrawImage(element.x, element.y, element.sx, element.sy, element.Image or blancImage, element.rotation, element.rotationOffX, element.rotationOffY, element.Color)

	elseif element.type == "dxRectangle" then
		dxDrawRectangle(element.x, element.y, element.sx, element.sy, element.Color)

	elseif element.type == "dxButton" then
		dxDrawImage(element.x, element.y, element.sx, element.sy, element.holder)

	elseif element.type == "dxCheckBox" then
		dxDrawImage(element.x, element.y, element.sx, element.sy, element.holder)

	elseif element.type == "dxRadioButton" then
		dxDrawImage(element.x, element.y, element.sx, element.sy, element.holder)

	elseif element.type == "dxLoadingBar" then
		dxDrawImage(element.x, element.y, element.sx, element.sy, element.holder)
		dxDrawRectangle(element.x+8,element.y+8,(element.sx-16)*element.Progress, element.sy-16, element.Color)

	elseif element.type == "dxLoadingIcon" then
		dxDrawImage(element.x, element.y, element.sx, element.sy, "images/loading"..element.Version..".png", ((getTickCount()%1250)/1250)*360)

	end

	dxSetRenderTarget()
	dxSetBlendMode("blend")
end

----------------------------------<
-- Pre Render system
----------------------------------<
-- Elements which have to be
-- pre-rendered first:
-- > dxEdit
-- > dxCheckBox
-- > dxButton
-- > dxRadioButton
-- > dxSlider
-- > dxLoadingBar
-- Other elements can be drawn
-- directly onto the screen.
----------------------------------<
-- Note: Texture size of dxSlider
--       > x+40 & y + 40
----------------------------------<

local needUpdate = {}

function updateElement(element)
	if not table.find(needUpdate, element) then
		table.insert(needUpdate, element)
	end
end

function preRenderUI()
	dxSetBlendMode("modulate_add")
	for _, element in ipairs(needUpdate) do
		local extraX, extraY = 0,0
		if element.type == "dxSlider" then extraX, extraY = 40,40
		elseif element.type == "dxEdit" then extraX, extraY = element.overShoot,0 end

		local render = dxCreateRenderTarget(element.sx+extraX,element.sy+extraY,true)

		dxSetRenderTarget(render)
		dxSetBlendMode("modulate_add")
		if element.type == "dxButton" then
			dxDrawRectangle(0,0,element.sx, element.sy, dxGetColor("Text", false))
			if element.State and element.Enabled then
				dxDrawText(element.Text, 0,0,element.sx,element.sy, dxGetColor("Inverted Text",false),1, dxGetFont("Segoe UI", 12), "center", "center")
			else
				dxDrawRectangle(4,4, element.sx-8, element.sy-8, dxGetColor("Inverted Text",false))
				dxDrawText(element.Text, 0,0,element.sx,element.sy, dxGetColor("Text",false),1, dxGetFont("Segoe UI", 12), "center", "center")
				if not (element.Enabled) then
					local r,g,b = dxGetColor("Description", true)
					dxDrawRectangle(element.sx, element.sy, element.sx, element.sy, tocolor(r,g,b,125))
				end
			end
		elseif element.type == "dxCheckBox" then
			local color = dxGetColor("Text",false)
			if not element.Enabled then color = dxGetColor("Unfocused",false) end

			dxDrawRectangle(0,0, element.sx, element.sy, color)
			if element.Enabled then
				if element.state then
					dxDrawRectangle(element.sx*0.1, element.sy*0.1, element.sx*0.8, element.sy*0.8, dxGetColor("Accent",false))
				else
					dxDrawRectangle(element.sx*0.1, element.sy*0.1, element.sx*0.8, element.sy*0.8, dxGetColor("Inverted Text",false))
				end
			else
				if element.state then
					dxDrawRectangle(element.sx*0.1, element.sy*0.1, element.sx*0.8, element.sy*0.8, color)
				end
			end
		elseif element.type == 'dxRadioButton' then
			dxDrawImage(0,0,element.sx,element.sy,"images/circle.png", 0,0,0,dxGetColor("Inverted Text",false))
			if element.Enabled then
				if element.state then
					dxDrawImage(element.sx*0.1,element.sy*0.1,element.sx*0.8,element.sy*0.8,"images/circle.png", 0,0,0,dxGetColor("Accent",false))
				end
			else
				if element.state then
					dxDrawImage(element.sx*0.1,element.sy*0.1,element.sx*0.8,element.sy*0.8,"images/circle.png", 0,0,0,dxGetColor("Unfocused",false))
				end
			end
		elseif element.type == "dxSlider" then
			local color = dxGetColor("Text",false)
			if not element.Enabled then color = dxGetColor("Unfocused",false) end

			dxDrawLine(0,0, element.sx, 0, color,4)
			dxDrawLine(0,0, 0, element.sy, color,4)
			dxDrawLine(element.sx, 0, element.sx, element.sy, color,4)
			dxDrawLine(0, element.sy, element.sx, element.sy, color,4)

			dxDrawRectangle(element.sx  ,0,30,element.sy, dxGetColor("Inverted Text",false))
			dxDrawRectangle(element.sx+4,0,22,element.sy, color)

			dxDrawRectangle(0,element.sy,element.sx,30, dxGetColor("Inverted Text",false))
			dxDrawRectangle(0,element.sy+4,element.sx,22, color)
		elseif element.type == "dxLoadingBar" then
			local color = dxGetColor("Text",false)

			dxDrawLine(0,0, element.sx, 0, color,4)
			dxDrawLine(0,0, 0, element.sy, color,4)
			dxDrawLine(element.sx, 0, element.sx, element.sy, color,4)
			dxDrawLine(0, element.sy, element.sx, element.sy, color,4)
		elseif element.type == "dxEdit" then
			if element.state then
				dxDrawRectangle(0,0, element.sx+extraX, element.sy, dxGetColor("Text",false))
			else
				dxDrawRectangle(0,0, element.sx+extraX, element.sy, dxGetColor("Unfocused",false))
			end

			if element.Text == '' then
				dxDrawText(element.GhostText, 5,0, element.sx+extraX, element.sy, dxGetColor("Description", false),1, dxGetFont("Segoe UI", 12), "left", "center")
			else
				if element.Masked then
					local text = string.rep("•", string.len(element.Text))
					dxDrawText(text, 5,0, element.sx+extraX, element.sy, dxGetColor("Inverted Text", false),1, dxGetFont("Segoe UI", 12), "left", "center")
				else
					dxDrawText(element.Text, 5,0, element.sx+extraX, element.sy, dxGetColor("Inverted Text", false),1, dxGetFont("Segoe UI", 12), "left", "center")
				end
			end

			--[[if element.selectLength ~= 0 then
				local startWidth = 5+dxGetTextWidth(string.sub(element.text, 0,element.selectStart-1),1, dxGetFont("Segoe UI", 12))
				local width = dxGetTextWidth(string.sub(element.text, element.selectStart, element.selectStart+element.selectLength),1, dxGetFont("Segoe UI", 12))
				local height = dxGetFontHeight(1, dxGetFont("Segoe UI", 12))
				local r,g,b = dxGetColor("Accent",true)
				dxDrawRectangle(startWidth, element.sx/2-height/2, width, height,tocolor(r,g,b, 150))
			end]]

			-- Carat is drawn real time.
		end

		dxSetRenderTarget()
		local pixels = dxGetTexturePixels(render)
		if pixels then
			dxSetTexturePixels(element.holder, pixels)
		else
			updateElement(element)
		end
		destroyElement(render)
	end
	dxSetBlendMode("blend")
	needUpdate = {}
	renderUI()
end

function stopRender()
	removeEventHandler("onClientRender", root, preRenderUI)
	
	g_Rendering = false
end

function startRender()
	if(g_Rendering == true) then
		return
	end
	
	addEventHandler("onClientRender", root, preRenderUI)
	
	g_Rendering = true
end

startRender()

fileDelete("c_render.lua")