local v_u_1 = game:GetService("ReplicatedStorage").Modules.Finishers
local v_u_2 = {}
v_u_2.__index = v_u_2
function v_u_2.new(p3) -- name: new
	-- upvalues: (copy) v_u_2
	local v4 = v_u_2
	local v5 = setmetatable({}, v4)
	v5.Scene = p3
	v5._dummy_template = v5.Scene.Model:WaitForChild("FinisherDummy")
	v5._fake_player = v5.Scene.Model:WaitForChild("FakePlayer")
	v5._playing_hash = 0
	v5._last_rig = nil
	v5._last_finisher = nil
	v5:_Init()
	return v5
end
function v_u_2.GetHumanoidCFrame(p6) -- name: GetHumanoidCFrame
	return p6._dummy_template:GetPivot()
end
function v_u_2.OnCustomizingStateChanged(p7) -- name: OnCustomizingStateChanged
	task.defer(p7._StartPlaying, p7)
end
function v_u_2.OnStateChanged(p8) -- name: OnStateChanged
	task.defer(p8._StartPlaying, p8)
end
function v_u_2._StartPlaying(p9) -- name: _StartPlaying
	-- upvalues: (copy) v_u_1
	p9._playing_hash = p9._playing_hash + 1
	local v10 = p9._playing_hash
	if p9._last_rig then
		p9._last_rig:Destroy()
		p9._last_rig = nil
	end
	if p9._last_finisher then
		p9._last_finisher:Destroy()
		p9._last_finisher = nil
	end
	local v11 = p9.Scene.Equipment:GetSelectedCosmetic()
	if p9.Scene.Equipment:GetCustomizingType() ~= "Finisher" then
		return
	end
	while true do
		p9._last_rig = p9._dummy_template:Clone()
		p9._last_rig:PivotTo(p9:GetHumanoidCFrame() * CFrame.new(0, 0, 8))
		p9._last_rig.Parent = p9.Scene.Model
		p9._last_rig.Humanoid:MoveTo((p9._last_rig:GetPivot() * CFrame.new(0, 0, -16)).Position)
		local v12 = Instance.new("Animation")
		v12.AnimationId = "rbxassetid://14266666697"
		local v13 = p9._last_rig.Humanoid.LoadAnimation
		local v14 = p9._last_rig.Humanoid
		local v15, v16 = pcall(v13, v14, v12)
		if v15 then
			v16:Play(0)
		end
		wait(0.5)
		if p9._playing_hash ~= v10 then
			return
		end
		if v15 then
			v16:Stop(0)
		end
		local v17 = p9._last_rig
		local v18 = p9._last_rig:GetPivot()
		local v19 = CFrame.Angles
		local v20 = math.random() - 0.5
		v17:PivotTo(v18 * v19(0.17453292519943295, 0, math.sign(v20) * 0.17453292519943295))
		local v21 = p9._last_rig.HumanoidRootPart
		v21.AssemblyLinearVelocity = v21.AssemblyLinearVelocity * 0
		p9._last_rig.Humanoid.Health = 0
		for _, v22 in pairs(p9._last_rig:GetChildren()) do
			if not v22:IsA("BasePart") then
				continue
			end
			for _, v23 in pairs(p9._last_rig:GetChildren()) do
				if not v23:IsA("BasePart") or v23 == v22 then
					continue
				end
				local v24 = Instance.new("NoCollisionConstraint")
				v24.Part1 = v23
				v24.Part0 = v22
				v24.Parent = v22
			end
		end
		for _, v25 in pairs(p9._last_rig:GetDescendants()) do
			if not v25:IsA("BasePart") then
				continue
			end
			v25.CanCollide = true
		end
		local v26 = v11 == "RANDOM_COSMETIC" and "Ragdoll" or (v11 or "Ragdoll")
		local v27 = {
			["Character"] = p9._fake_player
		}
		p9._last_finisher = require(v_u_1[v26]).new(p9._last_rig.Humanoid, false, v27)
		p9._last_finisher:Simulate()
		if p9._playing_hash ~= v10 then
			return
		end
		wait(3)
		if p9._playing_hash ~= v10 then
			return
		end
		if p9._last_rig then
			p9._last_rig:Destroy()
			p9._last_rig = nil
		end
		if not p9._last_finisher then
			break
		end
		p9._last_finisher:Destroy()
		p9._last_finisher = nil
	end
end
function v_u_2._Setup(p28) -- name: _Setup
	p28._dummy_template.Parent = nil
end
function v_u_2._Init(p29) -- name: _Init
	p29:_Setup()
end
return v_u_2