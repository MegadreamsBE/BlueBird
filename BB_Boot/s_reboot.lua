---------------------------------<
-- Bluebird Reboot
---------------------------------<

g_Resource = getThisResource()
g_ResourceRoot = getResourceRootElement(g_Resource)

Resources = {
[1] = "Apps",
[2] = "BB_Base",
[3] = "BB_Login",
[4] = "BB_GUI",
[5] = "BB_Notify",
[6] = "BB_AppManager",
[7] = "BB_Maps",
[8] = "BB_Rooms",
[9] = "BB_Menu",
[10] = "BB_Statistics",
[11] = "BB_Carfade",
[12] = "BB_Radar",
[13] = "BB_Names",
[14] = "BB_Chat",
[15] = "BB_Scoreboard",
[16] = "BB_AFKDetect",
[17] = "BB_Privatemessages"
}

Working = false
Current = 1
loading = false

addEventHandler("onResourceStop", g_ResourceRoot,
	function()
		startResource(getResourceFromName("BB_Loading"))
	end
)

addCommandHandler("BB_QuickReboot",
	function()
		if Working == true then return else Working = true end
		Current = 1

		startResource(getResourceFromName("BB_Loading"))
		outputDebugString("Stopping Bluebird resources, (re)starting in 3 seconds.", 3,55,167,220)
		for num, res in ipairs(Resources) do
			if res == "Apps" then
				for _, Resource in ipairs(getResources()) do
					if string.sub(getResourceName(Resource), 1, 4) == "App_" then
						stopResource(Resource)
					end
				end
			else
				stopResource(getResourceFromName(res))
			end
		end

		setTimer(
			function()
				outputDebugString("Starting Bluebird.", 3,55,167,220)
				loading = true
				forceLoad()
				outputDebugString("Bluebird rebooted.", 3,55,167,220)			
				stopResource(getResourceFromName("BB_Loading"))
			end
		, 3000, 1)
	end
)

addCommandHandler("BB_ForceStop",
	function()
		outputDebugString("Forcing Bluebird to stop.", 3,55,167,220)
		startResource(getResourceFromName("BB_Loading"))
		for num, res in ipairs(Resources) do
			if res == "Apps" then
				for _, Resource in ipairs(getResources()) do
					if string.sub(getResourceName(Resource), 1, 4) == "App_" then
						stopResource(Resource)
					end
				end
			else
				stopResource(getResourceFromName(res))
			end
		end
		outputDebugString("Bluebird stopped.", 3,55,167,220)
	end
)

function forceLoad()
	if not Resources[Current] then
		Working = false
		stopResource(getResourceFromName("BB_Loading"))
		return
	end
	outputDebugString("Starting "..Resources[Current], 3,55,167,220)
	if Resources[Current] == "Apps" then
		for _, Resource in ipairs(getResources()) do
			if string.sub(getResourceName(Resource), 1, 4) == "App_" then
				startResource(Resource)
			end
		end
	else	
		if( Resources[Current] == "BB_Menu") then
			stopResource(getResourceFromName("BB_Loading"))
			loading = false
		else
			if(loading == true) then
				startResource(getResourceFromName("BB_Loading"))
			end
		end
		startResource(getResourceFromName(Resources[Current]))
	end
	
	Current = Current + 1
	setTimer(forceLoad, 1000,1)
end

function restartBlueBird()
	if Working == true then return else Working = true end
	Current = 1

	startResource(getResourceFromName("BB_Loading"))
	outputDebugString("Stopping Bluebird resources, (re)starting in 3 seconds.", 3,55,167,220)
	for num, res in ipairs(Resources) do
		if res == "Apps" then
			for _, Resource in ipairs(getResources()) do
				if string.sub(getResourceName(Resource), 1, 4) == "App_" then
					stopResource(Resource)
				end
			end
		else
			stopResource(getResourceFromName(res))
		end
	end

	setTimer(
		function()
			outputDebugString("Starting Bluebird.", 3,55,167,220)
			loading = true
			forceLoad()
			outputDebugString("Bluebird rebooted.", 3,55,167,220)			
			stopResource(getResourceFromName("BB_Loading"))
		end
	, 3000, 1)
end

addEventHandler("onResourceStart",g_ResourceRoot,
	function()
		startResource(getResourceFromName("BB_Loading"))
		loading = true
		forceLoad()
		outputDebugString("Bluebird started.", 3,55,167,220)
		 setGameType("BlueBird")
	end
)