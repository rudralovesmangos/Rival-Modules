local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = require(v1.Modules.BetterDebris)
local v_u_3 = require(v1.Modules.Utility)
return function(p4)
	-- upvalues: (copy) v_u_2, (copy) v_u_3
	local v5 = p4.HumanoidRootPart
	wait(2.1)
	local v6 = script.Part:Clone()
	v6.CFrame = v5.CFrame
	v6.Parent = workspace
	v_u_2:AddItem(v6, 5)
	v_u_3:PlayParticles(v6)
	v_u_3:CreateSound("rbxassetid://112056339158256", 0.8, 1, v6, true)
end