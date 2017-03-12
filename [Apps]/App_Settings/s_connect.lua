---------------------------------<
-- Application Connecter
-- s_connect.lua
---------------------------------<

g_ResourceRoot = getResourceRootElement(getThisResource())

addEvent("onRequestChecksumOfFile", true)
addEventHandler("onRequestChecksumOfFile", g_ResourceRoot,
	function(player, filename)
		local file = fileOpen(filename)
		local buffer = ""
		while not fileIsEOF(file) do
		    buffer = buffer..fileRead(file, 500)
		end
		fileClose(file)
		checksum = sha256(buffer)
		triggerClientEvent(player, "onClientRequestChecksumOfFile", g_ResourceRoot, checksum,filename)
	end
)

addEvent("onRequestDownload",true)
addEventHandler("onRequestDownload", g_ResourceRoot,
	function(player,filename)
		local file = fileOpen(filename)
		local buffer = ""
		while not fileIsEOF(file) do
		    buffer = buffer..fileRead(file, 500)
		end
		triggerLatentClientEvent(player,"onClientDownloaded", 1*10^8,g_ResourceRoot, buffer,filename) -- 0.1MB/s
	end
)