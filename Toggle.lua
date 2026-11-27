local v1 = game:GetService("Players")
local v_u_2 = require(v1.LocalPlayer.PlayerScripts.Modules:WaitForChild("ButtonEffect"))
local v_u_3 = require(v1.LocalPlayer.PlayerScripts.Modules:WaitForChild("SettingSlot"))
local v_u_4 = Color3.fromRGB(0, 0, 0)
local v_u_5 = Color3.fromRGB(255, 255, 255)
local v_u_6 = Color3.fromRGB(100, 255, 50)
local v_u_7 = setmetatable({}, v_u_3)
v_u_7.__index = v_u_7
function v_u_7.new(...) -- name: new
	-- upvalues: (copy) v_u_3, (copy) v_u_7
	local v8 = v_u_3.new(...)
	local v9 = v_u_7
	local v10 = setmetatable(v8, v9)
	v10.ToggleContainer = v10.ControlsSettingFrame:WaitForChild("Container")
	v10.Background = v10.ToggleContainer:WaitForChild("Background")
	v10.Button = v10.ToggleContainer:WaitForChild("Button")
	v10.Slider = v10.Button:WaitForChild("Slider")
	v10._custom_value_set = false
	v10:_Init()
	return v10
end
function v_u_7._Update(p11) -- name: _Update
	local v12 = p11.Value and UDim2.new(0.75, 0, 0.5, 0) or UDim2.new(0.25, 0, 0.5, 0)
	if p11.Slider:IsDescendantOf(game) then
		p11.Slider:TweenPosition(v12, "Out", "Quint", 0.5, true)
	else
		p11.Slider.Position = v12
	end
end
function v_u_7._Toggle(p13) -- name: _Toggle
	p13:InputValue(not p13.Value)
end
function v_u_7._Init(p_u_14) -- name: _Init
	-- upvalues: (copy) v_u_4, (copy) v_u_4, (copy) v_u_5, (copy) v_u_6, (copy) v_u_2
	p_u_14.Changed:Connect(function()
		-- upvalues: (copy) p_u_14
		p_u_14:_Update()
	end)
	p_u_14.Button.MouseButton1Click:Connect(function()
		-- upvalues: (copy) p_u_14
		p_u_14:_Toggle()
	end)
	p_u_14.Slider:GetPropertyChangedSignal("Position"):Connect(function()
		-- upvalues: (copy) p_u_14, (ref) v_u_4, (ref) v_u_4, (ref) v_u_5, (ref) v_u_6
		local v15 = (p_u_14.Slider.Position.X.Scale - 0.25) / 0.5
		p_u_14.Slider.ImageColor3 = v_u_4:Lerp(v_u_4, v15)
		p_u_14.Background.ImageColor3 = v_u_5:Lerp(v_u_6, v15)
	end)
	p_u_14:_Update()
	v_u_2:Add(p_u_14.Button, nil, {
		["ReleaseRatio"] = 0.95,
		["HoverRatio"] = 0.95
	})
end
return v_u_7