local v1 = game:GetService("ReplicatedStorage")
local v2 = game:GetService("Players")
local v_u_3 = require(v1.Modules.PermissionsLibrary)
local v_u_4 = require(v1.Modules.ModerationLibrary)
local v_u_5 = require(v1.Modules.DebugLibrary)
local v_u_6 = require(v2.LocalPlayer.PlayerScripts.Controllers:WaitForChild("ShootingRangeController"))
local v_u_7 = require(v2.LocalPlayer.PlayerScripts.Controllers:WaitForChild("PlayerDataController"))
local v_u_8 = require(v2.LocalPlayer.PlayerScripts.Controllers:WaitForChild("SettingsController"))
local v_u_9 = require(v2.LocalPlayer.PlayerScripts.Controllers:WaitForChild("FighterController"))
local v_u_10 = require(v2.LocalPlayer.PlayerScripts.Controllers:WaitForChild("CameraController"))
local v_u_11 = require(v2.LocalPlayer.PlayerScripts.Modules.UserInterface:WaitForChild("PlayerList"))
local v_u_12 = require(v2.LocalPlayer.PlayerScripts.Modules:WaitForChild("InsetButtonsBar"))
local v_u_13 = require(v2.LocalPlayer.PlayerScripts.Modules.UserInterface:WaitForChild("Pages"))
local v_u_14 = require(v2.LocalPlayer.PlayerScripts.Modules:WaitForChild("UILibrary"))
local v_u_15 = {
	{
		"StopFreecam",
		"Turn off freecam mode",
		"rbxassetid://17548980857",
		nil,
		nil,
		nil
	},
	{
		"LeaveShootingRange",
		"Leave the Shooting Range",
		"rbxassetid://17498605048",
		nil,
		nil,
		nil
	},
	{
		"PlayerList",
		"Open the player list",
		"rbxassetid://108950719202626",
		nil,
		nil,
		nil
	},
	{
		"HUD",
		"Enable your HUD",
		"rbxassetid://126633805196326",
		nil,
		nil,
		nil
	},
	{
		"Debug",
		"Test things out using commands",
		"rbxassetid://18223601855",
		nil,
		UDim2.new(0.6, 0, 0.6, 0),
		"Debug"
	},
	{
		"Moderation",
		"Search, join, & ban cheaters",
		"rbxassetid://118920750856778",
		nil,
		nil,
		"Moderation"
	},
	{
		"Permissions",
		"Promote & demote team members",
		"rbxassetid://95626460059631",
		nil,
		UDim2.new(0.75, 0, 0.75, 0),
		"Permissions"
	}
}
local v_u_16 = {}
v_u_16.__index = v_u_16
function v_u_16.new(p17) -- name: new
	-- upvalues: (copy) v_u_16, (copy) v_u_12, (copy) v_u_14
	local v18 = v_u_16
	local v19 = setmetatable({}, v18)
	v19.Inset = p17
	v19.Bar = v_u_12.new(v_u_14.BUTTON_BACKGROUND_TRANSPARENCY, v_u_14.BUTTON_BACKGROUND_COLOR, v_u_14.BUTTON_ICON_COLOR, true)
	v19._local_fighter = nil
	v19:_Init()
	return v19
end
function v_u_16.SetVisible(p20, p21, p22) -- name: SetVisible
	p20.Bar.Frame.Visible = p21
	p20.Bar.Frame.Size = p22 or p20.Bar.Frame.Size
	p20.Bar:Toggle(true)
end
function v_u_16._UpdateVisibility(p23) -- name: _UpdateVisibility
	-- upvalues: (copy) v_u_10, (copy) v_u_11, (copy) v_u_7, (copy) v_u_5, (copy) v_u_4, (copy) v_u_3
	p23.Bar.Buttons.StopFreecam.Frame.Visible = v_u_10:GetPublicState() == v_u_10.CameraState.States.CustomFreecam
	local v24 = p23.Bar.Buttons.PlayerList.Frame
	local v25 = v_u_11.ClosedByInputs
	if v25 then
		v25 = v_u_11:GetBaseVisibility()
	end
	v24.Visible = v25
	p23.Bar.Buttons.HUD.Frame.Visible = v_u_7:GetSetting("Hide HUD")
	local v26 = p23.Bar.Buttons.LeaveShootingRange.Frame
	local v27 = p23._local_fighter
	if v27 then
		v27 = p23._local_fighter:Get("IsInShootingRange")
	end
	v26.Visible = v27
	local v28 = p23.Bar.Buttons.Debug.Frame
	local v29 = not v_u_7:GetSetting("Staff Team Tools Disabled")
	if v29 then
		v29 = v_u_5:CanViewDebugPage(v_u_7:Get("PermissionsRoles"))
	end
	v28.Visible = v29
	local v30 = p23.Bar.Buttons.Moderation.Frame
	local v31 = not v_u_7:GetSetting("Staff Team Tools Disabled")
	if v31 then
		v31 = v_u_4:CanViewModerationPage(v_u_7:Get("PermissionsRoles"))
	end
	v30.Visible = v31
	local v32 = p23.Bar.Buttons.Permissions.Frame
	local v33 = not (v_u_3.USE_GROUP_ROLES_INSTEAD_OF_DATASTORES or v_u_7:GetSetting("Staff Team Tools Disabled Leads"))
	if v33 then
		v33 = v_u_3:CanViewPermissionsPage(v_u_7:Get("PermissionsRoles"))
	end
	v32.Visible = v33
	p23:SetVisible(p23.Bar.Frame.Visible)
end
function v_u_16._HookFighter(p_u_34) -- name: _HookFighter
	-- upvalues: (copy) v_u_9
	p_u_34._local_fighter = v_u_9:WaitForLocalFighter()
	p_u_34._local_fighter:GetDataChangedSignal("IsInShootingRange"):Connect(function()
		-- upvalues: (copy) p_u_34
		p_u_34:_UpdateVisibility()
	end)
	p_u_34:_UpdateVisibility()
end
function v_u_16._Setup(p35) -- name: _Setup
	-- upvalues: (copy) v_u_15, (copy) v_u_13, (copy) v_u_10, (copy) v_u_6, (copy) v_u_11, (copy) v_u_8
	for v36, v37 in pairs(v_u_15) do
		local v38, v39, v40, v41, v42, v_u_43 = table.unpack(v37)
		p35.Bar:CreateButton(v36, v38, v39, v40, v41, v42).Clicked:Connect(function()
			-- upvalues: (copy) v_u_43, (ref) v_u_13
			if v_u_43 then
				v_u_13.PageSystem:OpenPage(v_u_43)
			end
		end)
	end
	p35.Bar.Buttons.StopFreecam.Clicked:Connect(function()
		-- upvalues: (ref) v_u_10
		v_u_10.CameraState:SetCustomFreecamEnabled(false)
	end)
	p35.Bar.Buttons.LeaveShootingRange.Clicked:Connect(function()
		-- upvalues: (ref) v_u_6
		v_u_6:Leave()
	end)
	p35.Bar.Buttons.PlayerList.Clicked:Connect(function()
		-- upvalues: (ref) v_u_11
		v_u_11:SetClosedByInputs(not v_u_11.ClosedByInputs)
	end)
	p35.Bar.Buttons.HUD.Clicked:Connect(function()
		-- upvalues: (ref) v_u_8
		v_u_8:ChangeSetting("Hide HUD", false)
	end)
	p35.Bar.Frame.Parent = p35.Inset.RightButtonsFrame
end
function v_u_16._Init(p_u_44) -- name: _Init
	-- upvalues: (copy) v_u_7, (copy) v_u_11, (copy) v_u_10
	v_u_7:GetSettingChangedSignal("Staff Team Tools Disabled"):Connect(function()
		-- upvalues: (copy) p_u_44
		p_u_44:_UpdateVisibility()
	end)
	v_u_7:GetSettingChangedSignal("Staff Team Tools Disabled Leads"):Connect(function()
		-- upvalues: (copy) p_u_44
		p_u_44:_UpdateVisibility()
	end)
	v_u_7:GetSettingChangedSignal("Hide HUD"):Connect(function()
		-- upvalues: (copy) p_u_44
		p_u_44:_UpdateVisibility()
	end)
	v_u_7:GetDataChangedSignal("PermissionsRoles"):Connect(function()
		-- upvalues: (copy) p_u_44
		p_u_44:_UpdateVisibility()
	end)
	v_u_11.ClosedByInputsChanged:Connect(function()
		-- upvalues: (copy) p_u_44
		p_u_44:_UpdateVisibility()
	end)
	v_u_11.BaseVisibilityChanged:Connect(function()
		-- upvalues: (copy) p_u_44
		p_u_44:_UpdateVisibility()
	end)
	v_u_10.CustomFreecamStateChanged:Connect(function()
		-- upvalues: (copy) p_u_44
		p_u_44:_UpdateVisibility()
	end)
	v_u_10.CameraState.FreecamAccessChanged:Connect(function()
		-- upvalues: (copy) p_u_44
		p_u_44:_UpdateVisibility()
	end)
	p_u_44:_Setup()
	p_u_44:_UpdateVisibility()
	task.defer(p_u_44._HookFighter, p_u_44)
end
return v_u_16