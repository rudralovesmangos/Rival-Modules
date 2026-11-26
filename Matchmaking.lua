local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("TweenService")
local v_u_3 = game:GetService("Players")
local v_u_4 = require(v1.Modules.CONSTANTS)
local v_u_5 = require(v1.Modules.RotatingQueueLibrary)
require(v1.Modules.CosmeticLibrary)
local v_u_6 = require(v1.Modules.SeasonLibrary)
local v_u_7 = require(v1.Modules.EventLibrary)
local v_u_8 = require(v1.Modules.DuelLibrary)
local v_u_9 = require(v1.Modules.Utility)
local v_u_10 = require(v_u_3.LocalPlayer.PlayerScripts.Controllers:WaitForChild("LeaderboardController"))
local v_u_11 = require(v_u_3.LocalPlayer.PlayerScripts.Controllers:WaitForChild("PlayerDataController"))
local v_u_12 = require(v_u_3.LocalPlayer.PlayerScripts.Controllers:WaitForChild("ArcadeController"))
local v_u_13 = require(v_u_3.LocalPlayer.PlayerScripts.Controllers:WaitForChild("SeasonController"))
local v_u_14 = require(v_u_3.LocalPlayer.PlayerScripts.Modules:WaitForChild("BaseMatchmakingQueueSlot"):WaitForChild("MatchmakingQueueSlot"))
local v_u_15 = require(v_u_3.LocalPlayer.PlayerScripts.Modules:WaitForChild("BaseMatchmakingQueueSlot"))
local v_u_16 = require(v_u_3.LocalPlayer.PlayerScripts.Modules:WaitForChild("ButtonEffect"))
local v_u_17 = require(v_u_3.LocalPlayer.PlayerScripts.Modules:WaitForChild("PromptSystem"))
local v_u_18 = require(v_u_3.LocalPlayer.PlayerScripts.Modules:WaitForChild("RewardSlot"))
local v_u_19 = require(v_u_3.LocalPlayer.PlayerScripts.Modules:WaitForChild("RankIcon"))
local v_u_20 = require(v_u_3.LocalPlayer.PlayerScripts.Modules:WaitForChild("Page"))
v_u_3.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("MatchmakingQueueSlot")
local v_u_21 = setmetatable({}, v_u_20)
v_u_21.__index = v_u_21
function v_u_21._new() -- name: _new
	-- upvalues: (copy) v_u_20, (copy) v_u_21, (copy) v_u_17, (copy) v_u_15
	local v22 = v_u_20.new(script.Name)
	local v23 = v_u_21
	local v24 = setmetatable(v22, v23)
	v24.PromptsFrame = v24.PageFrame:WaitForChild("Prompts")
	v24.PageContainer = v24.PageFrame:WaitForChild("Container")
	v24.CloseButton = v24.PageContainer:WaitForChild("Close")
	v24.List = v24.PageContainer:WaitForChild("List")
	v24.Container = v24.List:WaitForChild("Container")
	v24.Layout = v24.Container:WaitForChild("Layout")
	v24.CenterDuelsFrame = v24.Container:WaitForChild("CenterDuels")
	v24.DuelsFrame = v24.Container:WaitForChild("Duels")
	v24.DuelsContainer = v24.DuelsFrame:WaitForChild("Container")
	v24.DuelsContainerCloseButton = v24.DuelsContainer:WaitForChild("Close")
	v24.QueuesFrame = v24.DuelsContainer:WaitForChild("Queues")
	v24.RankedFrame = v24.DuelsContainer:WaitForChild("Ranked")
	v24.RankedButton = v24.RankedFrame:WaitForChild("Button")
	v24.RankedThumbnail = v24.RankedButton:WaitForChild("Thumbnail")
	v24.RankedLockedFrame = v24.RankedButton:WaitForChild("Locked")
	v24.RankedLockedText = v24.RankedLockedFrame:WaitForChild("Description")
	v24.RankedUnlockedFrame = v24.RankedButton:WaitForChild("Unlocked")
	v24.RankedIconContainer = v24.RankedUnlockedFrame:WaitForChild("IconContainer")
	v24.RankedSeasonText = v24.RankedUnlockedFrame:WaitForChild("Season")
	v24.RankedRankText = v24.RankedUnlockedFrame:WaitForChild("Rank")
	v24.RankedELOText = v24.RankedUnlockedFrame:WaitForChild("ELO")
	v24.AprilFoolsFrame = v24.Container:WaitForChild("AprilFools")
	v24.AprilFoolsContainer = v24.AprilFoolsFrame:WaitForChild("Container")
	v24.AprilFoolsSlotsFrame = v24.AprilFoolsContainer:WaitForChild("Slots")
	v24.AprilFoolsSlotsLayout = v24.AprilFoolsSlotsFrame:WaitForChild("Layout")
	v24.ArcadeServersFrame = v24.Container:WaitForChild("ArcadeServers")
	v24.ArcadeServersContainer = v24.ArcadeServersFrame:WaitForChild("Container")
	v24.ArcadeServersHeaderInfoButton = v24.ArcadeServersContainer:WaitForChild("Header"):WaitForChild("Info")
	v24.ArcadeServersHeaderInfoBubble = v24.ArcadeServersHeaderInfoButton:WaitForChild("Bubble")
	v24.ArcadeServersHeaderInfoBubbleTitle = v24.ArcadeServersHeaderInfoBubble:WaitForChild("Title")
	v24.ArcadeServersHeaderInfoBubbleBackground = v24.ArcadeServersHeaderInfoBubble:WaitForChild("Background")
	v24.RotatingFrame = v24.Container:WaitForChild("Rotating")
	v24.RotatingContainer = v24.RotatingFrame:WaitForChild("Container")
	v24.RotatingHeaderFrame = v24.RotatingContainer:WaitForChild("Header")
	v24.RotatingHeaderTitle = v24.RotatingHeaderFrame:WaitForChild("Title")
	v24.RotatingHeaderNewReleaseFrame = v24.RotatingHeaderFrame:WaitForChild("NewRelease")
	v24.RotatingHeaderNewReleaseTitle = v24.RotatingHeaderNewReleaseFrame:WaitForChild("Title")
	v24.RotatingHeaderNewReleaseBackground = v24.RotatingHeaderNewReleaseFrame:WaitForChild("Background")
	v24.RotatingSlotsFrame = v24.RotatingContainer:WaitForChild("Slots")
	v24.RotatingSlotsLayout = v24.RotatingSlotsFrame:WaitForChild("Layout")
	v24.EventFrame = v24.Container:WaitForChild("Event")
	v24.EventContainer = v24.EventFrame:WaitForChild("Container")
	v24.EventHeaderFrame = v24.EventContainer:WaitForChild("Header")
	v24.EventHeaderIcon = v24.EventHeaderFrame:WaitForChild("Icon")
	v24.EventRewardsFrame = v24.EventHeaderFrame:WaitForChild("Rewards")
	v24.EventSlotsFrame = v24.EventContainer:WaitForChild("Slots")
	v24.EventSlotsLayout = v24.EventSlotsFrame:WaitForChild("Layout")
	v24.PromptSystem = v_u_17.new(v24.PromptsFrame)
	v24.RankedSlot = v_u_15.new(v24.RankedFrame)
	v24._matchmaking_queue_slots = {}
	v24._rotating_matchmaking_queue_slots = {}
	v24._rotating_batch_containers = {}
	v24._rank_icon = nil
	v24:_Init()
	return v24
end
function v_u_21.ScrollTo(p_u_25, p26, p27) -- name: ScrollTo
	-- upvalues: (copy) v_u_2
	local v_u_28
	if p26 == "Arcade" then
		v_u_28 = p_u_25.ArcadeServersFrame
	elseif p26 == "Rotating" then
		v_u_28 = p_u_25.RotatingFrame
	elseif p26 == "Event" then
		v_u_28 = p_u_25.EventFrame
	else
		v_u_28 = nil
	end
	if v_u_28 then
		task.delay(p27 or 0, function()
			-- upvalues: (ref) v_u_2, (copy) p_u_25, (copy) v_u_28
			v_u_2:Create(p_u_25.List, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
				["CanvasPosition"] = Vector2.new(0, v_u_28.AbsolutePosition.Y - p_u_25.Container.AbsolutePosition.Y)
			}):Play()
		end)
	end
end
function v_u_21.Open(p29, ...) -- name: Open
	-- upvalues: (copy) v_u_20
	v_u_20.Open(p29, ...)
	p29.List.CanvasPosition = Vector2.zero
	task.defer(p29._GenerateRotatingLoop, p29)
	p29:_UpdateLocked()
end
function v_u_21._UpdateLayouts(p30) -- name: _UpdateLayouts
	p30.RotatingFrame.Size = UDim2.new(1, 0, 0.1, p30.RotatingSlotsLayout.AbsoluteContentSize.Y)
	p30.EventFrame.Size = UDim2.new(1, 0, 0.11, p30.EventSlotsLayout.AbsoluteContentSize.Y)
	p30.AprilFoolsFrame.Size = UDim2.new(1, 0, 0.1, p30.AprilFoolsSlotsLayout.AbsoluteContentSize.Y)
	p30.ArcadeServersHeaderInfoBubbleBackground.Size = UDim2.new(0.04, p30.ArcadeServersHeaderInfoBubbleTitle.TextBounds.X, 1, 0)
	p30.RotatingHeaderNewReleaseBackground.Size = UDim2.new(0.125, p30.RotatingHeaderNewReleaseTitle.TextBounds.X, 1, 0)
end
function v_u_21._UpdateArcadeServerHeaderInfo(p31) -- name: _UpdateArcadeServerHeaderInfo
	p31.ArcadeServersHeaderInfoButton.Visible = true
end
function v_u_21._UpdateLocked(p32) -- name: _UpdateLocked
	-- upvalues: (copy) v_u_13, (copy) v_u_11, (copy) v_u_6
	local v33 = not v_u_13:IsRankedUnlocked()
	if v33 then
		v33 = v_u_11:Get("Level") < v_u_6.CurrentSeason.LevelRequirement
	end
	p32.RankedLockedFrame.Visible = v33
	p32.RankedUnlockedFrame.Visible = not v33
end
function v_u_21._UpdateELO(p34) -- name: _UpdateELO
	-- upvalues: (copy) v_u_6, (copy) v_u_11, (copy) v_u_3, (copy) v_u_9, (copy) v_u_19
	if p34._rank_icon then
		p34._rank_icon:Destroy()
		p34._rank_icon = nil
	end
	local _ = v_u_6.CurrentSeason.RankProfile
	local v35 = v_u_11:Get("Seasons")[v_u_6.CurrentSeason.Name]
	if v35 then
		v35 = v35.RankedPerformances[v_u_6.UNIVERSAL_ELO_NAME]
	end
	if v35 then
		local v36 = v_u_6:GetRank(v35.CurrentELO, v_u_3.LocalPlayer.UserId)
		p34.RankedRankText.Text = v36
		local v37 = p34.RankedELOText
		local v38
		if v35.CurrentELO then
			v38 = v_u_9:PrettyNumber(v35.CurrentELO) .. " ELO"
		else
			v38 = v35.DuelsPlayed .. " / " .. v_u_6.CurrentSeason.RankProfile.NumPlacementDuels
		end
		v37.Text = v38
		if v35.CurrentELO then
			p34._rank_icon = v_u_19.new(v35.CurrentELO, v_u_3.LocalPlayer.UserId)
			p34._rank_icon:SetParent(p34.RankedIconContainer)
		end
	end
end
function v_u_21._UpdateList(p39) -- name: _UpdateList
	p39.CloseButton.Position = UDim2.new(0.975, 0, 0.0225, p39.PageFrame.AbsoluteSize.Y * 0.125)
	p39.List.Position = UDim2.new(0.5, 9, 0, p39.PageFrame.AbsoluteSize.Y * 0.125)
	p39.List.Size = UDim2.new(0.85, 0, 0, p39.PageFrame.AbsoluteSize.Y * 0.75)
	p39.List.CanvasSize = UDim2.new(0, 0, 0, p39.Layout.AbsoluteContentSize.Y)
end
function v_u_21._UpdateOnboarding(p40) -- name: _UpdateOnboarding
	-- upvalues: (copy) v_u_11, (copy) v_u_9, (copy) v_u_8
	local v41 = v_u_11:GetStatistic("StatisticDuelsPlayed")
	p40.RotatingFrame.Visible = v41 >= 3
	p40.ArcadeServersFrame.Visible = v41 >= 4
	local v42 = p40.AprilFoolsFrame
	local v43 = v41 >= 10 and (v_u_9:IsAprilFoolsGamemodesEnabled() and v_u_8.APRIL_FOOLS_QUEUES)
	if v43 then
		v43 = #v_u_8.APRIL_FOOLS_QUEUES > 0
	end
	v42.Visible = v43
	p40.CenterDuelsFrame.Visible = v41 < 3
	p40.DuelsContainerCloseButton.Visible = p40.CenterDuelsFrame.Visible
	p40.CloseButton.Visible = not p40.CenterDuelsFrame.Visible
end
function v_u_21._UpdateBeginnerQueue(p44) -- name: _UpdateBeginnerQueue
	-- upvalues: (copy) v_u_4, (copy) v_u_11
	local v45 = p44._matchmaking_queue_slots[v_u_4.BEGINNER_QUEUE_NAME]
	if v45 then
		local v46 = v_u_11:GetStatistic("StatisticDuelsWon") < v_u_4.BEGINNER_QUEUE_WINS
		v45.Frame.Visible = v46
		p44.RankedFrame.Visible = not v46
		p44.QueuesFrame.Position = not v46 and UDim2.new(0.7, 0, 0.2, 0) or UDim2.new(1, 0, 0.2, 0)
	else
		p44.RankedFrame.Visible = true
	end
end
function v_u_21._RespondToQueueStatus(p47, p48) -- name: _RespondToQueueStatus
	if p48 == "Success" then
		p47.Closed:Fire()
	else
		p47.PromptSystem:Open("ErrorMessage", "Whoops!", p48 or "Server failed to respond, please try again")
	end
end
function v_u_21._GenerateQueues(p_u_49, p50, p51, p52, p53, p54, p55) -- name: _GenerateQueues
	-- upvalues: (copy) v_u_14
	if p52 then
		for _, v56 in pairs(p52) do
			v56:Destroy()
		end
		table.clear(p52)
	end
	local v57 = p54 and 1 or 2
	local v58 = #p51 / v57
	local v59 = p52 or {}
	for v60 = 1, math.ceil(v58) do
		local v61 = Instance.new("Frame")
		v61.AnchorPoint = Vector2.new(0.5, 0.5)
		v61.Size = UDim2.new(1, 0, 1, 0)
		v61.BackgroundTransparency = 1
		v61.Parent = p50
		table.insert(v59, v61)
		local v62 = Instance.new("UIListLayout")
		v62.Padding = UDim.new(0.005, 0)
		v62.HorizontalAlignment = Enum.HorizontalAlignment.Center
		v62.FillDirection = Enum.FillDirection.Horizontal
		v62.VerticalAlignment = Enum.VerticalAlignment.Top
		v62.Parent = v61
		local v63 = p51[v57 * (v60 - 1) + 1 + 1] and v57 and v57 or 1
		for v64 = 1, v63 do
			local v65 = p51[v57 * (v60 - 1) + v64]
			local v66
			if p55 then
				if v64 == 1 then
					v66 = 1 - p55
				else
					v66 = p55
				end
			else
				v66 = 1 / v63
			end
			local v67 = Instance.new("Frame")
			v67.AnchorPoint = Vector2.new(0.5, 0.5)
			v67.Size = UDim2.new(v66 - v62.Padding.Scale * v66 * (v63 - 1), 0, (p54 or (v60 <= 1 or v63 ~= 1)) and 1 or 0.75, 0)
			v67.BackgroundTransparency = 1
			v67.Parent = v61
			local v68 = v_u_14.new(v65, v67)
			v68.QueueStatus:Connect(function(p69)
				-- upvalues: (copy) p_u_49
				p_u_49:_RespondToQueueStatus(p69)
			end)
			p_u_49._matchmaking_queue_slots[v65] = v68
			if not p53 then
				continue
			end
			p53(v65, v67, v68)
		end
	end
end
function v_u_21._GenerateRotating(p_u_70) -- name: _GenerateRotating
	-- upvalues: (copy) v_u_5
	for _, v71 in pairs(p_u_70._rotating_matchmaking_queue_slots) do
		v71.Container:Destroy()
		v71.MatchmakingQueueSlot:Destroy()
	end
	p_u_70:_GenerateQueues(p_u_70.RotatingSlotsFrame, v_u_5:GetCurrent().QueueNames, p_u_70._rotating_batch_containers, function(p72, p73, p74) -- name: callback
		-- upvalues: (copy) p_u_70
		p_u_70._rotating_matchmaking_queue_slots[p72] = {
			["Container"] = p73,
			["MatchmakingQueueSlot"] = p74
		}
	end)
end
function v_u_21._GenerateRotatingLoop(p75) -- name: _GenerateRotatingLoop
	-- upvalues: (copy) v_u_5, (copy) v_u_9
	local v76 = p75._is_open_hash
	local v77 = nil
	while p75._is_open and v76 == p75._is_open_hash do
		local v78 = v_u_5:GetPremierInfo()
		local v79 = p75.RotatingHeaderTitle
		local v80 = v_u_9
		local v81 = v_u_5:GetTimeUntilNext()
		v79.Text = "New gamemodes in " .. v80:TimeFormat2((math.ceil(v81)))
		p75.RotatingHeaderNewReleaseFrame.Visible = v78 ~= nil
		p75.RotatingHeaderNewReleaseTitle.Text = v78 and (v78.Title or "") or ""
		local v82 = v78 or v_u_5:GetCycle()
		if v82 == v77 then
			v82 = v77
		else
			p75:_GenerateRotating()
		end
		wait(1)
		v77 = v82
	end
end
function v_u_21._GenerateQueueSlot(p_u_83, p84) -- name: _GenerateQueueSlot
	-- upvalues: (copy) v_u_9, (copy) v_u_14, (copy) v_u_4
	local v85 = v_u_9:WaitForChildRecursive(p_u_83.Container, p84, 2)
	if v85 then
		local v86 = v_u_14.new(p84, v85)
		v86.QueueStatus:Connect(function(p87)
			-- upvalues: (copy) p_u_83
			p_u_83:_RespondToQueueStatus(p87)
		end)
		p_u_83._matchmaking_queue_slots[p84] = v86
		if p84 == v_u_4.BEGINNER_QUEUE_NAME then
			p_u_83:_UpdateBeginnerQueue()
		end
	end
end
function v_u_21._Setup(p88) -- name: _Setup
	-- upvalues: (copy) v_u_6, (copy) v_u_7, (copy) v_u_4, (copy) v_u_8, (copy) v_u_18, (copy) v_u_15, (copy) v_u_12
	p88.RankedLockedText.Text = "Unlocked at\nLevel " .. v_u_6.CurrentSeason.LevelRequirement
	p88.RankedSeasonText.Text = "Season " .. v_u_6.CurrentSeason.Version
	p88.RankedThumbnail.Image = v_u_6.CurrentSeason.ThumbnailRankedCoverPhoto
	p88.EventHeaderIcon.Image = v_u_7.EVENT_DETAILS and v_u_7.EVENT_DETAILS.LTM_HEADER_ICON or p88.EventHeaderIcon.Image
	p88.ArcadeServersHeaderInfoBubbleTitle.Text = string.format("You must be Level %s+ to earn XP from Arcade Servers\nThis includes Career XP, Weapon XP, & Task progress", v_u_4.LEVEL_REQUIRED_FOR_REWARDS_FROM_ARCADE_SERVERS)
	for _, v89 in pairs(v_u_8.MatchmakingQueueOrder) do
		task.defer(p88._GenerateQueueSlot, p88, v89)
	end
	if v_u_8.APRIL_FOOLS_QUEUES and #v_u_8.APRIL_FOOLS_QUEUES > 0 then
		p88:_GenerateQueues(p88.AprilFoolsSlotsFrame, v_u_8.APRIL_FOOLS_QUEUES)
	end
	local v90 = p88.EventFrame
	local v91 = v_u_7.IS_ACTIVE and v_u_7.LTM_QUEUENAMES
	if v91 then
		v91 = #v_u_7.LTM_QUEUENAMES > 0
	end
	v90.Visible = v91
	local v92 = p88.EventRewardsFrame
	local v93 = v_u_7.LTM_QUEUES_REWARDS_DISPLAYED
	if v93 then
		v93 = #v_u_7.LTM_QUEUES_REWARDS_DISPLAYED > 0
	end
	v92.Visible = v93
	if p88.EventFrame.Visible then
		p88:_GenerateQueues(p88.EventSlotsFrame, v_u_7.LTM_QUEUENAMES, nil, nil, v_u_7.LTM_QUEUES_SMART_TILING_DISABLED, v_u_7.LTM_QUEUES_SMART_TILING_X_SIZE_MULTIPLIER)
		for _, v94 in pairs(v_u_7.LTM_QUEUES_REWARDS_DISPLAYED) do
			local v95 = v_u_18.new({
				["Name"] = v94
			})
			v95:EnableOwnedLogic(true)
			v95:SetParent(p88.EventRewardsFrame)
		end
	end
	for _, v_u_96 in pairs(v_u_8.ArcadeModeOrder) do
		local v97 = v_u_8.ArcadeModes[v_u_96]
		local v98 = p88.ArcadeServersContainer:WaitForChild(v_u_96)
		v98:WaitForChild("Button"):WaitForChild("Title").Text = v97.DisplayName
		v98:WaitForChild("Button"):WaitForChild("Description").Text = v97.Description
		v98:WaitForChild("Button"):WaitForChild("Thumbnail").Image = v97.Thumbnail
		v_u_15.new(v98).Clicked:Connect(function()
			-- upvalues: (ref) v_u_12, (copy) v_u_96
			v_u_12:ToArcadeServer(v_u_96)
		end)
	end
end
function v_u_21._Init(p_u_99) -- name: _Init
	-- upvalues: (copy) v_u_9, (copy) v_u_11, (copy) v_u_10, (copy) v_u_16
	p_u_99.CloseButton.MouseButton1Click:Connect(function()
		-- upvalues: (copy) p_u_99
		p_u_99:CloseRequest()
	end)
	p_u_99.DuelsContainerCloseButton.MouseButton1Click:Connect(function()
		-- upvalues: (copy) p_u_99
		p_u_99:CloseRequest()
	end)
	p_u_99.ArcadeServersHeaderInfoButton.MouseButton1Click:Connect(function()
		-- upvalues: (copy) p_u_99
		p_u_99.ArcadeServersHeaderInfoBubble.Visible = not p_u_99.ArcadeServersHeaderInfoBubble.Visible
	end)
	p_u_99.Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		-- upvalues: (copy) p_u_99
		p_u_99:_UpdateList()
	end)
	p_u_99.PageFrame:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
		-- upvalues: (copy) p_u_99
		p_u_99:_UpdateList()
	end)
	p_u_99.RankedSlot.Clicked:Connect(function()
		-- upvalues: (copy) p_u_99, (ref) v_u_9
		if p_u_99.RankedUnlockedFrame.Visible then
			p_u_99.OpenPage:Fire("Ranked")
		else
			v_u_9:CreateSound("rbxassetid://17153811469", 2, 1, script, true, 5)
		end
	end)
	p_u_99.RotatingSlotsLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		-- upvalues: (copy) p_u_99
		p_u_99:_UpdateLayouts()
	end)
	p_u_99.EventSlotsLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		-- upvalues: (copy) p_u_99
		p_u_99:_UpdateLayouts()
	end)
	p_u_99.AprilFoolsSlotsLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		-- upvalues: (copy) p_u_99
		p_u_99:_UpdateLayouts()
	end)
	p_u_99.ArcadeServersHeaderInfoBubbleTitle:GetPropertyChangedSignal("TextBounds"):Connect(function()
		-- upvalues: (copy) p_u_99
		p_u_99:_UpdateLayouts()
	end)
	p_u_99.RotatingHeaderNewReleaseTitle:GetPropertyChangedSignal("TextBounds"):Connect(function()
		-- upvalues: (copy) p_u_99
		p_u_99:_UpdateLayouts()
	end)
	v_u_11:GetDataChangedSignal("StatisticDuelsPlayed"):Connect(function()
		-- upvalues: (copy) p_u_99
		p_u_99:_UpdateOnboarding()
	end)
	v_u_11:GetDataChangedSignal("StatisticDuelsWon"):Connect(function()
		-- upvalues: (copy) p_u_99
		p_u_99:_UpdateBeginnerQueue()
	end)
	v_u_11:GetDataChangedSignal("Level"):Connect(function()
		-- upvalues: (copy) p_u_99
		p_u_99:_UpdateLocked()
		p_u_99:_UpdateArcadeServerHeaderInfo()
	end)
	v_u_11:GetDataChangedSignal("Seasons"):Connect(function()
		-- upvalues: (copy) p_u_99
		p_u_99:_UpdateELO()
	end)
	v_u_10:GetLeaderboardRefreshedSignal("Highest ELO"):Connect(function()
		-- upvalues: (copy) p_u_99
		p_u_99:_UpdateELO()
	end)
	p_u_99:_Setup()
	p_u_99:_UpdateList()
	p_u_99:_UpdateOnboarding()
	p_u_99:_UpdateELO()
	p_u_99:_UpdateLocked()
	p_u_99:_UpdateLayouts()
	p_u_99:_UpdateArcadeServerHeaderInfo()
	v_u_16:Add(p_u_99.CloseButton)
	v_u_16:Add(p_u_99.DuelsContainerCloseButton)
	v_u_16:Add(p_u_99.ArcadeServersHeaderInfoButton)
end
return v_u_21._new()