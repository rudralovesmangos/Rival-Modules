local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("UserInputService")
local v_u_3 = game:GetService("GuiService")
local v4 = game:GetService("Players")
local v_u_5 = require(v1.Modules.Utility)
local v_u_6 = require(v1.Modules.Signal)
local v_u_7 = require(v1.Modules.Spring)
local v_u_8 = require(v4.LocalPlayer.PlayerScripts.Controllers.CameraController)
local v_u_9 = require(v4.LocalPlayer.PlayerScripts.Modules.UserInterface.Pages)
local v_u_10 = require(v4.LocalPlayer.PlayerScripts.Modules.UILibrary)
local v_u_11 = CFrame.new(0, 0, 35)
local v_u_12 = CFrame.new(0, -2, 0)
local v_u_13 = UDim2.new(0.5, 0, -2.5, 0)
local v_u_14 = UDim2.new(0.5, 0, 3.5, 0)
local v_u_15 = {}
v_u_15.__index = v_u_15
function v_u_15.new(p16) -- name: new
	-- upvalues: (copy) v_u_15, (copy) v_u_6, (copy) v_u_10, (copy) v_u_7
	local v17 = v_u_15
	local v18 = setmetatable({}, v17)
	v18.FinishedOpenEffect = v_u_6.new()
	v18.Equipment = p16
	v18._frame = v_u_10:GetTo("MainFrame", "Equipment", "CameraFade")
	v18._look_at_attachment = nil
	v18._look_at_offset = Vector3.new(0, 0, 0)
	v18._fov_spring = v_u_7.new(15, 0.875, 5)
	v18._equipment_open_hash = 0
	v18._equipment_open_start_cframe = CFrame.identity
	v18._equipment_open_start = 0
	v18._equipment_open_finished = true
	v18._equipment_open_is_closing = false
	v18._controls_connections = {}
	v18._scroll_fov_spring = v_u_7.new(0, 1, 20)
	v18._fov_zoom_direction = Vector2.zero
	v18:_Init()
	return v18
end
function v_u_15.IsOpenEffectDone(p19) -- name: IsOpenEffectDone
	return p19._equipment_open_finished
end
function v_u_15.IsClosing(p20) -- name: IsClosing
	return p20._equipment_open_is_closing
end
function v_u_15.SetFocus(p21, p22, p23, p24, p25) -- name: SetFocus
	p21._look_at_attachment = p22 or nil
	p21._look_at_offset = p23 or Vector3.new(0, 0, 0)
	p21._fov_spring.Target = p24 or 15
	p21._fov_spring.Speed = p25 or 5
end
function v_u_15.Update(p26, p27) -- name: Update
	-- upvalues: (copy) v_u_12, (copy) v_u_11, (copy) v_u_8
	workspace.CurrentCamera.CameraType = Enum.CameraType.Scriptable
	p26:_IncrementFOVSpringFromInput((p26._fov_zoom_direction.X - p26._fov_zoom_direction.Y) * p27 * 60 * 0.25)
	local v28 = (tick() - p26._equipment_open_start) / 0.375
	local v29 = math.clamp(v28, 0, 1)
	if v29 < 1 then
		local v30 = v29 ^ 2
		if p26._equipment_open_is_closing then
			workspace.CurrentCamera.CFrame = p26._equipment_open_start_cframe * CFrame.identity:Lerp(v_u_12, v30)
		else
			workspace.CurrentCamera.CFrame = p26._equipment_open_start_cframe * CFrame.new(0, v30 * 25, 0)
		end
	else
		local v31 = p26.Equipment:GetCustomizingType()
		local v32 = v31 == "Finisher" and true or v31 == "Emote"
		local v33 = p26.Equipment.Scene:GetCFrame() * v_u_11
		local v34
		if p26._equipment_open_finished then
			v34 = workspace.CurrentCamera.CFrame
		else
			v34 = v33 * (p26:_IsOpenEffectDisabled() and CFrame.identity or v_u_12)
		end
		if v32 then
			v33 = CFrame.new(v33.Position + Vector3.new(0, 5, 0), p26.Equipment.Scene:GetHumanoidCFrame().Position)
		elseif p26._look_at_attachment then
			v33 = CFrame.new(v33.Position, p26._look_at_attachment.WorldPosition + p26._look_at_offset)
		end
		local v35 = CFrame.Angles
		local v36 = tick() * 0.23983 % 6.283185307179586
		local v37 = math.sin(v36) * 0.00017453292519943296
		local v38 = tick() * 0.372721 % 6.283185307179586
		local v39 = math.sin(v38) * 0.00017453292519943296
		local v40 = tick() * 0.43123 % 6.283185307179586
		local v41 = v35(v37, v39, math.sin(v40) * 0.00017453292519943296)
		local v42 = p26.Equipment:IsCustomizing() and 0.025 or 0.05
		workspace.CurrentCamera.FieldOfView = p26._fov_spring.Value + p26._scroll_fov_spring.Value + v_u_8:GetExternalFOVOffset()
		workspace.CurrentCamera.CFrame = CFrame.new(v34.Position:Lerp(v33.Position, 0.1)) * v34.Rotation:Lerp(v33.Rotation, v42) * v41
		if not p26._equipment_open_finished then
			p26._equipment_open_finished = true
			p26.FinishedOpenEffect:Fire()
		end
		return
	end
end
function v_u_15.OnStateChanged(p43) -- name: OnStateChanged
	p43.Equipment:IsCustomizing()
end
function v_u_15.OnOpen(p44) -- name: OnOpen
	-- upvalues: (copy) v_u_8, (copy) v_u_13, (copy) v_u_14, (copy) v_u_5
	task.spawn(v_u_8.CameraState.SetCustomFreecamEnabled, v_u_8.CameraState, false)
	v_u_8:Freeze(p44.Equipment.IsOpen)
	p44:_VerifyControls()
	if p44.Equipment.IsOpen then
		p44._scroll_fov_spring.Target = 0
		p44._scroll_fov_spring.Value = 0
		if p44:_IsOpenEffectDisabled() then
			p44._equipment_open_hash = p44._equipment_open_hash + 1
			p44._equipment_open_is_closing = false
			p44._equipment_open_start_cframe = CFrame.identity
			p44._equipment_open_start = 0
			p44._equipment_open_finished = false
			p44.FinishedOpenEffect:Fire()
			return
		end
		p44._equipment_open_hash = p44._equipment_open_hash + 1
		p44._equipment_open_is_closing = false
		p44._equipment_open_start_cframe = workspace.CurrentCamera.CFrame
		p44._equipment_open_start = tick()
		p44._equipment_open_finished = false
		p44.FinishedOpenEffect:Fire()
		p44._frame.Position = v_u_13
		p44._frame:TweenPosition(v_u_14, "InOut", "Quint", 0.9375, true)
		v_u_5:CreateSound("rbxassetid://106551800007995", 1.5, 1 + 0.2 * math.random(), script, true, 5)
	end
end
function v_u_15.CloseEffect(p45) -- name: CloseEffect
	-- upvalues: (copy) v_u_14, (copy) v_u_13, (copy) v_u_5
	if p45:_IsOpenEffectDisabled() then
		p45._equipment_open_hash = p45._equipment_open_hash + 1
		p45._equipment_open_is_closing = true
		p45._equipment_open_start_cframe = CFrame.identity
		p45._equipment_open_start = 0
		p45._equipment_open_finished = true
		p45.FinishedOpenEffect:Fire()
		return
	else
		p45._equipment_open_hash = p45._equipment_open_hash + 1
		p45._equipment_open_is_closing = true
		p45._equipment_open_start_cframe = workspace.CurrentCamera.CFrame
		p45._equipment_open_start = tick()
		p45._equipment_open_finished = false
		p45.FinishedOpenEffect:Fire()
		p45._frame.Position = v_u_14
		p45._frame:TweenPosition(v_u_13, "InOut", "Quint", 0.75, true)
		v_u_5:CreateSound("rbxassetid://106551800007995", 1.25, 0.8 + 0.2 * math.random(), script, true, 5)
		local v46 = p45._equipment_open_hash
		wait(0.375)
		if v46 == p45._equipment_open_hash then
			if not p45._equipment_open_finished then
				p45._equipment_open_finished = true
				p45.FinishedOpenEffect:Fire()
			end
		end
	end
end
function v_u_15._IsOpenEffectDisabled(_) -- name: _IsOpenEffectDisabled
	-- upvalues: (copy) v_u_3
	return v_u_3.ReducedMotionEnabled
end
function v_u_15._IncrementFOVSpringFromInput(p47, p48) -- name: _IncrementFOVSpringFromInput
	local v49 = p47._scroll_fov_spring
	local v50 = p47._scroll_fov_spring.Target + p48
	v49.Target = math.clamp(v50, -10, 10)
end
function v_u_15._VerifyControls(p_u_51) -- name: _VerifyControls
	-- upvalues: (copy) v_u_2, (copy) v_u_9, (copy) v_u_10
	for _, v52 in pairs(p_u_51._controls_connections) do
		v52:Disconnect()
	end
	p_u_51._controls_connections = {}
	p_u_51._fov_zoom_direction = Vector2.zero
	if p_u_51.Equipment.IsOpen then
		local v53 = p_u_51._controls_connections
		local v54 = v_u_2.TouchPinch
		table.insert(v53, v54:Connect(function(_, _, p55, _, p56)
			-- upvalues: (copy) p_u_51
			if not p56 then
				p_u_51:_IncrementFOVSpringFromInput(p55 * -0.25)
			end
		end))
		local v57 = p_u_51._controls_connections
		local v58 = v_u_2.InputChanged
		local function v60(p59, _)
			-- upvalues: (ref) v_u_9, (ref) v_u_10, (copy) p_u_51
			if v_u_9.PageSystem.CurrentPage or p59.UserInputType ~= Enum.UserInputType.MouseWheel then
				return
			elseif v_u_10:IsMouseWithinBounds(p_u_51.Equipment.Interface.Left.Frame.AbsolutePosition, p_u_51.Equipment.Interface.Left.Frame.AbsoluteSize) then
				return
			elseif v_u_10:IsMouseWithinBounds(p_u_51.Equipment.Interface.Right.Frame.AbsolutePosition, p_u_51.Equipment.Interface.Right.Frame.AbsoluteSize) then
				return
			elseif not v_u_10:IsMouseWithinBounds(p_u_51.Equipment.Interface.Customize.Cosmetics.List.AbsolutePosition, p_u_51.Equipment.Interface.Customize.Cosmetics.List.AbsoluteSize) then
				p_u_51:_IncrementFOVSpringFromInput(p59.Position.Z * -1)
			end
		end
		table.insert(v57, v58:Connect(v60))
		local v61 = p_u_51._controls_connections
		local v62 = v_u_2.InputBegan
		table.insert(v61, v62:Connect(function(p63, _)
			-- upvalues: (copy) p_u_51
			if p63.KeyCode == Enum.KeyCode.ButtonL2 then
				p_u_51._fov_zoom_direction = Vector2.new(1, p_u_51._fov_zoom_direction.Y)
			elseif p63.KeyCode == Enum.KeyCode.ButtonR2 then
				p_u_51._fov_zoom_direction = Vector2.new(p_u_51._fov_zoom_direction.X, 1)
			end
		end))
		local v64 = p_u_51._controls_connections
		local v65 = v_u_2.InputEnded
		table.insert(v64, v65:Connect(function(p66, _)
			-- upvalues: (copy) p_u_51
			if p66.KeyCode == Enum.KeyCode.ButtonL2 then
				p_u_51._fov_zoom_direction = Vector2.new(0, p_u_51._fov_zoom_direction.Y)
			elseif p66.KeyCode == Enum.KeyCode.ButtonR2 then
				p_u_51._fov_zoom_direction = Vector2.new(p_u_51._fov_zoom_direction.X, 0)
			end
		end))
	end
end
function v_u_15._UpdateFocus(p67) -- name: _UpdateFocus
	-- upvalues: (copy) v_u_9
	local v68 = p67.Equipment:GetCustomizingType()
	p67._look_at_offset = v68 == "Charm" and Vector3.new(0, -0.075, 0) or Vector3.new(0, 0, 0)
	local v69
	if v68 == "Charm" and p67.Equipment.FloatingModel then
		v69 = p67.Equipment.FloatingModel:GetCharmPivotAttachment() or nil
	else
		v69 = nil
	end
	p67._look_at_attachment = v69
	p67._fov_spring.Speed = v_u_9.PageSystem.CurrentPage and 15 or 5
	p67._fov_spring.Target = v68 == "Finisher" and 40 or (v68 == "Emote" and 25 or (v68 == "Charm" and 5 or (v68 and 12.5 or (v_u_9.PageSystem.CurrentPage and 20 or 15))))
end
function v_u_15._Setup(p70) -- name: _Setup
	-- upvalues: (copy) v_u_10
	p70._frame.Parent = v_u_10.MainGui
end
function v_u_15._Init(p_u_71) -- name: _Init
	-- upvalues: (copy) v_u_9
	p_u_71.Equipment.CustomizingChanged:Connect(function()
		-- upvalues: (copy) p_u_71
		p_u_71:_UpdateFocus()
	end)
	p_u_71.Equipment.CharmAttachmentVisibleChanged:Connect(function()
		-- upvalues: (copy) p_u_71
		p_u_71:_UpdateFocus()
	end)
	v_u_9.PageSystem.PagesActivity:Connect(function()
		-- upvalues: (copy) p_u_71
		p_u_71:_UpdateFocus()
	end)
	p_u_71:_Setup()
	p_u_71:_UpdateFocus()
end
return v_u_15