---------------------------------<
-- Login System
-- s_login.lua
---------------------------------<

IPS = "some-url"

function attemptLogin(how,nick,pass)
	local player = source
	local id = false
	local dname = false
	
	local function SetGroups(groups,id)
		local tab = {}
		for id,val in pairs(groups) do
			table.insert(tab,val)
		end
		setElementData(player, 'UAG.Account.Groups', tab)
		
		if(isInGroup(player,"Premium")) then
			setPlayerTeam(player,getTeamFromName("Premium"))
		end
		
		if(isInGroup(player,"UAG Member")) then
			setPlayerTeam(player,getTeamFromName("UAG Members"))
		end
	end

	local function Auth(bool, nick)
		if bool == true then -- Authed
			setElementData(player, "UAG.Account.Logged", true)
			setElementData(player, "UAG.Account.Name", nick)
			setElementData(player, "UAG.Account.ID", id)
			setElementData(player, "UAG.Account.DisplayName", dname)

			callRemote(IPS, SetGroups
			,md5("S908LKn3,zxcLJKsa(asj2"), "groups", id)

			triggerClientEvent(player, "onLoginSucces",player,how,nick,pass)
		else -- Wrong pass
			if how == "fill" then
				triggerClientEvent(player, "onLoginFailed",player)
			end
		end
	end

	local function loginWithID(id)
		local result = callRemote(IPS, Auth
		,md5("S908LKn3,zxcLJKsa(asj2"), "auth", tostring(id), pass, nick)
	end

	local function check(data,code)
		if type(data) == "table" then
			id = data.member_id
			dname = data.name
			
			loginWithID(data.member_id)
		else
			-- Auto Login only works when "UAG.Account.Logged" is set @ player, so just ignore then if it doesn't work.
			if how == "fill" then
				triggerClientEvent(player, "onLoginFailed",player)
			end
		end
	end

	local result = callRemote(IPS, check
		,md5("S908LKn3,zxcLJKsa(asj2"), "fetch", nick, 'username')
end

function isInGroup(player,group)
	local groups = getElementData(player,"UAG.Account.Groups")
	for _,v in ipairs(groups) do
		if(v == group) then
			return true
		end
	end
	return false
end

---------------------------------<

addEvent("onAttemptToLogin",true)
addEventHandler("onAttemptToLogin",root, attemptLogin)
