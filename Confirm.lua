local v1 = game:GetService("Players")
local v_u_2 = require(v1.LocalPlayer.PlayerScripts.Modules:WaitForChild("SettingSlot"))
local v_u_3 = setmetatable({}, v_u_2)
v_u_3.__index = v_u_3
function v_u_3.new(...) -- name: new
	-- upvalues: (copy) v_u_2, (copy) v_u_3
	local v4 = v_u_2.new(...)
	local v5 = v_u_3
	local v6 = setmetatable(v4, v5)
	v6.GreenFrame = v6.ControlsConfirmButton:WaitForChild("Green")
	v6.RedFrame = v6.ControlsConfirmButton:WaitForChild("Red")
	v6:_Init()
	return v6
end
function v_u_3.SetConfirmColor(p7, p8) -- name: SetConfirmColor
	p7.GreenFrame.Visible = p8 == "Green"
	p7.RedFrame.Visible = p8 == "Red"
end
function v_u_3._Confirm(p9) -- name: _Confirm
	p9:SetValue(not p9.Value, nil, true)
end
function v_u_3._Setup(p10) -- name: _Setup
	p10.ControlsConfirmButton.Size = UDim2.new(1.538, 0, 0.625, 0)
	p10.ControlsConfirmButton.Position = UDim2.new(-0.03, 0, 0.5, 0)
end
function v_u_3._Init(p11) -- name: _Init
	p11:_Setup()
end
return v_u_3