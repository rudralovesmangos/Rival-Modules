local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("Players")
local v_u_3 = require(v1.Modules.MonetizationLibrary)
local v_u_4 = require(v1.Modules.SeasonLibrary)
local v_u_5 = require(v1.Modules.BetterDebris)
local v_u_6 = require(v1.Modules.EventLibrary)
local v_u_7 = require(v1.Modules.ItemLibrary)
require(v1.Modules.ShopLibrary)
local v_u_8 = require(v_u_2.LocalPlayer.PlayerScripts.Controllers.PlayerDataController)
local v_u_9 = require(v_u_2.LocalPlayer.PlayerScripts.Modules.UserInterface.Spotlight)
local v_u_10 = require(v_u_2.LocalPlayer.PlayerScripts.Modules.VideoAdRewards)
local v_u_11 = require(v_u_2.LocalPlayer.PlayerScripts.Modules.ButtonEffect)
local v_u_12 = require(v_u_2.LocalPlayer.PlayerScripts.Modules.RewardSlot)
local v_u_13 = {
	"lootbox_Skin Case",
	"lootbox_Skin Case 2",
	"lootbox_Skin Case 3",
	"lootbox_Wrap Box",
	"lootbox_Wrap Box 2",
	"lootbox_Wrap Box 3",
	"lootbox_Charm Capsule",
	"lootbox_Finisher Pack",
	"lootbox_Finisher Pack 2",
	"loose_arena",
	"loose_randomwrap",
	"loose_universalwrap"
}
local v_u_14 = {}
v_u_14.__index = v_u_14
function v_u_14.new(p15) -- name: new
	-- upvalues: (copy) v_u_14, (copy) v_u_10
	local v16 = v_u_14
	local v17 = setmetatable({}, v16)
	v17.Pages = p15
	v17.Frame = v17.Pages.Frame:WaitForChild("Home")
	v17.Container = v17.Frame:WaitForChild("Container")
	v17.EventFrame = v17.Container:WaitForChild("Event")
	v17.OtherFrame = v17.Container:WaitForChild("Other")
	v17.LooseFrame = v17.OtherFrame:WaitForChild("Loose")
	v17.CarouselFrame = v17.OtherFrame:WaitForChild("Carousel")
	v17.CarouselContainer = v17.CarouselFrame:WaitForChild("Container")
	v17.VideoAdRewardsFrame = v17.CarouselContainer:WaitForChild("VideoAdRewards")
	v17.CarouselButtons = v17.CarouselFrame:WaitForChild("Buttons")
	v17.CarouselButtonsContainer = v17.CarouselButtons:WaitForChild("Container")
	v17.CarouselButtonsLayout = v17.CarouselButtonsContainer:WaitForChild("Layout")
	v17.CarouselButtonsBackground = v17.CarouselButtons:WaitForChild("Background")
	v17.VideoAdRewardsButton = v17.CarouselButtonsContainer:WaitForChild("VideoAdRewards")
	v17.RedirectFrame = v17.OtherFrame:WaitForChild("Redirect")
	v17.RedirectDailyButton = v17.RedirectFrame:WaitForChild("Daily"):WaitForChild("Container")
	v17.RedirectWeaponsButton = v17.RedirectFrame:WaitForChild("Weapons"):WaitForChild("Container")
	v17.RedirectKeysButton = v17.RedirectFrame:WaitForChild("Keys"):WaitForChild("Container")
	v17.BattlePassFrame = v17.OtherFrame:WaitForChild("BattlePass")
	v17.BattlePassContainer = v17.BattlePassFrame:WaitForChild("Container")
	v17.BattlePassBackground = v17.BattlePassContainer:WaitForChild("Background")
	v17.BattlePassNotHoveringFrame = v17.BattlePassContainer:WaitForChild("NotHovering")
	v17.BattlePassNotHoveringIcon = v17.BattlePassNotHoveringFrame:WaitForChild("Icon")
	v17.BattlePassIsHoveringFrame = v17.BattlePassContainer:WaitForChild("IsHovering")
	v17.BattlePassIsHoveringIcon = v17.BattlePassIsHoveringFrame:WaitForChild("Icon")
	v17.BattlePassRewardsFrame = v17.BattlePassIsHoveringFrame:WaitForChild("Rewards")
	v17.VideoAdRewards = v_u_10.new()
	v17._is_open_hash = 0
	v17._current_carousel_index = 0
	v17._last_carousel_index_change_time = 0
	v17._shop_slots = {}
	v17._carousel_buttons = {}
	v17._pause_carousel_until = 0
	v17._season_pass_reward_slots = {}
	v17:_Init()
	return v17
end
function v_u_14.GetVisualIndex(p18) -- name: GetVisualIndex
	local v19 = 0
	for v20 = 1, p18._current_carousel_index do
		if not p18._carousel_buttons[v20].Visible then
			continue
		end
		v19 = v19 + 1
	end
	return v19
end
function v_u_14.SetCarouselIndexByName(p21, p22) -- name: SetCarouselIndexByName
	for v23, v24 in pairs(p21._carousel_buttons) do
		if v24.Name ~= p22 then
			continue
		end
		p21:SetCarouselIndex(v23)
		return
	end
end
function v_u_14.SetCarouselIndex(p25, p26) -- name: SetCarouselIndex
	-- upvalues: (copy) v_u_2
	p25._current_carousel_index = (p26 - 1) % #p25._carousel_buttons + 1
	local v27 = UDim2.new(0.5 - 0.975 * (p25:GetVisualIndex() - 1), 0, -0.025, 0)
	if p25.CarouselContainer:IsDescendantOf(v_u_2) then
		p25.CarouselContainer:TweenPosition(v27, "Out", "Quint", 0.75, true)
	else
		p25.CarouselContainer.Position = v27
	end
	for v28, v29 in pairs(p25._carousel_buttons) do
		local v30 = v28 == p25._current_carousel_index
		v29.ImageLabel.Size = v30 and UDim2.new(0.5, 0, 0.5, 0) or UDim2.new(0.3, 0, 0.3, 0)
		v29.ImageLabel.ImageTransparency = v30 and 0 or 0.75
	end
	p25.VideoAdRewards:WeakUpdate()
end
function v_u_14.PauseCarousel(p31, p32) -- name: PauseCarousel
	p31._pause_carousel_until = tick() + p32
end
function v_u_14.Open(p33) -- name: Open
	p33._is_open_hash = p33._is_open_hash + 1
	p33:_UpdateShopSlots()
	p33:_ScrollToDefault()
	task.spawn(p33._CarouselLoop, p33)
	task.spawn(p33._SeasonPassLoop, p33)
	p33.VideoAdRewards:Update()
end
function v_u_14.Close(p34) -- name: Close
	p34:_UpdateShopSlots()
	p34._is_open_hash = p34._is_open_hash + 1
end
function v_u_14.Setup(p35) -- name: Setup
	-- upvalues: (copy) v_u_3
	local v36 = v_u_3.VIDEO_AD_REWARDS_ENABLED
	if v36 then
		v36 = #v_u_3.VideoAdRewards > 0
	end
	p35.VideoAdRewardsFrame.Visible = v36
	p35.VideoAdRewardsButton.Visible = v36
	task.defer(p35.VideoAdRewards.Update, p35.VideoAdRewards)
	p35:_SetupCarouselSlot("VideoAdRewards")
	for _, v37 in pairs(p35.Pages.Shop.BUNDLE_NAMES) do
		p35:_SetupCarouselSlot(v37, true)
	end
	p35:SetCarouselIndex(1)
	p35:_ScrollToDefault()
end
function v_u_14._UpdateSeasonPassVisuals(p38) -- name: _UpdateSeasonPassVisuals
	-- upvalues: (copy) v_u_8, (copy) v_u_4, (copy) v_u_7
	local v39 = v_u_8:Get("Seasons")[v_u_4.CurrentSeason.Name]
	if v39 then
		v39 = v39.BattlePass
	end
	local v40 = v39 and v39.MaxPassTrackNum or 0
	local v41 = v_u_4.PASS_TRACK_IMAGES
	local v42 = #v_u_4.PASS_TRACK_IMAGES
	local v43 = v41[math.clamp(v40, 1, v42)]
	p38.BattlePassIsHoveringIcon.Image = v43
	p38.BattlePassNotHoveringIcon.Image = v43
	p38.BattlePassBackground.ImageColor3 = v_u_7.StatusByPassTrackNum[v40].PassColor
end
function v_u_14._SeasonPassLoop(p_u_44) -- name: _SeasonPassLoop
	-- upvalues: (copy) v_u_12, (copy) v_u_5, (copy) v_u_4
	for _, v45 in pairs(p_u_44._season_pass_reward_slots) do
		v45:Destroy()
	end
	p_u_44._season_pass_reward_slots = {}
	local function v53(p46, p47, p48) -- name: create_slot
		-- upvalues: (ref) v_u_12, (copy) p_u_44, (ref) v_u_5
		local v49 = (p47 - -1.5) / 0.5
		local v_u_50 = v_u_12.new(p46)
		v_u_50:SetInteractable(false)
		v_u_50:SetNameText("")
		v_u_50:SetParent(p_u_44.BattlePassRewardsFrame)
		local v51 = p_u_44._season_pass_reward_slots
		table.insert(v51, v_u_50)
		v_u_5:AddItem(v_u_50, v49)
		v_u_50.Frame.Position = UDim2.new(p47, 0, p48, 0)
		v_u_50.Frame:TweenPosition(UDim2.new(-1.5, 0, p48, 0), "InOut", "Linear", v49, true)
		task.delay(v49, function()
			-- upvalues: (ref) p_u_44, (copy) v_u_50
			local v52 = table.find(p_u_44._season_pass_reward_slots, v_u_50)
			if v52 then
				table.remove(p_u_44._season_pass_reward_slots, v52)
			end
		end)
	end
	local v54 = p_u_44._is_open_hash
	local v55 = 0
	while true do
		for v56 = 1, v_u_4.CurrentSeason.NumBattlePassTiers do
			for v57 = 1, v_u_4.CurrentSeason.NumBattlePassTracks do
				local v58 = v_u_4.CurrentSeason.BattlePassRewards[v56][v57]
				if not v58 then
					continue
				end
				v53(v58, math.min(7, v55) * 1 + 0.5, v57 - 1 + 0.5)
			end
			v55 = v55 + 1
			if v55 > 7 then
				wait(2)
			end
			if v54 == p_u_44._is_open_hash then
				break
			end
			return
		end
	end
end
function v_u_14._UpdateCarouselButtonsBackground(p59) -- name: _UpdateCarouselButtonsBackground
	p59.CarouselButtonsBackground.Size = UDim2.new(0, p59.CarouselButtonsLayout.AbsoluteContentSize.X, 1, 0)
end
function v_u_14._SetupCarouselSlot(p_u_60, p_u_61, p62) -- name: _SetupCarouselSlot
	-- upvalues: (copy) v_u_11, (copy) v_u_3
	local v_u_63 = p_u_60.CarouselButtonsContainer:WaitForChild(p_u_61)
	v_u_63.MouseButton1Click:Connect(function()
		-- upvalues: (copy) p_u_60, (copy) v_u_63
		p_u_60._last_carousel_index_change_time = tick()
		p_u_60:SetCarouselIndex(table.find(p_u_60._carousel_buttons, v_u_63))
	end)
	v_u_11:Add(v_u_63)
	local v64 = p_u_60._carousel_buttons
	table.insert(v64, v_u_63)
	if p62 then
		local v65 = v_u_3.Bundles[p_u_61]
		local v_u_66 = p_u_60.CarouselContainer:WaitForChild(p_u_61)
		local v67 = v_u_66:WaitForChild("Container")
		v67.MouseButton1Click:Connect(function()
			-- upvalues: (copy) p_u_60, (copy) p_u_61, (copy) v_u_66
			p_u_60.Pages.Shop:InspectBundle(p_u_61, v_u_66)
		end)
		v67.Button.Bubble.Title.RichText = true
		v67.Button.Bubble.Title.Text = v65.BubbleText or ""
		v67.Button.Bubble.Visible = v67.Button.Bubble.Title.Text ~= ""
		v_u_11:Add(v67, nil, {
			["HoverRatio"] = 1.01,
			["ReleaseRatio"] = 1.01
		})
	end
	table.sort(p_u_60._carousel_buttons, function(p68, p69)
		return p68.LayoutOrder < p69.LayoutOrder
	end)
end
function v_u_14._ScrollToDefault(p70) -- name: _ScrollToDefault
	p70:SetCarouselIndexByName("VideoAdRewards")
end
function v_u_14._CarouselLoop(_) -- name: _CarouselLoop end
function v_u_14._UpdateShopSlots(p71) -- name: _UpdateShopSlots
	-- upvalues: (copy) v_u_13, (copy) v_u_6
	for _, v72 in pairs(p71._shop_slots) do
		v72:Destroy()
	end
	p71._shop_slots = {}
	if p71.Pages.Shop:IsOpen() then
		for v73, v74 in pairs({ v_u_13, v_u_6.IS_ACTIVE and v_u_6.SHOP_ENTRIES_OVERVIEW or nil }) do
			for _, v75 in pairs(v74) do
				local v76
				if v73 == 2 then
					v76 = p71.EventFrame
				else
					v76 = p71.LooseFrame
				end
				local v77 = p71.Pages.Shop:CreateShopSlot(nil, v76:WaitForChild(v75), v75)
				if not v77 then
					continue
				end
				local v78 = p71._shop_slots
				table.insert(v78, v77)
			end
		end
	end
end
function v_u_14._Setup(p79) -- name: _Setup
	-- upvalues: (copy) v_u_6
	p79.VideoAdRewards.Frame.Parent = p79.VideoAdRewardsFrame
	local v80 = p79.EventFrame
	local v81 = v_u_6.IS_ACTIVE and v_u_6.SHOP_ENTRIES_OVERVIEW
	if v81 then
		v81 = #v_u_6.SHOP_ENTRIES_OVERVIEW > 0
	end
	v80.Visible = v81
	for v82, v83 in pairs(v_u_6.IS_ACTIVE and (v_u_6.SHOP_ENTRIES_OVERVIEW and v_u_6.SHOP_ENTRIES_OVERVIEW) or {}) do
		local v84 = Instance.new("Frame")
		v84.BackgroundTransparency = 1
		v84.Size = UDim2.new(1, 0, 1, 0)
		v84.LayoutOrder = v82
		v84.ZIndex = -v82
		v84.Name = v83
		v84.Parent = p79.EventFrame
	end
end
function v_u_14._Init(p_u_85) -- name: _Init
	-- upvalues: (copy) v_u_9, (copy) v_u_8, (copy) v_u_11
	p_u_85.CarouselButtonsLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		-- upvalues: (copy) p_u_85
		p_u_85:_UpdateCarouselButtonsBackground()
	end)
	p_u_85.RedirectDailyButton.MouseButton1Click:Connect(function()
		-- upvalues: (copy) p_u_85
		p_u_85.Pages.Shop:SetPage("Daily")
	end)
	p_u_85.RedirectWeaponsButton.MouseButton1Click:Connect(function()
		-- upvalues: (copy) p_u_85
		p_u_85.Pages.Shop:SetPage("Weapons")
	end)
	p_u_85.RedirectKeysButton.MouseButton1Click:Connect(function()
		-- upvalues: (copy) p_u_85
		p_u_85.Pages.Shop:SetPage("Currency")
	end)
	p_u_85.BattlePassContainer.MouseButton1Click:Connect(function()
		-- upvalues: (copy) p_u_85
		p_u_85.Pages.Shop:SetPage("BattlePass")
	end)
	p_u_85.VideoAdRewards.PlayedAd:Connect(function()
		-- upvalues: (copy) p_u_85
		p_u_85:PauseCarousel(25)
	end)
	p_u_85.BattlePassContainer.MouseEnter:Connect(function()
		-- upvalues: (copy) p_u_85, (ref) v_u_9
		p_u_85.BattlePassIsHoveringFrame.Visible = true
		p_u_85.BattlePassNotHoveringFrame.Visible = false
		v_u_9:ChangeSubject(p_u_85.BattlePassContainer)
	end)
	p_u_85.BattlePassContainer.MouseLeave:Connect(function()
		-- upvalues: (copy) p_u_85, (ref) v_u_9
		p_u_85.BattlePassIsHoveringFrame.Visible = false
		p_u_85.BattlePassNotHoveringFrame.Visible = true
		v_u_9:ChangeSubject(nil, p_u_85.BattlePassContainer)
	end)
	v_u_8:GetDataChangedSignal("CosmeticInventory"):Connect(function()
		-- upvalues: (copy) p_u_85
		p_u_85:_UpdateShopSlots()
	end)
	v_u_8:GetDataChangedSignal("WeaponInventory"):Connect(function()
		-- upvalues: (copy) p_u_85
		p_u_85:_UpdateShopSlots()
	end)
	v_u_8:GetDataChangedSignal("Seasons"):Connect(function()
		-- upvalues: (copy) p_u_85
		p_u_85:_UpdateSeasonPassVisuals()
	end)
	p_u_85:_Setup()
	p_u_85:_UpdateSeasonPassVisuals()
	p_u_85:_UpdateCarouselButtonsBackground()
	v_u_11:Add(p_u_85.RedirectKeysButton)
	v_u_11:Add(p_u_85.RedirectDailyButton)
	v_u_11:Add(p_u_85.RedirectWeaponsButton)
	v_u_11:Add(p_u_85.BattlePassContainer, nil, {
		["HoverRatio"] = 1.01,
		["ReleaseRatio"] = 1.01
	})
end
return v_u_14