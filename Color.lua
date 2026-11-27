local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("UserInputService")
local v3 = game:GetService("Players")
local v_u_4 = require(v1.Modules.Utility)
local v_u_5 = require(v1.Modules.Signal)
local v_u_6 = require(v3.LocalPlayer.PlayerScripts.Modules:WaitForChild("ColorPicker"):WaitForChild("ColorWheel"))
local v_u_7 = require(v3.LocalPlayer.PlayerScripts.Modules:WaitForChild("ButtonEffect"))
local v_u_8 = require(v3.LocalPlayer.PlayerScripts.Modules:WaitForChild("UILibrary"))
local v_u_9 = require(v3.LocalPlayer.PlayerScripts.Modules:WaitForChild("SettingSlot"))
local v_u_10 = setmetatable({}, v_u_9)
v_u_10.__index = v_u_10
function v_u_10.new(...) -- name: new
	-- upvalues: (copy) v_u_9, (copy) v_u_10, (copy) v_u_5, (copy) v_u_6
	local v11 = v_u_9.new(...)
	local v12 = v_u_10
	local v13 = setmetatable(v11, v12)
	v13.SliderChanged = v_u_5.new()
	v13.EditButton = v13.ControlsSettingFrame:WaitForChild("Edit")
	v13.EditButtonBackground = v13.EditButton:WaitForChild("Background")
	v13.ColorWheelFrame = v13.ControlsSettingFrame:WaitForChild("ColorWheel")
	v13.ColorWheel = v_u_6.new(v13.ColorWheelFrame)
	v13._close_connection = nil
	v13._open_time = 0
	v13._is_open = false
	v13:_Init()
	return v13
end
function v_u_10.SetOpen(p_u_14, p15) -- name: SetOpen
	-- upvalues: (copy) v_u_2, (copy) v_u_8
	local v16 = typeof(p15) == "boolean"
	assert(v16, "Argument 1 invalid, expected a boolean")
	p_u_14._is_open = p15
	p_u_14.ColorWheelFrame.Visible = p_u_14._is_open
	p_u_14.SettingFrame.ZIndex = p_u_14._is_open and 999 or 1
	p_u_14.EditButton.Interactable = not p_u_14._is_open
	if p_u_14._close_connection then
		p_u_14._close_connection:Disconnect()
		p_u_14._close_connection = nil
	end
	if p_u_14._is_open then
		p_u_14._open_time = tick()
		p_u_14._close_connection = v_u_2.InputEnded:Connect(function(p17, _)
			-- upvalues: (copy) p_u_14, (ref) v_u_8
			if tick() - p_u_14._open_time >= 0.25 and (p17.UserInputType == Enum.UserInputType.MouseButton1 or (p17.UserInputType == Enum.UserInputType.Touch or p17.KeyCode == Enum.KeyCode.ButtonA)) then
				if not v_u_8:IsMouseWithinBounds(p_u_14.ColorWheelFrame.AbsolutePosition, p_u_14.ColorWheelFrame.AbsoluteSize) then
					p_u_14:SetOpen(false)
				end
			end
		end)
	end
end
function v_u_10.SetAlwaysOpen(p18) -- name: SetAlwaysOpen
	p18:SetOpen(true)
	p18.ColorWheelFrame.Position = UDim2.new(0.325, 0, 0, 0)
end
function v_u_10.Destroy(p19) -- name: Destroy
	-- upvalues: (copy) v_u_9
	p19.ColorWheel:Destroy()
	p19.SliderChanged:Destroy()
	v_u_9.Destroy(p19)
end
function v_u_10._Update(p20) -- name: _Update
	-- upvalues: (copy) v_u_4
	p20.ColorWheel:SetStartingColor(p20.Value)
	p20.EditButtonBackground.ImageColor3 = v_u_4:Color3FromHex(p20.Value)
end
function v_u_10._Init(p_u_21) -- name: _Init
	-- upvalues: (copy) v_u_7
	p_u_21.Changed:Connect(function()
		-- upvalues: (copy) p_u_21
		p_u_21:_Update()
	end)
	p_u_21.ColorWheel.Updated:Connect(function(p22, p23)
		-- upvalues: (copy) p_u_21
		if p23 then
			p_u_21:StoreValue(p22)
		else
			p_u_21:SetValue(p22)
		end
		p_u_21.SliderChanged:Fire(p22)
	end)
	p_u_21.EditButton.MouseButton1Click:Connect(function()
		-- upvalues: (copy) p_u_21
		p_u_21:SetOpen(not p_u_21._is_open)
	end)
	p_u_21:_Update()
	v_u_7:Add(p_u_21.EditButton)
end
return v_u_10