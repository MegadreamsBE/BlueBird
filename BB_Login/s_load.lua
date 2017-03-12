---------------------------------<
-- Login System
-- s_load.lua
---------------------------------<

function getPlayerFromDataValue(what, value)
	local players = getElementsByType("player")
	local player = false
	for k, v in ipairs(players) do
		if getElementData(v, what, false) == value then
			player = v
		end
	end
	return player
end

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

---------------------------------<

URL = "some-url"
SQLCon = false

function SQL()
	if not SQLCon then
		SQLCon = dbConnect("mysql", "dbname=name;host="..URL,"user", "pass")
	end
	return SQLCon
end

g_ResourceRoot = getResourceRootElement(getThisResource())

addEventHandler ( "onResourceStart", g_ResourceRoot,
	function(g_ResourceRoot)
		createTeam("UAG Members",0,69,159)
		createTeam("Premiums",0, 255,64)
	end
)

addEventHandler ( "onResourceStop", g_ResourceRoot,
	function(g_ResourceRoot)
		destroyElement(getTeamFromName("UAG Members"))
		destroyElement(getTeamFromName("Premiums"))
	end
)


function startLoading()
	local id = getElementData(source, "UAG.Account.ID", false)
	
	-- NOTE: To prevent any lag, we'll not use dbPoll(query, -1), but dbPoll(query,0) with function callback
	dbQuery(checkPlayer, {source,id}, SQL(), "SELECT * FROM users WHERE member_id=?", id)
end

function checkPlayer(qh,player,id)
	local result,num_affected_rows = dbPoll( qh, 0 )
	local groups = getElementData(player, "UAG.Account.Groups", false)
	if num_affected_rows == 0 then
		local name = getElementData(player, "UAG.Account.Name", false)
		
		dbExec(SQL(),"INSERT INTO users (member_id,name,cash,credits,groups) VALUES(?,?,?,?,?)", id, name, 0, 0, table.concat(groups, "|"))
	else
		-- Update Groups & Display Name
		dbExec(SQL(), "UPDATE users SET groups=? WHERE member_id=?", table.concat(groups, "|"),id)
	end
	setTimer(downloadData, 3000,1,player,id) -- TIMERS.. Y U NO LOVE THEM!?
end

function downloadData(player, id)

	dbQuery(importData, {player,id}, SQL(), "SELECT cash,credits,points,deaths,hunters FROM users WHERE member_id=?", id)
	dbQuery(importApplications, {player,id}, SQL(),"SELECT app_name FROM applications WHERE member_id=?", id)
end

function importData(qh,player,id)
	local result,num_affected_rows = dbPoll( qh, 0 )

	setElementData(player, "UAG.Account.Cash", result[1]["cash"])
	setElementData(player, "UAG.Account.Credits", result[1]["credits"])
	setElementData(player, "UAG.Account.Points", result[1]["points"])
	setElementData(player, "UAG.Account.Deaths", result[1]["deaths"])
	setElementData(player, "UAG.Account.Hunters", result[1]["hunters"])
end

function importApplications(qh, player,id)
	local result = dbPoll( qh, 0 )
	-- result[<any random number>]["app_name"] = App 1
	-- result[<any higher random number>]["app_name"] = App 2

	local list = {}
	for k, item in pairs(result) do
		table.insert(list, item.app_name)
	end
	-- list[1] = App 1
	-- list[2] = App 2

	local default = {"App_Calculator", "App_Message", "App_Logout", "App_Sandbox", "App_Settings"}
	for k, item in pairs(default) do
		if not table.find(list, item) then table.insert(list,item) end
	end

	setTimer(loadMenu, 3000,1,player,id,list)
end

function loadMenu(player,id,list)
	triggerClientEvent(player, "onClientWantApplications", g_ResourceRoot, list)

	setTimer(getQuickAccesTable, 3000,1,player,id,list)
end

function getQuickAccesTable(player,id,list)
	dbQuery(checkQuickAccesTable, {player,id,list}, SQL(), "SELECT * FROM quickacces WHERE member_id=?", id)
end

function checkQuickAccesTable(qh,player,id,list)
	local result,num_affected_rows = dbPoll( qh, 0 )
	local endResult = defaultQuickAcces
	if num_affected_rows == 0 then 
		for key, row in ipairs(defaultQuickAcces) do
			dbExec(SQL(),"INSERT INTO quickacces (member_id,row,column1,column2,column3,column4,column5,column6) VALUES(?,?,?,?,?,?,?,?)", id, key, row[1],row[2],row[3],row[4],row[5],row[6])
		end
	else
		local tab = {}
		for _, row in ipairs(result) do
			tab[tonumber(row["row"])] = {row["column1"],row["column2"],row["column3"],row["column4"],row["column5"],row["column6"]}
		end
		endResult = tab
	end

	triggerClientEvent(player,"onClientInitializeQuickAccesNeeded", g_ResourceRoot, endResult)

	setTimer(createApplicationsList, 3000,1,player,list)
end

function createApplicationsList(player,list)
	triggerClientEvent(player,"onClientInitializeAppsListNeeded", g_ResourceRoot, list)

	exports.BB_AppManager:setPlayerQuickAcces(player,list)

	setTimer(createRoomsMenu, 3000,1,player)
end

function createRoomsMenu(player)
	triggerClientEvent(player,"onClientInitializeRoomsNeeded", g_ResourceRoot)
end

addEvent("onGetHubID",true)
addEventHandler("onGetHubID",root,
	function()
		triggerClientEvent(source,"onLoadHub",getRootElement(),exports.BB_Rooms:getRoomIDAssociatedWithGamemode("hub"))
	end
)

---------------------------------<
-- DEFAULT GRID OF QUICK ACCES
-- 6 mini block width, #inf height
---------------------------------<

defaultQuickAcces = {
	-- Testing Grid (Still making applications)
	[1] = {"App_Logout", 	"App_Logout",	"App_Message",		"App_Message",	"App_Message",	"App_Message"},
	[2] = {"App_Logout", 	"App_Logout",	"App_Message",		"App_Message",	"App_Message",	"App_Message"}


	--[[ Final grid
	[1] = {"App_Message", 	"App_Call",		"App_GS",			"App_GS",		"App_GS",		"App_GS"},
	[2] = {"App_Market",	"App_Premium",	"App_GS",			"App_GS",		"App_GS",		"App_GS"},
	[3] = {"App_Friends",	"App_Friends",	"App_Calculator",	"App_Calendar",	"App_Twitter",	"App_Twitter"},
	[4] = {"App_Friends",	"App_Friends",	"App_Clock",		"",				"App_Twitter",	"App_Twitter"},
	[5] = {"App_RSS",		"App_RSS",		"App_RSS",			"App_RSS",		"App_Music",	"App_Music"},
	[6] = {"App_RSS",		"App_RSS",		"App_RSS",			"App_RSS",		"App_Music",	"App_Music"}
	--]]
}


---------------------------------<

addEvent("onPlayerGoesLoading", true)
addEventHandler("onPlayerGoesLoading", root, startLoading)
