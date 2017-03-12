function removeColorCoding ( name )
	return type(name)=='string' and string.gsub ( name, '#%x%x%x%x%x%x', '' ) or name
end

function pm(playerSource, command, arg1,...)
function findPlayerByName(playerPart)
    local pl = removeColorCoding(getPlayerFromName(removeColorCoding(playerPart)))
	if ( pl ) then return pl end
	local matches = {}
	for id, pl in ipairs ( getElementsByType ( "player" ) ) do
		if ( string.find ( string.upper ( removeColorCoding(getPlayerName ( pl )) ), string.upper ( playerPart ), 1, true ) ) then
			table.insert(matches,pl)
		end
	end
	if #matches == 0 then
		return false, outputChatBox("PM: '" .. playerPart .. "' matches no players.",playerSource,255,0,0)
	elseif #matches == 1 then
		return matches[1]
	else
		return false, outputChatBox("PM: '" .. playerPart .. "' matches ".. tostring(#matches) .. " players.",playerSource,255,0,0)
	end
 end
		if arg1 == nil then
			outputChatBox("PM: You have to specify player name", playerSource, 255, 0, 0, true)
		else
			local playerElement = findPlayerByName(arg1)
			if playerElement then
				local name = removeColorCoding(getPlayerName(playerElement))
				local sourceName = removeColorCoding(getPlayerName(playerSource))
					local veve = {...}
					local message = table.concat(veve, " ")
					if message == "" then
					outputChatBox("PM: You have to write your message", playerSource, 255, 0, 0, true)
					else
					outputChatBox("PM: "..sourceName..": "..message,playerElement,255,0,255,true)
					outputChatBox("PM: Message Sent To "..name, playerSource,0,255,255)
					end
			else
				local sourceName = removeColorCoding(getPlayerName(playerSource))
--				outputChatBox("PM: player not found", playerSource,255,0,0)
			end
		end
end
addCommandHandler("PM", pm)
addCommandHandler("pm", pm)