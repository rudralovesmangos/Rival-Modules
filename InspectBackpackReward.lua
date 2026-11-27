local v_u_1 = game:GetService("ReplicatedStorage")
local v2 = game:GetService("Players")
local v_u_3 = require(v_u_1.Modules.CONSTANTS)
local v_u_4 = require(v_u_1.Modules.CosmeticLibrary)
local v_u_5 = require(v_u_1.Modules.ServerOsTime)
local v_u_6 = require(v_u_1.Modules.Utility)
local v_u_7 = require(v_u_1.Modules.Signal)
local v_u_8 = require(v2.LocalPlayer.PlayerScripts.Controllers:WaitForChild("PlayerDataController"))
local v_u_9 = require(v2.LocalPlayer.PlayerScripts.Controllers:WaitForChild("FighterController"))
local v_u_10 = require(v2.LocalPlayer.PlayerScripts.Modules:WaitForChild("ButtonEffect"))
local v_u_11 = require(v2.LocalPlayer.PlayerScripts.Modules:WaitForChild("RewardSlot"))
local v_u_12 = require(v2.LocalPlayer.PlayerScripts.Modules:WaitForChild("Prompt"))
local v_u_13 = setmetatable({}, v_u_12)
v_u_13.__index = v_u_13
function v_u_13.new(p14) -- name: new
	-- upvalues: (copy) v_u_12, (copy) v_u_13, (copy) v_u_7
	local v15 = v_u_12.new(script.Name)
	local v16 = v_u_13
	local v17 = setmetatable(v15, v16)
	v17.ClosePage = v_u_7.new()
	v17.Title = v17.PromptFrame:WaitForChild("Title")
	v17.ExpireText = v17.PromptFrame:WaitForChild("Expire")
	v17.ExpireLeftIcon = v17.ExpireText:WaitForChild("LeftIcon")
	v17.ExpireRightIcon = v17.ExpireText:WaitForChild("RightIcon")
	v17.Container = v17.PromptFrame:WaitForChild("Container")
	v17.CloseButton = v17.PromptFrame:WaitForChild("Close")
	v17.ButtonsFrame = v17.PromptFrame:WaitForChild("Buttons")
	v17.ViewContentsButton = v17.ButtonsFrame:WaitForChild("ViewContents")
	v17.UseButton = v17.ButtonsFrame:WaitForChild("Use")
	v17.Use3Button = v17.ButtonsFrame:WaitForChild("Use3")
	v17.UseMaxButton = v17.ButtonsFrame:WaitForChild("UseMax")
	v17.UseMaxButtonText = v17.UseMaxButton:WaitForChild("Price")
	v17._index = p14
	v17._reward_data = nil
	v17._cosmetic_info = nil
	v17._reward_info = nil
	v17._reward_slot = nil
	v17._expire_hash = 0
	v17._is_using = false
	v17:_Init()
	return v17
end
function v_u_13.Use(p18, p19) -- name: Use
	-- upvalues: (copy) v_u_9, (copy) v_u_1, (copy) v_u_4
	if not p18._is_using and (v_u_9.LocalFighter and not (v_u_9.LocalFighter:Get("IsInDuel") or v_u_9.LocalFighter:Get("IsInShootingRange"))) then
		p18._is_using = true
		local v20 = p18._reward_info
		if v20 then
			v20 = p18._reward_info.Type == "Lootbox"
		end
		if v_u_1.Remotes.Data.UseUnclaimedReward:InvokeServer(p18._index, p19) == "Success" then
			if v20 then
				if p18._reward_info and p18._reward_info.SoundProfile then
					p18.ClosePage:Fire()
				else
					p18:CloseRequest()
				end
			end
		elseif v20 then
			p18.OpenPrompt:Fire("ErrorMessage", "Whoops!", "Failed to open, you probably already have everything!")
		elseif p18._cosmetic_info and v_u_4.Types[p18._cosmetic_info.Type].IsWeaponCosmetic then
			p18.OpenPrompt:Fire("ErrorMessage", "Whoops!", "Failed to use, this item is probably already unlocked for all possible weapons!")
		else
			p18.OpenPrompt:Fire("ErrorMessage", "Whoops!", "Failed to use, this item is probably already unlocked!")
		end
		p18._is_using = false
	end
end
function v_u_13.Destroy(p21) -- name: Destroy
	-- upvalues: (copy) v_u_12
	p21:_Clear()
	v_u_12.Destroy(p21)
end
function v_u_13._UpdateTextBounds(p22) -- name: _UpdateTextBounds
	p22.ExpireLeftIcon.Position = UDim2.new(0.5, -p22.ExpireText.TextBounds.X / 2, 0.5, 0)
	p22.ExpireRightIcon.Position = UDim2.new(0.5, p22.ExpireText.TextBounds.X / 2, 0.5, 0)
end
function v_u_13._UpdateExpireText(p23) -- name: _UpdateExpireText
	-- upvalues: (copy) v_u_5, (copy) v_u_6
	p23.ExpireText.Text = not p23._reward_data and "" or (not p23._reward_data.ExpireTime and "" or (v_u_5:Get() >= p23._reward_data.ExpireTime and "This item has expired" or "Expires in " .. v_u_6:TimeFormat2(p23._reward_data.ExpireTime - v_u_5:GetRounded())))
end
function v_u_13._Clear(p24) -- name: _Clear
	if p24._reward_slot then
		p24._reward_slot:Destroy()
		p24._reward_slot = nil
	end
	p24._expire_hash = p24._expire_hash + 1
end
function v_u_13._Update(p_u_25) -- name: _Update
	-- upvalues: (copy) v_u_8, (copy) v_u_4, (copy) v_u_3, (copy) v_u_11
	p_u_25:_Clear()
	p_u_25._reward_data = v_u_8:Get("UnclaimedRewards")[p_u_25._index]
	local v26 = p_u_25._reward_data
	if v26 then
		v26 = v_u_4.Cosmetics[p_u_25._reward_data.Name]
	end
	p_u_25._cosmetic_info = v26
	local v27 = p_u_25._reward_data
	if v27 then
		v27 = v_u_4.Rewards[p_u_25._reward_data.Name]
	end
	p_u_25._reward_info = v27
	if p_u_25._reward_data then
		local v28 = p_u_25._reward_data.Weapon == "IsRandom" and "Random" or (p_u_25._reward_data.Weapon == "IsUniversal" and "Universal" or p_u_25._reward_data.Weapon)
		local v29 = p_u_25._reward_data.Quantity or 1
		local v30 = p_u_25.Title
		local v31
		if p_u_25._cosmetic_info and v28 then
			v31 = v28 .. " " .. p_u_25._cosmetic_info.Type
		elseif p_u_25._cosmetic_info then
			v31 = p_u_25._cosmetic_info.Type
		else
			v31 = p_u_25._reward_data.Name
		end
		v30.Text = v31
		p_u_25.ExpireText.Visible = p_u_25._reward_data.ExpireTime ~= nil
		local v32 = p_u_25.ViewContentsButton
		local v33 = ((not p_u_25._reward_info or p_u_25._reward_info.Type ~= "Lootbox") and true or false) and (p_u_25._cosmetic_info and v_u_4.Types[p_u_25._cosmetic_info.Type].IsWeaponCosmetic)
		if v33 then
			v33 = p_u_25._reward_data.Weapon == "IsRandom"
		end
		v32.Visible = v33
		local v34 = p_u_25.Use3Button
		local v35 = p_u_25.ViewContentsButton.Visible
		if v35 then
			v35 = v29 >= 3
		end
		v34.Visible = v35
		local v36 = p_u_25.UseMaxButton
		local v37 = p_u_25.ViewContentsButton.Visible
		if v37 then
			v37 = v29 > 3
		end
		v36.Visible = v37
		local v38 = p_u_25.UseMaxButtonText
		local v39 = v_u_3.MAX_BACKPACK_USE_QUANTITY
		v38.Text = "\195\151" .. math.min(v39, v29)
		p_u_25._reward_slot = v_u_11.new(p_u_25._reward_data)
		p_u_25._reward_slot:SetParent(p_u_25.Container)
		if p_u_25.ExpireText.Visible then
			task.spawn(function()
				-- upvalues: (copy) p_u_25
				local v40 = p_u_25
				v40._expire_hash = v40._expire_hash + 1
				local v41 = p_u_25._expire_hash
				while not p_u_25._destroyed or v41 ~= p_u_25._expire_hash do
					p_u_25:_UpdateExpireText()
					wait(1)
				end
			end)
		end
	else
		task.defer(p_u_25.CloseRequest, p_u_25)
	end
end
function v_u_13._Init(p_u_42) -- name: _Init
	-- upvalues: (copy) v_u_3, (copy) v_u_8, (copy) v_u_10
	p_u_42.CloseButton.MouseButton1Click:Connect(function()
		-- upvalues: (copy) p_u_42
		p_u_42:CloseRequest()
	end)
	p_u_42.UseButton.MouseButton1Click:Connect(function()
		-- upvalues: (copy) p_u_42
		p_u_42:Use(1)
	end)
	p_u_42.Use3Button.MouseButton1Click:Connect(function()
		-- upvalues: (copy) p_u_42
		p_u_42:Use(3)
	end)
	p_u_42.UseMaxButton.MouseButton1Click:Connect(function()
		-- upvalues: (copy) p_u_42, (ref) v_u_3
		p_u_42:Use(v_u_3.MAX_BACKPACK_USE_QUANTITY)
	end)
	p_u_42.ViewContentsButton.MouseButton1Click:Connect(function()
		-- upvalues: (copy) p_u_42
		if p_u_42._reward_data then
			p_u_42.OpenPrompt:Fire("InspectLootbox", p_u_42._reward_data.Name, p_u_42._reward_data.Weapon, "InspectBackpackReward", p_u_42._index)
		end
	end)
	p_u_42.ExpireText:GetPropertyChangedSignal("TextBounds"):Connect(function()
		-- upvalues: (copy) p_u_42
		p_u_42:_UpdateTextBounds()
	end)
	local v43 = p_u_42._connections
	local v44 = v_u_8:GetDataChangedSignal("UnclaimedRewards")
	table.insert(v43, v44:Connect(function()
		-- upvalues: (copy) p_u_42
		p_u_42:_Update()
	end))
	p_u_42:_Update()
	p_u_42:_UpdateTextBounds()
	v_u_10:Add(p_u_42.UseButton)
	v_u_10:Add(p_u_42.Use3Button)
	v_u_10:Add(p_u_42.UseMaxButton)
	v_u_10:Add(p_u_42.CloseButton)
	v_u_10:Add(p_u_42.ViewContentsButton)
end
return v_u_13