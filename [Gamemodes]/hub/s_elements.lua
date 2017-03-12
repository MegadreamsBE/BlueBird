function giveParachute()
	giveWeapon(source, 46, 1, true)
end

addEvent("onPlayerNeedsParachute",true)
addEventHandler("onPlayerNeedsParachute", root, giveParachute)

function setDim(dim)
	setElementDimension(source,dim)
end

addEvent("onPlayermovePlayerToDim",true)
addEventHandler("onPlayermovePlayerToDim",root, setDim)

addEventHandler( "onPlayerWasted", getRootElement( ),
	function()
		if(getElementData(source,"bb.room") ~= g_roomID) then return end
		spawnPlayer(source,2121.3635253906,1333.107421875,10.8203125,90, 0, 0,1)
	end
)