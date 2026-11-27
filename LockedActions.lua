local v_u_1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("AdService")
local v3 = game:GetService("Players")
local v_u_4 = require(v_u_1.Modules.CONSTANTS)
local v_u_5 = require(v_u_1.Modules.ScavengerHuntLibrary)
local v_u_6 = require(v_u_1.Modules.MonetizationLibrary)
local v_u_7 = require(v_u_1.Modules.CurrencyLibrary)
local v_u_8 = require(v_u_1.Modules.SeasonLibrary)
local v_u_9 = require(v_u_1.Modules.ServerOsTime)
local v_u_10 = require(v_u_1.Modules.ShopLibrary)
local v_u_11 = require(v_u_1.Modules.Utility)
local v_u_12 = require(v3.LocalPlayer.PlayerScripts.Controllers.PlayerDataController)
local v_u_13 = require(v3.LocalPlayer.PlayerScripts.Modules.ButtonEffect)
local v_u_14 = require(v3.LocalPlayer.PlayerScripts.Modules.UserInterface.Pages)
local v_u_15 = {}
v_u_15.__index = v_u_15
function v_u_15.new(p16) -- name: new
	-- upvalues: (copy) v_u_15
	local v17 = v_u_15
	local v18 = setmetatable({}, v17)
	v18.Right = p16
	v18.Frame = v18.Right.Container:WaitForChild("LockedActions")
	v18.Container = v18.Frame:WaitForChild("Container")
	v18.Layout = v18.Container:WaitForChild("Layout")
	v18.TryWeaponFrame = v18.Container:WaitForChild("TryWeapon")
	v18.TryWeaponButton = v18.TryWeaponFrame:WaitForChild("Button")
	v18.SpecialOfferFrame = v18.Container:WaitForChild("SpecialOffer")
	v18.SpecialOfferDescription = v18.SpecialOfferFrame:WaitForChild("Description")
	v18.SpecialOfferCountdown = v18.SpecialOfferFrame:WaitForChild("Countdown")
	v18.SpecialOfferButton = v18.SpecialOfferFrame:WaitForChild("Button")
	v18.SpecialOfferButtonLockedFrame = v18.SpecialOfferButton:WaitForChild("Locked")
	v18.SpecialOfferButtonUnlockedFrame = v18.SpecialOfferButton:WaitForChild("Unlocked")
	v18.BuyFrame = v18.Container:WaitForChild("Buy")
	v18.BuyDescription = v18.BuyFrame:WaitForChild("Description")
	v18.BuyCountdown = v18.BuyFrame:WaitForChild("Countdown")
	v18.BuyButton = v18.BuyFrame:WaitForChild("Button")
	v18.BuyButtonLockedFrame = v18.BuyButton:WaitForChild("Locked")
	v18.BuyButtonFreeFrame = v18.BuyButton:WaitForChild("Free")
	v18.BuyButtonKeysFrame = v18.BuyButton:WaitForChild("Keys")
	v18.BuyButtonKeysPrice = v18.BuyButtonKeysFrame:WaitForChild("Price")
	v18.BuyButtonKeysPriceIconOutline = v18.BuyButtonKeysPrice:WaitForChild("Icon")
	v18.BuyButtonKeysPriceIcon = v18.BuyButtonKeysPriceIconOutline:WaitForChild("ImageLabel")
	v18.ScavengerFrame = v18.Container:WaitForChild("Scavenger")
	v18.ScavengerTitle = v18.ScavengerFrame:WaitForChild("Title")
	v18.ScavengerProgress = v18.ScavengerFrame:WaitForChild("Progress")
	v18.ScavengerIcon = v18.ScavengerFrame:WaitForChild("Icon")
	v18.ScavengerButton = v18.ScavengerFrame:WaitForChild("Button")
	v18.FreeTrialFrame = v18.Container:WaitForChild("FreeTrial")
	v18.FreeTrialReadyFrame = v18.FreeTrialFrame:WaitForChild("Ready")
	v18.FreeTrialNotReadyFrame = v18.FreeTrialFrame:WaitForChild("NotReady")
	v18.FreeTrialWaitingFrame = v18.FreeTrialNotReadyFrame:WaitForChild("Waiting")
	v18.FreeTrialWaitingDotsFrame = v18.FreeTrialWaitingFrame:WaitForChild("Dots")
	v18.FreeTrialUnavailable = v18.FreeTrialNotReadyFrame:WaitForChild("Unavailable")
	v18.FreeTrialButton = v18.FreeTrialNotReadyFrame:WaitForChild("Button")
	v18.FreeTrialButtonTitle = v18.FreeTrialButton:WaitForChild("Title")
	v18.FreeTrialButtonIcon = v18.FreeTrialButtonTitle:WaitForChild("Icon")
	v18._update_information_hash = 0
	v18:_Init()
	return v18
end
function v_u_15.OnStateChanged(p19) -- name: OnStateChanged
	p19:_UpdateInformation()
end
function v_u_15._InteractSpecialOffer(p20) -- name: _InteractSpecialOffer
	-- upvalues: (copy) v_u_8, (copy) v_u_6, (copy) v_u_14
	local v21 = p20.Right.Interface.Equipment:GetSelectedWeapon()
	local v22, v23 = v_u_8:GetRewardSeasonPassPosition(v21)
	local v_u_24 = p20.SpecialOfferDescription.Text == "Early access!" and "standardweapons_bundle" or v_u_6:GetBundleContainingReward(v21)
	if v22 and v23 then
		v_u_14.PageSystem:OpenPage("BattlePass", true)
		v_u_14.PageSystem:WaitForPage("BattlePass"):Preview(v22, v23)
		return
	elseif v_u_24 == "deluxeseasonpass_bundle" or v_u_24 == "seasonpass_bundle" then
		v_u_14.PageSystem:OpenPage("BattlePass", true)
		v_u_14.PageSystem:WaitForPage("BattlePass"):InspectBundle(v_u_24)
	elseif v_u_24 then
		v_u_14.PageSystem:OpenPage("Shop", true)
		v_u_14.PageSystem:WaitForPage("Shop"):SetPage("Bundles")
		task.delay(0.1, function()
			-- upvalues: (ref) v_u_14, (copy) v_u_24
			v_u_14.PageSystem:WaitForPage("Shop"):InspectBundle(v_u_24)
		end)
	end
end
function v_u_15._UpdateInformation(p_u_25) -- name: _UpdateInformation
	-- upvalues: (copy) v_u_12, (copy) v_u_10, (copy) v_u_6, (copy) v_u_8, (copy) v_u_4, (copy) v_u_5, (copy) v_u_9, (copy) v_u_11, (copy) v_u_2
	p_u_25._update_information_hash = p_u_25._update_information_hash + 1
	local v_u_26 = p_u_25._update_information_hash
	local v27 = p_u_25.Right.Interface.Equipment:GetSelectedWeapon()
	local v28 = v_u_12:GetWeaponData(v27)
	local v29
	if v27 then
		v29 = not v28
	else
		v29 = v27
	end
	p_u_25.Frame.Visible = v29
	if v29 then
		local v30, _, v31, _ = v_u_10:GetWeaponKeyPriceInfo(v27, v_u_12:Get("UnlockTokens"), v_u_12:Get("FreeWeaponUnlockCheck"))
		local v32 = v_u_6:GetBundleContainingReward(v27)
		local v33, _ = v_u_8:GetRewardSeasonPassPosition(v27)
		local v34 = v_u_10:GetTimeUntilWeaponRelease(v27)
		local v35 = not v31
		if v35 then
			v35 = v34 > 0
		end
		local v36
		if v35 then
			v36 = v34 <= v_u_4.WEAPON_REVEAL_TIME_OFFSET
		else
			v36 = v35
		end
		local v37
		if v36 then
			v37 = v34 <= v_u_4.WEAPON_EARLY_ACCESS_TIME_OFFSET
		else
			v37 = v36
		end
		local v38 = v_u_5.InfoByWeapon[v27]
		local v39 = v_u_6:GetNumVideoAdsForFreeWeaponTrial(v27)
		local v_u_40 = (v_u_12:Get("FreeWeaponTrialsRemaining")[v27] or 0) > 0
		local v_u_41
		if v_u_40 then
			v_u_41 = v_u_40
		elseif v39 then
			v_u_41 = v_u_12:Get("NumFreeWeaponTrialsFromVideoAdsToday") < v_u_6.MAX_FREE_WEAPON_TRIALS_PER_DAY
		else
			v_u_41 = v39
		end
		local v42 = v32 ~= "superstarter_bundle" and true or v_u_9:GetRounded() - v_u_12:Get("SuperStarterBundleStartTime") < v_u_6.SUPER_STARTER_BUNDLE_OFFER_DURATION
		p_u_25.BuyFrame.Visible = v37 or v30 < (1 / 0)
		p_u_25.BuyButtonLockedFrame.Visible = v35
		local v43 = p_u_25.BuyButtonFreeFrame
		local v44 = not v35
		if v44 then
			v44 = v30 <= 0
		end
		v43.Visible = v44
		local v45 = p_u_25.BuyButtonKeysFrame
		local v46 = not v35
		if v46 then
			v46 = v30 > 0
		end
		v45.Visible = v46
		p_u_25.BuyButtonKeysPrice.Text = v35 and "" or v_u_11:PrettyNumber(v30)
		local v47 = p_u_25.BuyDescription
		local v48
		if v35 then
			v48 = UDim2.new(0.175, 0, 0.35, 0)
		else
			v48 = UDim2.new(0.175, 0, 0.5, 0)
		end
		v47.Position = v48
		p_u_25.BuyDescription.Text = v35 and "Coming soon!" or "Unlock now!"
		p_u_25.BuyCountdown.Text = not v35 and "" or "in " .. v_u_11:TimeFormat2(v34, 2)
		local v49 = p_u_25.SpecialOfferFrame
		local v50 = not v31
		if v50 then
			v50 = v32 and v42 and v42 or (v36 or v33)
		end
		v49.Visible = v50
		local v51 = p_u_25.SpecialOfferButtonLockedFrame
		local v52
		if v36 then
			v52 = not v37
		else
			v52 = v36
		end
		v51.Visible = v52
		p_u_25.SpecialOfferButtonUnlockedFrame.Visible = not v36 or v37
		local v53 = p_u_25.SpecialOfferDescription
		local v54
		if v36 and not v37 then
			v54 = UDim2.new(0.175, 0, 0.35, 0)
		else
			v54 = UDim2.new(0.175, 0, 0.5, 0)
		end
		v53.Position = v54
		p_u_25.SpecialOfferDescription.Text = v36 and "Early access!" or "Special offer!"
		p_u_25.SpecialOfferCountdown.Text = (not v36 or v37) and "" or "in " .. v_u_11:TimeFormat2(v34 - v_u_4.WEAPON_EARLY_ACCESS_TIME_OFFSET, 2)
		local v55 = p_u_25.TryWeaponFrame
		local v56 = not (v31 or v35)
		if v56 then
			v56 = table.find(v_u_10.OwnableWeapons, v27)
		end
		v55.Visible = v56
		p_u_25.ScavengerFrame.Visible = v38 ~= nil
		p_u_25.ScavengerTitle.Text = not v38 and "" or (v38.NumObjects == 1 and v38.ObjectsName or v38.ObjectsNamePlural)
		p_u_25.ScavengerProgress.Text = not v38 and "" or string.format("%s / %s", #(v_u_12:Get("ScavengerHunts")[v38.Name] or {}), v38.NumObjects)
		p_u_25.ScavengerIcon.Image = not v38 and "" or v38.ObjectsImage
		p_u_25.FreeTrialFrame.Visible = v_u_41
		p_u_25.FreeTrialReadyFrame.Visible = v_u_40
		p_u_25.FreeTrialNotReadyFrame.Visible = not v_u_40
		p_u_25.FreeTrialButtonTitle.Text = string.format("%s <font size=\"8\">/ %s</font>", v_u_12:Get("FreeWeaponTrialsProgressFromVideoAds")[v27] or 0, v39 or -1)
		p_u_25.FreeTrialButton.Visible = false
		p_u_25.FreeTrialUnavailable.Visible = false
		p_u_25.FreeTrialWaitingFrame.Visible = true
		p_u_25.FreeTrialWaitingDotsFrame:AddTag("UILoadingDots")
		task.spawn(function()
			-- upvalues: (copy) v_u_41, (copy) v_u_40, (ref) v_u_2, (copy) v_u_26, (copy) p_u_25
			if v_u_41 and not v_u_40 then
				local v57 = v_u_2.GetAdAvailabilityNowAsync
				local v58 = v_u_2
				local v59 = Enum.AdFormat.RewardedVideo
				local v60, v61 = pcall(v57, v58, v59)
				wait(1)
				if v_u_26 == p_u_25._update_information_hash then
					if v60 then
						v60 = v61.AdAvailabilityResult == Enum.AdAvailabilityResult.IsAvailable
					end
					p_u_25.FreeTrialButton.Visible = v60
					p_u_25.FreeTrialUnavailable.Visible = not v60
					p_u_25.FreeTrialWaitingFrame.Visible = false
					p_u_25.FreeTrialWaitingDotsFrame:RemoveTag("UILoadingDots")
				end
			else
				return
			end
		end)
	else
		p_u_25.FreeTrialWaitingDotsFrame:RemoveTag("UILoadingDots")
	end
end
function v_u_15._Update(p62) -- name: _Update
	p62.Frame.Size = UDim2.new(1, 0, 0, p62.Layout.AbsoluteContentSize.Y)
	p62.BuyButtonKeysPrice.Position = UDim2.new(0.5, -p62.BuyButtonKeysPriceIconOutline.AbsoluteSize.X / 2, 0.5, 0)
	p62.BuyButtonKeysPriceIconOutline.Position = UDim2.new(0.5, p62.BuyButtonKeysPrice.TextBounds.X / 2, 0.5, 0)
	p62.FreeTrialButtonIcon.Position = UDim2.new(0.5, -p62.FreeTrialButtonTitle.TextBounds.X / 2, 0.5, 0)
end
function v_u_15._Setup(p63) -- name: _Setup
	-- upvalues: (copy) v_u_7
	p63.BuyButtonKeysPriceIconOutline.Image = v_u_7.Info.WeaponKeys.ImageFlatOutline
	p63.BuyButtonKeysPriceIcon.Image = v_u_7.Info.WeaponKeys.ImageFlat
end
function v_u_15._Init(p_u_64) -- name: _Init
	-- upvalues: (copy) v_u_1, (copy) v_u_12, (copy) v_u_13
	p_u_64.Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		-- upvalues: (copy) p_u_64
		p_u_64:_Update()
	end)
	p_u_64.BuyButtonKeysPrice:GetPropertyChangedSignal("TextBounds"):Connect(function()
		-- upvalues: (copy) p_u_64
		p_u_64:_Update()
	end)
	p_u_64.BuyButtonKeysPriceIconOutline:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
		-- upvalues: (copy) p_u_64
		p_u_64:_Update()
	end)
	p_u_64.BuyButton.MouseButton1Click:Connect(function()
		-- upvalues: (copy) p_u_64
		p_u_64.Right.Interface.Equipment:UnlockWeapon()
	end)
	p_u_64.TryWeaponButton.MouseButton1Click:Connect(function()
		-- upvalues: (copy) p_u_64
		p_u_64.Right.Interface.Equipment:TryWeapon()
	end)
	p_u_64.SpecialOfferButton.MouseButton1Click:Connect(function()
		-- upvalues: (copy) p_u_64
		p_u_64:_InteractSpecialOffer()
	end)
	p_u_64.FreeTrialButton.MouseButton1Click:Connect(function()
		-- upvalues: (copy) p_u_64, (ref) v_u_1
		local v65 = p_u_64.Right.Interface.Equipment:GetSelectedWeapon()
		v_u_1.Remotes.Misc.PlayVideoAdWeaponTrial:FireServer(v65)
	end)
	p_u_64.FreeTrialUnavailable.MouseButton1Click:Connect(function()
		-- upvalues: (copy) p_u_64
		p_u_64:_UpdateInformation()
	end)
	v_u_12:GetDataChangedSignal("WeaponInventory"):Connect(function()
		-- upvalues: (copy) p_u_64
		p_u_64:_UpdateInformation()
	end)
	v_u_12:GetDataChangedSignal("UnlockTokens"):Connect(function()
		-- upvalues: (copy) p_u_64
		p_u_64:_UpdateInformation()
	end)
	v_u_12:GetDataChangedSignal("FreeWeaponUnlockCheck"):Connect(function()
		-- upvalues: (copy) p_u_64
		p_u_64:_UpdateInformation()
	end)
	v_u_12:GetDataChangedSignal("ScavengerHunts"):Connect(function()
		-- upvalues: (copy) p_u_64
		p_u_64:_UpdateInformation()
	end)
	v_u_12:GetDataChangedSignal("FreeWeaponTrialsRemaining"):Connect(function()
		-- upvalues: (copy) p_u_64
		p_u_64:_UpdateInformation()
	end)
	v_u_12:GetDataChangedSignal("FreeWeaponTrialsProgressFromVideoAds"):Connect(function()
		-- upvalues: (copy) p_u_64
		p_u_64:_UpdateInformation()
	end)
	v_u_12:GetDataChangedSignal("NumFreeWeaponTrialsFromVideoAdsToday"):Connect(function()
		-- upvalues: (copy) p_u_64
		p_u_64:_UpdateInformation()
	end)
	p_u_64:_Setup()
	p_u_64:_Update()
	v_u_13:Add(p_u_64.BuyButton, nil, {
		["HoverRatio"] = UDim2.new(0, 10, 0, 10),
		["ReleaseRatio"] = UDim2.new(0, 10, 0, 10)
	})
	v_u_13:Add(p_u_64.TryWeaponButton, nil, {
		["HoverRatio"] = UDim2.new(0, 10, 0, 10),
		["ReleaseRatio"] = UDim2.new(0, 10, 0, 10)
	})
	v_u_13:Add(p_u_64.SpecialOfferButton, nil, {
		["HoverRatio"] = UDim2.new(0, 10, 0, 10),
		["ReleaseRatio"] = UDim2.new(0, 10, 0, 10)
	})
	v_u_13:Add(p_u_64.FreeTrialButton, nil, {
		["HoverRatio"] = UDim2.new(0, 10, 0, 10),
		["ReleaseRatio"] = UDim2.new(0, 10, 0, 10)
	})
	v_u_13:Add(p_u_64.FreeTrialUnavailable, nil, {
		["HoverRatio"] = UDim2.new(0, 10, 0, 10),
		["ReleaseRatio"] = UDim2.new(0, 10, 0, 10)
	})
	v_u_13:Add(p_u_64.ScavengerButton, nil, {
		["HoverRatio"] = UDim2.new(0, 10, 0, 10),
		["ReleaseRatio"] = UDim2.new(0, 10, 0, 10)
	})
end
return v_u_15