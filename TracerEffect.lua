local v1 = game:GetService("Players")
local v_u_2 = require(v1.LocalPlayer.PlayerScripts.Modules.TracerEffect)
return function(...)
	-- upvalues: (copy) v_u_2
	v_u_2:Play(...)
end