local v1 = game:GetService("ReplicatedStorage")
local v2 = game:GetService("Players")
local v_u_3 = require(v1.Modules.CosmeticLibrary)
require(v1.Modules.CurrencyLibrary)
local v_u_4 = require(v1.Modules.EventLibrary)
local v_u_5 = require(v1.Modules.LootLibrary)
local v_u_6 = require(v1.Modules.Utility)
local v_u_7 = require(v2.LocalPlayer.PlayerScripts.Controllers.MonetizationController)
local v_u_8 = require(v2.LocalPlayer.PlayerScripts.Controllers.PlayerDataController)
local v_u_9 = require(v2.LocalPlayer.PlayerScripts.Modules.BaseShopSlot.BigShopSlot)
local v_u_10 = require(v2.LocalPlayer.PlayerScripts.Controllers.ShopController)
local v_u_11 = require(v2.LocalPlayer.PlayerScripts.Modules.BaseShopSlot.ShopSlot)
local v_u_12 = require(v2.LocalPlayer.PlayerScripts.Modules.ButtonEffect)
local v_u_13 = require(script:WaitForChild("LoginRewards"))
local v_u_14 = {}
v_u_14.__index = v_u_14
function v_u_14.new(p15) -- name: new
	-- upvalues: (copy) v_u_14, (copy) v_u_13
	local v16 = v_u_14
	local v17 = setmetatable({}, v16)
	v17.Pages = p15
	v17.Frame = v17.Pages.Frame:WaitForChild("Daily")
	v17.Container = v17.Frame:WaitForChild("Container")
	v17.Layout = v17.Container:WaitForChild("Layout")
	v17.CountdownFrame = v17.Container:WaitForChild("Countdown")
	v17.CountdownTimer = v17.CountdownFrame:WaitForChild("Timer")
	v17.CountdownRefreshButton = v17.CountdownFrame:WaitForChild("Refresh")
	v17.CountdownRefreshPrice = v17.CountdownRefreshButton:WaitForChild("Price")
	v17.CountdownRefreshPriceIcon = v17.CountdownRefreshPrice:WaitForChild("Icon")
	v17.SkinsFrame = v17.Container:WaitForChild("Skins")
	v17.SkinsContainer = v17.SkinsFrame:WaitForChild("Container")
	v17.SkinsLayout = v17.SkinsContainer:WaitForChild("Layout")
	v17.FinishersFrame = v17.Container:WaitForChild("Finishers")
	v17.FinishersContainer = v17.FinishersFrame:WaitForChild("Container")
	v17.FinishersHeaderIcon = v17.FinishersContainer:WaitForChild("Header"):WaitForChild("Icon")
	v17.FinishersSlotsFrame = v17.FinishersContainer:WaitForChild("Slots")
	v17.FinishersSlotsLayout = v17.FinishersSlotsFrame:WaitForChild("Layout")
	v17.WrapsFrame = v17.Container:WaitForChild("Wraps")
	v17.WrapsContainer = v17.WrapsFrame:WaitForChild("Container")
	v17.WrapsHeaderIcon = v17.WrapsContainer:WaitForChild("Header"):WaitForChild("Icon")
	v17.WrapsSlotsFrame = v17.WrapsContainer:WaitForChild("Slots")
	v17.WrapsSlotsLayout = v17.WrapsSlotsFrame:WaitForChild("Layout")
	v17.CharmsFrame = v17.Container:WaitForChild("Charms")
	v17.CharmsContainer = v17.CharmsFrame:WaitForChild("Container")
	v17.CharmsHeaderIcon = v17.CharmsContainer:WaitForChild("Header"):WaitForChild("Icon")
	v17.CharmsSlotsFrame = v17.CharmsContainer:WaitForChild("Slots")
	v17.CharmsSlotsLayout = v17.CharmsSlotsFrame:WaitForChild("Layout")
	v17.LoginRewards = v_u_13.new(v17)
	v17._is_open_hash = 0
	v17._shop_slots = {}
	v17:_Init()
	return v17
end
function v_u_14.Generate(p18) -- name: Generate
	-- upvalues: (copy) v_u_8, (copy) v_u_4, (copy) v_u_10, (copy) v_u_3, (copy) v_u_9, (copy) v_u_11
	for _, v19 in pairs(p18._shop_slots) do
		v19:Destroy()
	end
	p18._shop_slots = {}
	if p18.Pages.Shop:IsOpen() then
		local v20 = v_u_8:GetStatistic("StatisticDuelsPlayed") >= v_u_4.NUM_GAMES_NEEDED_TO_PARTICIPATE
		v_u_8:Get("CosmeticInventory")
		for v21, v22 in pairs(v_u_10:GetDailyShop()) do
			if v22.Prices.EventCurrency and not v20 then
				continue
			end
			local v23 = v22.Rewards[1]
			local v24 = v_u_3.Cosmetics[v23.Name]
			local v25 = v24.Type == "Finisher" and p18.FinishersSlotsFrame or v24.Type == "Wrap" and p18.WrapsSlotsFrame or (v24.Type == "Charm" and p18.CharmsSlotsFrame or p18.SkinsContainer)
			local v26
			if v24.Type == "Skin" or v24.Type == "Emote" then
				v26 = v_u_9
			else
				v26 = v_u_11
			end
			local v27 = p18.Pages.Shop:CreateShopSlot(v26, nil, v22.EntryName)
			v27.Frame.LayoutOrder = v21
			v27.Frame.ZIndex = v21
			v27.Frame.Parent = v25
			local v28 = p18._shop_slots
			table.insert(v28, v27)
			if v24.Type ~= "Emote" or not v24.EmoteDescription then
				continue
			end
			v27:SetDescription(v24.EmoteDescription)
		end
	end
end
function v_u_14.Open(p29) -- name: Open
	p29._is_open_hash = p29._is_open_hash + 1
	task.spawn(p29._CountdownLoop, p29)
	p29:Generate()
	p29:_UpdateFrame()
	p29:_UpdateSizes()
	p29.LoginRewards:Open()
end
function v_u_14.Close(p30) -- name: Close
	p30._is_open_hash = p30._is_open_hash + 1
	p30:Generate()
	p30.LoginRewards:Close()
end
function v_u_14.Setup(p31) -- name: Setup
	p31:Generate()
	p31.LoginRewards:Setup()
end
function v_u_14._CountdownLoop(p32) -- name: _CountdownLoop
	-- upvalues: (copy) v_u_6, (copy) v_u_10
	p32._is_open_hash = p32._is_open_hash + 1
	local v33 = p32._is_open_hash
	while v33 == p32._is_open_hash do
		p32.CountdownTimer.Text = "<font transparency=\"0.5\" size=\"9\">shop will refresh in</font> " .. v_u_6:TimeFormat2(v_u_10:GetDailyShopRefreshTimeRemaining())
		wait(1)
	end
end
function v_u_14._UpdateRefreshText(p34) -- name: _UpdateRefreshText
	-- upvalues: (copy) v_u_5, (copy) v_u_8
	p34.CountdownRefreshPrice.Text = v_u_5:GetCostToRefreshDailyShop(v_u_8:Get("DailyShopRefreshesToday"))
end
function v_u_14._UpdateSizes(p35) -- name: _UpdateSizes
	p35.SkinsFrame.Size = UDim2.new(1, 0, 0, p35.SkinsLayout.AbsoluteContentSize.Y + p35.SkinsFrame.AbsoluteSize.X * 440 / 1173 * 0.05)
	p35.FinishersFrame.Size = UDim2.new(1, 0, 0, p35.FinishersSlotsLayout.AbsoluteContentSize.Y + p35.FinishersSlotsFrame.AbsolutePosition.Y - p35.FinishersContainer.AbsolutePosition.Y + 0.05 * p35.FinishersContainer.AbsoluteSize.Y)
	p35.WrapsFrame.Size = UDim2.new(1, 0, 0, p35.WrapsSlotsLayout.AbsoluteContentSize.Y + p35.WrapsSlotsFrame.AbsolutePosition.Y - p35.WrapsContainer.AbsolutePosition.Y + 0.05 * p35.WrapsContainer.AbsoluteSize.Y)
	p35.CharmsFrame.Size = UDim2.new(1, 0, 0, p35.CharmsSlotsLayout.AbsoluteContentSize.Y + p35.CharmsSlotsFrame.AbsolutePosition.Y - p35.CharmsContainer.AbsolutePosition.Y + 0.05 * p35.CharmsContainer.AbsoluteSize.Y)
end
function v_u_14._UpdateFrame(p36) -- name: _UpdateFrame
	p36.Frame.Size = UDim2.new(1, 0, 0, p36.Layout.AbsoluteContentSize.Y)
end
function v_u_14._Setup(p37) -- name: _Setup
	-- upvalues: (copy) v_u_3
	p37.FinishersHeaderIcon = v_u_3.Types.Finisher.Image
	p37.WrapsHeaderIcon = v_u_3.Types.Wrap.Image
	p37.CharmsHeaderIcon = v_u_3.Types.Charm.Image
end
function v_u_14._Init(p_u_38) -- name: _Init
	-- upvalues: (copy) v_u_5, (copy) v_u_8, (copy) v_u_7, (copy) v_u_10, (copy) v_u_6, (copy) v_u_12
	p_u_38.Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		-- upvalues: (copy) p_u_38
		p_u_38:_UpdateFrame()
	end)
	p_u_38.SkinsFrame:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
		-- upvalues: (copy) p_u_38
		p_u_38:_UpdateSizes()
	end)
	p_u_38.SkinsLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		-- upvalues: (copy) p_u_38
		p_u_38:_UpdateSizes()
	end)
	p_u_38.FinishersSlotsLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		-- upvalues: (copy) p_u_38
		p_u_38:_UpdateSizes()
	end)
	p_u_38.FinishersSlotsFrame:GetPropertyChangedSignal("AbsolutePosition"):Connect(function()
		-- upvalues: (copy) p_u_38
		p_u_38:_UpdateSizes()
	end)
	p_u_38.FinishersContainer:GetPropertyChangedSignal("AbsolutePosition"):Connect(function()
		-- upvalues: (copy) p_u_38
		p_u_38:_UpdateSizes()
	end)
	p_u_38.FinishersContainer:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
		-- upvalues: (copy) p_u_38
		p_u_38:_UpdateSizes()
	end)
	p_u_38.WrapsSlotsLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		-- upvalues: (copy) p_u_38
		p_u_38:_UpdateSizes()
	end)
	p_u_38.WrapsSlotsFrame:GetPropertyChangedSignal("AbsolutePosition"):Connect(function()
		-- upvalues: (copy) p_u_38
		p_u_38:_UpdateSizes()
	end)
	p_u_38.WrapsContainer:GetPropertyChangedSignal("AbsolutePosition"):Connect(function()
		-- upvalues: (copy) p_u_38
		p_u_38:_UpdateSizes()
	end)
	p_u_38.WrapsContainer:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
		-- upvalues: (copy) p_u_38
		p_u_38:_UpdateSizes()
	end)
	p_u_38.CharmsSlotsLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		-- upvalues: (copy) p_u_38
		p_u_38:_UpdateSizes()
	end)
	p_u_38.CharmsSlotsFrame:GetPropertyChangedSignal("AbsolutePosition"):Connect(function()
		-- upvalues: (copy) p_u_38
		p_u_38:_UpdateSizes()
	end)
	p_u_38.CharmsContainer:GetPropertyChangedSignal("AbsolutePosition"):Connect(function()
		-- upvalues: (copy) p_u_38
		p_u_38:_UpdateSizes()
	end)
	p_u_38.CharmsContainer:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
		-- upvalues: (copy) p_u_38
		p_u_38:_UpdateSizes()
	end)
	p_u_38.CountdownRefreshPriceIcon:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
		-- upvalues: (copy) p_u_38
		p_u_38.CountdownRefreshPrice.Position = UDim2.new(0.5, -p_u_38.CountdownRefreshPriceIcon.AbsoluteSize.X / 2, 0.5, 0)
		p_u_38.CountdownRefreshPriceIcon.Position = UDim2.new(0.5, p_u_38.CountdownRefreshPrice.TextBounds.X / 2, 0.5, 0)
	end)
	p_u_38.CountdownRefreshButton.MouseButton1Click:Connect(function()
		-- upvalues: (ref) v_u_5, (ref) v_u_8, (copy) p_u_38, (ref) v_u_7, (ref) v_u_10, (ref) v_u_6
		local v39 = v_u_5:GetCostToRefreshDailyShop(v_u_8:Get("DailyShopRefreshesToday"))
		if v_u_8:Get("WeaponKeys") < v39 then
			p_u_38.Pages.Shop:SetPage("Currency")
			v_u_7:PromptCurrencyBundlePurchase(v39, "WeaponKeys")
		else
			v_u_10:BuyDailyShopRefresh()
			v_u_6:CreateSound("rbxassetid://18100002432", 1.25, 1, script, true, 5)
		end
	end)
	v_u_8:GetDataChangedSignal("DailyShopRefreshesToday"):Connect(function()
		-- upvalues: (copy) p_u_38
		p_u_38:_UpdateRefreshText()
	end)
	v_u_8:GetDataChangedSignal("CosmeticInventory"):Connect(function()
		-- upvalues: (copy) p_u_38
		p_u_38:Generate()
	end)
	v_u_8:GetDataChangedSignal("WeaponInventory"):Connect(function()
		-- upvalues: (copy) p_u_38
		p_u_38:Generate()
	end)
	v_u_10.DailyShopRefreshed:Connect(function()
		-- upvalues: (copy) p_u_38
		p_u_38:Generate()
	end)
	p_u_38:_Setup()
	p_u_38:_UpdateFrame()
	p_u_38:_UpdateSizes()
	p_u_38:_UpdateRefreshText()
	v_u_12:Add(p_u_38.CountdownRefreshButton)
end
return v_u_14