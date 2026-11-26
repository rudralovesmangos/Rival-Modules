local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("CollectionService")
local v_u_3 = game:GetService("Players")
local v_u_4 = require(v1.Modules.Utility)
local v_u_5 = require(v_u_3.LocalPlayer.PlayerScripts.Controllers:WaitForChild("FighterController"))
local v_u_6 = {}
v_u_6.__index = v_u_6
function v_u_6._new() -- name: _new
	-- upvalues: (copy) v_u_6
	local v7 = v_u_6
	local v8 = setmetatable({}, v7)
	v8._objects = {}
	v8._next_update = 0
	v8:_Init()
	return v8
end
function v_u_6.Update(p9, _) -- name: Update
	-- upvalues: (copy) v_u_5, (copy) v_u_4
	if tick() < p9._next_update then
		return
	else
		p9._next_update = tick() + 0.25
		local v10 = v_u_5.LocalFighter and v_u_5.LocalFighter.Entity
		if v10 then
			v10 = v_u_5.LocalFighter.Entity.Humanoid
		end
		if v10 then
			v10 = v10.RootPart
		end
		if v10 then
			for v11, v12 in pairs(p9._objects) do
				if not (v12.MathHitboxCheckEnabled and v_u_4:IsWithinPart(v11, v10.Position, Vector3.new(2, 2, 2))) then
					continue
				end
				task.spawn(v12.TouchedCallback, v10, true)
			end
		end
	end
end
function v_u_6._ObjectAdded(p13, p_u_14) -- name: _ObjectAdded
	-- upvalues: (copy) v_u_3, (copy) v_u_5, (copy) v_u_4
	local v_u_39 = {
		["Connections"] = nil,
		["Cooldowns"] = nil,
		["TouchedCallback"] = nil,
		["MathHitboxCheckEnabled"] = nil,
		["Connections"] = {},
		["Cooldowns"] = {},
		["MathHitboxCheckEnabled"] = p_u_14:GetAttribute("MathHitboxCheckEnabled"),
		["TouchedCallback"] = function(p15, p16)
			-- upvalues: (ref) v_u_3, (copy) v_u_39, (ref) v_u_5, (copy) p_u_14, (ref) v_u_4
			local v17 = p15.AssemblyRootPart or p15
			if p15.Parent == v_u_3.LocalPlayer.Character and (tick() >= (v_u_39.Cooldowns[v17] or 0) and (v_u_5.LocalFighter and v_u_5.LocalFighter:IsAlive())) then
				local v18 = p_u_14:GetAttribute("Velocity")
				local v19 = p_u_14:GetAttribute("LocalTo")
				local v20 = p_u_14:GetAttribute("MinimumYVelocity")
				if v19 then
					v18 = p_u_14.CFrame[v19] * v18
				end
				if v20 then
					local v21 = v18.X
					local v22 = v18.Y
					if math.abs(v22) >= 0.001 then
						local v23 = v18.Y
						local v24 = math.abs(v23)
						local v25 = math.max(v20, v24)
						local v26 = v18.Y
						v20 = v25 * math.sign(v26)
					end
					local v27 = v18.Z
					v18 = Vector3.new(v21, v20, v27)
				end
				local v28 = p_u_14:GetAttribute("HasToBeInFront")
				local v29
				if typeof(v28) == "CFrame" then
					v29 = v28
				else
					v29 = CFrame.identity
				end
				if p16 or (not v28 or v_u_4:AngleBetweenVectors((v17.Position - (p_u_14.CFrame * v29).Position).Unit, v18.Unit) <= 1.5707963267948966) then
					v_u_39.Cooldowns[v17] = tick() + (p_u_14:GetAttribute("Cooldown") or 0.5)
					local v30 = v_u_5.LocalFighter.Entity.RootPart.Velocity
					local v31 = v_u_5.LocalFighter.Entity.Humanoid.WalkSpeed
					local v32 = v_u_4:AngleBetweenVectors(v18, Vector3.new(0, 1, 0)) < 0.08726646259971647 and true or v_u_4:AngleBetweenVectors(v18, Vector3.new(-0, -1, -0)) < 0.08726646259971647
					local v33 = p_u_14:GetAttribute("SpringSpeed") or 12
					local v34
					if v32 then
						local v35 = v30.Unit
						local v36 = (v30 * (Vector3.new(1, 0, 1)).Unit).Magnitude
						v34 = v35 * math.max(v36, v31)
					else
						v34 = nil
					end
					if not v34 or (v34 ~= v34 or (v34.Magnitude <= 0.001 or not v34)) then
						v34 = nil
					end
					if p_u_14:GetAttribute("Override") then
						v_u_5.LocalFighter.Entity:AirborneCancel()
					end
					v_u_5.LocalFighter.Entity:AirborneTrigger(v18, v33, nil, v34)
					local v37 = p_u_14:GetAttribute("SoundID")
					local v38 = p_u_14:GetAttribute("SoundVolume") or 1
					if v37 then
						v_u_4:CreateSound(v37, 1 * v38, 1, script, true, 10)
					else
						v_u_4:CreateSound("rbxassetid://17835965717", 1 * v38, 1.25, script, true, 5)
					end
				else
					return
				end
			else
				return
			end
		end
	}
	local function v41(p40) -- name: from_touched
		-- upvalues: (copy) v_u_39
		v_u_39.TouchedCallback(p40)
	end
	local v42 = v_u_39.Connections
	local v43 = p_u_14.Touched
	table.insert(v42, v43:Connect(v41))
	local v44 = v_u_39.Connections
	local v45 = p_u_14.TouchEnded
	table.insert(v44, v45:Connect(v41))
	p13._objects[p_u_14] = v_u_39
end
function v_u_6._ObjectRemoved(p46, p47) -- name: _ObjectRemoved
	local v48 = p46._objects[p47]
	if v48 then
		for _, v49 in pairs(v48.Connections) do
			v49:Disconnect()
		end
		p46._objects[p47] = nil
	end
end
function v_u_6._Init(p_u_50) -- name: _Init
	-- upvalues: (copy) v_u_2
	v_u_2:GetInstanceAddedSignal("CustomKnockbackPart"):Connect(function(p51)
		-- upvalues: (copy) p_u_50
		p_u_50:_ObjectAdded(p51)
	end)
	v_u_2:GetInstanceRemovedSignal("CustomKnockbackPart"):Connect(function(p52)
		-- upvalues: (copy) p_u_50
		p_u_50:_ObjectRemoved(p52)
	end)
	for _, v53 in pairs(v_u_2:GetTagged("CustomKnockbackPart")) do
		task.defer(p_u_50._ObjectAdded, p_u_50, v53)
	end
end
return v_u_6._new()