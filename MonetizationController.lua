local v_u_1 = game:GetService("MarketplaceService")
local v_u_2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("Players")
local v_u_4 = require(v_u_2.Modules.MonetizationLibrary)
local v_u_5 = require(v_u_2.Modules.Utility)
local v_u_6 = require(v_u_2.Modules.Signal)
local v_u_7 = require(v_u_3.LocalPlayer.PlayerScripts.Controllers:WaitForChild("PlayerDataController"))
local v_u_8 = {}
v_u_8.__index = v_u_8
function v_u_8._new() -- name: _new
	-- upvalues: (copy) v_u_8, (copy) v_u_6
	local v9 = v_u_8
	local v10 = setmetatable({}, v9)
	v10.PurchaseStarted = v_u_6.new()
	v10.PurchaseFinished = v_u_6.new()
	v10._fetch_robux_price_hashes = {}
	v10:_Init()
	return v10
end
function v_u_8.PromptBulkPurchase(p11, p12) -- name: PromptBulkPurchase
	-- upvalues: (copy) v_u_2
	local v13 = typeof(p12) == "table"
	local v14 = "Argument 1 invalid, expected a table, got " .. tostring(p12)
	assert(v13, v14)
	v_u_2.Remotes.Misc.PromptBulkPurchase:FireServer(p12)
	p11:_StartPrompt()
end
function v_u_8.PromptPurchase(p15, p16) -- name: PromptPurchase
	-- upvalues: (copy) v_u_1, (copy) v_u_3
	local v17 = typeof(p16) == "number"
	local v18 = "Argument 1 invalid, expected a number, got " .. tostring(p16)
	assert(v17, v18)
	v_u_1:PromptPurchase(v_u_3.LocalPlayer, p16)
	p15:_StartPrompt()
end
function v_u_8.PromptProductPurchase(p19, p20) -- name: PromptProductPurchase
	-- upvalues: (copy) v_u_1, (copy) v_u_3
	local v21 = typeof(p20) == "number"
	local v22 = "Argument 1 invalid, expected a number, got " .. tostring(p20)
	assert(v21, v22)
	v_u_1:PromptProductPurchase(v_u_3.LocalPlayer, p20)
	p19:_StartPrompt()
end
function v_u_8.PromptGamePassPurchase(p23, p24) -- name: PromptGamePassPurchase
	-- upvalues: (copy) v_u_7, (copy) v_u_4, (copy) v_u_1, (copy) v_u_3
	local v25 = typeof(p24) == "number"
	local v26 = "Argument 1 invalid, expected a number, got " .. tostring(p24)
	assert(v25, v26)
	if not v_u_7:HasGamepass(v_u_4:GetGamepassName(p24)) then
		v_u_1:PromptGamePassPurchase(v_u_3.LocalPlayer, p24)
		p23:_StartPrompt()
	end
end
function v_u_8.PromptSubscriptionPurchase(p27, p28) -- name: PromptSubscriptionPurchase
	-- upvalues: (copy) v_u_1, (copy) v_u_3
	local v29 = typeof(p28) == "string"
	local v30 = "Argument 1 invalid, expected a string, got " .. tostring(p28)
	assert(v29, v30)
	v_u_1:PromptSubscriptionPurchase(v_u_3.LocalPlayer, p28)
	p27:_StartPrompt()
end
function v_u_8.PromptCurrencyBundlePurchase(p31, p32, p33) -- name: PromptCurrencyBundlePurchase
	-- upvalues: (copy) v_u_7, (copy) v_u_4
	local v34 = p32 - v_u_7:Get(p33)
	if v34 <= 0 then
		return
	else
		local v35 = p33 == "WeaponKeys" and v_u_4.NUM_KEY_BUNDLES or (p33 == "EventCurrency" and v_u_4.NUM_EVENT_CURRENCY_BUNDLES or nil)
		local v36 = p33 == "WeaponKeys" and "keybundle_" or (p33 == "EventCurrency" and "eventcurrencybundle_" or nil)
		if v35 and v36 then
			for v37 = 1, v35 do
				local v38 = v_u_4.Bundles[v36 .. v37]
				if v34 > v38.Rewards[1].Quantity then
					continue
				end
				p31:PromptProductPurchase(v38.ProductID)
				return true
			end
		end
	end
end
function v_u_8.FetchRobuxPrice(_, p39, p40) -- name: FetchRobuxPrice
	-- upvalues: (copy) v_u_1
	local v41 = v_u_1.GetProductInfoAsync
	local v42 = v_u_1
	local v43 = p40 or Enum.InfoType.Product
	local v45, v45 = pcall(v41, v42, p39, v43)
	if not v45 then
		warn("Failed to fetch robux price:", v45)
	end
	if v45 then
		if v45 then
			v45 = v45.PriceInRobux
		end
	end
	return v45
end
function v_u_8.SetRobuxText(p_u_46, p_u_47, ...) -- name: SetRobuxText
	p_u_46._fetch_robux_price_hashes[p_u_47] = (p_u_46._fetch_robux_price_hashes[p_u_47] or 0) + 1
	local v_u_48 = p_u_46._fetch_robux_price_hashes[p_u_47]
	task.spawn(function(...)
		-- upvalues: (copy) p_u_47, (copy) p_u_46, (copy) v_u_48
		p_u_47.Text = "\226\128\162 \226\128\162 \226\128\162"
		p_u_47.Text = p_u_46:_GetRobuxText(v_u_48, p_u_47, ...) or p_u_47.Text
	end, ...)
end
function v_u_8.SetRobuxTextWithFormat(p_u_49, p_u_50, p_u_51, ...) -- name: SetRobuxTextWithFormat
	p_u_49._fetch_robux_price_hashes[p_u_51] = (p_u_49._fetch_robux_price_hashes[p_u_51] or 0) + 1
	local v_u_52 = p_u_49._fetch_robux_price_hashes[p_u_51]
	task.spawn(function(...)
		-- upvalues: (copy) p_u_51, (copy) p_u_49, (copy) v_u_52, (copy) p_u_50
		p_u_51.Text = "\226\128\162 \226\128\162 \226\128\162"
		local v53 = p_u_49:_GetRobuxText(v_u_52, p_u_51, ...)
		if v53 then
			p_u_51.Text = string.format(p_u_50, v53)
		end
	end, ...)
end
function v_u_8.VerifyUGC(_, p54) -- name: VerifyUGC
	-- upvalues: (copy) v_u_2
	v_u_2.Remotes.Data.VerifyUGC:FireServer(p54)
end
function v_u_8._GetRobuxText(p55, p56, p57, ...) -- name: _GetRobuxText
	-- upvalues: (copy) v_u_5
	local v58 = { ... }
	local v59 = 0
	for v60 = 1, #v58, 2 do
		local v61 = p55:FetchRobuxPrice(v58[v60], v58[v60 + 1])
		if p56 ~= p55._fetch_robux_price_hashes[p57] or not v61 then
			return
		end
		v59 = v59 + v61
	end
	return utf8.char(57346) .. " " .. v_u_5:PrettyNumber(v59)
end
function v_u_8._StartPrompt(p62) -- name: _StartPrompt
	p62.PurchaseStarted:Fire()
end
function v_u_8._FinishPrompt(p63, p64) -- name: _FinishPrompt
	p63.PurchaseFinished:Fire(p64)
end
function v_u_8._Init(p_u_65) -- name: _Init
	-- upvalues: (copy) v_u_1, (copy) v_u_4, (copy) v_u_2
	v_u_1.PromptBulkPurchaseFinished:Connect(function(_, _, p66)
		-- upvalues: (copy) p_u_65, (ref) v_u_4
		local v67 = false
		for _, v68 in pairs(p66.Items) do
			if v68.status ~= Enum.MarketplaceItemPurchaseStatus.Success then
				continue
			end
			v67 = true
		end
		p_u_65:_FinishPrompt(v67)
		if v67 then
			local v69 = {}
			for _, v70 in pairs(p66.Items) do
				local v71 = v_u_4.UGCAssetIDToName
				local v72 = v70.id
				local v73 = v71[tostring(v72)]
				if not v73 then
					continue
				end
				table.insert(v69, v73)
			end
			if #v69 > 0 then
				p_u_65:VerifyUGC(v69)
			end
		end
	end)
	v_u_2.Remotes.Misc.StartPurchasePrompt.OnClientEvent:Connect(function()
		-- upvalues: (copy) p_u_65
		p_u_65:_StartPrompt()
	end)
	v_u_2.Remotes.Misc.FinishPurchasePrompt.OnClientEvent:Connect(function(p74)
		-- upvalues: (copy) p_u_65
		p_u_65:_FinishPrompt(p74)
	end)
end
return v_u_8._new()