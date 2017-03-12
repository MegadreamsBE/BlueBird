addEventHandler("onResourceStart", resourceRoot,
	function()
		for i,player in ipairs(getElementsByType("player")) do
			spawn(player)
		end
	end
)

addEventHandler("onPlayerSpawn", resourceRoot,
	function()
		local player = source
		showPlayerHudComponent(player, "ammo", false)
		showPlayerHudComponent(player, "area_name", false)
		showPlayerHudComponent(player, "armour", false)
		showPlayerHudComponent(player, "breath", false)
		showPlayerHudComponent(player, "clock", false)
		showPlayerHudComponent(player, "health", false)
		showPlayerHudComponent(player, "money", false)
		showPlayerHudComponent(player, "vehicle_name", false)
		showPlayerHudComponent(player, "weapon", false)
		showPlayerHudComponent(player, "wanted", false)
	end
)


function spawn(player)
	if not isElement(player) then return end
	fadeCamera(player, true)
	spawnPlayer(player,0.0,0.0,5.0,0.0,0)
	setCameraTarget(player, player)
	showChat(player, true)
	fadeCamera(player, false)
	
	showPlayerHudComponent(player, "ammo", false)
	showPlayerHudComponent(player, "area_name", false)
	showPlayerHudComponent(player, "armour", false)
	showPlayerHudComponent(player, "breath", false)
	showPlayerHudComponent(player, "clock", false)
	showPlayerHudComponent(player, "health", false)
	showPlayerHudComponent(player, "money", false)
	showPlayerHudComponent(player, "vehicle_name", false)
	showPlayerHudComponent(player, "weapon", false)
	showPlayerHudComponent(player, "wanted", false)
end

addEventHandler("onPlayerJoin", root,
	function()
		spawn(source)
	end
)