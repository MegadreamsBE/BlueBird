function startClient()
A = createObject(6959, 5809.0224609375, -1452.1123046875, 61.660598754883,0, 90, 0)
A2 = createObject(6959, 5809.0224609375, -1487.6794433594, 61.660598754883,0, 90, 0)

setElementCollisionsEnabled(A, false)
setElementCollisionsEnabled(A2, false)
end
addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()), startClient) 
