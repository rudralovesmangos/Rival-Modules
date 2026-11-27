local v_u_1 = game:GetService("UserInputService")
local v_u_2 = game:GetService("RunService")
local v3 = game:GetService("Players")
local v_u_4 = require(v3.LocalPlayer.PlayerScripts.Controllers:WaitForChild("ControlsController"))
local v_u_5 = require(v3.LocalPlayer.PlayerScripts.Modules:WaitForChild("ButtonEffect"))
local v_u_6 = require(v3.LocalPlayer.PlayerScripts.Modules:WaitForChild("SettingSlot"))
local v_u_7 = setmetatable({}, v_u_6)
v_u_7.__index = v_u_7
function v_u_7.new(...) -- name: new
	-- upvalues: (copy) v_u_6, (copy) v_u_7
	local v8 = v_u_6.new(...)
	local v9 = v_u_7
	local v10 = setmetatable(v8, v9)
	v10.HotkeyContainer = v10.ControlsSettingFrame:WaitForChild("Container")
	v10.HotkeyBackground = v10.HotkeyContainer:WaitForChild("Background")
	v10.HotkeyButton = v10.HotkeyContainer:WaitForChild("Button")
	v10.HotkeyValueText = v10.HotkeyContainer:WaitForChild("Value")
	v10._destroyed = false
	v10._listening = false
	v10._listen_connections = {}
	v10:_Init()
	return v10
end
function v_u_7.GetSelection(p11) -- name: GetSelection
	return p11.HotkeyButton
end
function v_u_7.Destroy(p12) -- name: Destroy
	-- upvalues: (copy) v_u_6
	p12._destroyed = true
	for _, v13 in pairs(p12._listen_connections) do
		v13:Disconnect()
	end
	v_u_6.Destroy(p12)
end
function v_u_7._Update(p14) -- name: _Update
	p14:_StopListening()
	local v15 = p14.HotkeyValueText
	local v16 = p14.Value
	v15.Text = typeof(v16) == "EnumItem" and p14.Value.Name or (p14.Value or "")
end
function v_u_7._Input(p17, p18) -- name: _Input
	p17:_StopListening()
	p17:SetValue(p17.SettingsInfo.VerifyInput(p18))
end
function v_u_7._StartListening(p_u_19) -- name: _StartListening
	-- upvalues: (copy) v_u_1
	if not (p_u_19._listening or p_u_19._destroyed) then
		p_u_19._listening = true
		local v20 = p_u_19._listen_connections
		local v21 = v_u_1.InputBegan
		table.insert(v20, v21:Connect(function(p22)
			-- upvalues: (copy) p_u_19
			local v23 = p_u_19
			local v24
			if p22.KeyCode == Enum.KeyCode.Unknown then
				v24 = p22.UserInputType.Name
			else
				v24 = p22.KeyCode.Name
			end
			v23:_Input(v24)
		end))
		local v25 = p_u_19._listen_connections
		local v26 = v_u_1.InputChanged
		table.insert(v25, v26:Connect(function(_) end))
		p_u_19.HotkeyBackground.ImageColor3 = Color3.fromRGB(127, 127, 127)
		p_u_19.HotkeyValueText.TextStrokeColor3 = Color3.fromRGB(64, 64, 64)
		p_u_19.HotkeyValueText.Text = "\226\128\162 \226\128\162 \226\128\162"
	end
end
function v_u_7._StopListening(p27) -- name: _StopListening
	if p27._listening then
		p27._listening = false
		for _, v28 in pairs(p27._listen_connections) do
			v28:Disconnect()
		end
		p27.HotkeyBackground.ImageColor3 = Color3.fromRGB(0, 150, 255)
		p27.HotkeyValueText.TextStrokeColor3 = Color3.fromRGB(0, 75, 127)
	end
end
function v_u_7._Setup(p29) -- name: _Setup
	p29.HotkeyButton.NextSelectionRight = p29.HotkeyButton
	p29.HotkeyButton.NextSelectionLeft = p29.HotkeyButton
end
function v_u_7._Init(p_u_30) -- name: _Init
	-- upvalues: (copy) v_u_2, (copy) v_u_4, (copy) v_u_5
	p_u_30.Changed:Connect(function()
		-- upvalues: (copy) p_u_30
		p_u_30:_Update()
	end)
	p_u_30.HotkeyButton.MouseButton1Click:Connect(function()
		-- upvalues: (ref) v_u_2, (ref) v_u_4, (copy) p_u_30
		v_u_2.Heartbeat:Wait()
		if v_u_4.CurrentControls ~= "Touch" then
			p_u_30:_StartListening()
		end
	end)
	p_u_30:_Setup()
	p_u_30:_Update()
	v_u_5:Add(p_u_30.HotkeyButton, true)
end
return v_u_7