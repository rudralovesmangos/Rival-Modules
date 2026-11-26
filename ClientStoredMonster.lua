local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("RunService")
local v3 = game:GetService("Players")
local v_u_4 = require(v1.Modules.BetterDebris)
local v_u_5 = require(v1.Modules.Utility)
local v_u_6 = require(v3.LocalPlayer.PlayerScripts.Modules.ClientReplicatedClasses.ClientEntity.ClientCustomEntity)
local v_u_7 = setmetatable({}, v_u_6)
v_u_7.__index = v_u_7
function v_u_7.new(...) -- name: new
	-- upvalues: (copy) v_u_6, (copy) v_u_7
	local v8 = v_u_6.new(...)
	local v9 = v_u_7
	local v10 = setmetatable(v8, v9)
	v10._original_cframe_before_shaking = nil
	v10._death_vfx = v10.Model:FindFirstChild("DeathVFX", true)
	v10:_Init()
	return v10
end
function v_u_7.ReplicateFromServer(p11, p12, ...) -- name: ReplicateFromServer
	-- upvalues: (copy) v_u_2, (copy) v_u_6
	if p12 == "StoredMonsterDieOnPresence" then
		if not p11:IsRendered() then
			return
		end
		local v13 = p11.Model:GetPivot()
		local v14 = Random.new()
		local v15 = tick()
		p11._original_cframe_before_shaking = p11.RootPart.CFrame
		local v16 = ...
		while not p11._destroyed and p11.RootPart:IsDescendantOf(workspace) do
			local v17 = (tick() - v15) / v16
			local v18 = math.min(1, v17)
			local v19 = v14:NextUnitVector() * Vector3.new(1, 0, 1) * v18 ^ 4
			p11.Model:PivotTo(v13 + v19)
			v_u_2.RenderStepped:Wait()
		end
	else
		v_u_6.ReplicateFromServer(p11, p12, ...)
	end
end
function v_u_7._PlayDeathVFX(p20) -- name: _PlayDeathVFX
	-- upvalues: (copy) v_u_4, (copy) v_u_5
	if p20._death_vfx then
		local v21 = Instance.new("Part")
		v21.CFrame = p20._original_cframe_before_shaking or p20.RootPart.CFrame
		v21.Anchored = true
		v21.CanCollide = false
		v21.CanTouch = false
		v21.CanQuery = false
		v21.Transparency = 1
		v21.Size = Vector3.new(0, 0, 0)
		v21.Parent = workspace
		v_u_4:AddItem(v21, 10)
		p20._death_vfx.Parent = v21
		v_u_5:PlayParticles(p20._death_vfx)
	end
end
function v_u_7._Init(p_u_22) -- name: _Init
	p_u_22.Died:Connect(function()
		-- upvalues: (copy) p_u_22
		p_u_22:_PlayDeathVFX()
	end)
end
return v_u_7