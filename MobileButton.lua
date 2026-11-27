local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("UserInputService")
local v_u_3 = game:GetService("TweenService")
game:GetService("GuiService")
local v_u_4 = game:GetService("RunService")
local v_u_5 = game:GetService("Players")
local v_u_6 = require(v1.Modules.CONSTANTS)
local v_u_7 = require(v1.Modules.BetterDebris)
local v_u_8 = require(v1.Modules.InputLibrary)
local v_u_9 = require(v1.Modules.ItemLibrary)
local v_u_10 = require(v1.Modules.Utility)
local v_u_11 = require(v_u_5.LocalPlayer.PlayerScripts.Controllers:WaitForChild("PlayerDataController"))
local v_u_12 = require(v_u_5.LocalPlayer.PlayerScripts.Controllers:WaitForChild("MechanicsController"))
local v_u_13 = require(v_u_5.LocalPlayer.PlayerScripts.Controllers:WaitForChild("SettingsController"))
local v_u_14 = require(v_u_5.LocalPlayer.PlayerScripts.Controllers:WaitForChild("SpectateController"))
require(v_u_5.LocalPlayer.PlayerScripts.Controllers:WaitForChild("FighterController"))
local v_u_15 = require(v_u_5.LocalPlayer.PlayerScripts.Controllers:WaitForChild("CameraController"))
local v_u_16 = require(v_u_5.LocalPlayer.PlayerScripts.Controllers:WaitForChild("EmoteController"))
local v_u_17 = require(v_u_5.LocalPlayer.PlayerScripts.Modules:WaitForChild("InfiniteParticles"))
local v_u_18 = require(v_u_5.LocalPlayer.PlayerScripts.Modules:WaitForChild("UILibrary"))
local v_u_19 = v_u_5.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("MobileButtonCooldownSlot")
local v_u_20 = v_u_5.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("MobileButton")
local v_u_21 = {}
v_u_21.__index = v_u_21
function v_u_21.new(p22, p23) -- name: new
	-- upvalues: (copy) v_u_21, (copy) v_u_20, (copy) v_u_8, (copy) v_u_17
	local v24 = v_u_21
	local v25 = setmetatable({}, v24)
	v25.Buttons = p22
	v25.Name = p23
	v25.Frame = v_u_20:Clone()
	v25.InvisibleFrame = v25.Frame:WaitForChild("Invisible")
	v25.ResizeIcon = v25.Frame:WaitForChild("Resize")
	v25.WeaponIcon = v25.Frame:WaitForChild("Weapon")
	v25.IconContainer = v25.Frame:WaitForChild("IconContainer")
	v25.Icon = v25.IconContainer:WaitForChild("Icon")
	v25.AmmoFrame = v25.Frame:WaitForChild("Ammo")
	v25.AmmoIcon = v25.AmmoFrame:WaitForChild("Icon")
	v25.AmmoTitle = v25.AmmoFrame:WaitForChild("Title")
	v25.AmmoTitleStroke = v25.AmmoTitle:WaitForChild("UIStroke")
	v25._local_fighter = nil
	v25._item_index = v_u_8.MobileInputNameToItemIndex[v25.Name]
	v25._info = v_u_8.MobileButtons[v25.Name]
	v25._is_active = false
	v25._is_scoped = false
	v25._is_resizing = false
	v25._resize_connection = nil
	v25._is_dragging = false
	v25._drag_connection = nil
	v25._drag_delta = nil
	v25._drag_original_position = nil
	v25._current_cooldown_frame = nil
	v25._infinite_particles = v_u_17.new(v25.AmmoTitle)
	v25:_Init()
	return v25
end
function v_u_21.IsReallyVisible(p26) -- name: IsReallyVisible
	local v27 = p26.Frame.Visible
	if v27 then
		v27 = p26.Buttons:IsReallyVisible()
	end
	return v27
end
function v_u_21.IsWithin(p28, p29, p30) -- name: IsWithin
	-- upvalues: (copy) v_u_18
	return v_u_18:IsWithinBounds(p29, p30, p28.Frame.AbsolutePosition, p28.Frame.AbsoluteSize)
end
function v_u_21.SetScoped(p31, p32) -- name: SetScoped
	if p31._is_scoped ~= p32 then
		p31._is_scoped = p32
		p31:UpdateVisuals()
	end
end
function v_u_21.SetActive(p33, p34) -- name: SetActive
	p33._is_active = p34
	p33:UpdateVisuals()
end
function v_u_21.Input(p35, p36, p37) -- name: Input
	-- upvalues: (copy) v_u_15, (copy) v_u_12
	if p37 or not p35.Buttons.MobileInputs.EditorEnabled and p35:_IsVisible(p35.Name) then
		p35:SetActive(p36)
		if p35.Name == "mobile_switchcamerapov" then
			if p36 then
				v_u_15.CameraState:TogglePOV()
				return
			end
		elseif p35.Name == "mobile_crouch" and (v_u_12.IsSliding and p35:_IsEasySlideEnabled()) then
			if p36 then
				v_u_12:MobileInput("mobile_jump", true)
				return
			end
		elseif p35.Name == "mobile_slide" and v_u_12.IsSliding then
			if p36 then
				v_u_12:MobileInput("mobile_jump", true)
				return
			end
		else
			v_u_12:MobileInput(p35.Name, p36)
		end
	end
end
function v_u_21.InputEnded(p38, _) -- name: InputEnded
	if p38._is_resizing then
		p38._resize_connection:Disconnect()
		p38._resize_connection = nil
		p38._is_resizing = false
	end
	if p38._is_dragging then
		p38._drag_connection:Disconnect()
		p38._drag_connection = nil
		p38._drag_delta = nil
		p38._drag_original_position = nil
		p38._is_dragging = false
	end
end
function v_u_21.Button1Down(p_u_39, p_u_40) -- name: Button1Down
	p_u_39.Buttons.MobileInputs.DoubleTap:ResetTapWindow()
	if p_u_39:_IsToggleMode() then
		p_u_39:Input(not p_u_39._is_active)
	else
		task.spawn(function()
			-- upvalues: (copy) p_u_40, (copy) p_u_39
			if p_u_40 then
				while p_u_40.UserInputState ~= Enum.UserInputState.End do
					p_u_40:GetPropertyChangedSignal("UserInputState"):Wait()
				end
				p_u_39:Button1Up()
			end
		end)
		p_u_39:Input(true)
	end
end
function v_u_21.Button1Up(p41) -- name: Button1Up
	p41:Input(false)
end
function v_u_21.UpdateVisuals(p42) -- name: UpdateVisuals
	-- upvalues: (copy) v_u_13
	local v43 = not p42._is_active and p42._item_index and (p42._local_fighter and p42._local_fighter.EquippedItem)
	if v43 then
		v43 = p42._local_fighter.EquippedItem == p42._local_fighter.Items[p42._item_index]
	end
	if v43 then
		v43 = not p42.Buttons.MobileInputs.EditorEnabled
	end
	local v44 = v_u_13:GetMobileButtonSetting(p42.Name, "Mobile Buttons Transparency", "Transparency")
	if p42._is_scoped and v_u_13:GetMobileButtonSetting(p42.Name, "Opaque Buttons While Scoped") then
		v44 = 0
	elseif v43 then
		v44 = v44 * 2 - 1
	end
	local v45 = math.clamp(v44, 0, 1)
	local v46 = v44 * 2
	local v47 = math.clamp(v46, 0, 1)
	local v48 = v44 * 2 - 1
	local v49 = math.clamp(v48, 0, 1)
	p42.InvisibleFrame.Visible = not p42:_IsVisibleSetting()
	p42.IconContainer.ImageTransparency = v47 * 1 + 0
	p42.Icon.ImageTransparency = v45
	p42.Icon.ImageColor3 = v43 and Color3.fromRGB(0, 190, 255) or Color3.fromRGB(0, 0, 0)
	p42.WeaponIcon.ImageTransparency = v49 * 1 + 0
	p42.AmmoIcon.ImageTransparency = v49 * 1 + 0
	p42.AmmoTitle.TextTransparency = v49 * 1 + 0
	p42.AmmoTitleStroke.Transparency = v49 * 0.125 + 0.875
end
function v_u_21.UpdateWeaponIcon(p50) -- name: UpdateWeaponIcon
	-- upvalues: (copy) v_u_9, (copy) v_u_6
	local v51 = p50:_GetClientItem()
	p50.WeaponIcon.Image = p50._item_index and ((not p50.Buttons.MobileInputs.EditorEnabled and v51 and true or false) and v51.ViewModel:GetImage() or (v_u_9.Items[v_u_6.DEFAULT_WEAPONS[p50._item_index]].Image or "")) or ""
end
function v_u_21.UpdatePositionAndSize(p52, p53) -- name: UpdatePositionAndSize
	-- upvalues: (copy) v_u_11
	p52:ResetPositionAndSize()
	local v54 = p53 or v_u_11:Get("MobileButtonSettings")[v_u_11:Get("SettingsProfile")]
	if v54 then
		local v55 = v54[p52.Name]
		if v55 then
			p52.Frame.Position = UDim2.new(0, v55.Position[1], 0, v55.Position[2])
			p52.Frame.Size = UDim2.new(0, v55.Size[1], 0, v55.Size[2])
		end
	else
		return
	end
end
function v_u_21.ResetPositionAndSize(p56) -- name: ResetPositionAndSize
	local v57 = p56.Buttons.Frame.AbsoluteSize.X
	local v58 = p56.Buttons.Frame.AbsoluteSize.Y
	local v59 = math.min(v57, v58) <= 500
	local v60 = v59 and UDim2.new() or UDim2.new(0, 0, 0, -45)
	local v61 = v59 and 1 or 1.7894736842105263
	local v62 = v59 and 1 or 1.7142857142857142
	p56.Frame.Position = v60 + UDim2.new(p56._info.DefaultPosition.X.Scale, p56._info.DefaultPosition.X.Offset * v61, p56._info.DefaultPosition.Y.Scale, p56._info.DefaultPosition.Y.Offset * v61)
	p56.Frame.Size = UDim2.new(0, p56._info.DefaultSize.X.Offset * v62, 0, p56._info.DefaultSize.Y.Offset * v62)
end
function v_u_21.UpdateVisibility(p63) -- name: UpdateVisibility
	p63.Frame.Visible = p63:_IsVisible()
	if not p63.Frame.Visible then
		p63:SetActive(false)
	end
end
function v_u_21.UpdateMobileInputSettings(p64) -- name: UpdateMobileInputSettings
	if not (p64._info.IsCoreInput or p64._info.QuickAttackType) then
		p64:Input(false, true)
	end
	p64:UpdateVisibility()
end
function v_u_21.Update(p65, p66) -- name: Update
	p65._infinite_particles:Update(p66)
end
function v_u_21._GetClientItem(p67) -- name: _GetClientItem
	local v68 = p67._item_index and p67._local_fighter
	if v68 then
		v68 = p67._local_fighter.Items[p67._item_index]
	end
	return v68
end
function v_u_21._UpdateAmmo(p69) -- name: _UpdateAmmo
	-- upvalues: (copy) v_u_11, (copy) v_u_9
	local v70 = not p69.Buttons.MobileInputs.EditorEnabled
	if v70 then
		v70 = p69:_GetClientItem()
	end
	if v70 then
		local v71, v72, v73, v74 = v70:GetAmmoVariables()
		local v75 = v_u_11:GetSetting("Touch Button Ammo")
		local v76 = v71 and v71 <= 0 and Color3.fromRGB(255, 50, 50) or Color3.fromRGB(255, 255, 255)
		local v77 = v71 and v71 <= 0 and "rgb(255,50,50)" or "rgb(255,255,255)"
		local v78 = v74 and "\226\136\158" or (v72 or "")
		local v79 = v72 and v72 <= 0 and Color3.fromRGB(255, 50, 50) or Color3.fromRGB(255, 255, 255)
		local v80 = v72 and v72 <= 0 and "rgb(255,50,50)" or "rgb(255,255,255)"
		p69.AmmoFrame.Visible = v71 and v75
		p69.AmmoTitle.Text = string.format("<font color=\"%s\">%s</font>", v77, v73 and "\226\136\158" or (v71 or "")) .. (v78 == "" and "" or string.format("<font size=\"8\" color=\"%s\"> %s</font>", v80, v78))
		local v81 = p69.AmmoIcon
		if v72 then
			v76 = v79 or v76
		end
		v81.ImageColor3 = v76
		p69.AmmoIcon.Image = v70.Info.AmmoType and v_u_9.Ammos[v70.Info.AmmoType].Image or ""
		p69._infinite_particles:SetActive(v73, v74)
	else
		p69.AmmoFrame.Visible = false
	end
end
function v_u_21._GetMobileInputSettingsFromEquippedItem(p82) -- name: _GetMobileInputSettingsFromEquippedItem
	-- upvalues: (copy) v_u_8
	local v83 = p82._local_fighter and p82._local_fighter.EquippedItem
	if v83 then
		v83 = p82._local_fighter.EquippedItem:GetMobileInputSettings()
	end
	if v83 then
		v83 = v83[v_u_8.MobileButtons[p82.Name].InputName]
	end
	return v83
end
function v_u_21._IsEasySlideEnabled(_) -- name: _IsEasySlideEnabled
	-- upvalues: (copy) v_u_11
	local v84 = v_u_11:GetSetting("Easy Slide Mobile")
	if v84 then
		v84 = not v_u_11:GetSetting("MobileButton mobile_slide Enabled")
	end
	return v84
end
function v_u_21._IsVisibleSetting(p85) -- name: _IsVisibleSetting
	-- upvalues: (copy) v_u_11
	return v_u_11:GetSetting("MobileButton " .. p85.Name .. " Enabled")
end
function v_u_21._IsToggleMode(p86) -- name: _IsToggleMode
	return p86._info.AlwaysToggle or p86:_GetMobileInputSettingsFromEquippedItem() == true
end
function v_u_21._IsVisible(p87) -- name: _IsVisible
	-- upvalues: (copy) v_u_14, (copy) v_u_15, (copy) v_u_16
	if p87.Buttons.MobileInputs.EditorEnabled then
		return true
	elseif p87._local_fighter and p87:_IsVisibleSetting() then
		if v_u_14.CurrentDuelSubject then
			if v_u_14.CurrentDuelSubject.DuelInterface.Voting:IsOpen() then
				return false
			end
			if not (v_u_14.CurrentDuelSubject.LocalDueler or p87._info.VisibleWhileSpectatingForeignDuel) then
				return false
			end
		end
		if p87._info.AlwaysVisible or p87:_GetMobileInputSettingsFromEquippedItem() ~= nil then
			if p87._info.HideIfDead and not p87._local_fighter:IsAlive() then
				return false
			elseif p87.Name == "mobile_quickmelee" and #p87._local_fighter.Items < p87._local_fighter:GetQuickAttackIndex(p87._info.QuickAttackType) then
				return false
			elseif p87.Name == "mobile_quickutility" and #p87._local_fighter.Items < p87._local_fighter:GetQuickAttackIndex(p87._info.QuickAttackType) then
				return false
			elseif p87.Name == "mobile_equipnext" and #p87._local_fighter.Items < 2 then
				return false
			elseif p87.Name == "mobile_switchcamerapov" and (not v_u_15:GetPublicState() and (not v_u_14.CurrentDuelSubject or v_u_14.CurrentDuelSubject.LocalDueler)) then
				return false
			elseif p87.Name == "mobile_openplayerlist" and not v_u_14.CurrentDuelSubject then
				return false
			elseif p87.Name == "mobile_equipprimary" and #p87._local_fighter.Items < 1 then
				return false
			elseif p87.Name == "mobile_equipsecondary" and #p87._local_fighter.Items < 2 then
				return false
			elseif p87.Name == "mobile_equipmelee" and #p87._local_fighter.Items < 3 then
				return false
			elseif p87.Name == "mobile_equiputility" and #p87._local_fighter.Items < 4 then
				return false
			else
				return (p87.Name ~= "mobile_useemote" or v_u_16:CanEmote()) and true or false
			end
		else
			return false
		end
	else
		return false
	end
end
function v_u_21._UpdateCameraSinking(p88) -- name: _UpdateCameraSinking
	-- upvalues: (copy) v_u_13
	p88.Frame.Active = not v_u_13:GetMobileButtonSetting(p88.Name, "Camera Mobile Button Sinking", "Camera Sinking")
end
function v_u_21._UpdateEditorVisuals(p89) -- name: _UpdateEditorVisuals
	p89.ResizeIcon.Visible = p89.Buttons.MobileInputs.EditorEnabled
	if p89._current_cooldown_frame then
		p89._current_cooldown_frame.Visible = not p89.Buttons.MobileInputs.EditorEnabled
	end
end
function v_u_21._SetupEditorLogic(p_u_90) -- name: _SetupEditorLogic
	-- upvalues: (copy) v_u_18, (copy) v_u_4, (copy) v_u_2
	local function v_u_95() -- name: update_resize
		-- upvalues: (copy) p_u_90, (ref) v_u_18
		local v91 = p_u_90.Frame.AbsolutePosition + p_u_90.Frame.AbsoluteSize * p_u_90.Frame.AnchorPoint - v_u_18:GetMouseLocation()
		local v92 = v91.X ^ 2 + v91.Y ^ 2
		local v93 = math.sqrt(v92) * 2
		local v94 = math.max(v93, 35)
		p_u_90.Frame.Size = UDim2.new(0, v94, 0, v94)
	end
	local v_u_96 = nil
	local function v_u_106(p97) -- name: update_drag
		-- upvalues: (copy) p_u_90, (ref) v_u_96
		local v98 = p_u_90
		v98._drag_delta = v98._drag_delta + (not v_u_96 and Vector3.new(0, 0, 0) or p97.Position - v_u_96)
		v_u_96 = p97.Position
		local v99 = p_u_90.Frame
		local v100 = UDim2.new
		local v101 = p_u_90._drag_original_position.X + p_u_90._drag_delta.X
		local v102 = p_u_90.Buttons.Frame.AbsoluteSize.X
		local v103 = math.clamp(v101, 0, v102)
		local v104 = p_u_90._drag_original_position.Y + p_u_90._drag_delta.Y
		local v105 = p_u_90.Buttons.Frame.AbsoluteSize.Y
		v99.Position = v100(0, v103, 0, (math.clamp(v104, 0, v105)))
	end
	p_u_90.Frame.Resize.MouseButton1Down:Connect(function()
		-- upvalues: (copy) p_u_90, (ref) v_u_4, (copy) v_u_95
		if p_u_90.Buttons.MobileInputs.EditorEnabled and not p_u_90._is_resizing then
			p_u_90.Buttons.MobileInputs.EditorLogic:PendEdits()
			p_u_90._is_resizing = true
			p_u_90._resize_connection = v_u_4.RenderStepped:Connect(v_u_95)
		end
	end)
	p_u_90.Frame.MouseButton1Down:Connect(function()
		-- upvalues: (copy) p_u_90, (ref) v_u_96, (ref) v_u_2, (copy) v_u_106
		if p_u_90.Buttons.MobileInputs.EditorEnabled and not p_u_90._is_dragging then
			p_u_90.Buttons.MobileInputs.EditorLogic:PendEdits()
			v_u_96 = nil
			p_u_90._is_dragging = true
			p_u_90._drag_original_position = p_u_90.Frame.AbsolutePosition + p_u_90.Frame.AbsoluteSize * p_u_90.Frame.AnchorPoint - p_u_90.Buttons.Frame.AbsolutePosition
			p_u_90._drag_delta = Vector3.new(0, 0, 0)
			p_u_90._drag_connection = v_u_2.InputChanged:Connect(v_u_106)
		end
	end)
end
function v_u_21._HookFighter(p_u_107) -- name: _HookFighter
	-- upvalues: (copy) v_u_12, (copy) v_u_11, (copy) v_u_13, (copy) v_u_19, (copy) v_u_7, (copy) v_u_3, (copy) v_u_10
	p_u_107._local_fighter = v_u_12:WaitForLocalFighter()
	p_u_107._local_fighter:GetDataChangedSignal("InfiniteAmmo"):Connect(function()
		-- upvalues: (copy) p_u_107
		p_u_107:_UpdateAmmo()
	end)
	p_u_107._local_fighter:GetDataChangedSignal("InfiniteAmmoReserve"):Connect(function()
		-- upvalues: (copy) p_u_107
		p_u_107:_UpdateAmmo()
	end)
	v_u_11:GetSettingChangedSignal("Touch Button Ammo"):Connect(function()
		-- upvalues: (copy) p_u_107
		p_u_107:_UpdateAmmo()
	end)
	if p_u_107._item_index then
		local v_u_108 = {}
		local v_u_109 = {}
		local v_u_110 = {}
		local v_u_111 = nil
		local function v_u_114() -- name: cleanup_cooldown_effect
			-- upvalues: (ref) v_u_108, (ref) v_u_109, (copy) p_u_107
			for _, v112 in pairs(v_u_108) do
				v112:Disconnect()
			end
			for _, v113 in pairs(v_u_109) do
				v113:Destroy()
			end
			v_u_108 = {}
			v_u_109 = {}
			p_u_107._current_cooldown_frame = nil
		end
		local function v_u_133(p115) -- name: cooldown_effect
			-- upvalues: (copy) v_u_114, (ref) v_u_13, (copy) p_u_107, (ref) v_u_19, (ref) v_u_7, (ref) v_u_109, (ref) v_u_108, (ref) v_u_3
			if not p115.IsReversed then
				v_u_114()
				local v116, v117, v118 = p115.GetVariables()
				local v119 = v_u_13:GetMobileButtonSetting(p_u_107.Name, "Mobile Buttons Transparency", "Transparency") * 2 - 1
				local v120 = v_u_19:Clone()
				v120.Right.Frame.UIStroke.Transparency = v119
				v120.Left.Frame.UIStroke.Transparency = v119
				v120.Icon.Image = ""
				v120.Parent = p_u_107.Frame
				v_u_7:AddItem(v120, v116)
				local v121 = v_u_109
				table.insert(v121, v120)
				p_u_107._current_cooldown_frame = v120
				local v_u_122 = v120.Right.Frame.UIStroke.UIGradient
				local v_u_123 = v120.Left.Frame.UIStroke.UIGradient
				local v_u_124 = Instance.new("NumberValue")
				v_u_124.Value = v117
				local v125 = v_u_109
				table.insert(v125, v_u_124)
				local v126 = v_u_108
				local v127 = v_u_124:GetPropertyChangedSignal("Value")
				table.insert(v126, v127:Connect(function()
					-- upvalues: (copy) v_u_124, (copy) v_u_122, (copy) v_u_123
					local v128 = 1 - v_u_124.Value
					local v129 = v128 * 2
					local v130 = math.clamp(v129, 0, 1)
					local v131 = v128 * 2 - 1
					local v132 = math.clamp(v131, 0, 1)
					v_u_122.Rotation = v130 * 180 + -180
					v_u_123.Rotation = v132 * 180 + 0
				end))
				v_u_3:Create(v_u_124, TweenInfo.new(v116, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {
					["Value"] = v118
				}):Play()
				p_u_107:_UpdateEditorVisuals()
			end
		end
		local function v149() -- name: update_client_item
			-- upvalues: (copy) p_u_107, (ref) v_u_111, (copy) v_u_114, (ref) v_u_108, (ref) v_u_110, (ref) v_u_3, (ref) v_u_10, (copy) v_u_133
			local v134 = p_u_107._local_fighter.Items[p_u_107._item_index]
			if v134 == v_u_111 then
				return
			else
				v_u_114()
				for _, v135 in pairs(v_u_108) do
					v135:Disconnect()
				end
				v_u_110 = {}
				v_u_111 = v134
				p_u_107:_UpdateAmmo()
				if v_u_111 then
					local v136 = v_u_110
					local v137 = v_u_111:GetDataChangedSignal("Ammo")
					local function v138()
						-- upvalues: (ref) p_u_107
						p_u_107:_UpdateAmmo()
					end
					table.insert(v136, v137:Connect(v138))
					local v139 = v_u_110
					local v140 = v_u_111:GetDataChangedSignal("AmmoReserve")
					local function v141()
						-- upvalues: (ref) p_u_107
						p_u_107:_UpdateAmmo()
					end
					table.insert(v139, v140:Connect(v141))
					local v142 = v_u_110
					local v143 = v_u_111.EquipFailedEffect
					local function v144()
						-- upvalues: (ref) p_u_107, (ref) v_u_3, (ref) v_u_10
						if p_u_107:IsReallyVisible() then
							p_u_107.WeaponIcon.ImageColor3 = Color3.fromRGB(127, 0, 0)
							p_u_107.WeaponIcon.Position = UDim2.new(0.5, 0, 0.75, 0)
							v_u_3:Create(p_u_107.WeaponIcon, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
								["ImageColor3"] = Color3.fromRGB(255, 255, 255),
								["Position"] = UDim2.new(0.5, 0, 0.5, 0)
							}):Play()
							v_u_10:CreateSound("rbxassetid://17153811469", 2, 1, script, true, 5)
						end
					end
					table.insert(v142, v143:Connect(v144))
					local v145 = v_u_110
					local v146 = v_u_111.Cooldowns.CooldownAdded
					local v147 = v_u_133
					table.insert(v145, v146:Connect(v147))
					for _, v148 in pairs(v_u_111.Cooldowns.Cooldowns) do
						task.spawn(v_u_133, v148)
					end
				end
			end
		end
		p_u_107._local_fighter.ItemAdded:Connect(v149)
		p_u_107._local_fighter.ItemRemoved:Connect(v149)
		v149()
	end
	p_u_107:UpdateVisibility()
	p_u_107:UpdateVisuals()
	p_u_107:UpdateWeaponIcon()
end
function v_u_21._HookPages(p_u_150) -- name: _HookPages
	-- upvalues: (copy) v_u_5
	require(v_u_5.LocalPlayer.PlayerScripts.Modules.UserInterface:WaitForChild("Pages")).PageSystem.PagesActivity:Connect(function()
		-- upvalues: (copy) p_u_150
		p_u_150:Button1Up()
	end)
end
function v_u_21._Setup(p_u_151) -- name: _Setup
	-- upvalues: (copy) v_u_12, (copy) v_u_8
	p_u_151.Frame.Name = p_u_151.Name
	p_u_151.Icon.Image = p_u_151._item_index and "rbxassetid://16793449322" or p_u_151._info.Image
	if p_u_151.Name == "mobile_crouch" then
		local function v152() -- name: update_icon
			-- upvalues: (ref) v_u_12, (copy) p_u_151, (ref) v_u_8
			if not v_u_12.IsSliding then
				task.spawn(v_u_12.MobileInput, v_u_12, "mobile_jump", false)
			end
			p_u_151.Icon.Image = not p_u_151:_IsEasySlideEnabled() and p_u_151._info.Image or v_u_12.IsSliding and v_u_8.MobileButtons.mobile_jump.Image or (v_u_12.IsSprinting and v_u_8.MobileButtons.mobile_slide.Image or p_u_151._info.Image)
		end
		v_u_12.StateChanged:Connect(v152)
		v152()
	elseif p_u_151.Name == "mobile_slide" then
		local function v153() -- name: update_icon
			-- upvalues: (copy) p_u_151, (ref) v_u_12, (ref) v_u_8
			p_u_151.Icon.Image = v_u_12.IsSliding and v_u_8.MobileButtons.mobile_jump.Image or p_u_151._info.Image
		end
		v_u_12.StateChanged:Connect(v153)
		p_u_151.Icon.Image = v_u_12.IsSliding and v_u_8.MobileButtons.mobile_jump.Image or p_u_151._info.Image
	end
end
function v_u_21._Init(p_u_154) -- name: _Init
	-- upvalues: (copy) v_u_11
	p_u_154.Buttons.MobileInputs.EditorEnabledChanged:Connect(function()
		-- upvalues: (copy) p_u_154
		p_u_154:_UpdateEditorVisuals()
		p_u_154:UpdateVisuals()
	end)
	v_u_11:GetSettingChangedSignal("MobileButton " .. p_u_154.Name .. " Enabled"):Connect(function()
		-- upvalues: (copy) p_u_154
		p_u_154:UpdateVisuals()
		p_u_154:UpdateVisibility()
	end)
	v_u_11:GetSettingChangedSignal("Camera Mobile Button Sinking"):Connect(function()
		-- upvalues: (copy) p_u_154
		p_u_154:_UpdateCameraSinking()
	end)
	v_u_11:GetSettingChangedSignal("MobileButton " .. p_u_154.Name .. " Camera Sinking"):Connect(function()
		-- upvalues: (copy) p_u_154
		p_u_154:_UpdateCameraSinking()
	end)
	v_u_11:GetSettingChangedSignal("Mobile Buttons Transparency"):Connect(function()
		-- upvalues: (copy) p_u_154
		p_u_154:UpdateVisuals()
	end)
	v_u_11:GetSettingChangedSignal("MobileButton " .. p_u_154.Name .. " Transparency"):Connect(function()
		-- upvalues: (copy) p_u_154
		p_u_154:UpdateVisuals()
	end)
	v_u_11:GetSettingChangedSignal("MobileButton " .. p_u_154.Name .. " Override"):Connect(function()
		-- upvalues: (copy) p_u_154
		p_u_154:_UpdateCameraSinking()
		p_u_154:UpdateVisuals()
	end)
	p_u_154:_Setup()
	p_u_154:_SetupEditorLogic()
	p_u_154:_UpdateEditorVisuals()
	p_u_154:_UpdateCameraSinking()
	p_u_154:_UpdateAmmo()
	p_u_154:UpdateVisuals()
	p_u_154:UpdateWeaponIcon()
	p_u_154:UpdatePositionAndSize()
	p_u_154:UpdateVisibility()
	task.defer(p_u_154._HookPages, p_u_154)
	task.defer(p_u_154._HookFighter, p_u_154)
end
return v_u_21