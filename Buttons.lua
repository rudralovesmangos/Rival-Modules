local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("UserInputService")
local v_u_3 = game:GetService("RunService")
local v_u_4 = game:GetService("Players")
local v_u_5 = require(v1.Modules.InputLibrary)
local v_u_6 = require(v1.Modules.EnumLibrary)
local v_u_7 = require(v1.Modules.Utility)
local v_u_8 = require(v_u_4.LocalPlayer.PlayerScripts.Controllers:WaitForChild("PlayerDataController"))
local v_u_9 = require(v_u_4.LocalPlayer.PlayerScripts.Controllers:WaitForChild("MechanicsController"))
local v_u_10 = require(v_u_4.LocalPlayer.PlayerScripts.Controllers:WaitForChild("SpectateController"))
local v_u_11 = require(v_u_4.LocalPlayer.PlayerScripts.Controllers:WaitForChild("CameraController"))
local v_u_12 = require(v_u_4.LocalPlayer.PlayerScripts.Controllers:WaitForChild("EmoteController"))
local v_u_13 = require(script:WaitForChild("MobileButton"))
local v_u_14 = {}
v_u_14.__index = v_u_14
function v_u_14.new(p15) -- name: new
	-- upvalues: (copy) v_u_14
	local v16 = v_u_14
	local v17 = setmetatable({}, v16)
	v17.MobileInputs = p15
	v17.Frame = v17.MobileInputs.Frame:WaitForChild("Buttons")
	v17.Buttons = {}
	v17._generated = false
	v17._hooked_fighter = false
	v17._local_fighter = nil
	v17._connections = {}
	v17._duel_subject_connections = {}
	v17:_Init()
	return v17
end
function v_u_14.IsReallyVisible(p18) -- name: IsReallyVisible
	local v19 = p18.Frame.Visible
	if v19 then
		v19 = p18.MobileInputs.Frame.Visible
	end
	return v19
end
function v_u_14.GetButtonsFromPosition(p20, p21, p22) -- name: GetButtonsFromPosition
	-- upvalues: (copy) v_u_4
	if require(v_u_4.LocalPlayer.PlayerScripts.Modules.UserInterface.Inset):IsWithinAnyBar(p21, p22) then
		return {}
	end
	local v23 = {}
	for _, v24 in pairs(p20.Buttons) do
		if not (v24:IsReallyVisible() and v24:IsWithin(p21, p22)) then
			continue
		end
		table.insert(v23, v24)
	end
	return v23
end
function v_u_14.GetCurrentProfile(p25) -- name: GetCurrentProfile
	local v26 = {}
	for v27, v28 in pairs(p25.Buttons) do
		local v29 = v28.Frame.AbsolutePosition + v28.Frame.AbsoluteSize * v28.Frame.AnchorPoint - p25.Frame.AbsolutePosition
		v26[v27] = {
			["Position"] = { v29.X, v29.Y },
			["Size"] = { v28.Frame.Size.X.Offset, v28.Frame.Size.Y.Offset }
		}
	end
	return v26
end
function v_u_14.EncryptProfile(p30) -- name: EncryptProfile
	-- upvalues: (copy) v_u_6
	return v_u_6:EncryptTable(p30:GetCurrentProfile())
end
function v_u_14.VerifyControls(p_u_31, p32) -- name: VerifyControls
	-- upvalues: (copy) v_u_9, (copy) v_u_3, (copy) v_u_11, (copy) v_u_12, (copy) v_u_8, (copy) v_u_10, (copy) v_u_2
	for _, v33 in pairs(p_u_31._connections) do
		v33:Disconnect()
	end
	for _, v34 in pairs(p_u_31._duel_subject_connections) do
		v34:Disconnect()
	end
	p_u_31._connections = {}
	p_u_31._duel_subject_connections = {}
	if p_u_31._generated then
		v_u_9:MobileInput("mobile_shoot", false)
	end
	if p32 then
		p_u_31:_GenerateButtons()
		task.spawn(p_u_31._HookFighter, p_u_31)
		local v35 = p_u_31._connections
		local v36 = v_u_3.RenderStepped
		table.insert(v35, v36:Connect(function(p37)
			-- upvalues: (copy) p_u_31
			for _, v38 in pairs(p_u_31.Buttons) do
				v38:Update(p37)
			end
		end))
		local v39 = p_u_31._connections
		local v40 = v_u_11.ActiveStateChanged
		table.insert(v39, v40:Connect(function(_)
			-- upvalues: (copy) p_u_31
			p_u_31:_UpdateVisibilities()
		end))
		local v41 = p_u_31._connections
		local v42 = v_u_12.CanEmoteChanged
		table.insert(v41, v42:Connect(function()
			-- upvalues: (copy) p_u_31
			p_u_31:_UpdateVisibilities()
		end))
		local v43 = p_u_31._connections
		local v44 = v_u_8:GetDataChangedSignal("SettingsProfile")
		table.insert(v43, v44:Connect(function()
			-- upvalues: (copy) p_u_31
			p_u_31:_UpdatePositionsAndSizes()
		end))
		local v45 = p_u_31._connections
		local v46 = v_u_8:GetDataChangedSignal("MobileButtonSettings")
		table.insert(v45, v46:Connect(function()
			-- upvalues: (copy) p_u_31
			p_u_31:_UpdatePositionsAndSizes()
		end))
		local function v51() -- name: update_duel_subject
			-- upvalues: (copy) p_u_31, (ref) v_u_10
			for _, v47 in pairs(p_u_31._duel_subject_connections) do
				v47:Disconnect()
			end
			p_u_31._duel_subject_connections = {}
			p_u_31:_UpdateVisibilities()
			if v_u_10.CurrentDuelSubject then
				local v48 = p_u_31._duel_subject_connections
				local v49 = v_u_10.CurrentDuelSubject.DuelInterface.Voting.VisibilityChanged
				local function v50()
					-- upvalues: (ref) p_u_31
					p_u_31:_UpdateVisibilities()
				end
				table.insert(v48, v49:Connect(v50))
			end
		end
		local v52 = p_u_31._connections
		local v53 = v_u_10.DuelSubjectChanged
		table.insert(v52, v53:Connect(v51))
		v51()
		local v54 = p_u_31._connections
		local v55 = v_u_2.InputBegan
		table.insert(v54, v55:Connect(function(p56, _)
			-- upvalues: (copy) p_u_31
			if p56.UserInputType == Enum.UserInputType.Touch or p56.UserInputType == Enum.UserInputType.MouseButton1 then
				local v57 = p_u_31:GetButtonsFromPosition(p56.Position.X, p56.Position.Y)
				for _, v58 in pairs(v57) do
					v58:Button1Down(p56)
				end
			end
		end))
		local v59 = p_u_31._connections
		local v60 = v_u_2.InputEnded
		table.insert(v59, v60:Connect(function(p61, _)
			-- upvalues: (copy) p_u_31
			if p61.UserInputType == Enum.UserInputType.Touch or p61.UserInputType == Enum.UserInputType.MouseButton1 then
				for _, v62 in pairs(p_u_31.Buttons) do
					v62:InputEnded(p61)
				end
			end
		end))
		local v63 = p_u_31._connections
		local v64 = v_u_9.StateChanged
		local function v65(_)
			-- upvalues: (copy) p_u_31, (ref) v_u_9
			if p_u_31:IsReallyVisible() and not v_u_9.IsCrouching then
				p_u_31.Buttons.mobile_crouch:Input(false, true)
			end
		end
		table.insert(v63, v64:Connect(v65))
	end
end
function v_u_14.UpdatePositionsAndSizes(p66, ...) -- name: UpdatePositionsAndSizes
	p66:_UpdatePositionsAndSizes(...)
end
function v_u_14._UpdateWeaponIcons(p67, ...) -- name: _UpdateWeaponIcons
	for _, v68 in pairs(p67.Buttons) do
		v68:UpdateWeaponIcon(...)
	end
end
function v_u_14._UpdatePositionsAndSizes(p69, ...) -- name: _UpdatePositionsAndSizes
	for _, v70 in pairs(p69.Buttons) do
		v70:UpdatePositionAndSize(...)
	end
end
function v_u_14._UpdateVisibilities(p71, ...) -- name: _UpdateVisibilities
	for _, v72 in pairs(p71.Buttons) do
		v72:UpdateVisibility(...)
	end
end
function v_u_14._UpdateMobileInputSettings(p73, ...) -- name: _UpdateMobileInputSettings
	for _, v74 in pairs(p73.Buttons) do
		v74:UpdateMobileInputSettings(...)
	end
end
function v_u_14._GenerateButtons(p_u_75) -- name: _GenerateButtons
	-- upvalues: (copy) v_u_5, (copy) v_u_13
	if not p_u_75._generated then
		p_u_75._generated = true
		for v76 in pairs(v_u_5.MobileButtons) do
			local v77 = v_u_13.new(p_u_75, v76)
			v77.Frame.Parent = p_u_75.Frame
			p_u_75.Buttons[v77.Name] = v77
		end
		p_u_75.Frame:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
			-- upvalues: (copy) p_u_75
			p_u_75:_UpdatePositionsAndSizes()
		end)
	end
end
function v_u_14._HookFighter(p_u_78) -- name: _HookFighter
	-- upvalues: (copy) v_u_9
	if not p_u_78._hooked_fighter then
		p_u_78._hooked_fighter = true
		p_u_78._local_fighter = v_u_9:WaitForLocalFighter()
		local function v_u_82() -- name: check_scoped
			-- upvalues: (copy) p_u_78
			local v79 = false
			for v80 in pairs(p_u_78._local_fighter:GetEquippedItems()) do
				if not (v80.ItemInterface and v80.ItemInterface:IsScopeActive()) then
					continue
				end
				v79 = true
			end
			for _, v81 in pairs(p_u_78.Buttons) do
				v81:SetScoped(v79)
			end
		end
		p_u_78._local_fighter.EquippedItemChanged:Connect(v_u_82)
		local function v_u_85(p83, p84) -- name: item_interface_added
			-- upvalues: (copy) v_u_82
			p83.Mouse.Scope.ActiveChanged:Connect(v_u_82)
			if not p84 then
				v_u_82()
			end
		end
		local function v89(p86, p87) -- name: client_item_added
			-- upvalues: (copy) p_u_78, (copy) v_u_85, (copy) v_u_82
			p86.ToggleOffMobileInputButton:Connect(function(p88)
				-- upvalues: (ref) p_u_78
				p_u_78.Buttons[p88]:Button1Up()
			end)
			p86.InterfaceAdded:Connect(v_u_85)
			if p86.ItemInterface then
				p86.ItemInterface.Mouse.Scope.ActiveChanged:Connect(v_u_82)
				if not p87 then
					v_u_82()
				end
			end
		end
		p_u_78._local_fighter.ItemAdded:Connect(v89)
		for _, v90 in pairs(p_u_78._local_fighter.Items) do
			task.spawn(v89, v90, true)
		end
		task.defer(v_u_82)
		p_u_78._local_fighter.EquippedItemChanged:Connect(function()
			-- upvalues: (copy) p_u_78
			p_u_78:_UpdateMobileInputSettings()
		end)
		p_u_78._local_fighter.HealthChanged:Connect(function()
			-- upvalues: (copy) p_u_78
			p_u_78:_UpdateVisibilities()
		end)
		p_u_78._local_fighter.EntityAdded:Connect(function()
			-- upvalues: (copy) p_u_78
			p_u_78:_UpdateVisibilities()
		end)
		p_u_78._local_fighter.Died:Connect(function()
			-- upvalues: (copy) p_u_78
			p_u_78:_UpdateVisibilities()
		end)
		p_u_78._local_fighter:GetDataChangedSignal("IsInDuel"):Connect(function()
			-- upvalues: (copy) p_u_78
			p_u_78:_UpdateVisibilities()
		end)
		p_u_78._local_fighter:GetDataChangedSignal("QuickAttackOverrides"):Connect(function()
			-- upvalues: (copy) p_u_78
			p_u_78:_UpdateVisibilities()
		end)
		p_u_78._local_fighter.ItemAdded:Connect(function()
			-- upvalues: (copy) p_u_78
			p_u_78:_UpdateWeaponIcons()
		end)
		p_u_78._local_fighter.ItemRemoved:Connect(function()
			-- upvalues: (copy) p_u_78
			p_u_78:_UpdateWeaponIcons()
		end)
		p_u_78:_UpdateWeaponIcons()
	end
end
function v_u_14._HookTouchGui(_) -- name: _HookTouchGui
	-- upvalues: (copy) v_u_7, (copy) v_u_4
	local v91 = v_u_7:SilentWaitForChild(v_u_4.LocalPlayer:WaitForChild("PlayerGui"), "TouchGui"):WaitForChild("TouchControlFrame"):WaitForChild("JumpButton")
	task.defer(v91.Destroy, v91)
end
function v_u_14._Init(p_u_92) -- name: _Init
	p_u_92.MobileInputs.EditorEnabledChanged:Connect(function()
		-- upvalues: (copy) p_u_92
		p_u_92:_UpdateVisibilities()
		p_u_92:_UpdateWeaponIcons()
	end)
	task.defer(p_u_92._HookTouchGui, p_u_92)
end
return v_u_14