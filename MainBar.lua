local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("Players")
local v_u_3 = require(v1.Modules.CONSTANTS)
require(v1.Modules.DebugLibrary)
local v_u_4 = require(v1.Modules.Utility)
local v_u_5 = require(v_u_2.LocalPlayer.PlayerScripts.Controllers:WaitForChild("PlayerDataController"))
local v_u_6 = require(v_u_2.LocalPlayer.PlayerScripts.Controllers:WaitForChild("ControlsController"))
local v_u_7 = require(v_u_2.LocalPlayer.PlayerScripts.Controllers:WaitForChild("CameraController"))
local v_u_8 = require(v_u_2.LocalPlayer.PlayerScripts.Modules:WaitForChild("InsetButtonsBar"))
local v_u_9 = require(v_u_2.LocalPlayer.PlayerScripts.Modules.UserInterface:WaitForChild("Pages"))
local v_u_10 = require(v_u_2.LocalPlayer.PlayerScripts.Modules:WaitForChild("UILibrary"))
local v_u_11 = require(v_u_2.LocalPlayer.PlayerScripts.Modules.Pages:WaitForChild("Inbox"))
local v_u_12 = v_u_2.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("InboxNotification")
local v_u_13 = {
	{
		"Open",
		"See more",
		"rbxassetid://14641612286",
		nil,
		nil,
		nil
	},
	{
		"Settings",
		"Change your crosshair & hotkeys",
		"rbxassetid://14641612286",
		nil,
		nil,
		"Settings"
	},
	{
		"PatchNotes",
		"Read the latest news",
		"rbxassetid://18457336026",
		nil,
		nil,
		"PatchNotes"
	},
	{
		"Restrictions",
		"",
		"rbxassetid://120647688402991",
		nil,
		nil,
		nil
	},
	{
		"Inbox",
		"View your recent notifications",
		"rbxassetid://96509180790493",
		nil,
		nil,
		"Inbox"
	},
	{
		"PrivateServerControls",
		"Edit your private server",
		"rbxassetid://12343093905",
		nil,
		nil,
		"PrivateServerControls"
	},
	{
		"MobileEditor",
		"Move & resize your touch buttons",
		"rbxassetid://98757786697658",
		UDim2.new(0.525, 0, 0.525, 0),
		UDim2.new(0.55, 0, 0.55, 0),
		nil
	},
	{
		"Freecam",
		"Turn on freecam mode",
		"rbxassetid://17548980857",
		nil,
		nil,
		nil
	}
}
local v_u_14 = {}
v_u_14.__index = v_u_14
function v_u_14.new(p15) -- name: new
	-- upvalues: (copy) v_u_14, (copy) v_u_8, (copy) v_u_10, (copy) v_u_12
	local v16 = v_u_14
	local v17 = setmetatable({}, v16)
	v17.Inset = p15
	v17.Bar = v_u_8.new(v_u_10.BUTTON_BACKGROUND_TRANSPARENCY, v_u_10.BUTTON_BACKGROUND_COLOR, v_u_10.BUTTON_ICON_COLOR, true)
	v17._inbox_notification_frame = v_u_12:Clone()
	v17:_Init()
	return v17
end
function v_u_14.GetNotificationGoal(p18) -- name: GetNotificationGoal
	if p18.Bar.IsOpen then
		return p18.Bar.Buttons.Inbox
	else
		return p18.Bar.Buttons.Open
	end
end
function v_u_14.SetVisible(p19, p20, p21) -- name: SetVisible
	p19.Bar.Frame.Visible = p20
	p19.Bar.Frame.Size = p21 or p19.Bar.Frame.Size
	local v22 = p19.Bar
	local v23
	if p19.Bar.Frame.Visible then
		v23 = p19.Bar.IsOpen
	else
		v23 = false
	end
	v22:Toggle(v23)
end
function v_u_14._UpdateRestrictions(p24) -- name: _UpdateRestrictions
	-- upvalues: (copy) v_u_5, (copy) v_u_3
	local v25 = v_u_5:Get("WinsFromDuelPadsToday") >= v_u_3.MAX_DUEL_PAD_WINS_PER_DAY_BEFORE_BEING_BLOCKED
	local v26 = v_u_5:Get("IsRestrictedFromCasualLeaderboards")
	local v27 = v_u_5:Get("IsRestrictedFromCompetitiveLeaderboards")
	local v28 = (("" .. (v25 and "You\'ve reached the max amount of wins from duel pads today\n" or "")) .. (v26 and "You\'ve been restricted from casual leaderboards due to your ban history\n" or "")) .. (v27 and "You\'ve been restricted from competitive leaderboards due to your ban history\n" or "")
	local v29
	if v28 == "" then
		v29 = ""
	else
		local v30 = #v28 - 1
		v29 = string.sub(v28, 1, v30)
	end
	p24.Bar.Buttons.Restrictions:SetBubbleText(v29)
	p24.Bar.Buttons.Restrictions.Frame.Visible = v29 ~= ""
end
function v_u_14._UpdateFreecam(p31) -- name: _UpdateFreecam
	-- upvalues: (copy) v_u_7, (copy) v_u_6
	local v32 = v_u_7.CameraState:HasFreecamAccess()
	local v33 = v_u_7:GetPublicState() == v_u_7.CameraState.States.CustomFreecam
	local v34 = p31.Bar.Buttons.Freecam.Frame
	local v35 = v32 and not v33
	if v35 then
		v35 = v_u_6.CurrentControls == "MouseKeyboard"
	end
	v34.Visible = v35
end
function v_u_14._UpdateInbox(p36) -- name: _UpdateInbox
	-- upvalues: (copy) v_u_11, (copy) v_u_4
	local v37 = v_u_11:GetNumNewNotifications()
	p36.Bar.Buttons.Inbox.Frame.Visible = v_u_11:GetNumNotifications() > 0
	p36._inbox_notification_frame.Title.Text = v_u_4:PrettyNumber(v37)
	local v38 = p36._inbox_notification_frame
	local v39
	if v37 <= 0 then
		v39 = nil
	elseif p36.Bar.IsOpen then
		v39 = p36.Bar.Buttons.Inbox.Frame.Button
	else
		v39 = p36.Bar.Buttons.Open.Frame.Button
	end
	v38.Parent = v39
end
function v_u_14._UpdateOpenButton(p40) -- name: _UpdateOpenButton
	-- upvalues: (copy) v_u_2
	local v41 = p40.Bar.Buttons.Open
	local v42 = v41.Frame.Button.Icon.Image
	v41:SetBubbleText(p40.Bar.IsOpen and "See less" or "See more")
	v41.Frame.Button.Icon.Image = p40.Bar.IsOpen and "rbxassetid://108220438104376" or "rbxassetid://14641612286"
	if v41.Frame.Button.Icon.Image ~= v42 then
		if v41.Frame.Button:IsDescendantOf(v_u_2) then
			v41.Frame.Button.Icon.Size = UDim2.new(0, 0, 0, 0)
			v41.Frame.Button.Icon:TweenSize(UDim2.new(0.5, 0, 0.5, 0), "Out", "Quint", 0.25, true)
			return
		end
		v41.Frame.Button.Icon.Size = UDim2.new(0.5, 0, 0.5, 0)
	end
end
function v_u_14._UpdateMobileEditorVisibility(p43) -- name: _UpdateMobileEditorVisibility
	-- upvalues: (copy) v_u_6
	local v44 = v_u_6.CurrentControls == "Touch"
	p43.Bar.Buttons.MobileEditor.Frame.Visible = v44
	if p43.Inset.MobileEditorBar.Bar.Frame.Visible and not v44 then
		p43.Inset.MobileEditorBar:SetVisible(false)
	end
end
function v_u_14._Setup(p_u_45) -- name: _Setup
	-- upvalues: (copy) v_u_13, (copy) v_u_9, (copy) v_u_7, (copy) v_u_3, (copy) v_u_2
	for v46, v47 in pairs(v_u_13) do
		local v48, v49, v50, v51, v52, v_u_53 = table.unpack(v47)
		p_u_45.Bar:CreateButton(v46, v48, v49, v50, v51, v52).Clicked:Connect(function()
			-- upvalues: (copy) v_u_53, (ref) v_u_9
			if v_u_53 then
				v_u_9.PageSystem:OpenPage(v_u_53)
			end
		end)
	end
	p_u_45.Bar.Buttons.Open.Clicked:Connect(function()
		-- upvalues: (copy) p_u_45
		p_u_45.Bar:Toggle()
	end)
	p_u_45.Bar.Buttons.MobileEditor.Clicked:Connect(function()
		-- upvalues: (copy) p_u_45
		p_u_45.Inset.MobileEditorBar:SetVisible(true, p_u_45.Bar.Frame.Size)
	end)
	p_u_45.Bar.Buttons.Freecam.Clicked:Connect(function()
		-- upvalues: (ref) v_u_7
		v_u_7.CameraState:SetCustomFreecamEnabled(v_u_7:GetPublicState() ~= v_u_7.CameraState.States.CustomFreecam)
	end)
	local v54 = p_u_45.Bar.Buttons.PrivateServerControls.Frame
	local v55 = v_u_3.IS_PRIVATE_HUB_SERVER
	if v55 then
		v55 = v_u_3.IS_PRIVATE_SERVER_OWNER(v_u_2.LocalPlayer.UserId)
	end
	v54.Visible = v55
	p_u_45.Bar.Buttons.Open.Frame.Visible = true
end
function v_u_14._Init(p_u_56) -- name: _Init
	-- upvalues: (copy) v_u_11, (copy) v_u_6, (copy) v_u_7, (copy) v_u_5
	p_u_56.Bar.OpenedChanged:Connect(function()
		-- upvalues: (copy) p_u_56
		p_u_56:_UpdateOpenButton()
		p_u_56:_UpdateInbox()
	end)
	v_u_11.NotificationAdded:Connect(function()
		-- upvalues: (copy) p_u_56
		p_u_56:_UpdateInbox()
	end)
	v_u_11.NotificationQueued:Connect(function()
		-- upvalues: (copy) p_u_56
		p_u_56:_UpdateInbox()
	end)
	v_u_6.ControlsChanged:Connect(function()
		-- upvalues: (copy) p_u_56
		p_u_56:_UpdateMobileEditorVisibility()
		p_u_56:_UpdateFreecam()
	end)
	v_u_7.CustomFreecamStateChanged:Connect(function()
		-- upvalues: (copy) p_u_56
		p_u_56:_UpdateFreecam()
	end)
	v_u_7.CameraState.FreecamAccessChanged:Connect(function()
		-- upvalues: (copy) p_u_56
		p_u_56:_UpdateFreecam()
	end)
	v_u_5:GetDataChangedSignal("IsBadGuy"):Connect(function()
		-- upvalues: (copy) p_u_56
		p_u_56:_UpdateRestrictions()
	end)
	v_u_5:GetDataChangedSignal("IsBadGuy2"):Connect(function()
		-- upvalues: (copy) p_u_56
		p_u_56:_UpdateRestrictions()
	end)
	v_u_5:GetDataChangedSignal("WinsFromDuelPadsToday"):Connect(function()
		-- upvalues: (copy) p_u_56
		p_u_56:_UpdateRestrictions()
	end)
	p_u_56:_Setup()
	p_u_56:_UpdateInbox()
	p_u_56:_UpdateFreecam()
	p_u_56:_UpdateOpenButton()
	p_u_56:_UpdateRestrictions()
	p_u_56:_UpdateMobileEditorVisibility()
	p_u_56:SetVisible(true)
end
return v_u_14