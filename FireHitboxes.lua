local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("CollectionService")
local v_u_3 = game:GetService("TweenService")
local v4 = game:GetService("Players")
local v_u_5 = require(v1.Modules.BetterDebris)
local v_u_6 = require(v1.Modules.Utility)
require(v1.Modules.Spring)
local v_u_7 = require(v4.LocalPlayer.PlayerScripts.Controllers.FighterController)
local v_u_8 = require(v4.LocalPlayer.PlayerScripts.Controllers.WrapController)
local v_u_9 = v4.LocalPlayer.PlayerScripts.Assets:WaitForChild("Misc"):WaitForChild("FireHitboxes")
local v_u_10 = {}
v_u_10.__index = v_u_10
function v_u_10._new() -- name: _new
	-- upvalues: (copy) v_u_10
	local v11 = v_u_10
	local v12 = setmetatable({}, v11)
	v12._fire_hitboxes = {}
	v12:_Init()
	return v12
end
function v_u_10.Extinguish(p13, p14) -- name: Extinguish
	for v15, v16 in pairs(p13._fire_hitboxes) do
		if v15:GetAttribute("FireHitboxID") ~= p14 then
			continue
		end
		v16.Visual:Destroy()
		p13._fire_hitboxes[v15] = nil
		return v16.Visual:GetPivot().Position
	end
end
function v_u_10.Update(p17, _) -- name: Update
	for v18, v19 in pairs(p17._fire_hitboxes) do
		v19.Visual:PivotTo(v18.CFrame)
	end
end
function v_u_10._Setup(p_u_20) -- name: _Setup
	-- upvalues: (copy) v_u_5, (copy) v_u_3, (copy) v_u_6, (copy) v_u_2, (copy) v_u_9, (copy) v_u_7, (copy) v_u_8
	local function v30(p21) -- name: fire_hitbox_removed
		-- upvalues: (copy) p_u_20, (ref) v_u_5, (ref) v_u_3, (ref) v_u_6
		local v_u_22 = p_u_20._fire_hitboxes[p21]
		if v_u_22 then
			v_u_22.Destroyed = true
			for _, v23 in pairs(v_u_22.Visual:GetDescendants()) do
				if not v23:IsA("ParticleEmitter") then
					continue
				end
				v23.Enabled = false
			end
			v_u_5:AddItem(v_u_22.Visual, 10)
			if v_u_22.Visual.Name == "Hot Coals" then
				for _, v_u_24 in pairs(v_u_22.Visual.Coals:GetChildren()) do
					v_u_24.Color = Color3.fromRGB(0, 0, 0)
					task.delay(0.5 * math.random(), function()
						-- upvalues: (ref) v_u_3, (copy) v_u_24
						v_u_3:Create(v_u_24, TweenInfo.new(0.25 + 0.5 * math.random(), Enum.EasingStyle.Quint, Enum.EasingDirection.In), {
							["Size"] = Vector3.new(0, 0, 0)
						}):Play()
					end)
				end
			end
			local v_u_25 = v_u_22.Sound1
			if v_u_25 then
				v_u_25 = v_u_22.Sound1.Volume
			end
			local v_u_26 = v_u_22.Sound2
			if v_u_26 then
				v_u_26 = v_u_22.Sound2.Volume
			end
			local v_u_27 = v_u_22.Visual.Primary.PointLight
			v_u_6:RenderstepForLoop(0, 100, 1, function(p28)
				-- upvalues: (copy) v_u_22, (copy) v_u_25, (copy) v_u_26, (copy) v_u_27
				local v29 = 1 - (p28 / 100) ^ 2
				if v_u_22.Sound1 then
					v_u_22.Sound1.Volume = v_u_25 * v29
				end
				if v_u_22.Sound2 then
					v_u_22.Sound2.Volume = v_u_26 * v29
				end
				v_u_27.Brightness = 3 * v29
			end)
			p_u_20._fire_hitboxes[p21] = nil
		end
	end
	v_u_2:GetInstanceRemovedSignal("FireHitbox"):Connect(v30)
	local function v47(p31) -- name: fire_hitbox_added
		-- upvalues: (ref) v_u_9, (ref) v_u_7, (ref) v_u_8, (ref) v_u_6, (copy) p_u_20, (ref) v_u_3
		local v32 = p31:GetAttribute("IsMain")
		local v33 = p31:GetAttribute("ObjectID")
		local v34 = p31:GetAttribute("ViewModelName") or "Default"
		local v35 = (v_u_9:FindFirstChild(v34) or v_u_9.Default):Clone()
		v35.PrimaryPart = v35.Primary
		v35.Primary.Size = p31.Size
		v35:PivotTo(p31.CFrame)
		v35.Parent = workspace
		if v32 and v35.Primary:FindFirstChild("Fire") then
			v35.Primary.Fire.Acceleration = Vector3.new(0, 10, 0)
		end
		local v36 = v_u_7:GetWrap(v33)
		if v36 then
			v_u_8:ApplyWrap(v_u_8:RecordOriginalWrapProperties(v35), v36, true)
		end
		local v37, v38
		if v32 then
			local v39 = p31.Size.X
			local v40 = p31.Size.Y
			local v41 = p31.Size.Z
			local v42 = math.max(v39, v40, v41) * 1.5
			v37 = v_u_6:CreateSound("rbxassetid://13702989275", 0.5, 0.7 + 0.3 * math.random(), v35.Primary, true, nil, v42)
			if v34 == "Campfire Stick" then
				v38 = v_u_6:CreateSound("rbxassetid://115255932685592", 1.25, 1, v35.Primary, true, nil, v42)
			else
				v38 = v_u_6:CreateSound("rbxassetid://14812827622", 1.25, 0.875, v35.Primary, true, nil, v42)
			end
		else
			v37 = nil
			v38 = nil
		end
		local v_u_43 = {
			["Visual"] = nil,
			["Sound1"] = nil,
			["Sound2"] = nil,
			["Destroyed"] = false,
			["Visual"] = v35,
			["Sound1"] = v37,
			["Sound2"] = v38
		}
		p_u_20._fire_hitboxes[p31] = v_u_43
		if v_u_43.Visual.Name == "Hot Coals" then
			for _, v_u_44 in pairs(v_u_43.Visual.Coals:GetChildren()) do
				local v_u_45 = v_u_44.Size
				v_u_44.Size = Vector3.new(0, 0, 0)
				v_u_44.CFrame = v_u_44.CFrame * CFrame.Angles(6.283185307179586 * math.random(), 6.283185307179586 * math.random(), 6.283185307179586 * math.random())
				task.delay(0.5 * math.random(), function()
					-- upvalues: (copy) v_u_43, (ref) v_u_3, (copy) v_u_44, (copy) v_u_45
					if not v_u_43.Destroyed then
						local v46 = {
							["Size"] = v_u_45
						}
						v_u_3:Create(v_u_44, TweenInfo.new(1 * math.random(), Enum.EasingStyle.Quint, Enum.EasingDirection.Out), v46):Play()
					end
				end)
			end
		end
	end
	v_u_2:GetInstanceAddedSignal("FireHitbox"):Connect(v47)
	for _, v48 in pairs(v_u_2:GetTagged("FireHitbox")) do
		task.spawn(v47, v48)
	end
end
function v_u_10._Init(p49) -- name: _Init
	p49:_Setup()
end
return v_u_10._new()