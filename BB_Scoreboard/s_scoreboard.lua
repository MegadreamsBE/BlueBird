-- Variables
g_Root = getRootElement()

-- Events

addEvent("requestServerInfo",true)
addEventHandler("requestServerInfo",g_Root,
	function()
		local svInfo = {
			["name"] = getServerName(),
			["maxPlayers"] = getMaxPlayers()
		}
		triggerClientEvent(source,"onServerInfoReceived",g_Root,svInfo,exports.BB_Rooms:getDefaultRooms())
	end
)