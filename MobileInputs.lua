local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("Players")
local v_u_3 = require(v1.Modules.Signal)
local v_u_4 = require(v_u_2.LocalPlayer.PlayerScripts.Controllers:WaitForChild("ControlsController"))
local v_u_5 = require(v_u_2.LocalPlayer.PlayerScripts.Controllers:WaitForChild("SettingsController"))
local v_u_6 = require(v_u_2.LocalPlayer.PlayerScripts.Modules:WaitForChild("UILibrary"))
local v_u_7 = require(script:WaitForChild("EditorLogic"))
local v_u_8 = require(script:WaitForChild("DoubleTap"))
local v_u_9 = require(script:WaitForChild("Joystick"))
local v_u_10 = require(script:WaitForChild("Buttons"))
v_u_2.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("MobileButton")
local v_u_11 = {}
v_u_11.__index = v_u_11
function v_u_11._new() -- name: _new
	-- upvalues: (copy) v_u_11, (copy) v_u_3, (copy) v_u_6, (copy) v_u_8, (copy) v_u_9, (copy) v_u_10, (copy) v_u_7
	local v12 = v_u_11
	local v13 = setmetatable({}, v12)
	v13.EditorEnabledChanged = v_u_3.new()
	v13.Frame = v_u_6:GetTo("MobileInputs")
	v13.EditorEnabled = false
	v13.DoubleTap = v_u_8.new(v13)
	v13.Joystick = v_u_9.new(v13)
	v13.Buttons = v_u_10.new(v13)
	v13.EditorLogic = v_u_7.new(v13)
	v13:_Init()
	return v13
end
function v_u_11.SwitchProfile(p14, p15) -- name: SwitchProfile
	-- upvalues: (copy) v_u_5
	local v16 = typeof(p15) == "number"
	assert(v16)
	p14.EditorLogic:ApplyEdits()
	v_u_5:SwitchSettingsProfile(p15)
end
function v_u_11._IsEnabled(_) -- name: _IsEnabled
	-- upvalues: (copy) v_u_4
	return v_u_4.CurrentControls == "Touch"
end
function v_u_11._VerifyControls(p17) -- name: _VerifyControls
	local v18 = p17:_IsEnabled()
	p17.EditorLogic:SetEnabled(false)
	p17.DoubleTap:VerifyControls(v18)
	p17.Buttons:VerifyControls(v18)
end
function v_u_11._SetupVisibility(p_u_19) -- name: _SetupVisibility
	-- upvalues: (copy) v_u_2, (copy) v_u_4
	local v_u_20 = require(v_u_2.LocalPlayer.PlayerScripts.Modules:WaitForChild("UserInterface"):WaitForChild("EliminatedEffect"))
	local v_u_21 = require(v_u_2.LocalPlayer.PlayerScripts.Modules:WaitForChild("UserInterface"):WaitForChild("Equipment"))
	local v_u_22 = require(v_u_2.LocalPlayer.PlayerScripts.Modules:WaitForChild("UserInterface"):WaitForChild("Pages"))
	local function v25() -- name: update
		-- upvalues: (copy) p_u_19, (copy) v_u_20, (copy) v_u_21, (copy) v_u_22
		local v23 = p_u_19.Frame
		local v24 = p_u_19:_IsEnabled() and not (v_u_20:IsVisible() or v_u_21.IsOpen)
		if v24 then
			v24 = not v_u_22.PageSystem.CurrentPage
		end
		v23.Visible = v24
	end
	v_u_4.ControlsChanged:Connect(v25)
	v_u_20.VisibilityChanged:Connect(v25)
	v_u_22.PageSystem.PagesActivity:Connect(v25)
	v_u_21.Opened:Connect(v25)
	local v26 = p_u_19.Frame
	local v27 = p_u_19:_IsEnabled() and not (v_u_20:IsVisible() or v_u_21.IsOpen)
	if v27 then
		v27 = not v_u_22.PageSystem.CurrentPage
	end
	v26.Visible = v27
end
function v_u_11._Init(p_u_28) -- name: _Init
	-- upvalues: (copy) v_u_4
	p_u_28.EditorLogic.EnabledChanged:Connect(function()
		-- upvalues: (copy) p_u_28
		p_u_28.EditorEnabled = p_u_28.EditorLogic.Enabled
		p_u_28.EditorEnabledChanged:Fire()
	end)
	v_u_4.ControlsChanged:Connect(function()
		-- upvalues: (copy) p_u_28
		p_u_28:_VerifyControls()
	end)
	task.defer(p_u_28._SetupVisibility, p_u_28)
	task.defer(p_u_28._VerifyControls, p_u_28)
end
return v_u_11._new()