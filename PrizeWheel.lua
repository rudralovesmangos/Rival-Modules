local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("RunService")
local v_u_3 = require(v1.Modules.Utility)
local v_u_4 = {
	6.15,
	6.35,
	6.6,
	6.8,
	7.15,
	7.45,
	7.8,
	8.25,
	8.8,
	9.6,
	11.05
}
return function(p5)
	-- upvalues: (copy) v_u_3, (copy) v_u_2, (copy) v_u_4
	local v6 = p5:FindFirstChild("HumanoidRootPart") or p5:FindFirstChild("RootPart")
	v_u_3:CreateSound("rbxassetid://97748906880096", 1, 1, v6, true)
	wait(1.45)
	v_u_3:CreateSound("rbxassetid://103519956736851", 1, 1.25, v6, true)
	wait(0.6)
	local v7 = tick()
	local v8 = tick() + 4
	local v9 = 0
	while tick() < v8 do
		if v9 < tick() then
			v_u_3:CreateSound("rbxassetid://103519956736851", 0.8, (1.5 + -0.3999999999999999 * ((tick() - v7) / 9) ^ 2) * (0.975 + 0.05 * math.random()), v6, true)
			v9 = tick() + 0.08
		end
		v_u_2.RenderStepped:Wait()
	end
	for v10, v11 in pairs(v_u_4) do
		local v12 = v_u_4[v10 - 1] or 6.05
		wait(v11 - v12)
		v_u_3:CreateSound("rbxassetid://103519956736851", 0.8, (1.5 + -0.3999999999999999 * ((tick() - v7) / 9) ^ 2) * (0.975 + 0.05 * math.random()), v6, true)
	end
	wait(3.95)
end