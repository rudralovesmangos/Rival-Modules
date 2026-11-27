local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("Players")
local v_u_3 = require(v1.Modules.Utility)
local v_u_4 = require(v_u_2.LocalPlayer.PlayerScripts.Controllers:WaitForChild("PlayerDataController"))
local v_u_5 = require(v_u_2.LocalPlayer.PlayerScripts.Modules:WaitForChild("UILibrary"))
local v_u_6 = {}
v_u_6.__index = v_u_6
function v_u_6.new(p7) -- name: new
	-- upvalues: (copy) v_u_6
	local v8 = v_u_6
	local v9 = setmetatable({}, v8)
	v9.MobileInputs = p7
	v9.Frame = v9.MobileInputs.Frame:WaitForChild("JoystickArea")
	v9._hooked = false
	v9._touch_gui = nil
	v9._joystick_frame = nil
	v9._joystick_original_position = nil
	v9._joystick_original_anchor_point = nil
	v9._joystick_left_handed_position = nil
	v9._joystick_left_handed_anchor_point = nil
	v9:_Init()
	return v9
end
function v_u_6._Update(p10) -- name: _Update
	-- upvalues: (copy) v_u_4, (copy) v_u_5
	local v11 = p10.Frame
	local v12 = p10._hooked
	if v12 then
		v12 = p10.MobileInputs.EditorEnabled
	end
	v11.Visible = v12
	if p10.Frame.Visible then
		local v13 = v_u_4:GetSetting("Left Handed Touch Controls")
		p10._joystick_frame.Position = v13 and p10._joystick_left_handed_position or p10._joystick_original_position
		p10._joystick_frame.AnchorPoint = v13 and p10._joystick_left_handed_anchor_point or p10._joystick_original_anchor_point
		local v14 = Vector2.new
		local v15 = p10._joystick_frame.AbsolutePosition.X + (p10._touch_gui.AbsolutePosition.X - v_u_5.MainGui.AbsolutePosition.X)
		local v16 = p10.Frame.AbsoluteSize.X
		local v17 = math.clamp(v15, 0, v16)
		local v18 = p10._joystick_frame.AbsolutePosition.Y + (p10._touch_gui.AbsolutePosition.Y - v_u_5.MainGui.AbsolutePosition.Y)
		local v19 = p10.Frame.AbsoluteSize.Y
		local v20 = v14(v17, (math.clamp(v18, 0, v19)))
		local v21 = Vector2.new(p10._joystick_frame.AbsolutePosition.X + p10._joystick_frame.AbsoluteSize.X - v20.X, p10._joystick_frame.AbsolutePosition.Y + p10._joystick_frame.AbsoluteSize.Y - v20.Y)
		p10.Frame.Position = UDim2.new(0, v20.X, 0, v20.Y)
		p10.Frame.Size = UDim2.new(0, v21.X, 0, v21.Y)
	end
end
function v_u_6._HookTouchGui(p_u_22) -- name: _HookTouchGui
	-- upvalues: (copy) v_u_3, (copy) v_u_2
	local v23 = v_u_3:SilentWaitForChild(v_u_2.LocalPlayer:WaitForChild("PlayerGui"), "TouchGui")
	local v_u_24 = v23:WaitForChild("TouchControlFrame"):WaitForChild("DynamicThumbstickFrame")
	p_u_22._hooked = true
	p_u_22._touch_gui = v23
	p_u_22._joystick_frame = v_u_24
	p_u_22._joystick_original_position = p_u_22._joystick_frame.Position
	p_u_22._joystick_original_anchor_point = p_u_22._joystick_frame.AnchorPoint
	p_u_22._joystick_left_handed_position = UDim2.new(1 - p_u_22._joystick_original_position.X.Scale, -p_u_22._joystick_original_position.X.Offset, p_u_22._joystick_original_position.Y.Scale, p_u_22._joystick_original_position.Y.Offset)
	p_u_22._joystick_left_handed_anchor_point = Vector2.new(1 - p_u_22._joystick_original_anchor_point.X, p_u_22._joystick_original_anchor_point.Y)
	p_u_22._touch_gui:GetPropertyChangedSignal("AbsolutePosition"):Connect(function()
		-- upvalues: (copy) p_u_22
		p_u_22:_Update()
	end)
	p_u_22._joystick_frame:GetPropertyChangedSignal("AbsolutePosition"):Connect(function()
		-- upvalues: (copy) p_u_22
		p_u_22:_Update()
	end)
	p_u_22._joystick_frame:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
		-- upvalues: (copy) p_u_22
		p_u_22:_Update()
	end)
	p_u_22:_Update()
	task.spawn(function()
		-- upvalues: (copy) v_u_24
		local v_u_25 = v_u_24:WaitForChild("ThumbstickStart")
		v_u_25:GetPropertyChangedSignal("Visible"):Connect(function() -- name: update
			-- upvalues: (copy) v_u_25
			v_u_25.Visible = false
		end)
		v_u_25.Visible = false
	end)
end
function v_u_6._Setup(p26) -- name: _Setup
	p26.Frame.AnchorPoint = Vector2.zero
end
function v_u_6._Init(p_u_27) -- name: _Init
	-- upvalues: (copy) v_u_5, (copy) v_u_4
	p_u_27.MobileInputs.EditorEnabledChanged:Connect(function()
		-- upvalues: (copy) p_u_27
		p_u_27:_Update()
	end)
	p_u_27.MobileInputs.Frame:GetPropertyChangedSignal("AbsolutePosition"):Connect(function()
		-- upvalues: (copy) p_u_27
		p_u_27:_Update()
	end)
	p_u_27.MobileInputs.Frame:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
		-- upvalues: (copy) p_u_27
		p_u_27:_Update()
	end)
	v_u_5.MainGui:GetPropertyChangedSignal("AbsolutePosition"):Connect(function()
		-- upvalues: (copy) p_u_27
		p_u_27:_Update()
	end)
	v_u_4:GetSettingChangedSignal("Left Handed Touch Controls"):Connect(function()
		-- upvalues: (copy) p_u_27
		p_u_27:_Update()
	end)
	p_u_27:_Setup()
	p_u_27:_Update()
	task.defer(p_u_27._HookTouchGui, p_u_27)
end
return v_u_6