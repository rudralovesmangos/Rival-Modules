local v_u_1 = game:GetService("MarketplaceService")
local v_u_2 = game:GetService("ReplicatedStorage")
game:GetService("GuiService")
local v_u_3 = game:GetService("Players")
local v_u_4 = require(v_u_2.Modules.CONSTANTS)
local v_u_5 = require(v_u_2.Modules.MonetizationLibrary)
local v_u_6 = require(v_u_2.Modules.SeasonLibrary)
local v_u_7 = require(v_u_2.Modules.Utility)
local v_u_8 = require(v_u_3.LocalPlayer.PlayerScripts.Controllers:WaitForChild("MonetizationController"))
local v_u_9 = require(v_u_3.LocalPlayer.PlayerScripts.Controllers:WaitForChild("PlayerDataController"))
local v_u_10 = require(v_u_3.LocalPlayer.PlayerScripts.Controllers:WaitForChild("ComplianceController"))
local v_u_11 = require(v_u_3.LocalPlayer.PlayerScripts.Modules:WaitForChild("ButtonEffect"))
local v_u_12 = require(v_u_3.LocalPlayer.PlayerScripts.Modules:WaitForChild("PromptSystem"))
local v_u_13 = require(v_u_3.LocalPlayer.PlayerScripts.Modules:WaitForChild("DropdownSlot"))
local v_u_14 = require(v_u_3.LocalPlayer.PlayerScripts.Modules:WaitForChild("RewardSlot"))
local v_u_15 = require(v_u_3.LocalPlayer.PlayerScripts.Modules:WaitForChild("Page"))
local v_u_16 = v_u_3.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("GiftPlayerEmptySlot")
local v_u_17 = v_u_3.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("GiftProductSlot")
local v_u_18 = v_u_3.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("GiftPlayerSlot")
local v_u_19 = {
	"None",
	"Enjoy!",
	"Thanks!",
	"Surprise!",
	"I appreciate you!",
	"You\'re the best!",
	"Thanks for everything!",
	"You played well!",
	"You owe me!",
	"Happy birthday!",
	"Merry Christmas!",
	"Happy holidays!",
	"Congratulations!",
	"Custom"
}
local v_u_20 = setmetatable({}, v_u_15)
v_u_20.__index = v_u_20
function v_u_20._new() -- name: _new
	-- upvalues: (copy) v_u_15, (copy) v_u_20, (copy) v_u_12
	local v21 = v_u_15.new(script.Name)
	local v22 = v_u_20
	local v23 = setmetatable(v21, v22)
	v23.CloseButton = v23.PageFrame:WaitForChild("Close")
	v23.PromptsFrame = v23.PageFrame:WaitForChild("Prompts")
	v23.BackButton = v23.PageFrame:WaitForChild("Back")
	v23.Container = v23.PageFrame:WaitForChild("Container")
	v23.SelectPlayerFrame = v23.Container:WaitForChild("SelectPlayer")
	v23.PlayersList = v23.SelectPlayerFrame:WaitForChild("List")
	v23.PlayersContainer = v23.PlayersList:WaitForChild("Container")
	v23.PlayersLayout = v23.PlayersContainer:WaitForChild("Layout")
	v23.PlayersGiftRewardFrame = v23.PlayersContainer:WaitForChild("GiftReward")
	v23.PlayersGiftRewardProgressBar = v23.PlayersGiftRewardFrame:WaitForChild("Progress"):WaitForChild("Bar")
	v23.PlayersGiftRewardContainer = v23.PlayersGiftRewardFrame:WaitForChild("Container")
	v23.PlayersGiftRewardGoalText = v23.PlayersGiftRewardFrame:WaitForChild("Goal")
	v23.PlayersOfflineGiftFrame = v23.PlayersContainer:WaitForChild("OfflineGift")
	v23.PlayersOfflineGiftBox = v23.PlayersOfflineGiftFrame:WaitForChild("Input"):WaitForChild("Box")
	v23.PlayersOfflineGiftButton = v23.PlayersOfflineGiftFrame:WaitForChild("Button")
	v23.PlayersOfflineGiftButtonOn = v23.PlayersOfflineGiftButton:WaitForChild("On")
	v23.PlayersOfflineGiftButtonOff = v23.PlayersOfflineGiftButton:WaitForChild("Off")
	v23.PlayersOfflineGiftButtonIcon = v23.PlayersOfflineGiftButton:WaitForChild("Icon")
	v23.PlayersOfflineGiftButtonCountdown = v23.PlayersOfflineGiftButton:WaitForChild("Countdown")
	v23.SelectProductFrame = v23.Container:WaitForChild("SelectProduct")
	v23.ProductsEmptyFrame = v23.SelectProductFrame:WaitForChild("Empty")
	v23.ProductsDotsFrame = v23.SelectProductFrame:WaitForChild("Dots")
	v23.ProductsList = v23.SelectProductFrame:WaitForChild("List")
	v23.ProductsContainer = v23.ProductsList:WaitForChild("Container")
	v23.ProductsLayout = v23.ProductsContainer:WaitForChild("Layout")
	v23.ProductsPlayerFrame = v23.ProductsContainer:WaitForChild("Player")
	v23.ProductsPlayerPicture = v23.ProductsPlayerFrame:WaitForChild("Picture")
	v23.ProductsPlayerUsernameText = v23.ProductsPlayerFrame:WaitForChild("Username")
	v23.ProductsPlayerDisplayNameText = v23.ProductsPlayerFrame:WaitForChild("DisplayName")
	v23.ConfirmPurchaseFrame = v23.Container:WaitForChild("ConfirmPurchase")
	v23.ConfirmPurchaseDotsFrame = v23.ConfirmPurchaseFrame:WaitForChild("Dots")
	v23.ConfirmPurchaseList = v23.ConfirmPurchaseFrame:WaitForChild("List")
	v23.ConfirmPurchaseContainer = v23.ConfirmPurchaseList:WaitForChild("Container")
	v23.ConfirmPurchaseLayout = v23.ConfirmPurchaseContainer:WaitForChild("Layout")
	v23.ConfirmPurchasePlayerFrame = v23.ConfirmPurchaseContainer:WaitForChild("Player")
	v23.ConfirmPurchasePlayerPicture = v23.ConfirmPurchasePlayerFrame:WaitForChild("Picture")
	v23.ConfirmPurchasePlayerUsernameText = v23.ConfirmPurchasePlayerFrame:WaitForChild("Username")
	v23.ConfirmPurchasePlayerDisplayNameText = v23.ConfirmPurchasePlayerFrame:WaitForChild("DisplayName")
	v23.ConfirmPurchaseProductFrame = v23.ConfirmPurchaseContainer:WaitForChild("Product")
	v23.ConfirmPurchaseProductIcon = v23.ConfirmPurchaseProductFrame:WaitForChild("Icon")
	v23.ConfirmPurchaseProductTitleText = v23.ConfirmPurchaseProductFrame:WaitForChild("DisplayName")
	v23.ConfirmPurchaseWarningsFrame = v23.ConfirmPurchaseContainer:WaitForChild("Warnings")
	v23.ConfirmPurchaseWarningsGiftTicketsFrame = v23.ConfirmPurchaseWarningsFrame:WaitForChild("GiftTickets")
	v23.ConfirmPurchaseWarningsGiftTicketsText = v23.ConfirmPurchaseWarningsGiftTicketsFrame:WaitForChild("Icon"):WaitForChild("Quantity")
	v23.ConfirmPurchaseWarningsOfflineGiftingFrame = v23.ConfirmPurchaseWarningsFrame:WaitForChild("OfflineGifting")
	v23.ConfirmPurchaseBuyFrame = v23.ConfirmPurchaseContainer:WaitForChild("Buy")
	v23.ConfirmPurchaseBuyButton = v23.ConfirmPurchaseBuyFrame:WaitForChild("Button")
	v23.ConfirmPurchaseBuyButtonGiftTicketIcon = v23.ConfirmPurchaseBuyButton:WaitForChild("GiftTicket")
	v23.ConfirmPurchaseBuyButtonRobuxPrice = v23.ConfirmPurchaseBuyButton:WaitForChild("Robux")
	v23.ConfirmPurchaseSettingsFrame = v23.ConfirmPurchaseContainer:WaitForChild("Settings")
	v23.ConfirmPurchaseSettingsContainer = v23.ConfirmPurchaseSettingsFrame:WaitForChild("Container")
	v23.ConfirmPurchaseSettingsLayout = v23.ConfirmPurchaseSettingsContainer:WaitForChild("Layout")
	v23.ConfirmPurchaseSettingsNoteFrame = v23.ConfirmPurchaseSettingsContainer:WaitForChild("Note")
	v23.ConfirmPurchaseSettingsNoteDropdownFrame = v23.ConfirmPurchaseSettingsNoteFrame:WaitForChild("Dropdown")
	v23.ConfirmPurchaseSettingsNoteDropdownButton = v23.ConfirmPurchaseSettingsNoteDropdownFrame:WaitForChild("Button")
	v23.ConfirmPurchaseSettingsNoteDropdownButtonTitle = v23.ConfirmPurchaseSettingsNoteDropdownButton:WaitForChild("Title")
	v23.ConfirmPurchaseSettingsCustomNoteFrame = v23.ConfirmPurchaseSettingsContainer:WaitForChild("CustomNote")
	v23.ConfirmPurchaseSettingsCustomNoteContainer = v23.ConfirmPurchaseSettingsCustomNoteFrame:WaitForChild("Container")
	v23.ConfirmPurchaseSettingsCustomNoteLockedFrame = v23.ConfirmPurchaseSettingsCustomNoteContainer:WaitForChild("Locked")
	v23.ConfirmPurchaseSettingsCustomNoteUnlockedFrame = v23.ConfirmPurchaseSettingsCustomNoteContainer:WaitForChild("Unlocked")
	v23.ConfirmPurchaseSettingsCustomNoteBox = v23.ConfirmPurchaseSettingsCustomNoteUnlockedFrame:WaitForChild("Box")
	v23.ConfirmPurchaseSettingsCustomNoteCount = v23.ConfirmPurchaseSettingsCustomNoteUnlockedFrame:WaitForChild("Count")
	v23.ConfirmPurchaseSettingsAnonymousFrame = v23.ConfirmPurchaseSettingsContainer:WaitForChild("Anonymous")
	v23.ConfirmPurchaseSettingsAnonymousTitle = v23.ConfirmPurchaseSettingsAnonymousFrame:WaitForChild("Title")
	v23.ConfirmPurchaseSettingsAnonymousButton = v23.ConfirmPurchaseSettingsAnonymousFrame:WaitForChild("Button")
	v23.ConfirmPurchaseSettingsAnonymousEmpty = v23.ConfirmPurchaseSettingsAnonymousButton:WaitForChild("Empty")
	v23.ConfirmPurchaseSettingsAnonymousFilled = v23.ConfirmPurchaseSettingsAnonymousButton:WaitForChild("Filled")
	v23.PromptSystem = v_u_12.new(v23.PromptsFrame)
	v23._open_animation_disabled = true
	v23._selected_player_input = nil
	v23._selected_product_id = nil
	v23._selected_player_lookup = nil
	v23._player_slots = {}
	v23._gift_slots = {}
	v23._fetch_player_data_hash = 0
	v23._generate_hash = 0
	v23._dont_redirect = nil
	v23:_Init()
	return v23
end
function v_u_20.CloseRequest(p24) -- name: CloseRequest
	-- upvalues: (copy) v_u_15
	if p24._dont_redirect then
		p24._dont_redirect = nil
		v_u_15.CloseRequest(p24)
	else
		p24.OpenPage:Fire("Shop", true)
	end
end
function v_u_20.Open(p25, ...) -- name: Open
	-- upvalues: (copy) v_u_15
	v_u_15.Open(p25, ...)
	p25:SelectPlayer(nil)
	task.spawn(p25._FetchGiftImages, p25)
	task.spawn(p25._GeneratePlayers, p25)
end
function v_u_20.Close(p26, ...) -- name: Close
	-- upvalues: (copy) v_u_15
	p26:SelectPlayer(nil)
	p26:_StopNoteDropdown()
	v_u_15.Close(p26, ...)
end
function v_u_20.DontRedirect(p27) -- name: DontRedirect
	p27._dont_redirect = true
end
function v_u_20.SelectPlayer(p28, p29) -- name: SelectPlayer
	local v30 = not p29
	if not v30 then
		if typeof(p29) == "string" then
			v30 = true
		elseif typeof(p29) == "Instance" then
			v30 = p29:IsA("Player")
		else
			v30 = false
		end
	end
	local v31 = "Argument 1 invalid, expected a Player or string or nil, got " .. tostring(p29)
	assert(v30, v31)
	p28._fetch_player_data_hash = p28._fetch_player_data_hash + 1
	p28._selected_player_input = p29
	p28._selected_player_lookup = nil
	p28:_UpdateFrameVisibility()
	if p28._selected_player_input then
		task.spawn(p28._FetchSelectedPlayerData, p28)
	else
		p28:SelectProduct(nil)
	end
	task.spawn(p28._GeneratePlayers, p28)
end
function v_u_20.SelectProduct(p32, p33) -- name: SelectProduct
	local v34 = not p33 or typeof(p33) == "number"
	local v35 = "Argument 1 invalid, expected a number or nil, got " .. tostring(p33)
	assert(v34, v35)
	p32._fetch_player_data_hash = p32._fetch_player_data_hash + 1
	p32._selected_product_id = p33
	p32:_UpdateFrameVisibility()
end
function v_u_20.ConfirmPurchase(p36) -- name: ConfirmPurchase
	-- upvalues: (copy) v_u_2
	if p36._selected_player_input and p36._selected_product_id then
		p36.ConfirmPurchaseList.Visible = false
		p36.ConfirmPurchaseDotsFrame.Visible = true
		p36.ConfirmPurchaseDotsFrame:AddTag("UILoadingDots")
		v_u_2.Remotes.Misc.PromptGiftProductPurchase:InvokeServer(p36._selected_product_id, p36._selected_player_lookup.UserID, p36._selected_player_lookup.IsOfflineGift, p36:_GetGiftNote(), p36.ConfirmPurchaseSettingsAnonymousFilled.Visible)
		p36.ConfirmPurchaseList.Visible = true
		p36.ConfirmPurchaseDotsFrame.Visible = false
		p36.ConfirmPurchaseDotsFrame:RemoveTag("UILoadingDots")
		p36:SelectPlayer(nil)
	end
end
function v_u_20._StopNoteDropdown(p37) -- name: _StopNoteDropdown
	if p37._note_dropdown_slot then
		p37._note_dropdown_slot:Cancel()
		p37._note_dropdown_slot = nil
	end
	p37.ConfirmPurchaseSettingsNoteDropdownButton.Visible = true
end
function v_u_20._StartNoteDropdown(p_u_38) -- name: _StartNoteDropdown
	-- upvalues: (copy) v_u_13, (copy) v_u_19
	p_u_38:_StopNoteDropdown()
	p_u_38.ConfirmPurchaseSettingsNoteDropdownButton.Visible = false
	p_u_38._note_dropdown_slot = v_u_13.new(p_u_38.ConfirmPurchaseSettingsNoteDropdownFrame, v_u_19)
	p_u_38._note_dropdown_slot.Selected:Connect(function(p39)
		-- upvalues: (copy) p_u_38
		if p39 then
			p_u_38.ConfirmPurchaseSettingsNoteDropdownButtonTitle.Text = p39
		end
		p_u_38:_StopNoteDropdown()
	end)
end
function v_u_20._GetGiftNote(p40) -- name: _GetGiftNote
	local v41 = p40.ConfirmPurchaseSettingsNoteDropdownButtonTitle.Text
	if v41 == "None" then
		return ""
	elseif v41 == "Custom" then
		return not p40.ConfirmPurchaseSettingsCustomNoteUnlockedFrame.Visible and "" or p40.ConfirmPurchaseSettingsCustomNoteBox.Text
	else
		return v41
	end
end
function v_u_20._VerifyNote(p42) -- name: _VerifyNote
	-- upvalues: (copy) v_u_5
	p42.ConfirmPurchaseSettingsCustomNoteBox.Text = v_u_5:SanitizeGiftNote(p42.ConfirmPurchaseSettingsCustomNoteBox.Text) or ""
	p42.ConfirmPurchaseSettingsCustomNoteCount.Text = #p42.ConfirmPurchaseSettingsCustomNoteBox.Text .. " / " .. v_u_5.MAX_GIFTING_NOTE_CHARACTER_COUNT
	p42.ConfirmPurchaseSettingsCustomNoteCount.TextColor3 = #p42.ConfirmPurchaseSettingsCustomNoteBox.Text >= v_u_5.MAX_GIFTING_NOTE_CHARACTER_COUNT and Color3.fromRGB(255, 50, 50) or Color3.fromRGB(255, 255, 255)
	p42.ConfirmPurchaseSettingsCustomNoteCount.TextTransparency = #p42.ConfirmPurchaseSettingsCustomNoteBox.Text >= v_u_5.MAX_GIFTING_NOTE_CHARACTER_COUNT and 0 or 0.5
end
function v_u_20._UpdateGiftReward(p43) -- name: _UpdateGiftReward
	-- upvalues: (copy) v_u_9, (copy) v_u_5, (copy) v_u_7
	local v44 = v_u_9:Get("GiftRobuxSpentProgress")
	local v45 = v_u_5:GetGiftRewardRobuxSpentRequirement(v_u_9:Get("GiftRobuxSpentRewardsClaimed"))
	local v46 = p43.PlayersGiftRewardProgressBar
	local v47 = UDim2.new
	local v48 = v44 / v45
	v46.Size = v47(math.clamp(v48, 0, 1), 0, 1, 2)
	p43.PlayersGiftRewardGoalText.Text = v_u_7:PrettyNumber(v44) .. " / " .. v_u_7:PrettyNumber(v45) .. " points"
end
function v_u_20._OfflineGiftingCooldown(p49) -- name: _OfflineGiftingCooldown
	p49.PlayersOfflineGiftButtonCountdown.Visible = true
	p49.PlayersOfflineGiftButtonIcon.Visible = false
	for v50 = 15, 1, -1 do
		p49.PlayersOfflineGiftButtonCountdown.Text = v50
		wait(1)
	end
	p49.PlayersOfflineGiftButtonCountdown.Visible = false
	p49.PlayersOfflineGiftButtonIcon.Visible = true
end
function v_u_20._UpdateOfflineGiftingButton(p51) -- name: _UpdateOfflineGiftingButton
	-- upvalues: (copy) v_u_3, (copy) v_u_4
	local v52 = p51.PlayersOfflineGiftButtonOn
	local v53 = p51.PlayersOfflineGiftButtonIcon.Visible
	if v53 then
		if p51.PlayersOfflineGiftBox.Text == "" then
			v53 = false
		else
			v53 = string.lower(p51.PlayersOfflineGiftBox.Text) ~= string.lower(v_u_3.LocalPlayer.Name) and true or v_u_4.IS_STUDIO
		end
	end
	v52.Visible = v53
	p51.PlayersOfflineGiftButtonOff.Visible = not p51.PlayersOfflineGiftButtonOn.Visible
end
function v_u_20._FetchGiftImages(p_u_54) -- name: _FetchGiftImages
	-- upvalues: (copy) v_u_5, (copy) v_u_1
	for v_u_55, v_u_56 in pairs(v_u_5.Gifts) do
		if v_u_56.ImageID then
			continue
		end
		task.spawn(function()
			-- upvalues: (ref) v_u_1, (copy) v_u_56, (copy) p_u_54, (copy) v_u_55
			local v57 = v_u_1.GetProductInfoAsync
			local v58 = v_u_1
			local v59 = v_u_56.ProductID
			local v60 = Enum.InfoType.Product
			local v61, v62 = pcall(v57, v58, v59, v60)
			if v_u_56.ImageID then
				return
			elseif v61 then
				v_u_56.ImageID = "rbxassetid://" .. v62.IconImageAssetId
				p_u_54._gift_slots[v_u_55].Slot.Icon.Image = v_u_56.ImageID
			else
				warn("Failed to fetch gamepass info:", v62)
			end
		end)
	end
end
function v_u_20._FetchSelectedPlayerData(p63) -- name: _FetchSelectedPlayerData
	-- upvalues: (copy) v_u_2
	p63._fetch_player_data_hash = p63._fetch_player_data_hash + 1
	local v64 = p63._fetch_player_data_hash
	p63.ProductsDotsFrame.Visible = true
	p63.ProductsDotsFrame:AddTag("UILoadingDots")
	p63.ProductsList.Visible = false
	p63._selected_player_lookup = nil
	wait(0.25)
	if p63._fetch_player_data_hash == v64 then
		local v65, v66 = v_u_2.Remotes.Misc.RequestGiftingDetails:InvokeServer(p63._selected_player_input)
		if p63._fetch_player_data_hash == v64 then
			p63.ProductsDotsFrame:RemoveTag("UILoadingDots")
			p63.ProductsDotsFrame.Visible = false
			p63.ProductsList.Visible = true
			if v65 and v66 then
				p63._selected_player_lookup = v66
			else
				if v66 then
					p63.PromptSystem:Open("ErrorMessage", "Whoops!", v66)
				end
				p63:SelectPlayer(nil)
			end
			p63:_UpdateProducts()
		end
	else
		return
	end
end
function v_u_20._UpdateConfirmPurchasePage(p67) -- name: _UpdateConfirmPurchasePage
	-- upvalues: (copy) v_u_5, (copy) v_u_9, (copy) v_u_4, (copy) v_u_8
	if p67._selected_player_input and p67._selected_product_id then
		local v68 = v_u_5.Gifts
		local v69 = p67._selected_product_id
		local v70 = v68[tostring(v69)]
		local v71 = v_u_9:Get("GiftTickets")
		local v72 = p67._selected_product_id
		local v73 = v71[tostring(v72)] or 0
		local v74 = p67._selected_player_input
		local v75 = typeof(v74) == "string"
		p67.ConfirmPurchasePlayerPicture.Image = string.format(v_u_4.HEADSHOT_IMAGE, p67._selected_player_lookup.UserID)
		p67.ConfirmPurchasePlayerUsernameText.Text = not p67._selected_player_lookup.DisplayName and "" or (p67._selected_player_lookup.DisplayName == p67._selected_player_lookup.Name and "" or "@" .. p67._selected_player_lookup.Name)
		p67.ConfirmPurchasePlayerDisplayNameText.Text = p67._selected_player_lookup.DisplayName or "@" .. p67._selected_player_lookup.Name
		p67.ConfirmPurchasePlayerDisplayNameText.Position = p67.ConfirmPurchasePlayerUsernameText.Text == "" and UDim2.new(0.15, 0, 0.5, 0) or UDim2.new(0.15, 0, 0.4, 0)
		p67.ConfirmPurchaseProductIcon.Image = v70.ImageID or ""
		p67.ConfirmPurchaseProductTitleText.Text = v70.DisplayName
		p67.ConfirmPurchaseSettingsAnonymousTitle.Text = "Hide my name from " .. (p67._selected_player_lookup.DisplayName or p67._selected_player_lookup.Name)
		p67.ConfirmPurchaseSettingsCustomNoteLockedFrame.Visible = v75
		p67.ConfirmPurchaseSettingsCustomNoteUnlockedFrame.Visible = not v75
		p67.ConfirmPurchaseWarningsGiftTicketsFrame.Visible = v73 > 0
		p67.ConfirmPurchaseWarningsGiftTicketsText.Text = "\195\151" .. v73
		p67.ConfirmPurchaseBuyButtonGiftTicketIcon.Visible = v73 > 0
		p67.ConfirmPurchaseBuyButtonRobuxPrice.Visible = v73 <= 0
		p67.ConfirmPurchaseWarningsOfflineGiftingFrame.Visible = v75
		v_u_8:SetRobuxText(p67.ConfirmPurchaseBuyButtonRobuxPrice, p67._selected_product_id, Enum.InfoType.Product)
	end
end
function v_u_20._UpdateFrameVisibility(p76) -- name: _UpdateFrameVisibility
	p76.BackButton.Visible = p76._selected_player_input ~= nil
	p76.SelectPlayerFrame.Visible = not p76._selected_player_input
	local v77 = p76.SelectProductFrame
	local v78 = p76._selected_player_input
	if v78 then
		v78 = not p76._selected_product_id
	end
	v77.Visible = v78
	local v79 = p76.ConfirmPurchaseFrame
	local v80 = p76._selected_player_input
	if v80 then
		v80 = p76._selected_product_id
	end
	v79.Visible = v80
	p76.PlayersList.CanvasPosition = Vector2.new(0, 0)
	p76.ProductsList.CanvasPosition = Vector2.new(0, 0)
	p76.ConfirmPurchaseSettingsAnonymousFilled.Visible = false
	p76.ConfirmPurchaseSettingsAnonymousEmpty.Visible = true
	p76.ConfirmPurchaseSettingsCustomNoteBox.Text = ""
	p76.ConfirmPurchaseSettingsNoteDropdownButtonTitle.Text = "Surprise!"
	p76:_UpdateProducts()
	p76:_UpdateConfirmPurchasePage()
end
function v_u_20._UpdateProducts(p81) -- name: _UpdateProducts
	-- upvalues: (copy) v_u_9, (copy) v_u_10, (copy) v_u_4, (copy) v_u_6, (copy) v_u_5
	if p81._selected_player_input and not p81._selected_product_id then
		local v82 = v_u_9:Get("GiftTickets")
		local v83 = p81._selected_player_lookup and v_u_10:ArePaidRandomItemsRestricted(p81._selected_player_lookup.LimitedPolicyInfo) or v_u_10:ArePaidRandomItemsRestricted()
		for v84, v85 in pairs(p81._gift_slots) do
			local v86 = v82[v84] or 0
			v85.Slot.Button.GiftTicket.Visible = v86 > 0
			v85.Slot.Button.GiftTicket.Quantity.Text = "\195\151" .. v86
			local v87 = v85.Slot
			local v88 = p81._selected_player_lookup and p81._selected_player_lookup.CanReceiveGifts and ((v85.Info.GiftType ~= "Gamepass" or not p81._selected_player_lookup.GamepassesOwned[v85.Info.GiftName]) and (not (v85.Info.IsPaidRandomItem and v83) or v_u_4.SHOW_LOOTBOX_CONTENTS_TO_RESTRICTED_PLAYERS))
			if v88 then
				if v85.Info.GiftName == "BattlePassLevels10" and p81._selected_player_lookup.CurrentSeasonPassLevel >= v_u_6.CurrentSeason.NumBattlePassTiers or v85.Info.GiftName == "seasonpass_bundle" and p81._selected_player_lookup.CurrentSeasonMaxPassTrackNum >= v_u_5.Bundles.seasonpass_bundle.BattlePassMaxPassTrackNum then
					v88 = false
				else
					v88 = v85.Info.GiftName ~= "deluxeseasonpass_bundle" and true or not p81._selected_player_lookup.CurrentSeasonSeasonPassBundleOwned
				end
			end
			v87.Visible = v88
		end
		local v89 = p81.ProductsEmptyFrame
		local v90 = p81._selected_player_lookup
		if v90 then
			v90 = not p81._selected_player_lookup.CanReceiveGifts
		end
		v89.Visible = v90
		p81.ProductsPlayerFrame.Visible = not p81.ProductsEmptyFrame.Visible
		p81.ProductsPlayerPicture.Image = not p81._selected_player_lookup and "" or string.format(v_u_4.HEADSHOT_IMAGE, p81._selected_player_lookup.UserID)
		p81.ProductsPlayerUsernameText.Text = not p81._selected_player_lookup and "" or (not p81._selected_player_lookup.DisplayName and "" or (p81._selected_player_lookup.DisplayName == p81._selected_player_lookup.Name and "" or "@" .. p81._selected_player_lookup.Name))
		p81.ProductsPlayerDisplayNameText.Text = not p81._selected_player_lookup and "" or (p81._selected_player_lookup.DisplayName or "@" .. p81._selected_player_lookup.Name)
		p81.ProductsPlayerDisplayNameText.Position = p81.ProductsPlayerUsernameText.Text == "" and UDim2.new(0.15, 0, 0.5, 0) or UDim2.new(0.15, 0, 0.4, 0)
	end
end
function v_u_20._GeneratePlayers(p_u_91) -- name: _GeneratePlayers
	-- upvalues: (copy) v_u_3, (copy) v_u_7, (copy) v_u_4, (copy) v_u_18, (copy) v_u_11, (copy) v_u_16
	for _, v92 in pairs(p_u_91._player_slots) do
		v92:Destroy()
	end
	p_u_91._player_slots = {}
	p_u_91._generate_hash = p_u_91._generate_hash + 1
	local v93 = p_u_91._generate_hash
	local v94 = v_u_3:GetPlayers()
	table.sort(v94, function(p95, p96)
		-- upvalues: (ref) v_u_7
		return v_u_7:StringLessThan(p95.DisplayName, p96.DisplayName)
	end)
	local v97 = table.find(v94, v_u_3.LocalPlayer)
	if v97 then
		table.remove(v94, v97)
	end
	local v98 = v_u_3.LocalPlayer
	table.insert(v94, 1, v98)
	for v99, v_u_100 in pairs(v94) do
		if v_u_100 == v_u_3.LocalPlayer and not v_u_4.IS_STUDIO then
			continue
		end
		local v101 = v_u_18:Clone()
		v101.Username.Text = v_u_100.DisplayName == v_u_100.Name and "" or "@" .. v_u_100.Name
		v101.DisplayName.Text = v_u_100.DisplayName
		v101.DisplayName.Position = v101.Username.Text == "" and UDim2.new(0.175, 0, 0.5, 0) or UDim2.new(0.175, 0, 0.4, 0)
		v101.Icon.Image = string.format(v_u_4.HEADSHOT_IMAGE, v_u_100.UserId)
		v101.LayoutOrder = v99
		v101.Parent = p_u_91.PlayersContainer
		v_u_11:Add(v101.Button)
		local v102 = p_u_91._player_slots
		table.insert(v102, v101)
		v101.Button.MouseButton1Click:Connect(function()
			-- upvalues: (copy) p_u_91, (copy) v_u_100
			p_u_91:SelectPlayer(v_u_100)
		end)
		if v93 == p_u_91._generate_hash then
			continue
		end
		return
	end
	for _ = #p_u_91._player_slots + 1, 6 do
		local v103 = v_u_16:Clone()
		v103.Parent = p_u_91.PlayersContainer
		local v104 = p_u_91._player_slots
		table.insert(v104, v103)
		if v93 == p_u_91._generate_hash then
			continue
		end
		return
	end
	local v105 = p_u_91._selected_player_input
	if typeof(v105) == "Instance" and p_u_91._selected_player_input.Parent ~= v_u_3 then
		p_u_91:SelectPlayer(nil)
	end
end
function v_u_20._Setup(p_u_106) -- name: _Setup
	-- upvalues: (copy) v_u_5, (copy) v_u_17, (copy) v_u_11, (copy) v_u_14
	for v107, v108 in pairs(v_u_5.GiftOrder) do
		local v_u_109 = v_u_5.Gifts[v108]
		local v110 = v_u_17:Clone()
		v110.Icon.Image = ""
		v110.DisplayName.Text = v_u_109.DisplayName
		v110.LayoutOrder = v107
		v110.Parent = p_u_106.ProductsContainer
		v_u_11:Add(v110.Button)
		v110.Button.MouseButton1Click:Connect(function()
			-- upvalues: (copy) p_u_106, (copy) v_u_109
			p_u_106:SelectProduct(v_u_109.ProductID)
		end)
		p_u_106._gift_slots[v108] = {
			["Slot"] = v110,
			["Info"] = v_u_109
		}
	end
	v_u_14.new({
		["Name"] = nil,
		["Quantity"] = 1,
		["Weapon"] = "IsRandom",
		["Name"] = v_u_5.GIFT_REWARD_DATA
	}):SetParent(p_u_106.PlayersGiftRewardContainer)
end
function v_u_20._Init(p_u_111) -- name: _Init
	-- upvalues: (copy) v_u_9, (copy) v_u_8, (copy) v_u_11
	p_u_111.CloseButton.MouseButton1Click:Connect(function()
		-- upvalues: (copy) p_u_111
		p_u_111:CloseRequest()
	end)
	p_u_111.BackButton.MouseButton1Click:Connect(function()
		-- upvalues: (copy) p_u_111
		if p_u_111._selected_product_id then
			p_u_111:SelectProduct(nil)
		elseif p_u_111._selected_player_input then
			p_u_111:SelectPlayer(nil)
		end
	end)
	p_u_111.ConfirmPurchaseBuyButton.MouseButton1Click:Connect(function()
		-- upvalues: (copy) p_u_111
		p_u_111:ConfirmPurchase()
	end)
	p_u_111.ConfirmPurchaseSettingsLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		-- upvalues: (copy) p_u_111
		p_u_111.ConfirmPurchaseSettingsFrame.Size = UDim2.new(1, 0, 0, p_u_111.ConfirmPurchaseSettingsLayout.AbsoluteContentSize.Y)
	end)
	p_u_111.PlayersLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		-- upvalues: (copy) p_u_111
		p_u_111.PlayersList.CanvasSize = UDim2.new(0, 0, 0, p_u_111.PlayersLayout.AbsoluteContentSize.Y)
	end)
	p_u_111.ProductsLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		-- upvalues: (copy) p_u_111
		p_u_111.ProductsList.CanvasSize = UDim2.new(0, 0, 0, p_u_111.ProductsLayout.AbsoluteContentSize.Y)
	end)
	p_u_111.ConfirmPurchaseLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		-- upvalues: (copy) p_u_111
		p_u_111.ConfirmPurchaseList.CanvasSize = UDim2.new(0, 0, 0, p_u_111.ConfirmPurchaseLayout.AbsoluteContentSize.Y)
	end)
	p_u_111.ConfirmPurchaseSettingsNoteDropdownButtonTitle:GetPropertyChangedSignal("Text"):Connect(function()
		-- upvalues: (copy) p_u_111
		p_u_111.ConfirmPurchaseSettingsCustomNoteFrame.Visible = p_u_111.ConfirmPurchaseSettingsNoteDropdownButtonTitle.Text == "Custom"
	end)
	p_u_111.PlayersOfflineGiftBox:GetPropertyChangedSignal("Text"):Connect(function()
		-- upvalues: (copy) p_u_111
		p_u_111:_UpdateOfflineGiftingButton()
	end)
	p_u_111.PlayersOfflineGiftButtonIcon:GetPropertyChangedSignal("Visible"):Connect(function()
		-- upvalues: (copy) p_u_111
		p_u_111:_UpdateOfflineGiftingButton()
	end)
	p_u_111.PlayersOfflineGiftButton.MouseButton1Click:Connect(function()
		-- upvalues: (copy) p_u_111
		if p_u_111.PlayersOfflineGiftButtonOn.Visible and p_u_111.PlayersOfflineGiftButtonIcon.Visible then
			local v112 = p_u_111.PlayersOfflineGiftBox.Text
			task.defer(p_u_111._OfflineGiftingCooldown, p_u_111)
			p_u_111.PlayersOfflineGiftBox.Text = ""
			p_u_111:SelectPlayer(v112)
		end
	end)
	p_u_111.ConfirmPurchaseSettingsCustomNoteBox:GetPropertyChangedSignal("Text"):Connect(function()
		-- upvalues: (copy) p_u_111
		p_u_111:_VerifyNote()
	end)
	p_u_111.ConfirmPurchaseSettingsAnonymousButton.MouseButton1Click:Connect(function()
		-- upvalues: (copy) p_u_111
		p_u_111.ConfirmPurchaseSettingsAnonymousEmpty.Visible = not p_u_111.ConfirmPurchaseSettingsAnonymousEmpty.Visible
		p_u_111.ConfirmPurchaseSettingsAnonymousFilled.Visible = not p_u_111.ConfirmPurchaseSettingsAnonymousEmpty.Visible
	end)
	p_u_111.ConfirmPurchaseSettingsNoteDropdownButton.MouseButton1Click:Connect(function()
		-- upvalues: (copy) p_u_111
		p_u_111:_StartNoteDropdown()
	end)
	v_u_9:GetDataChangedSignal("GiftTickets"):Connect(function()
		-- upvalues: (copy) p_u_111
		p_u_111:_UpdateProducts()
	end)
	v_u_9:GetDataChangedSignal("GiftRobuxSpentProgress"):Connect(function()
		-- upvalues: (copy) p_u_111
		p_u_111:_UpdateGiftReward()
	end)
	v_u_9:GetDataChangedSignal("GiftRobuxSpentRewardsClaimed"):Connect(function()
		-- upvalues: (copy) p_u_111
		p_u_111:_UpdateGiftReward()
	end)
	v_u_8.PurchaseFinished:Connect(function()
		-- upvalues: (copy) p_u_111
		p_u_111:SelectPlayer(nil)
	end)
	p_u_111:_Setup()
	p_u_111:SelectPlayer(nil)
	p_u_111:_UpdateGiftReward()
	v_u_11:Add(p_u_111.BackButton)
	v_u_11:Add(p_u_111.CloseButton)
	v_u_11:Add(p_u_111.PlayersOfflineGiftButton)
	v_u_11:Add(p_u_111.ConfirmPurchaseSettingsAnonymousButton)
	v_u_11:Add(p_u_111.ConfirmPurchaseBuyButton, nil, {
		["HoverRatio"] = UDim2.new(0, 10, 0, 10),
		["ReleaseRatio"] = UDim2.new(0, 10, 0, 10)
	})
	v_u_11:Add(p_u_111.ConfirmPurchaseSettingsNoteDropdownButton, nil, {
		["ReleaseRatio"] = 1.025,
		["HoverRatio"] = 1.025
	})
end
return v_u_20._new()