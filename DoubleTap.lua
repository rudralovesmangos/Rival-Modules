local v_u_1 = game:GetService("UserInputService")
local v2 = game:GetService("Players")
local v_u_3 = require(v2.LocalPlayer.PlayerScripts.Controllers:WaitForChild("PlayerDataController"))
local v_u_4 = require(v2.LocalPlayer.PlayerScripts.Controllers:WaitForChild("FighterController"))
local v_u_5 = {}
v_u_5.__index = v_u_5
function v_u_5.new(p6) -- name: new
	-- upvalues: (copy) v_u_5
	local v7 = v_u_5
	local v8 = setmetatable({}, v7)
	v8.MobileInputs = p6
	v8.Frame = v8.MobileInputs.Frame:WaitForChild("DoubleTapArea")
	v8._connections = {}
	v8._shooting_connection = nil
	v8._last_tap = 0
	v8:_Init()
	return v8
end
function v_u_5.IsWithin(p9, p10) -- name: IsWithin
	-- upvalues: (copy) v_u_3
	local v11 = p10 - p9.MobileInputs.Frame.AbsolutePosition.X
	if v_u_3:GetSetting("Left Handed Touch Controls") then
		return v11 <= p9.MobileInputs.Frame.AbsoluteSize.X / 2
	else
		return p9.MobileInputs.Frame.AbsoluteSize.X / 2 <= v11
	end
end
function v_u_5.ResetTapWindow(p12) -- name: ResetTapWindow
	p12._last_tap = 0
end
function v_u_5.UpdateVisuals(p13) -- name: UpdateVisuals
	-- upvalues: (copy) v_u_3
	local v14 = p13.Frame
	local v15 = p13.MobileInputs.EditorEnabled
	if v15 then
		v15 = v_u_3:GetSetting("Double Tap Shoot")
	end
	v14.Visible = v15
	local v16 = p13.Frame
	local v17
	if v_u_3:GetSetting("Left Handed Touch Controls") then
		v17 = UDim2.new(0.5, 0, 0.5, 0)
	else
		v17 = UDim2.new(1, 0, 0.5, 0)
	end
	v16.Position = v17
end
function v_u_5.VerifyControls(p_u_18, p19) -- name: VerifyControls
	-- upvalues: (copy) v_u_1, (copy) v_u_3, (copy) v_u_4
	for _, v20 in pairs(p_u_18._connections) do
		v20:Disconnect()
	end
	p_u_18._connections = {}
	p_u_18:_CancelShootingConnection()
	p_u_18:ResetTapWindow()
	if p19 then
		local v21 = p_u_18._connections
		local v22 = v_u_1.InputBegan
		local function v25(p_u_23, _)
			-- upvalues: (copy) p_u_18, (ref) v_u_3, (ref) v_u_4
			if p_u_23.UserInputType == Enum.UserInputType.Touch then
				if p_u_18.MobileInputs.EditorEnabled or (not p_u_18:IsWithin(p_u_23.Position.X) or #p_u_18.MobileInputs.Buttons:GetButtonsFromPosition(p_u_23.Position.X, p_u_23.Position.Y) > 0) then
					return
				elseif tick() - p_u_18._last_tap > v_u_3:GetSetting("Double Tap Shoot Window") then
					p_u_18._last_tap = tick()
					return
				else
					local v24 = not v_u_3:GetSetting("Double Tap Shoot") and (v_u_4.LocalFighter and not v_u_4.LocalFighter:Get("IsInDuel"))
					if v24 then
						v24 = not v_u_4.LocalFighter:Get("IsInShootingRange")
					end
					if v24 then
						p_u_18:_CancelShootingConnection()
						p_u_18._shooting_connection = p_u_23:GetPropertyChangedSignal("UserInputState"):Connect(function()
							-- upvalues: (copy) p_u_23, (ref) p_u_18
							if p_u_23.UserInputState == Enum.UserInputState.End then
								p_u_18:_CancelShootingConnection()
								p_u_18.MobileInputs.Buttons.Buttons.mobile_shoot:Button1Up()
							end
						end)
						p_u_18.MobileInputs.Buttons.Buttons.mobile_shoot:Button1Down()
					end
				end
			else
				return
			end
		end
		table.insert(v21, v22:Connect(v25))
	end
end
function v_u_5._CancelShootingConnection(p26) -- name: _CancelShootingConnection
	if p26._shooting_connection then
		p26._shooting_connection:Disconnect()
		p26._shooting_connection = nil
	end
end
function v_u_5._Init(p_u_27) -- name: _Init
	-- upvalues: (copy) v_u_3
	p_u_27.MobileInputs.EditorEnabledChanged:Connect(function()
		-- upvalues: (copy) p_u_27
		p_u_27:UpdateVisuals()
	end)
	v_u_3:GetSettingChangedSignal("Left Handed Touch Controls"):Connect(function()
		-- upvalues: (copy) p_u_27
		p_u_27:UpdateVisuals()
	end)
	v_u_3:GetSettingChangedSignal("Double Tap Shoot"):Connect(function()
		-- upvalues: (copy) p_u_27
		p_u_27:UpdateVisuals()
	end)
	p_u_27:UpdateVisuals()
end
return v_u_5