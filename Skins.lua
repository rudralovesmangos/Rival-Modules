local v1 = game:GetService("ReplicatedStorage")
local v2 = game:GetService("Players")
local v_u_3 = require(v1.Modules.CONSTANTS)
local v_u_4 = require(v1.Modules.MonetizationLibrary)
local v_u_5 = require(v1.Modules.CosmeticLibrary)
require(v1.Modules.Utility)
local v_u_6 = require(v2.LocalPlayer.PlayerScripts.Controllers.MonetizationController)
local v_u_7 = require(v2.LocalPlayer.PlayerScripts.Controllers.ComplianceController)
local v_u_8 = require(v2.LocalPlayer.PlayerScripts.Controllers.PlayerDataController)
local v_u_9 = require(v2.LocalPlayer.PlayerScripts.Modules.UserInterface.Spotlight)
local v_u_10 = require(v2.LocalPlayer.PlayerScripts.Modules.ButtonEffect)
local v_u_11 = require(v2.LocalPlayer.PlayerScripts.Modules.RewardSlot)
local v_u_12 = {}
v_u_12.__index = v_u_12
function v_u_12.new(p13) -- name: new
	-- upvalues: (copy) v_u_12
	local v14 = v_u_12
	local v15 = setmetatable({}, v14)
	v15.Pages = p13
	v15.Frame = v15.Pages.Frame:WaitForChild("Skins")
	v15.Container = v15.Frame:WaitForChild("Container")
	v15.SlotsFrame = v15.Container:WaitForChild("Slots")
	v15.InspectFrame = v15.Container:WaitForChild("Inspect")
	v15.InspectRewardsFrame = v15.InspectFrame:WaitForChild("Rewards")
	v15.InspectNameDisplayFrame = v15.InspectFrame:WaitForChild("NameDisplay")
	v15.InspectNameDisplayBackground = v15.InspectNameDisplayFrame:WaitForChild("Background")
	v15.InspectNameDisplayElementsFrame = v15.InspectNameDisplayFrame:WaitForChild("Elements")
	v15.InspectNameDisplayLayout = v15.InspectNameDisplayElementsFrame:WaitForChild("Layout")
	v15.InspectNameDisplayTitleContainerFrame = v15.InspectNameDisplayElementsFrame:WaitForChild("TitleContainer")
	v15.InspectNameDisplayTitle = v15.InspectNameDisplayTitleContainerFrame:WaitForChild("Title")
	v15.InspectNameDisplaySlotFrameContainer = v15.InspectNameDisplayElementsFrame:WaitForChild("Slot"):WaitForChild("Container")
	v15.InspectDescriptionFrame = v15.InspectNameDisplaySlotFrameContainer:WaitForChild("Description")
	v15.InspectDescriptionArrow = v15.InspectDescriptionFrame:WaitForChild("Arrow")
	v15.InspectDescriptionBackground = v15.InspectDescriptionFrame:WaitForChild("Background")
	v15.InspectDescriptionTitle = v15.InspectDescriptionFrame:WaitForChild("Title")
	v15.InspectButtonsFrame = v15.InspectFrame:WaitForChild("Buttons")
	v15.InspectBackButton = v15.InspectButtonsFrame:WaitForChild("Back")
	v15.InspectBuyItemButton = v15.InspectButtonsFrame:WaitForChild("BuyItem")
	v15.InspectBuyItemText = v15.InspectBuyItemButton:WaitForChild("Value")
	v15.InspectBuyBundleButton = v15.InspectButtonsFrame:WaitForChild("BuyBundle")
	v15.InspectBuyBundleText = v15.InspectBuyBundleButton:WaitForChild("Value")
	v15.InspectDiscountTitle = v15.InspectButtonsFrame:WaitForChild("Discount"):WaitForChild("Bubble"):WaitForChild("Title")
	v15.InspectPreviewFrame = v15.InspectFrame:WaitForChild("Preview")
	v15.InspectPreviewContainer = v15.InspectPreviewFrame:WaitForChild("Container")
	v15._inspected_bundle_name = false
	v15._inspected_bundle_info = nil
	v15._selected_product_and_reward = nil
	v15._inspected_reward_slots = {}
	v15._selected_reward_slot = nil
	v15._preview_reward_slot = nil
	v15:_Init()
	return v15
end
function v_u_12.SelectProductAndReward(p16, p17) -- name: SelectProductAndReward
	-- upvalues: (copy) v_u_6, (copy) v_u_5, (copy) v_u_8, (copy) v_u_11
	if p16._selected_reward_slot then
		p16._selected_reward_slot:Destroy()
		p16._selected_reward_slot = nil
	end
	if p16._preview_reward_slot then
		p16._preview_reward_slot:Destroy()
		p16._preview_reward_slot = nil
	end
	p16._selected_product_and_reward = p17
	p16.InspectNameDisplayFrame.Visible = p16._selected_product_and_reward ~= nil
	local v18 = p16.InspectBuyItemButton
	local v19 = p16._selected_product_and_reward
	if v19 then
		v19 = p16._selected_product_and_reward[1] ~= nil
	end
	v18.Visible = v19
	if p16._selected_product_and_reward then
		if p16.InspectBuyItemButton.Visible then
			local v20 = v_u_6
			local v21 = p16.InspectBuyItemText
			local v22 = p16._selected_product_and_reward
			if v22 then
				v22 = p16._selected_product_and_reward[1]
			end
			v20:SetRobuxText(v21, v22)
		end
		local v23 = p16._selected_product_and_reward[3]
		local v24 = v_u_5.Cosmetics[v23.Name]
		p16.InspectNameDisplayTitle.Text = v23.Name .. (not v24 and "" or "  \226\128\162  " .. v24.Type .. " ")
		p16.InspectDescriptionTitle.Text = (v24 and v24.ItemName and (v23.Weapon or "") or "") .. " not included"
		local v25 = p16.InspectDescriptionFrame
		local v26 = v24 and (v24.ItemName and v23.Weapon)
		if v26 then
			v26 = not v_u_8:GetWeaponData(v23.Weapon)
		end
		v25.Visible = v26
		p16._selected_reward_slot = v_u_11.new(v23)
		p16._selected_reward_slot:HideWeaponVisual()
		p16._selected_reward_slot:SetNameText("")
		p16._selected_reward_slot:SetInteractable(false)
		p16._selected_reward_slot.Frame.Parent = p16.InspectNameDisplaySlotFrameContainer
		p16._preview_reward_slot = v_u_11.new(v23)
		p16._preview_reward_slot:ZoomOutViewportFrame()
		p16._preview_reward_slot:UseHighResolutionImage()
		p16._preview_reward_slot:HideBackground()
		p16._preview_reward_slot:HideWeaponVisual()
		p16._preview_reward_slot:SetNameText("")
		p16._preview_reward_slot:SetInteractable(false)
		p16._preview_reward_slot.Frame.Parent = p16.InspectPreviewContainer
		p16.InspectPreviewContainer.Position = UDim2.new(0.5, 0, 0.6, 0)
		p16.InspectPreviewContainer:TweenPosition(UDim2.new(0.5, 0, 0.5, 0), "Out", "Quint", 0.25, true)
	end
end
function v_u_12.Inspect(p_u_27, p28) -- name: Inspect
	-- upvalues: (copy) v_u_4, (copy) v_u_6, (copy) v_u_5, (copy) v_u_7, (copy) v_u_3, (copy) v_u_11
	if p28 == p_u_27._inspected_bundle_name then
		return
	else
		for _, v29 in pairs(p_u_27._inspected_reward_slots) do
			v29:Destroy()
		end
		p_u_27._inspected_reward_slots = {}
		p_u_27._inspected_bundle_name = p28
		local v30 = p_u_27._inspected_bundle_name
		if v30 then
			v30 = v_u_4.Bundles[p_u_27._inspected_bundle_name]
		end
		p_u_27._inspected_bundle_info = v30
		p_u_27:SelectProductAndReward(nil)
		p_u_27.SlotsFrame.Visible = not p_u_27._inspected_bundle_name
		local v31 = p_u_27.SlotsFrame
		local v32
		if p_u_27.SlotsFrame.Visible then
			v32 = UDim2.new(0.375, 0, 0, 0)
		else
			v32 = UDim2.new(0.5, 0, 0, 0)
		end
		v31.Position = v32
		p_u_27.SlotsFrame:TweenPosition(UDim2.new(0.5, 0, 0, 0), "Out", "Quint", 0.25, true)
		p_u_27.InspectFrame.Visible = not p_u_27.SlotsFrame.Visible
		local v33 = p_u_27.InspectFrame
		local v34
		if p_u_27.InspectFrame.Visible then
			v34 = UDim2.new(0.625, 0, 0, 0)
		else
			v34 = UDim2.new(0.5, 0, 0, 0)
		end
		v33.Position = v34
		p_u_27.InspectFrame:TweenPosition(UDim2.new(0.5, 0, 0, 0), "Out", "Quint", 0.25, true)
		if p_u_27._inspected_bundle_name then
			v_u_6:SetRobuxText(p_u_27.InspectBuyBundleText, p_u_27._inspected_bundle_info.ProductID)
			local v35 = v_u_6
			local v36 = p_u_27.InspectDiscountTitle
			local v37 = p_u_27._inspected_bundle_info.SetRobuxTextArgs
			v35:SetRobuxTextWithFormat("<s>%s</s>", v36, table.unpack(v37))
			for v38, v_u_39 in pairs(p_u_27._inspected_bundle_info.RewardsWithIndividualProductIDs) do
				local v40 = v_u_39[3]
				local v41 = v_u_5.Rewards[v40.Name]
				if v41 and (v41.Type == "Lootbox" and (v_u_7:ArePaidRandomItemsRestricted() and not v_u_3.SHOW_LOOTBOX_CONTENTS_TO_RESTRICTED_PLAYERS)) then
					continue
				end
				local v42 = v_u_11.new(v40)
				v42.Frame.LayoutOrder = v38
				v42:EnableOwnedLogic(true)
				v42:SetParent(p_u_27.InspectRewardsFrame)
				local v43 = p_u_27._inspected_reward_slots
				table.insert(v43, v42)
				v42:OnClick(function()
					-- upvalues: (copy) p_u_27, (copy) v_u_39
					p_u_27:SelectProductAndReward(v_u_39)
				end)
				if p_u_27._selected_product_and_reward or not v_u_39[1] then
					continue
				end
				p_u_27:SelectProductAndReward(v_u_39)
			end
			if not p_u_27._selected_product_and_reward then
				p_u_27:SelectProductAndReward(p_u_27._inspected_bundle_info.RewardsWithIndividualProductIDs[1])
			end
		end
	end
end
function v_u_12.Open(p44) -- name: Open
	p44:Inspect(nil)
end
function v_u_12.Close(p45) -- name: Close
	p45:Inspect(nil)
end
function v_u_12.Setup(p_u_46) -- name: Setup
	-- upvalues: (copy) v_u_4, (copy) v_u_9, (copy) v_u_10, (copy) v_u_5, (copy) v_u_7, (copy) v_u_3, (copy) v_u_11
	for v_u_47, v48 in pairs(v_u_4.Bundles) do
		if not v48.IsCosmeticBundle then
			continue
		end
		local v_u_49 = p_u_46.SlotsFrame:WaitForChild(v_u_47):WaitForChild("Container")
		local v50 = v_u_49:WaitForChild("Rewards")
		v_u_49:WaitForChild("Title").Text = v48.DisplayName
		v_u_49.MouseButton1Click:Connect(function()
			-- upvalues: (copy) p_u_46, (copy) v_u_47
			p_u_46:Inspect(v_u_47)
		end)
		v_u_49.MouseEnter:Connect(function()
			-- upvalues: (ref) v_u_9, (copy) v_u_49
			v_u_9:ChangeSubject(v_u_49)
		end)
		v_u_49.MouseLeave:Connect(function()
			-- upvalues: (ref) v_u_9, (copy) v_u_49
			v_u_9:ChangeSubject(nil, v_u_49)
		end)
		v_u_10:Add(v_u_49, nil, {
			["HoverRatio"] = 1.025,
			["ReleaseRatio"] = 1.025
		})
		for v51, v52 in pairs(v48.RewardsWithIndividualProductIDs) do
			if not v52[1] then
				continue
			end
			local v53 = v52[3]
			local v54 = v_u_5.Rewards[v53.Name]
			if v54 and (v54.Type == "Lootbox" and (v_u_7:ArePaidRandomItemsRestricted() and not v_u_3.SHOW_LOOTBOX_CONTENTS_TO_RESTRICTED_PLAYERS)) then
				continue
			end
			local v55 = v_u_11.new(v53)
			v55.Frame.LayoutOrder = v51
			v55:SetInteractable(false)
			v55:SetNameText("")
			v55:HideWeaponVisual()
			v55:SetParent(v50)
		end
	end
	p_u_46:Inspect(nil)
end
function v_u_12._UpdateLayout(p56) -- name: _UpdateLayout
	p56.InspectNameDisplayTitleContainerFrame.Size = UDim2.new(0, p56.InspectNameDisplayTitle.TextBounds.X, 0.75, 0)
	p56.InspectNameDisplayBackground.Size = UDim2.new(0, p56.InspectNameDisplayLayout.AbsoluteContentSize.X + p56.InspectNameDisplayTitleContainerFrame.AbsoluteSize.Y * 0.5, 1, 0)
	p56.InspectDescriptionBackground.Size = UDim2.new(0, p56.InspectDescriptionTitle.TextBounds.X + p56.InspectDescriptionFrame.AbsoluteSize.Y, 1, 0)
end
function v_u_12._Init(p_u_57) -- name: _Init
	-- upvalues: (copy) v_u_6, (copy) v_u_10
	p_u_57.InspectBuyBundleButton.MouseButton1Click:Connect(function()
		-- upvalues: (ref) v_u_6, (copy) p_u_57
		v_u_6:PromptProductPurchase(p_u_57._inspected_bundle_info.ProductID)
	end)
	p_u_57.InspectBuyItemButton.MouseButton1Click:Connect(function()
		-- upvalues: (ref) v_u_6, (copy) p_u_57
		v_u_6:PromptProductPurchase(p_u_57._selected_product_and_reward[1])
	end)
	p_u_57.InspectBackButton.MouseButton1Click:Connect(function()
		-- upvalues: (copy) p_u_57
		p_u_57:Inspect(nil)
	end)
	p_u_57.InspectNameDisplayTitle:GetPropertyChangedSignal("TextBounds"):Connect(function()
		-- upvalues: (copy) p_u_57
		p_u_57:_UpdateLayout()
	end)
	p_u_57.InspectNameDisplayTitleContainerFrame:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
		-- upvalues: (copy) p_u_57
		p_u_57:_UpdateLayout()
	end)
	p_u_57.InspectNameDisplayLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		-- upvalues: (copy) p_u_57
		p_u_57:_UpdateLayout()
	end)
	p_u_57.InspectDescriptionTitle:GetPropertyChangedSignal("TextBounds"):Connect(function()
		-- upvalues: (copy) p_u_57
		p_u_57:_UpdateLayout()
	end)
	p_u_57.Pages.Shop.CurrentPageChanged:Connect(function()
		-- upvalues: (copy) p_u_57
		p_u_57:Inspect(nil)
	end)
	p_u_57:_UpdateLayout()
	v_u_10:Add(p_u_57.InspectBackButton)
	v_u_10:Add(p_u_57.InspectBuyItemButton)
	v_u_10:Add(p_u_57.InspectBuyBundleButton)
end
return v_u_12