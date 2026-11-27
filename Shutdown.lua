local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("RunService")
game:GetService("Lighting")
local v_u_3 = game:GetService("Players")
local v_u_4 = require(v1.Modules.Utility)
local v_u_5 = require(v1.Modules.Signal)
local v_u_6 = require(v_u_3.LocalPlayer.PlayerScripts.Modules.UserInterface:WaitForChild("Teleporting"))
local v_u_7 = require(v_u_3.LocalPlayer.PlayerScripts.Modules:WaitForChild("GlowyBackground"))
local v_u_8 = require(v_u_3.LocalPlayer.PlayerScripts.Modules:WaitForChild("ChickenFooter"))
local v_u_9 = require(v_u_3.LocalPlayer.PlayerScripts.Modules:WaitForChild("UILibrary"))
local v_u_10 = v_u_3.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("Shutdown")
local v_u_11 = {
	[Enum.CloseReason.Unknown] = "Unknown shutdown",
	[Enum.CloseReason.RobloxMaintenance] = "Roblox maintenance",
	[Enum.CloseReason.OutOfMemory] = "The server ran out of memory",
	[Enum.CloseReason.ServerEmpty] = "The server is now empty",
	[Enum.CloseReason.DeveloperUpdate] = "Migrating to new servers",
	[Enum.CloseReason.DeveloperShutdown] = "Shutdown by the developers"
}
local v_u_12 = {}
v_u_12.__index = v_u_12
function v_u_12._new() -- name: _new
	-- upvalues: (copy) v_u_12, (copy) v_u_5
	local v13 = v_u_12
	local v14 = setmetatable({}, v13)
	v14.EnabledChanged = v_u_5.new()
	v14.Enabled = nil
	v14:_Init()
	return v14
end
function v_u_12.Enable(p15, p16) -- name: Enable
	-- upvalues: (copy) v_u_9, (copy) v_u_6, (copy) v_u_10, (copy) v_u_3, (copy) v_u_2, (copy) v_u_11, (copy) v_u_8, (copy) v_u_7, (copy) v_u_4
	p15.Enabled = true
	p15.EnabledChanged:Fire()
	v_u_9.MainGui.Enabled = false
	v_u_6.GUI.Parent = nil
	local v_u_17 = v_u_10:Clone()
	v_u_17.Parent = v_u_3.LocalPlayer.PlayerGui
	local v_u_18 = tick()
	v_u_2.RenderStepped:Connect(function(p19)
		-- upvalues: (copy) v_u_17, (copy) v_u_18
		local v20 = v_u_17.MainFrame.Container.Icon
		local v21 = v20.Rotation
		local v22 = (tick() - v_u_18) * 2 % 6.283185307179586
		v20.Rotation = v21 + (math.sin(v22) + 1) * p19 * 300
	end)
	local v23 = v_u_11[p16] or (p16 and p16.Name or "")
	local v24 = v_u_8.new()
	v24:SetStatus("Server Restart")
	v24:SetMessage((v23 == "" and "" or v23 .. " \226\128\148 ") .. "Hang tight while I find a new server for you!")
	v24:SetPicture("Sensei")
	v24:EnableTimer()
	v24:SetParent(v_u_17.MainFrame)
	local v25 = v_u_7.new("Shutdown")
	v25:SetParent(v_u_17.MainFrame)
	v25:SetEnabled(true)
	v_u_4:RenderstepForLoop(0, 100, 1, function(p26)
		-- upvalues: (copy) v_u_17
		local v27 = (1 - p26 / 100) ^ 5
		v_u_17.MainFrame.Container.Icon.ImageTransparency = v27
	end)
end
function v_u_12._Init(_) -- name: _Init end
return v_u_12._new()