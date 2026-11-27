local v_u_1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("GamepadService")
local v_u_3 = game:GetService("RunService")
local v_u_4 = game:GetService("StarterGui")
game:GetService("Lighting")
local v5 = game:GetService("Players")
local v_u_6 = require(v_u_1.Modules.LootLibrary)
local v_u_7 = require(v_u_1.Modules.ShopLibrary)
local v_u_8 = require(v_u_1.Modules.Utility)
local v_u_9 = require(v_u_1.Modules.Signal)
local v_u_10 = require(v5.LocalPlayer.PlayerScripts.Controllers.ShootingRangeController)
local v_u_11 = require(v5.LocalPlayer.PlayerScripts.Controllers.MonetizationController)
local v_u_12 = require(v5.LocalPlayer.PlayerScripts.Controllers.PlayerDataController)
local v_u_13 = require(v5.LocalPlayer.PlayerScripts.Controllers.FighterController)
local v_u_14 = require(v5.LocalPlayer.PlayerScripts.Controllers.CameraController)
local v_u_15 = require(v5.LocalPlayer.PlayerScripts.Modules.UserInterface.MobileInputs)
local v_u_16 = require(v5.LocalPlayer.PlayerScripts.Modules.UserInterface.Teleporting)
local v_u_17 = require(v5.LocalPlayer.PlayerScripts.Modules.UserInterface.Queue)
local v_u_18 = require(v5.LocalPlayer.PlayerScripts.Modules.UserInterface.Pages)
local v_u_19 = require(v5.LocalPlayer.PlayerScripts.Modules.UILibrary)
local v_u_20 = require(script:WaitForChild("EquipmentState"))
local v_u_21 = require(script:WaitForChild("FloatingModel"))
local v_u_22 = require(script:WaitForChild("SpinControls"))
local v_u_23 = require(script:WaitForChild("Interface"))
local v_u_24 = require(script:WaitForChild("Camera"))
local v_u_25 = require(script:WaitForChild("Scene"))
local v_u_26 = {}
v_u_26.__index = v_u_26
function v_u_26._new() -- name: _new
	-- upvalues: (copy) v_u_26, (copy) v_u_9, (copy) v_u_19, (copy) v_u_20, (copy) v_u_24, (copy) v_u_25, (copy) v_u_21, (copy) v_u_22, (copy) v_u_23
	local v27 = v_u_26
	local v28 = setmetatable({}, v27)
	v28.Opened = v_u_9.new()
	v28.SelectedWeaponChanged = v_u_9.new()
	v28.CareerPageOpened = v_u_9.new()
	v28.CustomizingChanged = v_u_9.new()
	v28.CustomizingStateChanged = v_u_9.new()
	v28.CosmeticSearchChanged = v_u_9.new()
	v28.UnlockingChanged = v_u_9.new()
	v28.FinishedOpenEffect = v_u_9.new()
	v28.CharmAttachmentVisibleChanged = v_u_9.new()
	v28.Frame = v_u_19:GetTo("MainFrame", "Equipment")
	v28.IsOpen = false
	v28.EquipmentState = v_u_20.new(v28)
	v28.Camera = v_u_24.new(v28)
	v28.Scene = v_u_25.new(v28)
	v28.FloatingModel = v_u_21.new(v28)
	v28.SpinControls = v_u_22.new(v28)
	v28.Interface = v_u_23.new(v28)
	v28._is_trying_weapon = false
	v28._from_shop = false
	v28._was_chat_active = true
	v28._open_hash = 0
	v28._on_state_changed_queued = false
	v28._on_customizing_state_changed_queued = false
	v28:_Init()
	return v28
end
function v_u_26.IsCareerPageOpen(p29) -- name: IsCareerPageOpen
	return p29.EquipmentState.IsCareerPageOpen
end
function v_u_26.IsOpenEffectDone(p30, ...) -- name: IsOpenEffectDone
	return p30.Camera:IsOpenEffectDone(...)
end
function v_u_26.IsUnlocking(p31) -- name: IsUnlocking
	return p31.Scene.UnlockModel.IsUnlocking
end
function v_u_26.IsCustomizing(p32) -- name: IsCustomizing
	return p32.EquipmentState.CustomizingType ~= nil
end
function v_u_26.GetStateID(p33, p34) -- name: GetStateID
	-- upvalues: (copy) v_u_12
	p33:IsCustomizing()
	local v35 = p33:IsCareerPageOpen()
	local v36 = p33:GetSelectedWeapon()
	local v37 = v_u_12:GetWeaponData(v36)
	if v35 then
		return "FAKE_CAREER_STATE"
	end
	if not v36 then
		return "nil"
	end
	local v38
	if p34 then
		local v39 = v37 ~= nil
		v38 = tostring(v39) or ""
	else
		v38 = ""
	end
	return v36 .. v38
end
function v_u_26.GetSelectedWeapon(p40) -- name: GetSelectedWeapon
	return p40.EquipmentState.SelectedWeapon
end
function v_u_26.GetSelectedCosmetic(p41) -- name: GetSelectedCosmetic
	return p41.EquipmentState.SelectedCosmetic
end
function v_u_26.GetCosmeticSearchQuery(p42) -- name: GetCosmeticSearchQuery
	return p42.EquipmentState.CosmeticSearchQuery
end
function v_u_26.GetCustomizingType(p43) -- name: GetCustomizingType
	return p43.EquipmentState.CustomizingType
end
function v_u_26.SetCosmeticSearchQuery(p44, ...) -- name: SetCosmeticSearchQuery
	return p44.EquipmentState:SetCosmeticSearchQuery(...)
end
function v_u_26.SelectCosmetic(p45, ...) -- name: SelectCosmetic
	return p45.EquipmentState:SelectCosmetic(...)
end
function v_u_26.SelectWeapon(p46, ...) -- name: SelectWeapon
	return p46.EquipmentState:SelectWeapon(...)
end
function v_u_26.OpenCareerPage(p47, ...) -- name: OpenCareerPage
	return p47.EquipmentState:OpenCareerPage(...)
end
function v_u_26.StartCustomizing(p48, ...) -- name: StartCustomizing
	return p48.EquipmentState:StartCustomizing(...)
end
function v_u_26.FavoriteWeapon(p49) -- name: FavoriteWeapon
	-- upvalues: (copy) v_u_1
	local v50 = p49:GetSelectedWeapon()
	if v50 then
		v_u_1.Remotes.Data.FavoriteWeapon:FireServer(v50)
	end
end
function v_u_26.LevelUpWeapon(p51) -- name: LevelUpWeapon
	-- upvalues: (copy) v_u_12, (copy) v_u_6, (copy) v_u_18, (copy) v_u_11, (copy) v_u_8, (copy) v_u_1
	local v52 = p51:GetSelectedWeapon()
	local v53 = v_u_12:GetWeaponData(v52)
	if v53 then
		local v54 = v_u_6:GetCostToLevelUp(v53.Level, v53.XP)
		if v_u_12:Get("WeaponKeys") < v54 then
			v_u_18.PageSystem:OpenPage("Shop", true)
			v_u_18.PageSystem:WaitForPage("Shop"):SetPage("Currency")
			v_u_11:PromptCurrencyBundlePurchase(v54, "WeaponKeys")
		else
			v_u_8:CreateSound("rbxassetid://18242015218", 1, 1, script, true, 6)
			v_u_1.Remotes.Data.LevelUpWeapon:FireServer(v52)
		end
	else
		return
	end
end
function v_u_26.UnlockWeapon(p55) -- name: UnlockWeapon
	-- upvalues: (copy) v_u_7, (copy) v_u_12, (copy) v_u_18, (copy) v_u_11, (copy) v_u_1
	local v56 = p55:GetSelectedWeapon()
	local v57, v58, v59, _ = v_u_7:GetWeaponKeyPriceInfo(v56, v_u_12:Get("UnlockTokens"), v_u_12:Get("FreeWeaponUnlockCheck"))
	if v59 or v_u_7:IsWeaponReleased(v56) then
		if v_u_12:Get("WeaponKeys") < v57 and not v58 then
			v_u_18.PageSystem:OpenPage("Shop", true)
			v_u_18.PageSystem:WaitForPage("Shop"):SetPage("Currency")
			v_u_11:PromptCurrencyBundlePurchase(v57, "WeaponKeys")
		else
			p55.Scene.UnlockModel:PlayAnimation()
			v_u_1.Remotes.Data.UnlockWeapon:FireServer(v56)
		end
	else
		return
	end
end
function v_u_26.TryWeapon(p60) -- name: TryWeapon
	-- upvalues: (copy) v_u_10
	local v61 = p60:GetSelectedWeapon()
	if v61 then
		p60._is_trying_weapon = true
		p60._from_shop = false
		p60:Close(nil, true)
		v_u_10:Enter(v61)
	end
end
function v_u_26.Open(p_u_62, p63, p64) -- name: Open
	-- upvalues: (copy) v_u_14, (copy) v_u_3, (copy) v_u_4, (copy) v_u_2
	if p64 or not (v_u_14:GetPublicState() or p_u_62.IsOpen) then
		p_u_62._open_hash = p_u_62._open_hash + 1
		p_u_62:Close(true)
		p_u_62._renderstep_connection = v_u_3.RenderStepped:Connect(function(p65)
			-- upvalues: (copy) p_u_62
			p_u_62:_Update(p65)
		end)
		p_u_62._from_shop = p63
		p_u_62._was_chat_active = v_u_4:GetCore("ChatActive")
		v_u_2:EnableGamepadCursor(p_u_62.Frame)
		local v66 = v_u_4.SetCore
		local v67 = v_u_4
		pcall(v66, v67, "ChatActive", false)
		p_u_62.IsOpen = true
		p_u_62.Opened:Fire()
	end
end
function v_u_26.Close(p68, p69, p70) -- name: Close
	-- upvalues: (copy) v_u_2, (copy) v_u_4, (copy) v_u_18
	if p68.IsOpen or p69 then
		p68._open_hash = p68._open_hash + 1
		if p70 then
			local v71 = p68._open_hash
			p68.Camera:CloseEffect()
			if v71 ~= p68._open_hash then
				return
			end
		end
		if p68._renderstep_connection then
			p68._renderstep_connection:Disconnect()
			p68._renderstep_connection = nil
		end
		v_u_2:DisableGamepadCursor()
		local v72 = v_u_4.SetCore
		local v73 = v_u_4
		local v74 = p68._was_chat_active
		pcall(v72, v73, "ChatActive", v74)
		p68.IsOpen = false
		p68.Opened:Fire()
		if p68._from_shop then
			p68._from_shop = false
			v_u_18.PageSystem:OpenPage("Shop", true)
		end
	end
end
function v_u_26.CloseRequest(p75) -- name: CloseRequest
	if p75:IsCustomizing() then
		p75:StartCustomizing(nil)
	elseif p75:IsOpenEffectDone() then
		p75:Close(nil, true)
	end
end
function v_u_26._OnCustomizingStateChanged(p_u_76, ...) -- name: _OnCustomizingStateChanged
	if not p_u_76._on_customizing_state_changed_queued then
		p_u_76._on_customizing_state_changed_queued = true
		task.defer(function(...)
			-- upvalues: (copy) p_u_76
			p_u_76._on_customizing_state_changed_queued = false
			p_u_76.Interface:OnCustomizingStateChanged(...)
			p_u_76.FloatingModel:OnCustomizingStateChanged(...)
			p_u_76.Scene:OnCustomizingStateChanged(...)
		end, ...)
	end
end
function v_u_26._OnStateChanged(p_u_77, ...) -- name: _OnStateChanged
	if not p_u_77._on_state_changed_queued then
		p_u_77._on_state_changed_queued = true
		task.defer(function(...)
			-- upvalues: (copy) p_u_77
			p_u_77._on_state_changed_queued = false
			p_u_77.Scene:OnStateChanged(...)
			p_u_77.Camera:OnStateChanged(...)
			p_u_77.SpinControls:OnStateChanged(...)
			p_u_77.FloatingModel:OnStateChanged(...)
			p_u_77.Interface:OnStateChanged(...)
		end, ...)
	end
end
function v_u_26._OnOpen(p78, ...) -- name: _OnOpen
	p78.EquipmentState:OnOpen(...)
	p78.Camera:OnOpen(...)
	p78.Scene:OnOpen(...)
	p78.SpinControls:OnOpen(...)
	p78.FloatingModel:OnOpen(...)
	p78.Interface:OnOpen(...)
end
function v_u_26._Update(p79, ...) -- name: _Update
	p79.Camera:Update(...)
	p79.SpinControls:Update(...)
	p79.FloatingModel:Update(...)
	p79.Interface:Update(...)
end
function v_u_26._UpdateVisibility(p80) -- name: _UpdateVisibility
	-- upvalues: (copy) v_u_12
	local v81 = p80.Frame
	local v82 = p80.IsOpen
	if v82 then
		v82 = not v_u_12:GetSetting("Hide HUD")
	end
	v81.Visible = v82
end
function v_u_26._CheckInterruption(p83) -- name: _CheckInterruption
	-- upvalues: (copy) v_u_17, (copy) v_u_16, (copy) v_u_15
	if v_u_17:IsVisible() or (v_u_16.Enabled or v_u_15.EditorEnabled) then
		p83:Close()
	end
end
function v_u_26._HookLocalFighter(p_u_84) -- name: _HookLocalFighter
	-- upvalues: (copy) v_u_13
	local v_u_85 = v_u_13:WaitForLocalFighter()
	v_u_85:GetDataChangedSignal("IsInShootingRange"):Connect(function()
		-- upvalues: (copy) v_u_85, (copy) p_u_84
		if v_u_85:Get("IsInShootingRange") then
			p_u_84:Close()
		elseif p_u_84._is_trying_weapon and not v_u_85:Get("IsInShootingRange") then
			p_u_84._is_trying_weapon = false
			p_u_84:Open(nil, true)
		end
	end)
	v_u_85:GetDataChangedSignal("IsInDuel"):Connect(function()
		-- upvalues: (copy) v_u_85, (copy) p_u_84
		if v_u_85:Get("IsInDuel") then
			p_u_84:Close()
		end
	end)
end
function v_u_26._Init(p_u_86) -- name: _Init
	-- upvalues: (copy) v_u_17, (copy) v_u_16, (copy) v_u_15, (copy) v_u_12
	p_u_86.Opened:Connect(function(...)
		-- upvalues: (copy) p_u_86
		p_u_86:_UpdateVisibility()
		p_u_86:_OnOpen(...)
	end)
	p_u_86.SelectedWeaponChanged:Connect(function(...)
		-- upvalues: (copy) p_u_86
		p_u_86:_OnStateChanged(...)
	end)
	p_u_86.CareerPageOpened:Connect(function(...)
		-- upvalues: (copy) p_u_86
		p_u_86:_OnStateChanged(...)
	end)
	p_u_86.CustomizingChanged:Connect(function(...)
		-- upvalues: (copy) p_u_86
		p_u_86:_OnStateChanged(...)
		p_u_86:_OnCustomizingStateChanged()
	end)
	p_u_86.CustomizingStateChanged:Connect(function(...)
		-- upvalues: (copy) p_u_86
		p_u_86:_OnCustomizingStateChanged(...)
	end)
	p_u_86.EquipmentState.SelectedWeaponChanged:Connect(function(...)
		-- upvalues: (copy) p_u_86
		p_u_86.SelectedWeaponChanged:Fire(...)
	end)
	p_u_86.EquipmentState.CareerPageOpened:Connect(function(...)
		-- upvalues: (copy) p_u_86
		p_u_86.CareerPageOpened:Fire(...)
	end)
	p_u_86.EquipmentState.CustomizingChanged:Connect(function(...)
		-- upvalues: (copy) p_u_86
		p_u_86.CustomizingChanged:Fire(...)
	end)
	p_u_86.EquipmentState.CustomizingStateChanged:Connect(function(...)
		-- upvalues: (copy) p_u_86
		p_u_86.CustomizingStateChanged:Fire(...)
	end)
	p_u_86.EquipmentState.CosmeticSearchChanged:Connect(function(...)
		-- upvalues: (copy) p_u_86
		p_u_86.CosmeticSearchChanged:Fire(...)
	end)
	p_u_86.Scene.UnlockModel.UnlockingChanged:Connect(function(...)
		-- upvalues: (copy) p_u_86
		p_u_86.UnlockingChanged:Fire(...)
	end)
	p_u_86.Camera.FinishedOpenEffect:Connect(function(...)
		-- upvalues: (copy) p_u_86
		p_u_86.FinishedOpenEffect:Fire(...)
	end)
	p_u_86.FloatingModel.CharmAttachmentVisibleChanged:Connect(function(...)
		-- upvalues: (copy) p_u_86
		p_u_86.CharmAttachmentVisibleChanged:Fire(...)
	end)
	v_u_17.VisibilityChanged:Connect(function()
		-- upvalues: (copy) p_u_86
		p_u_86:_CheckInterruption()
	end)
	v_u_16.EnabledChanged:Connect(function()
		-- upvalues: (copy) p_u_86
		p_u_86:_CheckInterruption()
	end)
	v_u_15.EditorEnabledChanged:Connect(function()
		-- upvalues: (copy) p_u_86
		p_u_86:_CheckInterruption()
	end)
	v_u_12:GetSettingChangedSignal("Hide HUD"):Connect(function()
		-- upvalues: (copy) p_u_86
		p_u_86:_UpdateVisibility()
	end)
	p_u_86:Close()
	p_u_86:_UpdateVisibility()
	task.spawn(p_u_86._HookLocalFighter, p_u_86)
end
return v_u_26._new()