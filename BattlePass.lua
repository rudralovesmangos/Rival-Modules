local v_u_1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("UserInputService")
local v_u_3 = game:GetService("TweenService")
local v4 = game:GetService("Players")
local v_u_5 = require(v_u_1.Modules.MonetizationLibrary)
local v_u_6 = require(v_u_1.Modules.CosmeticLibrary)
local v_u_7 = require(v_u_1.Modules.SeasonLibrary)
local v_u_8 = require(v_u_1.Modules.ItemLibrary)
local v_u_9 = require(v_u_1.Modules.Utility)
local v_u_10 = require(v4.LocalPlayer.PlayerScripts.Controllers:WaitForChild("MonetizationController"))
local v_u_11 = require(v4.LocalPlayer.PlayerScripts.Controllers:WaitForChild("PlayerDataController"))
local v_u_12 = require(v4.LocalPlayer.PlayerScripts.Controllers:WaitForChild("ControlsController"))
local v_u_13 = require(v4.LocalPlayer.PlayerScripts.Controllers:WaitForChild("SeasonController"))
local v_u_14 = require(v4.LocalPlayer.PlayerScripts.Modules:WaitForChild("WeaponStatusHandler"))
local v_u_15 = require(v4.LocalPlayer.PlayerScripts.Modules:WaitForChild("ButtonEffect"))
local v_u_16 = require(v4.LocalPlayer.PlayerScripts.Modules:WaitForChild("PromptSystem"))
local v_u_17 = require(v4.LocalPlayer.PlayerScripts.Modules:WaitForChild("BundleSlot"))
local v_u_18 = require(v4.LocalPlayer.PlayerScripts.Modules:WaitForChild("RewardSlot"))
local v_u_19 = require(v4.LocalPlayer.PlayerScripts.Modules:WaitForChild("Page"))
local v_u_20 = v4.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("BattlePassFooterSlot")
local v_u_21 = v4.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("BattlePassRewardSlot")
local v_u_22 = v4.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("BattlePassTrackSlot")
local v_u_23 = TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
local v_u_24 = setmetatable({}, v_u_19)
v_u_24.__index = v_u_24
function v_u_24._new() -- name: _new
	-- upvalues: (copy) v_u_19, (copy) v_u_24, (copy) v_u_16, (copy) v_u_17
	local v25 = v_u_19.new(script.Name)
	local v26 = v_u_24
	local v27 = setmetatable(v25, v26)
	v27.CloseButton = v27.PageFrame:WaitForChild("TopRight"):WaitForChild("Close")
	v27.PromptsFrame = v27.PageFrame:WaitForChild("Prompts")
	v27.BackgroundFrame = v27.PageFrame:WaitForChild("Background")
	v27.List = v27.PageFrame:WaitForChild("List")
	v27.Container = v27.List:WaitForChild("Container")
	v27.Layout = v27.Container:WaitForChild("Layout")
	v27.RewardsFrame = v27.Container:WaitForChild("Rewards")
	v27.TracksFrame = v27.RewardsFrame:WaitForChild("Tracks")
	v27.FooterFrame = v27.TracksFrame:WaitForChild("Footer")
	v27.FooterBackground = v27.FooterFrame:WaitForChild("Background")
	v27.FooterSlotsFrame = v27.FooterFrame:WaitForChild("Slots")
	v27.FooterSlotsLayout = v27.FooterSlotsFrame:WaitForChild("Layout")
	v27.HeaderFrame = v27.TracksFrame:WaitForChild("Header")
	v27.HeaderContainer = v27.HeaderFrame:WaitForChild("Container")
	v27.HeaderLevelText = v27.HeaderContainer:WaitForChild("Value")
	v27.HeaderXPFrame = v27.HeaderContainer:WaitForChild("XP")
	v27.HeaderXPBarFrame = v27.HeaderXPFrame:WaitForChild("Bar")
	v27.HeaderNextLevelText = v27.HeaderXPBarFrame:WaitForChild("NextLevel")
	v27.HeaderXPBarContainer = v27.HeaderXPBarFrame:WaitForChild("Container")
	v27.HeaderBubbleFrame = v27.HeaderContainer:WaitForChild("Bubble")
	v27.HeaderBubbleArrow = v27.HeaderBubbleFrame:WaitForChild("Arrow")
	v27.HeaderBubbleTitle = v27.HeaderBubbleFrame:WaitForChild("Title")
	v27.HeaderBubbleBackground = v27.HeaderBubbleFrame:WaitForChild("Background")
	v27.NextButton = v27.HeaderContainer:WaitForChild("Next")
	v27.NextBackground = v27.NextButton:WaitForChild("Background")
	v27.NextIcon = v27.NextButton:WaitForChild("Icon")
	v27.PreviousButton = v27.HeaderContainer:WaitForChild("Previous")
	v27.PreviousBackground = v27.PreviousButton:WaitForChild("Background")
	v27.PreviousIcon = v27.PreviousButton:WaitForChild("Icon")
	v27.PreviewFrame = v27.Container:WaitForChild("Preview")
	v27.PreviewContainer = v27.PreviewFrame:WaitForChild("Container")
	v27.PreviewRewardContainer = v27.PreviewContainer:WaitForChild("RewardContainer")
	v27.PreviewDetailsFrame = v27.PreviewFrame:WaitForChild("Details")
	v27.PreviewDetailsClaimed = v27.PreviewDetailsFrame:WaitForChild("Claimed")
	v27.PreviewDetailsTitle = v27.PreviewDetailsFrame:WaitForChild("Title")
	v27.PreviewDetailsDescription = v27.PreviewDetailsFrame:WaitForChild("Description")
	v27.PreviewUnlockFrame = v27.PreviewFrame:WaitForChild("Unlock")
	v27.PreviewUnlockContainer = v27.PreviewUnlockFrame:WaitForChild("Container")
	v27.PreviewUnlockDetailsFrame = v27.PreviewUnlockContainer:WaitForChild("Details")
	v27.PreviewUnlockTiersText = v27.PreviewUnlockDetailsFrame:WaitForChild("Tiers")
	v27.PreviewUnlockTitleText = v27.PreviewUnlockDetailsFrame:WaitForChild("Title")
	v27.PreviewUnlockButtonFrame = v27.PreviewUnlockContainer:WaitForChild("Buy")
	v27.PreviewUnlockButton = v27.PreviewUnlockButtonFrame:WaitForChild("Button")
	v27.PreviewUnlockButtonTitle = v27.PreviewUnlockButton:WaitForChild("Title")
	v27.PreviewUnlockViewContentsFrame = v27.PreviewUnlockContainer:WaitForChild("ViewContents")
	v27.PreviewUnlockViewContentsButton = v27.PreviewUnlockViewContentsFrame:WaitForChild("Button")
	v27.PreviewUnlockClaimFrame = v27.PreviewUnlockContainer:WaitForChild("Claim")
	v27.PreviewUnlockClaimButton = v27.PreviewUnlockClaimFrame:WaitForChild("Button")
	v27.BundlesFrame = v27.Container:WaitForChild("Bundles")
	v27.SeasonPassBundleFrame = v27.BundlesFrame:WaitForChild("seasonpass_bundle")
	v27.DeluxeSeasonPassBundleFrame = v27.BundlesFrame:WaitForChild("deluxeseasonpass_bundle")
	v27.EndingSoonFrame = v27.Container:WaitForChild("EndingSoon")
	v27.EndingSoonTitle = v27.EndingSoonFrame:WaitForChild("Title")
	v27.HidePartyDisplay = true
	v27.PromptSystem = v_u_16.new(v27.PromptsFrame)
	v27.SeasonPassBundleSlot = v_u_17.new("seasonpass_bundle")
	v27.DeluxeSeasonPassBundleSlot = v_u_17.new("deluxeseasonpass_bundle")
	v27._open_animation_disabled = true
	v27._current_page = 1
	v27._footer_slots = {}
	v27._track_slots = {}
	v27._xp_slots = {}
	v27._reward_slots = {}
	v27._preview_data = nil
	v27._scroll_delta = 0
	v27._refreshed_input_tags = false
	v27._completed_all_tasks_thread = nil
	v27:_Init()
	return v27
end
function v_u_24.InspectBundle(p28, p29) -- name: InspectBundle
	p28.PromptSystem:Open("InspectBundle", p29)
end
function v_u_24.UnlockNow(p30) -- name: UnlockNow
	-- upvalues: (copy) v_u_10
	if p30._preview_data then
		local v31 = p30:_GetUnlockNowProductInfo(p30._preview_data.Tier, p30._preview_data.PassTrackNum)
		if v31 then
			v_u_10:PromptProductPurchase(v31.ProductID)
		end
	end
end
function v_u_24.Preview(p32, p33, p34) -- name: Preview
	-- upvalues: (copy) v_u_7, (copy) v_u_14, (copy) v_u_3, (copy) v_u_23, (copy) v_u_8, (copy) v_u_11, (copy) v_u_18, (copy) v_u_9, (copy) v_u_6, (copy) v_u_10
	local v35 = v_u_7.CurrentSeason.BattlePassRewards[p33]
	if v35 then
		v35 = v_u_7.CurrentSeason.BattlePassRewards[p33][p34]
	end
	if p32._preview_data and p32._preview_data.RewardSlot then
		p32._preview_data.RewardSlot:Destroy()
		p32._preview_data.RewardSlot = nil
	end
	p32._preview_data = nil
	p32.PreviewDetailsTitle.Text = ""
	p32.PreviewDetailsDescription.Text = ""
	v_u_14:ClearStatusElements(p32.PreviewDetailsTitle)
	v_u_14:ClearStatusElements(p32.PreviewDetailsDescription)
	v_u_14:ClearStatusElements(p32.PreviewUnlockTiersText)
	v_u_3:Create(p32.BackgroundFrame, v_u_23, {
		["BackgroundColor3"] = (v_u_8.StatusByPassTrackNum[p34] or v_u_8.Statuses.Standard).Color
	}):Play()
	v_u_3:Create(p32.List, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
		["CanvasPosition"] = Vector2.zero
	}):Play()
	if v35 and (p33 and p34) then
		local v36 = task.defer
		local v37 = p32._SetPage
		local v38 = p33 / 7
		v36(v37, p32, (math.ceil(v38)))
		p32._preview_data = {
			["RewardData"] = nil,
			["Tier"] = nil,
			["PassTrackNum"] = nil,
			["RewardSlot"] = nil,
			["RewardData"] = v35,
			["Tier"] = p33,
			["PassTrackNum"] = p34
		}
		local v39 = v_u_11:Get("Seasons")[v_u_7.CurrentSeason.Name]
		if v39 then
			v39 = v39.BattlePass
		end
		local v40 = v39 and (v39.PassLevel or 0) or 0
		local v41 = v39 and (v39.MaxPassTrackNum or 0) or 0
		local v42
		if p33 <= v40 then
			v42 = p34 <= v41
		else
			v42 = false
		end
		local v43 = v39 and v39.RewardsClaimed[tostring(p33)]
		if v43 then
			v43 = v39.RewardsClaimed[tostring(p33)][tostring(p34)]
		end
		local v44 = p32:_GetUnlockNowProductInfo(p33, p34)
		local v45 = v_u_18.new(v35)
		v45:ZoomOutViewportFrame()
		v45:UseHighResolutionImage()
		v45:HideBackground()
		v45:HideWeaponVisual()
		v45:SetNameText("")
		v45:SetInteractable(false)
		v45.Frame.Parent = p32.PreviewRewardContainer
		p32._preview_data.RewardSlot = v45
		p32.PreviewDetailsClaimed.Visible = v43
		p32.PreviewDetailsTitle.Text = v45:GetRewardBubbleTitle()
		p32.PreviewDetailsDescription.Text = v45:GetRewardBubbleDescription()
		if v_u_8.Items[v35.Name] then
			local v46 = v_u_8.Items[v35.Name].Status
			v_u_14:ApplyItemStatusToText(p32.PreviewDetailsTitle, v46)
			v_u_14:ApplyItemStatusToText(p32.PreviewDetailsDescription, v46)
		elseif v_u_8.Items[v35.Weapon] then
			local v47 = v_u_14
			local v48 = p32.PreviewDetailsDescription
			local v49 = v_u_8.Items[v35.Weapon]
			if v49 then
				v49 = v_u_8.Items[v35.Weapon].Status
			end
			v47:ApplyItemStatusToText(v48, v49)
		end
		local v50 = p32.PreviewUnlockClaimFrame
		if v42 then
			v42 = not v43
		end
		v50.Visible = v42
		local v51 = p32.PreviewUnlockButtonFrame
		local v52
		if v44 then
			v52 = not v43
		else
			v52 = v44
		end
		v51.Visible = v52
		local v53 = p32.PreviewUnlockTiersText
		local v54
		if v44 and v44.BattlePassLevelIncrement then
			v54 = string.format("+%s Level%s", v_u_9:PrettyNumber(v44.BattlePassLevelIncrement), v44.BattlePassLevelIncrement == 1 and "" or "s")
		else
			v54 = not (v44 and (v44.BattlePassMaxPassTrackNum and v44.UnlockNowDisplayName)) and "" or v44.UnlockNowDisplayName
		end
		v53.Text = v54
		p32.PreviewUnlockTitleText.Visible = p32.PreviewUnlockTiersText.Text ~= ""
		local v55 = p32.PreviewUnlockViewContentsFrame
		local v56 = v_u_6.Rewards[v35.Name]
		if v56 then
			v56 = v_u_6.Rewards[v35.Name].Type == "Lootbox"
		end
		v55.Visible = v56
		if v44 then
			v_u_10:SetRobuxText(p32.PreviewUnlockButtonTitle, v44.ProductID, Enum.InfoType.Product)
			if v44.BattlePassMaxPassTrackNum and v44.UnlockNowWeaponStatusUIEffect then
				v_u_14:ApplyItemStatusToText(p32.PreviewUnlockTiersText, v44.UnlockNowWeaponStatusUIEffect)
			end
		end
		local v57 = v43 and 0.2 or 0
		p32.PreviewDetailsTitle.Position = UDim2.new(0.5 + v57, 0, 0.775, 0)
		p32.PreviewDetailsDescription.Position = UDim2.new(0.5 + v57, 0, 0.9, 0)
		v45.Frame.Position = UDim2.new(0.5, 0, 0.75, 0)
		p32.PreviewDetailsTitle:TweenPosition(UDim2.new(0.15 + v57, 0, 0.775, 0), "Out", "Quint", 0.5, true)
		p32.PreviewDetailsDescription:TweenPosition(UDim2.new(0.15 + v57, 0, 0.9, 0), "Out", "Quint", 0.625, true)
		v45.Frame:TweenPosition(UDim2.new(0.5, 0, 0.5, 0), "Out", "Quint", 0.375, true)
		p32.PreviewFrame.Visible = true
		p32.PreviewFrame:TweenSize(UDim2.new(1, 0, 0.3, 0), "Out", "Quint", 0.25, true)
	else
		p32.PreviewFrame.Visible = false
		p32.PreviewFrame.Size = UDim2.new(1, 0, 0, 0)
	end
end
function v_u_24.Open(p_u_58, ...) -- name: Open
	-- upvalues: (copy) v_u_19, (copy) v_u_11, (copy) v_u_2, (copy) v_u_7
	v_u_19.Open(p_u_58, ...)
	local v59 = p_u_58._open_connections
	local v60 = v_u_11:GetDataChangedSignal("Seasons")
	table.insert(v59, v60:Connect(function()
		-- upvalues: (copy) p_u_58
		p_u_58:_Update()
		if p_u_58._preview_data then
			p_u_58:Preview(p_u_58._preview_data.Tier, p_u_58._preview_data.PassTrackNum)
		end
	end))
	local v61 = p_u_58._open_connections
	local v62 = v_u_2.InputBegan
	table.insert(v61, v62:Connect(function(p63, p64)
		-- upvalues: (copy) p_u_58
		if p64 then
			return
		elseif p63.KeyCode == Enum.KeyCode.ButtonL1 then
			p_u_58:_SetPage(p_u_58._current_page - 1)
		elseif p63.KeyCode == Enum.KeyCode.ButtonR1 then
			p_u_58:_SetPage(p_u_58._current_page + 1)
		end
	end))
	local v65 = p_u_58._open_connections
	local v66 = v_u_2.InputChanged
	table.insert(v65, v66:Connect(function(_, _) end))
	local v67 = p_u_58._open_threads
	local v68 = task.spawn
	table.insert(v67, v68(function()
		-- upvalues: (copy) p_u_58
		while true do
			p_u_58:_UpdateEndingSoon()
			wait(1)
		end
	end))
	if not p_u_58._refreshed_input_tags then
		p_u_58._refreshed_input_tags = true
		for _, v69 in pairs({ p_u_58.NextButton, p_u_58.PreviousButton }) do
			local v70 = v69:WaitForChild("Inputs")
			v70.Parent = nil
			v70.Parent = v69
		end
	end
	p_u_58.SeasonPassBundleSlot.Frame.Position = UDim2.new(0.5, 0, 4, 0)
	p_u_58.DeluxeSeasonPassBundleSlot.Frame.Position = UDim2.new(0.5, 0, 4, 0)
	p_u_58.SeasonPassBundleSlot.Frame:TweenPosition(UDim2.new(0.5, 0, 0.5, 0), "Out", "Quint", 1, true)
	p_u_58.DeluxeSeasonPassBundleSlot.Frame:TweenPosition(UDim2.new(0.5, 0, 0.5, 0), "Out", "Quint", 1.5, true)
	local v71 = v_u_11:Get("Seasons")[v_u_7.CurrentSeason.Name]
	if v71 then
		v71 = v71.BattlePass
	end
	local v72 = (v71 and v71.PassLevel or 0) / 7
	local v73 = math.ceil(v72)
	p_u_58:Preview(nil)
	p_u_58:_SetPage(v73)
	p_u_58:_Update()
end
function v_u_24.Close(p74, ...) -- name: Close
	-- upvalues: (copy) v_u_19
	p74:_Clear()
	v_u_19.Close(p74, ...)
end
function v_u_24._UpdateEndingSoon(p75) -- name: _UpdateEndingSoon
	-- upvalues: (copy) v_u_13
	p75.EndingSoonFrame.Visible = v_u_13:GetTimeRemaining() ~= nil
	p75.EndingSoonTitle.Text = (v_u_13:GetCountdownText() or "") .. " \226\128\148 Complete the Season Pass and collect your rewards before they\'re gone forever!"
end
function v_u_24._UpdateVisuals(p76) -- name: _UpdateVisuals
	local v77 = p76.HeaderXPBarContainer.AbsolutePosition.X + p76.HeaderXPBarContainer.AbsoluteSize.X - p76.HeaderBubbleFrame.AbsolutePosition.X
	local v78 = math.abs(v77)
	local v79 = p76.HeaderBubbleFrame.AbsoluteSize.X / 2 - p76.HeaderBubbleArrow.AbsoluteSize.X - 8
	local v80 = math.min(v78, v79) * math.sign(v77)
	p76.HeaderBubbleArrow.Position = UDim2.new(0, v80, 1, -2)
	p76.HeaderBubbleBackground.Size = UDim2.new(0.05, p76.HeaderBubbleTitle.TextBounds.X, 1, 0)
	p76.List.CanvasSize = UDim2.new(0, 0, 0, p76.Layout.AbsoluteContentSize.Y)
	p76.FooterBackground.Size = UDim2.new(0, (p76.FooterSlotsLayout.AbsoluteContentSize.X + p76.FooterSlotsLayout.Padding.Scale * p76.FooterSlotsFrame.AbsoluteSize.X) * 1.00878, 1, 0)
end
function v_u_24._UpdateListVisibility(p81) -- name: _UpdateListVisibility
	p81.List.Visible = not p81.PromptSystem.CurrentPrompt
end
function v_u_24._GetUnlockNowProductInfo(_, p82, p83) -- name: _GetUnlockNowProductInfo
	-- upvalues: (copy) v_u_11, (copy) v_u_7, (copy) v_u_5
	local v84 = v_u_11:Get("Seasons")[v_u_7.CurrentSeason.Name]
	if v84 then
		v84 = v84.BattlePass
	end
	if (v84 and (v84.MaxPassTrackNum or 0) or 0) < p83 then
		return v_u_5.Bundles.seasonpass_bundle
	end
	local v85 = p82 - (v84 and v84.PassLevel or 0)
	if v85 > 0 then
		for _, v86 in pairs(v_u_5.BATTLE_PASS_LEVELS) do
			local v87 = v_u_5.Products[v86]
			if v85 > v87.BattlePassLevelIncrement then
				continue
			end
			return v87
		end
		return nil
	end
end
function v_u_24._GetMaxPage(_) -- name: _GetMaxPage
	-- upvalues: (copy) v_u_7
	local v88 = v_u_7.CurrentSeason.NumBattlePassTiers / 7
	return math.ceil(v88)
end
function v_u_24._SetPage(p89, p90) -- name: _SetPage
	local v91 = p89._current_page
	local v92 = p89:_GetMaxPage()
	p89._current_page = math.clamp(p90, 1, v92)
	if v91 ~= p89._current_page then
		local v93 = p89._current_page - v91
		local v94 = math.sign(v93)
		if v94 == 0 then
			v94 = nil
		end
		p89:_Update(v94)
	end
end
function v_u_24._Clear(p95) -- name: _Clear
	for _, v96 in pairs(p95._reward_slots) do
		v96:Destroy()
	end
	for _, v97 in pairs(p95._track_slots) do
		v97:Destroy()
	end
	for _, v98 in pairs(p95._footer_slots) do
		v98:Destroy()
	end
	for _, v99 in pairs(p95._xp_slots) do
		v99:Destroy()
	end
	p95._reward_slots = {}
	p95._track_slots = {}
	p95._footer_slots = {}
	p95._xp_slots = {}
	if p95._completed_all_tasks_thread then
		task.cancel(p95._completed_all_tasks_thread)
		p95._completed_all_tasks_thread = nil
	end
end
function v_u_24._Update(p_u_100, p101) -- name: _Update
	-- upvalues: (copy) v_u_7, (copy) v_u_22, (copy) v_u_8, (copy) v_u_11, (copy) v_u_20, (copy) v_u_21, (copy) v_u_18, (copy) v_u_6, (copy) v_u_9
	p_u_100:_Clear()
	for v102 = 1, v_u_7.CurrentSeason.NumBattlePassTracks do
		local v103 = v_u_22:Clone()
		v103.Side.Background.ImageColor3 = v_u_8.StatusByPassTrackNum[v102].PassColor
		v103.Side["Icon" .. v102].Visible = true
		v103.LayoutOrder = v102
		v103.Parent = p_u_100.TracksFrame
		p_u_100._track_slots[v102] = v103
	end
	local v104 = v_u_11:Get("Seasons")[v_u_7.CurrentSeason.Name]
	if v104 then
		v104 = v104.BattlePass
	end
	local v105 = v104 and (v104.PassLevel or 0) or 0
	local v106 = v104 and (v104.MaxPassTrackNum or 0) or 0
	p_u_100.HeaderLevelText.Text = v105
	p_u_100.HeaderNextLevelText.Text = "Level " .. v105 + 1
	local v107 = false
	for v108 = 1, 7 do
		local v_u_109 = (p_u_100._current_page - 1) * 7 + v108
		if v_u_7.CurrentSeason.NumBattlePassTiers < v_u_109 then
			continue
		end
		local v110 = v_u_109 <= v105
		local v111 = v_u_20:Clone()
		v111.Tier.Text = v_u_109
		v111.LayoutOrder = v108
		v111.Bar.BackgroundColor3 = v110 and Color3.fromRGB(100, 255, 50) or Color3.fromRGB(255, 255, 255)
		v111.Bar.BackgroundTransparency = v110 and 0 or 0.75
		v111.Parent = p_u_100.FooterSlotsFrame
		local v112 = p_u_100._footer_slots
		table.insert(v112, v111)
		for v_u_113 = 1, v_u_7.CurrentSeason.NumBattlePassTracks do
			local v114 = v_u_7.CurrentSeason.BattlePassRewards[v_u_109]
			if v114 then
				v114 = v_u_7.CurrentSeason.BattlePassRewards[v_u_109][v_u_113]
			end
			local v115 = v_u_8.StatusByPassTrackNum[v_u_113]
			local v116 = v104 and v104.RewardsClaimed[tostring(v_u_109)]
			if v116 then
				v116 = v104.RewardsClaimed[tostring(v_u_109)][tostring(v_u_113)]
			end
			local v117
			if v116 then
				v117 = v116
			elseif v110 then
				v117 = v_u_113 <= v106
			else
				v117 = v110
			end
			local v118 = v_u_21:Clone()
			v118.Container.Claimed.Visible = v117
			v118.Container.Unclaimed.Visible = not v117
			v118.Container.Unclaimed.Status.ImageColor3 = v115.PassColor
			v118.Container.Unclaimed.Background.ImageColor3 = v115.DarkPassColor
			v118.Container.Claimed.Status.ImageColor3 = v115.DarkPassColor
			v118.Container.Claimed.Claimed.Visible = v116 and v114
			v118.Container.Claimed.Background.ImageColor3 = v115.DarkPassColor
			v118.Container.Claimed.Container.GroupTransparency = v116 and 0.75 or 0
			local v119 = v118.Container.Claimed.ClaimNowBubble
			local v120
			if v114 then
				v120 = not v116
			else
				v120 = v114
			end
			v119.Visible = v120
			v118.LayoutOrder = v108
			v118.Parent = p_u_100._track_slots[v_u_113]
			if v114 then
				local v121 = v_u_18.new(v114)
				v121.Frame.Parent = v117 and v118.Container.Claimed.Container or v118.Container.Unclaimed.Container
				local v122 = p_u_100._reward_slots
				table.insert(v122, v121)
				v121:OnClick(function()
					-- upvalues: (copy) p_u_100, (copy) v_u_109, (copy) v_u_113
					p_u_100:Preview(v_u_109, v_u_113)
				end)
				local v123 = (v114.Quantity or 1) == 1
				local v124 = v_u_6.Cosmetics[v114.Name]
				local v125 = v_u_8.Items[v114.Name]
				local v126 = v_u_6.Rewards[v114.Name]
				if v126 then
					v126 = v_u_6.Rewards[v114.Name].Type == "Currency"
				end
				if v123 and not (v124 or (v125 or v126)) then
					v121:SetNameText("")
				end
			end
			if p101 then
				local v127 = (v108 + v_u_113 - 1) / 7
				if p101 < 0 then
					v127 = 1 - v127
				end
				v118.Container.Position = UDim2.new(0.5 + 0.5 * p101, 0, 0.5, 0)
				v118.Container:TweenPosition(UDim2.new(0.5, 0, 0.5, 0), "Out", "Quint", v127 * 0.5 + 0.25, true)
			end
			if v107 or (v_u_113 ~= 1 or not v114) then
				continue
			end
			v107 = true
		end
	end
	local v128 = v104 and (v104.NumPassTasksCompleted or 0) or 0
	local v_u_129 = v104 and v104.PassTaskProgress and (v104.PassTaskProgress.RoundsWon or 0) or 0
	local v_u_130 = v104 and (v104.PassTaskProgress and v104.PassTaskProgress.Playtime) or 0
	local v_u_131 = v_u_7:GetCurrentSeasonWeek() * v_u_7.CurrentSeason.BattlePassTasksPerWeek <= v128
	local v132 = v_u_129 / v_u_7.CurrentSeason.BattlePassTaskRequirements.RoundsWon
	local v133 = v_u_130 / v_u_7.CurrentSeason.BattlePassTaskRequirements.Playtime
	local v134 = math.max(v132, v133)
	p_u_100.HeaderXPBarContainer.Size = UDim2.new(math.clamp(v134, 0, 1), 0, 1, 0)
	local function v_u_140() -- name: update_bubble_title
		-- upvalues: (copy) v_u_131, (copy) p_u_100, (ref) v_u_9, (ref) v_u_7, (copy) v_u_130, (copy) v_u_129
		if v_u_131 then
			local v135 = p_u_100.HeaderBubbleTitle
			local v136 = string.format
			local v137 = v_u_9
			local v138 = v_u_7:GetTimeUntilNextSeasonWeek()
			v135.Text = v136("All done! You can level up again in <font transparency=\"0\" weight=\"800\">%s</font>", v137:TimeFormat2((math.ceil(v138))))
		else
			local v139 = string.format("%.1f", v_u_130 / 60)
			p_u_100.HeaderBubbleTitle.Text = string.format("Win (<font transparency=\"0\" weight=\"800\">%s</font> / %s) rounds in duels or play for (<font transparency=\"0\" weight=\"800\">%s</font> / %s) minutes to level up", v_u_129, v_u_7.CurrentSeason.BattlePassTaskRequirements.RoundsWon, v139 == "0.0" and "0" or v139, string.format("%.0f", v_u_7.CurrentSeason.BattlePassTaskRequirements.Playtime / 60))
		end
	end
	v_u_140()
	if v_u_131 then
		p_u_100._completed_all_tasks_thread = task.spawn(function()
			-- upvalues: (copy) v_u_140
			while true do
				wait(1)
				v_u_140()
			end
		end)
	end
	local v141 = p_u_100._current_page < p_u_100:_GetMaxPage()
	local v142 = p_u_100._current_page > 1
	p_u_100.NextBackground.BackgroundTransparency = v141 and 0 or 0.75
	p_u_100.NextIcon.ImageTransparency = v141 and 0 or 0.75
	p_u_100.PreviousBackground.BackgroundTransparency = v142 and 0 or 0.75
	p_u_100.PreviousIcon.ImageTransparency = v142 and 0 or 0.75
end
function v_u_24._Setup(p143) -- name: _Setup
	p143.SeasonPassBundleSlot:SetParent(p143.SeasonPassBundleFrame)
	p143.DeluxeSeasonPassBundleSlot:SetParent(p143.DeluxeSeasonPassBundleFrame)
end
function v_u_24._Init(p_u_144) -- name: _Init
	-- upvalues: (copy) v_u_1, (copy) v_u_12, (copy) v_u_15
	p_u_144.CloseButton.MouseButton1Click:Connect(function()
		-- upvalues: (copy) p_u_144
		p_u_144:CloseRequest()
	end)
	p_u_144.PromptSystem.PromptAdded:Connect(function()
		-- upvalues: (copy) p_u_144
		p_u_144:_UpdateListVisibility()
	end)
	p_u_144.PromptSystem.PromptRemoved:Connect(function()
		-- upvalues: (copy) p_u_144
		p_u_144:_UpdateListVisibility()
	end)
	p_u_144.NextButton.MouseButton1Click:Connect(function()
		-- upvalues: (copy) p_u_144
		p_u_144:_SetPage(p_u_144._current_page + 1)
	end)
	p_u_144.PreviousButton.MouseButton1Click:Connect(function()
		-- upvalues: (copy) p_u_144
		p_u_144:_SetPage(p_u_144._current_page - 1)
	end)
	p_u_144.Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		-- upvalues: (copy) p_u_144
		p_u_144:_UpdateVisuals()
	end)
	p_u_144.FooterSlotsLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		-- upvalues: (copy) p_u_144
		p_u_144:_UpdateVisuals()
	end)
	p_u_144.HeaderBubbleTitle:GetPropertyChangedSignal("TextBounds"):Connect(function()
		-- upvalues: (copy) p_u_144
		p_u_144:_UpdateVisuals()
	end)
	p_u_144.HeaderXPBarContainer:GetPropertyChangedSignal("AbsolutePosition"):Connect(function()
		-- upvalues: (copy) p_u_144
		p_u_144:_UpdateVisuals()
	end)
	p_u_144.HeaderXPBarContainer:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
		-- upvalues: (copy) p_u_144
		p_u_144:_UpdateVisuals()
	end)
	p_u_144.HeaderBubbleFrame:GetPropertyChangedSignal("AbsolutePosition"):Connect(function()
		-- upvalues: (copy) p_u_144
		p_u_144:_UpdateVisuals()
	end)
	p_u_144.HeaderBubbleFrame:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
		-- upvalues: (copy) p_u_144
		p_u_144:_UpdateVisuals()
	end)
	p_u_144.HeaderBubbleArrow:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
		-- upvalues: (copy) p_u_144
		p_u_144:_UpdateVisuals()
	end)
	p_u_144.PreviewUnlockClaimButton.MouseButton1Click:Connect(function()
		-- upvalues: (ref) v_u_1, (copy) p_u_144
		v_u_1.Remotes.Data.ClaimBattlePassReward:FireServer(p_u_144._preview_data.Tier, p_u_144._preview_data.PassTrackNum)
	end)
	p_u_144.PreviewUnlockButton.MouseButton1Click:Connect(function()
		-- upvalues: (copy) p_u_144
		p_u_144:UnlockNow()
	end)
	p_u_144.PreviewUnlockViewContentsButton.MouseButton1Click:Connect(function()
		-- upvalues: (copy) p_u_144
		p_u_144.PromptSystem:Open("InspectLootbox", p_u_144._preview_data.RewardData.Name, p_u_144._preview_data.RewardData.Weapon)
	end)
	p_u_144.SeasonPassBundleSlot.Tapped:Connect(function()
		-- upvalues: (ref) v_u_12, (copy) p_u_144
		if v_u_12.CurrentControls == "Touch" then
			p_u_144:InspectBundle(p_u_144.SeasonPassBundleSlot.Name)
		else
			p_u_144.SeasonPassBundleSlot:PurchaseRequest()
		end
	end)
	p_u_144.DeluxeSeasonPassBundleSlot.Tapped:Connect(function()
		-- upvalues: (ref) v_u_12, (copy) p_u_144
		if v_u_12.CurrentControls == "Touch" then
			p_u_144:InspectBundle(p_u_144.DeluxeSeasonPassBundleSlot.Name)
		else
			p_u_144.DeluxeSeasonPassBundleSlot:PurchaseRequest()
		end
	end)
	p_u_144:_Setup()
	p_u_144:_UpdateVisuals()
	v_u_15:Add(p_u_144.CloseButton)
	v_u_15:Add(p_u_144.NextButton)
	v_u_15:Add(p_u_144.PreviousButton)
	v_u_15:Add(p_u_144.PreviewUnlockButton)
	v_u_15:Add(p_u_144.PreviewUnlockClaimButton)
	v_u_15:Add(p_u_144.PreviewUnlockViewContentsButton)
end
return v_u_24._new()