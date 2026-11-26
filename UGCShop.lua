local v_u_1 = game:GetService("MarketplaceService")
local v2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("Players")
local v_u_4 = require(v2.Modules.MonetizationLibrary)
local v_u_5 = require(v2.Modules.Utility)
local v_u_6 = require(v_u_3.LocalPlayer.PlayerScripts.Controllers:WaitForChild("MonetizationController"))
local v_u_7 = require(v_u_3.LocalPlayer.PlayerScripts.Controllers:WaitForChild("PlayerDataController"))
local v_u_8 = require(v_u_3.LocalPlayer.PlayerScripts.Modules:WaitForChild("BaseContractSlot"))
local v_u_9 = require(v_u_3.LocalPlayer.PlayerScripts.Modules:WaitForChild("ButtonEffect"))
local v_u_10 = require(v_u_3.LocalPlayer.PlayerScripts.Modules:WaitForChild("PromptSystem"))
local v_u_11 = require(v_u_3.LocalPlayer.PlayerScripts.Modules:WaitForChild("RewardSlot"))
local v_u_12 = require(v_u_3.LocalPlayer.PlayerScripts.Modules:WaitForChild("Page"))
local v_u_13 = v_u_3.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("UGCEmptySlot")
local v_u_14 = v_u_3.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("UGCSlot")
local v_u_15 = setmetatable({}, v_u_12)
v_u_15.__index = v_u_15
function v_u_15._new() -- name: _new
	-- upvalues: (copy) v_u_12, (copy) v_u_15, (copy) v_u_10, (copy) v_u_8
	local v16 = v_u_12.new(script.Name)
	local v17 = v_u_15
	local v18 = setmetatable(v16, v17)
	v18.CloseButton = v18.PageFrame:WaitForChild("Close")
	v18.PromptsFrame = v18.PageFrame:WaitForChild("Prompts")
	v18.List = v18.PageFrame:WaitForChild("List")
	v18.Container = v18.List:WaitForChild("Container")
	v18.Layout = v18.Container:WaitForChild("Layout")
	v18.SlotsFrame = v18.Container:WaitForChild("Slots")
	v18.SlotsContainer = v18.SlotsFrame:WaitForChild("Container")
	v18.SlotsLayout = v18.SlotsContainer:WaitForChild("Layout")
	v18.CartFrame = v18.Container:WaitForChild("Cart")
	v18.CartContainer = v18.CartFrame:WaitForChild("Container")
	v18.ItemsText = v18.CartContainer:WaitForChild("Items")
	v18.BuyButton = v18.CartContainer:WaitForChild("Buy")
	v18.BuyDisclaimerFrame = v18.BuyButton:WaitForChild("Disclaimer")
	v18.BuyLockedFrame = v18.BuyButton:WaitForChild("Locked")
	v18.BuyRobuxFrame = v18.BuyButton:WaitForChild("Robux")
	v18.BuyText = v18.BuyButton:WaitForChild("Value")
	v18.NextRewardContainer = v18.CartContainer:WaitForChild("NextRewardContainer")
	v18.NextRewardTitle = v18.CartContainer:WaitForChild("NextRewardTitle")
	v18.NextRewardDescription = v18.CartContainer:WaitForChild("NextRewardDescription")
	v18.NextRewardProgressBFrame = v18.CartContainer:WaitForChild("NextRewardProgress")
	v18.NextRewardProgressBar = v18.NextRewardProgressBFrame:WaitForChild("Bar")
	v18.PromptSystem = v_u_10.new(v18.PromptsFrame)
	v18._next_reward_slot = nil
	v18._contract_slot = v_u_8.new()
	v18._verified_ugc = false
	v18._ugc_slots = {}
	v18._robux_prices = {}
	v18._shopping_cart = {}
	v18:_Init()
	return v18
end
function v_u_15.Buy(_, p19) -- name: Buy
	-- upvalues: (copy) v_u_6, (copy) v_u_4
	v_u_6:PromptPurchase(v_u_4.UGCs[p19].AssetID)
end
function v_u_15.BuyCart(p20) -- name: BuyCart
	-- upvalues: (copy) v_u_5, (copy) v_u_4, (copy) v_u_6
	if next(p20._shopping_cart) then
		local v21 = {}
		for v22 in pairs(p20._shopping_cart) do
			local v23 = {
				["Type"] = Enum.MarketplaceProductType.AvatarAsset
			}
			local v24 = v_u_4.UGCs[v22].AssetID
			v23.Id = tostring(v24)
			table.insert(v21, v23)
		end
		v_u_6:PromptBulkPurchase(v21)
	else
		v_u_5:CreateSound("rbxassetid://17153811469", 2, 1, script, true, 5)
	end
end
function v_u_15.Close(p25, ...) -- name: Close
	-- upvalues: (copy) v_u_12
	p25:_ClearCart()
	v_u_12.Close(p25, ...)
end
function v_u_15._GetNumItemsInCart(p26) -- name: _GetNumItemsInCart
	-- upvalues: (copy) v_u_4
	local v27 = 0
	local v28 = 0
	local v29 = false
	for v30 in pairs(p26._shopping_cart) do
		v27 = v27 + 1
		v28 = v28 + (p26._robux_prices[v30] or 0)
		v29 = v29 or v_u_4.UGCs[v30].CanBeMisleading
	end
	return v27, v28, v29
end
function v_u_15._UpdateCartVisuals(p31) -- name: _UpdateCartVisuals
	-- upvalues: (copy) v_u_5
	for v32, v33 in pairs(p31._ugc_slots) do
		v33.Enabled.Button.Added.Visible = p31._shopping_cart[v32]
	end
	local v34, v35, v36 = p31:_GetNumItemsInCart()
	p31.BuyText.Text = utf8.char(57346) .. " " .. v_u_5:PrettyNumber(v35)
	p31.ItemsText.Text = v34 .. " item" .. (v34 == 1 and "" or "s")
	local v37 = p31.ItemsText
	local v38
	if v34 >= 20 then
		v38 = Color3.fromRGB(255, 50, 50)
	else
		v38 = Color3.fromRGB(255, 255, 255)
	end
	v37.TextColor3 = v38
	p31.BuyLockedFrame.Visible = v34 == 0
	p31.BuyRobuxFrame.Visible = v34 > 0
	p31.BuyDisclaimerFrame.Visible = v36
end
function v_u_15._ClearCart(p39) -- name: _ClearCart
	if not next(p39._shopping_cart) then
		return false
	end
	p39._shopping_cart = {}
	p39:_UpdateCartVisuals()
	return true
end
function v_u_15._AddToCart(p40, p41) -- name: _AddToCart
	if p40._shopping_cart[p41] or p40:_GetNumItemsInCart() >= 20 then
		return false
	end
	p40._shopping_cart[p41] = true
	p40:_UpdateCartVisuals()
	return true
end
function v_u_15._RemoveFromCart(p42, p43) -- name: _RemoveFromCart
	if not p42._shopping_cart[p43] then
		return false
	end
	p42._shopping_cart[p43] = nil
	p42:_UpdateCartVisuals()
	return true
end
function v_u_15._UpdateContractSlot(p44) -- name: _UpdateContractSlot
	-- upvalues: (copy) v_u_7
	p44._contract_slot:SetProgress(#v_u_7:Get("UGCPurchased"))
end
function v_u_15._UpdateNextReward(p45) -- name: _UpdateNextReward
	-- upvalues: (copy) v_u_7, (copy) v_u_4, (copy) v_u_11
	if p45._next_reward_slot then
		p45._next_reward_slot:Destroy()
		p45._next_reward_slot = nil
	end
	local v46 = #v_u_7:Get("UGCPurchased")
	local v47, v48 = v_u_4:GetNextUGCMilestone(v46)
	local v49 = v47 ~= nil
	p45.NextRewardContainer.Visible = v49
	p45.NextRewardTitle.Visible = v49
	p45.NextRewardDescription.Visible = v49
	p45.NextRewardProgressBFrame.Visible = v49
	p45.NextRewardProgressBar.Visible = v49
	p45.CartFrame.Size = UDim2.new(1, 0, v49 and 0.2 or 0.1, 0)
	if v49 then
		local v50 = v47.PurchaseRequirement - v46
		local v51 = not v48 and 0 or v48.PurchaseRequirement
		local v52 = p45.NextRewardProgressBar
		local v53 = UDim2.new
		local v54 = (v46 - v51) / (v47.PurchaseRequirement - v51)
		v52.Size = v53(math.clamp(v54, 0, 1), 0, 1, 2)
		p45.NextRewardDescription.Text = string.format("Purchase %s more UGC item%s for a FREE reward!", v50, v50 == 1 and "" or "s")
		if v47.Reward then
			p45._next_reward_slot = v_u_11.new(v47.Reward)
			p45._next_reward_slot:SetParent(p45.NextRewardContainer)
		end
	end
end
function v_u_15._UpdateLayout(p55) -- name: _UpdateLayout
	p55.List.CanvasSize = UDim2.new(0, 0, 0, p55.Layout.AbsoluteContentSize.Y)
	p55.SlotsFrame.Size = UDim2.new(1, 0, 0, p55.SlotsLayout.AbsoluteContentSize.Y + p55.SlotsFrame.AbsoluteSize.X * 0.042)
end
function v_u_15._Setup(p_u_56) -- name: _Setup
	-- upvalues: (copy) v_u_4, (copy) v_u_14, (copy) v_u_9, (copy) v_u_7, (copy) v_u_5, (copy) v_u_1, (copy) v_u_3, (copy) v_u_6, (copy) v_u_13
	p_u_56._contract_slot:SetTitle("Exclusive Rewards")
	p_u_56._contract_slot:SetImage("rbxassetid://71823401853501", UDim2.new(1.5, 0, 0.75, 0))
	p_u_56._contract_slot:SetContractImage("rbxassetid://17619445340", UDim2.new(0.05, 0, 0.5, 0))
	p_u_56._contract_slot:SetDescription("Purchase UGC items for exclusive rewards in the game (RIVALS)")
	for _, v57 in pairs(v_u_4.UGCMilestoneOrder) do
		local v58 = v_u_4.UGCMilestones[v57]
		p_u_56._contract_slot:AddMilestone(v58.PurchaseRequirement, v58.Reward)
	end
	p_u_56._contract_slot.Frame.Parent = p_u_56.Container
	for v59, v_u_60 in pairs(v_u_4.UGCOrder) do
		local v_u_61 = v_u_4.UGCs[v_u_60]
		local v_u_62 = nil
		local v_u_63 = v_u_14:Clone()
		v_u_63.Enabled.Visible = false
		v_u_63.Waiting.Visible = true
		v_u_63.Waiting.Dots:AddTag("UILoadingDots")
		v_u_63.LayoutOrder = v59
		v_u_63.Parent = p_u_56.SlotsContainer
		v_u_9:Add(v_u_63.Enabled.Button)
		p_u_56._ugc_slots[v_u_60] = v_u_63
		v_u_63.Enabled.Button.MouseButton1Click:Connect(function()
			-- upvalues: (ref) v_u_7, (copy) v_u_60, (ref) v_u_5, (copy) p_u_56
			if table.find(v_u_7:Get("UGCPurchased"), v_u_60) then
				v_u_5:CreateSound("rbxassetid://17153811469", 2, 1, script, true, 5)
				return
			elseif p_u_56._robux_prices[v_u_60] then
				if p_u_56._shopping_cart[v_u_60] then
					p_u_56:_RemoveFromCart(v_u_60)
				elseif not p_u_56:_AddToCart(v_u_60) then
					v_u_5:CreateSound("rbxassetid://17153811469", 2, 1, script, true, 5)
				end
			else
				p_u_56:Buy(v_u_60)
				return
			end
		end)
		local function v65() -- name: update_owned
			-- upvalues: (ref) v_u_7, (copy) v_u_60, (copy) v_u_63, (ref) v_u_62, (ref) v_u_5, (copy) p_u_56
			local v64 = table.find(v_u_7:Get("UGCPurchased"), v_u_60)
			v_u_63.Enabled.Button.Description.Text = v64 and "\226\156\133 Owned" or (not v_u_62 and "\226\128\162 \226\128\162 \226\128\162" or utf8.char(57346) .. " " .. v_u_5:PrettyNumber(v_u_62.PriceInRobux or 0))
			if v64 then
				p_u_56:_RemoveFromCart(v_u_60)
			end
		end
		v_u_7:GetDataChangedSignal("UGCPurchased"):Connect(v65)
		v65()
		task.spawn(function()
			-- upvalues: (ref) v_u_1, (copy) v_u_61, (ref) v_u_62, (copy) p_u_56, (copy) v_u_60, (ref) v_u_7, (ref) v_u_3, (ref) v_u_6, (copy) v_u_63
			local v66 = v_u_1.GetProductInfoAsync
			local v67 = v_u_1
			local v68 = v_u_61.AssetID
			local v69 = Enum.InfoType.Asset
			local v70, v71 = pcall(v66, v67, v68, v69)
			if v70 then
				v_u_62 = v71
				p_u_56._robux_prices[v_u_60] = v_u_62.PriceInRobux
				if not table.find(v_u_7:Get("UGCPurchased"), v_u_60) then
					local v72 = v_u_1.PlayerOwnsAssetAsync
					local v73 = v_u_1
					local v74 = v_u_3.LocalPlayer
					local v75 = v_u_61.AssetID
					local v76, v77 = pcall(v72, v73, v74, v75)
					if not v76 then
						return
					end
					if v77 and not p_u_56._verified_ugc then
						p_u_56._verified_ugc = true
						v_u_6:VerifyUGC()
					end
				end
				v_u_63.Waiting.Visible = false
				v_u_63.Enabled.Visible = true
				v_u_63.Enabled.Button.Icon.Image = "rbxthumb://type=Asset&id=" .. v_u_61.AssetID .. "&w=150&h=150"
				v_u_63.Enabled.Button.Title.Text = v_u_62.Name or ""
			end
		end)
	end
	for _ = 1, 6 - ((#v_u_4.UGCOrder - 1) % 6 + 1) do
		local v78 = v_u_13:Clone()
		v78.LayoutOrder = 65535
		v78.Parent = p_u_56.SlotsContainer
	end
end
function v_u_15._Init(p_u_79) -- name: _Init
	-- upvalues: (copy) v_u_7, (copy) v_u_9
	p_u_79.CloseButton.MouseButton1Click:Connect(function()
		-- upvalues: (copy) p_u_79
		p_u_79:CloseRequest()
	end)
	p_u_79.Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		-- upvalues: (copy) p_u_79
		p_u_79:_UpdateLayout()
	end)
	p_u_79.SlotsLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		-- upvalues: (copy) p_u_79
		p_u_79:_UpdateLayout()
	end)
	p_u_79.SlotsFrame:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
		-- upvalues: (copy) p_u_79
		p_u_79:_UpdateLayout()
	end)
	p_u_79.BuyButton.MouseButton1Click:Connect(function()
		-- upvalues: (copy) p_u_79
		p_u_79:BuyCart()
	end)
	v_u_7:GetDataChangedSignal("UGCPurchased"):Connect(function()
		-- upvalues: (copy) p_u_79
		p_u_79:_UpdateNextReward()
		p_u_79:_UpdateContractSlot()
	end)
	p_u_79:_Setup()
	p_u_79:_UpdateLayout()
	p_u_79:_UpdateNextReward()
	p_u_79:_UpdateContractSlot()
	p_u_79:_UpdateCartVisuals()
	v_u_9:Add(p_u_79.BuyButton)
	v_u_9:Add(p_u_79.CloseButton)
end
return v_u_15._new()