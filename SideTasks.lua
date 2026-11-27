local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("GuiService")
local v_u_3 = game:GetService("RunService")
local v4 = game:GetService("Players")
local v_u_5 = require(v1.Modules.CONSTANTS)
local v_u_6 = require(v1.Modules.StatisticsLibrary)
local v_u_7 = require(v1.Modules.ContractsLibrary)
local v_u_8 = require(v1.Modules.TaskLibrary)
local v_u_9 = require(v1.Modules.ItemLibrary)
local v_u_10 = require(v1.Modules.Spring)
local v_u_11 = require(v4.LocalPlayer.PlayerScripts.Controllers:WaitForChild("ShootingRangeController"))
local v_u_12 = require(v4.LocalPlayer.PlayerScripts.Controllers:WaitForChild("PlayerDataController"))
local v_u_13 = require(v4.LocalPlayer.PlayerScripts.Controllers:WaitForChild("SpectateController"))
local v_u_14 = require(v4.LocalPlayer.PlayerScripts.Controllers:WaitForChild("FighterController"))
local v_u_15 = require(v4.LocalPlayer.PlayerScripts.Controllers:WaitForChild("LobbyController"))
local v_u_16 = require(v4.LocalPlayer.PlayerScripts.Controllers:WaitForChild("TimerController"))
local v_u_17 = require(v4.LocalPlayer.PlayerScripts.Modules:WaitForChild("WeaponStatusHandler"))
local v_u_18 = require(v4.LocalPlayer.PlayerScripts.Modules.UserInterface:WaitForChild("MobileInputs"))
local v_u_19 = require(v4.LocalPlayer.PlayerScripts.Modules.UserInterface:WaitForChild("Teleporting"))
local v_u_20 = require(v4.LocalPlayer.PlayerScripts.Modules.UserInterface:WaitForChild("Equipment"))
local v_u_21 = require(v4.LocalPlayer.PlayerScripts.Modules.UserInterface:WaitForChild("Pages"))
local v_u_22 = require(v4.LocalPlayer.PlayerScripts.Modules.UserInterface:WaitForChild("Queue"))
local v_u_23 = require(v4.LocalPlayer.PlayerScripts.Modules:WaitForChild("ButtonEffect"))
local v_u_24 = require(v4.LocalPlayer.PlayerScripts.Modules:WaitForChild("RewardSlot"))
local v_u_25 = require(v4.LocalPlayer.PlayerScripts.Modules:WaitForChild("UILibrary"))
local v_u_26 = v4.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("SideContractSlot")
local v_u_27 = v4.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("SideTaskSlot")
local v_u_28 = UDim2.new(-1, -10, 0.5, 0)
local v_u_29 = UDim2.new(0, 10, 0.5, 0)
local v_u_30 = UDim2.new(0.25, 90, 0.208, 75)
local v_u_31 = {}
v_u_31.__index = v_u_31
function v_u_31._new() -- name: _new
	-- upvalues: (copy) v_u_31, (copy) v_u_25
	local v32 = v_u_31
	local v33 = setmetatable({}, v32)
	v33.Frame = v_u_25:GetTo("MainFrame", "SideTasks")
	v33._local_fighter = nil
	v33._side_slots = {}
	v33._duel_connections = {}
	v33._teleport_cooldown = 0
	v33._generate_queued = false
	v33._center_alert_hash = 0
	v33._center_alert_connection = nil
	v33._is_open = false
	v33:_Init()
	return v33
end
function v_u_31._PlayCenterAlertEffect(p_u_34) -- name: _PlayCenterAlertEffect
	-- upvalues: (copy) v_u_21, (copy) v_u_12, (copy) v_u_8, (copy) v_u_10, (copy) v_u_3, (copy) v_u_29, (copy) v_u_28, (copy) v_u_30
	local v35 = p_u_34._local_fighter and (p_u_34._local_fighter:Get("IsInShootingRange") and not v_u_21.PageSystem.CurrentPage)
	if v35 then
		v35 = v_u_12:Get("BeginnerTasksCompleted") < v_u_8.NUM_BEGINNER_TASKS
	end
	if v35 then
		if p_u_34._center_alert_connection then
			p_u_34._center_alert_connection:Disconnect()
			p_u_34._center_alert_connection = nil
		end
		p_u_34._center_alert_hash = p_u_34._center_alert_hash + 1
		local v_u_36 = p_u_34._center_alert_hash
		local v_u_37 = v_u_10.new(0, 1, 10)
		p_u_34._center_alert_connection = v_u_3.RenderStepped:Connect(function()
			-- upvalues: (copy) p_u_34, (copy) v_u_36, (copy) v_u_37, (ref) v_u_29, (ref) v_u_28
			if p_u_34._center_alert_hash == v_u_36 then
				local v38 = v_u_37.Value
				local v39 = p_u_34.Frame.Parent.AbsolutePosition + p_u_34.Frame.Parent.AbsoluteSize / 2 - p_u_34.Frame.Container.AbsoluteSize.X * Vector2.new(0.5, 0) - p_u_34.Frame.AbsolutePosition
				local v40 = UDim2.new(0, v39.X, 0, v39.Y)
				local v41 = UDim2.new(v_u_29.X.Scale + (v40.X.Scale - v_u_29.X.Scale) * v38, v_u_29.X.Offset + (v40.X.Offset - v_u_29.X.Offset) * v38, v_u_29.Y.Scale + (v40.Y.Scale - v_u_29.Y.Scale) * v38, v_u_29.Y.Offset + (v40.Y.Offset - v_u_29.Y.Offset) * v38)
				local v42 = p_u_34.Frame.Container
				if not p_u_34._is_open then
					v41 = v_u_28
				end
				v42:TweenPosition(v41, "InOut", "Linear", 0, true)
				p_u_34.Frame.Container.Background.UIGradient.Transparency = NumberSequence.new(0, 1 - v38)
			end
		end)
		v_u_37.Target = 1
		p_u_34.Frame.Container.Size = v_u_30
		p_u_34.Frame.Container:TweenSize(UDim2.new(v_u_30.X.Scale * 1.25, v_u_30.X.Offset * 1.25, v_u_30.Y.Scale * 1.25, v_u_30.Y.Offset * 1.25), "InOut", "Quint", 0.75, true)
		for _ = 1, 5 do
			wait(0.06)
			if p_u_34._center_alert_hash == v_u_36 then
				p_u_34.Frame.Container.Visible = true
				wait(0.12)
				if p_u_34._center_alert_hash == v_u_36 then
					continue
				end
			end
		end
		wait(2)
		if p_u_34._center_alert_hash == v_u_36 then
			v_u_37.Target = 0
			p_u_34.Frame.Container:TweenSize(v_u_30, "Out", "Quint", 0.5, true)
			wait(2)
			if p_u_34._center_alert_hash == v_u_36 then
				p_u_34._center_alert_connection:Disconnect()
				p_u_34._center_alert_connection = nil
				local v43 = p_u_34.Frame.Container
				local v44
				if p_u_34._is_open then
					v44 = v_u_29
				else
					v44 = v_u_28
				end
				v43.Position = v44
				p_u_34.Frame.Container.Background.UIGradient.Transparency = NumberSequence.new(0, 1)
			end
		else
			return
		end
	else
		return
	end
end
function v_u_31._UpdateBackground(p45) -- name: _UpdateBackground
	p45.Frame.Container.Background.Size = UDim2.new(1, 0, 0, p45.Frame.Container.Slots.BackgroundEnd.AbsolutePosition.Y - p45.Frame.Container.Slots.AbsolutePosition.Y)
end
function v_u_31._Generate(p_u_46) -- name: _Generate
	-- upvalues: (copy) v_u_17, (copy) v_u_12, (copy) v_u_8, (copy) v_u_21, (copy) v_u_20, (copy) v_u_22, (copy) v_u_19, (copy) v_u_18, (copy) v_u_2, (copy) v_u_13, (copy) v_u_7, (copy) v_u_5, (copy) v_u_9, (copy) v_u_27, (copy) v_u_25, (copy) v_u_24, (copy) v_u_6, (copy) v_u_26, (copy) v_u_16, (copy) v_u_29, (copy) v_u_28
	for _, v47 in pairs(p_u_46._side_slots) do
		v47:Destroy()
	end
	p_u_46._side_slots = {}
	v_u_17:ClearStatusElements(p_u_46.Frame.Container.Slots.Header.Title)
	p_u_46._generate_cooldown = tick() + 0.2
	local v48 = v_u_12:GetStatistic("StatisticFavoriteWeapon")
	local v49 = p_u_46._local_fighter and p_u_46._local_fighter.EquippedItem and p_u_46._local_fighter.EquippedItem.Name or ((v48 == "N/A" or not v48) and "Assault Rifle" or v48)
	local v50 = v_u_12:Get("BeginnerTasksCompleted")
	local v51 = v_u_8.NUM_BEGINNER_TASKS <= v50
	local v52 = p_u_46._local_fighter and not (v_u_21.PageSystem.CurrentPage or v_u_20.IsOpen) and not (v_u_22:IsVisible() or v_u_19.Enabled or (v_u_18.EditorEnabled or v_u_2.MenuIsOpen)) and (((not v_u_12:GetSetting("Hide Tasks In Duels") or (not v_u_13.CurrentDuelSubject or v_u_13.CurrentDuelSubject:Get("Status") == "RoundStarting")) and true or false) and ((not v_u_13.CurrentDuelSubject or v_u_13.CurrentDuelSubject.LocalDueler and (v_u_13.CurrentDuelSubject:Get("Status") ~= "GameOver" and not v_u_13.CurrentDuelSubject.DuelInterface.Voting:IsOpen() and not (v_u_13.CurrentDuelSubject.DuelInterface.Scoreboard:IsOpen() or v_u_13.CurrentDuelSubject:Get("HideMostDuelInterfaceElements")))) and (not v_u_12:GetSetting("Hide HUD") and (v_u_12:GetStatistic("StatisticDuelsPlayed") < 2 and p_u_46._local_fighter))))
	if v52 then
		v52 = p_u_46._local_fighter:Get("IsInShootingRange")
	end
	local v53
	if v52 then
		v53 = v_u_12:Get("TasksInterfaceOverride") ~= nil
	else
		v53 = v52
	end
	local v54 = not v53
	if v54 then
		if v52 then
			v54 = not v_u_12:AreTasksCompleted()
		else
			v54 = v52
		end
	end
	local v55 = not (v53 or v54)
	if v55 then
		if v52 then
			v52 = #v_u_7:GetWeaponContracts(v49) > 0
		end
	else
		v52 = v55
	end
	p_u_46._is_open = v53 or (v54 or v52)
	local v56 = v_u_5.SHOOTING_RANGE_ACTIVE
	if v56 then
		if v54 then
			v56 = v50 <= v_u_8.NUM_BEGINNER_TASKS - 2
		else
			v56 = v54
		end
	end
	local v57 = v_u_5.QUEUES_ACTIVE
	if v57 then
		v57 = not v53
		if v57 then
			v57 = not v56
		end
	end
	local v58 = p_u_46.Frame.Container.Slots.ToShootingRange
	local v59 = v56 and (p_u_46._local_fighter and not p_u_46._local_fighter:Get("IsInShootingRange"))
	if v59 then
		v59 = not v_u_13.CurrentDuelSubject
	end
	v58.Visible = v59
	local v60 = p_u_46.Frame.Container.Slots.ToDuels
	if v57 then
		v57 = not v_u_13.CurrentDuelSubject
	end
	v60.Visible = v57
	p_u_46.Frame.Container.Slots.ButtonsBuffer.Visible = p_u_46.Frame.Container.Slots.ToShootingRange.Visible or p_u_46.Frame.Container.Slots.ToDuels.Visible
	p_u_46.Frame.Container.Slots.Header.Title.Text = v53 and "Special Mission" or (v52 and v49 and v49 or (v54 and (v51 and "Daily Tasks" or ("Beginner Tasks   [" .. v50 + 1 .. " / " .. v_u_8.NUM_BEGINNER_TASKS .. "]" or "")) or ""))
	p_u_46.Frame.Container.Slots.Header.Title.Icon.Image = v52 and (v_u_9.ViewModels[v49].Image or "rbxassetid://17653923757") or "rbxassetid://17653923757"
	p_u_46.Frame.Container.Slots.Header.Title.Icon.Size = v52 and UDim2.new(6, 0, 4.5, 0) or UDim2.new(2, 0, 1.5, 0)
	if not v53 and v52 then
		v_u_17:ApplyItemStatusToText(p_u_46.Frame.Container.Slots.Header.Title, v_u_9.Items[v49].Status)
	end
	local function v74(p61, p62) -- name: create_task_slot
		-- upvalues: (ref) v_u_8, (ref) v_u_27, (copy) p_u_46, (ref) v_u_25, (ref) v_u_24
		local v63 = p62.TaskInfo or v_u_8.Info[p62.Name]
		local v64 = p62.Goal or v63.Goal
		local v65 = v64 <= p62.Progress
		local v66 = v_u_27:Clone()
		v66.LayoutOrder = p61
		local v67 = v66.Container.Progress.Bar
		local v68 = UDim2.new
		local v69 = p62.Progress / v64
		v67.Size = v68(math.clamp(v69, 0, 1), 0, 1, 2)
		v66.Container.Progress.Bar.BackgroundColor3 = v65 and Color3.fromRGB(100, 255, 50) or Color3.fromRGB(0, 190, 255)
		v66.Container.TitleContainer.Title.Text = v63.Title
		v66.Container.Goal.Text = string.format("%s <font size=\"8\">/ %s</font>", p62.Progress, v64)
		v66.Container.Goal.Visible = not v65
		v66.Container.Icon.Image = v63.Icon
		v66.Completed.Visible = v65
		v66.Parent = p_u_46.Frame.Container.Slots
		local v70 = p_u_46._side_slots
		table.insert(v70, v66)
		v_u_25:ScrollingTextLabel(v66.Container.TitleContainer, v66.Container.TitleContainer.Title, v66.Container.Goal)
		if not v65 then
			for _, v71 in pairs({ v63.Rewards, p62.BonusRewards or {} }) do
				for _, v72 in pairs(v71) do
					local v73 = v_u_24.new(v72)
					v73:SetBubbleAutoCloseDelay(3)
					v73:SetParent(v66.Reward)
				end
			end
		end
	end
	if v53 then
		for v75, v76 in pairs(v_u_12:Get("TasksInterfaceOverride")) do
			v74(v75, v76)
		end
	end
	if v54 then
		for v77, v78 in pairs(v_u_12:Get("Tasks")) do
			v74(v77, v78)
		end
	end
	local v79
	if v52 then
		v79 = true
		for v80, v81 in pairs(v_u_7:GetWeaponContracts(v49)) do
			local v82 = v_u_7.Contracts[v81]
			local v83 = v_u_6.Info[v82.StatisticName]
			local v84 = v_u_12:GetWeaponStatistic(v82.Identifier, v82.StatisticName, v82.ExtraStatisticNames)
			for _, v85 in pairs(v82.Milestones) do
				local v86, v87 = table.unpack(v85)
				if v86 <= v84 then
					continue
				end
				v79 = false
				local v88 = v_u_26:Clone()
				v88.LayoutOrder = v80
				local v89 = v88.Container.Progress.Bar
				local v90 = UDim2.new
				local v91 = v84 / v86
				v89.Size = v90(math.clamp(v91, 0, 1), 0, 1, 2)
				v88.Container.Goal.Text = string.format("%s <font size=\"8\">/ %s</font>", v83.TostringFunction(v84), v83.TostringFunction(v86))
				v88.Container.TitleContainer.Title.Text = v82.FullDisplayName
				v88.Parent = p_u_46.Frame.Container.Slots
				local v92 = p_u_46._side_slots
				table.insert(v92, v88)
				v_u_25:ScrollingTextLabel(v88.Container.TitleContainer, v88.Container.TitleContainer.Title, v88.Container.Goal)
				if not v87 then
					break
				end
				local v93 = v_u_24.new(v87)
				v93:SetBubbleAutoCloseDelay(3)
				v93.Frame.Parent = v88.Reward
			end
		end
	else
		v79 = false
	end
	p_u_46.Frame.Container.Slots.ContractsCompleted.Visible = v79
	p_u_46.Frame.Container.Slots.ContractsCompleted.Title.Text = "Congratulations! You\'ve completed every " .. v49 .. " contract!"
	v_u_16:OnStep("LobbyTasks", "TaskRefresh", v54 and (v51 and v_u_12:AreTasksCompleted()) and function(_, p94)
		-- upvalues: (copy) p_u_46
		p_u_46.Frame.Container.Slots.Header.Title.Text = "New tasks in " .. p94
	end or nil)
	local v95 = p_u_46.Frame.Container
	local v96
	if p_u_46._is_open then
		v96 = v_u_29
	else
		v96 = v_u_28
	end
	v95:TweenPosition(v96, "Out", "Quint", p_u_46._is_open and 0.25 or 1.25, true)
	p_u_46:_UpdateBackground()
end
function v_u_31._GenerateThrottled(p_u_97) -- name: _GenerateThrottled
	if tick() > p_u_97._generate_cooldown then
		p_u_97:_Generate()
		return
	elseif not p_u_97._generate_queued then
		p_u_97._generate_queued = true
		task.delay(p_u_97._generate_cooldown - tick(), function()
			-- upvalues: (copy) p_u_97
			p_u_97._generate_queued = false
			p_u_97:_Generate()
		end)
	end
end
function v_u_31._UpdateCurrentDuelSubject(p_u_98) -- name: _UpdateCurrentDuelSubject
	-- upvalues: (copy) v_u_13
	for _, v99 in pairs(p_u_98._duel_connections) do
		v99:Disconnect()
	end
	p_u_98._duel_connections = {}
	if v_u_13.CurrentDuelSubject then
		local v100 = p_u_98._duel_connections
		local v101 = v_u_13.CurrentDuelSubject:GetDataChangedSignal("Status")
		table.insert(v100, v101:Connect(function()
			-- upvalues: (copy) p_u_98
			p_u_98:_Generate()
		end))
		local v102 = p_u_98._duel_connections
		local v103 = v_u_13.CurrentDuelSubject:GetDataChangedSignal("HideMostDuelInterfaceElements")
		table.insert(v102, v103:Connect(function()
			-- upvalues: (copy) p_u_98
			p_u_98:_Generate()
		end))
		local v104 = p_u_98._duel_connections
		local v105 = v_u_13.CurrentDuelSubject.DuelInterface.Voting.VisibilityChanged
		table.insert(v104, v105:Connect(function()
			-- upvalues: (copy) p_u_98
			p_u_98:_Generate()
		end))
		local v106 = p_u_98._duel_connections
		local v107 = v_u_13.CurrentDuelSubject.DuelInterface.Scoreboard.VisibilityChanged
		table.insert(v106, v107:Connect(function()
			-- upvalues: (copy) p_u_98
			p_u_98:_Generate()
		end))
		p_u_98:_Generate()
	else
		p_u_98:_Generate()
	end
end
function v_u_31._HookLocalFighter(p_u_108) -- name: _HookLocalFighter
	-- upvalues: (copy) v_u_14
	p_u_108._local_fighter = v_u_14:WaitForLocalFighter()
	p_u_108._local_fighter:GetDataChangedSignal("IsInShootingRange"):Connect(function()
		-- upvalues: (copy) p_u_108
		p_u_108:_Generate()
		p_u_108:_PlayCenterAlertEffect()
	end)
	p_u_108._local_fighter:GetDataChangedSignal("IsInDuel"):Connect(function()
		-- upvalues: (copy) p_u_108
		p_u_108:_Generate()
	end)
	p_u_108._local_fighter.EquippedItemChanged:Connect(function()
		-- upvalues: (copy) p_u_108
		p_u_108:_GenerateThrottled()
	end)
	p_u_108:_Generate()
	p_u_108:_PlayCenterAlertEffect()
end
function v_u_31._Init(p_u_109) -- name: _Init
	-- upvalues: (copy) v_u_11, (copy) v_u_15, (copy) v_u_12, (copy) v_u_20, (copy) v_u_21, (copy) v_u_22, (copy) v_u_19, (copy) v_u_18, (copy) v_u_13, (copy) v_u_2, (copy) v_u_23
	p_u_109.Frame.Container.Slots.ToShootingRange.Button.MouseButton1Click:Connect(function()
		-- upvalues: (copy) p_u_109, (ref) v_u_11
		if tick() >= p_u_109._teleport_cooldown then
			p_u_109._teleport_cooldown = tick() + 1
			v_u_11:Enter(true)
		end
	end)
	p_u_109.Frame.Container.Slots.ToDuels.Button.MouseButton1Click:Connect(function()
		-- upvalues: (copy) p_u_109, (ref) v_u_15
		if tick() >= p_u_109._teleport_cooldown then
			p_u_109._teleport_cooldown = tick() + 1
			v_u_15:ToDuels()
		end
	end)
	p_u_109.Frame.Container.Slots:GetPropertyChangedSignal("AbsolutePosition"):Connect(function()
		-- upvalues: (copy) p_u_109
		p_u_109:_UpdateBackground()
	end)
	p_u_109.Frame.Container.Slots.BackgroundEnd:GetPropertyChangedSignal("AbsolutePosition"):Connect(function()
		-- upvalues: (copy) p_u_109
		p_u_109:_UpdateBackground()
	end)
	v_u_12:GetDataChangedSignal("BeginnerTasksCompleted"):Connect(function()
		-- upvalues: (copy) p_u_109
		p_u_109:_Generate()
		p_u_109:_PlayCenterAlertEffect()
	end)
	v_u_12:GetDataChangedSignal("Tasks"):Connect(function()
		-- upvalues: (copy) p_u_109
		p_u_109:_Generate()
	end)
	v_u_12:GetSettingChangedSignal("Hide Tasks In Duels"):Connect(function()
		-- upvalues: (copy) p_u_109
		p_u_109:_Generate()
	end)
	v_u_12:GetSettingChangedSignal("Hide HUD"):Connect(function()
		-- upvalues: (copy) p_u_109
		p_u_109:_Generate()
	end)
	v_u_12:GetDataChangedSignal("StatisticDuelsPlayed"):Connect(function()
		-- upvalues: (copy) p_u_109
		p_u_109:_Generate()
	end)
	v_u_12:GetDataChangedSignal("TasksInterfaceOverride"):Connect(function()
		-- upvalues: (copy) p_u_109
		p_u_109:_Generate()
	end)
	v_u_12.StatisticsUpdated:Connect(function()
		-- upvalues: (copy) p_u_109
		p_u_109:_Generate()
	end)
	v_u_20.Opened:Connect(function()
		-- upvalues: (copy) p_u_109
		p_u_109:_Generate()
	end)
	v_u_21.PageSystem.PagesActivity:Connect(function()
		-- upvalues: (copy) p_u_109
		p_u_109:_Generate()
		p_u_109:_PlayCenterAlertEffect()
	end)
	v_u_22.VisibilityChanged:Connect(function()
		-- upvalues: (copy) p_u_109
		p_u_109:_Generate()
	end)
	v_u_19.EnabledChanged:Connect(function()
		-- upvalues: (copy) p_u_109
		p_u_109:_Generate()
	end)
	v_u_18.EditorEnabledChanged:Connect(function()
		-- upvalues: (copy) p_u_109
		p_u_109:_Generate()
	end)
	v_u_13.DuelSubjectChanged:Connect(function()
		-- upvalues: (copy) p_u_109
		p_u_109:_UpdateCurrentDuelSubject()
	end)
	v_u_2:GetPropertyChangedSignal("MenuIsOpen"):Connect(function()
		-- upvalues: (copy) p_u_109
		p_u_109:_Generate()
	end)
	p_u_109:_Generate()
	p_u_109:_UpdateCurrentDuelSubject()
	p_u_109:_UpdateBackground()
	task.spawn(p_u_109._HookLocalFighter, p_u_109)
	v_u_23:Add(p_u_109.Frame.Container.Slots.ToDuels.Button)
	v_u_23:Add(p_u_109.Frame.Container.Slots.ToShootingRange.Button)
end
return v_u_31._new()