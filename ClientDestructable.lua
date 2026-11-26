local v1 = game:GetService("ReplicatedStorage")
local v2 = game:GetService("Players")
local v_u_3 = require(v1.Modules.Utility)
local v_u_4 = require(v1.Modules.Signal)
local v_u_5 = require(v2.LocalPlayer.PlayerScripts.Modules.ClientReplicatedClasses.ClientEntity.ClientCustomEntity)
local v_u_6 = v2.LocalPlayer.PlayerScripts.Assets.Destructables.ShatterVisuals
local v_u_7 = v2.LocalPlayer.PlayerScripts.Assets.Destructables.Visuals
local v_u_8 = CFrame.Angles(0, 1.5707963267948966, 0)
local v_u_9 = setmetatable({}, v_u_5)
v_u_9.__index = v_u_9
function v_u_9.new(...) -- name: new
	-- upvalues: (copy) v_u_5, (copy) v_u_9, (copy) v_u_4, (copy) v_u_6
	local v10 = v_u_5.new(...)
	local v11 = v_u_9
	local v12 = setmetatable(v10, v11)
	v12.ShatterModelAdded = v_u_4.new()
	v12.AimAssistBlacklist = true
	v12.PlayRubbleEffectOnDeath = nil
	v12._shatter_template = v_u_6:FindFirstChild(v12.Model.Name)
	v12._death_animation_override = true
	v12._death_sound_override = true
	v12._visual = nil
	v12._always_face_camera = v12.Model:GetAttribute("AlwaysFaceCamera") or false
	v12._shatter_sound_id = v12.Model:GetAttribute("ShatterSoundID") or (v12._shatter_template and (v12._shatter_template:GetAttribute("ShatterSoundID") or "rbxassetid://14441658101") or "rbxassetid://14441658101")
	v12._next_update = 0
	v12._shatter_effect_chance = 1
	v12:_Init()
	return v12
end
function v_u_9.Destroy(p13) -- name: Destroy
	-- upvalues: (copy) v_u_5
	p13.ShatterModelAdded:Destroy()
	v_u_5.Destroy(p13)
end
function v_u_9._RubbleEffect(p14, _) -- name: _RubbleEffect
	for _, v15 in pairs(p14.Model:GetDescendants()) do
		local v16 = v15:HasTag("IsRubble")
		if v15:IsA("BasePart") or (v15:IsA("Decal") or v15:IsA("Texture")) then
			v15.Transparency = v16 and 0 or 1
		end
		if not v15:IsA("BasePart") then
			continue
		end
		v15.CanCollide = v16
	end
end
function v_u_9._ShatterEffect(p17, p18) -- name: _ShatterEffect
	-- upvalues: (copy) v_u_8, (copy) v_u_3
	local v19 = p17._visual and p17._visual.CFrame * v_u_8:Inverse() * CFrame.Angles(0, 6.283185307179586 * math.random(), 0) or p17.Model:GetPivot()
	p17.Model:ClearAllChildren()
	if math.random() <= p17._shatter_effect_chance or (workspace.CurrentCamera.CFrame.Position - v19.Position).Magnitude <= 24 then
		local v20 = p17._shatter_template:Clone()
		v20.Parent = p17.Model
		v20.PrimaryPart = v20.Primary
		v20:PivotTo(v19)
		v20.PrimaryPart:Destroy()
		local v21 = v20:GetAttribute("ShatterStrength") or 1
		local v22 = Random.new()
		for _, v23 in pairs(v20:GetChildren()) do
			local v24 = CFrame.new(p17.RootPart.Position, v23.Position).LookVector
			local v25 = v24.X
			local v26 = v24.Y
			local v27 = math.max(0, v26) * 2
			local v28 = v24.Z
			local v29 = Vector3.new(v25, v27, v28) * (10 + 10 * math.random()) * v21
			v23.CanCollide = true
			v23.CanTouch = false
			v23.Anchored = false
			v23.RotVelocity = v22:NextUnitVector() * 25 * math.random()
			v23.Velocity = v29
			for _, v30 in pairs(v20:GetChildren()) do
				if v30 == v23 then
					continue
				end
				local v31 = Instance.new("NoCollisionConstraint")
				v31.Part0 = v23
				v31.Part1 = v30
				v31.Parent = v23
			end
		end
		if not p18 then
			v_u_3:CreateSound(p17._shatter_sound_id, 0.625 + 0.25 * math.random(), 1.5 + 0.5 * math.random(), v19.Position, true, 10)
		end
		if p17._visual then
			p17._visual:Destroy()
			p17._visual = nil
		end
		p17.ShatterModelAdded:Fire(v20)
	end
end
function v_u_9._CheckDead(p32, p33) -- name: _CheckDead
	if p32:IsAlive() then
		return
	elseif p32.PlayRubbleEffectOnDeath then
		p32:_RubbleEffect(p33)
	else
		p32:_ShatterEffect(p33)
	end
end
function v_u_9._Setup(p34) -- name: _Setup
	-- upvalues: (copy) v_u_7
	local v35 = v_u_7:FindFirstChild(p34.Model.Name)
	if v35 then
		p34._visual = v35:Clone()
		p34._visual.CanCollide = false
		p34._visual.CanQuery = false
		p34._visual.CanTouch = false
		p34._visual.Anchored = true
		p34._visual.Parent = p34.Model
	end
end
function v_u_9._Init(p_u_36) -- name: _Init
	p_u_36.Died:Connect(function()
		-- upvalues: (copy) p_u_36
		p_u_36:_CheckDead()
	end)
	p_u_36:_Setup()
	task.defer(p_u_36._CheckDead, p_u_36, true)
end
return v_u_9