local v_u_1 = game:GetService("ProximityPromptService")
local v2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("GuiService")
local v_u_4 = game:GetService("Players")
local v_u_5 = require(v2.Modules.BetterDebris)
local v_u_6 = require(v2.Modules.InputLibrary)
local v_u_7 = require(v2.Modules.ItemLibrary)
local v_u_8 = require(v_u_4.LocalPlayer.PlayerScripts.Controllers:WaitForChild("PlayerDataController"))
local v_u_9 = require(v_u_4.LocalPlayer.PlayerScripts.Controllers:WaitForChild("ControlsController"))
local v_u_10 = require(v_u_4.LocalPlayer.PlayerScripts.Controllers:WaitForChild("SpectateController"))
local v_u_11 = require(v_u_4.LocalPlayer.PlayerScripts.Controllers:WaitForChild("CameraController"))
local v_u_12 = require(v_u_4.LocalPlayer.PlayerScripts.Modules.UserInterface:WaitForChild("MobileInputs"))
local v_u_13 = require(v_u_4.LocalPlayer.PlayerScripts.Modules.UserInterface:WaitForChild("Teleporting"))
local v_u_14 = require(v_u_4.LocalPlayer.PlayerScripts.Modules.UserInterface:WaitForChild("Equipment"))
local v_u_15 = require(v_u_4.LocalPlayer.PlayerScripts.Modules.UserInterface:WaitForChild("Shutdown"))
local v_u_16 = require(v_u_4.LocalPlayer.PlayerScripts.Modules.UserInterface:WaitForChild("Queue"))
local v_u_17 = require(v_u_4.LocalPlayer.PlayerScripts.Modules.UserInterface:WaitForChild("Pages"))
local v_u_18 = require(v_u_4.LocalPlayer.PlayerScripts.Modules:WaitForChild("WeaponStatusHandler"))
local v_u_19 = require(v_u_4.LocalPlayer.PlayerScripts.Modules:WaitForChild("ButtonEffect"))
local v_u_20 = v_u_4.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("ProximityPrompts")
local v_u_21 = {}
v_u_21.__index = v_u_21
function v_u_21._new() -- name: _new
	-- upvalues: (copy) v_u_21
	local v22 = v_u_21
	local v23 = setmetatable({}, v22)
	v23._custom_prompt = nil
	v23._custom_prompt_hash = 0
	v23._custom_prompt_connections = {}
	v23:_Init()
	return v23
end
function v_u_21._Update(p24) -- name: _Update
	-- upvalues: (copy) v_u_1, (copy) v_u_12, (copy) v_u_17, (copy) v_u_13, (copy) v_u_15, (copy) v_u_16, (copy) v_u_3, (copy) v_u_14, (copy) v_u_8, (copy) v_u_9, (copy) v_u_11
	local v25 = v_u_1
	local v26 = not (v_u_12.EditorEnabled or (v_u_17.PageSystem.CurrentPage or v_u_13.Enabled) or (v_u_15.Enabled or v_u_16:IsVisible() or (v_u_3.MenuIsOpen or v_u_14.IsOpen)))
	if v26 then
		v26 = not v_u_8:GetSetting("Hide HUD")
	end
	v25.Enabled = v26
	if p24._custom_prompt then
		p24._custom_prompt.Active = v_u_9.CurrentControls == "Touch" and true or not v_u_11.CameraState:GetPublicState()
	end
end
function v_u_21._Cleanup(p27) -- name: _Cleanup
	-- upvalues: (copy) v_u_5, (copy) v_u_4
	p27._custom_prompt_hash = p27._custom_prompt_hash + 1
	for _, v28 in pairs(p27._custom_prompt_connections) do
		v28:Disconnect()
	end
	p27._custom_prompt_connections = {}
	if p27._custom_prompt then
		v_u_5:AddItem(p27._custom_prompt, 0.15)
		if p27._custom_prompt:FindFirstChild("Button") and p27._custom_prompt:IsDescendantOf(v_u_4) then
			p27._custom_prompt.Button:TweenSize(UDim2.new(0, 0, 0, 0), "Out", "Quint", 0.25, true)
		end
		p27._custom_prompt = nil
	end
end
function v_u_21._Create(p_u_29, p_u_30) -- name: _Create
	-- upvalues: (copy) v_u_4, (copy) v_u_9, (copy) v_u_6, (copy) v_u_20, (copy) v_u_18, (copy) v_u_7, (copy) v_u_19
	p_u_29:_Cleanup()
	if not p_u_30:GetAttribute("OnlyShowToThisUserID") or v_u_4.LocalPlayer.UserId == p_u_30:GetAttribute("OnlyShowToThisUserID") then
		p_u_30:SetAttribute("ClickablePrompt", p_u_30.ClickablePrompt)
		p_u_30.ClickablePrompt = v_u_9.CurrentControls == "Touch" and true or p_u_30:GetAttribute("ClickablePrompt")
		p_u_30.KeyboardKeyCode = v_u_6:FindFirstEnum("Interact", "MouseKeyboard")
		p_u_30.GamepadKeyCode = v_u_6:FindFirstEnum("Interact", "Gamepad")
		p_u_30.Exclusivity = Enum.ProximityPromptExclusivity.OnePerButton
		p_u_29._custom_prompt_hash = p_u_29._custom_prompt_hash + 1
		local v_u_31 = p_u_29._custom_prompt_hash
		local v32 = v_u_20[p_u_30:GetAttribute("Style") or "Default"]
		local v33 = p_u_30:GetAttribute("ProximityUIScale") or 1
		p_u_29._custom_prompt = v32:Clone()
		p_u_29._custom_prompt.Name = "ProximityPrompt - " .. v32.Name
		p_u_29._custom_prompt.Button.Inputs.MouseKeyboard.KeyText.Text = p_u_30.KeyboardKeyCode.Name
		p_u_29._custom_prompt.Button.Inputs.Gamepad.Container:SetAttribute("EnumType", "KeyCode")
		p_u_29._custom_prompt.Button.Inputs.Gamepad.Container:SetAttribute("EnumName", p_u_30.GamepadKeyCode.Name)
		p_u_29._custom_prompt.Button.Inputs.Gamepad.Container:AddTag("UIKeybindContainer")
		p_u_29._custom_prompt.Button.Interactable = p_u_30.ClickablePrompt
		p_u_29._custom_prompt.Adornee = p_u_30.Parent
		p_u_29._custom_prompt.Size = UDim2.new(p_u_29._custom_prompt.Size.X.Scale * v33, p_u_29._custom_prompt.Size.X.Offset * v33, p_u_29._custom_prompt.Size.Y.Scale * v33, p_u_29._custom_prompt.Size.Y.Offset * v33)
		p_u_29._custom_prompt.Parent = v_u_4.LocalPlayer.PlayerGui
		local function v37() -- name: update
			-- upvalues: (copy) p_u_29, (copy) p_u_30, (ref) v_u_18, (ref) v_u_7
			p_u_29._custom_prompt.Button.ObjectText.Text = p_u_30.ObjectText
			p_u_29._custom_prompt.Button.ActionText.Text = p_u_30.ActionText
			v_u_18:ClearStatusElements(p_u_29._custom_prompt.Button.ObjectText)
			if not p_u_30:GetAttribute("IgnoreStatusText") then
				local v34 = v_u_18
				local v35 = p_u_29._custom_prompt.Button.ObjectText
				local v36 = v_u_7.Items[p_u_30.ObjectText]
				if v36 then
					v36 = v_u_7.Items[p_u_30.ObjectText].Status
				end
				v34:ApplyItemStatusToText(v35, v36)
			end
		end
		local v38 = p_u_29._custom_prompt_connections
		local v39 = p_u_30:GetAttributeChangedSignal("IgnoreStatusText")
		table.insert(v38, v39:Connect(v37))
		local v40 = p_u_29._custom_prompt_connections
		local v41 = p_u_30:GetPropertyChangedSignal("ObjectText")
		table.insert(v40, v41:Connect(v37))
		local v42 = p_u_29._custom_prompt_connections
		local v43 = p_u_30:GetPropertyChangedSignal("ActionText")
		table.insert(v42, v43:Connect(v37))
		v37()
		p_u_29._custom_prompt.Button.Size = UDim2.new(p_u_29._custom_prompt.Button.Size.X.Scale * 0.5, p_u_29._custom_prompt.Button.Size.X.Offset * 0.5, p_u_29._custom_prompt.Button.Size.Y.Scale * 0.5, p_u_29._custom_prompt.Button.Size.Y.Offset * 0.5)
		p_u_29._custom_prompt.Button:TweenSize(v32.Button.Size, "Out", "Quint", 0.25, true, function()
			-- upvalues: (copy) p_u_29, (copy) v_u_31, (copy) p_u_30, (ref) v_u_19
			if p_u_29._custom_prompt_hash == v_u_31 and p_u_30.ClickablePrompt then
				p_u_29._custom_prompt.Button.MouseButton1Down:Connect(function()
					-- upvalues: (ref) p_u_30
					p_u_30:InputHoldBegin()
				end)
				p_u_29._custom_prompt.Button.MouseButton1Up:Connect(function()
					-- upvalues: (ref) p_u_30
					p_u_30:InputHoldEnd()
				end)
				p_u_29._custom_prompt.Button.MouseLeave:Connect(function()
					-- upvalues: (ref) p_u_30
					p_u_30:InputHoldEnd()
				end)
				v_u_19:Add(p_u_29._custom_prompt.Button, nil, {
					["DontReposition"] = true
				})
			end
		end)
		p_u_29:_Update()
	end
end
function v_u_21._Init(p_u_44) -- name: _Init
	-- upvalues: (copy) v_u_1, (copy) v_u_17, (copy) v_u_13, (copy) v_u_15, (copy) v_u_16, (copy) v_u_10, (copy) v_u_12, (copy) v_u_9, (copy) v_u_11, (copy) v_u_3, (copy) v_u_14, (copy) v_u_8
	v_u_1.PromptShown:Connect(function(p45)
		-- upvalues: (copy) p_u_44
		if p45.Style == Enum.ProximityPromptStyle.Custom then
			p_u_44:_Create(p45)
		end
	end)
	v_u_1.PromptHidden:Connect(function(p46)
		-- upvalues: (copy) p_u_44
		if p46.Style == Enum.ProximityPromptStyle.Custom then
			p_u_44:_Cleanup()
		end
	end)
	v_u_17.PageSystem.PageOpened:Connect(function()
		-- upvalues: (copy) p_u_44
		p_u_44:_Update()
	end)
	v_u_17.PageSystem.PageClosed:Connect(function()
		-- upvalues: (copy) p_u_44
		p_u_44:_Update()
	end)
	v_u_13.EnabledChanged:Connect(function()
		-- upvalues: (copy) p_u_44
		p_u_44:_Update()
	end)
	v_u_15.EnabledChanged:Connect(function()
		-- upvalues: (copy) p_u_44
		p_u_44:_Update()
	end)
	v_u_16.VisibilityChanged:Connect(function()
		-- upvalues: (copy) p_u_44
		p_u_44:_Update()
	end)
	v_u_10.DuelSubjectChanged:Connect(function()
		-- upvalues: (copy) p_u_44
		p_u_44:_Update()
	end)
	v_u_12.EditorEnabledChanged:Connect(function()
		-- upvalues: (copy) p_u_44
		p_u_44:_Update()
	end)
	v_u_9.ControlsChanged:Connect(function()
		-- upvalues: (copy) p_u_44
		p_u_44:_Update()
	end)
	v_u_11.StateChanged:Connect(function()
		-- upvalues: (copy) p_u_44
		p_u_44:_Update()
	end)
	v_u_3:GetPropertyChangedSignal("MenuIsOpen"):Connect(function()
		-- upvalues: (copy) p_u_44
		p_u_44:_Update()
	end)
	v_u_14.Opened:Connect(function()
		-- upvalues: (copy) p_u_44
		p_u_44:_Update()
	end)
	v_u_8:GetSettingChangedSignal("Hide HUD"):Connect(function()
		-- upvalues: (copy) p_u_44
		p_u_44:_Update()
	end)
	p_u_44:_Update()
end
return v_u_21._new()