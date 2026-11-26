local v_u_1 = game:GetService("ReplicatedStorage")
local v2 = game:GetService("Players")
local v_u_3 = require(v_u_1.Modules.CONSTANTS)
local v_u_4 = require(v_u_1.Modules.StatisticsLibrary)
local v_u_5 = require(v_u_1.Modules.SeasonLibrary)
local v_u_6 = require(v_u_1.Modules.DuelLibrary)
require(v_u_1.Modules.ItemLibrary)
local v_u_7 = require(v_u_1.Modules.Utility)
local v_u_8 = require(v2.LocalPlayer.PlayerScripts.Controllers:WaitForChild("ComplianceController"))
local v_u_9 = require(v2.LocalPlayer.PlayerScripts.Controllers:WaitForChild("QueuePadController"))
local v_u_10 = require(v2.LocalPlayer.PlayerScripts.Controllers:WaitForChild("FighterController"))
local v_u_11 = require(v2.LocalPlayer.PlayerScripts.Controllers:WaitForChild("SeasonController"))
local v_u_12 = require(v2.LocalPlayer.PlayerScripts.Controllers:WaitForChild("PartyController"))
local v_u_13 = require(v2.LocalPlayer.PlayerScripts.Modules:WaitForChild("WeaponStatusHandler"))
local v_u_14 = require(v2.LocalPlayer.PlayerScripts.Modules:WaitForChild("ButtonEffect"))
local v_u_15 = require(v2.LocalPlayer.PlayerScripts.Modules:WaitForChild("WeaponSlot"))
local v_u_16 = require(v2.LocalPlayer.PlayerScripts.Modules:WaitForChild("RankIcon"))
local v_u_17 = require(v2.LocalPlayer.PlayerScripts.Modules:WaitForChild("Page"))
local v_u_18 = setmetatable({}, v_u_17)
v_u_18.__index = v_u_18
function v_u_18._new() -- name: _new
	-- upvalues: (copy) v_u_17, (copy) v_u_18
	local v19 = v_u_17.new(script.Name)
	local v20 = v_u_18
	local v21 = setmetatable(v19, v20)
	v21.LoadingFrame = v21.PageFrame:WaitForChild("Loading")
	v21.DotsFrame = v21.LoadingFrame:WaitForChild("Dots")
	v21.ActiveFrame = v21.PageFrame:WaitForChild("Active")
	v21.PlayerFrame = v21.ActiveFrame:WaitForChild("Player")
	v21.MostPlayedWeaponsFrame = v21.PlayerFrame:WaitForChild("MostPlayedWeapons")
	v21.MostPlayedMap = v21.PlayerFrame:WaitForChild("MostPlayedMap")
	v21.DisplayNameText = v21.PlayerFrame:WaitForChild("DisplayName")
	v21.ControlsIcon = v21.DisplayNameText:WaitForChild("Controls")
	v21.UsernameText = v21.PlayerFrame:WaitForChild("Username")
	v21.HeadshotIcon = v21.PlayerFrame:WaitForChild("Headshot")
	v21.BraggingFrame = v21.PlayerFrame:WaitForChild("Bragging")
	v21.LevelImage = v21.BraggingFrame:WaitForChild("Level")
	v21.LevelText = v21.LevelImage:WaitForChild("Value")
	v21.StreakImage = v21.BraggingFrame:WaitForChild("Streak")
	v21.StreakText = v21.StreakImage:WaitForChild("Value")
	v21.RankFrame = v21.BraggingFrame:WaitForChild("Rank")
	v21.RankContainer = v21.RankFrame:WaitForChild("Container")
	v21.RankText = v21.RankFrame:WaitForChild("Title")
	v21.WinsButton = v21.PlayerFrame:WaitForChild("WinsButton")
	v21.WinsButtonCasualBackground = v21.WinsButton:WaitForChild("CasualBackground")
	v21.WinsButtonRankedBackground = v21.WinsButton:WaitForChild("RankedBackground")
	v21.CasualFrame = v21.PlayerFrame:WaitForChild("Casual")
	v21.CasualWinsText = v21.CasualFrame:WaitForChild("Wins")
	v21.CasualWinsTitle = v21.CasualFrame:WaitForChild("Wins")
	v21.CasualWinPercentText = v21.CasualFrame:WaitForChild("WinPercent")
	v21.RankedFrame = v21.PlayerFrame:WaitForChild("Ranked")
	v21.RankedWinsText = v21.RankedFrame:WaitForChild("Wins")
	v21.RankedWinsTitle = v21.RankedWinsText:WaitForChild("Title")
	v21.RankedWinPercentText = v21.RankedFrame:WaitForChild("WinPercent")
	v21.ButtonsFrame = v21.ActiveFrame:WaitForChild("Buttons")
	v21.CloseButton = v21.ButtonsFrame:WaitForChild("Close")
	v21.ChallengeButton = v21.ButtonsFrame:WaitForChild("Challenge")
	v21.ChallengeOnFrame = v21.ChallengeButton:WaitForChild("On")
	v21.ChallengeOffFrame = v21.ChallengeButton:WaitForChild("Off")
	v21.InviteButton = v21.ButtonsFrame:WaitForChild("Invite")
	v21.InviteOnFrame = v21.InviteButton:WaitForChild("On")
	v21.InviteOffFrame = v21.InviteButton:WaitForChild("Off")
	v21._fetch_hash = 0
	v21._weapon_slots = {}
	v21._last_player_object = nil
	v21._wins_tab_is_casual = nil
	v21._wins_tab_hash = 0
	v21._rank_icon = nil
	v21:_Init()
	return v21
end
function v_u_18.Fetch(p22, p23) -- name: Fetch
	-- upvalues: (copy) v_u_13, (copy) v_u_1, (copy) v_u_10, (copy) v_u_5, (copy) v_u_6, (copy) v_u_3, (copy) v_u_7, (copy) v_u_8, (copy) v_u_4, (copy) v_u_9, (copy) v_u_12, (copy) v_u_16, (copy) v_u_15
	p22._last_player_object = p23
	p22._fetch_hash = p22._fetch_hash + 1
	local v24 = p22._fetch_hash
	p22.DotsFrame:AddTag("UILoadingDots")
	p22.LoadingFrame.Visible = true
	p22.ActiveFrame.Visible = false
	for _, v25 in pairs(p22._weapon_slots) do
		v25:Destroy()
	end
	p22._weapon_slots = {}
	if p22._rank_icon then
		p22._rank_icon:Destroy()
		p22._rank_icon = nil
	end
	v_u_13:ClearStatusElements(p22.DisplayNameText)
	local v26 = v_u_1.Remotes.Misc.RequestProfile:InvokeServer(p22._last_player_object)
	wait(0.25)
	if v24 == p22._fetch_hash then
		if v26 then
			local v27 = v_u_10:GetFighter(p22._last_player_object)
			local v28 = v_u_5:GetHighestELOLeaderboardRanking(v26.RankedCurrentELO, p22._last_player_object.UserId)
			local v29 = v_u_5:GetRank(v26.RankedCurrentELO, p22._last_player_object.UserId)
			local v30 = p22._last_player_object:GetAttribute("StatisticDuelsWinStreak")
			p22.DotsFrame:RemoveTag("UILoadingDots")
			p22.LoadingFrame.Visible = false
			p22.ActiveFrame.Visible = true
			p22.MostPlayedMap.Image = v26.FavoriteMap and v_u_6.Maps[v26.FavoriteMap] and (v_u_6.Maps[v26.FavoriteMap].Image or "") or ""
			p22.UsernameText.Text = "@" .. p22._last_player_object.Name
			local v31 = p22.ControlsIcon
			local v32 = v_u_3.CONTROLS_IMAGES
			if v27 then
				v27 = v27:Get("Controls")
			end
			v31.Image = v32[v27] or ""
			p22.HeadshotIcon.Image = string.format(v_u_3.HEADSHOT_IMAGE, p22._last_player_object.UserId)
			local v33 = p22.StreakImage
			local v34
			if v30 then
				v34 = v30 > 0
			else
				v34 = v30
			end
			v33.Visible = v34
			p22.StreakText.Text = v_u_7:PrettyNumber(v30 or 0)
			p22.DisplayNameText.Text = v_u_8:GetName(p22._last_player_object)
			local v35 = p22.RankText
			if v28 and v28 <= v_u_5.CurrentSeason.TopPlayerLeaderboardRank then
				v29 = "#" .. v28
			end
			v35.Text = v29
			p22.CasualWinsTitle.Text = v26.CasualWins and v26.CasualWins ~= 1 and "wins" or "win"
			p22.CasualWinsText.Text = v_u_4.Info.StatisticDuelsWon.TostringFunction(v26.CasualWins)
			p22.CasualWinPercentText.Text = v_u_4.Info.StatisticDuelsWinPercent.TostringFunction(v26.CasualWinPercent)
			p22.RankedWinsTitle.Text = v26.RankedWins and v26.RankedWins ~= 1 and "wins" or "win"
			p22.RankedWinsText.Text = v_u_4.Info.StatisticRankedDuelsWon.TostringFunction(v26.RankedWins)
			p22.RankedWinPercentText.Text = v_u_4.Info.StatisticRankedDuelsWinPercent.TostringFunction(v26.RankedWinPercent)
			p22.LevelText.Text = v_u_7:PrettyNumber(v26.Level)
			p22.ChallengeButton.Visible = v_u_9:CanChallenge(p22._last_player_object)
			p22.InviteButton.Visible = v_u_12:CanInvitePlayerToParty(p22._last_player_object)
			v_u_13:ApplyItemStatusToText(p22.DisplayNameText, p22._last_player_object:GetAttribute("PlayerStatus"))
			p22._rank_icon = v_u_16.new(v26.RankedCurrentELO, p22._last_player_object.UserId)
			p22._rank_icon:SetParent(p22.RankContainer)
			for v36, v37 in pairs(v26.FavoriteWeapons) do
				local v38 = v_u_15.new(v37.Name, v37)
				v38.Frame.LayoutOrder = v36
				v38.Frame.Parent = p22.MostPlayedWeaponsFrame
				local v39 = p22._weapon_slots
				table.insert(v39, v38)
				v38:DisableButton()
			end
			p22:_UpdateCooldowns()
			p22:_UpdateTextBounds()
		else
			p22:CloseRequest()
		end
	else
		return
	end
end
function v_u_18.SwitchWinsTab(p40, p41) -- name: SwitchWinsTab
	-- upvalues: (copy) v_u_11
	local v42 = v_u_11:IsRankedUnlocked()
	p40.WinsButton.Visible = v42
	p40.RankFrame.Visible = v42
	p40._wins_tab_is_casual = p41 or not v42
	p40.WinsButtonCasualBackground.BackgroundTransparency = p40._wins_tab_is_casual and 0 or 0.75
	p40.CasualFrame.Visible = p40._wins_tab_is_casual
	p40.WinsButtonRankedBackground.BackgroundTransparency = p40._wins_tab_is_casual and 0.75 or 0
	p40.RankedFrame.Visible = not p40._wins_tab_is_casual
end
function v_u_18.Open(p43, ...) -- name: Open
	-- upvalues: (copy) v_u_17
	v_u_17.Open(p43, ...)
	p43:SwitchWinsTab(true)
	task.spawn(p43._SwitchWinsTabLoop, p43)
end
function v_u_18.Close(p44, ...) -- name: Close
	-- upvalues: (copy) v_u_17
	p44._wins_tab_hash = p44._wins_tab_hash + 1
	v_u_17.Close(p44, ...)
end
function v_u_18._UpdateCooldowns(p45) -- name: _UpdateCooldowns
	-- upvalues: (copy) v_u_9, (copy) v_u_12
	local v46 = p45._last_player_object
	local v47 = p45.ChallengeOnFrame
	local v48
	if v46 then
		v48 = not v_u_9:IsChallengeRequestOnCooldown(v46)
	else
		v48 = v46
	end
	v47.Visible = v48
	p45.ChallengeOffFrame.Visible = not p45.ChallengeOnFrame.Visible
	local v49 = p45.InviteOnFrame
	if v46 then
		v46 = not v_u_12:IsInviteRequestOnCooldown(v46)
	end
	v49.Visible = v46
	p45.InviteOffFrame.Visible = not p45.InviteOnFrame.Visible
end
function v_u_18._SwitchWinsTabLoop(p50) -- name: _SwitchWinsTabLoop
	p50._wins_tab_hash = p50._wins_tab_hash + 1
	local v51 = p50._wins_tab_hash
	while true do
		wait(5)
		if v51 ~= p50._wins_tab_hash then
			break
		end
		if not p50.WinsButton.Visible then
			continue
		end
		p50:SwitchWinsTab(not p50._wins_tab_is_casual)
	end
end
function v_u_18._UpdateTextBounds(p52) -- name: _UpdateTextBounds
	p52.ControlsIcon.Position = UDim2.new(0, p52.DisplayNameText.TextBounds.X, 0.5, 0)
end
function v_u_18._Init(p_u_53) -- name: _Init
	-- upvalues: (copy) v_u_9, (copy) v_u_12, (copy) v_u_14
	p_u_53.CloseButton.MouseButton1Click:Connect(function()
		-- upvalues: (copy) p_u_53
		p_u_53:CloseRequest()
	end)
	p_u_53.ChallengeButton.MouseButton1Click:Connect(function()
		-- upvalues: (ref) v_u_9, (copy) p_u_53
		v_u_9:SendChallengeRequest(p_u_53._last_player_object)
	end)
	p_u_53.InviteButton.MouseButton1Click:Connect(function()
		-- upvalues: (ref) v_u_12, (copy) p_u_53
		v_u_12:SendPartyInvite(p_u_53._last_player_object)
	end)
	p_u_53.DisplayNameText:GetPropertyChangedSignal("TextBounds"):Connect(function()
		-- upvalues: (copy) p_u_53
		p_u_53:_UpdateTextBounds()
	end)
	p_u_53.WinsButton.MouseButton1Click:Connect(function()
		-- upvalues: (copy) p_u_53
		local v54 = p_u_53
		v54._wins_tab_hash = v54._wins_tab_hash + 1
		p_u_53:SwitchWinsTab(not p_u_53._wins_tab_is_casual)
	end)
	v_u_9.ChallengeRequestCooldownChanged:Connect(function()
		-- upvalues: (copy) p_u_53
		p_u_53:_UpdateCooldowns()
	end)
	v_u_12.InviteRequestCooldownChanged:Connect(function()
		-- upvalues: (copy) p_u_53
		p_u_53:_UpdateCooldowns()
	end)
	p_u_53:_UpdateCooldowns()
	p_u_53:_UpdateTextBounds()
	p_u_53:SwitchWinsTab(true)
	v_u_14:Add(p_u_53.CloseButton)
	v_u_14:Add(p_u_53.ChallengeButton)
	v_u_14:Add(p_u_53.InviteButton)
	v_u_14:Add(p_u_53.WinsButton)
end
return v_u_18._new()