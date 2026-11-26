local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("GuiService")
local v3 = game:GetService("Players")
require(v1.Modules.SettingsInfo)
local v_u_4 = require(v3.LocalPlayer.PlayerScripts.Controllers:WaitForChild("PlayerDataController"))
local v_u_5 = require(v3.LocalPlayer.PlayerScripts.Controllers:WaitForChild("ControlsController"))
local v_u_6 = require(v3.LocalPlayer.PlayerScripts.Controllers:WaitForChild("SettingsController"))
local v_u_7 = require(v3.LocalPlayer.PlayerScripts.Modules:WaitForChild("ButtonEffect"))
local v_u_8 = require(v3.LocalPlayer.PlayerScripts.Modules:WaitForChild("Page"))
local v_u_9 = require(script:WaitForChild("Profiles"))
local v_u_10 = require(script:WaitForChild("Inspect"))
local v_u_11 = require(script:WaitForChild("List"))
local v_u_12 = require(script:WaitForChild("Tabs"))
local v_u_13 = setmetatable({}, v_u_8)
v_u_13.__index = v_u_13
function v_u_13._new() -- name: _new
	-- upvalues: (copy) v_u_8, (copy) v_u_13, (copy) v_u_9, (copy) v_u_10, (copy) v_u_12, (copy) v_u_11
	local v14 = v_u_8.new(script.Name)
	local v15 = v_u_13
	local v16 = setmetatable(v14, v15)
	v16.Container = v16.PageFrame:WaitForChild("Container")
	v16.CloseButton = v16.Container:WaitForChild("Close")
	v16.HidePartyDisplay = true
	v16.CurrentPage = nil
	v16.Profiles = v_u_9.new(v16)
	v16.Inspect = v_u_10.new(v16)
	v16.Tabs = v_u_12.new(v16)
	v16.List = v_u_11.new(v16)
	v16._open_animation_disabled = true
	v16:_Init()
	return v16
end
function v_u_13.SetPage(p17, p18) -- name: SetPage
	p17.CurrentPage = p18
	p17.Tabs:SetPage(p17.CurrentPage)
	p17.List:SetPage(p17.CurrentPage)
	p17.Inspect:SetPage(p17.CurrentPage)
	p17.Profiles:SetPage(p17.CurrentPage)
end
function v_u_13.Open(p19, ...) -- name: Open
	-- upvalues: (copy) v_u_8
	v_u_8.Open(p19, ...)
	p19.Inspect:Open()
	p19.Profiles:Open()
end
function v_u_13.Close(p20, ...) -- name: Close
	-- upvalues: (copy) v_u_8
	p20.List:Close()
	p20.Inspect:Close()
	v_u_8.Close(p20, ...)
end
function v_u_13._VerifyPage(p21) -- name: _VerifyPage
	-- upvalues: (copy) v_u_5
	local v22 = v_u_5.CurrentControls == "Touch"
	if v22 and p21.CurrentPage == "Hotkeys" then
		p21:SetPage("Touch")
	elseif not v22 and p21.CurrentPage == "Touch" then
		p21:SetPage("Hotkeys")
	end
end
function v_u_13._UpdateSize(p23) -- name: _UpdateSize
	-- upvalues: (copy) v_u_2
	p23.Container.Size = UDim2.new(1, 0, 1, -v_u_2.TopbarInset.Height)
end
function v_u_13._Init(p_u_24) -- name: _Init
	-- upvalues: (copy) v_u_6, (copy) v_u_4, (copy) v_u_5, (copy) v_u_2, (copy) v_u_7
	p_u_24.CloseButton.MouseButton1Click:Connect(function()
		-- upvalues: (copy) p_u_24
		p_u_24:CloseRequest()
	end)
	p_u_24.List.ResetSettings:Connect(function()
		-- upvalues: (ref) v_u_6, (copy) p_u_24
		v_u_6:DefaultSettings(p_u_24.CurrentPage)
	end)
	p_u_24.List.Hovered:Connect(function(p25)
		-- upvalues: (copy) p_u_24
		p_u_24.Inspect:Inspect(p25.SettingsInfo)
	end)
	p_u_24.Tabs.Clicked:Connect(function(p26)
		-- upvalues: (copy) p_u_24
		p_u_24:SetPage(p26)
	end)
	p_u_24.Profiles.Clicked:Connect(function(p27)
		-- upvalues: (ref) v_u_4, (copy) p_u_24, (ref) v_u_6
		if p27 ~= v_u_4:Get("SettingsProfile") then
			p_u_24.Inspect:Inspect(nil)
			v_u_6:SwitchSettingsProfile(p27)
		end
	end)
	v_u_5.ControlsChanged:Connect(function()
		-- upvalues: (copy) p_u_24
		p_u_24:_VerifyPage()
	end)
	v_u_2:GetPropertyChangedSignal("TopbarInset"):Connect(function()
		-- upvalues: (copy) p_u_24
		p_u_24:_UpdateSize()
	end)
	p_u_24:_UpdateSize()
	p_u_24:SetPage("Audio")
	v_u_7:Add(p_u_24.CloseButton)
end
return v_u_13._new()