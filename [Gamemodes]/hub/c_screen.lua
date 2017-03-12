g_Resource = getThisResource()
g_ResourceRoot = getResourceRootElement(g_Resource)
g_Me = getLocalPlayer()
screenX,screenY = guiGetScreenSize()

local screen = {}
screen.__index = screen

Screens = {}

-- Position View
--
-- 		1---4
-- 		|   |
-- -----2---3----- Screen axis

BlancImage = dxCreateTexture("images/bgcolor.png")
BlancShader = dxCreateShader("shader/window.fx")
dxSetShaderValue(BlancShader, "Tex0", BlancImage)

BorderImage = dxCreateTexture("images/white.png")

function createScreen(tag,x,y,z,rotation,dimension,action,groundZ,depth)
	-- Step 1: Create the object
	-- Step 2: Replace the border texture with dark grey (Same color as menu)
	-- Step 3: Create Shader
	-- Step 4: Assign Shader to object
	-- Step 5: Create ColShape (if action == true)
	-- Step 6: Create lightborder on floor (if action == true)
	-- Step 7: Attach Events (if action == true > attach event of what must be triggered when pressing RMB @ Screen)
	local Screen = createObject(16000, x,y,z)
	local Pos1, Pos2, Pos3, Pos4, PosCenter,ColShape
	-- Corners calculation
	rotation = rotation % 360 -- In case someone passes a rotation +360..
	if (rotation >= 0) and (rotation < 90) then
		Pos2 = {x-math.cos(rotation*(math.pi/180))*10.7055664062,y-math.sin(rotation*(math.pi/180))*10.7055664062,groundZ}
		Pos3 = {x+math.cos(rotation*(math.pi/180))*10.7055664062,y+math.sin(rotation*(math.pi/180))*10.7055664062,groundZ}

		Pos1 = {Pos2[1]-math.cos((90-rotation)*(math.pi/180))*depth,Pos2[2]+math.sin((90-rotation)*(math.pi/180))*depth,groundZ}
		Pos4 = {Pos3[1]-math.cos((90-rotation)*(math.pi/180))*depth,Pos3[2]+math.sin((90-rotation)*(math.pi/180))*depth,groundZ}

		PosCenter = {x+math.cos(rotation*(math.pi/180))*depth,y+math.sin(rotation*(math.pi/180))*depth,groundZ}

	elseif (rotation >= 90) and (rotation < 180) then
		Pos2 = {x+math.cos(rotation*(math.pi/180))*10.7055664062,y+math.sin(rotation*(math.pi/180))*10.7055664062,groundZ}
		Pos3 = {x-math.cos(rotation*(math.pi/180))*10.7055664062,y-math.sin(rotation*(math.pi/180))*10.7055664062,groundZ}

		Pos1 = {Pos2[1]-math.cos((90-rotation)*(math.pi/180))*depth,Pos2[2]+math.sin((90-rotation)*(math.pi/180))*depth,groundZ}
		Pos4 = {Pos3[1]-math.cos((90-rotation)*(math.pi/180))*depth,Pos3[2]+math.sin((90-rotation)*(math.pi/180))*depth,groundZ}

		PosCenter = {x+math.cos(rotation*(math.pi/180))*depth,y-math.sin(rotation*(math.pi/180))*depth,groundZ}

	elseif (rotation >= 180) and (rotation < 270) then

		Pos2 = {x+math.cos(rotation*(math.pi/180))*10.7055664062,y+math.sin(rotation*(math.pi/180))*10.7055664062,groundZ}
		Pos3 = {x-math.cos(rotation*(math.pi/180))*10.7055664062,y-math.sin(rotation*(math.pi/180))*10.7055664062,groundZ}	

		Pos1 = {Pos2[1]+math.cos((270-rotation)*(math.pi/180))*depth,Pos2[2]-math.sin((270-rotation)*(math.pi/180))*depth,groundZ}
		Pos4 = {Pos3[1]+math.cos((270-rotation)*(math.pi/180))*depth,Pos3[2]-math.sin((270-rotation)*(math.pi/180))*depth,groundZ}		

		PosCenter = {x-math.cos(rotation*(math.pi/180))*depth,y-math.sin(rotation*(math.pi/180))*depth,groundZ}

	elseif (rotation >= 270) and (rotation < 360) then

		Pos2 = {x-math.cos(rotation*(math.pi/180))*10.7055664062,y-math.sin(rotation*(math.pi/180))*10.7055664062,groundZ}
		Pos3 = {x+math.cos(rotation*(math.pi/180))*10.7055664062,y+math.sin(rotation*(math.pi/180))*10.7055664062,groundZ}

		Pos1 = {Pos2[1]-math.cos((90-rotation)*(math.pi/180))*depth,Pos2[2]+math.sin((90-rotation)*(math.pi/180))*depth,groundZ}
		Pos4 = {Pos3[1]-math.cos((90-rotation)*(math.pi/180))*depth,Pos3[2]+math.sin((90-rotation)*(math.pi/180))*depth,groundZ}	

		PosCenter = {x-math.cos(rotation*(math.pi/180))*depth,y+math.sin(rotation*(math.pi/180))*depth,groundZ}
	end

	ColShape = createColPolygon(PosCenter[1],PosCenter[2],Pos1[1],Pos1[2],Pos2[1],Pos2[2],Pos3[1],Pos3[2],Pos4[1],Pos4[2])
	setElementDimension(ColShape,dimension)
	-- Events

	addEvent("ActionZoneIn_"..tag)
	addEvent("ActionZoneOut_"..tag)

	addEventHandler("onClientColShapeHit", ColShape,
		function(elem,dim)
			if (elem == g_Me) and (dim) then
				for ID,ScreenB in pairs(Screens) do
					if ScreenB.ColShape == ColShape then
						if ScreenB.action then
							triggerEvent("ActionZoneIn_"..tag, ColShape)
							ScreenB.state = true
							playSoundFrontEnd(32)
						end
					end
				end
			end
		end)

	addEventHandler("onClientColShapeLeave", ColShape,
		function(elem,dim)
			if (elem == g_Me) and (dim)  then
				for ID,ScreenB in pairs(Screens) do
					if ScreenB.ColShape == ColShape then
						if ScreenB.action then
							triggerEvent("ActionZoneOut_"..tag, ColShape)
							playSoundFrontEnd(33)
							ScreenB.state = false
						end
					end
				end
			end
		end)

	local ColShapeView = createColSphere(x,y,z, 100)
	setElementDimension(ColShapeView,dimension)
	addEventHandler("onClientColShapeHit", root, function(elem,dim) if (elem == g_Me) and (dim) and (source == ColShapeView) then loadstring("Create_"..tag.."()")() end end)
	addEventHandler("onClientColShapeLeave", root, function(elem,dim) if (elem == g_Me) and (dim) and (source == ColShapeView) then loadstring("Delete_"..tag.."()")() end end)

	setElementRotation(Screen,0,0,rotation)
	setElementDimension(Screen, dimension)
	engineApplyShaderToWorldTexture(BlancShader, "drvin_front", Screen)
	engineApplyShaderToWorldTexture(BlancShader, "drvin_screen", Screen)

	local mt =  setmetatable({x = x, y = y, z = z, rotation = rotation or 0, dimension = dimension or 1,
		action = action or false, groundZ = groundZ or 0, depth = depth or 0, shader = 'default',
		Pos1 = Pos1, Pos2 = Pos2, Pos3 = Pos3, Pos4 = Pos4, PosCenter = PosCenter, Screen = Screen, ColShape = ColShape,
		tag = tag, tile = false, state = false}, screen)

	table.insert(Screens, mt)

	return mt
end

function screen:assignTile(tile)
	local texture = exports.BB_GUI:dxGetRawData(tile, "render")
	if (self.shader ~= 'default') then -- Can be 'dead' also
		destroyElement(self.shader)
	end

	local shader_screen, tec = dxCreateShader ( "shader/texreptransform.fx" )
	if not shader_screen then return end
	dxSetShaderValue ( shader_screen, "gBrighten", -0.23 )
	local radian=math.rad(0)
	dxSetShaderValue ( shader_screen, "gRotAngle", radian )
	dxSetShaderValue ( shader_screen, "gGrayScale", 0 )
	dxSetShaderValue ( shader_screen, "gRedColor", 0 )
	dxSetShaderValue ( shader_screen, "gGrnColor", 0 )
	dxSetShaderValue ( shader_screen, "gBluColor", 0 )
	dxSetShaderValue ( shader_screen, "gAlpha", 1 )
	dxSetShaderValue ( shader_screen, "gScrRig",  0)
    dxSetShaderValue ( shader_screen, "gScrDow", 0)
    dxSetShaderValue ( shader_screen, "gHScale", 1 )
	dxSetShaderValue ( shader_screen, "gVScale", 1 )
	dxSetShaderValue ( shader_screen, "gHOffset", 0 )
	dxSetShaderValue ( shader_screen, "gVOffset", 0 ) 
	engineApplyShaderToWorldTexture ( shader_screen, "drvin_screen", self.Screen)
	dxSetShaderValue ( shader_screen, "gTexture", texture )

	self.tile = tile
	self.shader = shader_screen
end

addEventHandler("onClientKey", root, function(key,state)
	local keyX = getBoundKeys("enter_exit")[1] or 'enter'
	if (key == keyX) and (not state) then
		for ID, Screen in pairs(Screens) do
			local found = false
			if Screen.State then
				found = Screen
			end
			if found then
				triggerEvent("ActionZoneUse_"..Screen.tag, g_Me)
			end
		end
	end
end)

addEventHandler("onClientPreRender", root, function()
	for ID,ScreenB in pairs(Screens) do
		if (ScreenB.action) and (getElementDimension(g_Me) == ScreenB.dimension) then
			-- Draw a 3DMaterialLine from 1-4, 1-2, 4-3, (2-3 not, because that's the screen)
			-- Draw it blue if you're outside, green if inside.
			local color = tocolor(50,151,255,120)
			if ScreenB.state then color = tocolor(125,255,0,120) end		

			dxDrawMaterialLine3D(ScreenB.Pos1[1],ScreenB.Pos1[2],ScreenB.Pos1[3],ScreenB.Pos4[1],ScreenB.Pos4[2],ScreenB.Pos4[3], BorderImage, 1,color, ScreenB.PosCenter[1],ScreenB.PosCenter[2],ScreenB.PosCenter[3])
			dxDrawMaterialLine3D(ScreenB.Pos1[1],ScreenB.Pos1[2],ScreenB.Pos1[3],ScreenB.Pos2[1],ScreenB.Pos2[2],ScreenB.Pos2[3], BorderImage, 1,color, ScreenB.PosCenter[1],ScreenB.PosCenter[2],ScreenB.PosCenter[3])
			dxDrawMaterialLine3D(ScreenB.Pos4[1],ScreenB.Pos4[2],ScreenB.Pos4[3],ScreenB.Pos3[1],ScreenB.Pos3[2],ScreenB.Pos3[3], BorderImage, 1,color, ScreenB.PosCenter[1],ScreenB.PosCenter[2],ScreenB.PosCenter[3])
		end
	end
end)

addEventHandler("onClientRender", root, function()
	exports.BB_GUI:startRender()
end)

function table.find(tableToSearch, index, value)
	if not value then
		value = index
		index = false
	elseif value == '[nil]' then
		value = nil
	end
	for k,v in pairs(tableToSearch) do
		if index then
			if v[index] == value then
				return k
			end
		elseif v == value then
			return k
		end
	end
	return false
end

function renderHUBClosed()
	if(getElementData(localPlayer,"UAG.MenuShown") == true) then
		return
	end
		
	local width = dxGetTextWidth("HUB Under Construction!",conv(3),"default-bold")
	dxDrawText("HUB Under Construction!", (screenX/2)-(width/2), conv(30),0,0, tocolor(255,0,0,255), conv(3), "default-bold","left","top",false,false,false,true)
	
	local infoText = "The HUB is the main place of the server.\n\nIt contains information, tutorials, the new room selection and minigames.\nIt is also the perfect place to interact with the other players.\n\nUnfortunately the HUB is still in development and is not available yet in this version. Although everything around it is implemented already.\nThis is the reason why you are joining the HUB on the start of the server. We use this chance to give you some information\nabout how the system currently works."
	local width = dxGetTextWidth(infoText,conv(1.5),"default-bold")
	dxDrawText(infoText, 0, conv(100),screenX,0, tocolor(255,255,255,255), conv(1.5), "default-bold","center","top")
	
	local infoText = "[U]  => Open/Close menu\n[I]   => Return to previous screen in the menu.\n[G]  => Global chat\n[F1] => Return to the HUB.\n[F3] => Change carfade mode."
	local width = dxGetTextWidth(infoText,conv(1.5),"default-bold")
	dxDrawText(infoText, (screenX/2)-(width/2), conv(300),screenX,0, tocolor(0,255,0,255), conv(1.5), "verdana","left","top")
	
	local roomText = "[To join a room using the old room selection, press 'U' until the menu opened. Then hold LMB (left mouse button).\nMove your mouse to the right side (known as dragging) until the room selection is on your screen.]"
	local width = dxGetTextWidth(roomText,conv(1.5),"default-bold")
	dxDrawText(roomText, 0, screenY-conv(70),screenX,0, tocolor(100,166,255,255), conv(1.5), "default-bold","center","top")
end

function showHUBClosed()
	fadeCamera(false)
	removeEventHandler("onClientRender",root,renderHUBClosed)
	addEventHandler("onClientRender",root,renderHUBClosed)
end

function conv(size)
	local newSize = size*(screenX/1366)
	
	if(screenX >= 1600) then
		return (newSize*0.8)
	elseif(screenX <= 1000) then
		return (newSize*1.4)
	else
		return (newSize*1)
	end
end