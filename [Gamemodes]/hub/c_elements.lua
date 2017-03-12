local ParachuteShader = dxCreateShader ( "shader/window.fx" )
local ParachuteTile = exports.BB_GUI:dxCreateTile(0,0,128,128,false,false,false,0)
local ParachutePane = exports.BB_GUI:dxCreateScrollPane(0,0,1,1,ParachuteTile,true,true)
exports.BB_GUI:dxSetPaneSize(ParachutePane, 0,1,true,true)
local ParachutePointA = exports.BB_GUI:dxCreateFocusPoint(0,0,ParachutePane,true,true)
local ParachutePointB = exports.BB_GUI:dxCreateFocusPoint(0,1,ParachutePane,true,true)
exports.BB_GUI:dxCreateImage(0,1,1,1,"images/parachute.png",ParachutePane,true,true)
exports.BB_GUI:dxCreateImage(0,0,1,1,"images/arrow.png",ParachutePane,true,true)
local ParachuteShown = false
local ParachutePickups = {}
local ParachuteMarkers = {}

dxSetShaderValue(ParachuteShader, "Tex0", exports.BB_GUI:dxGetRawData(ParachuteTile, "render"))

function updateParachuteSlider()
	if not ParachuteShader then return end -- Waits till everything is destroyed
	ParachuteShown = not ParachuteShown
	if ParachuteShown then
		exports.BB_GUI:dxScrollPaneFocusTo(ParachutePane, ParachutePointB, "OutQuad")
	else
		exports.BB_GUI:dxScrollPaneFocusTo(ParachutePane, ParachutePointA, "OutQuad")
	end
end
setTimer(updateParachuteSlider, 3000,0)


function fixElements()
	local ResourceRoot = getResourceRootElement(getResourceFromName("BB_Maps"))
	local objects = getElementsByType("object",ResourceRoot)
	for k, object in ipairs(objects) do
		if getElementModel(object) == 16000 then
			setElementAlpha(object, 0)
		elseif getElementModel(object) == 2729 then
			engineApplyShaderToWorldTexture ( ParachuteShader, "binc_tshirt", object)
			dxSetShaderValue ( ParachuteShader, "gTexture", exports.BB_GUI:dxGetRawData(ParachuteTile,"render") ) -- Refresh
		end
	end
	engineSetModelLODDistance ( 2729, 100 )
end

function destroyOtherThings()
	destroyElement(ParachuteShader)
	exports.BB_GUI:dxDestroyElement(ParachuteTile)

	for k, v in pairs(ParachutePickups) do
		destroyElement(v)
	end
	for k, v in pairs(ParachuteMarkers) do
		destroyElement(v)
	end
end

function createParachutePoint(x,y,z)
	-- Create's a parachute at coordinates.
	-- Teleports player to Z: 1500
	-- Shows QuickText about how to open parachute.
	local pickup = createPickup(x,y,z, 2, 46, 250, 1)
	local marker = createMarker(x,y,z, "corona", 2, 0,0,0,0)
	setElementDimension(pickup, 1)
	setElementDimension(marker, 1)
	addEventHandler("onClientMarkerHit", marker, function(elem, dim)
		if (elem == getLocalPlayer()) and (dim) then
			setElementPosition(getLocalPlayer(), x,y,1500)
			quickText("Fire to open the parachute.", g_ScreenStartX+800/2, g_ScreenStartY+500, 20, 2000,tocolor(255,255,255,255),"center")
			triggerServerEvent("onPlayerNeedsParachute", getLocalPlayer())
		end
	end)
	table.insert(ParachutePickups,pickup)
	table.insert(ParachuteMarkers,marker)
end

createParachutePoint(2096.2497558594, 1286.1103515625, 10.8203125)


addEventHandler("onClientResourceStop",g_ResourceRoot,
	function()
		engineRemoveShaderFromWorldTexture ( BlancShader, "drvin_screen", ScreensList.DerbyDestruction.Screen)
		engineRemoveShaderFromWorldTexture ( BlancShader, "drvin_screen", Screen)
		engineRemoveShaderFromWorldTexture ( BlancShader, "drvin_front", Screen)
	end
)