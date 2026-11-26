local v_u_1 = game:GetService("ReplicatedStorage")
local v2 = game:GetService("Players")
local v_u_3 = require(v2.LocalPlayer.PlayerScripts.Modules:WaitForChild("ButtonEffect"))
local v_u_4 = require(v2.LocalPlayer.PlayerScripts.Modules:WaitForChild("Page"))
local v_u_5 = setmetatable({}, v_u_4)
v_u_5.__index = v_u_5
function v_u_5._new() -- name: _new
	-- upvalues: (copy) v_u_4, (copy) v_u_5
	local v6 = v_u_4.new(script.Name)
	local v7 = v_u_5
	local v8 = setmetatable(v6, v7)
	v8.ButtonsFrame = v8.PageFrame:WaitForChild("Buttons")
	v8.CloseButton = v8.ButtonsFrame:WaitForChild("Close")
	v8.TeleportButton = v8.ButtonsFrame:WaitForChild("Teleport")
	v8:_Init()
	return v8
end
function v_u_5._Init(p_u_9) -- name: _Init
	-- upvalues: (copy) v_u_1, (copy) v_u_3
	p_u_9.CloseButton.MouseButton1Click:Connect(function()
		-- upvalues: (copy) p_u_9
		p_u_9:CloseRequest()
	end)
	p_u_9.TeleportButton.MouseButton1Click:Connect(function()
		-- upvalues: (ref) v_u_1, (copy) p_u_9
		v_u_1.Remotes.Misc.MobileDuelsTeleport:FireServer()
		p_u_9:CloseRequest()
	end)
	v_u_3:Add(p_u_9.CloseButton)
	v_u_3:Add(p_u_9.TeleportButton)
end
return v_u_5._new()