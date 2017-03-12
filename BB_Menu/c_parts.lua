---------------------------------<
-- Bluebird Menu
-- c_quickacces.lua
---------------------------------<

function pairsByKeys (t, f)
	local a = {}
	for n in pairs(t) do table.insert(a, n) end
	table.sort(a, f)
	local i = 0      -- iterator variable
	local iter = function ()   -- iterator function
		i = i + 1
		if a[i] == nil then return nil
		else return a[i], t[a[i]]
		end
	end
	return iter
end
---------------------------------<

GRID = {}

-- Grid = 6 x inf

function initializeQuickAcces(layout)
	-- Quick sketch
	local maxY = 0
	GRID,maxY = fromLayoutToGRID(layout)
	for name, block in pairs(GRID) do
		local sx,sy = 100,100
		if block.type == 2 then
			sx,sy = 220,220
		elseif block.type == 3 then
			sx,sy = 460,220
		end
		local tile = exports.BB_GUI:dxCreateTile(50+(block.pos[1]-1)*120, 50+(block.pos[2]-1)*120, sx,sy, Elements.VerticalPane_Center,false,false,255)
		exports.BB_GUI:dxSetRawData(tile, "BlockChildren", true)
		exports[name]:liveTileUpdate(tile, block.type)
		setElementData(tile, "App", name)
		addEventHandler("onClientDXClick", tile, performOpen)
	end

	maxY = 100+maxY*120-600
	if maxY < 0 then
		maxY = 0
	end
	exports.BB_GUI:dxSetPaneSize(Elements.VerticalPane_Center, 0, maxY)
end

function fromGRIDToLayout(grid)
	local layout = {}
	for name, block in pairs(grid) do
		if block.type == 1 then
			layout[block.pos[2]][block.pos[1]] = name
		elseif block.type == 2 then
			layout[block.pos[2]][block.pos[1]] = name
			layout[block.pos[2]][block.pos[1]+1] = name
			layout[block.pos[2]+1][block.pos[1]] = name
			layout[block.pos[2]+1][block.pos[1]+1] = name
		elseif block.type == 3 then
			layout[block.pos[2]][block.pos[1]] = name
			layout[block.pos[2]][block.pos[1]+1] = name
			layout[block.pos[2]][block.pos[1]+2] = name
			layout[block.pos[2]][block.pos[1]+3] = name
			layout[block.pos[2]+1][block.pos[1]] = name
			layout[block.pos[2]+1][block.pos[1]+1] = name
			layout[block.pos[2]+1][block.pos[1]+2] = name
			layout[block.pos[2]+1][block.pos[1]+3] = name
		end
	end
	return layout
end

function fromLayoutToGRID(layout)
	local grid = {}
	local maxY = 0
	for rowID, row in ipairs(layout) do
		for columnID, name in ipairs(row) do
			if (not grid[name]) and (name ~= "") then
				grid[name] = {}
				if layout[rowID][columnID+3] == name then
					grid[name].type = 3
				elseif layout[rowID][columnID+1] == name then
					grid[name].type = 2
				else
					grid[name].type = 1
				end
				grid[name].pos = {columnID, rowID} -- x,y
			end
		end
		maxY = rowID
	end
	return grid,maxY
end

---------------------------------<

AppList = {}

function initializeAppsList(list)
	if not blancImage then blancImage = dxCreateTexture("images/icons/blanc.png") end

	local maxCount = #list
	local apps = {}
	for k, app in ipairs(list) do
		apps[app] = k
	end

	local maxHeight = 50+100*maxCount-600
	if maxHeight < 0 then maxHeight = 0 end
	exports.BB_GUI:dxSetPaneSize(Elements.VerticalPane_Right, 0, maxHeight)

	local pos = 0
	for name, _ in pairsByKeys(apps) do
		local tile = exports.BB_GUI:dxCreateTile(50,50+pos*100, 700, 75, Elements.VerticalPane_Right, false, false,255)
    	AppList[pos] = {
    		["tile"] = tile,
    		["bg"] = exports.BB_GUI:dxCreateRectangle(0,0,1,1,tile, true,true, exports.BB_GUI:dxGetColor("Background",false)),
    		["rect"] = exports.BB_GUI:dxCreateRectangle(0,0,75,75,tile,false,false,exports.BB_GUI:dxGetColor("Accent",false)),
    		["image"] = exports.BB_GUI:dxCreateImage(0,0,75,75,blancImage, tile),
    		["text"] = exports.BB_GUI:dxCreateText("Loading...",100,0,600,75,tile,false,false,exports.BB_GUI:dxGetColor("Text", false),1,exports.BB_GUI:dxGetFont("Segoe UI", 24),"left", "center", true,true,true)
    	}
    	exports.BB_GUI:dxSetRawData(tile, "BlockChildren", true)
    	setElementData(tile, "App", name)
    	addEventHandler("onClientDXClick", tile, performOpen)

    	updateAppAtRight(name,AppList[pos])
    	pos = pos+1
    end
end

function updateAppAtRight(name, tab)
	if exports[name]:isStillUpdating() then
		setTimer(updateAppAtRight, 1000, 1, name,tab)
	else
		local appName, icon = exports[name]:giveMeDetails()
		exports.BB_GUI:dxSetRawData(tab.text, "Text", appName)
		exports.BB_GUI:dxSetRawData(tab.image, "Image", ":"..name.."/"..icon)
	end
end

RoomList = {}

function initializeRoomsList()
	local rooms = exports.BB_Rooms:requestRooms()
	local maxCount = #rooms

	local maxHeight = 50+100*maxCount-600
	if maxHeight < 0 then maxHeight = 0 end
	exports.BB_GUI:dxSetPaneSize(Elements.VerticalPane_Left, 0, maxHeight)

	local pos = 0
	for i,room in pairsByKeys(rooms) do
		local tile = exports.BB_GUI:dxCreateTile(50,50+pos*100, 700, 75, Elements.VerticalPane_Left, false, false,255)
    	RoomList[pos] = {
    		["tile"] = tile,
			["id"] = i,
    		["bg"] = exports.BB_GUI:dxCreateRectangle(0,0,1,1,tile, true,true, exports.BB_GUI:dxGetColor("Background",false)),
    		["rect"] = exports.BB_GUI:dxCreateRectangle(0,0,750,100,tile,false,false,exports.BB_GUI:dxGetColor("Accent",false)),
    		["roomName"] = exports.BB_GUI:dxCreateText("Loading...",15,0,600,40,tile,false,false,exports.BB_GUI:dxGetColor("Text", false),1,exports.BB_GUI:dxGetFont("Segoe UI", 24),"left", "center", true,true,true),
			["modeLabel"] = exports.BB_GUI:dxCreateText("Gamemode: ",15,0,600,120,tile,false,false,exports.BB_GUI:dxGetColor("Text", false),1,exports.BB_GUI:dxGetFont("Segoe UI Bold", 12),"left", "center", true,true,true),
			["mode"] = exports.BB_GUI:dxCreateText("none",110,0,600,120,tile,false,false,exports.BB_GUI:dxGetColor("Text", false),1,exports.BB_GUI:dxGetFont("Segoe UI Light", 12),"left", "center", true,true,true),
			["players"] = exports.BB_GUI:dxCreateText("0/0",550,0,600,65,tile,false,false,exports.BB_GUI:dxGetColor("Text", false),1,exports.BB_GUI:dxGetFont("Segoe UI", 24),"left", "center", true,true,true)
    	}
    	exports.BB_GUI:dxSetRawData(tile, "BlockChildren", true)
    	setElementData(tile, "Room", i)
    	addEventHandler("onClientDXClick", tile, goRoom)

    	updateRoom(RoomList[pos],room,tile)
    	pos = pos+1
    end
	
	roomTimer = setTimer(updateServerRooms,5000,0)
end

function updateRoom(tab, room,tile)
	exports.BB_GUI:dxSetRawData(tab.roomName, "Text", room.name)
	exports.BB_GUI:dxSetRawData(tab.players, "Text", getElementChildrenCount(getElementByID("room_"..tostring(getElementData(tile,"Room")))).."/"..room.maxPlayers)
	if(room.locked) then
		exports.BB_GUI:dxSetRawData(tab.players, "Text", "#FF0000Locked")
	elseif(room.maxPlayers == -1) then
		exports.BB_GUI:dxSetRawData(tab.players, "Text", getElementChildrenCount(getElementByID("room_"..tostring(getElementData(tile,"Room")))))
	else
		exports.BB_GUI:dxSetRawData(tab.players, "Text", getElementChildrenCount(getElementByID("room_"..tostring(getElementData(tile,"Room")))).."/"..room.maxPlayers)
	end
	exports.BB_GUI:dxSetRawData(tab.mode, "Text", room.modename)
end

function updateServerRooms()
	local rooms = exports.BB_Rooms:requestRooms()
	for i=0,#RoomList do
		if(rooms[RoomList[i].id] == nil) then
			exports.BB_GUI:dxDestroyElement(RoomList[i].tile)
			table.remove(RoomList,i)
		else			
			exports.BB_GUI:dxSetRawData(RoomList[i].roomName, "Text", rooms[RoomList[i].id].name)

			if(rooms[RoomList[i].id].locked) then
				exports.BB_GUI:dxSetRawData(RoomList[i].players, "Text", "#FF0000Locked")
			elseif(rooms[RoomList[i].id].maxPlayers == -1) then
				exports.BB_GUI:dxSetRawData(RoomList[i].players, "Text", getElementChildrenCount(getElementByID("room_"..tostring(i+1))))
			else
				exports.BB_GUI:dxSetRawData(RoomList[i].players, "Text", getElementChildrenCount(getElementByID("room_"..tostring(i+1))).."/"..rooms[RoomList[i].id].maxPlayers)
			end
			exports.BB_GUI:dxSetRawData(RoomList[i].mode, "Text", rooms[RoomList[i].id].modename)
		end
	end
end

function ShowMenuForFirstTime()
	exports.BB_GUI:dxSetRawData(Elements.Menu, "Alpha", 255)
	exports.BB_GUI:dxSetProperty(Elements.Menu, "Enabled", true)
	isLocked = false
end

addEvent("onClientDXClick")

function performOpen(btn,state)
	if (btn ~= "left") or (state ~= "up") then return end

	exports.BB_AppManager:LoadApp(getElementData(source, "App",false))
end

function goRoom(btn,state)
	if (btn ~= "left") or (state ~= "up") then return end

	exports.BB_Rooms:joinRoom(getElementData(source, "Room"))
end

fileDelete("c_parts.lua")