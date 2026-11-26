local v1 = game:GetService("Players")
local v_u_2 = require(v1.LocalPlayer.PlayerScripts.Controllers.PreloadController)
return function(p3, p4)
	-- upvalues: (copy) v_u_2
	p3:LoadAnimation(v_u_2:GetPreloadedAnimation(p4)):Play()
end