local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("UserInputService")
game:GetService("GuiService")
local v_u_3 = game:GetService("RunService")
local v4 = game:GetService("Players")
require(v1.Modules.CONSTANTS)
local v_u_5 = require(v1.Modules.Signal)
local v_u_6 = require(v4.LocalPlayer.PlayerScripts.Modules:WaitForChild("ButtonEffect"))
local v_u_7 = require(v4.LocalPlayer.PlayerScripts.Modules:WaitForChild("UILibrary"))
local v_u_8 = require(v4.LocalPlayer.PlayerScripts.Modules:WaitForChild("SettingSlot"))
local v_u_9 = setmetatable({}, v_u_8)
v_u_9.__index = v_u_9
function v_u_9.new(...) -- name: new
	-- upvalues: (copy) v_u_8, (copy) v_u_9, (copy) v_u_5
	local v10 = v_u_8.new(...)
	local v11 = v_u_9
	local v12 = setmetatable(v10, v11)
	v12.SliderChanged = v_u_5.new()
	v12.InputBox = v12.ControlsSettingFrame:WaitForChild("SliderInput"):WaitForChild("Box")
	v12.ControlsSettingButtonsFrame = v12.ControlsSettingFrame:WaitForChild("Buttons")
	v12.IncreaseButton = v12.ControlsSettingButtonsFrame:WaitForChild("Increase")
	v12.DecreaseButton = v12.ControlsSettingButtonsFrame:WaitForChild("Decrease")
	v12.SliderContainer = v12.ControlsSettingFrame:WaitForChild("Container")
	v12.Slider = v12.SliderContainer:WaitForChild("Slider")
	v12.Dragger = v12.Slider:WaitForChild("Dragger")
	v12._dragging = false
	v12._dragging_connection = nil
	v12._console_dragging_connection = nil
	v12._console_alpha = nil
	v12._console_drag_velocity = 0
	v12:_Init()
	return v12
end
function v_u_9.IncreaseValue(p13, p14) -- name: IncreaseValue
	local v15 = 1 / p13.SettingsInfo.Increment
	local v16 = (p13.SettingsInfo.Max - p13.SettingsInfo.Min) * 0.1
	local v17 = math.max(v15, v16)
	p13:InputValue((p13.SettingsInfo.VerifyInput(p13.Value + v17 * p14)))
end
function v_u_9.CancelInputs(p18) -- name: CancelInputs
	if p18._console_dragging_connection then
		p18:_StopDraggingConsole()
	else
		p18:_StopDragging()
	end
end
function v_u_9.Destroy(p19) -- name: Destroy
	-- upvalues: (copy) v_u_8
	if p19._dragging_connection then
		p19._dragging_connection:Disconnect()
		p19._dragging_connection = nil
	end
	if p19._console_dragging_connection then
		p19._console_dragging_connection:Disconnect()
		p19._console_dragging_connection = nil
	end
	p19.SliderChanged:Destroy()
	v_u_8.Destroy(p19)
end
function v_u_9._GetDisplayValue(p20, p21) -- name: _GetDisplayValue
	if not p20.SettingsInfo.IsPercent then
		return p21
	end
	local v22 = p21 * 100 + 0.5
	return math.floor(v22) .. "%"
end
function v_u_9._UpdateSliderPosition(p23) -- name: _UpdateSliderPosition
	local v24 = p23.ControlsSettingFrame.AbsolutePosition.X + p23.ControlsSettingFrame.AbsoluteSize.X - p23.SettingFrame.AbsolutePosition.X
	p23.SliderContainer.Size = UDim2.new(0, v24 / p23.UIScale.Scale, 0.42, 0)
end
function v_u_9._Update(p25) -- name: _Update
	local v26 = UDim2.new(p25:_GetAlphaFromValue(p25.Value), 0, 0.5, 0)
	p25.InputBox.Text = p25:_GetDisplayValue(p25.Value)
	if p25.Dragger:IsDescendantOf(game) then
		p25.Dragger:TweenPosition(v26, "Out", "Quint", 0.25, true)
	else
		p25.Dragger.Position = v26
	end
end
function v_u_9._VerifyInputBox(p27) -- name: _VerifyInputBox
	local v28 = p27.InputBox.Text
	local v29 = tonumber(v28)
	local v30 = p27.SettingsInfo.IsPercent and (v29 and v29 / 100) or p27.InputBox.Text
	local v31 = p27.SettingsInfo.VerifyInput(v30) or p27.Value
	p27.InputBox.Text = p27:_GetDisplayValue(v31)
	p27:InputValue(v31)
end
function v_u_9._GetAlphaFromValue(p32, p33) -- name: _GetAlphaFromValue
	return (p33 - p32.SettingsInfo.Min) / (p32.SettingsInfo.Max - p32.SettingsInfo.Min)
end
function v_u_9._GetAlphaFromMouse(p34) -- name: _GetAlphaFromMouse
	-- upvalues: (copy) v_u_7
	local v35 = v_u_7:GetMouseLocation()
	local v36 = p34.Slider.AbsolutePosition.X
	local v37 = p34.Slider.AbsoluteSize.X
	local v38 = (v35.X - v36) / v37
	return math.clamp(v38, 0, 1)
end
function v_u_9._GetValueFromAlpha(p39, p40) -- name: _GetValueFromAlpha
	local v41 = p39.SettingsInfo.Min + p40 * (p39.SettingsInfo.Max - p39.SettingsInfo.Min)
	return p39.SettingsInfo.VerifyInput(v41)
end
function v_u_9._GetValueFromMouse(p42) -- name: _GetValueFromMouse
	return p42:_GetValueFromAlpha(p42:_GetAlphaFromMouse())
end
function v_u_9._UpdateDrag(p43) -- name: _UpdateDrag
	local v44 = p43:_GetValueFromMouse()
	local v45 = p43:_GetAlphaFromMouse()
	local v46 = (v44 - p43.SettingsInfo.Min) / (p43.SettingsInfo.Max - p43.SettingsInfo.Min)
	local v47 = UDim2.new(v46 + (v45 - v46) * 0.5, 0, 0.5, 0)
	p43.Dragger:TweenPosition(v47, "Out", "Quint", 0.25, true)
	p43.InputBox.Text = p43:_GetDisplayValue(v44)
	p43.SliderChanged:Fire(v44)
end
function v_u_9._StartDragging(p_u_48) -- name: _StartDragging
	-- upvalues: (copy) v_u_2
	if not p_u_48._dragging and tick() >= p_u_48._value_change_cooldown then
		p_u_48._dragging = true
		p_u_48._dragging_connection = v_u_2.InputChanged:Connect(function()
			-- upvalues: (copy) p_u_48
			p_u_48:_UpdateDrag()
		end)
	end
end
function v_u_9._StopDragging(p49) -- name: _StopDragging
	if p49._dragging then
		p49._dragging = false
		if p49._dragging_connection then
			p49._dragging_connection:Disconnect()
		end
		p49:InputValue(p49:_GetValueFromMouse())
	end
end
function v_u_9._StartDraggingConsole(p_u_50) -- name: _StartDraggingConsole
	-- upvalues: (copy) v_u_2, (copy) v_u_3
	if not p_u_50._dragging and tick() >= p_u_50._value_change_cooldown then
		p_u_50._dragging = true
		p_u_50._console_alpha = p_u_50:_GetAlphaFromValue(p_u_50.Value)
		p_u_50._dragging_connection = v_u_2.InputChanged:Connect(function(p51)
			-- upvalues: (copy) p_u_50
			if p51.KeyCode == Enum.KeyCode.Thumbstick1 then
				local v52 = p51.Position.X
				if math.abs(v52) < 0.1 then
					p_u_50._console_drag_velocity = 0
				else
					p_u_50._console_drag_velocity = p51.Position.X * 0.01
				end
			else
				return
			end
		end)
		p_u_50._console_dragging_connection = v_u_3.RenderStepped:Connect(function(p53)
			-- upvalues: (copy) p_u_50
			local v54 = p_u_50
			local v55 = p_u_50._console_alpha + p_u_50._console_drag_velocity * p53 * 60
			v54._console_alpha = math.clamp(v55, 0, 1)
			local v56 = p_u_50:_GetValueFromAlpha(p_u_50._console_alpha)
			p_u_50.Dragger.Position = UDim2.new(p_u_50._console_alpha, 0, 0.5, 0)
			p_u_50.InputBox.Text = p_u_50:_GetDisplayValue(v56)
			p_u_50.SliderChanged:Fire(v56)
		end)
	end
end
function v_u_9._StopDraggingConsole(p57) -- name: _StopDraggingConsole
	if p57._dragging then
		p57._dragging = false
		if p57._dragging_connection then
			p57._dragging_connection:Disconnect()
		end
		if p57._console_dragging_connection then
			p57._console_dragging_connection:Disconnect()
		end
		p57:InputValue(p57:_GetValueFromAlpha(p57._console_alpha))
		p57._console_alpha = nil
	end
end
function v_u_9._Setup(p_u_58) -- name: _Setup
	-- upvalues: (copy) v_u_2
	p_u_58:ResizeYSize(1.5)
	p_u_58.Dragger.MouseButton1Down:Connect(function()
		-- upvalues: (copy) p_u_58
		p_u_58:_StartDragging()
	end)
	local v59 = p_u_58._connections
	local v60 = v_u_2.InputEnded
	table.insert(v59, v60:Connect(function(p61)
		-- upvalues: (copy) p_u_58
		if p61.UserInputType == Enum.UserInputType.MouseButton1 or p61.UserInputType == Enum.UserInputType.Touch then
			p_u_58:_StopDragging()
		end
	end))
end
function v_u_9._Init(p_u_62) -- name: _Init
	-- upvalues: (copy) v_u_6
	p_u_62.Changed:Connect(function()
		-- upvalues: (copy) p_u_62
		p_u_62:_Update()
	end)
	p_u_62.SliderChanged:Connect(function(p63)
		-- upvalues: (copy) p_u_62
		p_u_62:_UpdateDetails(p63)
	end)
	p_u_62.InputBox.FocusLost:Connect(function()
		-- upvalues: (copy) p_u_62
		p_u_62:_VerifyInputBox()
	end)
	p_u_62.IncreaseButton.MouseButton1Click:Connect(function()
		-- upvalues: (copy) p_u_62
		p_u_62:IncreaseValue(1)
	end)
	p_u_62.DecreaseButton.MouseButton1Click:Connect(function()
		-- upvalues: (copy) p_u_62
		p_u_62:IncreaseValue(-1)
	end)
	p_u_62.IncreaseButton.MouseEnter:Connect(function()
		-- upvalues: (copy) p_u_62
		p_u_62.IncreaseButton.ZIndex = 1
		p_u_62.DecreaseButton.ZIndex = 0
	end)
	p_u_62.DecreaseButton.MouseEnter:Connect(function()
		-- upvalues: (copy) p_u_62
		p_u_62.IncreaseButton.ZIndex = 0
		p_u_62.DecreaseButton.ZIndex = 1
	end)
	p_u_62.SettingFrame:GetPropertyChangedSignal("AbsolutePosition"):Connect(function()
		-- upvalues: (copy) p_u_62
		p_u_62:_UpdateSliderPosition()
	end)
	p_u_62.ControlsSettingFrame:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
		-- upvalues: (copy) p_u_62
		p_u_62:_UpdateSliderPosition()
	end)
	p_u_62.ControlsSettingFrame:GetPropertyChangedSignal("AbsolutePosition"):Connect(function()
		-- upvalues: (copy) p_u_62
		p_u_62:_UpdateSliderPosition()
	end)
	p_u_62.UIScale:GetPropertyChangedSignal("Scale"):Connect(function()
		-- upvalues: (copy) p_u_62
		p_u_62:_UpdateSliderPosition()
	end)
	p_u_62:_Setup()
	p_u_62:_Update()
	p_u_62:_UpdateSliderPosition()
	v_u_6:Add(p_u_62.Dragger)
	v_u_6:Add(p_u_62.IncreaseButton)
	v_u_6:Add(p_u_62.DecreaseButton)
end
return v_u_9