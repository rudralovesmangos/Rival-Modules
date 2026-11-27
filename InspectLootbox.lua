local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("Players")
local v_u_3 = require(v1.Modules.CONSTANTS)
local v_u_4 = require(v1.Modules.CosmeticLibrary)
local v_u_5 = require(v1.Modules.LootLibrary)
local v_u_6 = require(v1.Modules.ShopLibrary)
local v_u_7 = require(v1.Modules.ItemLibrary)
local v_u_8 = require(v_u_2.LocalPlayer.PlayerScripts.Controllers:WaitForChild("ComplianceController"))
local v_u_9 = require(v_u_2.LocalPlayer.PlayerScripts.Controllers:WaitForChild("PlayerDataController"))
local v_u_10 = require(v_u_2.LocalPlayer.PlayerScripts.Modules:WaitForChild("WeaponStatusHandler"))
local v_u_11 = require(v_u_2.LocalPlayer.PlayerScripts.Modules:WaitForChild("ButtonEffect"))
local v_u_12 = require(v_u_2.LocalPlayer.PlayerScripts.Modules:WaitForChild("RewardSlot"))
local v_u_13 = require(v_u_2.LocalPlayer.PlayerScripts.Modules:WaitForChild("Prompt"))
local v_u_14 = v_u_2.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("LootboxChanceSlot")
local v_u_15 = setmetatable({}, v_u_13)
v_u_15.__index = v_u_15
function v_u_15.new(p16, p17, p18, ...) -- name: new
	-- upvalues: (copy) v_u_13, (copy) v_u_15
	local v19 = v_u_13.new(script.Name)
	local v20 = v_u_15
	local v21 = setmetatable(v19, v20)
	v21.CloseButton = v21.PromptFrame:WaitForChild("Close")
	v21.SwitchButton = v21.PromptFrame:WaitForChild("Switch")
	v21.RestrictedFrame = v21.PromptFrame:WaitForChild("Restricted")
	v21.RestrictedNoResultFrame = v21.RestrictedFrame:WaitForChild("NoResult")
	v21.RestrictedNextRewardFrame = v21.RestrictedFrame:WaitForChild("NextReward")
	v21.RestrictedContainer = v21.RestrictedNextRewardFrame:WaitForChild("Container")
	v21.List = v21.PromptFrame:WaitForChild("List")
	v21.Container = v21.List:WaitForChild("Container")
	v21.Layout = v21.Container:WaitForChild("Layout")
	v21._root_name = p16
	v21._root_weapon = p17 or "IsRandom"
	v21._back_to_prompt_name = p18
	v21._back_to_prompt_args = { ... }
	v21:_Init()
	return v21
end
function v_u_15.CloseRequest(p22) -- name: CloseRequest
	-- upvalues: (copy) v_u_13
	if p22._back_to_prompt_name then
		local v23 = p22.OpenPrompt
		local v24 = p22._back_to_prompt_name
		local v25 = p22._back_to_prompt_args
		v23:Fire(v24, table.unpack(v25))
	else
		v_u_13.CloseRequest(p22)
	end
end
function v_u_15._GenerateOddsData(p_u_26, p27, p28, p_u_29, p30) -- name: _GenerateOddsData
	-- upvalues: (copy) v_u_4, (copy) v_u_5, (copy) v_u_9, (copy) v_u_6, (copy) v_u_3, (copy) v_u_7, (copy) v_u_14, (copy) v_u_10, (copy) v_u_12, (copy) v_u_11
	local v_u_31 = p28.RewardData
	local v32 = p28.DisplayType
	local v33 = v_u_31.Name .. (v_u_31.Quantity and v_u_31.Quantity > 1 and (" [\195\151" .. v_u_31.Quantity .. "]" or "") or "")
	local v34 = Color3.fromRGB(255, 255, 255)
	local v35 = nil
	local v36 = ""
	local v37 = Color3.fromRGB(255, 255, 255)
	local v38 = nil
	local v39 = v_u_4.Cosmetics[v_u_31.Name]
	local v40 = v_u_4.Rewards[v_u_31.Name]
	local v_u_41 = {}
	if v39 then
		v34 = v_u_4.Rarities[v39.Rarity].Color
		v36 = v39.Rarity .. " " .. v39.Type
		if v_u_31.Weapon == "IsUniversal" then
			v36 = v36 .. " for all weapons"
		elseif v_u_31.Weapon == "IsRandom" then
			v36 = v36 .. " for a random weapon"
			local v42 = v_u_5:GetUnlockedWeaponsForSelection(v_u_9:Get("WeaponInventory"), true, v_u_31.Name, v_u_9:Get("CosmeticInventory"))
			local v43 = {}
			local v44 = {}
			for _, v45 in pairs(v_u_6:GetReleasedOwnableWeapons(v_u_3.WEAPON_EARLY_ACCESS_TIME_OFFSET, v_u_6.OwnableWeaponsAlphabetized)) do
				if table.find(v42, v45) then
					continue
				end
				if v_u_9:GetWeaponData(v45) then
					table.insert(v43, v45)
				else
					table.insert(v44, v45)
				end
			end
			local function v51(p46, p47) -- name: add_these
				-- upvalues: (copy) v_u_31, (copy) v_u_41
				for _, v48 in pairs(p46) do
					local v49 = v_u_41
					local v50 = {
						["Weight"] = 1,
						["RewardData"] = nil,
						["DisplayType"] = nil,
						["RewardData"] = {
							["Name"] = v_u_31.Name,
							["Weapon"] = v48
						},
						["DisplayType"] = p47
					}
					table.insert(v49, v50)
				end
			end
			v51(v42, "Default")
			v51(v43, "Owned")
			v51(v44, "Locked")
		elseif v_u_31.Weapon then
			v36 = v36 .. " for " .. v_u_31.Weapon
			v38 = v_u_7.Items[v_u_31.Weapon].Status
		end
	elseif v40 then
		if v40.Type == "Weapon" then
			local v52 = v_u_7.Items[v_u_31.Name]
			v36 = v52.Status .. " Weapon"
			v35 = v52.Status
		else
			v36 = v40.Type
			if v_u_31.Weapon == "IsUniversal" then
				v36 = v36 .. " for all weapons"
			elseif v_u_31.Weapon ~= "IsRandom" and v_u_31.Weapon then
				v36 = v36 .. " for " .. v_u_31.Weapon
				v38 = v_u_7.Items[v_u_31.Weapon].Status
			end
			if v40.Type == "Lootbox" then
				local v53, v54, v55 = v_u_5:GetLootboxPossibilities(v40.SmartRestrictionsEnabled, v40.GetContents(v_u_31.Weapon), v_u_9:Get("CosmeticInventory"), v_u_9:GetUnlockedWeapons(), v_u_31.Weapon)
				local function v61(p56, p57) -- name: add_these
					-- upvalues: (copy) v_u_41
					for _, v58 in pairs(p56) do
						local v59 = v_u_41
						local v60 = {
							["Weight"] = v58.Weight,
							["RewardData"] = v58.Reward,
							["DisplayType"] = p57
						}
						table.insert(v59, v60)
					end
				end
				v61(v53, "Default")
				v61(v55, "Owned")
				v61(v54, "Locked")
			end
		end
	end
	local v_u_62
	if v32 == "Default" then
		v_u_62 = #v_u_41 > 0
	else
		v_u_62 = false
	end
	local v_u_63 = v_u_14:Clone()
	v_u_63.Container.TitleContainer.Value.Text = v33
	v_u_63.Container.TitleContainer.Value.TextColor3 = v34
	v_u_63.Container.DescriptionContainer.Value.Text = v36
	v_u_63.Container.DescriptionContainer.Value.TextColor3 = v37
	v_u_63.Container.Details.Chance.Text = string.format("%.2f%%", p_u_29 * 100)
	v_u_63.Container.Details.Chance.Visible = v32 == "Default"
	v_u_63.Container.Details.Locked.Visible = v32 == "Locked"
	v_u_63.Container.Details.Owned.Visible = v32 == "Owned"
	v_u_63.Container.Button.Visible = v_u_62
	v_u_63.Container.Arrow.Visible = v_u_62
	v_u_63.Parent = p27
	v_u_10:ApplyItemStatusToText(v_u_63.Container.TitleContainer.Value, v35)
	v_u_10:ApplyItemStatusToText(v_u_63.Container.DescriptionContainer.Value, v38)
	local v64 = v_u_12.new(v_u_31)
	v64:SetNameText("")
	v64:HideWeaponVisual()
	v64:SetParent(v_u_63.Container.RewardContainer)
	local v_u_65 = v_u_63.Container.Children
	local v_u_66 = v_u_65.Layout
	local function v67() -- name: update
		-- upvalues: (copy) v_u_63, (copy) v_u_65, (copy) v_u_66
		v_u_63.Size = UDim2.new(1, 0, 0.075, not v_u_65.Visible and 0 or v_u_66.AbsoluteContentSize.Y)
	end
	v_u_66:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(v67)
	v_u_65:GetPropertyChangedSignal("Visible"):Connect(v67)
	v_u_63.Size = UDim2.new(1, 0, 0.075, not v_u_65.Visible and 0 or v_u_66.AbsoluteContentSize.Y)
	local v_u_68 = false
	local v_u_69 = false
	local function v_u_75(p70) -- name: set_children_visible
		-- upvalues: (copy) v_u_62, (ref) v_u_68, (copy) v_u_41, (copy) p_u_29, (copy) p_u_26, (copy) v_u_63, (ref) v_u_69
		if p70 then
			p70 = v_u_62
		end
		if p70 and not v_u_68 then
			v_u_68 = true
			local v71 = 0
			for _, v72 in pairs(v_u_41) do
				v71 = v71 + (v72.DisplayType == "Default" and (v72.Weight or 0) or 0)
			end
			for _, v73 in pairs(v_u_41) do
				local v74 = v73.DisplayType ~= "Default" and 0 or p_u_29 * v73.Weight / v71
				p_u_26:_GenerateOddsData(v_u_63.Container.Children, v73, v74)
			end
		end
		v_u_69 = p70
		v_u_63.Container.Children.Visible = v_u_69
		v_u_63.Container.Details.Visible = not v_u_69
		v_u_63.Container.Arrow.Image = v_u_69 and "rbxassetid://17654601337" or "rbxassetid://17654548862"
	end
	if not p30 then
		v_u_63.Container.Button.MouseButton1Click:Connect(function()
			-- upvalues: (copy) v_u_75, (ref) v_u_69
			v_u_75(not v_u_69)
		end)
		v_u_11:Add(v_u_63.Container.Button)
	end
	v_u_75(p30)
end
function v_u_15._Setup(p76) -- name: _Setup
	-- upvalues: (copy) v_u_8, (copy) v_u_3, (copy) v_u_4, (copy) v_u_9, (copy) v_u_5, (copy) v_u_2, (copy) v_u_12
	local v77 = p76.SwitchButton
	local v78 = v_u_8:ArePaidRandomItemsRestricted()
	if v78 then
		v78 = v_u_3.SHOW_LOOTBOX_CONTENTS_TO_RESTRICTED_PLAYERS
	end
	v77.Visible = v78
	p76.RestrictedFrame.Visible = p76.SwitchButton.Visible
	p76.List.Visible = not p76.RestrictedFrame.Visible
	local v79
	if p76._root_name and (v_u_4.Rewards[p76._root_name] and v_u_4.Rewards[p76._root_name].Type == "Lootbox") then
		v79 = v_u_4.Rewards[p76._root_name]
	else
		v79 = nil
	end
	if v79 then
		local v80 = v_u_9:Get("LootboxSeedShifts")[p76._root_name] and (v_u_9:Get("LootboxSeedShifts")[p76._root_name][p76._root_weapon] or 0) or 0
		local v81 = v_u_5:GetWeightedLootboxOutcome(v_u_5:GetLootboxPossibilities(v79.SmartRestrictionsEnabled, v79.GetContents(p76._root_weapon), v_u_9:Get("CosmeticInventory"), v_u_9:GetUnlockedWeapons(), p76._root_weapon), v_u_5:GetWeightedOutcomeSeed(v_u_2.LocalPlayer.UserId, v80))
		p76.RestrictedNextRewardFrame.Visible = v81 ~= nil
		p76.RestrictedNoResultFrame.Visible = not p76.RestrictedNextRewardFrame.Visible
		if v81 then
			v_u_12.new(v81):SetParent(p76.RestrictedContainer)
		end
	end
end
function v_u_15._Init(p_u_82) -- name: _Init
	-- upvalues: (copy) v_u_11
	p_u_82.CloseButton.MouseButton1Click:Connect(function()
		-- upvalues: (copy) p_u_82
		p_u_82:CloseRequest()
	end)
	p_u_82.SwitchButton.MouseButton1Click:Connect(function()
		-- upvalues: (copy) p_u_82
		p_u_82.RestrictedFrame.Visible = not p_u_82.RestrictedFrame.Visible
		p_u_82.List.Visible = not p_u_82.RestrictedFrame.Visible
	end)
	p_u_82.Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		-- upvalues: (copy) p_u_82
		p_u_82.List.CanvasSize = UDim2.new(0, 0, 0, p_u_82.Layout.AbsoluteContentSize.Y)
	end)
	p_u_82:_Setup()
	local v83 = task.defer
	local v84 = p_u_82._GenerateOddsData
	local v85 = p_u_82.Container
	local v86 = {
		["RewardData"] = nil,
		["DisplayType"] = "Default",
		["RewardData"] = {
			["Name"] = p_u_82._root_name,
			["Weapon"] = p_u_82._root_weapon
		}
	}
	v83(v84, p_u_82, v85, v86, 1, true)
	v_u_11:Add(p_u_82.CloseButton)
	v_u_11:Add(p_u_82.SwitchButton)
end
return v_u_15