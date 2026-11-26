local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("UserInputService")
local v_u_3 = game:GetService("GamepadService")
local v_u_4 = game:GetService("RunService")
local v_u_5 = game:GetService("GuiService")
local v_u_6 = game:GetService("Players")
local v_u_7 = require(v1.Modules.PermissionsLibrary)
local v_u_8 = require(v1.Modules.SettingsLibrary)
local v_u_9 = require(v1.Modules.BountyLibrary)
local v_u_10 = require(v1.Modules.InputLibrary)
local v_u_11 = require(v1.Modules.Utility)
local v_u_12 = require(v1.Modules.Signal)
local v_u_13 = require(v_u_6.LocalPlayer.PlayerScripts.Controllers:WaitForChild("PlayerDataController"))
local v_u_14 = require(v_u_6.LocalPlayer.PlayerScripts.Controllers:WaitForChild("SettingsController"))
local v_u_15 = require(v_u_6.LocalPlayer.PlayerScripts.Modules.UserInterface:WaitForChild("Inset"))
local v_u_16 = require(v_u_6.LocalPlayer.PlayerScripts.Modules:WaitForChild("ButtonEffect"))
local v_u_17 = require(v_u_6.LocalPlayer.PlayerScripts.Modules:WaitForChild("UILibrary"))
local v_u_18 = v_u_6.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("SettingInputHotkeysDivider")
local v_u_19 = v_u_6.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("SettingInputHotkeysSlot")
local v_u_20 = v_u_6.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("SettingHotkeySlot")
local v_u_21 = v_u_6.LocalPlayer.PlayerScripts.Modules:WaitForChild("Settings")
local v_u_22 = {}
v_u_22.__index = v_u_22
function v_u_22.new(p23) -- name: new
	-- upvalues: (copy) v_u_22, (copy) v_u_12
	local v24 = v_u_22
	local v25 = setmetatable({}, v24)
	v25.Hovered = v_u_12.new()
	v25.ResetSettings = v_u_12.new()
	v25.Page = p23
	v25.Frame = v25.Page.Container:WaitForChild("Settings")
	v25.WaitingFrame = v25.Frame:WaitForChild("Waiting")
	v25.DotsFrame = v25.WaitingFrame:WaitForChild("Dots")
	v25.Container = v25.Frame:WaitForChild("Container")
	v25.HotkeyHeaderFrame = v25.Container:WaitForChild("HotkeyHeader")
	v25.List = v25.Container:WaitForChild("List")
	v25.Container = v25.List:WaitForChild("Container")
	v25.Layout = v25.Container:WaitForChild("Layout")
	v25.HotkeyTopFrame = v25.Container:WaitForChild("HotkeyTop")
	v25.HotkeyBottomFrame = v25.Container:WaitForChild("HotkeyBottom")
	v25.ResetDefaultFrame = v25.Container:WaitForChild("ResetDefault")
	v25.ResetDefaultContainer = v25.ResetDefaultFrame:WaitForChild("Container")
	v25.ResetDefaultButton = v25.ResetDefaultContainer:WaitForChild("Controls"):WaitForChild("Confirm"):WaitForChild("Button")
	v25.ResetDefaultDescription = v25.ResetDefaultContainer:WaitForChild("Details"):WaitForChild("Display"):WaitForChild("Description")
	v25.MobileEditorFrame = v25.Container:WaitForChild("MobileEditor")
	v25.MobileEditorButton = v25.MobileEditorFrame:WaitForChild("Container"):WaitForChild("Controls"):WaitForChild("Confirm"):WaitForChild("Button")
	v25.SettingObjects = {}
	v25._setting_objects_by_section = {}
	v25._input_hotkeys_slots = {}
	v25._is_listening_for_hotkey = false
	v25._last_reset_click = 0
	v25:_Init()
	return v25
end
function v_u_22.SetPage(p26, p27) -- name: SetPage
	local v28 = p26.Frame
	local v29
	if p27 == "Hotkeys" then
		v29 = UDim2.new(0.85, 0, 0.9, 0)
	else
		v29 = UDim2.new(0.5, 0, 0.9, 0)
	end
	v28.Size = v29
	local v30 = p26.List
	local v31
	if p27 == "Hotkeys" then
		v31 = UDim2.new(0.5, 0, 0.075, 0)
	else
		v31 = UDim2.new(0.5, 0, 0, 0)
	end
	v30.Position = v31
	p26.List.CanvasPosition = Vector2.zero
	local v32 = p26.Layout
	local v33
	if p27 == "Hotkeys" then
		v33 = UDim.new(0, 0)
	else
		v33 = UDim.new(0.01, 0)
	end
	v32.Padding = v33
	p26.HotkeyHeaderFrame.Visible = p27 == "Hotkeys"
	p26.HotkeyTopFrame.Visible = p27 == "Hotkeys"
	p26.HotkeyBottomFrame.Visible = p27 == "Hotkeys"
	local v34 = p26.ResetDefaultFrame
	local v35
	if p27 == "Hotkeys" then
		v35 = UDim2.new(1, 0, 0.11764705882352942, 0)
	else
		v35 = UDim2.new(1, 0, 0.2, 0)
	end
	v34.Size = v35
	local v36 = p26.ResetDefaultContainer
	local v37
	if p27 == "Hotkeys" then
		v37 = UDim2.new(0.5882352941176471, 0, 0.6, 0)
	else
		v37 = UDim2.new(1, 0, 0.6, 0)
	end
	v36.Size = v37
	p26.ResetDefaultDescription.Text = string.format("Double tap to reset your %s settings back to default", p27 or "???")
	p26.MobileEditorFrame.Visible = p27 == "Touch"
	for v38, v39 in pairs(p26._setting_objects_by_section) do
		for _, v40 in pairs(v39) do
			local v41 = v40.SettingFrame
			local v42
			if p27 == v38 then
				v42 = p26.Container
			else
				v42 = nil
			end
			v41.Parent = v42
		end
	end
	for _, v43 in pairs(p26._input_hotkeys_slots) do
		local v44
		if p27 == "Hotkeys" then
			v44 = p26.Container
		else
			v44 = nil
		end
		v43.Parent = v44
	end
end
function v_u_22.Close(p45) -- name: Close
	for _, v46 in pairs(p45.SettingObjects) do
		if v46.SettingsInfo.InputType ~= "Color" then
			continue
		end
		v46:SetOpen(false)
		v46:CancelInputs(false)
	end
end
function v_u_22._UpdateSize(p47) -- name: _UpdateSize
	-- upvalues: (copy) v_u_17
	p47.List.Size = UDim2.new(1, 0, 0, v_u_17.MainGui.AbsolutePosition.Y + v_u_17.MainGui.AbsoluteSize.Y - p47.List.AbsolutePosition.Y)
end
function v_u_22._GenerateHotkeys(p_u_48) -- name: _GenerateHotkeys
	-- upvalues: (copy) v_u_8, (copy) v_u_18, (copy) v_u_10, (copy) v_u_19, (copy) v_u_13, (copy) v_u_14, (copy) v_u_16, (copy) v_u_11, (copy) v_u_2, (copy) v_u_3, (copy) v_u_5, (copy) v_u_20, (copy) v_u_4
	for v49, v50 in pairs(v_u_8.HOTKEYS_GUIDE) do
		local v51 = v49 % 2 == 0
		if v50 == "Divider" then
			local v52 = v_u_18:Clone()
			v52.AlternateBackground.Visible = v51
			v52.LayoutOrder = v49
			v52.Parent = p_u_48.Container
			local v53 = p_u_48._input_hotkeys_slots
			table.insert(v53, v52)
		else
			local v54 = v_u_10.Inputs[v50]
			local v_u_55 = {}
			local v_u_56 = v_u_19:Clone()
			v_u_56.AlternateBackground.Visible = v51
			v_u_56.Title.Text = v54.DisplayName
			v_u_56.Icon.Image = v54.Image
			v_u_56.LayoutOrder = v49
			local v57 = p_u_48._input_hotkeys_slots
			table.insert(v57, v_u_56)
			local function v_u_64() -- name: update_reset_button
				-- upvalues: (copy) v_u_55, (ref) v_u_13, (ref) v_u_8, (copy) v_u_56
				local v58 = false
				for _, v59 in pairs(v_u_55) do
					if v_u_13:GetSetting(v59[2]) == v_u_8.Info[v59[2]].DefaultValue then
						continue
					end
					v58 = true
				end
				v_u_56.Reset.Visible = v58
				local v60 = v_u_56.Icon
				local v61
				if v58 then
					v61 = UDim2.new(0.15, 0, 0.5, 0)
				else
					v61 = UDim2.new(0.1, 0, 0.5, 0)
				end
				v60.Position = v61
				local v62 = v_u_56.Title
				local v63
				if v58 then
					v63 = UDim2.new(0.175, 0, 0.5, 0)
				else
					v63 = UDim2.new(0.125, 0, 0.5, 0)
				end
				v62.Position = v63
			end
			v_u_56.Reset.MouseButton1Click:Connect(function()
				-- upvalues: (copy) v_u_55, (ref) v_u_8, (ref) v_u_14
				local v65 = {}
				for _, v66 in pairs(v_u_55) do
					local v67 = { v66[2], v_u_8.Info[v66[2]].DefaultValue }
					table.insert(v65, v67)
				end
				v_u_14:ChangeSettings(v65)
			end)
			v_u_16:Add(v_u_56.Reset)
			local function v90(p_u_68, p_u_69) -- name: setup
				-- upvalues: (ref) v_u_8, (ref) v_u_11, (ref) v_u_13, (copy) p_u_48, (ref) v_u_14, (ref) v_u_2, (ref) v_u_3, (ref) v_u_5, (copy) v_u_64
				local v_u_70 = v_u_8.Info[p_u_69]
				local v_u_71 = {}
				local v_u_72 = nil
				local function v_u_77(p73) -- name: set_text
					-- upvalues: (ref) v_u_72, (ref) v_u_11, (copy) p_u_68
					if p73 ~= v_u_72 then
						v_u_72 = p73
						local v74
						if p73 then
							v74 = v_u_11:GetInputEnumFromName(p73)
						else
							v74 = p73
						end
						p_u_68.Listening.Visible = false
						p_u_68.Keybind.Visible = true
						p_u_68.Keybind:RemoveTag("UIKeybindContainer")
						if v74 then
							local v75 = p_u_68.Keybind
							local v76 = v74.EnumType
							v75:SetAttribute("EnumType", (tostring(v76)))
							p_u_68.Keybind:SetAttribute("EnumName", p73)
							p_u_68.Keybind:AddTag("UIKeybindContainer")
						end
					end
				end
				local function v_u_80(p78) -- name: set_action_buttons_visible
					-- upvalues: (ref) v_u_13, (copy) p_u_69, (copy) p_u_68
					local v79 = v_u_13:GetSetting(p_u_69) ~= "nil"
					p_u_68.Edit.Size = v79 and UDim2.new(0.5, 0, 1, 0) or UDim2.new(1, 0, 1, 0)
					p_u_68.Edit.BackgroundHalf.Visible = v79
					p_u_68.Edit.BackgroundFull.Visible = not v79
					p_u_68.Edit.Visible = p78
					p_u_68.Unbind.Visible = v79 and p78
				end
				local function v_u_82() -- name: clear_listen_connections
					-- upvalues: (ref) v_u_71, (ref) p_u_48
					for _, v81 in pairs(v_u_71) do
						v81:Disconnect()
					end
					v_u_71 = {}
					p_u_48._is_listening_for_hotkey = false
				end
				p_u_68.Edit.MouseButton1Click:Connect(function()
					-- upvalues: (copy) v_u_80, (copy) v_u_82, (ref) p_u_48, (ref) v_u_72, (ref) v_u_71, (ref) v_u_2, (ref) v_u_3, (ref) v_u_5, (copy) v_u_70, (copy) p_u_68, (copy) v_u_77, (ref) v_u_14, (copy) p_u_69
					v_u_80(false)
					v_u_82()
					p_u_48._is_listening_for_hotkey = true
					v_u_72 = nil
					local v83 = v_u_71
					local v84 = v_u_2.InputBegan
					local function v88(p85)
						-- upvalues: (ref) v_u_3, (ref) v_u_5, (ref) v_u_70, (ref) v_u_82, (ref) p_u_68, (ref) v_u_72, (ref) v_u_77, (ref) v_u_14, (ref) p_u_69
						local v86
						if p85.UserInputType == Enum.UserInputType.MouseButton1 and (v_u_3.GamepadCursorEnabled or v_u_5.SelectedObject) then
							v86 = Enum.KeyCode.ButtonR2.Name
						elseif p85.KeyCode == Enum.KeyCode.Unknown then
							v86 = p85.UserInputType.Name
						else
							v86 = p85.KeyCode.Name
						end
						local v87 = v_u_70.VerifyInput(v86)
						v_u_82()
						p_u_68.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
						v_u_72 = nil
						v_u_77(v87)
						v_u_14:ChangeSetting(p_u_69, v87)
					end
					table.insert(v83, v84:Connect(v88))
					p_u_68.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					p_u_68.Keybind.Visible = false
					p_u_68.Listening.Visible = true
					v_u_5.SelectedObject = nil
				end)
				p_u_68.Unbind.MouseButton1Click:Connect(function()
					-- upvalues: (copy) v_u_80, (ref) v_u_14, (copy) p_u_69
					v_u_80(false)
					v_u_14:ChangeSetting(p_u_69, nil)
				end)
				p_u_68.MouseEnter:Connect(function()
					-- upvalues: (ref) v_u_71, (copy) v_u_80
					if #v_u_71 == 0 then
						v_u_80(true)
					end
				end)
				p_u_68.MouseLeave:Connect(function()
					-- upvalues: (copy) v_u_80
					v_u_80(false)
				end)
				local function v89() -- name: update
					-- upvalues: (copy) v_u_77, (ref) v_u_13, (copy) p_u_69, (ref) v_u_64
					v_u_77(v_u_13:GetSetting(p_u_69))
					v_u_64()
				end
				v_u_13:GetSettingChangedSignal(p_u_69):Connect(v89)
				v_u_77(v_u_13:GetSetting(p_u_69))
				v_u_64()
			end
			for v91, v92 in pairs(v_u_10.HOTKEY_FORMATS) do
				for v93, v94 in pairs(v92) do
					local v95 = v_u_56[v91 .. v93]
					local v96 = string.format(v94, v50)
					local v97 = v_u_20:Clone()
					v97.Listening.Visible = false
					v97.Edit.Visible = false
					v97.Unbind.Visible = false
					v97.Parent = v95
					table.insert(v_u_55, { v95, v96 })
					task.defer(v90, v97, v96)
					if not v54.RestrictedToJustOneInputPerDevice then
						continue
					end
					break
					break
				end
			end
			if v49 % 3 ~= 0 then
				break
			end
			v_u_4.RenderStepped:Wait()
		end
	end
end
function v_u_22._GenerateSettings(p_u_98) -- name: _GenerateSettings
	-- upvalues: (copy) v_u_8, (copy) v_u_9, (copy) v_u_6, (copy) v_u_13, (copy) v_u_7, (copy) v_u_21, (copy) v_u_14, (copy) v_u_4
	local v_u_99 = table.clone(v_u_8.DEPENDENCIES)
	for _, v100 in pairs(v_u_8.OrderBySections) do
		local v101 = false
		for v102, v_u_103 in pairs(v100) do
			if v_u_103.InputType == "Hotkey" then
				continue
			end
			if v_u_103.Name == "Bounty Rewards Disabled" then
				local v104 = v_u_9.Players
				local v105 = v_u_6.LocalPlayer.UserId
				if not v104[tostring(v105)] then
					continue
				end
			end
			if table.find(v_u_8.STAFF_SETTINGS, v_u_103.Name) and not v_u_13:IsNosniyGamesTeamMember() or v_u_103.Name == "Staff Team Tools Disabled Leads" and v_u_7.USE_GROUP_ROLES_INSTEAD_OF_DATASTORES then
				continue
			end
			local v106 = v_u_99[v_u_103.Name]
			local v_u_107 = require(v_u_21:WaitForChild(v_u_103.InputType)).new(v_u_103)
			v_u_107:OverrideDescription("")
			v_u_107.SettingFrame.LayoutOrder = v102
			p_u_98._setting_objects_by_section[v_u_103.Section] = p_u_98._setting_objects_by_section[v_u_103.Section] or {}
			p_u_98._setting_objects_by_section[v_u_103.Section][v_u_103.Name] = v_u_107
			p_u_98.SettingObjects[v_u_103.Name] = v_u_107
			v_u_107.Hovered:Connect(function()
				-- upvalues: (copy) p_u_98, (copy) v_u_107
				p_u_98.Hovered:Fire(v_u_107)
			end)
			if v_u_107.SettingsInfo.InputType == "Divider" then
				v101 = true
				if v102 > 1 then
					v_u_107:SetDividerSpacing(1.5)
				end
			elseif v101 then
				v_u_107:Scale(0.95)
			end
			if v106 then
				if not v106[3] then
					local v108 = v_u_103.Name
					local v109 = v101 and 1 or 0
					while v_u_99[v108] do
						v108 = v_u_99[v108][1]
						v109 = v109 + 1
					end
					v_u_107:Scale(1 - v109 * 0.05)
				end
				local function v_u_113(p110) -- name: is_visible
					-- upvalues: (ref) v_u_13, (copy) v_u_99, (copy) v_u_113
					local v111 = v_u_13:GetSetting(v_u_99[p110][1]) == v_u_99[p110][2]
					if v_u_99[p110][4] then
						v111 = not v111
					end
					local v112
					if v111 or v_u_99[p110][2] == "any" then
						v112 = not v_u_99[v_u_99[p110][1]] or v_u_113(v_u_99[p110][1])
					else
						v112 = false
					end
					return v112
				end
				local function v_u_114() -- name: update_visibility
					-- upvalues: (copy) v_u_107, (copy) v_u_113, (copy) v_u_103
					v_u_107.SettingFrame.Visible = v_u_113(v_u_103.Name)
				end
				v_u_13:GetDataChangedSignal("SettingsProfile"):Connect(v_u_114)
				local function v_u_116(p115) -- name: hook
					-- upvalues: (ref) v_u_13, (copy) v_u_114, (copy) v_u_99, (copy) v_u_116
					v_u_13:GetSettingChangedSignal(p115):Connect(v_u_114)
					if v_u_99[p115] then
						v_u_116(v_u_99[p115][1])
					end
				end
				local v117 = v106[1]
				v_u_13:GetSettingChangedSignal(v117):Connect(v_u_114)
				if v_u_99[v117] then
					v_u_116(v_u_99[v117][1])
				end
				v_u_107.SettingFrame.Visible = v_u_113(v_u_103.Name)
			end
			local function v118() -- name: update
				-- upvalues: (copy) v_u_107, (ref) v_u_13, (copy) v_u_103
				v_u_107:SetValue(v_u_13:GetSetting(v_u_103.Name), true, true)
			end
			v_u_13:GetSettingChangedSignal(v_u_103.Name):Connect(v118)
			v_u_13:GetDataChangedSignal("SettingsProfile"):Connect(v118)
			v_u_107:SetValue(v_u_13:GetSetting(v_u_103.Name), true, true)
			v_u_107.Replicate:Connect(function()
				-- upvalues: (ref) v_u_14, (copy) v_u_103, (copy) v_u_107
				v_u_14:ChangeSetting(v_u_103.Name, v_u_107.Value)
			end)
			if v_u_107.SettingsInfo.InputType == "Slider" or v_u_107.SettingsInfo.InputType == "Color" then
				v_u_107.SliderChanged:Connect(function(p119)
					-- upvalues: (ref) v_u_13, (copy) v_u_103
					v_u_13.SettingsSliderChanged:Fire(v_u_103.Name, p119)
				end)
			end
			if v102 % 3 ~= 0 then
				continue
			end
			v_u_4.RenderStepped:Wait()
		end
	end
end
function v_u_22._Generate(p120) -- name: _Generate
	p120.DotsFrame:AddTag("UILoadingDots")
	p120.WaitingFrame.Visible = true
	p120.Container.Visible = false
	p120:_GenerateSettings()
	p120:_GenerateHotkeys()
	p120:SetPage(p120.Page.CurrentPage)
	p120.DotsFrame:RemoveTag("UILoadingDots")
	p120.WaitingFrame.Visible = false
	p120.Container.Visible = true
end
function v_u_22._Init(p_u_121) -- name: _Init
	-- upvalues: (copy) v_u_15, (copy) v_u_17, (copy) v_u_5, (copy) v_u_16
	p_u_121.Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		-- upvalues: (copy) p_u_121
		p_u_121.List.CanvasSize = UDim2.new(0, 0, 0, p_u_121.Layout.AbsoluteContentSize.Y)
	end)
	p_u_121.List:GetPropertyChangedSignal("AbsolutePosition"):Connect(function()
		-- upvalues: (copy) p_u_121
		p_u_121:_UpdateSize()
	end)
	p_u_121.ResetDefaultButton.MouseButton1Click:Connect(function()
		-- upvalues: (copy) p_u_121
		if tick() < p_u_121._last_reset_click + 0.5 then
			p_u_121.ResetSettings:Fire()
		else
			p_u_121._last_reset_click = tick()
		end
	end)
	p_u_121.MobileEditorButton.MouseButton1Click:Connect(function()
		-- upvalues: (copy) p_u_121, (ref) v_u_15
		p_u_121.Page.Closed:Fire()
		task.defer(v_u_15.MobileEditorBar.SetVisible, v_u_15.MobileEditorBar, true, nil, true)
	end)
	v_u_17.MainGui:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
		-- upvalues: (copy) p_u_121
		p_u_121:_UpdateSize()
	end)
	v_u_17.MainGui:GetPropertyChangedSignal("AbsolutePosition"):Connect(function()
		-- upvalues: (copy) p_u_121
		p_u_121:_UpdateSize()
	end)
	v_u_5:GetPropertyChangedSignal("SelectedObject"):Connect(function()
		-- upvalues: (copy) p_u_121, (ref) v_u_5
		if p_u_121.Page:IsOpen() and p_u_121._is_listening_for_hotkey then
			task.defer(function()
				-- upvalues: (ref) v_u_5
				v_u_5.SelectedObject = nil
			end)
		end
	end)
	task.spawn(p_u_121._Generate, p_u_121)
	p_u_121:_UpdateSize()
	v_u_16:Add(p_u_121.ResetDefaultButton)
	v_u_16:Add(p_u_121.MobileEditorButton)
end
return v_u_22