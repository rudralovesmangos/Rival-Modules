local v_u_1 = game:GetService("CollectionService")
local v_u_2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("AdService")
local v_u_4 = game:GetService("Players")
local v_u_5 = require(v_u_2.Modules.CONSTANTS)
local v_u_6 = require(v_u_2.Modules.MonetizationLibrary)
local v_u_7 = require(v_u_2.Modules.CosmeticLibrary)
local v_u_8 = require(v_u_2.Modules.EventLibrary)
local v_u_9 = require(v_u_4.LocalPlayer.PlayerScripts.Controllers.MonetizationController)
local v_u_10 = require(v_u_4.LocalPlayer.PlayerScripts.Controllers.ComplianceController)
local v_u_11 = require(v_u_4.LocalPlayer.PlayerScripts.Controllers.PlayerDataController)
local v_u_12 = require(v_u_4.LocalPlayer.PlayerScripts.Controllers.FighterController)
local v_u_13 = require(v_u_4.LocalPlayer.PlayerScripts.Modules.UserInterface.MatchmakingCountdown)
local v_u_14 = require(v_u_4.LocalPlayer.PlayerScripts.Modules.UserInterface.Pages)
local v_u_15 = require(v_u_4.LocalPlayer.PlayerScripts.Modules.ButtonEffect)
local v_u_16 = require(v_u_4.LocalPlayer.PlayerScripts.Modules.LobbyElement)
local v_u_17 = require(v_u_4.LocalPlayer.PlayerScripts.Modules.RewardSlot)
local v_u_18 = v_u_4.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("LobbyVisuals")
local v_u_19 = setmetatable({}, v_u_16)
v_u_19.__index = v_u_19
function v_u_19._new(...) -- name: _new
	-- upvalues: (copy) v_u_16, (copy) v_u_19
	local v20 = v_u_16.new(...)
	local v21 = v_u_19
	local v22 = setmetatable(v20, v21)
	v22._spin_these = {}
	v22:_Init()
	return v22
end
function v_u_19.Update(p23, p24) -- name: Update
	-- upvalues: (copy) v_u_4
	local v25 = {}
	for v26 in pairs(p23._spin_these) do
		if v26:IsDescendantOf(workspace) or v26:IsDescendantOf(v_u_4.LocalPlayer.PlayerGui) then
			v26.Rotation = v26.Rotation + 15 * p24
		else
			v25[v26] = true
		end
	end
	for v27 in pairs(v25) do
		p23._spin_these[v27] = nil
	end
end
function v_u_19._BoardAdded(p28, p29) -- name: _BoardAdded
	-- upvalues: (copy) v_u_18, (copy) v_u_8, (copy) v_u_11, (copy) v_u_6, (copy) v_u_12, (copy) v_u_13, (copy) v_u_3, (copy) v_u_17, (copy) v_u_14, (copy) v_u_2, (copy) v_u_15, (copy) v_u_7, (copy) v_u_10, (copy) v_u_5, (copy) v_u_9, (copy) v_u_4
	local v_u_30 = (v_u_18:FindFirstChild(v_u_8.LOBBY_VISUALS_PROFILE) and v_u_18[v_u_8.LOBBY_VISUALS_PROFILE]:FindFirstChild("BillboardVideoAdsGui") or v_u_18.Default.BillboardVideoAdsGui):Clone()
	p28._spin_these[v_u_30.MainFrame.Background.CanvasGroup.Keys.ImageLabel] = true
	p28._spin_these[v_u_30.MainFrame.Background.CanvasGroup.Wraps.ImageLabel] = true
	local v_u_31 = 0
	local v_u_32 = nil
	local v_u_33 = false
	local function v36() -- name: update_visuals
		-- upvalues: (ref) v_u_11, (ref) v_u_6, (copy) v_u_30
		local v34 = v_u_11:Get("BillboardVideoAdProgress")
		local v35 = v_u_6:GetNumVideoAdsForBillboardReward(v_u_11:Get("BillboardVideoAdClaimedToday"))
		v_u_30.MainFrame.Play.Title.Text = string.format("%s<font size=\"8\"> /%s</font>", v34, v35)
	end
	v_u_11:GetDataChangedSignal("BillboardVideoAdClaimedToday"):Connect(v36)
	v_u_11:GetDataChangedSignal("BillboardVideoAdProgress"):Connect(v36)
	local v37 = v_u_11:Get("BillboardVideoAdProgress")
	local v38 = v_u_6:GetNumVideoAdsForBillboardReward(v_u_11:Get("BillboardVideoAdClaimedToday"))
	v_u_30.MainFrame.Play.Title.Text = string.format("%s<font size=\"8\"> /%s</font>", v37, v38)
	local function v_u_40() -- name: can_fetch_ads
		-- upvalues: (ref) v_u_12, (ref) v_u_13, (ref) v_u_11, (ref) v_u_6
		local v39 = v_u_12.LocalFighter and not v_u_12.LocalFighter:Get("IsInDuel") and not (v_u_12.LocalFighter:Get("IsInShootingRange") or v_u_13:IsVisible())
		if v39 then
			v39 = v_u_11:Get("BillboardVideoAdClaimedToday") < v_u_6.MAX_BILLBOARD_VIDEO_ADS_PER_DAY
		end
		return v39
	end
	local function v_u_50() -- name: update
		-- upvalues: (ref) v_u_31, (ref) v_u_32, (copy) v_u_30, (copy) v_u_40, (ref) v_u_33, (ref) v_u_3, (ref) v_u_11, (ref) v_u_17, (ref) v_u_6
		v_u_31 = v_u_31 + 1
		local v41 = v_u_31
		if v_u_32 then
			v_u_32:Destroy()
			v_u_32 = nil
		end
		v_u_30.MainFrame.Visible = false
		v_u_30.KeyBundle.Visible = true
		if v_u_40() then
			if not v_u_33 then
				local v42 = v_u_3.GetAdAvailabilityNowAsync
				local v43 = v_u_3
				local v44 = Enum.AdFormat.RewardedVideo
				local v45, v46 = pcall(v42, v43, v44)
				wait(0.5)
				if v41 ~= v_u_31 then
					return
				end
				if v45 then
					v45 = v46.AdAvailabilityResult == Enum.AdAvailabilityResult.IsAvailable
				end
				v_u_33 = v45
			end
			local v47 = v_u_11:Get("BillboardVideoAdClaimedToday") == 0
			v_u_30.MainFrame.Visible = v_u_33
			v_u_30.KeyBundle.Visible = not v_u_33
			v_u_30.MainFrame.Background.CanvasGroup.Keys.Visible = v47
			v_u_30.MainFrame.Background.CanvasGroup.Wraps.Visible = not v47
			if v_u_33 then
				local v48 = v_u_17.new
				local v49
				if v47 then
					v49 = v_u_6.BILLBOARD_KEYS_REWARD_DATA
				else
					v49 = v_u_6.BILLBOARD_WRAPS_REWARD_DATA
				end
				v_u_32 = v48(v49)
				v_u_32:ZoomOutViewportFrame()
				v_u_32:UseHighResolutionImage()
				v_u_32:HideBackground()
				v_u_32:HideWeaponVisual()
				v_u_32:SetInteractable(false)
				v_u_32:SetParent(v_u_30.MainFrame.Reward)
			end
		end
	end
	v_u_13.VisibilityChanged:Connect(v_u_50)
	local function v52() -- name: hook_local_fighter
		-- upvalues: (ref) v_u_12, (copy) v_u_50
		local v51 = v_u_12:WaitForLocalFighter()
		v51:GetDataChangedSignal("IsInDuel"):Connect(v_u_50)
		v51:GetDataChangedSignal("IsInShootingRange"):Connect(v_u_50)
		v_u_50()
	end
	task.spawn(v52)
	v_u_11:GetDataChangedSignal("BillboardVideoAdClaimedToday"):Connect(function()
		-- upvalues: (copy) v_u_50, (ref) v_u_32
		wait(1)
		v_u_50()
		wait(1)
		if not v_u_32 then
			v_u_50()
		end
	end)
	task.spawn(function()
		-- upvalues: (copy) v_u_50
		v_u_50()
		wait(2)
		while true do
			v_u_50()
			wait(15)
		end
	end)
	v_u_30.MainFrame.Button.MouseButton1Click:Connect(function()
		-- upvalues: (ref) v_u_14, (ref) v_u_2, (ref) v_u_3, (ref) v_u_33, (copy) v_u_50
		if not v_u_14.PageSystem.CurrentPage then
			task.spawn(function()
				-- upvalues: (ref) v_u_2, (ref) v_u_3
				if not v_u_2.Remotes.Misc.PlayVideoAdBillboard:InvokeServer() then
					local v53 = v_u_3.GetAdAvailabilityNowAsync
					local v54 = v_u_3
					local v55 = Enum.AdFormat.RewardedVideo
					pcall(v53, v54, v55)
					v_u_2.Remotes.Misc.PlayVideoAdBillboard:InvokeServer()
				end
			end)
			v_u_33 = false
			task.delay(2, function()
				-- upvalues: (ref) v_u_33, (ref) v_u_50
				v_u_33 = false
				v_u_50()
			end)
		end
	end)
	v_u_15:Add(v_u_30.MainFrame.Button, true)
	local v_u_56 = v_u_6.Bundles.keybundle_2
	local v57 = v_u_30.KeyBundle
	v57.Title.Text = v_u_56.DisplayName
	for v58, v59 in pairs(v_u_56.Rewards) do
		local v60 = v_u_7.Rewards[v59.Name]
		if v60 and (v60.Type == "Lootbox" and (v_u_10:ArePaidRandomItemsRestricted() and not v_u_5.SHOW_LOOTBOX_CONTENTS_TO_RESTRICTED_PLAYERS)) then
			continue
		end
		local v61 = v_u_17.new(v59)
		v61.Frame.LayoutOrder = v58
		v61:SetParent(v57.Rewards)
		v61:OnClick(function()
			-- upvalues: (ref) v_u_14
			if not v_u_14.PageSystem.CurrentPage then
				v_u_14.PageSystem:OpenPage("Shop")
				v_u_14.PageSystem:WaitForPage("Shop"):SetPage("Currency")
				v_u_14.PageSystem:WaitForPage("Shop"):InspectBundle("keybundle_2")
			end
		end)
	end
	v57.Button.MouseButton1Click:Connect(function()
		-- upvalues: (ref) v_u_14, (ref) v_u_9, (copy) v_u_56
		if not v_u_14.PageSystem.CurrentPage then
			v_u_9:PromptProductPurchase(v_u_56.ProductID)
		end
	end)
	v_u_9:SetRobuxText(v57.Button.Title, v_u_56.ProductID, Enum.InfoType.Product)
	v_u_15:Add(v57.Button)
	v_u_30.Adornee = p29
	v_u_30.Parent = v_u_4.LocalPlayer.PlayerGui
end
function v_u_19._Init(p_u_62) -- name: _Init
	-- upvalues: (copy) v_u_1
	v_u_1:GetInstanceAddedSignal("LobbyBillboardVideoAds"):Connect(function(p63)
		-- upvalues: (copy) p_u_62
		p_u_62:_BoardAdded(p63)
	end)
	for _, v64 in pairs(v_u_1:GetTagged("LobbyBillboardVideoAds")) do
		task.defer(p_u_62._BoardAdded, p_u_62, v64)
	end
end
return v_u_19._new()