local v_u_1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("TeleportService")
local v_u_3 = game:GetService("Lighting")
local v_u_4 = game:GetService("Players")
local v_u_5 = require(v_u_1.Modules.Utility)
local v_u_6 = require(v_u_1.Modules.Signal)
local v_u_7 = require(v_u_4.LocalPlayer.PlayerScripts.Modules:WaitForChild("GlowyBackground"))
local v_u_8 = require(v_u_4.LocalPlayer.PlayerScripts.Modules:WaitForChild("ChickenFooter"))
require(v_u_4.LocalPlayer.PlayerScripts.Modules:WaitForChild("UILibrary"))
local v_u_9 = v_u_4.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("TeleportingGui")
local v_u_10 = {}
v_u_10.__index = v_u_10
function v_u_10._new() -- name: _new
	-- upvalues: (copy) v_u_10, (copy) v_u_6, (copy) v_u_9, (copy) v_u_8, (copy) v_u_7
	local v11 = v_u_10
	local v12 = setmetatable({}, v11)
	v12.EnabledChanged = v_u_6.new()
	v12.Enabled = nil
	v12.GUI = v_u_9:Clone()
	v12.Frame = v12.GUI:WaitForChild("Teleporting")
	v12.Container = v12.Frame:WaitForChild("Container")
	v12.Dots = v12.Container:WaitForChild("Waiting"):WaitForChild("Dots")
	v12._enabled_hash = 0
	v12._blur = Instance.new("BlurEffect")
	v12._chicken_footer = v_u_8.new()
	v12._glowy_background = v_u_7.new("Teleporting")
	v12:_Init()
	return v12
end
function v_u_10.Enable(p13, p14) -- name: Enable
	if p14 ~= p13.Enabled then
		p13.Enabled = p14
		p13.EnabledChanged:Fire()
		p13._enabled_hash = p13._enabled_hash + 1
		task.spawn(p13._Update, p13)
	end
end
function v_u_10._Update(p_u_15) -- name: _Update
	-- upvalues: (copy) v_u_5
	local v_u_16 = p_u_15._enabled_hash
	p_u_15.Container.Visible = p_u_15.Enabled
	p_u_15._glowy_background:SetEnabled(p_u_15.Enabled)
	if p_u_15.Enabled then
		p_u_15.Dots:AddTag("UILoadingDots")
		p_u_15._chicken_footer:Show()
		p_u_15._chicken_footer:EnableTimer()
		p_u_15._chicken_footer:EnableFunFacts()
		p_u_15._chicken_footer:SetStatus("Teleporting")
	else
		p_u_15.Dots:RemoveTag("UILoadingDots")
		p_u_15._chicken_footer:Hide()
	end
	local _ = p_u_15.Enabled
	local _ = p_u_15.Enabled
	local v_u_17 = p_u_15.Enabled and 0 or 56
	local v_u_18 = p_u_15.Enabled and 56 or 0
	v_u_5:RenderstepForLoop(0, 100, 4, function(p19)
		-- upvalues: (copy) v_u_16, (copy) p_u_15, (copy) v_u_17, (copy) v_u_18
		if v_u_16 ~= p_u_15._enabled_hash then
			return true
		end
		local v20 = 1 - (1 - p19 / 100) ^ 3
		p_u_15._blur.Size = v_u_17 + (v_u_18 - v_u_17) * v20
	end)
end
function v_u_10._Setup(p21) -- name: _Setup
	-- upvalues: (copy) v_u_3, (copy) v_u_4
	p21._blur.Size = 0
	p21._blur.Name = "Teleporting"
	p21._blur.Parent = v_u_3
	p21._chicken_footer:SetParent(p21.Frame)
	p21._glowy_background:SetParent(p21.Frame)
	p21.GUI.Parent = v_u_4.LocalPlayer.PlayerGui
end
function v_u_10._Init(p_u_22) -- name: _Init
	-- upvalues: (copy) v_u_2, (copy) v_u_1
	p_u_22.EnabledChanged:Connect(function()
		-- upvalues: (copy) p_u_22, (ref) v_u_2
		if p_u_22.Enabled then
			v_u_2:SetTeleportGui(p_u_22.GUI)
		end
	end)
	v_u_1.Remotes.Misc.Teleporting.OnClientEvent:Connect(function(p23)
		-- upvalues: (copy) p_u_22
		p_u_22:Enable(p23)
	end)
	p_u_22:_Setup()
	p_u_22:Enable(false)
end
return v_u_10._new()