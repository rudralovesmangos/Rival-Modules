local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = require(v1.Modules.Utility)
return function(p3)
	-- upvalues: (copy) v_u_2
	v_u_2:CreateSound("rbxassetid://7384906695", 0.8, 1, p3.HumanoidRootPart, true)
	wait(2.95)
	v_u_2:CreateSound("rbxassetid://7384913560", 0.4, 1, p3.HumanoidRootPart, true)
	wait(0.25)
	v_u_2:CreateSound("rbxassetid://7384913560", 0.8, 0.8, p3.HumanoidRootPart, true)
	wait(0.5)
	v_u_2:CreateSound("rbxassetid://7384913560", 0.8, 1.5, p3.HumanoidRootPart, true)
end