local v1 = game:GetService("ReplicatedStorage")
local v2 = game:GetService("Players")
require(v1.Modules.CONSTANTS)
require(v2.LocalPlayer.PlayerScripts.Controllers:WaitForChild("PlayerDataController"))
local v_u_3 = require(v2.LocalPlayer.PlayerScripts.Controllers:WaitForChild("ControlsController"))
local v_u_4 = require(v2.LocalPlayer.PlayerScripts.Controllers:WaitForChild("CameraController"))
require(v2.LocalPlayer.PlayerScripts.Modules.UserInterface:WaitForChild("Pages"))
local v_u_5 = require(v2.LocalPlayer.PlayerScripts.Modules:WaitForChild("UILibrary"))
local v_u_6 = {}
v_u_6.__index = v_u_6
function v_u_6._new() -- name: _new
	-- upvalues: (copy) v_u_6, (copy) v_u_5
	local v7 = v_u_6
	local v8 = setmetatable({}, v7)
	v8.Frame = v_u_5:GetTo("MainFrame", "BottomStack", "SwitchCameraPOV")
	v8.Container = v8.Frame:WaitForChild("Container")
	v8.Title = v8.Container:WaitForChild("Title")
	v8.KeybindIcon = v8.Container:WaitForChild("Keybind")
	v8._effect_hash = 0
	v8:_Init()
	return v8
end
function v_u_6._SwitchEffect(_) -- name: _SwitchEffect end
function v_u_6._UpdateControls(p9) -- name: _UpdateControls
	-- upvalues: (copy) v_u_3
	p9.KeybindIcon.Visible = v_u_3.CurrentControls ~= "Touch"
end
function v_u_6._Init(p_u_10) -- name: _Init
	-- upvalues: (copy) v_u_4, (copy) v_u_3
	v_u_4.POVStateChanged:Connect(function(_, _, p11)
		-- upvalues: (copy) p_u_10
		if p11 then
			p_u_10:_SwitchEffect()
		end
	end)
	v_u_3.ControlsChanged:Connect(function()
		-- upvalues: (copy) p_u_10
		p_u_10:_UpdateControls()
	end)
	p_u_10:_UpdateControls()
end
return v_u_6._new()