local v_u_1 = game:GetService("CollectionService")
local v2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("Players")
local v_u_4 = require(v2.Modules.Utility)
local v_u_5 = require(v2.Modules.Spring)
local v_u_6 = require(v_u_3.LocalPlayer.PlayerScripts.Controllers.MechanicsController)
local v_u_7 = require(v_u_3.LocalPlayer.PlayerScripts.Controllers.FighterController)
local v_u_8 = v_u_3.LocalPlayer.PlayerScripts.Assets.Misc.Vortexes
local v_u_9 = {}
v_u_9.__index = v_u_9
function v_u_9._new() -- name: _new
	-- upvalues: (copy) v_u_9
	local v10 = v_u_9
	local v11 = setmetatable({}, v10)
	v11._vortexes = {}
	v11._forces = {}
	v11._was_sitting = false
	v11:_Init()
	return v11
end
function v_u_9.UpdateForces(p12) -- name: UpdateForces
	-- upvalues: (copy) v_u_7, (copy) v_u_3, (copy) v_u_6
	local v13 = v_u_7.LocalFighter and v_u_7.LocalFighter.Entity
	if v13 then
		v13 = v_u_7.LocalFighter.Entity.Humanoid
	end
	local v14
	if v13 then
		v14 = v13.RootPart
	else
		v14 = v13
	end
	if v14 then
		for v15, v16 in pairs(p12._vortexes) do
			local v17 = (v15.Position - v14.Position).Magnitude
			if v15.Size.X / 2 < v17 then
				if v15.Size.X * 1 >= v17 then
					continue
				end
				local v18 = p12._forces[v15]
				if not v18 then
					continue
				end
				p12:_Cleanup(v18)
				p12._forces[v15] = nil
			else
				if v16.UserID == v_u_3.LocalPlayer.UserId or v16.TeamID and v16.TeamID == v_u_3.LocalPlayer:GetAttribute("TeamID") or p12._forces[v15] then
					continue
				end
				local v19 = Instance.new("VectorForce")
				v19.RelativeTo = Enum.ActuatorRelativeTo.World
				v19.Attachment0 = v14.RootRigAttachment
				v19.Parent = nil
				local v20 = Instance.new("BodyVelocity")
				v20.MaxForce = Vector3.new(100000, 100000, 100000)
				v20.Parent = v14
				p12._forces[v15] = {
					["RootPart"] = v14,
					["VectorForce"] = v19,
					["BodyVelocity"] = v20
				}
			end
		end
		if next(p12._forces) then
			if v_u_6.IsSliding then
				v_u_6:StopSliding()
			end
			for v21, v22 in pairs(p12._forces) do
				if not v14.Position:FuzzyEq(v21.Position) then
					local v23 = CFrame.new(v14.Position, v21.Position)
					local v24 = (v23.RightVector * 0.15 + v23.LookVector) * 5000
					local v25 = v22.VectorForce
					local v26 = v24.Unit
					local v27 = v24.Magnitude
					v25.Force = v26 * math.min(v27, 5000)
					v22.BodyVelocity.Velocity = v23.LookVector * 50
				end
				v13.Sit = true
				p12._was_sitting = true
			end
		elseif p12._was_sitting then
			p12._was_sitting = false
			v13.Sit = false
		end
	else
		for _, v28 in pairs(p12._forces) do
			p12:_Cleanup(v28)
		end
		p12._forces = {}
		return
	end
end
function v_u_9.UpdateVisuals(p29, p30) -- name: UpdateVisuals
	for v31, v32 in pairs(p29._vortexes) do
		local v33 = (tick() - v32.Start) / v32.Lifetime
		local v34 = math.clamp(v33, 0, 1)
		v32.Clock = v32.Clock + p30 * (v34 ^ 4 + 1)
		local v35 = 1 - v34 ^ 4
		local v36 = math.max(0.01, v35)
		local v37 = CFrame.new(v31.Position, workspace.CurrentCamera.CFrame.Position) * CFrame.Angles(-1.5707963267948966, 0, 0) * CFrame.Angles(0, v32.Clock * (v34 ^ 4 * 4 + 4) % 6.283185307179586, 0) * CFrame.Angles((1 - v34 ^ 6 * 3) * 0.7853981633974483, 0, 0) * CFrame.Angles(0, v32.Clock * (v34 ^ 4 * 4 + 4) % 6.283185307179586, 0)
		v32.Visual:ScaleTo(v32.OriginalScale * v32.ScaleSpring.Value * v36)
		v32.Visual:PivotTo(v37)
		if tick() <= v32.NextShrink then
			continue
		end
		v32.NextShrink = tick() + 0.25
		local v38 = v32.ScaleSpring
		v38.Value = v38.Value - 0.125
	end
end
function v_u_9.Update(p39, p40) -- name: Update
	p39:UpdateForces(p40)
	p39:UpdateVisuals(p40)
end
function v_u_9._Cleanup(_, p41) -- name: _Cleanup
	p41.VectorForce:Destroy()
	p41.BodyVelocity:Destroy()
end
function v_u_9._ObjectAdded(p42, p43) -- name: _ObjectAdded
	-- upvalues: (copy) v_u_4, (copy) v_u_8, (copy) v_u_5
	p42:_ObjectRemoved(p43)
	v_u_4:CreateSound("rbxassetid://90138246017443", 1.25, 0.75 + 0.1 * math.random(), p43, true)
	local v44 = (v_u_8:FindFirstChild(p43:GetAttribute("ViewModelName") or "Default") or v_u_8.Default):Clone()
	v44:ScaleTo(v44:GetScale() * p43.Size.X / 24)
	v44.Parent = p43
	local v45 = v_u_5.new(1, 0.75, 20)
	v45.Value = 0
	p42._vortexes[p43] = {
		["Visual"] = nil,
		["OriginalScale"] = nil,
		["ScaleSpring"] = nil,
		["NextShrink"] = nil,
		["Start"] = nil,
		["Clock"] = 0,
		["Lifetime"] = nil,
		["TeamID"] = nil,
		["UserID"] = nil,
		["Visual"] = v44,
		["OriginalScale"] = v44:GetScale(),
		["ScaleSpring"] = v45,
		["NextShrink"] = tick() + 0.5,
		["Start"] = tick(),
		["Lifetime"] = p43:GetAttribute("Lifetime"),
		["TeamID"] = p43:GetAttribute("TeamID"),
		["UserID"] = p43:GetAttribute("UserID")
	}
end
function v_u_9._ObjectRemoved(p46, p47) -- name: _ObjectRemoved
	p46._vortexes[p47] = nil
	if p46._forces[p47] then
		p46:_Cleanup(p46._forces[p47])
		p46._forces[p47] = nil
	end
end
function v_u_9._Init(p_u_48) -- name: _Init
	-- upvalues: (copy) v_u_1
	v_u_1:GetInstanceRemovedSignal("Vortex"):Connect(function(p49)
		-- upvalues: (copy) p_u_48
		p_u_48:_ObjectRemoved(p49)
	end)
	v_u_1:GetInstanceAddedSignal("Vortex"):Connect(function(p50)
		-- upvalues: (copy) p_u_48
		p_u_48:_ObjectAdded(p50)
	end)
	for _, v51 in pairs(v_u_1:GetTagged("Vortex")) do
		task.defer(p_u_48._ObjectAdded, p_u_48, v51)
	end
end
return v_u_9._new()