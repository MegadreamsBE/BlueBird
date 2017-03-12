setTimer(function()
	if isSkyState then
		isSkyState = false
		setSkyGradient(250, 250, 250, 250, 250, 250)
	else
		isSkyState = true
		setSkyGradient(176, 128, 194, 176, 128, 194)
	end
end, 50, 0)