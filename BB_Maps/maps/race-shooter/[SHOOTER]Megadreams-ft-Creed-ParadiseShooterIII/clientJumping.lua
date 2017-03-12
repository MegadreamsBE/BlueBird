-- This script is created by MegaDreams for [FUN] MegaDreams ft. CreeD - Paradise Shooter III, Don't even think about stealing it.

function plrJump()
	local theVehicle = getPedOccupiedVehicle(getLocalPlayer())
	if isVehicleOnGround(theVehicle) and not isPlayerDead(getLocalPlayer()) then
		local vx,vy,vz = getElementVelocity(theVehicle)
		setElementVelocity(theVehicle,vx,vy,0.2)
	end
end

for keyName, state in pairs(getBoundKeys("jump")) do
	bindKey(keyName, "down", plrJump)
end