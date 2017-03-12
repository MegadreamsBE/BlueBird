---------------------------------<
-- Application Connecter
-- c_connect.lua
--[[-----------------------------<

This file is used for connecting the Application Manager
and the applications themselves together.

This file must be used at every application in order to
make it work well.

Server-side services are always running when the resource is started.
Client-side services are will only run when the user is logged in and has the Application installed.

Client-side files will be downloaded directly when the Application is installed.
The already-downloaded files will be updated when it differs with the servers' on the load.

--]]-----------------------------<
-- Exports
---------------------------------<

g_ResourceRoot = getResourceRootElement(getThisResource())

local files = {"images/icon.png","c_settings.lua"}
local alias = "Settings"
local icon = "images/icon.png"
local filesReady = 0

local Revision = 1

function loadApplication()
	updateFiles()
end

function openApplication()
	if filesReady ~= true then return false end

	local filename = "@:BB_AppManager/Versions.xml"
	local node = xmlLoadFile(filename)
	if node then
		local resourceName = getResourceName(getThisResource())
		local childNode = xmlFindChild(node, resourceName, 0) or xmlCreateChild(node, resourceName)
		local version = tonumber(xmlNodeGetAttribute(childNode, "version"))
		if type(version) == "number" then
			if version < Revision then
				exports.BB_Notify:Notify("Files of the application are outdated,\nrejoin to update.", 2, "Error", 5000)
				xmlUnloadFile(node)
				return
			end
		else
			exports.BB_Notify:Notify("#FF0000Error: APP_XML_Load_Failure\n#FFFFFFCan't open #FF9900"..alias.."#FFFFFF, look at the \n#FF9900Getting Started App#FFFFFF to find out how\nto fix this.", 4, "Error", 5000)
		end 
	else
		return
	end

	main()
end

function closeApplication()
	close()
	return true
end

function liveTileUpdate(tile,mode)
	if not filesReady then return false end

	updateTile(tile,mode)
end

function isStillUpdating()
	if filesReady == true then return false else return true end
end

function giveMeDetails()
	return alias, icon
end

---------------------------------<
-- File updater
---------------------------------<

function updateFiles()
	local filename = "@:BB_AppManager/Versions.xml"
	local node = xmlLoadFile(filename) or xmlCreateFile(filename, "Apps")
	if node then
		local resourceName = getResourceName(getThisResource())
		local childNode = xmlFindChild(node, resourceName, 0) or xmlCreateChild(node, resourceName)
		local version = tonumber(xmlNodeGetAttribute(childNode, "version"))
		if type(version) ~= "number" then
			xmlNodeSetAttribute(childNode, "version", Revision)
			xmlSaveFile(node)
		end
		xmlUnloadFile(node)
	else
		return
	end

	for _,file in pairs(files) do
		updateFile(file)
	end

end

function updateFile(filename)
	triggerServerEvent("onRequestChecksumOfFile", g_ResourceRoot, getLocalPlayer(), filename)
end

addEvent("onClientRequestChecksumOfFile",true)
addEventHandler("onClientRequestChecksumOfFile",g_ResourceRoot,
	function(checksumA,filename)
		local file = fileExists(filename) and fileOpen(filename) or fileCreate(filename)
		local buffer = ""
		while not fileIsEOF(file) do
		    buffer = buffer..fileRead(file, 500)
		end
		fileClose(file)
		checksumB = sha256(buffer)
		if checksumA ~= checksumB then
			downloadFileAgain(filename)
		else
			if string.sub(filename, -4) == ".lua" then
				local lcall,err = loadstring(buffer)
				if(lcall == nil) then
					outputDebugString(err,1)
				else
					lcall()
				end
			end
			sendNotification()
		end
	end
)

function downloadFileAgain(filename)
	triggerServerEvent("onRequestDownload", g_ResourceRoot,getLocalPlayer(), filename)
end

addEvent("onClientDownloaded", true)
addEventHandler("onClientDownloaded", g_ResourceRoot,
	function(buffer, filename)
		local file = fileOpen(filename)
		if not file then
			file = fileCreate(filename)
		else
			fileClose(file)
			fileDelete(filename)
			file = fileCreate(filename)
		end
		fileWrite(file, buffer)
		fileClose(file)

		if string.sub(filename, -4) == ".lua" then
			local lcall,err = loadstring(buffer)
			if(lcall == nil) then
				outputDebugString(err,1)
			else
				lcall()
			end
		end
		sendNotification()
	end
)

function sendNotification()
	filesReady = filesReady+1
	if filesReady == #files then
		triggerEvent("onClientFilesAreAllDownloaded", g_ResourceRoot)
		filesReady = true
	end
end