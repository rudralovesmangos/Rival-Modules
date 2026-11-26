local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("TweenService")
local v3 = game:GetService("Players")
local v_u_4 = require(v1.Modules.CONSTANTS)
local v_u_5 = require(v1.Modules.MonetizationLibrary)
local v_u_6 = require(v1.Modules.StatisticsLibrary)
local v_u_7 = require(v1.Modules.ContractsLibrary)
local v_u_8 = require(v1.Modules.EventLibrary)
local v_u_9 = require(v1.Modules.ServerOsTime)
local v_u_10 = require(v1.Modules.ItemLibrary)
local v_u_11 = require(v1.Modules.TaskLibrary)
local v_u_12 = require(v1.Modules.DuelLibrary)
local v_u_13 = require(v1.Modules.Utility)
local v_u_14 = require(v3.LocalPlayer.PlayerScripts.Controllers.ShootingRangeController)
local v_u_15 = require(v3.LocalPlayer.PlayerScripts.Controllers.MonetizationController)
local v_u_16 = require(v3.LocalPlayer.PlayerScripts.Controllers.PlayerDataController)
local v_u_17 = require(v3.LocalPlayer.PlayerScripts.Controllers.LobbyController)
local v_u_18 = require(v3.LocalPlayer.PlayerScripts.Controllers.TimerController)
local v_u_19 = require(v3.LocalPlayer.PlayerScripts.Modules:WaitForChild("AdventCalendarSlot"))
local v_u_20 = require(v3.LocalPlayer.PlayerScripts.Modules:WaitForChild("DropdownSlot"))
local v_u_21 = require(v3.LocalPlayer.PlayerScripts.Modules:WaitForChild("ButtonEffect"))
local v_u_22 = require(v3.LocalPlayer.PlayerScripts.Modules:WaitForChild("RewardSlot"))
local v_u_23 = require(v3.LocalPlayer.PlayerScripts.Modules:WaitForChild("TaskSlot"))
local v_u_24 = require(v3.LocalPlayer.PlayerScripts.Modules:WaitForChild("Page"))
local v_u_25 = v3.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("DailyTaskStreakMilestoneSlot")
local v_u_26 = v3.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("TaskContractMilestoneDivider")
local v_u_27 = v3.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("DailyTaskStreakSlot")
local v_u_28 = v3.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("TaskContractMilestoneSlot")
local v_u_29 = v3.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("TaskContainer")
local v_u_30 = {
	{
		"Tasks",
		"Daily Tasks",
		"rbxassetid://17653923757",
		UDim2.new(2, 0, 1.5, 0)
	},
	{
		"LimitedTasks",
		nil,
		nil,
		nil
	},
	{
		"SpecialChallenges",
		"Special Challenge" .. (#(v_u_11.SPECIAL_CHALLENGES or {}) == 1 and "" or "s") .. "!",
		"rbxassetid://17860673529",
		UDim2.new(2, 0, 2, 0),
		"Limited time only!"
	},
	{
		"EventTasks",
		"Earn " .. v_u_8.EVENT_DETAILS.CURRENCY_NAME_PLURAL .. "!",
		v_u_8.EVENT_DETAILS.CURRENCY_IMAGE,
		UDim2.new(2.25, 0, 2.25, 0),
		"Limited time only!"
	},
	{
		"BonusTasks",
		"Bonus Tasks",
		"rbxassetid://17653923757",
		UDim2.new(2, 0, 1.5, 0)
	}
}
local v_u_31 = setmetatable({}, v_u_24)
v_u_31.__index = v_u_31
function v_u_31._new() -- name: _new
	-- upvalues: (copy) v_u_24, (copy) v_u_31, (copy) v_u_19
	local v32 = v_u_24.new(script.Name)
	local v33 = v_u_31
	local v34 = setmetatable(v32, v33)
	v34.CloseButton = v34.PageFrame:WaitForChild("Close")
	v34.List = v34.PageFrame:WaitForChild("List")
	v34.Container = v34.List:WaitForChild("Container")
	v34.Layout = v34.Container:WaitForChild("Layout")
	v34.TasksCompletedFrame = v34.Container:WaitForChild("TasksCompleted")
	v34.TasksCompletedContainer = v34.TasksCompletedFrame:WaitForChild("Container")
	v34.TasksCompletedTimerText = v34.TasksCompletedContainer:WaitForChild("Timer")
	v34.TasksCompletedContentsFrame = v34.TasksCompletedContainer:WaitForChild("Contents")
	v34.TasksCompletedContentsLayout = v34.TasksCompletedContentsFrame:WaitForChild("Layout")
	v34.TasksCompletedRefreshFrame = v34.TasksCompletedContentsFrame:WaitForChild("Refresh")
	v34.TasksCompletedRefreshRewardsFrame = v34.TasksCompletedRefreshFrame:WaitForChild("Rewards")
	v34.TasksCompletedRefreshButton = v34.TasksCompletedRefreshFrame:WaitForChild("Button")
	v34.TasksCompletedRefreshButtonText = v34.TasksCompletedRefreshButton:WaitForChild("Price")
	v34.ContractsFrame = v34.Container:WaitForChild("Contracts")
	v34.ContractsContainer = v34.ContractsFrame:WaitForChild("Container")
	v34.ContractsFilterButton = v34.ContractsContainer:WaitForChild("Filter")
	v34.ContractsDropdownFrame = v34.ContractsContainer:WaitForChild("Dropdown")
	v34.ContractsDropdownButton = v34.ContractsDropdownFrame:WaitForChild("Button")
	v34.ContractsDropdownTitle = v34.ContractsDropdownButton:WaitForChild("Title")
	v34.ContractsMilestones = v34.ContractsContainer:WaitForChild("Milestones")
	v34.ContractsLayout = v34.ContractsMilestones:WaitForChild("Layout")
	v34.AdventCalendarFrame = v34.Container:WaitForChild("AdventCalendar")
	v34.AdventCalendarSlot = v_u_19.new(v34.AdventCalendarFrame)
	v34._to_shooting_range_button = nil
	v34._to_duels_button = nil
	v34._task_containers = {}
	v34._task_slots = {}
	v34._contract_slots = {}
	v34._contract_dividers = {}
	v34._daily_task_streak_cleanup = {}
	v34._daily_task_streak_reward_slots = {}
	v34._daily_task_streak_update_callbacks = {}
	v34._percent_contract_goal_enabled = false
	v34._while_open_callbacks = {}
	v34:_Init()
	return v34
end
function v_u_31.ScrollTo(p_u_35, p36, p37) -- name: ScrollTo
	-- upvalues: (copy) v_u_2
	local v_u_38 = p_u_35._task_containers[p36]
	if v_u_38 then
		task.delay(p37 or 0, function()
			-- upvalues: (ref) v_u_2, (copy) p_u_35, (copy) v_u_38
			v_u_2:Create(p_u_35.List, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
				["CanvasPosition"] = Vector2.new(0, v_u_38.AbsolutePosition.Y - p_u_35.Container.AbsolutePosition.Y)
			}):Play()
		end)
	end
end
function v_u_31.Open(p_u_39, ...) -- name: Open
	-- upvalues: (copy) v_u_24, (copy) v_u_16, (copy) v_u_18, (copy) v_u_11
	v_u_24.Open(p_u_39, ...)
	p_u_39.AdventCalendarSlot:SetEnabled(true)
	p_u_39.ContractsDropdownFrame.Visible = v_u_16:Get("Level") >= 15
	local v40 = p_u_39._open_threads
	local v41 = task.spawn
	table.insert(v40, v41(function()
		-- upvalues: (copy) p_u_39
		while true do
			for _, v42 in pairs(p_u_39._while_open_callbacks) do
				v42()
			end
			wait(1)
		end
	end))
	local v43 = p_u_39._open_threads
	local v44 = task.spawn
	table.insert(v43, v44(function()
		-- upvalues: (copy) p_u_39
		while true do
			wait(3)
			for _, v45 in pairs(p_u_39._daily_task_streak_reward_slots) do
				v45.Frame:TweenPosition(UDim2.new(0.5, 0, -0.125, 0), "Out", "Quint", 1, true)
			end
			wait(0.75)
			for _, v46 in pairs(p_u_39._daily_task_streak_reward_slots) do
				v46.Frame:TweenPosition(UDim2.new(0.5, 0, 0.5, 0), "Out", "Bounce", 1, true)
			end
		end
	end))
	local v47 = p_u_39._open_connections
	local v48 = v_u_16:GetDataChangedSignal("StatisticDuelsPlayed")
	table.insert(v47, v48:Connect(function()
		-- upvalues: (copy) p_u_39
		p_u_39:_Generate()
	end))
	local v49 = p_u_39._open_connections
	local v50 = v_u_16:GetDataChangedSignal("BeginnerTasksCompleted")
	table.insert(v49, v50:Connect(function()
		-- upvalues: (copy) p_u_39
		p_u_39:_Generate()
	end))
	local v51 = p_u_39._open_connections
	local v52 = v_u_16:GetDataChangedSignal("DailyTaskStreak")
	table.insert(v51, v52:Connect(function()
		-- upvalues: (copy) p_u_39
		p_u_39:_Generate()
	end))
	local v53 = p_u_39._open_connections
	local v54 = v_u_18.TimerUpdated
	table.insert(v53, v54:Connect(function()
		-- upvalues: (copy) p_u_39
		p_u_39:_Generate()
	end))
	for _, v55 in pairs(v_u_11.TASKS_DATA_NAMES) do
		local v56 = p_u_39._open_connections
		local v57 = v_u_16:GetDataChangedSignal(v55)
		table.insert(v56, v57:Connect(function()
			-- upvalues: (copy) p_u_39
			p_u_39:_Generate()
		end))
	end
	p_u_39:_Generate()
end
function v_u_31.Close(p58, ...) -- name: Close
	-- upvalues: (copy) v_u_18, (copy) v_u_24
	v_u_18:OnStep("TaskPage", nil, nil)
	p58.AdventCalendarSlot:SetEnabled(false)
	p58:_StopDropdown()
	v_u_24.Close(p58, ...)
end
function v_u_31._StopDropdown(p59) -- name: _StopDropdown
	if p59._dropdown_slot then
		p59._dropdown_slot:Cancel()
		p59._dropdown_slot = nil
	end
	p59.ContractsDropdownButton.Visible = true
end
function v_u_31._StartDropdown(p_u_60) -- name: _StartDropdown
	-- upvalues: (copy) v_u_20
	p_u_60:_StopDropdown()
	p_u_60.ContractsDropdownButton.Visible = false
	p_u_60._dropdown_slot = v_u_20.new(p_u_60.ContractsDropdownFrame, { "Near Completion", "Most Played" })
	p_u_60._dropdown_slot.Selected:Connect(function(p61)
		-- upvalues: (copy) p_u_60
		if p61 then
			p_u_60.ContractsDropdownTitle.Text = p61
			p_u_60:_Generate()
		end
		p_u_60:_StopDropdown()
	end)
end
function v_u_31._SetPercentContractGoalEnabled(p62, p63) -- name: _SetPercentContractGoalEnabled
	p62._percent_contract_goal_enabled = p63
	for _, v64 in pairs(p62._contract_slots) do
		v64.GoalPercent.Visible = p62._percent_contract_goal_enabled
		v64.Goal.Visible = not p62._percent_contract_goal_enabled
	end
end
function v_u_31._CreateDailyTaskStreakSlot(p_u_65, p66) -- name: _CreateDailyTaskStreakSlot
	-- upvalues: (copy) v_u_27, (copy) v_u_16, (copy) v_u_11, (copy) v_u_25, (copy) v_u_13, (copy) v_u_22
	local v_u_67 = p66 or false
	local v_u_68 = v_u_27:Clone()
	local function v91(p69, p70) -- name: update
		-- upvalues: (copy) v_u_68, (copy) v_u_67, (ref) v_u_16, (ref) v_u_11, (ref) v_u_25, (copy) p_u_65, (ref) v_u_13, (ref) v_u_22
		local v71 = v_u_68
		if p69 then
			p69 = v_u_67 == p70
		end
		v71.Visible = p69
		if v_u_68.Visible then
			local v72 = v_u_16:Get("DailyTaskStreak")
			local v73 = v72 / v_u_11.NUM_DAILY_TASK_STREAK_REWARD_MILESTONES
			local v74 = math.floor(v73) * v_u_11.NUM_DAILY_TASK_STREAK_REWARD_MILESTONES + 1
			for v75 = v74, v74 + v_u_11.NUM_DAILY_TASK_STREAK_REWARD_MILESTONES - 1 do
				local v76 = v_u_11.DailyTaskStreakRewards[(v75 - 1) % v_u_11.NUM_DAILY_TASK_STREAK_REWARD_MILESTONES + 1]
				local v77
				if v76.CanMultiplyRewards then
					local v78 = v_u_11.DAILY_TASK_STREAK_REWARD_MAX_MULTIPLIER
					local v79 = v75 / v_u_11.NUM_DAILY_TASK_STREAK_REWARD_MILESTONES
					local v80 = math.ceil(v79)
					v77 = math.min(v78, v80)
				else
					v77 = 1
				end
				local v81 = v75 <= v72
				local v82 = v75 == v72 + 1
				local _ = v72 + 1 < v75
				local v83 = (v82 and not p70 or v81) and 0 or 0.9
				local v84 = v_u_25:Clone()
				v84.LayoutOrder = v75
				v84.Completed.Visible = v81
				v84.Date.Visible = not v81
				v84.Date.Value.Text = v75
				v84.Date.Value.TextTransparency = v83
				v84.Date.Title.TextTransparency = v83
				v84.Background.Circle.BackgroundTransparency = v81 and 0 or 1
				v84.Background.Circle.UIStroke.Transparency = v83
				v84.Background.Circle.UIStroke.Thickness = v81 and 2 or (v82 and 2 or 1)
				v84.Background.Dash.BackgroundTransparency = v83
				v84.Background.Dash.Visible = v75 ~= v74
				v84.Reward.Visible = not v81
				v84.Parent = v_u_68.Container.Milestones
				local v85 = p_u_65._daily_task_streak_cleanup
				table.insert(v85, v84)
				for _, v86 in pairs(v76.Rewards or {}) do
					local v87 = v_u_13:CloneTable(v86)
					v87.Quantity = (v87.Quantity or 1) * v77
					local v88 = v_u_22.new(v87)
					v88:SetParent(v84.Reward)
					local v89 = p_u_65._daily_task_streak_cleanup
					table.insert(v89, v88)
					local v90 = p_u_65._daily_task_streak_reward_slots
					table.insert(v90, v88)
				end
			end
		end
	end
	local v92 = p_u_65._daily_task_streak_update_callbacks
	table.insert(v92, v91)
	v91()
	return v_u_68
end
function v_u_31._UpdateDailyTaskStreak(p93, ...) -- name: _UpdateDailyTaskStreak
	for _, v94 in pairs(p93._daily_task_streak_cleanup) do
		v94:Destroy()
	end
	p93._daily_task_streak_cleanup = {}
	p93._daily_task_streak_reward_slots = {}
	for _, v95 in pairs(p93._daily_task_streak_update_callbacks) do
		v95(...)
	end
end
function v_u_31._Generate(p_u_96) -- name: _Generate
	-- upvalues: (copy) v_u_16, (copy) v_u_11, (copy) v_u_8, (copy) v_u_4, (copy) v_u_18
	for _, v97 in pairs(p_u_96._task_slots) do
		v97:Destroy()
	end
	for _, v98 in pairs(p_u_96._contract_slots) do
		v98:Destroy()
	end
	for _, v99 in pairs(p_u_96._contract_dividers) do
		v99:Destroy()
	end
	p_u_96._task_slots = {}
	p_u_96._contract_slots = {}
	p_u_96._contract_dividers = {}
	local v100 = v_u_16:Get("BeginnerTasksCompleted")
	local v101 = v_u_11.NUM_BEGINNER_TASKS <= v100
	local v102 = v_u_16:AreTasksCompleted()
	local v103 = v_u_8.IS_ACTIVE
	if v103 then
		v103 = v_u_16:GetStatistic("StatisticDuelsPlayed") >= v_u_8.NUM_GAMES_NEEDED_TO_PARTICIPATE
	end
	local v104 = #(v_u_16:Get("LimitedTasks") or {}) > 0
	p_u_96.TasksCompletedFrame.Visible = v102
	p_u_96.ContractsFrame.Visible = v101
	if p_u_96._to_shooting_range_button then
		local v105 = p_u_96._to_shooting_range_button
		local v106 = v_u_4.SHOOTING_RANGE_ACTIVE
		if v106 then
			v106 = v100 <= v_u_11.NUM_BEGINNER_TASKS - 2
		end
		v105.Visible = v106
	end
	if p_u_96._to_duels_button then
		local v107 = p_u_96._to_duels_button
		local v108 = v_u_4.QUEUES_ACTIVE
		if v108 then
			v108 = v_u_11.NUM_BEGINNER_TASKS - 1 <= v100
		end
		v107.Visible = v108
	end
	local v109 = p_u_96._task_containers.SpecialChallenges
	local v110
	if v_u_16:Get("SpecialChallenges") == nil then
		v110 = false
	else
		v110 = not v_u_16:AreTasksCompleted("SpecialChallenges")
	end
	v109.Visible = v110
	p_u_96._task_containers.EventTasks.Visible = v102 and v103
	p_u_96._task_containers.LimitedTasks.Visible = v104
	p_u_96._task_containers.BonusTasks.Visible = v102
	p_u_96._task_containers.Tasks.Visible = not v102
	p_u_96._task_containers.Tasks.Container.Title.Text = v101 and "Daily Tasks" or "Beginner Tasks   [" .. v100 + 1 .. " / " .. v_u_11.NUM_BEGINNER_TASKS .. "]"
	v_u_18:OnStep("TaskPageTaskRefresh", "TaskRefresh", v102 and function(_, p111)
		-- upvalues: (copy) p_u_96
		p_u_96.TasksCompletedTimerText.Text = "new tasks in " .. p111
	end or nil)
	p_u_96:_GenerateTasks(v102, v101, v103, v104)
	if v101 then
		p_u_96:_GenerateContracts()
	end
end
function v_u_31._GenerateTasks(p112, p113, p114, p115, _) -- name: _GenerateTasks
	-- upvalues: (copy) v_u_11, (copy) v_u_16, (copy) v_u_23
	local v116 = p113 and { "BonusTasks" } or { "Tasks" }
	if p113 and p115 then
		table.insert(v116, "EventTasks")
	end
	if v_u_11.SPECIAL_CHALLENGES then
		table.insert(v116, "SpecialChallenges")
	end
	table.insert(v116, "LimitedTasks")
	local v117 = v_u_11:GetCurrentlyActiveLimitedTasks()
	for _, v118 in pairs(v116) do
		local v119 = p112._task_containers[v118]
		local v120 = v_u_16:Get(v118)
		if not v120 then
			continue
		end
		local v121 = v118 == "SpecialChallenges" and v_u_11.SPECIAL_CHALLENGES_MUST_BE_COMPLETED_IN_ORDER
		if not v121 then
			if v118 == "LimitedTasks" then
				if v117 then
					v121 = v117.RequiresPreviousTaskCompleted
				else
					v121 = v117
				end
			else
				v121 = false
			end
		end
		local v122 = false
		for v123, v124 in pairs(v120) do
			local v125
			if v121 then
				if v123 > 1 then
					v125 = not v120[v123 - 1].Completed
				else
					v125 = false
				end
			else
				v125 = v121
			end
			local v126 = v_u_23.new(v124)
			v126:SetLocked(v125, v122)
			v126:SetParent(v119.Container.Contents.Slots.Container)
			local v127 = p112._task_slots
			table.insert(v127, v126)
			v122 = v125
		end
	end
	p112:_UpdateDailyTaskStreak(p114, p113)
end
function v_u_31._GenerateContracts(p_u_128) -- name: _GenerateContracts
	-- upvalues: (copy) v_u_7, (copy) v_u_6, (copy) v_u_28, (copy) v_u_10, (copy) v_u_12, (copy) v_u_22, (copy) v_u_16, (copy) v_u_13, (copy) v_u_26
	local v_u_129 = p_u_128.ContractsDropdownTitle.Text == "Near Completion" and "FilterProgress" or "FilterPlaytime"
	local v_u_130 = 0
	local function v149(p131, p132, p133, p134) -- name: generate
		-- upvalues: (ref) v_u_7, (ref) v_u_6, (ref) v_u_130, (ref) v_u_28, (ref) v_u_10, (ref) v_u_12, (copy) p_u_128, (ref) v_u_22
		local v135 = v_u_7.Contracts[p133]
		local v136 = v_u_6.Info[v135.StatisticName]
		local v137 = string.find(p133, " Rounds Won") and 6 or (string.find(p133, " Playtime") and 4 or 2)
		local v138 = p131 or (p132 or "???")
		for v139, v140 in pairs(v135.Milestones) do
			local v141, v142 = table.unpack(v140)
			local v143 = v141 <= p134
			if v143 and v139 < #v135.Milestones then
				continue
			end
			v_u_130 = v_u_130 + 1
			local v144 = v_u_28:Clone()
			local v145 = v144.Progress.Bar
			local v146 = UDim2.new
			local v147 = p134 / v141
			v145.Size = v146(math.clamp(v147, 0, 1), 0, 1, 2)
			v144.Progress.Bar.BackgroundColor3 = v143 and Color3.fromRGB(100, 255, 50) or Color3.fromRGB(0, 190, 255)
			v144.Completed.Visible = v143
			v144.Goal.Text = v143 and "" or string.format("%s <font size=\"8\">/ %s</font>", v136.TostringFunction(p134), v136.TostringFunction(v141))
			v144.GoalPercent.Text = v143 and "" or string.format("%.1f", p134 / v141 * 100) .. "%"
			v144.Title.Text = v138 .. "  \226\128\162  " .. v136.FullDisplayName
			v144.Weapon.Image = p131 and v_u_10.Items[p131].Image or ""
			v144.Map.Image = p132 and v_u_12.Maps[p132].Image or ""
			v144.LayoutOrder = v137 * 99999
			v144.Parent = p_u_128.ContractsMilestones
			local v148 = p_u_128._contract_slots
			table.insert(v148, v144)
			if v142 and not v143 then
				v_u_22.new(v142):SetParent(v144.Reward)
				return
			end
			return
		end
	end
	local function v_u_169(p150, p151, p152) -- name: get_sorted_contracts
		-- upvalues: (ref) v_u_7, (ref) v_u_16, (copy) v_u_129, (ref) v_u_13
		local v153 = {}
		for _, v154 in pairs(p150) do
			local v155
			if p152 then
				v155 = v_u_7:GetWeaponContracts(v154)
			else
				v155 = v_u_7:GetMapContracts(v154)
			end
			if v155 then
				v155 = v155[p151]
			end
			if not v155 then
				continue
			end
			local v156 = v_u_7.Contracts[v155]
			local v157
			if p152 then
				v157 = v_u_16:GetWeaponStatistic(v156.Identifier, v156.StatisticName, v156.ExtraStatisticNames)
			else
				v157 = v_u_16:GetMapStatistic(v156.Identifier, v156.StatisticName, v156.ExtraStatisticNames)
			end
			for _, v160 in pairs(v156.Milestones) do
				local v159, _ = table.unpack(v160)
				if v159 <= v157 then
					continue
				end
			end
			local v160 = v156.Milestones[#v156.Milestones]
			local v161 = v160[1]
			local v162 = {
				["Name"] = v154,
				["ContractName"] = v155,
				["Progress"] = v157,
				["Goal"] = v161
			}
			local v163
			if p152 then
				v163 = v_u_16:GetWeaponStatistic(v154, "StatisticPlaytime")
			else
				v163 = v_u_16:GetMapStatistic(v154, "StatisticPlaytime")
			end
			v162.FilterPlaytime = v163
			v162.FilterProgress = -(v161 - v157)
			table.insert(v153, v162)
		end
		table.sort(v153, function(p164, p165)
			-- upvalues: (ref) v_u_129, (ref) v_u_13
			local v166 = p164.Progress >= p164.Goal
			local v167 = p165.Progress >= p165.Goal
			if v166 == v167 then
				local v168 = p164[v_u_129] - p165[v_u_129]
				if math.abs(v168) > 0.001 then
					return p164[v_u_129] > p165[v_u_129]
				else
					return v_u_13:StringLessThan(p164.Name, p165.Name)
				end
			else
				return v167
			end
		end)
		return v153
	end
	for _, v170 in pairs({ 3, 5 }) do
		local v171 = v_u_26:Clone()
		v171.LayoutOrder = v170 * 99999
		v171.Parent = p_u_128.ContractsMilestones
		local v172 = p_u_128._contract_dividers
		table.insert(v172, v171)
	end
	local function v178(p173, p174) -- name: get_sorted_weapons
		-- upvalues: (ref) v_u_16, (ref) v_u_10, (copy) v_u_169
		local v175 = {}
		for _, v176 in pairs(v_u_16:Get("WeaponInventory")) do
			local v177 = v176.Name
			if v_u_10.Classes[v_u_10.Items[v177].Class].Slot ~= p173 then
				continue
			end
			table.insert(v175, v177)
		end
		return v_u_169(v175, p174, true)
	end
	for v179 = 1, 2 do
		for v180 = 1, 4 do
			local v181 = v178(v180, v179)
			for _, v182 in pairs(v181) do
				v149(v182.Name, nil, v182.ContractName, v182.Progress)
			end
		end
	end
	local v186 = (function(p183) -- name: get_sorted_maps
		-- upvalues: (ref) v_u_12, (copy) v_u_169
		local v184 = {}
		for _, v185 in pairs(v_u_12:GetReleasedMapOrder()) do
			table.insert(v184, v185)
		end
		return v_u_169(v184, p183, false)
	end)(1)
	for v187 = 1, 4 do
		local v188 = v186[v187]
		v149(nil, v188.Name, v188.ContractName, v188.Progress)
	end
	p_u_128:_SetPercentContractGoalEnabled(p_u_128._percent_contract_goal_enabled)
end
function v_u_31._Setup(p_u_189) -- name: _Setup
	-- upvalues: (copy) v_u_30, (copy) v_u_11, (copy) v_u_29, (copy) v_u_14, (copy) v_u_17, (copy) v_u_21, (copy) v_u_9, (copy) v_u_13, (copy) v_u_22, (copy) v_u_15, (copy) v_u_5
	p_u_189.ContractsDropdownTitle.Text = "Near Completion"
	for v190, v191 in pairs(v_u_30) do
		local v192, v193, v194, v195, v196 = table.unpack(v191)
		if v192 == "LimitedTasks" then
			local v197 = v_u_11:GetCurrentlyActiveLimitedTasks()
			if v197 then
				v193 = v197.DisplayName
				v194 = v197.Image
				v195 = v197.ImageSize
				v196 = v197.Description
			end
		end
		local v_u_198 = v_u_29:Clone()
		v_u_198.Container.Buttons.Visible = v192 == "Tasks"
		v_u_198.Container.Title.Text = v193 or ""
		v_u_198.Container.Title.ImageLabel.Image = v194 or ""
		v_u_198.Container.Title.ImageLabel.Size = v195 or UDim2.new(1.5, 0, 1, 0)
		v_u_198.Container.Description.Text = v196 or ""
		v_u_198.LayoutOrder = -999 + v190
		v_u_198.Parent = p_u_189.Container
		p_u_189._task_containers[v192] = v_u_198
		v_u_198.Container.Contents.Slots.Container.Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() -- name: update_slots
			-- upvalues: (copy) v_u_198
			v_u_198.Container.Contents.Slots.Size = UDim2.new(1, 0, 0, v_u_198.Container.Contents.Slots.Container.Layout.AbsoluteContentSize.Y)
		end)
		v_u_198.Container.Contents.Slots.Size = UDim2.new(1, 0, 0, v_u_198.Container.Contents.Slots.Container.Layout.AbsoluteContentSize.Y)
		local function v202() -- name: update_frame
			-- upvalues: (copy) v_u_198
			local function v201()
				-- upvalues: (ref) v_u_198
				v_u_198.Size = UDim2.new(1, 0, 0, v_u_198.Container.AbsoluteSize.Y * 0.2 + v_u_198.Container.Contents.Layout.AbsoluteContentSize.Y)
				local v199 = v_u_198
				local v200
				if v_u_198.Container.Contents.Layout.AbsoluteContentSize.Y > 1 then
					v200 = #v_u_198.Container.Contents.Slots.Container:GetChildren() > 1
				else
					v200 = false
				end
				v199.Visible = v200
			end
			pcall(v201)
		end
		v_u_198.Container.Contents.Slots.Container.ChildAdded:Connect(v202)
		v_u_198.Container.Contents.Slots.Container.ChildRemoved:Connect(v202)
		v_u_198.Container.Contents.Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(v202)
		v_u_198.Container:GetPropertyChangedSignal("AbsoluteSize"):Connect(v202)
		pcall(function()
			-- upvalues: (copy) v_u_198
			v_u_198.Size = UDim2.new(1, 0, 0, v_u_198.Container.AbsoluteSize.Y * 0.2 + v_u_198.Container.Contents.Layout.AbsoluteContentSize.Y)
			local v203 = v_u_198
			local v204
			if v_u_198.Container.Contents.Layout.AbsoluteContentSize.Y > 1 then
				v204 = #v_u_198.Container.Contents.Slots.Container:GetChildren() > 1
			else
				v204 = false
			end
			v203.Visible = v204
		end)
		if v192 == "Tasks" then
			p_u_189:_CreateDailyTaskStreakSlot(false).Parent = v_u_198.Container.Contents
			p_u_189._to_shooting_range_button = v_u_198.Container.Buttons.ToShootingRange
			p_u_189._to_duels_button = v_u_198.Container.Buttons.ToDuels
			p_u_189._to_shooting_range_button.Button.MouseButton1Click:Connect(function()
				-- upvalues: (copy) p_u_189, (ref) v_u_14
				p_u_189:CloseRequest()
				v_u_14:Enter(true)
			end)
			p_u_189._to_duels_button.Button.MouseButton1Click:Connect(function()
				-- upvalues: (copy) p_u_189, (ref) v_u_17
				p_u_189:CloseRequest()
				v_u_17:ToDuels()
			end)
			v_u_21:Add(p_u_189._to_duels_button.Button, nil, {
				["HoverRatio"] = UDim2.new(0, 10, 0, 10),
				["ReleaseRatio"] = UDim2.new(0, 10, 0, 10)
			})
			v_u_21:Add(p_u_189._to_shooting_range_button.Button, nil, {
				["HoverRatio"] = UDim2.new(0, 10, 0, 10),
				["ReleaseRatio"] = UDim2.new(0, 10, 0, 10)
			})
		else
			if v192 ~= "LimitedTasks" then
				continue
			end
			local v205 = p_u_189._while_open_callbacks
			local function v208()
				-- upvalues: (ref) v_u_11, (ref) v_u_9, (copy) v_u_198, (ref) v_u_13
				local v206 = v_u_11:GetCurrentlyActiveLimitedTasks()
				if v206 then
					local v207 = v206.FinishTimestamp - v_u_9:Get()
					v206 = math.floor(v207)
				end
				v_u_198.Container.Description.Text = v206 and (v206 > 0 and v_u_13:TimeFormat2(v206)) or "\226\128\162 \226\128\162 \226\128\162"
			end
			table.insert(v205, v208)
		end
	end
	p_u_189:_CreateDailyTaskStreakSlot(true).Parent = p_u_189.TasksCompletedContentsFrame
	v_u_22.new({
		["Name"] = "Key",
		["Quantity"] = nil,
		["Quantity"] = v_u_11.Info.Core1.Rewards[1].Quantity + v_u_11.Info.Core2.Rewards[1].Quantity + v_u_11.Info.Core3.Rewards[1].Quantity
	}):SetParent(p_u_189.TasksCompletedRefreshRewardsFrame)
	local v209 = v_u_22.new({
		["Name"] = nil,
		["Weapon"] = "IsRandom",
		["Name"] = v_u_11.DAILY_TASKS_RARE_REWARD
	})
	v209.CosmeticSlot.Frame.Button.Title.Size = UDim2.new(0.9, 0, 0.4, 0)
	local v210 = v209.CosmeticSlot.Frame.Button.Title
	local v211 = v_u_11.DAILY_TASKS_RARE_REWARD_CHANCE * 1000
	v210.Text = math.floor(v211) / 10 .. "%"
	v209:SetParent(p_u_189.TasksCompletedRefreshRewardsFrame)
	local v212 = v_u_22.new({
		["Name"] = nil,
		["Weapon"] = "IsRandom",
		["Name"] = v_u_11.DAILY_TASKS_LEGENDARY_REWARD
	})
	v212.CosmeticSlot.Frame.Button.Title.Size = UDim2.new(0.9, 0, 0.4, 0)
	local v213 = v212.CosmeticSlot.Frame.Button.Title
	local v214 = v_u_11.DAILY_TASKS_LEGENDARY_REWARD_CHANCE * 1000
	v213.Text = math.floor(v214) / 10 .. "%"
	v212:SetParent(p_u_189.TasksCompletedRefreshRewardsFrame)
	v_u_15:SetRobuxText(p_u_189.TasksCompletedRefreshButtonText, v_u_5.Products.RefreshTasks.ProductID)
end
function v_u_31._Init(p_u_215) -- name: _Init
	-- upvalues: (copy) v_u_15, (copy) v_u_5, (copy) v_u_21
	p_u_215.CloseButton.MouseButton1Click:Connect(function()
		-- upvalues: (copy) p_u_215
		p_u_215:CloseRequest()
	end)
	p_u_215.TasksCompletedRefreshButton.MouseButton1Click:Connect(function()
		-- upvalues: (ref) v_u_15, (ref) v_u_5
		v_u_15:PromptProductPurchase(v_u_5.Products.RefreshTasks.ProductID)
	end)
	p_u_215.Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		-- upvalues: (copy) p_u_215
		p_u_215.List.CanvasSize = UDim2.new(0, 0, 0, p_u_215.Layout.AbsoluteContentSize.Y)
		p_u_215.List.Active = p_u_215.List.CanvasSize.Y.Offset > p_u_215.List.AbsoluteSize.Y
		p_u_215.List.Position = p_u_215.List.Active and UDim2.new(0.5, 0, 0, 0) or UDim2.new(0.5, 0, 0.2, 0)
		p_u_215.CloseButton.Position = p_u_215.List.Active and UDim2.new(1.075, 16, 0.0375, 0) or UDim2.new(1.075, 16, 0.2375, 0)
	end)
	p_u_215.TasksCompletedContentsLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		-- upvalues: (copy) p_u_215
		p_u_215.TasksCompletedFrame.Size = UDim2.new(1, 0, 0, p_u_215.TasksCompletedContentsLayout.AbsoluteContentSize.Y)
	end)
	p_u_215.ContractsLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		-- upvalues: (copy) p_u_215
		p_u_215.ContractsFrame.Size = UDim2.new(1, 0, 0, p_u_215.ContractsContainer.AbsoluteSize.Y * 0.15 + p_u_215.ContractsLayout.AbsoluteContentSize.Y)
	end)
	p_u_215.ContractsFilterButton.MouseButton1Click:Connect(function()
		-- upvalues: (copy) p_u_215
		p_u_215:_SetPercentContractGoalEnabled(not p_u_215._percent_contract_goal_enabled)
	end)
	p_u_215.ContractsDropdownButton.MouseButton1Click:Connect(function()
		-- upvalues: (copy) p_u_215
		p_u_215:_StartDropdown()
	end)
	p_u_215:_Setup()
	v_u_21:Add(p_u_215.CloseButton)
	v_u_21:Add(p_u_215.ContractsFilterButton)
	v_u_21:Add(p_u_215.TasksCompletedRefreshButton, nil, {
		["HoverRatio"] = UDim2.new(0, 8, 0, 8),
		["ReleaseRatio"] = UDim2.new(0, 8, 0, 8)
	})
	v_u_21:Add(p_u_215.ContractsDropdownButton, nil, {
		["ReleaseRatio"] = 1.025,
		["HoverRatio"] = 1.025
	})
end
return v_u_31._new()