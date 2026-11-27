local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("GuiService")
local v_u_3 = game:GetService("Players")
require(v1.Modules.CONSTANTS)
local v_u_4 = require(v1.Modules.CurrencyLibrary)
local v_u_5 = require(v1.Modules.EventLibrary)
require(v1.Modules.ItemLibrary)
local v_u_6 = require(v1.Modules.TaskLibrary)
local v7 = require(v1.Modules.TestLibrary)
local v_u_8 = require(v1.Modules.Utility)
local v_u_9 = require(v_u_3.LocalPlayer.PlayerScripts.Controllers:WaitForChild("PlayerDataController"))
local v_u_10 = require(v_u_3.LocalPlayer.PlayerScripts.Modules.UserInterface.Lobby:WaitForChild("Matchmaking"))
local v_u_11 = require(v_u_3.LocalPlayer.PlayerScripts.Modules.UserInterface:WaitForChild("MobileInputs"))
local v_u_12 = require(v_u_3.LocalPlayer.PlayerScripts.Modules.UserInterface:WaitForChild("Teleporting"))
local v_u_13 = require(v_u_3.LocalPlayer.PlayerScripts.Modules.UserInterface:WaitForChild("Equipment"))
local v_u_14 = require(v_u_3.LocalPlayer.PlayerScripts.Modules.UserInterface:WaitForChild("Queue"))
local v_u_15 = require(v_u_3.LocalPlayer.PlayerScripts.Modules.UserInterface:WaitForChild("Pages"))
local v_u_16 = require(v_u_3.LocalPlayer.PlayerScripts.Modules:WaitForChild("ButtonEffect"))
local v_u_17 = require(v_u_3.LocalPlayer.PlayerScripts.Modules:WaitForChild("UILibrary"))
local v_u_18 = v7:GetTestAttribute("StudioSkipOnboarding")
local v_u_19 = v_u_3.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("CurrencySlot")
local v_u_20 = {
	["EventCurrency"] = true,
	["SkinTickets"] = true
}
local v_u_21 = {
	["Shop"] = true,
	["EventOverview"] = true,
	["StreakRecovery"] = true
}
local v_u_22 = {}
v_u_22.__index = v_u_22
function v_u_22._new() -- name: _new
	-- upvalues: (copy) v_u_22, (copy) v_u_17
	local v23 = v_u_22
	local v24 = setmetatable({}, v23)
	v24.Frame = v_u_17:GetTo("MainFrame", "Lobby", "Currency")
	v24.Container = v24.Frame:WaitForChild("Container")
	v24._is_open = false
	v24._is_shrinked = false
	v24._currency_slots = {}
	v24._setup_update_slots_logic = false
	v24._scrolled_up_hooked = {}
	v24._scrolled_up = {}
	v24._keys_bubble = nil
	v24._keys_bubble_hash = 0
	v24:_Init()
	return v24
end
function v_u_22._UpdateOnboardingBubble(p_u_25) -- name: _UpdateOnboardingBubble
	-- upvalues: (copy) v_u_18, (copy) v_u_9, (copy) v_u_6, (copy) v_u_3
	if p_u_25._keys_bubble and not v_u_18 then
		local v26 = v_u_9:Get("BeginnerTasksCompleted") >= v_u_6.NUM_BEGINNER_TASKS
		local v27 = p_u_25._keys_bubble
		local v28 = p_u_25._is_open and not (p_u_25._is_shrinked or v26)
		if v28 then
			v28 = v_u_9:GetStatistic("StatisticDuelsPlayed") >= 2
		end
		v27.Visible = v28
		p_u_25._keys_bubble_hash = p_u_25._keys_bubble_hash + 1
		local v_u_29 = p_u_25._keys_bubble_hash
		if p_u_25._keys_bubble.Visible then
			task.spawn(function()
				-- upvalues: (copy) v_u_29, (copy) p_u_25, (ref) v_u_3
				while v_u_29 == p_u_25._keys_bubble_hash do
					if p_u_25._keys_bubble:IsDescendantOf(v_u_3) then
						p_u_25._keys_bubble:TweenPosition(UDim2.new(0.5, 0, 1, 0), "Out", "Sine", 0.5, true)
					end
					wait(0.5)
					if v_u_29 ~= p_u_25._keys_bubble_hash then
						return
					end
					if p_u_25._keys_bubble:IsDescendantOf(v_u_3) then
						p_u_25._keys_bubble:TweenPosition(UDim2.new(0.5, 0, 0.875, 0), "In", "Sine", 0.5, true)
					end
					wait(0.5)
				end
			end)
		end
	else
		return
	end
end
function v_u_22._IsScrolledUp(p30) -- name: _IsScrolledUp
	for _, v31 in pairs(p30._scrolled_up) do
		if not v31 then
			continue
		end
		return true
	end
end
function v_u_22._UpdateVisibility(p32) -- name: _UpdateVisibility
	-- upvalues: (copy) v_u_15, (copy) v_u_21, (copy) v_u_10, (copy) v_u_13, (copy) v_u_14, (copy) v_u_12, (copy) v_u_11, (copy) v_u_2, (copy) v_u_3
	local v33 = ((not v_u_15.PageSystem.CurrentPage or v_u_15.PageSystem.CurrentPage.Name == "StreakRecovery") and true or false or v_u_21[v_u_15.PageSystem.CurrentPage.Name]) and (not (v_u_10:IsOpened() or v_u_13:IsUnlocking()) and (not v_u_13:IsCustomizing() and (not v_u_13.IsOpen or v_u_13:IsOpenEffectDone())) and not (v_u_14:IsVisible() or v_u_12.Enabled or (v_u_11.EditorEnabled or v_u_2.MenuIsOpen)))
	if v33 then
		v33 = not p32:_IsScrolledUp()
	end
	p32._is_open = v33
	p32._is_shrinked = false
	if p32.Container:IsDescendantOf(v_u_3) then
		p32.Container:TweenPosition(p32._is_open and UDim2.new(0.5, 0, 0, 0) or UDim2.new(0.5, 0, -0.15, -30), "Out", "Quint", 0.25, true)
		p32.Container:TweenSize(p32._is_shrinked and UDim2.new(0.0375, 20, 0.0375, 20) or UDim2.new(0.075, 40, 0.075, 40), "Out", "Quint", 0.25, true)
	end
	p32:_UpdateOnboardingBubble()
end
function v_u_22._UpdateSlots(p34) -- name: _UpdateSlots
	-- upvalues: (copy) v_u_15, (copy) v_u_4, (copy) v_u_9, (copy) v_u_20, (copy) v_u_8
	local v35 = v_u_15.PageSystem:GetPage("Shop")
	local v36
	if v35 then
		v36 = v35:IsOpen()
	else
		v36 = v35
	end
	local v37
	if v36 then
		v37 = v35.CurrentPage == "Ranked"
	else
		v37 = v36
	end
	local v38 = v_u_15.PageSystem:GetPage("EventOverview")
	if v38 then
		v38 = v38:IsOpen()
	end
	for v39, v40 in pairs(p34._currency_slots) do
		local v41 = v_u_4.Info[v39]
		local v42 = v_u_9:Get(v41.DataName) or 0
		local v43 = ((not v41.OnlyDisplayAboveZeroBalance or v42 > 0) and true or false) and (v39 == "Glory" and v37 or v39 ~= "Glory" and not v37)
		if v43 then
			if v36 then
				v43 = v36
			elseif v39 == "WeaponKeys" then
				v43 = true
			elseif v38 then
				v43 = v_u_20[v39]
			else
				v43 = v38
			end
		end
		v40.Visible = v43
		v40.Title.Text = v_u_8:PrettyNumber(v42)
	end
end
function v_u_22._SetupUpdateSlotsLogic(p_u_44) -- name: _SetupUpdateSlotsLogic
	-- upvalues: (copy) v_u_15
	if not p_u_44._setup_update_slots_logic then
		p_u_44._setup_update_slots_logic = true
		task.spawn(function()
			-- upvalues: (ref) v_u_15, (copy) p_u_44
			v_u_15.PageSystem:WaitForPage("EventOverview").OpenChanged:Connect(function()
				-- upvalues: (ref) p_u_44
				p_u_44:_UpdateSlots()
			end)
			p_u_44:_UpdateSlots()
		end)
		task.spawn(function()
			-- upvalues: (ref) v_u_15, (copy) p_u_44
			local v45 = v_u_15.PageSystem:WaitForPage("Shop")
			v45.OpenChanged:Connect(function()
				-- upvalues: (ref) p_u_44
				p_u_44:_UpdateSlots()
			end)
			v45.CurrentPageChanged:Connect(function()
				-- upvalues: (ref) p_u_44
				p_u_44:_UpdateSlots()
			end)
			p_u_44:_UpdateSlots()
		end)
	end
end
function v_u_22._SetupScrollUpLogic(p_u_46, p_u_47) -- name: _SetupScrollUpLogic
	-- upvalues: (copy) v_u_15
	if not p_u_46._scrolled_up_hooked[p_u_47] then
		p_u_46._scrolled_up_hooked[p_u_47] = true
		local v_u_48 = v_u_15.PageSystem:WaitForPage(p_u_47)
		v_u_48.OpenChanged:Connect(function()
			-- upvalues: (copy) v_u_48, (copy) p_u_46, (copy) p_u_47
			if not v_u_48:IsOpen() then
				p_u_46._scrolled_up[p_u_47] = false
			end
		end)
		v_u_48.List:GetPropertyChangedSignal("CanvasPosition"):Connect(function()
			-- upvalues: (copy) v_u_48, (copy) p_u_46, (copy) p_u_47
			if v_u_48:IsOpen() and (v_u_48.List.CanvasPosition.Y <= 10 or not p_u_46._scrolled_up[p_u_47]) and (v_u_48.List.CanvasPosition.Y > 10 or p_u_46._scrolled_up[p_u_47]) then
				p_u_46._scrolled_up[p_u_47] = v_u_48.List.CanvasPosition.Y > 10
				p_u_46:_UpdateVisibility()
			end
		end)
		p_u_46:_UpdateVisibility()
	end
end
function v_u_22._Setup(p_u_49) -- name: _Setup
	-- upvalues: (copy) v_u_4, (copy) v_u_5, (copy) v_u_19, (copy) v_u_9, (copy) v_u_15, (copy) v_u_16
	for v50, v51 in pairs(v_u_4.Order) do
		local v52 = v_u_4.Info[v51]
		if v52.IsHidden or v51 == "EventCurrency" and not v_u_5.IS_ACTIVE then
			continue
		end
		local v53 = v_u_19:Clone()
		v53.LayoutOrder = v50
		v53.Icon.Icon.Image = v52.Image
		v53.Buy.Visible = v52.CanBePurchasedWithRobux
		v53.Parent = p_u_49.Container
		p_u_49._currency_slots[v51] = v53
		v_u_9:GetDataChangedSignal(v52.DataName):Connect(function()
			-- upvalues: (copy) p_u_49
			p_u_49:_UpdateSlots()
		end)
		v53.Buy.MouseButton1Click:Connect(function()
			-- upvalues: (ref) v_u_15
			v_u_15.PageSystem:OpenPage("Shop", true)
			v_u_15.PageSystem:WaitForPage("Shop"):SetPage("Currency")
		end)
		v_u_16:Add(v53.Buy)
		if v51 ~= "WeaponKeys" then
			continue
		end
		p_u_49._keys_bubble = v53.Icon.Bubble
		v53.Icon.MouseButton1Click:Connect(function()
			-- upvalues: (ref) v_u_15
			v_u_15.PageSystem:OpenPage("Tasks", true)
		end)
		v_u_16:Add(v53.Icon)
	end
end
function v_u_22._Init(p_u_54) -- name: _Init
	-- upvalues: (copy) v_u_13, (copy) v_u_15, (copy) v_u_21, (copy) v_u_14, (copy) v_u_12, (copy) v_u_11, (copy) v_u_10, (copy) v_u_9, (copy) v_u_2
	v_u_13.UnlockingChanged:Connect(function()
		-- upvalues: (copy) p_u_54
		p_u_54:_UpdateVisibility()
	end)
	v_u_13.Opened:Connect(function()
		-- upvalues: (copy) p_u_54
		p_u_54:_UpdateVisibility()
	end)
	v_u_13.SelectedWeaponChanged:Connect(function()
		-- upvalues: (copy) p_u_54
		p_u_54:_UpdateVisibility()
	end)
	v_u_13.CustomizingChanged:Connect(function()
		-- upvalues: (copy) p_u_54
		p_u_54:_UpdateVisibility()
	end)
	v_u_13.FinishedOpenEffect:Connect(function()
		-- upvalues: (copy) p_u_54
		p_u_54:_UpdateVisibility()
	end)
	v_u_15.PageSystem.PageOpened:Connect(function(p55)
		-- upvalues: (ref) v_u_21, (copy) p_u_54
		if v_u_21[p55.Name] then
			task.spawn(p_u_54._SetupScrollUpLogic, p_u_54, p55.Name)
			task.spawn(p_u_54._SetupUpdateSlotsLogic, p_u_54)
		end
		p_u_54:_UpdateVisibility()
	end)
	v_u_15.PageSystem.PageClosed:Connect(function()
		-- upvalues: (copy) p_u_54
		p_u_54:_UpdateVisibility()
	end)
	v_u_14.VisibilityChanged:Connect(function()
		-- upvalues: (copy) p_u_54
		p_u_54:_UpdateVisibility()
	end)
	v_u_12.EnabledChanged:Connect(function()
		-- upvalues: (copy) p_u_54
		p_u_54:_UpdateVisibility()
	end)
	v_u_11.EditorEnabledChanged:Connect(function()
		-- upvalues: (copy) p_u_54
		p_u_54:_UpdateVisibility()
	end)
	v_u_10.OpenedChanged:Connect(function()
		-- upvalues: (copy) p_u_54
		p_u_54:_UpdateVisibility()
	end)
	v_u_9:GetDataChangedSignal("BeginnerTasksCompleted"):Connect(function()
		-- upvalues: (copy) p_u_54
		p_u_54:_UpdateOnboardingBubble()
	end)
	v_u_9:GetDataChangedSignal("StatisticDuelsPlayed"):Connect(function()
		-- upvalues: (copy) p_u_54
		p_u_54:_UpdateOnboardingBubble()
		p_u_54:_UpdateSlots()
	end)
	v_u_2:GetPropertyChangedSignal("MenuIsOpen"):Connect(function()
		-- upvalues: (copy) p_u_54
		p_u_54:_UpdateVisibility()
	end)
	p_u_54:_Setup()
	p_u_54:_UpdateSlots()
	p_u_54:_UpdateVisibility()
	p_u_54:_UpdateOnboardingBubble()
end
return v_u_22._new()