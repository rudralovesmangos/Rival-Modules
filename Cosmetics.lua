local v_u_1 = game:GetService("ReplicatedStorage")
local v2 = game:GetService("Players")
local v_u_3 = require(v_u_1.Modules.CosmeticLibrary)
local v_u_4 = require(v_u_1.Modules.BetterDebris)
local v_u_5 = require(v_u_1.Modules.ItemLibrary)
local v_u_6 = require(v_u_1.Modules.Utility)
local v_u_7 = require(v2.LocalPlayer.PlayerScripts.Controllers.PlayerDataController)
local v_u_8 = require(v2.LocalPlayer.PlayerScripts.Modules.CosmeticSlot)
local v_u_9 = v2.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("CosmeticSlotNotification")
local v_u_10 = v2.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("CosmeticSlotEmpty")
local v_u_11 = {}
v_u_11.__index = v_u_11
function v_u_11.new(p12) -- name: new
	-- upvalues: (copy) v_u_11
	local v13 = v_u_11
	local v14 = setmetatable({}, v13)
	v14.Customize = p12
	v14.List = v14.Customize.BottomContainer:WaitForChild("List")
	v14.Container = v14.List:WaitForChild("Container")
	v14.Layout = v14.Container:WaitForChild("Layout")
	v14._cosmetic_slots = {}
	v14._empty_cosmetic_slots = {}
	v14._generate_hash = 0
	v14:_Init()
	return v14
end
function v_u_11.OnCustomizingStateChanged(p15) -- name: OnCustomizingStateChanged
	p15:_BulkUpdateEquipped()
	p15:_BulkUpdateSearch()
end
function v_u_11.OnStateChanged(p16) -- name: OnStateChanged
	p16:_BulkUpdateEquipped()
	task.defer(p16._Generate, p16)
end
function v_u_11._UpdateFavorited(p17, p18) -- name: _UpdateFavorited
	-- upvalues: (copy) v_u_7, (copy) v_u_3
	local v19 = v_u_7:Get("FavoritedCosmetics")
	local v20 = p17.Customize.Interface.Equipment:GetSelectedWeapon()
	local v21 = p17.Customize.Interface.Equipment:GetCustomizingType()
	local v22 = v19[v20]
	if v22 then
		v22 = v19[v20][v_u_3:GetNoneSpecificCosmeticName(p18, v21)]
	end
	p17._cosmetic_slots[p18].Frame.Button.Favorited.Visible = v22
	p17._cosmetic_slots[p18].Frame.LayoutOrder = p17._cosmetic_slots[p18].OriginalLayoutOrder + (v22 and -9999999 or 0)
	p17._cosmetic_slots[p18].Frame.ZIndex = p17._cosmetic_slots[p18].Frame.LayoutOrder
end
function v_u_11._BulkUpdateFavorited(p23) -- name: _BulkUpdateFavorited
	for v24 in pairs(p23._cosmetic_slots) do
		p23:_UpdateFavorited(v24)
	end
end
function v_u_11._UpdateSearch(p25, p26) -- name: _UpdateSearch
	-- upvalues: (copy) v_u_3, (copy) v_u_6
	local v27 = v_u_3.Cosmetics[p26]
	if v27 then
		v27 = v27.GetDescription(false)
	end
	p25._cosmetic_slots[p26].Frame.Visible = p26 == "NONE_COSMETIC" and true or v_u_6:IsVisibleFromSearch(p25.Customize.Interface.Equipment:GetCosmeticSearchQuery(), p25._cosmetic_slots[p26].Frame.Button.Title.ContentText, p25._cosmetic_slots[p26].Frame.Button.Title, v27, nil)
end
function v_u_11._BulkUpdateSearch(p28) -- name: _BulkUpdateSearch
	for v29 in pairs(p28._cosmetic_slots) do
		p28:_UpdateSearch(v29)
	end
end
function v_u_11._IsEquipped(p30, p31) -- name: _IsEquipped
	-- upvalues: (copy) v_u_7
	local v32 = p30.Customize.Interface.Equipment:GetSelectedWeapon()
	local v33 = p30.Customize.Interface.Equipment:GetCustomizingType()
	if v33 == "Emote" then
		if p31 == "NONE_COSMETIC" then
			return false
		else
			return v_u_7:IsEmoteEquipped(p31)
		end
	else
		local v34 = v_u_7:GetWeaponData(v32)
		if v34 then
			v34 = v34[v33]
		end
		if p31 == "NONE_COSMETIC" then
			return not v34
		end
		if v34 then
			v34 = p31 == v34.Name
		end
		return v34
	end
end
function v_u_11._UpdateEquipped(p35, p36) -- name: _UpdateEquipped
	p35._cosmetic_slots[p36].Frame.Button.Equipped.Visible = p35:_IsEquipped(p36)
end
function v_u_11._BulkUpdateEquipped(p37) -- name: _BulkUpdateEquipped
	if p37.Customize.Interface.Equipment.IsOpen then
		for v38 in pairs(p37._cosmetic_slots) do
			p37:_UpdateEquipped(v38)
		end
	end
end
function v_u_11._Cleanup(p39) -- name: _Cleanup
	-- upvalues: (copy) v_u_4
	local v40 = 0
	for _, v41 in pairs(p39._cosmetic_slots) do
		v41.Frame.Parent = nil
		v_u_4:AddItem(v41, v40 * 0.1)
		v40 = v40 + 1
	end
	for _, v42 in pairs(p39._empty_cosmetic_slots) do
		v42:Destroy()
	end
	p39._cosmetic_slots = {}
	p39._empty_cosmetic_slots = {}
	p39._generate_hash = p39._generate_hash + 1
end
function v_u_11._Generate(p_u_43) -- name: _Generate
	-- upvalues: (copy) v_u_3, (copy) v_u_7, (copy) v_u_8, (copy) v_u_9, (copy) v_u_5, (copy) v_u_1, (copy) v_u_10
	p_u_43:_Cleanup()
	p_u_43._generate_hash = p_u_43._generate_hash + 1
	local v44 = p_u_43._generate_hash
	local v_u_45 = p_u_43.Customize.Interface.Equipment:GetSelectedWeapon()
	local v46 = p_u_43.Customize.Interface.Equipment:GetSelectedCosmetic()
	local v_u_47 = p_u_43.Customize.Interface.Equipment:GetCustomizingType()
	local v_u_48 = v_u_47 and v_u_3.Types[v_u_47]
	if v_u_48 then
		v_u_48 = v_u_3.Types[v_u_47].IsWeaponCosmetic
	end
	local v49 = v_u_7:Get("CosmeticNotifications")
	local v50 = v_u_7:Get("CosmeticInventory")
	if v_u_47 and (not v_u_48 or v_u_45) then
		local v51 = 0
		local v52 = {}
		for v53, v54 in pairs(v_u_3.CosmeticsAlphabetized) do
			local v55 = v_u_3.Cosmetics[v54]
			if v55.Type ~= v_u_47 or v_u_47 == "Skin" and v55.ItemName ~= v_u_45 then
				continue
			end
			local v56 = v_u_3:HasNotification(v49, v54, v_u_45)
			local v57 = not v_u_3:OwnsCosmetic(v50, v54, v_u_45)
			local v58 = p_u_43:_IsEquipped(v54)
			v51 = v51 + (v57 and 0 or 1)
			table.insert(v52, {
				["Name"] = v54,
				["HasNotification"] = v56 or false,
				["IsLocked"] = v57,
				["IsEquipped"] = v58,
				["AlphabeticalValue"] = v53
			})
		end
		table.sort(v52, function(p59, p60)
			-- upvalues: (ref) v_u_3
			local v61 = p59.IsEquipped
			if v61 == p60.IsEquipped then
				local v62 = p59.IsLocked
				if v62 == p60.IsLocked then
					local v63 = p59.HasNotification
					if v63 == p60.HasNotification then
						local v64 = v_u_3.Rarities[v_u_3.Cosmetics[p59.Name].Rarity].Value
						local v65 = v_u_3.Rarities[v_u_3.Cosmetics[p60.Name].Rarity].Value
						if v64 == v65 then
							return p59.AlphabeticalValue < p60.AlphabeticalValue
						else
							return v65 < v64
						end
					else
						return v63
					end
				else
					return not v62
				end
			else
				return v61
			end
		end)
		if not v46 and (v_u_47 == "Emote" and not next(v_u_7:Get("EquippedEmotes"))) then
			p_u_43.Customize.Interface.Equipment:SelectCosmetic("Take The L")
		end
		local v_u_66 = v_u_47 == "Emote" and 1 or 5
		local v_u_67 = 0
		local function v77(p_u_68, p_u_69, p70) -- name: generate_slot
			-- upvalues: (ref) v_u_3, (ref) v_u_8, (ref) v_u_67, (copy) p_u_43, (ref) v_u_9, (ref) v_u_7, (ref) v_u_5, (copy) v_u_45, (copy) v_u_48, (ref) v_u_1, (copy) v_u_47, (copy) v_u_66
			local v71 = v_u_3.Cosmetics[p_u_68]
			if not (v71 and (v71.Hidden and p_u_69)) then
				local v72 = v_u_8.new(p_u_68, p_u_69)
				v72.OriginalLayoutOrder = v_u_67 + (v71 and 0 or -999999999) + (v71 and p_u_43:_IsEquipped(p_u_68) and -99999999 or 0)
				v72.Frame.LayoutOrder = v72.OriginalLayoutOrder
				v72.Frame.Parent = p_u_43.Container
				p_u_43._cosmetic_slots[p_u_68] = v72
				v_u_67 = v_u_67 + 1
				p_u_43:_UpdateSearch(p_u_68)
				p_u_43:_UpdateEquipped(p_u_68)
				p_u_43:_UpdateFavorited(p_u_68)
				local v_u_73
				if p70 then
					v_u_73 = v_u_9:Clone()
					v_u_73.Parent = v72.Frame.Button
				else
					v_u_73 = nil
				end
				v72.Frame.Button.MouseButton1Click:Connect(function()
					-- upvalues: (ref) v_u_73, (ref) v_u_7, (copy) p_u_68, (ref) v_u_5, (ref) v_u_45, (ref) p_u_43, (copy) p_u_69, (ref) v_u_48, (ref) v_u_1, (ref) v_u_47
					if v_u_73 then
						v_u_73:Destroy()
						v_u_73 = nil
						v_u_7:SilenceCosmeticNotification(p_u_68, v_u_5.Items[v_u_45] and v_u_45 or nil)
					end
					p_u_43.Customize.Interface.Equipment:SelectCosmetic(p_u_68)
					if v_u_45 and (not p_u_69 and v_u_48) then
						local v74 = v_u_7:GetWeaponData(v_u_45)
						local v75
						if p_u_68 == "NONE_COSMETIC" then
							v75 = nil
						else
							v75 = p_u_68
						end
						local v76 = v74 and (v74.Wrap and v74.Wrap.Inverted) or nil
						v_u_1.Remotes.Data.EquipCosmetic:FireServer(v_u_45, v_u_47, v75, {
							["IsInverted"] = v76
						})
					end
				end)
				if not p_u_43.Customize.Interface.Equipment:GetSelectedCosmetic() and p_u_43:_IsEquipped(p_u_68) then
					p_u_43.Customize.Interface.Equipment:SelectCosmetic(p_u_68)
				end
				if v_u_67 % v_u_66 == 0 then
					wait(0.06)
				end
			end
		end
		if v_u_48 then
			v77("NONE_COSMETIC", false)
			if v44 ~= p_u_43._generate_hash then
				return
			end
		end
		if v_u_48 and v51 > 0 then
			v77("RANDOM_COSMETIC", false)
			if v44 ~= p_u_43._generate_hash then
				return
			end
		end
		for _, v78 in pairs(v52) do
			v77(v78.Name, v78.IsLocked, v78.HasNotification)
			if v44 == p_u_43._generate_hash then
				continue
			end
			return
		end
		for _ = 1, 11 do
			local v79 = v_u_10:Clone()
			v79.LayoutOrder = 999999999
			v79.Parent = p_u_43.Container
			local v80 = p_u_43._empty_cosmetic_slots
			table.insert(v80, v79)
		end
	end
end
function v_u_11._Init(p_u_81) -- name: _Init
	-- upvalues: (copy) v_u_7
	p_u_81.Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		-- upvalues: (copy) p_u_81
		p_u_81.List.CanvasSize = UDim2.new(0, p_u_81.Layout.AbsoluteContentSize.X, 0, 0)
	end)
	p_u_81.Customize.Interface.Equipment.CosmeticSearchChanged:Connect(function()
		-- upvalues: (copy) p_u_81
		p_u_81:_BulkUpdateSearch()
	end)
	v_u_7:GetDataChangedSignal("WeaponInventory"):Connect(function()
		-- upvalues: (copy) p_u_81
		p_u_81:_BulkUpdateEquipped()
	end)
	v_u_7:GetDataChangedSignal("EquippedEmotes"):Connect(function()
		-- upvalues: (copy) p_u_81
		p_u_81:_BulkUpdateEquipped()
	end)
	v_u_7:GetDataChangedSignal("CosmeticInventory"):Connect(function()
		-- upvalues: (copy) p_u_81
		p_u_81:_BulkUpdateEquipped()
	end)
	v_u_7:GetDataChangedSignal("FavoritedCosmetics"):Connect(function()
		-- upvalues: (copy) p_u_81
		p_u_81:_BulkUpdateFavorited()
	end)
end
return v_u_11