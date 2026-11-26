local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("RunService")
local v3 = game:GetService("Players")
local v_u_4 = require(v1.Modules.Utility)
local v_u_5 = require(v1.Modules.Spring)
local v_u_6 = require(v3.LocalPlayer.PlayerScripts.Modules.ClientReplicatedClasses.ClientEntity.ClientHumanoidEntity.ClientEnemy)
local v_u_7 = v3.LocalPlayer.PlayerScripts.Assets.Misc.ChombieEgg
local v_u_8 = setmetatable({}, v_u_6)
v_u_8.__index = v_u_8
function v_u_8.new(...) -- name: new
	-- upvalues: (copy) v_u_6, (copy) v_u_8
	local v9 = v_u_6.new(...)
	local v10 = v_u_8
	local v11 = setmetatable(v9, v10)
	v11._current_egg_thread = nil
	v11._current_egg_model = nil
	v11:_Init()
	return v11
end
function v_u_8.ReplicateFromServer(p12, p13, ...) -- name: ReplicateFromServer
	-- upvalues: (copy) v_u_6
	if p13 == "ChombieEggPhase" then
		if p12:IsRendered() then
			p12._current_egg_thread = task.spawn(p12._EggPhase, p12, ...)
		end
	else
		v_u_6.ReplicateFromServer(p12, p13, ...)
		return
	end
end
function v_u_8.Destroy(p14) -- name: Destroy
	-- upvalues: (copy) v_u_6
	if p14._current_egg_thread then
		local v15 = task.cancel
		local v16 = p14._current_egg_thread
		pcall(v15, v16)
	end
	v_u_6.Destroy(p14)
end
function v_u_8._BrokenEggEffect(p17) -- name: _BrokenEggEffect
	-- upvalues: (copy) v_u_4
	if p17._current_egg_thread then
		local v18 = task.cancel
		local v19 = p17._current_egg_thread
		pcall(v18, v19)
	end
	if p17._current_egg_model then
		p17._current_egg_model:ScaleTo(p17._current_egg_model:GetScale() * 0.75)
		p17._current_egg_model.Full.Transparency = 1
		p17._current_egg_model.Broken.Transparency = 0
		v_u_4:CreateSound("rbxassetid://99730126765749", 1, 1 + 0.125 * math.random(), p17.RootPart, true, 10)
		wait(2)
		p17._current_egg_model.Broken.Anchored = false
	end
end
function v_u_8._EggPhase(p20, p_u_21) -- name: _EggPhase
	-- upvalues: (copy) v_u_7, (copy) v_u_5, (copy) v_u_2, (copy) v_u_4
	local v22 = {}
	for _, v23 in pairs(p20.Model:GetDescendants()) do
		if not (v23:IsA("BasePart") or v23:IsA("Decal")) then
			continue
		end
		v23.LocalTransparencyModifier = 1
		v22[v23] = true
	end
	p20._current_egg_model = v_u_7:Clone()
	p20._current_egg_model.Parent = p20.Model
	local v_u_24 = v_u_5.new(0, 0.75, 10)
	local v25 = p20._current_egg_model:GetScale()
	local v_u_26 = CFrame.identity
	local v_u_27 = 1
	local v_u_28 = 0
	local v_u_29 = tick()
	task.spawn(function()
		-- upvalues: (copy) v_u_29, (copy) p_u_21, (ref) v_u_28, (copy) v_u_24, (ref) v_u_26, (ref) v_u_27
		wait(1)
		while tick() < v_u_29 + p_u_21 - 0.5 do
			v_u_28 = tick()
			v_u_24.Value = 1
			v_u_26 = CFrame.Angles(0, 6.283185307179586 * math.random(), 0)
			v_u_27 = -v_u_27
			local v30 = wait
			local v31 = (v_u_29 + p_u_21 - tick()) * 0.25
			v30((math.min(1, v31)))
		end
	end)
	local v32 = v_u_26
	local v33 = v_u_27
	local v34 = v_u_28
	while tick() < v_u_29 + p_u_21 do
		local v35 = (tick() - v_u_29) / p_u_21
		local v36 = math.clamp(v35, 0, 1)
		local v37 = (tick() - v34) / 0.5
		local v38 = math.clamp(v37, 0, 1)
		local v39 = (tick() - v_u_29) / 1
		local v40 = 1 - (1 - math.clamp(v39, 0, 1)) ^ 4
		local v41 = p20.RootPart.CFrame * CFrame.new(0, -3, 0)
		local v42 = v32 * CFrame.Angles(0, 6.283185307179586 * v38 * v33, 0)
		local v43 = CFrame.Angles(0, 0, 0.6108652381980153 * v_u_24.Value)
		local v44 = Random.new():NextUnitVector() * 1 * v36 ^ 8
		p20._current_egg_model:ScaleTo(v25 * v40)
		p20._current_egg_model:PivotTo(v41 * v42 * v43 * v42:Inverse() + v44)
		v_u_2.RenderStepped:Wait()
	end
	for v45 in pairs(v22) do
		v45.LocalTransparencyModifier = 0
	end
	v_u_4:CreateSound("rbxassetid://94881601487773", 1, 1 + 0.125 * math.random(), p20.RootPart, true, 10)
	p20._current_egg_model:Destroy()
	p20._current_egg_model = nil
end
function v_u_8._Init(p_u_46) -- name: _Init
	p_u_46.Died:Connect(function()
		-- upvalues: (copy) p_u_46
		p_u_46:_BrokenEggEffect()
	end)
end
return v_u_8