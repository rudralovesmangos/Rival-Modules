local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("RunService")
local v3 = game:GetService("Players")
require(v1.Modules.BetterDebris)
require(v1.Modules.Utility)
local v_u_4 = require(v3.LocalPlayer.PlayerScripts.Modules.ClientReplicatedClasses.ClientEntity.ClientCustomEntity.ClientDestructable)
v3.LocalPlayer.PlayerScripts.Assets.Misc:WaitForChild("ExplosiveZombieExplosionEffect")
local v_u_5 = setmetatable({}, v_u_4)
v_u_5.__index = v_u_5
function v_u_5.new(...) -- name: new
	-- upvalues: (copy) v_u_4, (copy) v_u_5
	local v6 = v_u_4.new(...)
	local v7 = v_u_5
	local v8 = setmetatable(v6, v7)
	v8._shatter_effect_chance = 0.5
	v8._colored_tile_part = v8.Model:FindFirstChild("ColoredTile")
	v8:_Init()
	return v8
end
function v_u_5.ReplicateFromServer(p9, p10, ...) -- name: ReplicateFromServer
	-- upvalues: (copy) v_u_2, (copy) v_u_4
	if p10 == "SpleefTileShake" then
		if not p9:IsRendered() then
			return
		end
		if not p9._colored_tile_part then
			return
		end
		local v11 = p9._colored_tile_part:GetPivot()
		local v12 = tick()
		while p9:IsAlive() do
			local v13 = tick() - v12
			local v14 = math.clamp(v13, 0, 1)
			local v15 = p9._colored_tile_part
			local v16 = math.random() - 0.5
			local v17 = math.random() - 0.5
			local v18 = math.random() - 0.5
			v15:PivotTo(v11 + Vector3.new(v16, v17, v18) * v14 * 2)
			v_u_2.RenderStepped:Wait()
		end
	else
		v_u_4.ReplicateFromServer(p9, p10, ...)
	end
end
function v_u_5._Init(p_u_19) -- name: _Init
	p_u_19.ShatterModelAdded:Connect(function(p20)
		-- upvalues: (copy) p_u_19
		if p_u_19._colored_tile_part then
			for _, v21 in pairs(p20:GetChildren()) do
				if not v21:IsA("BasePart") then
					continue
				end
				v21.Color = p_u_19._colored_tile_part.Color
			end
		end
	end)
end
return v_u_5