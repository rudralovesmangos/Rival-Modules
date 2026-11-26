local v1 = game:GetService("ReplicatedStorage")
local v2 = game:GetService("Players")
local v_u_3 = require(v1.Modules.CONSTANTS)
local v_u_4 = require(v1.Modules.MonetizationLibrary)
local v_u_5 = require(v1.Modules.CosmeticLibrary)
local v_u_6 = require(v1.Modules.EventLibrary)
local v_u_7 = require(v1.Modules.Utility)
local v_u_8 = require(v2.LocalPlayer.PlayerScripts.Controllers.ComplianceController)
local v_u_9 = require(v2.LocalPlayer.PlayerScripts.Controllers.PlayerDataController)
local v_u_10 = require(v2.LocalPlayer.PlayerScripts.Controllers.EventController)
local v_u_11 = require(v2.LocalPlayer.PlayerScripts.Controllers.ShopController)
local v_u_12 = require(v2.LocalPlayer.PlayerScripts.Modules:WaitForChild("BaseMatchmakingQueueSlot"):WaitForChild("MatchmakingQueueSlot"))
local v_u_13 = require(v2.LocalPlayer.PlayerScripts.Modules:WaitForChild("BaseShopSlot"):WaitForChild("ShopSlot"))
local v_u_14 = require(v2.LocalPlayer.PlayerScripts.Modules:WaitForChild("AdventCalendarSlot"))
local v_u_15 = require(v2.LocalPlayer.PlayerScripts.Modules:WaitForChild("PromptSystem"))
local v_u_16 = require(v2.LocalPlayer.PlayerScripts.Modules:WaitForChild("ButtonEffect"))
local v_u_17 = require(v2.LocalPlayer.PlayerScripts.Modules.UserInterface:WaitForChild("Pages"))
local v_u_18 = require(v2.LocalPlayer.PlayerScripts.Modules:WaitForChild("RewardSlot"))
local v_u_19 = require(v2.LocalPlayer.PlayerScripts.Modules:WaitForChild("TaskSlot"))
local v_u_20 = require(v2.LocalPlayer.PlayerScripts.Modules:WaitForChild("Page"))
local v_u_21 = setmetatable({}, v_u_20)
v_u_21.__index = v_u_21
function v_u_21._new() -- name: _new
	-- upvalues: (copy) v_u_20, (copy) v_u_21, (copy) v_u_15, (copy) v_u_14
	local v22 = v_u_20.new(script.Name)
	local v23 = v_u_21
	local v24 = setmetatable(v22, v23)
	v24.CloseButton = v24.PageFrame:WaitForChild("Close")
	v24.PromptsFrame = v24.PageFrame:WaitForChild("Prompts")
	v24.LockedFrame = v24.PageFrame:WaitForChild("Locked")
	v24.LockedDescriptionText = v24.LockedFrame:WaitForChild("Description")
	v24.List = v24.PageFrame:WaitForChild("List")
	v24.Container = v24.List:WaitForChild("Container")
	v24.Layout = v24.Container:WaitForChild("Layout")
	v24.HeaderFrame = v24.Container:WaitForChild("Header")
	v24.HeaderPicture = v24.HeaderFrame:WaitForChild("Picture")
	v24.HeaderTitleText = v24.HeaderFrame:WaitForChild("Title")
	v24.HeaderCountdownText = v24.HeaderFrame:WaitForChild("Countdown")
	v24.EventTasksFrame = v24.Container:WaitForChild("EventTasks")
	v24.EventTasksLockedFrame = v24.EventTasksFrame:WaitForChild("Locked")
	v24.EventTasksLockedDescription = v24.EventTasksLockedFrame:WaitForChild("Description")
	v24.EventTasksUnlockedFrame = v24.EventTasksFrame:WaitForChild("Unlocked")
	v24.EventTasksContainer = v24.EventTasksUnlockedFrame:WaitForChild("Container")
	v24.EventTasksTitleText = v24.EventTasksContainer:WaitForChild("Title")
	v24.EventTasksSlotsFrame = v24.EventTasksContainer:WaitForChild("Slots")
	v24.EventTasksSlotsLayout = v24.EventTasksSlotsFrame:WaitForChild("Layout")
	v24.RushFrame = v24.EventTasksUnlockedFrame:WaitForChild("Rush")
	v24.RushContainer = v24.RushFrame:WaitForChild("Container")
	v24.RushTitleText = v24.RushContainer:WaitForChild("Title")
	v24.RushProgressFrame = v24.RushContainer:WaitForChild("Progress")
	v24.RushProgressBar = v24.RushProgressFrame:WaitForChild("Bar")
	v24.RushProgressCompleted = v24.RushProgressFrame:WaitForChild("Completed")
	v24.RushProgressText = v24.RushProgressFrame:WaitForChild("Title")
	v24.ShopEntriesFrame = v24.Container:WaitForChild("ShopEntries")
	v24.ShopEntriesContainer = v24.ShopEntriesFrame:WaitForChild("Container")
	v24.ShopEntriesTitleText = v24.ShopEntriesContainer:WaitForChild("Title")
	v24.ShopEntriesSlotsFrame = v24.ShopEntriesContainer:WaitForChild("Slots")
	v24.ShopEntriesSlotsLayout = v24.ShopEntriesSlotsFrame:WaitForChild("Layout")
	v24.AdventCalendarFrame = v24.Container:WaitForChild("AdventCalendar")
	v24.SkinBundleFrame = v24.Container:WaitForChild("SkinBundle")
	v24.SkinBundleContainer = v24.SkinBundleFrame:WaitForChild("Container")
	v24.SkinBundleRewardsFrame = v24.SkinBundleContainer:WaitForChild("Rewards")
	v24.PromptSystem = v_u_15.new(v24.PromptsFrame)
	v24.AdventCalendarSlot = v_u_14.new(v24.AdventCalendarFrame)
	v24._open_connections = {}
	v24._task_slots = {}
	v24._shop_slots = {}
	v24:_Init()
	return v24
end
function v_u_21.Open(p_u_25, ...) -- name: Open
	-- upvalues: (copy) v_u_20, (copy) v_u_9
	v_u_20.Open(p_u_25, ...)
	p_u_25.AdventCalendarSlot:SetEnabled(true)
	local v26 = p_u_25._open_connections
	local v27 = v_u_9:GetDataChangedSignal("Tasks")
	table.insert(v26, v27:Connect(function()
		-- upvalues: (copy) p_u_25
		p_u_25:_GenerateTasks()
	end))
	local v28 = p_u_25._open_connections
	local v29 = v_u_9:GetDataChangedSignal("EventTasks")
	table.insert(v28, v29:Connect(function()
		-- upvalues: (copy) p_u_25
		p_u_25:_GenerateTasks()
	end))
	local v30 = p_u_25._open_connections
	local v31 = v_u_9:GetDataChangedSignal("CosmeticInventory")
	table.insert(v30, v31:Connect(function()
		-- upvalues: (copy) p_u_25
		p_u_25:_GenerateShopEntries()
	end))
	local v32 = p_u_25._open_connections
	local v33 = v_u_9:GetDataChangedSignal("WeaponInventory")
	table.insert(v32, v33:Connect(function()
		-- upvalues: (copy) p_u_25
		p_u_25:_GenerateShopEntries()
	end))
	local v34 = p_u_25._open_connections
	local v35 = v_u_9:GetDataChangedSignal("EventCurrencyRushProgress")
	table.insert(v34, v35:Connect(function()
		-- upvalues: (copy) p_u_25
		p_u_25:_UpdateRush()
	end))
	local v36 = p_u_25._open_connections
	local v37 = v_u_9:GetDataChangedSignal("StatisticDuelsPlayed")
	table.insert(v36, v37:Connect(function()
		-- upvalues: (copy) p_u_25
		p_u_25:_UpdateLocked()
	end))
	task.spawn(function()
		-- upvalues: (copy) p_u_25
		local v38 = p_u_25._is_open_hash
		while v38 == p_u_25._is_open_hash do
			p_u_25:_UpdateCountdown()
			wait(1)
		end
	end)
	p_u_25:_UpdateRush()
	p_u_25:_UpdateCountdown()
	p_u_25:_UpdateLocked()
	p_u_25:_GenerateTasks()
	p_u_25:_GenerateShopEntries()
end
function v_u_21.Close(p39, ...) -- name: Close
	-- upvalues: (copy) v_u_20
	p39.AdventCalendarSlot:SetEnabled(false)
	v_u_20.Close(p39, ...)
end
function v_u_21._UpdateLayouts(p40) -- name: _UpdateLayouts
	p40.List.CanvasSize = UDim2.new(0, 0, 0, p40.Layout.AbsoluteContentSize.Y)
	p40.ShopEntriesFrame.Size = UDim2.new(1, 0, 0, p40.ShopEntriesContainer.AbsoluteSize.Y * 0.3 + p40.ShopEntriesSlotsLayout.AbsoluteContentSize.Y)
	local v41 = p40.EventTasksFrame
	local v42
	if p40.EventTasksLockedFrame.Visible then
		v42 = UDim2.new(1, 0, 0.075, 0)
	else
		v42 = UDim2.new(1, 0, 0, p40.EventTasksContainer.AbsoluteSize.Y * 0.2 + p40.EventTasksSlotsLayout.AbsoluteContentSize.Y + p40.RushFrame.AbsoluteSize.Y)
	end
	v41.Size = v42
end
function v_u_21._UpdateLocked(p43) -- name: _UpdateLocked
	-- upvalues: (copy) v_u_6, (copy) v_u_9
	local v44 = v_u_6.NUM_GAMES_NEEDED_TO_PARTICIPATE - v_u_9:GetStatistic("StatisticDuelsPlayed")
	p43.List.Visible = v44 <= 0
	p43.LockedFrame.Visible = v44 > 0
	p43.LockedDescriptionText.Text = "Play " .. v44 .. " more duels to gain access!"
end
function v_u_21._UpdateCountdown(p45) -- name: _UpdateCountdown
	-- upvalues: (copy) v_u_10, (copy) v_u_7
	local v46 = v_u_10:GetTimeRemaining()
	p45.HeaderCountdownText.Text = v46 and v46 == 0 and "Ending any minute now!" or (v46 and (v46 > 0 and "Ending in " .. v_u_7:TimeFormat2(v46)) or "Here for a limited time only!")
end
function v_u_21._UpdateRush(p47) -- name: _UpdateRush
	-- upvalues: (copy) v_u_9, (copy) v_u_6
	local v48 = v_u_9:Get("EventCurrencyRushProgress")
	local v49 = v48 / v_u_6.CURRENCY_RUSH_DAILY_LIMIT
	local v50 = math.clamp(v49, 0, 1)
	p47.RushProgressText.Text = v50 < 1 and v48 .. " / " .. v_u_6.CURRENCY_RUSH_DAILY_LIMIT or ""
	p47.RushProgressCompleted.Visible = v50 >= 1
	p47.RushProgressBar.Size = UDim2.new(v50, 0, 1, 2)
	p47.RushProgressBar.BackgroundColor3 = v50 < 1 and v_u_6.EVENT_DETAILS.CURRENCY_COLOR or Color3.fromRGB(100, 255, 50)
end
function v_u_21._GenerateTasks(p51, _) -- name: _GenerateTasks
	-- upvalues: (copy) v_u_9, (copy) v_u_19
	for _, v52 in pairs(p51._task_slots) do
		v52:Destroy()
	end
	p51._task_slots = {}
	p51.EventTasksLockedFrame.Visible = not v_u_9:AreTasksCompleted()
	p51.EventTasksUnlockedFrame.Visible = not p51.EventTasksLockedFrame.Visible
	local v53 = v_u_9:Get("EventTasks")
	for _, v54 in pairs(v53 or {}) do
		local v55 = v_u_19.new(v54)
		v55:SetParent(p51.EventTasksSlotsFrame)
		local v56 = p51._task_slots
		table.insert(v56, v55)
	end
	p51:_UpdateLayouts()
end
function v_u_21._GenerateShopEntries(p_u_57) -- name: _GenerateShopEntries
	-- upvalues: (copy) v_u_6, (copy) v_u_13, (copy) v_u_11
	for _, v58 in pairs(p_u_57._shop_slots) do
		v58:Destroy()
	end
	p_u_57._shop_slots = {}
	for _, v59 in pairs(v_u_6.IS_ACTIVE and v_u_6.SHOP_ENTRIES_OVERVIEW or {}) do
		local v_u_60 = v_u_13.new(v_u_11:GetShopEntry(v59))
		v_u_60.Frame.Parent = p_u_57.ShopEntriesSlotsFrame
		local v61 = p_u_57._shop_slots
		table.insert(v61, v_u_60)
		v_u_60.RewardSlot:OnClick(function()
			-- upvalues: (copy) v_u_60, (copy) p_u_57
			if not (v_u_60.IsLocked or v_u_60.IsOwned) then
				p_u_57.PromptSystem:Open("InspectShopEntry", v_u_60.ShopEntry.EntryName)
			end
		end)
	end
end
function v_u_21._Setup(p_u_62) -- name: _Setup
	-- upvalues: (copy) v_u_6, (copy) v_u_12, (copy) v_u_4, (copy) v_u_5, (copy) v_u_8, (copy) v_u_3, (copy) v_u_18, (copy) v_u_11
	p_u_62.HeaderPicture.Image = v_u_6.EVENT_DETAILS.OVERVIEW_BANNER_IMAGE
	p_u_62.HeaderTitleText.Text = string.upper(v_u_6.EVENT_NAME or "???") .. " EVENT"
	p_u_62.EventTasksTitleText.Text = "Earn " .. v_u_6.EVENT_DETAILS.CURRENCY_NAME_PLURAL .. "!"
	p_u_62.ShopEntriesTitleText.Text = "Spend " .. v_u_6.EVENT_DETAILS.CURRENCY_NAME_PLURAL .. "!"
	p_u_62.RushTitleText.Text = string.upper(v_u_6.EVENT_DETAILS.CURRENCY_NAME) .. " RUSH \226\128\148 Earn \195\151" .. v_u_6.CURRENCY_RUSH_MULTIPLIER .. " " .. v_u_6.EVENT_DETAILS.CURRENCY_NAME_PLURAL .. " every day!"
	p_u_62.EventTasksLockedDescription.Text = "Complete your Daily Tasks to start earning " .. v_u_6.EVENT_DETAILS.CURRENCY_NAME_PLURAL .. "!"
	p_u_62.SkinBundleFrame.Visible = v_u_6.SKIN_BUNDLE_NAME ~= nil
	for v63, v64 in pairs(v_u_6.LTM_QUEUENAMES or {}) do
		local v65 = Instance.new("Frame")
		v65.Name = v64
		v65.AnchorPoint = Vector2.new(0.5, 0.5)
		v65.Size = UDim2.new(0.995, 0, 0.2, 0)
		v65.BackgroundTransparency = 1
		v65.LayoutOrder = 10 + v63
		v65.Parent = p_u_62.Container
		v_u_12.new(v64, v65).QueueStatus:Connect(function(p66)
			-- upvalues: (copy) p_u_62
			if p66 == "Success" then
				p_u_62:CloseRequest()
			else
				p_u_62.PromptSystem:Open("ErrorMessage", "Whoops!", p66 or "Server failed to respond, please try again")
			end
		end)
	end
	if v_u_6.SKIN_BUNDLE_NAME then
		local v67 = v_u_4.Bundles[v_u_6.SKIN_BUNDLE_NAME]
		for v68, v69 in pairs(v67.RewardsWithIndividualProductIDs) do
			if not v69[1] then
				continue
			end
			local v70 = v69[3]
			local v71 = v_u_5.Rewards[v70.Name]
			if v71 and (v71.Type == "Lootbox" and (v_u_8:ArePaidRandomItemsRestricted() and not v_u_3.SHOW_LOOTBOX_CONTENTS_TO_RESTRICTED_PLAYERS)) then
				continue
			end
			local v72 = v_u_18.new(v70)
			v72.Frame.LayoutOrder = v68
			v72:SetInteractable(false)
			v72:SetNameText("")
			v72:HideWeaponVisual()
			v72:SetParent(p_u_62.SkinBundleRewardsFrame)
		end
	end
	v_u_11:GetDailyShop()
end
function v_u_21._Init(p_u_73) -- name: _Init
	-- upvalues: (copy) v_u_17, (copy) v_u_6, (copy) v_u_16
	p_u_73.CloseButton.MouseButton1Click:Connect(function()
		-- upvalues: (copy) p_u_73
		p_u_73:CloseRequest()
	end)
	p_u_73.Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		-- upvalues: (copy) p_u_73
		p_u_73:_UpdateLayouts()
	end)
	p_u_73.EventTasksSlotsLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		-- upvalues: (copy) p_u_73
		p_u_73:_UpdateLayouts()
	end)
	p_u_73.ShopEntriesSlotsLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		-- upvalues: (copy) p_u_73
		p_u_73:_UpdateLayouts()
	end)
	p_u_73.SkinBundleContainer.MouseButton1Click:Connect(function()
		-- upvalues: (ref) v_u_17, (ref) v_u_6
		v_u_17.PageSystem:OpenPage("Shop")
		v_u_17.PageSystem:WaitForPage("Shop"):InspectSkinBundle(v_u_6.SKIN_BUNDLE_NAME)
	end)
	p_u_73.PromptSystem.PromptAdded:Connect(function(p74)
		-- upvalues: (copy) p_u_73, (ref) v_u_17
		p_u_73.List.CanvasPosition = Vector2.new(0, 0)
		if p74.InspectCurrencyPage then
			p74.InspectCurrencyPage:Connect(function()
				-- upvalues: (ref) v_u_17
				v_u_17.PageSystem:OpenPage("Shop")
				v_u_17.PageSystem:WaitForPage("Shop"):SetPage("Currency")
			end)
		end
	end)
	p_u_73:_Setup()
	p_u_73:_UpdateRush()
	p_u_73:_UpdateCountdown()
	p_u_73:_UpdateLocked()
	p_u_73:_UpdateLayouts()
	p_u_73:_GenerateTasks()
	p_u_73:_GenerateShopEntries()
	v_u_16:Add(p_u_73.CloseButton)
	v_u_16:Add(p_u_73.SkinBundleContainer, nil, {
		["HoverRatio"] = 1.025,
		["ReleaseRatio"] = 1.025
	})
end
return v_u_21._new()