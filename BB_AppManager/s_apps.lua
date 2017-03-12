---------------------------------<
-- Application Manager
-- s_apps.lua
---------------------------------<

local QuickAccesOfUsers = {}

function getPlayerExtraApps(player)
	return {} -- Doing it later when the market place is done.
end

function setPlayerQuickAcces(player,list)
	QuickAccesOfUsers[player] = list
end

function getPlayerQuickAcces(player)
	return QuickAccesOfUsers[player]
end