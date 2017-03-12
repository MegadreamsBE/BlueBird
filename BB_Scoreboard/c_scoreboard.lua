-- Variables
g_Me = getLocalPlayer()
g_Resource = getThisResource()
g_Root = getRootElement()
g_ResourceRoot = getResourceRootElement(g_Resource)

local screenX, screenY = guiGetScreenSize()
local teams = {}

local updateTimer = nil
local cursorShowing = false
local roomSelection = false

local counter = 0
local starttick = nil
local currenttick = nil
local avgYTick = 0

local selectedRoom = 0
local lastPlayerRoom = 0

local scrPos = 1
local loopPlayers = 0
local loopTeams = 0

local svInfo = {
["name"] = "Unknown",
["maxPlayers"] = 0,
["players"] = 0
}

local roomsInfo = {}
local roomPlayers = {}

-- Events

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

addEventHandler("onClientResourceStart", g_ResourceRoot, 
	function(resource)
		bindKey("tab", "down", showScoreboard)
		bindKey("tab", "up", hideScoreboard)  
		triggerServerEvent("requestServerInfo",localPlayer)
		setElementData(localPlayer,"ping",getPlayerPing(localPlayer))
	end
)

addEvent("onServerInfoReceived",true)
addEventHandler("onServerInfoReceived",g_Root,
	function(info,rooms)
		svInfo["name"] = info["name"]
		svInfo["maxPlayers"] = info["maxPlayers"]
		
		setElementData(localPlayer,"ping",getPlayerPing(localPlayer))
		
		roomsInfo = {}
		for _,v in ipairs(rooms) do
			table.insert(roomsInfo,v.roomID,v)
		end
		
		roomPlayers = {}
		local plrRoom = (getElementData(localPlayer,"bb.room") or -1)
		if(plrRoom == -1) then
			plrRoom = 1
		end
		if(selectedRoom == plrRoom) then
			table.insert(roomPlayers,localPlayer)
		end
		for _,v in ipairs(getElementsByType("player")) do
			local plrRoom = (getElementData(v,"bb.room") or -1)
			if(plrRoom == -1) then
				plrRoom = 1
			end
			if(selectedRoom == plrRoom) then
				if(v ~= localPlayer) then
					table.insert(roomPlayers,v)
				end
			end
			if((getElementData(v,"bb.room") or -1) == -1) then
				roomsInfo[1].players = roomsInfo[1].players + 1
			end
		end
		
		teams = {}
		for _,v in ipairs(getElementsByType("team")) do
			local teamPlrCount = 0
			for _,v in ipairs(getPlayersInTeam(v)) do
				local plrRoom = (getElementData(v,"bb.room") or -1)
				if(plrRoom == -1) then
					plrRoom = 1
				end
				
				if(plrRoom == selectedRoom) then
					teamPlrCount = teamPlrCount + 1
				end
			end
			if(teamPlrCount > 0) then
				table.insert(teams,v)
			end
		end
	end
)

function showScoreboard()
	addEventHandler("onClientRender",g_Root,renderScoreboard)
	addEventHandler( "onClientClick", g_Root,clickScoreboard)
	updateTimer = setTimer(updateInfo,2000,0)
	triggerServerEvent("requestServerInfo",localPlayer)
	
	svInfo["players"] = #getElementsByType("player")
	
	local plrRoom = (getElementData(localPlayer,"bb.room") or -1)
	if(plrRoom == -1) then
		plrRoom = 1
	end
	
	if(lastPlayerRoom ~= plrRoom) then
		lastPlayerRoom = plrRoom
		selectedRoom = plrRoom
	end
	
	bindKey("mouse2", "both", showTheCursor)
	bindKey("mouse_wheel_up", "down", scrollScoreboard, -1)
	bindKey("mouse_wheel_down", "down", scrollScoreboard, 1)
end

function hideScoreboard()
	removeEventHandler("onClientRender",g_Root,renderScoreboard)
	removeEventHandler( "onClientClick", g_Root,clickScoreboard)
	killTimer(updateTimer)
	
	roomSelection = false
	unbindKey("mouse2", "both", showTheCursor)
	unbindKey("mouse_wheel_up", "down", scrollScoreboard, -1)
	unbindKey("mouse_wheel_down", "down", scrollScoreboard, 1)
	if(cursorShowing == true) then
		showCursor(false)
		cursorShowing = false
	end
	
	scrPos = 1
end

function showTheCursor(key,state)
	if(state == "down") then
		if(isCursorShowing()) then return end
		showCursor(true)
		cursorShowing = true
	end
	if(state == "up" and cursorShowing == true) then
		showCursor(false)
		cursorShowing = false
	end
end

function updateInfo()
	triggerServerEvent("requestServerInfo",localPlayer)
end

local scWidth = conv(800)
local scHeight = 0

function renderScoreboard()
	local scPosX = ((screenX/2) - (scWidth/2))
	local scPosY = ((screenY/2) - (scHeight/2))
	
	dxDrawRectangle(scPosX, scPosY, scWidth, scHeight, tocolor(0,0,0,180), false)
	
	dxDrawText(svInfo["name"], scPosX+conv(6), scPosY+conv(2),scWidth,scHeight, tocolor(27,161,226,255), conv(1), "default-bold")
	
	local length = dxGetTextWidth(svInfo["players"].."/"..svInfo["maxPlayers"],conv(1),"default-bold")
	dxDrawText(svInfo["players"].."/"..svInfo["maxPlayers"], (((scPosX+scWidth)-length)-conv(2)), scPosY+conv(2),scWidth,scHeight, tocolor(27,161,226,255), conv(1), "default-bold")

	local scYPointer = conv(25)
	
	if(roomsInfo[selectedRoom].maxPlayers > 0) then
		playerDisplay = roomsInfo[selectedRoom].players.."/"..roomsInfo[selectedRoom].maxPlayers
	else
		playerDisplay = roomsInfo[selectedRoom].players
	end
	
	dxDrawRectangle(scPosX, scPosY+scYPointer, scWidth, conv(20), tocolor(27,161,226,180), false)
	dxDrawText(roomsInfo[selectedRoom].roomName.." ("..getElementChildrenCount(getElementByID("room_"..tostring(selectedRoom)))..")", scPosX+conv(6), (scPosY+scYPointer)+conv(2.5),scWidth,scHeight, tocolor(255,255,255,255), conv(1), "default-bold")
	
	dxDrawText("Country", (scPosX+conv(6)+conv(250)), (scPosY+scYPointer)+conv(2.5),scWidth,scHeight, tocolor(255,255,255,255), conv(1), "default-bold")
	dxDrawText("Points", (scPosX+conv(6)+conv(350)), (scPosY+scYPointer)+conv(2.5),scWidth,scHeight, tocolor(255,255,255,255), conv(1), "default-bold")
	dxDrawText("Cash", (scPosX+conv(6)+conv(450)), (scPosY+scYPointer)+conv(2.5),scWidth,scHeight, tocolor(255,255,255,255), conv(1), "default-bold")
	dxDrawText("State", (scPosX+conv(6)+conv(550)), (scPosY+scYPointer)+conv(2.5),scWidth,scHeight, tocolor(255,255,255,255), conv(1), "default-bold")
	dxDrawText("FPS", (scPosX+conv(6)+conv(650)), (scPosY+scYPointer)+conv(2.5),scWidth,scHeight, tocolor(255,255,255,255), conv(1), "default-bold")
	dxDrawText("Ping", (scPosX+conv(6)+conv(750)), (scPosY+scYPointer)+conv(2.5),scWidth,scHeight, tocolor(255,255,255,255), conv(1), "default-bold")			
	
	local roomPlr = 0
	local roomCount = 0
	for _,v in ipairs(roomPlayers) do
		if(roomSelection == false) then
			roomCount = 2
		else
			roomCount = #roomsInfo
		end
		
		if ((conv(25) + (conv(20)*(roomCount)) + ((roomPlr-(scrPos)+1)*conv(20))) > (screenY-conv(20))) then
			break
		end
		
		if((roomPlr+1) >= scrPos) then
			if(getPlayerTeam(v) == false) then
				scYPointer = scYPointer + conv(20)
				drawPlayer(v,scPosX,scPosY,scYPointer)
			end
		end
		
		roomPlr = roomPlr + 1
	end
	
	if(roomPlr == 0) then
		scYPointer = scYPointer + conv(20)
		
		local length = dxGetTextWidth("There are no players in this room.",conv(1),"default-bold")
		dxDrawText("There are no players in this room.", (scPosX+((scWidth/2) - (length/2))), (scPosY+scYPointer)+conv(2.5),scWidth,scHeight, tocolor(255,255,255,255), conv(1), "default-bold","left","top",false,false,false,true)
	end
	
	local teamCount = 0
	for _,v in ipairs(teams) do
		if ((conv(25) + (conv(20)*(roomCount)) + ((teamCount+1)*conv(20)) + ((roomPlr-(scrPos))*conv(20))) > (screenY-conv(20))) then
			break
		end
		scYPointer = scYPointer + conv(20)
			
		dxDrawRectangle(scPosX, scPosY+scYPointer, scWidth, conv(20), tocolor(0,0,0,150), false)
		
		local r,g,b = getTeamColor(v)
		dxDrawText(getTeamName(v), scPosX+conv(6), (scPosY+scYPointer)+conv(2.5),scWidth,scHeight, tocolor(r,g,b,255), conv(1), "default-bold")
		
		teamCount = teamCount + 1
		for _,plr in ipairs(getPlayersInTeam(v)) do
			local roomCount = 0
			if(roomSelection == false) then
				roomCount = 2
			else
				roomCount = #roomsInfo
			end
			if ((conv(25) + (conv(20)*(roomCount)) + (teamCount*conv(20)) + ((roomPlr-(scrPos)+1)*conv(20))) > (screenY-conv(20))) then
				break
			end
		
			local plrRoom = (getElementData(plr,"bb.room") or -1)
			if(plrRoom == -1) then
				plrRoom = 1
			end
			
			if(plrRoom == selectedRoom) then
				scYPointer = scYPointer + conv(20)
				drawPlayer(plr,scPosX,scPosY,scYPointer)
				roomPlr = roomPlr + 1
			end
		end
	end
	
	avgYTick = scYPointer
	
	for _,v in ipairs(roomsInfo) do
		if(v.roomID ~= selectedRoom) then
			scYPointer = scYPointer + conv(20)
			
			if(roomSelection == false) then
				dxDrawRectangle(scPosX, scPosY+scYPointer, scWidth, conv(20), tocolor(27,161,226,180), false)
				dxDrawText("Other rooms", scPosX+conv(6), (scPosY+scYPointer)+conv(2.5),scWidth,scHeight, tocolor(255,255,255,255), conv(1), "default-bold")
		
				dxDrawText("select another room", (scPosX+conv(6)+conv(650)), (scPosY+scYPointer)+conv(2.5),scWidth,scHeight, tocolor(255,255,255,255), conv(1), "default-bold")
				break
			end
			
			if(v.maxPlayers > 0) then
				playerDisplay = getElementChildrenCount(getElementByID("room_"..tostring(v.roomID))).."/"..v.maxPlayers
			else
				playerDisplay = v.players
			end
			
			dxDrawRectangle(scPosX, scPosY+scYPointer, scWidth, conv(20), tocolor(27,161,226,180), false)
			dxDrawText(v.roomName.." ("..playerDisplay..")", scPosX+conv(6), (scPosY+scYPointer)+conv(2.5),scWidth,scHeight, tocolor(255,255,255,255), conv(1), "default-bold")
		
			dxDrawText("click to choose room", (scPosX+conv(6)+conv(650)), (scPosY+scYPointer)+conv(2.5),scWidth,scHeight, tocolor(255,255,255,255), conv(1), "default-bold")
		end
	end
	
	if(roomSelection == true) then
		scYPointer = scYPointer + conv(20)
		
		dxDrawRectangle(scPosX, scPosY+scYPointer, scWidth, conv(20), tocolor(27,161,226,180), false)
		dxDrawText("Close selection", scPosX+conv(6), (scPosY+scYPointer)+conv(2.5),scWidth,scHeight, tocolor(255,255,255,255), conv(1), "default-bold")
		
		dxDrawText("close room selection", (scPosX+conv(6)+conv(650)), (scPosY+scYPointer)+conv(2.5),scWidth,scHeight, tocolor(255,255,255,255), conv(1), "default-bold")
	end
	
	scYPointer = scYPointer + conv(20)
	local length = dxGetTextWidth("© Ultimate AIR Gamers (2010 - 2013)",conv(0.7),"default-bold")
	dxDrawText("© Ultimate AIR Gamers (2010 - 2013)", (scPosX+((scWidth/2) - (length/2))), (scPosY+scYPointer)+conv(3.5),scWidth,scHeight, tocolor(255,255,255,255), conv(0.7), "default-bold","left","top",false,false,false,true)
	
	scHeight = scYPointer + conv(20)
	loopPlayers = roomPlr
	loopTeams = teamCount
end

function drawPlayer(player,scPosX,scPosY,scYPointer)
	if(player == localPlayer) then
		dxDrawRectangle(scPosX, scPosY+scYPointer, scWidth, conv(20), tocolor(100,166,255,50), false)
	end
	
	local r,g,b = 255,255,255
	if(getPlayerTeam(player) ~= false) then
		r,g,b = getTeamColor(getPlayerTeam(player))
	end
	dxDrawText(getPlayerName(player), scPosX+conv(6), (scPosY+scYPointer)+conv(2.5),scWidth,scHeight, tocolor(r,g,b,255), conv(1), "default-bold","left","top",false,false,false,true)
		
	dxDrawText((getElementData(player,"UAG.Account.Country") or "XX"), (scPosX+conv(6)+conv(250)), (scPosY+scYPointer)+conv(2.5),scWidth,scHeight, tocolor(255,255,255,255), conv(1), "default")
	dxDrawText((getElementData(player,"UAG.Account.Points") or 0), (scPosX+conv(6)+conv(350)), (scPosY+scYPointer)+conv(2.5),scWidth,scHeight, tocolor(255,255,255,255), conv(1), "default")
	dxDrawText("$"..(getElementData(player,"UAG.Account.Cash") or 0), (scPosX+conv(6)+conv(450)), (scPosY+scYPointer)+conv(2.5),scWidth,scHeight, tocolor(255,255,255,255), conv(1), "default")
	dxDrawText((getElementData(player,"state") or "Nothing"), (scPosX+conv(6)+conv(550)), (scPosY+scYPointer)+conv(2.5),scWidth,scHeight, tocolor(255,255,255,255), conv(1), "default")
	dxDrawText((getElementData(player,"fps") or 0), (scPosX+conv(6)+conv(650)), (scPosY+scYPointer)+conv(2.5),scWidth,scHeight, tocolor(255,255,255,255), conv(1), "default")
	dxDrawText((getElementData(player,"ping") or 0), (scPosX+conv(6)+conv(750)), (scPosY+scYPointer)+conv(2.5),scWidth,scHeight, tocolor(255,255,255,255), conv(1), "default")
end

function clickScoreboard(button, state, cX, cY)
	local scYPointer = avgYTick
	
	if button == "left" and state == "down" then
		local scPosX = ((screenX/2) - (scWidth/2))
		local scPosY = ((screenY/2) - (scHeight/2))
		
		if(roomSelection == false) then
			scYPointer = scYPointer + conv(20)
			
			if (cX >= scPosX) and (cX <= (scPosX+scWidth)) and (cY >= scPosY+scYPointer) and (cY <= (scPosY+scYPointer)+conv(20)) then
				roomSelection = true
			end
			return
		end
		
		for _,v in ipairs(roomsInfo) do
			if(v.roomID ~= selectedRoom) then
				scYPointer = scYPointer + conv(20)
			
				if (cX >= scPosX) and (cX <= (scPosX+scWidth)) and (cY >= scPosY+scYPointer) and (cY <= (scPosY+scYPointer)+conv(20)) then
					selectedRoom = v.roomID
					triggerServerEvent("requestServerInfo",localPlayer)
				end
			end
		end
		
		if(roomSelection == true) then
			scYPointer = scYPointer + conv(20)
			
			if (cX >= scPosX) and (cX <= (scPosX+scWidth)) and (cY >= scPosY+scYPointer) and (cY <= (scPosY+scYPointer)+conv(20)) then
				roomSelection = false
			end
			return
		end
	end
end

function scrollScoreboard( _, _, scrollState)
	if(roomSelection == true) then
		return
	end

	if(scrPos <= 1 and scrollState == -1) then
		scrPos = 1
		return
	end
		
	if(((loopPlayers >= #roomPlayers) and (loopTeams >= #teams)) and scrollState == 1) then
			return
	end
		
	scrPos = scrPos + scrollState
end

addEventHandler("onClientRender",g_Root,
	function()
		if not starttick then
			starttick = getTickCount()
		end
		counter = counter + 1
		currenttick = getTickCount()
		if currenttick - starttick >= 1000 then
			setElementData(localPlayer,"fps",counter)
			counter = 0
			starttick = false
		end
	end
)

fileDelete("c_scoreboard.lua")