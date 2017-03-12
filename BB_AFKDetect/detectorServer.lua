-- AFK Detector script
-- Made by Dr.CrazY

function outputMessage(text)
	outputChatBox("#FF0000*#FFFFFF "..text, getRootElement(),  255, 255, 255, true)
end

function onKickedHandler (maxafk)
	outputMessage("Player "..getPlayerName(source).."#FFFFFF has been kicked for being AFK #939EAB["..maxafk.."/"..maxafk.."]")
	kickPlayer ( source, "AFK Detector", "Reason: being AFK too much" )
end

addEvent( "onKickedForAFK", true )
addEventHandler( "onKickedForAFK", getRootElement(), onKickedHandler )

function onKilledHandler ( countafk, maxafk )
	outputMessage("Player "..getPlayerName(source).."#FFFFFF has been killed for being AFK #939EAB["..countafk.."/"..maxafk.."]")
end

addEvent( "onKilledForAFK", true )
addEventHandler( "onKilledForAFK", getRootElement(), onKilledHandler )

-- AUTO-KILL ( /afk )

local autoKillsCounting = false
local countingTimer = nil
local autoKilledPlayers = {}

function updateList(playerName)
	table.insert(autoKilledPlayers, playerName)
end

function startCounting()
	countingTimer = setTimer(stopCounting, 2000, 1)
	autoKillsCounting = true
end

function stopCounting()
	killTimer(countingTimer)
	countingTimer = nil
	autoKillsCounting = false
	if(#autoKilledPlayers == 1)then
		outputMessage("Player "..autoKilledPlayers[1].."#FFFFFF has been auto-killed for being AFK")	
	else
		local i = 1
		local lstr = ""
		while(i < #autoKilledPlayers)do
			lstr = lstr..autoKilledPlayers[i].."#FFFFFF, "
			i = i + 1
		end
		lstr = lstr..autoKilledPlayers[#autoKilledPlayers].."#FFFFFF"
		outputMessage("Players "..lstr.." has been auto-killed for being AFK")	
	end
	autoKilledPlayers = {}
end

function onAutoKilledHandler()
	updateList(getPlayerName(source))
	if(not autoKillsCounting)then
		startCounting()
	end
end

addEvent( "onAutoKilled", true )
addEventHandler( "onAutoKilled", getRootElement(), onAutoKilledHandler )

function playerChat(message, messageType)
	if(string.find(message, "afk") ~= nil or string.find(message, "Afk") ~= nil or string.find(message, "AFK") ~= nil)then
		triggerClientEvent ( source, "onTipTriggered", source )
	end
end
addEventHandler("onPlayerChat", root, playerChat)