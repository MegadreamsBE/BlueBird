function startClient()
A = createObject(1380, 6570.8388671875, 2424.861328125, 104.90811920166,0, 43.187255859375, 0)
A2 = createObject(1380, 6554.361328125, 2424.861328125, 89.453033447266,0, 43.187255859375, 0)
A3 = createObject(1380, 6537.9370117188, 2424.861328125, 73.953002929688,0, 43.187255859375, 0)
A4 = createObject(1380, 6521.431640625, 2424.861328125, 58.523040771484,0, 43.187255859375, 0)
A5 = createObject(1380, 6504.9887695313, 2424.861328125, 43.04296875,0, 43.187255859375, 0)
A6 = createObject(1380, 6488.4946289063, 2424.861328125, 27.617979049683,0, 43.187255859375, 0)
B = createObject(1380, 6570.8388671875, 1696.9326171875, 104.90811920166,0, 43.187255859375, 0)
B2 = createObject(1380, 6554.361328125, 1696.9326171875, 89.453033447266,0, 43.187255859375, 0)
B3 = createObject(1380, 6537.9370117188, 1696.9326171875, 73.953002929688,0, 43.187255859375, 0)
B4 = createObject(1380, 6521.431640625, 1696.9326171875, 58.523040771484,0, 43.187255859375, 0)
B5 = createObject(1380, 6504.9887695313, 1696.9326171875, 43.04296875,0, 43.187255859375, 0)
B6 = createObject(1380, 6488.4946289063, 1696.9326171875, 27.617979049683,0, 43.187255859375, 0)
setElementCollisionsEnabled(A, false)
setElementCollisionsEnabled(A2, false)
setElementCollisionsEnabled(A3, false)
setElementCollisionsEnabled(A4, false)
setElementCollisionsEnabled(A5, false)
setElementCollisionsEnabled(A6, false)
setElementCollisionsEnabled(B, false)
setElementCollisionsEnabled(B2, false)
setElementCollisionsEnabled(B3, false)
setElementCollisionsEnabled(B4, false)
setElementCollisionsEnabled(B5, false)
setElementCollisionsEnabled(B6, false)
end
addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()), startClient) 
