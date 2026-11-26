local v_u_1 = game:GetService("ExperienceNotificationService")
local v_u_2 = game:GetService("AvatarEditorService")
local v_u_3 = game:GetService("ReplicatedStorage")
local v_u_4 = game:GetService("UserInputService")
game:GetService("SocialService")
local v_u_5 = game:GetService("GroupService")
local v6 = game:GetService("Players")
local v_u_7 = require(v_u_3.Modules.CONSTANTS)
local v_u_8 = require(v_u_3.Modules.Utility)
local v_u_9 = require(v6.LocalPlayer.PlayerScripts.Controllers:WaitForChild("PlayerDataController"))
local v_u_10 = require(v6.LocalPlayer.PlayerScripts.Controllers:WaitForChild("ComplianceController"))
local v_u_11 = require(v6.LocalPlayer.PlayerScripts.Controllers:WaitForChild("SocialController"))
local v_u_12 = require(v6.LocalPlayer.PlayerScripts.Modules:WaitForChild("PromptSystem"))
local v_u_13 = require(v6.LocalPlayer.PlayerScripts.Modules:WaitForChild("ButtonEffect"))
local v_u_14 = require(v6.LocalPlayer.PlayerScripts.Modules:WaitForChild("RewardSlot"))
local v_u_15 = require(v6.LocalPlayer.PlayerScripts.Modules:WaitForChild("Page"))
local v_u_16 = {
	["HoverRatio"] = 1.05,
	["ReleaseRatio"] = 1.05
}
local v_u_17 = setmetatable({}, v_u_15)
v_u_17.__index = v_u_17
function v_u_17._new() -- name: _new
	-- upvalues: (copy) v_u_15, (copy) v_u_17, (copy) v_u_12
	local v18 = v_u_15.new(script.Name)
	local v19 = v_u_17
	local v20 = setmetatable(v18, v19)
	v20.CloseButton = v20.PageFrame:WaitForChild("Close")
	v20.PromptsFrame = v20.PageFrame:WaitForChild("Prompts")
	v20.List = v20.PageFrame:WaitForChild("List")
	v20.Container = v20.List:WaitForChild("Container")
	v20.Layout = v20.Container:WaitForChild("Layout")
	v20.InviteFrame = v20.Container:WaitForChild("Invite")
	v20.InviteRewardFrame = v20.InviteFrame:WaitForChild("Reward")
	v20.InviteRewardButton = v20.InviteFrame:WaitForChild("Button")
	v20.FavoriteFrame = v20.Container:WaitForChild("Favorite")
	v20.FavoriteRewardClaimed = v20.FavoriteFrame:WaitForChild("Claimed")
	v20.FavoriteRewardFrame = v20.FavoriteFrame:WaitForChild("Reward")
	v20.FavoriteRewardButton = v20.FavoriteFrame:WaitForChild("Button")
	v20.NotificationsFrame = v20.Container:WaitForChild("Notifications")
	v20.NotificationsRewardClaimed = v20.NotificationsFrame:WaitForChild("Claimed")
	v20.NotificationsRewardFrame = v20.NotificationsFrame:WaitForChild("Reward")
	v20.NotificationsRewardButton = v20.NotificationsFrame:WaitForChild("Button")
	v20.LikeFrame = v20.Container:WaitForChild("Like")
	v20.LikeRewardFrame = v20.LikeFrame:WaitForChild("Reward")
	v20.LikeRewardClaimed = v20.LikeFrame:WaitForChild("Claimed")
	v20.LikeRewardButton = v20.LikeFrame:WaitForChild("Button")
	v20.LikeRewardReadyFrame = v20.LikeRewardButton:WaitForChild("Ready")
	v20.LikeRewardCountdownFrame = v20.LikeRewardButton:WaitForChild("Countdown")
	v20.LikeRewardCountdownText = v20.LikeRewardCountdownFrame:WaitForChild("Title")
	v20.GroupFrame = v20.Container:WaitForChild("Group")
	v20.GroupRewardFrame = v20.GroupFrame:WaitForChild("Reward")
	v20.GroupRewardClaimed = v20.GroupFrame:WaitForChild("Claimed")
	v20.GroupRewardButton = v20.GroupFrame:WaitForChild("Button")
	v20.GroupRewardReadyFrame = v20.GroupRewardButton:WaitForChild("Ready")
	v20.GroupRewardCountdownFrame = v20.GroupRewardButton:WaitForChild("Countdown")
	v20.GroupRewardJoinFrame = v20.GroupRewardButton:WaitForChild("Join")
	v20.GroupRewardCountdownText = v20.GroupRewardCountdownFrame:WaitForChild("Title")
	v20.CodesFrame = v20.Container:WaitForChild("Codes")
	v20.CodesVerifiedFrame = v20.CodesFrame:WaitForChild("Verified")
	v20.CodesVerifiedInputFrame = v20.CodesVerifiedFrame:WaitForChild("Input")
	v20.CodesVerifiedBox = v20.CodesVerifiedInputFrame:WaitForChild("Box")
	v20.CodesVerifiedButton = v20.CodesVerifiedInputFrame:WaitForChild("Button")
	v20.CodesVerifiedButtonReadyFrame = v20.CodesVerifiedButton:WaitForChild("Ready")
	v20.CodesVerifiedButtonCountdownFrame = v20.CodesVerifiedButton:WaitForChild("Countdown")
	v20.CodesVerifiedButtonCountdownText = v20.CodesVerifiedButtonCountdownFrame:WaitForChild("Title")
	v20.CodesUnverifiedFrame = v20.CodesFrame:WaitForChild("Unverified")
	v20.CodesUnverifiedButton = v20.CodesUnverifiedFrame:WaitForChild("Input"):WaitForChild("Button")
	v20.CodesUnverifiedButtonReadyFrame = v20.CodesUnverifiedButton:WaitForChild("Ready")
	v20.CodesUnverifiedButtonCountdownFrame = v20.CodesUnverifiedButton:WaitForChild("Countdown")
	v20.CodesUnverifiedButtonCountdownText = v20.CodesUnverifiedButtonCountdownFrame:WaitForChild("Title")
	v20.PromptSystem = v_u_12.new(v20.PromptsFrame)
	v20._open_animation_disabled = true
	v20._group_reward_countdown_hash = 0
	v20._like_reward_countdown_hash = 0
	v20._codes_verify_countdown_hash = 0
	v20._window_focus_connection = nil
	v20._is_enabling_notifications = false
	v20._is_favoriting = false
	v20._can_verify = false
	v20._previous_verified_status = nil
	v20._redirect_on_close = nil
	v20:_Init()
	return v20
end
function v_u_17.CloseRequest(p21) -- name: CloseRequest
	-- upvalues: (copy) v_u_9, (copy) v_u_15
	local v22 = v_u_9:GetStatistic("StatisticDuelsPlayed")
	local v23 = v_u_9:GetStatistic("StatisticDuelsWon")
	if v22 >= 5 and v23 < 10 then
		v_u_15.CloseRequest(p21)
	else
		p21.OpenPage:Fire("Shop", true)
	end
end
function v_u_17._UpdateCodesVerified(p24) -- name: _UpdateCodesVerified
	-- upvalues: (copy) v_u_9, (copy) v_u_8
	local v25 = v_u_9:Get("CodesVerified")
	if p24._previous_verified_status == false and v25 then
		v_u_8:CreateSound("rbxassetid://7715210658", 1, 1, script, true, 5)
	end
	p24._previous_verified_status = v25
	p24.CodesVerifiedFrame.Visible = v25
	p24.CodesUnverifiedFrame.Visible = not v25
end
function v_u_17._CountdownCodesVerify(p_u_26) -- name: _CountdownCodesVerify
	p_u_26._codes_verify_countdown_hash = p_u_26._codes_verify_countdown_hash + 1
	local v_u_27 = p_u_26._codes_verify_countdown_hash
	p_u_26.CodesUnverifiedButtonCountdownFrame.Visible = true
	p_u_26.CodesUnverifiedButtonReadyFrame.Visible = false
	task.spawn(function()
		-- upvalues: (copy) p_u_26, (copy) v_u_27
		for v28 = 15, 1, -1 do
			p_u_26.CodesUnverifiedButtonCountdownText.Text = v28
			wait(1)
			if v_u_27 == p_u_26._codes_verify_countdown_hash then
				continue
			end
			return
		end
		p_u_26.CodesUnverifiedButtonCountdownFrame.Visible = false
		p_u_26.CodesUnverifiedButtonReadyFrame.Visible = true
	end)
end
function v_u_17._UpdateNotificationsReward(p29) -- name: _UpdateNotificationsReward
	-- upvalues: (copy) v_u_9
	local v30 = v_u_9:Get("ClaimedNotificationsReward")
	p29.NotificationsRewardClaimed.Visible = v30
	p29.NotificationsRewardButton.Visible = not v30
end
function v_u_17._UpdateFavoriteReward(p31) -- name: _UpdateFavoriteReward
	-- upvalues: (copy) v_u_9
	local v32 = v_u_9:Get("ClaimedFavoriteReward")
	p31.FavoriteRewardClaimed.Visible = v32
	p31.FavoriteRewardButton.Visible = not v32
end
function v_u_17._UpdateLikeReward(p33) -- name: _UpdateLikeReward
	-- upvalues: (copy) v_u_9
	local v34 = v_u_9:Get("ClaimedLikeReward")
	p33.LikeRewardClaimed.Visible = v34
	p33.LikeRewardButton.Visible = not v34
	if v34 then
		p33._like_reward_countdown_hash = p33._like_reward_countdown_hash + 1
	end
end
function v_u_17._CountdownLikeReward(p_u_35) -- name: _CountdownLikeReward
	p_u_35._like_reward_countdown_hash = p_u_35._like_reward_countdown_hash + 1
	local v_u_36 = p_u_35._like_reward_countdown_hash
	p_u_35.LikeRewardCountdownFrame.Visible = true
	p_u_35.LikeRewardReadyFrame.Visible = false
	task.spawn(function()
		-- upvalues: (copy) p_u_35, (copy) v_u_36
		for v37 = 20, 1, -1 do
			p_u_35.LikeRewardCountdownText.Text = v37
			wait(1)
			if v_u_36 == p_u_35._like_reward_countdown_hash then
				continue
			end
			return
		end
		p_u_35.LikeRewardCountdownFrame.Visible = false
		p_u_35.LikeRewardReadyFrame.Visible = true
	end)
end
function v_u_17._UpdateGroupReward(p38) -- name: _UpdateGroupReward
	-- upvalues: (copy) v_u_9
	local v39 = v_u_9:Get("ClaimedGroupReward")
	p38.GroupRewardClaimed.Visible = v39
	p38.GroupRewardButton.Visible = not v39
	if v39 then
		p38._group_reward_countdown_hash = p38._group_reward_countdown_hash + 1
	end
end
function v_u_17._CountdownGroupReward(p_u_40) -- name: _CountdownGroupReward
	p_u_40._group_reward_countdown_hash = p_u_40._group_reward_countdown_hash + 1
	local v_u_41 = p_u_40._group_reward_countdown_hash
	p_u_40.GroupRewardCountdownFrame.Visible = true
	p_u_40.GroupRewardReadyFrame.Visible = false
	task.spawn(function()
		-- upvalues: (copy) p_u_40, (copy) v_u_41
		for v42 = 60, 1, -1 do
			p_u_40.GroupRewardCountdownText.Text = v42
			wait(1)
			if v_u_41 == p_u_40._group_reward_countdown_hash then
				continue
			end
			return
		end
		p_u_40.GroupRewardCountdownFrame.Visible = false
		p_u_40.GroupRewardReadyFrame.Visible = true
	end)
end
function v_u_17._UpdateInviteFrame(p43) -- name: _UpdateInviteFrame
	-- upvalues: (copy) v_u_11
	p43.InviteFrame.Visible = v_u_11.CanSendGameInvite
end
function v_u_17._Setup(p_u_44) -- name: _Setup
	-- upvalues: (copy) v_u_10, (copy) v_u_14, (copy) v_u_1
	for _, v45 in pairs({ "Group", "Nosniy", "SenseiWarrior" }) do
		local v46 = p_u_44.CodesFrame:WaitForChild(v45)
		for _, v47 in pairs({ "X", "Discord", "YouTube" }) do
			local v48 = v46:WaitForChild("Details"):FindFirstChild(v47)
			if not v48 then
				continue
			end
			v48.Visible = v_u_10:IsExternalReferencesAllowed(v47)
		end
	end
	v_u_14.new({
		["Name"] = "Cream",
		["Weapon"] = "IsRandom"
	}):SetParent(p_u_44.InviteRewardFrame)
	v_u_14.new({
		["Name"] = "Shooting Star",
		["Weapon"] = "IsUniversal"
	}):SetParent(p_u_44.FavoriteRewardFrame)
	v_u_14.new({
		["Name"] = "Bell",
		["Weapon"] = "IsUniversal"
	}):SetParent(p_u_44.NotificationsRewardFrame)
	v_u_14.new({
		["Name"] = "Nosniy Games",
		["Weapon"] = "IsUniversal"
	}):SetParent(p_u_44.GroupRewardFrame)
	v_u_14.new({
		["Name"] = "RIVALS",
		["Weapon"] = "IsUniversal"
	}):SetParent(p_u_44.LikeRewardFrame)
	local v49 = v_u_14.new({
		["Name"] = "Key",
		["Quantity"] = 3
	})
	v49:SetParent(p_u_44.LikeRewardFrame)
	v49.Frame.Position = UDim2.new(-0.5, 0, 0.5, 0)
	task.spawn(function()
		-- upvalues: (copy) p_u_44, (ref) v_u_1
		p_u_44.NotificationsFrame.Visible = false
		local v50 = v_u_1.CanPromptOptInAsync
		local v51 = v_u_1
		local v52, v53 = pcall(v50, v51)
		p_u_44.NotificationsFrame.Visible = v52 and v53
	end)
end
function v_u_17._Init(p_u_54) -- name: _Init
	-- upvalues: (copy) v_u_5, (copy) v_u_7, (copy) v_u_3, (copy) v_u_2, (copy) v_u_11, (copy) v_u_1, (copy) v_u_4, (copy) v_u_9, (copy) v_u_13, (copy) v_u_16
	p_u_54.Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		-- upvalues: (copy) p_u_54
		p_u_54.List.CanvasSize = UDim2.new(0, 0, 0, p_u_54.Layout.AbsoluteContentSize.Y)
	end)
	p_u_54.CloseButton.MouseButton1Click:Connect(function()
		-- upvalues: (copy) p_u_54
		p_u_54:CloseRequest()
	end)
	p_u_54.GroupRewardButton.MouseButton1Click:Connect(function()
		-- upvalues: (copy) p_u_54, (ref) v_u_5, (ref) v_u_7, (ref) v_u_3
		if p_u_54.GroupRewardJoinFrame.Visible then
			p_u_54.GroupRewardJoinFrame.Visible = false
			p_u_54.GroupRewardReadyFrame.Visible = true
			local v55 = v_u_5.PromptJoinAsync
			local v56 = v_u_5
			local v57 = v_u_7.GROUP_ID
			local v58, v59 = pcall(v55, v56, v57)
			if not v58 then
				p_u_54.PromptSystem:Open("ErrorMessage", "Whoops!", "Failed to join, please try again another time!")
				warn("Failed to prompt group join, error:", v59)
				return
			end
		elseif p_u_54.GroupRewardReadyFrame.Visible then
			p_u_54:_CountdownGroupReward()
			if not v_u_3.Remotes.Data.ClaimGroupReward:InvokeServer() then
				p_u_54.PromptSystem:Open("ErrorMessage", "Whoops!", "Failed to verify, join the group before claiming your reward!")
			end
		end
	end)
	p_u_54.LikeRewardButton.MouseButton1Click:Connect(function()
		-- upvalues: (copy) p_u_54, (ref) v_u_3
		if p_u_54.LikeRewardReadyFrame.Visible then
			if p_u_54._window_focus_connection then
				p_u_54._window_focus_connection:Disconnect()
				p_u_54._window_focus_connection = nil
				p_u_54.PromptSystem:Open("ErrorMessage", "Whoops!", "Failed to verify, like the game before claiming your reward!")
				p_u_54:_CountdownLikeReward()
				return
			end
			v_u_3.Remotes.Data.ClaimLikeReward:FireServer()
		end
	end)
	p_u_54.FavoriteRewardButton.MouseButton1Click:Connect(function()
		-- upvalues: (ref) v_u_2, (ref) v_u_7, (copy) p_u_54, (ref) v_u_3
		v_u_2:PromptSetFavorite(v_u_7.HUB_PLACE_ID, Enum.AvatarItemType.Asset, true)
		if not p_u_54._is_favoriting then
			p_u_54._is_favoriting = true
			wait(10)
			v_u_3.Remotes.Data.ClaimFavoriteReward:FireServer()
		end
	end)
	p_u_54.InviteRewardButton.MouseButton1Click:Connect(function()
		-- upvalues: (ref) v_u_11
		v_u_11:PromptFriendInvite()
	end)
	p_u_54.NotificationsRewardButton.MouseButton1Click:Connect(function()
		-- upvalues: (ref) v_u_1, (copy) p_u_54, (ref) v_u_3
		v_u_1:PromptOptIn()
		if not p_u_54._is_enabling_notifications then
			p_u_54._is_enabling_notifications = true
			wait(10)
			v_u_3.Remotes.Data.ClaimNotificationsReward:FireServer()
		end
	end)
	p_u_54.CodesUnverifiedButton.MouseButton1Click:Connect(function()
		-- upvalues: (copy) p_u_54, (ref) v_u_3
		if p_u_54.CodesUnverifiedButtonReadyFrame.Visible then
			if p_u_54._can_verify then
				v_u_3.Remotes.Data.VerifyCodes:FireServer()
			else
				p_u_54._can_verify = true
				p_u_54.PromptSystem:Open("ErrorMessage", "Whoops!", "Failed to verify, follow the developers before verifying!")
				p_u_54:_CountdownCodesVerify()
			end
		else
			return
		end
	end)
	p_u_54.CodesVerifiedButton.MouseButton1Click:Connect(function()
		-- upvalues: (ref) v_u_3, (copy) p_u_54
		local v60 = v_u_3.Remotes.Data.RedeemCode:InvokeServer(string.lower(p_u_54.CodesVerifiedBox.Text)) or "Something went wrong"
		if v60 ~= "Success" then
			p_u_54.PromptSystem:Open("ErrorMessage", "Whoops!", "Failed to redeem code: " .. v60)
		end
	end)
	p_u_54._window_focus_connection = v_u_4.WindowFocusReleased:Connect(function()
		-- upvalues: (copy) p_u_54
		p_u_54._window_focus_connection:Disconnect()
		p_u_54._window_focus_connection = nil
	end)
	v_u_9:GetDataChangedSignal("ClaimedGroupReward"):Connect(function()
		-- upvalues: (copy) p_u_54
		p_u_54:_UpdateGroupReward()
	end)
	v_u_9:GetDataChangedSignal("ClaimedLikeReward"):Connect(function()
		-- upvalues: (copy) p_u_54
		p_u_54:_UpdateLikeReward()
	end)
	v_u_9:GetDataChangedSignal("ClaimedFavoriteReward"):Connect(function()
		-- upvalues: (copy) p_u_54
		p_u_54:_UpdateFavoriteReward()
	end)
	v_u_9:GetDataChangedSignal("ClaimedNotificationsReward"):Connect(function()
		-- upvalues: (copy) p_u_54
		p_u_54:_UpdateNotificationsReward()
	end)
	v_u_9:GetDataChangedSignal("CodesVerified"):Connect(function()
		-- upvalues: (copy) p_u_54
		p_u_54:_UpdateCodesVerified()
	end)
	v_u_11.CanSendGameInviteChanged:Connect(function()
		-- upvalues: (copy) p_u_54
		p_u_54:_UpdateInviteFrame()
	end)
	p_u_54:_Setup()
	p_u_54:_UpdateInviteFrame()
	p_u_54:_UpdateLikeReward()
	p_u_54:_UpdateGroupReward()
	p_u_54:_UpdateFavoriteReward()
	p_u_54:_UpdateNotificationsReward()
	p_u_54:_UpdateCodesVerified()
	v_u_13:Add(p_u_54.CloseButton)
	v_u_13:Add(p_u_54.InviteRewardButton, nil, v_u_16)
	v_u_13:Add(p_u_54.FavoriteRewardButton, nil, v_u_16)
	v_u_13:Add(p_u_54.NotificationsRewardButton, nil, v_u_16)
	v_u_13:Add(p_u_54.LikeRewardButton, nil, v_u_16)
	v_u_13:Add(p_u_54.GroupRewardButton, nil, v_u_16)
	v_u_13:Add(p_u_54.CodesVerifiedButton, nil, v_u_16)
	v_u_13:Add(p_u_54.CodesUnverifiedButton, nil, v_u_16)
end
return v_u_17._new()