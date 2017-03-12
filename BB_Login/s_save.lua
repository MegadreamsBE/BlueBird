---------------------------------<
-- Login System
-- s_save.lua
--[[-----------------------------<
-- This is actually part of logging out.
-- But the data save is put here for
-- better overview. :)
--]]-----------------------------

g_ResourceRoot = getResourceRootElement(getThisResource())

addEvent("onUserSaveAllTheThings",true)
addEventHandler("onUserSaveAllTheThings", root,
	function()
		-- Player Logs out or Quits
		redirectPlayer(source,"ultimateairgamers.com", 22003)

		savePlayerStats(source)
	end
)

function savePlayerStats(player)
	local id = (getElementData(player, "UAG.Account.ID", false) or -1)
	local cash = (getElementData(player, "UAG.Account.Cash",false) or 0)
	local credits = (getElementData(player, "UAG.Account.Credits",false) or 0)
	local points = (getElementData(player, "UAG.Account.Points",false) or 0)
	local deaths = (getElementData(player, "UAG.Account.Deaths",false) or 0)
	local hunters = (getElementData(player, "UAG.Account.Hunters",false) or 0)

	dbExec(SQL(), "UPDATE users SET cash=?, credits=?, points=?, deaths=?, hunters=? WHERE member_id=?", cash,credits,points,deaths,hunters,id)

	local apps = exports.BB_AppManager:getPlayerExtraApps(player)
	dbExec(SQL(), "DELETE FROM applications WHERE member_id=?",id)
	for k, app in ipairs(apps) do
		dbExec(SQL(),"INSERT INTO applications (member_id, app_name) VALUES(?,?)", id, app)
	end

	local layout = exports.BB_AppManager:getPlayerQuickAcces(player)
	dbExec(SQL(), "DELETE FROM quickacces WHERE member_id=?",id)
	for rowID, row in ipairs(layout) do
		dbExec(SQL(),"INSERT INTO applications (row,column1,column2,column3,column4,column5,column6) VALUES(?,?,?,?,?,?,?)", id, row[1], row[2], row[3], row[4], row[5], row[6])
	end
end

function saveAllStats()
	for _,v in ipairs(getElementsByType("player")) do
		if ((getElementData(v, "UAG.Account.Logged") or false) == true) then
			savePlayerStats(v)
		end
	end
end

addEventHandler ( "onResourceStart", g_ResourceRoot,
	function(g_ResourceRoot)
		setTimer(saveAllStats,240000,0)
	end
)

addEventHandler ( "onResourceStop", g_ResourceRoot,
	function(g_ResourceRoot)
		saveAllStats()
	end
)