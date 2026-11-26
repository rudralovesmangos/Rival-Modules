local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = require(v1.Modules.Utility)
return function(...)
	-- upvalues: (copy) v_u_2
	v_u_2:CreateSound(...)
end