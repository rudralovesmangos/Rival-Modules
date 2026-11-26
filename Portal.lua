local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("Players")
local v_u_3 = require(v1.Modules.GameplayUtility)
local v_u_4 = require(v1.Modules.DuelLibrary)
local v_u_5 = require(v1.Modules.Utility)
local v_u_6 = require(v1.Modules.Spring)
local v_u_7 = require(v1.Modules.Signal)
local v_u_8 = v_u_2.LocalPlayer.PlayerScripts.UserInterface.PortalKeybindGui
local v_u_9 = v_u_2.LocalPlayer.PlayerScripts.Assets.Misc.Portals
local v_u_10 = {}
v_u_10.__index = v_u_10
function v_u_10.new(p11) -- name: new
	-- upvalues: (copy) v_u_10, (copy) v_u_7, (copy) v_u_8, (copy) v_u_6
	local v12 = v_u_10
	local v13 = setmetatable({}, v12)
	v13.FinishedGrowing = v_u_7.new()
	v13.Model = p11
	v13.Hitbox = v13.Model:WaitForChild("Hitbox")
	local v14 = v13.Model.Name
	v13.PortalNum = tonumber(v14)
	v13.Visual = v13:_GetPortalTemplate():Clone()
	v13.BigVisual = v13.Visual:WaitForChild("Big")
	v13.SmallVisual = v13.Visual:WaitForChild("Small")
	v13.Gui = v_u_8:Clone()
	v13._viewmodel_name = v13.Model:GetAttribute("ViewModelName")
	v13._owner_user_id = v13.Model:GetAttribute("OwnerUserID")
	v13._owner_team_id = v13.Model:GetAttribute("OwnerTeamID")
	v13._original_scale = v13.Visual:GetScale()
	v13._grow_start = nil
	v13._spawn_delay = nil
	v13._finished_growing = nil
	v13._is_enabled = false
	v13._established = false
	v13._pivot_offset_spring = v_u_6.new(Vector3.new(0, 0, 0), 0.5, 25)
	v13._opened_hotel_door = false
	v13:_Init()
	return v13
end
function v_u_10.IsGrown(p15) -- name: IsGrown
	return p15._finished_growing
end
function v_u_10.GetTeleportCFrame(p16) -- name: GetTeleportCFrame
	-- upvalues: (copy) v_u_3, (copy) v_u_2, (copy) v_u_5
	local v17 = p16.Hitbox.CFrame
	local v18 = v17 * CFrame.new(0, 0, -4)
	local v19 = v_u_3:GetRaycastWhitelist(v_u_2.LocalPlayer:GetAttribute("EnvironmentID"))
	local v20 = v_u_5:Raycast(v17.Position, v18.Position, 4, v19, Enum.RaycastFilterType.Include)
	return CFrame.new(v20.Position) * v18.Rotation
end
function v_u_10.UpdateVisuals(p_u_21, p_u_22, p_u_23) -- name: UpdateVisuals
	-- upvalues: (copy) v_u_5
	task.defer(function()
		-- upvalues: (copy) p_u_22, (copy) p_u_21, (copy) p_u_23, (ref) v_u_5
		local v24 = p_u_22
		if v24 then
			v24 = p_u_21._finished_growing
		end
		local v25 = p_u_21
		local v26 = p_u_21.BigVisual
		local v27
		if v24 then
			v27 = p_u_21.Visual
		else
			v27 = nil
		end
		v25:_SafeParent(v26, v27)
		local v28 = p_u_21
		local v29 = p_u_21.SmallVisual
		local v30
		if v24 then
			v30 = nil
		else
			v30 = p_u_21.Visual
		end
		v28:_SafeParent(v29, v30)
		if v24 and (not p_u_21._opened_hotel_door and p_u_21._viewmodel_name == "Hotel Bell") then
			p_u_21._opened_hotel_door = true
			task.defer(function()
				-- upvalues: (ref) p_u_21
				p_u_21.BigVisual.Screen.SurfaceGui.MainFrame:TweenSize(UDim2.new(0.1, 0, 1, 0), "Out", "Quint", 0.5, true)
			end)
		end
		local v31 = not p_u_23 and (v24 and not p_u_21._is_enabled)
		if v31 then
			v31 = not p_u_21._established
		end
		if v31 then
			p_u_21._established = true
			if p_u_21._viewmodel_name == "Hotel Bell" then
				task.delay(0.1 + 0.1 * math.random(), v_u_5.CreateSound, v_u_5, "rbxassetid://109072275653492", 1, 1.25 + 0.25 * math.random(), p_u_21.Hitbox, true, 10)
				v_u_5:CreateSound("rbxassetid://119325209237441", 0.5, 1 + 0.1 * math.random(), p_u_21.Hitbox, true, 10)
			else
				v_u_5:CreateSound("rbxassetid://119325209237441", 0.75, 1 + 0.1 * math.random(), p_u_21.Hitbox, true, 10)
			end
		end
		p_u_21._is_enabled = p_u_22
		if not p_u_21._is_enabled then
			p_u_21:_ScaleTo(1)
		end
	end)
end
function v_u_10.Update(p32, p33) -- name: Update
	p32:_Pivot()
	if p32._viewmodel_name == "Hotel Bell" then
		local v34 = p32.BigVisual.Part.SurfaceGui1.CanvasGroup.Spin
		v34.Rotation = v34.Rotation + p33 * -90
		local v35 = p32.BigVisual.Part.SurfaceGui2.CanvasGroup.Spin
		v35.Rotation = v35.Rotation + p33 * -90
	end
	if p32._is_enabled and not p32._finished_growing then
		local v36
		if p32._spawn_delay <= 0 then
			v36 = 1
		else
			local v37 = (tick() - p32._grow_start) / p32._spawn_delay
			v36 = math.clamp(v37, 0, 1)
		end
		p32:_ScaleTo((v36 * 0.75 + 0.25) * (v36 < 1 and 3 or 1))
		if v36 >= 1 then
			p32._finished_growing = true
			p32.FinishedGrowing:Fire()
			local v38 = p32._spawn_delay <= 0.01
			if not v38 then
				p32._pivot_offset_spring.Value = Vector3.new(0, 0, -3)
			end
			p32:UpdateVisuals(p32._is_enabled, not v38)
		end
	else
		return
	end
end
function v_u_10.Destroy(p_u_39) -- name: Destroy
	pcall(function()
		-- upvalues: (copy) p_u_39
		p_u_39.Model:Destroy()
	end)
	pcall(function()
		-- upvalues: (copy) p_u_39
		p_u_39.Visual:Destroy()
	end)
	p_u_39.FinishedGrowing:Destroy()
end
function v_u_10._GetPortalTemplate(p40) -- name: _GetPortalTemplate
	-- upvalues: (copy) v_u_9
	return (v_u_9:FindFirstChild((p40.Model:GetAttribute("ViewModelName"))) or v_u_9.Default)[p40.PortalNum]
end
function v_u_10._Pivot(p41) -- name: _Pivot
	p41.Visual:PivotTo(p41.Model:GetPivot() * CFrame.new(p41._pivot_offset_spring.Value))
end
function v_u_10._SafeParent(_, p_u_42, p_u_43) -- name: _SafeParent
	pcall(function()
		-- upvalues: (copy) p_u_42, (copy) p_u_43
		p_u_42.Parent = p_u_43
	end)
end
function v_u_10._ScaleTo(p44, p45) -- name: _ScaleTo
	local v46 = p44.BigVisual.Parent
	local v47 = p44.SmallVisual.Parent
	p44:_SafeParent(p44.BigVisual, p44.Visual)
	p44:_SafeParent(p44.SmallVisual, p44.Visual)
	p44.Visual:ScaleTo(p44._original_scale * p45)
	p44:_SafeParent(p44.BigVisual, v46)
	p44:_SafeParent(p44.SmallVisual, v47)
end
function v_u_10._InitializeGrowing(p48) -- name: _InitializeGrowing
	p48._grow_start = tick()
	p48._spawn_delay = p48.Model:GetAttribute("SpawnDelay") or 0
	p48._finished_growing = false
	p48:UpdateVisuals(p48._is_enabled)
end
function v_u_10._Setup(p49) -- name: _Setup
	-- upvalues: (copy) v_u_4, (copy) v_u_2, (copy) v_u_5
	local v50 = v_u_4:GetTeamColor(p49._owner_team_id, nil, "PadColor")
	for _, v51 in pairs(p49.Visual:GetDescendants()) do
		if v51:HasTag("ColorThis") then
			local v52 = v51:GetAttribute("ColorThisMultiplier") or 1
			local v53 = Color3.new(v50.R * v52, v50.G * v52, v50.B * v52)
			if v51:IsA("BasePart") then
				v51.Color = v53
			elseif v51:IsA("Frame") then
				v51.BackgroundColor3 = v53
			elseif v51:IsA("ImageLabel") then
				v51.ImageColor3 = v53
			end
		end
		if not v51:IsA("BasePart") then
			continue
		end
		v51.CanCollide = false
		v51.CanQuery = false
		v51.CanTouch = false
	end
	p49.Gui.Parent = p49.Visual.Primary
	if p49._owner_user_id == v_u_2.LocalPlayer.UserId then
		p49.Gui.CanvasGroup.Keybind:SetAttribute("InputName", p49.PortalNum == 1 and "Shoot" or "Aim")
		p49.Gui.CanvasGroup.Keybind:AddTag("UIKeybindContainer")
	end
	p49.Visual.PrimaryPart = p49.Visual.Primary
	p49.BigVisual.WorldPivot = p49.Visual.WorldPivot
	p49.SmallVisual.WorldPivot = p49.Visual.WorldPivot
	p49.Visual.Parent = p49.Model
	v_u_5:CreateSound("rbxassetid://114274252176516", 0.5, 0.95 + 0.1 * math.random(), p49.Visual.Primary, true).Looped = true
end
function v_u_10._Init(p_u_54) -- name: _Init
	p_u_54.Model:GetAttributeChangedSignal("SpawnDelay"):Connect(function()
		-- upvalues: (copy) p_u_54
		p_u_54:_InitializeGrowing()
	end)
	p_u_54.Model:GetAttributeChangedSignal("RegrowHash"):Connect(function()
		-- upvalues: (copy) p_u_54
		p_u_54:_InitializeGrowing()
	end)
	p_u_54:_Setup()
	p_u_54:_Pivot()
	p_u_54:_InitializeGrowing()
end
return v_u_10