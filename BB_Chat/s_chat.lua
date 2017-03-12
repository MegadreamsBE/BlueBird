function SendMSG(message, type)
	if(isPlayerMuted(source)) then
		cancelEvent()
		outputChatBox("[GLOBAL]: #FF0000You are muted and cannot talk.", 27,161,226, true)
		return
	end
	if((getElementData(source,"bb.room") or -1) == -1) then
		cancelEvent()
		outputChatBox("[LOADER]: #91FFFFYou are currently not in a room. Press 'G' for the global chat.",source,27,161,226,true)
		return
	end
	if(type == 0) then
		for _,v in ipairs(exports.BB_Rooms:getPlayersInRoom(getElementData(source,"bb.room"))) do
			cancelEvent()
			local r,g,b = getPlayerNametagColor(source)
			local playerName = getPlayerName(source)
			outputChatBox(playerName ..":#F2E8C9 " .. message, v, r, g, b, true)
		end
	elseif(type == 2) then
		local r,g,b = getPlayerNametagColor(source)
		local tr,tg,tb = getTeamColor(getPlayerTeam(source))
		local playerName = getPlayerName(source)
		
		for _,v in ipairs(getPlayersInTeam(getPlayerTeam(source))) do
			cancelEvent()
			outputChatBox("(team) "..RGBToHex(r,g,b)..playerName ..":#F2E8C9 " ..message, v, tr,tg,tb, true)
		end
	end
end
addEventHandler("onPlayerChat", getRootElement(), SendMSG)

function SendGlobalMSG(player, command, ...)
	if(isPlayerMuted(player)) then
		outputChatBox("[GLOBAL]: #FF0000You are muted and cannot talk.", 27,161,226, true)
		return
	end
	local arg = {...}
	local message = table.concat( arg, " " )
	
	local r,g,b = getPlayerNametagColor(player)
	local playerName = getPlayerName(player)
	outputChatBox("(global) "..RGBToHex(r,g,b)..playerName ..":#F2E8C9 " ..message, getRootElement(), 27,161,226, true)
end
addCommandHandler("Global",SendGlobalMSG)

function RGBToHex(red, green, blue)
	if((red < 0 or red > 255 or green < 0 or green > 255 or blue < 0 or blue > 255)) then
		return nil
	end
	
	return string.format("#%.2X%.2X%.2X", red,green,blue)
end