g_Root = getRootElement()
g_Resource = getThisResource()
g_ResourceRoot = getResourceRootElement(g_Resource)

URL = "ultimateairgamers.com"
SQLCon = false

local lastUpdateDay = -1
local lastPass = nil
local lastTime = 0

function SQL()
	if not SQLCon then
		SQLCon = dbConnect("mysql", "dbname=zadmin_uagserv;host="..URL,"uagserv", "2e9y4une7")
	end
	return SQLCon
end


addEventHandler ( "onResourceStart", g_ResourceRoot,
	function(g_ResourceRoot)
		setTimer(checkServerState,30000,0)
	end
)

function checkServerState()
	local date = getRealTime()
	local dDay = date.weekday
	local dHour = date.hour
	
	if(dHour <= 1) then
		dDay = dDay - 1
	end
	if(dHour == 0) then
		dHour = 24
	end
	dHour = dHour - 2
	
	dbQuery(onServerState, SQL(), "SELECT * FROM timetable WHERE day=? and time=?", dDay, dHour)
end

function onServerState(qh)
	local result = dbPoll(qh, 0)
	local date = getRealTime()
	
	if(result[1]["state"] == 0) then
		if not (lastUpdateDay == result[1]["day"]) then
			local gPassword = generatePassword()
			setServerPassword(gPassword)
			lastPass = gPassword
			
			callRemote ( "http://www.ultimateairgamers.com/uag/spassword.php", function() end, gPassword)
			
			for _,v in ipairs(getElementsByType("player")) do
				kickPlayer(v,"Beta closed, please come back later. View the beta timetable on our forum. (www.ultimateairgamers.com)")
			end

			refreshResources(true)
			exports.BB_Boot:restartBlueBird()
		else
			if(getServerPassword() == nil) then
				setServerPassword(lastPass)
				
				for _,v in ipairs(getElementsByType("player")) do
					kickPlayer(v,"Beta closed, please come back later. View the beta timetable on our forum. (www.ultimateairgamers.com)")
				end

				refreshResources(true)
				exports.BB_Boot:restartBlueBird()
			end
		end
	else
		local dNHour = date.hour
		local dNDay = date.weekday
		
		if(dNHour < 1) then
			dNDay = dDNay - 1
		end
		if(dNHour == 0) then
			dNHour = 24
		end
		dNHour = dNHour - 1
		
		if(dNHour == 23) then
			dNHour = 0
			dNDay = dNDay + 1
		end
		
		if(getServerPassword() ~= nil) then
			setServerPassword(nil)
		end
		dbQuery(onCheckState, SQL(), "SELECT * FROM timetable WHERE day=? and time=?", dNDay, dNHour)
	end
	
	lastUpdateDay = result[1]["day"]
end

function onCheckState(qh)
	local result = dbPoll(qh, 0)
	local date = getRealTime()

	if(result[1]["state"] == 0) then
		if((date.timestamp - lastTime) >= 240) then
			triggerClientEvent("onServerClosing",getRootElement(),(60-date.minute))
			lastTime = date.timestamp
		end
	end
end

function generatePassword()
	local seed = math.random(10000,9999999)
	local shaString = sha256(seed)
	
	local hSeed = math.random(7,12)
	return string.sub(shaString, 1, hSeed)
end