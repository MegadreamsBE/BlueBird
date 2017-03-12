local keyTimers = {}

function onKeyTimeOut(player)
	for id,plr in ipairs (keyTimers) do
		if(plr.player == player) then
			table.remove(keyTimers,id)
			break
		end
	end
	outputChatBox("[VERIFY]: #FF0000Verify request timed out, try again later.",player,255,128,0,true)
end

function onKeyResult(player,status)
	for id,plr in ipairs (keyTimers) do
		if(plr.player == getPlayerFromName(player)) then
			table.remove(keyTimers,id)
			killTimer(plr.timer)
			break
		end
	end
	
	if(status == 0) then
		outputChatBox("[VERIFY]: #FF0000Sorry, this key belongs to nobody.",getPlayerFromName(player),255,128,0,true)
		return
	end
	if(status == 1) then
		outputChatBox("[VERIFY]: #FF0000The key belongs not to you.",getPlayerFromName(player),255,128,0,true)
		return
	end
	if(status == 2) then
		setPlayerMuted(getPlayerFromName(player),false)
		outputChatBox("[VERIFY]: #00FF00Key verified, BlueBird will launch.",getPlayerFromName(player),255,128,0,true)
		triggerClientEvent(getPlayerFromName(player),"keyVerified",getRootElement())
		return
	end
end

function onMutePlayer()
	setPlayerMuted(source,true)
end
addEvent("onPlayerGetMuted",true)
addEventHandler( "onPlayerGetMuted", getRootElement(), onMutePlayer)

function onKeyVerify(key)
	local keyTimer = setTimer (onKeyTimeOut, 5000, 1, source)
	table.insert(keyTimers ,{player = source, timer = keyTimer})

	callRemote ( "some-url", onKeyResult, getPlayerName(source), getPlayerIP(source), getPlayerSerial(source), key)
end
addEvent("verifyKey",true)
addEventHandler("verifyKey",getRootElement(),onKeyVerify)