local v1 = game:GetService("ReplicatedStorage")
local v2 = game:GetService("Players")
local v_u_3 = require(v1.Modules.CONSTANTS)
local v_u_4 = require(v1.Modules.CosmeticLibrary)
local v_u_5 = require(v1.Modules.CurrencyLibrary)
local v_u_6 = require(v1.Modules.Utility)
local v_u_7 = require(v1.Modules.Signal)
local v_u_8 = require(v2.LocalPlayer.PlayerScripts.Controllers:WaitForChild("MonetizationController"))
local v_u_9 = require(v2.LocalPlayer.PlayerScripts.Controllers:WaitForChild("PlayerDataController"))
local v_u_10 = require(v2.LocalPlayer.PlayerScripts.Controllers:WaitForChild("ComplianceController"))
local v_u_11 = require(v2.LocalPlayer.PlayerScripts.Controllers:WaitForChild("ShopController"))
local v_u_12 = require(v2.LocalPlayer.PlayerScripts.Modules:WaitForChild("ButtonEffect"))
local v_u_13 = require(v2.LocalPlayer.PlayerScripts.Modules:WaitForChild("RewardSlot"))
local v_u_14 = require(v2.LocalPlayer.PlayerScripts.Modules:WaitForChild("Prompt"))
local v_u_15 = v2.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("ShopEntryBuyButton")
local v_u_16 = setmetatable({}, v_u_14)
v_u_16.__index = v_u_16
function v_u_16.new(p17) -- name: new
	-- upvalues: (copy) v_u_14, (copy) v_u_16, (copy) v_u_7, (copy) v_u_11
	local v18 = v_u_14.new(script.Name)
	local v19 = v_u_16
	local v20 = setmetatable(v18, v19)
	v20.InspectCurrencyPage = v_u_7.new()
	v20.Title = v20.PromptFrame:WaitForChild("Title")
	v20.LimitedFrame = v20.PromptFrame:WaitForChild("Limited")
	v20.Container = v20.PromptFrame:WaitForChild("Container")
	v20.LockedText = v20.PromptFrame:WaitForChild("Locked")
	v20.DisabledText = v20.PromptFrame:WaitForChild("Disabled")
	v20.CloseButton = v20.PromptFrame:WaitForChild("Close")
	v20.ViewContentsButton = v20.PromptFrame:WaitForChild("ViewContents")
	v20.ButtonsFrame = v20.PromptFrame:WaitForChild("Buttons")
	v20.AreYouSureTitle = v20.ButtonsFrame:WaitForChild("AreYouSure")
	v20.Name = p17
	v20.ShopEntry = v_u_11:GetShopEntry(p17)
	v20._close_on_purchase = v20.ShopEntry.EntryType == "Daily"
	v20._reward_slots = {}
	v20._update_text_bounds = {}
	v20._robux_buy_buttons = {}
	v20:_Init()
	return v20
end
function v_u_16.Destroy(p21) -- name: Destroy
	-- upvalues: (copy) v_u_14
	for _, v22 in pairs(p21._reward_slots) do
		v22:Destroy()
	end
	p21.InspectCurrencyPage:Destroy()
	v_u_14.Destroy(p21)
end
function v_u_16._Update(p23) -- name: _Update
	-- upvalues: (copy) v_u_9, (copy) v_u_4, (copy) v_u_10, (copy) v_u_3
	local v24 = v_u_9:Get("CosmeticInventory")
	local v25 = p23.ShopEntry.Rewards[1]
	local v26 = v_u_4.Cosmetics[v25.Name]
	local v27
	if v26 then
		v27 = v_u_4.Types[v26.Type]
	else
		v27 = v26
	end
	local v28 = v_u_4.Rewards[v25.Name]
	local v29 = v_u_4:OwnsCosmetic(v24, v25.Name, v25.Weapon)
	local v30 = v25.Weapon
	if v30 then
		if v25.Weapon == "IsRandom" or v25.Weapon == "IsUniversal" then
			v30 = false
		else
			v30 = not v_u_9:GetWeaponData(v25.Weapon)
		end
	end
	local v31 = p23.Title
	local v32
	if v27 and v27.IsWeaponCosmetic then
		v32 = (v25.Weapon == "IsRandom" and "Random" or (v25.Weapon == "IsUniversal" and "Universal" or v25.Weapon)) .. " " .. v26.Type
	elseif v26 then
		v32 = v26.Type
	else
		v32 = v25.Name
	end
	v31.Text = v32
	p23.LockedText.Visible = v29 or v30
	p23.LockedText.Text = v29 and "Unavailable\nYou already own this" or (v30 and ("Unavailable\nYou don\'t own " .. (v25.Weapon or "") or "") or "")
	local v33 = p23.DisabledText
	local v34 = not p23.LockedText.Visible and (v28 and (v28.Type == "Lootbox" and v_u_10:ArePaidRandomItemsRestricted()))
	if v34 then
		v34 = not v_u_3.SHOW_LOOTBOX_CONTENTS_TO_RESTRICTED_PLAYERS
	end
	v33.Visible = v34
	local v35 = p23.ViewContentsButton
	local v36 = ((not v28 or v28.Type ~= "Lootbox") and true or false) and (v27 and v27.IsWeaponCosmetic)
	if v36 then
		v36 = v25.Weapon == "IsRandom"
	end
	v35.Visible = v36
	local v37 = p23.ButtonsFrame
	local v38 = not p23.DisabledText.Visible
	if v38 then
		v38 = not p23.LockedText.Visible
	end
	v37.Visible = v38
	p23.AreYouSureTitle.Visible = false
	for _, v39 in pairs(p23._robux_buy_buttons) do
		local v40 = not v29
		if v40 then
			v40 = not v30
		end
		v39.Visible = v40
	end
end
function v_u_16._Setup(p_u_41) -- name: _Setup
	-- upvalues: (copy) v_u_5, (copy) v_u_9, (copy) v_u_15, (copy) v_u_6, (copy) v_u_12, (copy) v_u_8, (copy) v_u_11, (copy) v_u_13
	p_u_41.LimitedFrame.Visible = p_u_41.ShopEntry.IsLimited
	for v_u_42, v_u_43 in pairs(p_u_41.ShopEntry.Prices) do
		local v_u_44 = v_u_5.Info[v_u_42]
		if v_u_44.OnlyDisplayBuyButtonAboveZeroBalance and v_u_9:Get(v_u_42) <= 0 then
			continue
		end
		local v_u_45 = v_u_15:Clone()
		v_u_45.LayoutOrder = v_u_44.OrderIndex
		v_u_45.Robux.Visible = false
		v_u_45.Free.Visible = v_u_43 == 0
		v_u_45.Currency.Visible = v_u_43 > 0
		v_u_45.Currency.Value.Text = v_u_6:PrettyNumber(v_u_43)
		v_u_45.Currency.Value.Icon.Image = v_u_44.ImageFlatOutline
		v_u_45.Currency.Value.Icon.ImageLabel.Image = v_u_44.ImageFlat
		v_u_45.Currency.Background.ImageColor3 = v_u_44.Color
		v_u_45.Currency.Background.UIGradient.Color = v_u_44.ColorGradient
		v_u_45.Parent = p_u_41.ButtonsFrame
		v_u_12:Add(v_u_45)
		v_u_45.MouseButton1Click:Connect(function()
			-- upvalues: (ref) v_u_9, (copy) v_u_44, (copy) v_u_43, (ref) v_u_8, (copy) v_u_42, (copy) p_u_41, (ref) v_u_6, (copy) v_u_45, (ref) v_u_11
			if v_u_9:Get(v_u_44.DataName) < v_u_43 then
				if v_u_8:PromptCurrencyBundlePurchase(v_u_43, v_u_42) then
					p_u_41.InspectCurrencyPage:Fire()
					p_u_41:CloseRequest()
				else
					v_u_6:CreateSound("rbxassetid://17153811469", 2, 1, script, true, 5)
				end
			elseif v_u_44.NeedsAreYouSurePrompt and not p_u_41.AreYouSureTitle.Visible then
				for _, v46 in pairs(p_u_41.ButtonsFrame:GetChildren()) do
					if not v46:IsA("GuiBase2d") then
						continue
					end
					v46.Visible = false
				end
				v_u_45.Visible = true
				p_u_41.AreYouSureTitle.Visible = true
			else
				v_u_6:CreateSound("rbxassetid://18210861148", 1, 1, script, true, 5)
				v_u_11:PurchaseShopEntry(p_u_41.Name, v_u_42)
				p_u_41:_Update()
				if p_u_41._close_on_purchase then
					p_u_41:CloseRequest()
				end
			end
		end)
		local v_u_47 = v_u_45.Currency.Value
		local v_u_48 = v_u_47.Icon
		local function v49() -- name: update
			-- upvalues: (copy) v_u_48, (copy) v_u_47
			v_u_48.Position = UDim2.new(0.5, v_u_47.TextBounds.X / 2, 0.5, 0)
		end
		v_u_47:GetPropertyChangedSignal("TextBounds"):Connect(v49)
		v_u_45.AncestryChanged:Connect(v49)
		v_u_48.Position = UDim2.new(0.5, v_u_47.TextBounds.X / 2, 0.5, 0)
	end
	for v50, v_u_51 in pairs(p_u_41.ShopEntry.ProductIDs or {}) do
		local v52 = v_u_15:Clone()
		v52.LayoutOrder = 9999 + v_u_51
		v52.Free.Visible = false
		v52.Currency.Visible = false
		v52.Robux.Visible = true
		v52.Robux.Title.Text = "Buy \195\151" .. v_u_51
		v52.Robux.Title.Visible = v_u_51 ~= 1
		local v53 = v52.Robux.Value
		local v54
		if v_u_51 == 1 then
			v54 = UDim2.new(0.5, 0, 0.5, 0)
		else
			v54 = UDim2.new(0.5, 0, 0.625, 0)
		end
		v53.Position = v54
		v52.Parent = p_u_41.ButtonsFrame
		local v55 = p_u_41._robux_buy_buttons
		table.insert(v55, v52)
		v_u_12:Add(v52)
		v_u_8:SetRobuxText(v52.Robux.Value, v50, Enum.InfoType.Product)
		v52.MouseButton1Click:Connect(function()
			-- upvalues: (copy) p_u_41, (ref) v_u_11, (copy) v_u_51
			if p_u_41._close_on_purchase then
				p_u_41:CloseRequest()
			end
			v_u_11:PurchaseShopEntry(p_u_41.Name, nil, v_u_51)
		end)
	end
	for v56, v57 in pairs(p_u_41.ShopEntry.Rewards) do
		local v58 = v_u_13.new(v57)
		v58.Frame.LayoutOrder = v56
		v58:SetParent(p_u_41.Container)
		local v59 = p_u_41._reward_slots
		table.insert(v59, v58)
	end
end
function v_u_16._Init(p_u_60) -- name: _Init
	-- upvalues: (copy) v_u_9, (copy) v_u_12
	p_u_60.CloseButton.MouseButton1Click:Connect(function()
		-- upvalues: (copy) p_u_60
		p_u_60:CloseRequest()
	end)
	p_u_60.ViewContentsButton.MouseButton1Click:Connect(function()
		-- upvalues: (copy) p_u_60
		p_u_60.OpenPrompt:Fire("InspectLootbox", p_u_60.ShopEntry.Rewards[1].Name, p_u_60.ShopEntry.Rewards[1].Weapon, "InspectShopEntry", p_u_60.Name)
	end)
	local v61 = p_u_60._connections
	local v62 = v_u_9:GetDataChangedSignal("CosmeticInventory")
	table.insert(v61, v62:Connect(function()
		-- upvalues: (copy) p_u_60
		p_u_60:_Update()
	end))
	local v63 = p_u_60._connections
	local v64 = v_u_9:GetDataChangedSignal("WeaponInventory")
	table.insert(v63, v64:Connect(function()
		-- upvalues: (copy) p_u_60
		p_u_60:_Update()
	end))
	p_u_60:_Setup()
	p_u_60:_Update()
	v_u_12:Add(p_u_60.CloseButton)
	v_u_12:Add(p_u_60.ViewContentsButton)
end
return v_u_16