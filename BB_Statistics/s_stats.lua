function onPlayerDieStatistics(player,pos,count)
	local playerRoom = (getElementData(player,"bb.room") or -1)
	
	if((getElementData(player, "UAG.Account.Logged") or false) == false) then
		outputChatBox("[STATS]: #91FFFFWhen you login you are able to receive statistics.", player, 27,161,226, true)
		return
	end
	local roomInfo = exports.BB_Rooms:getRoomInformation(playerRoom)
	
	if(roomInfo.default ~= true) then
		outputChatBox("[STATS]: #91FFFFThis room is not supporting statistics.", player, 27,161,226, true)
		return
	end
	
	if(count < 3) then
		outputChatBox("[STATS]: #91FFFFThere are less than 3 players in this room.", player, 27,161,226, true)
		outputChatBox("[STATS]: #91FFFFYour statistics will not change to avoid statistic faking.", player, 27,161,226, true)
		return
	end
	
	if(pos == count) then
		pos = pos - 1
	end
	local earnedCash = math.round((10*(count-pos)),0)
	local earnedPoints = math.round((2*(count-pos)),0)
	
	setElementData(player,"UAG.Account.Cash",getElementData(player,"UAG.Account.Cash")+earnedCash)
	setElementData(player,"UAG.Account.Points",getElementData(player,"UAG.Account.Points")+earnedPoints)
	outputChatBox("[STATS]: #91FFFFYou have died, you earned #64a6ff$"..earnedCash.." #91FFFFand #64a6ff"..earnedPoints.." #91FFFFpoints.", player, 27,161,226, true)
end

function math.round(number, decimals, method)
    decimals = decimals or 0
    local factor = 10 ^ decimals
    if (method == "ceil" or method == "floor") then return math[method](number * factor) / factor
    else return tonumber(("%."..decimals.."f"):format(number)) end
end