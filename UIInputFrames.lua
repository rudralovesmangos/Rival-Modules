local v_u_1 = game:GetService("CollectionService")
local v2 = game:GetService("Players")
local v_u_3 = require(v2.LocalPlayer.PlayerScripts.Controllers:WaitForChild("ControlsController"))
local v_u_4 = {}
v_u_4.__index = v_u_4
function v_u_4._new() -- name: _new
	-- upvalues: (copy) v_u_4
	local v5 = v_u_4
	local v6 = setmetatable({}, v5)
	v6:_Init()
	return v6
end
function v_u_4._UpdateElement(_, p7) -- name: _UpdateElement
	-- upvalues: (copy) v_u_3
	p7:WaitForChild("MouseKeyboard").Visible = v_u_3.CurrentControls == "MouseKeyboard"
	p7:WaitForChild("Gamepad").Visible = v_u_3.CurrentControls == "Gamepad"
	p7:WaitForChild("Touch").Visible = v_u_3.CurrentControls == "Touch"
end
function v_u_4._UpdateAllElements(p8) -- name: _UpdateAllElements
	-- upvalues: (copy) v_u_1
	for _, v9 in pairs(v_u_1:GetTagged("UIInputFrame")) do
		p8:_UpdateElement(v9)
	end
end
function v_u_4._Init(p_u_10) -- name: _Init
	-- upvalues: (copy) v_u_1, (copy) v_u_3
	v_u_1:GetInstanceAddedSignal("UIInputFrame"):Connect(function(p11)
		-- upvalues: (copy) p_u_10
		p_u_10:_UpdateElement(p11)
	end)
	v_u_3.ControlsChanged:Connect(function()
		-- upvalues: (copy) p_u_10
		p_u_10:_UpdateAllElements()
	end)
	task.spawn(p_u_10._UpdateAllElements, p_u_10)
end
return v_u_4._new()