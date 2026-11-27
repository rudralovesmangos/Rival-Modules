local v_u_1 = game:GetService("ReplicatedStorage")
local v2 = game:GetService("Players")
local v_u_3 = require(v_u_1.Modules.CosmeticLibrary)
local v_u_4 = require(v2.LocalPlayer.PlayerScripts.Controllers.PlayerDataController)
local v_u_5 = require(v2.LocalPlayer.PlayerScripts.Modules.ButtonEffect)
local v_u_6 = {}
v_u_6.__index = v_u_6
function v_u_6.new(p7) -- name: new
	-- upvalues: (copy) v_u_6
	local v8 = v_u_6
	local v9 = setmetatable({}, v8)
	v9.Customize = p7
	v9.Frame = v9.Customize.BottomContainer:WaitForChild("Options")
	v9.Background = v9.Frame:WaitForChild("Background")
	v9.Container = v9.Frame:WaitForChild("Container")
	v9.Layout = v9.Container:WaitForChild("Layout")
	v9:_Init()
	return v9
end
function v_u_6.OnCustomizingStateChanged(p10) -- name: OnCustomizingStateChanged
	p10:_Update()
end
function v_u_6.OnStateChanged(p11) -- name: OnStateChanged
	p11:_Update()
end
function v_u_6._UpdateBackground(p12) -- name: _UpdateBackground
	p12.Background.Size = UDim2.new(0, p12.Layout.AbsoluteContentSize.X, 1, 0)
	p12.Background.Visible = p12.Layout.AbsoluteContentSize.X > 1
end
function v_u_6._OnOptionClicked(p13, p14, p15) -- name: _OnOptionClicked
	-- upvalues: (copy) v_u_5
	local v16 = p13.Container:WaitForChild(p14):WaitForChild("Container"):WaitForChild("Button")
	v16.MouseButton1Click:Connect(p15)
	v_u_5:Add(v16)
end
function v_u_6._SetOption(p17, p18, p19, p20) -- name: _SetOption
	local v21 = p17.Container:WaitForChild(p18)
	local v22 = v21:WaitForChild("Container"):WaitForChild("Button")
	local v23 = v22:WaitForChild("Empty")
	local v24 = v22:WaitForChild("Filled")
	v21.Visible = p19
	v24.Visible = p20
	v23.Visible = not p20
end
function v_u_6._Update(p25) -- name: _Update
	-- upvalues: (copy) v_u_4, (copy) v_u_3
	if p25.Customize.Interface.Equipment.IsOpen then
		local v26 = p25.Customize.Interface.Equipment:GetSelectedWeapon()
		local v27 = p25.Customize.Interface.Equipment:GetSelectedCosmetic()
		local v28 = p25.Customize.Interface.Equipment:GetCustomizingType()
		local v29 = v_u_4:GetWeaponData(v26)
		local v30
		if v29 then
			if v27 then
				v30 = v_u_3:OwnsCosmetic(v_u_4:Get("CosmeticInventory"), v27, v26)
			else
				v30 = v27
			end
		else
			v30 = v29
		end
		local v31 = v_u_4:Get("FavoritedCosmetics")
		local v32 = not v27 and v28 and "NONE_COSMETIC" or v27
		local v33 = v30 or v32 == "NONE_COSMETIC"
		local v34 = v33 and v31[v26]
		if v34 then
			v34 = v31[v26][v_u_3:GetNoneSpecificCosmeticName(v32, v28)]
		end
		p25:_SetOption("Favorited", v33, v34)
		local v35
		if v28 == "Wrap" then
			if v27 then
				v35 = v27 ~= "RANDOM_COSMETIC"
			else
				v35 = v27
			end
		else
			v35 = false
		end
		local v36
		if p25.Customize.Interface.Equipment.EquipmentState.CosmeticInverted == nil then
			v36 = v29 and v29.Wrap
			if v36 then
				v36 = v29.Wrap.Inverted
			end
		else
			v36 = p25.Customize.Interface.Equipment.EquipmentState.CosmeticInverted
		end
		p25:_SetOption("Inverted", v35, v36)
		local v37 = v27 == "RANDOM_COSMETIC"
		local v38 = v37 and (v29 and v29[v28])
		if v38 then
			v38 = v29[v28].OnlyUseFavorites
		end
		p25:_SetOption("OnlyUseFavorites", v37, v38)
	end
end
function v_u_6._Init(p_u_39) -- name: _Init
	-- upvalues: (copy) v_u_4, (copy) v_u_3, (copy) v_u_1
	p_u_39.Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		-- upvalues: (copy) p_u_39
		p_u_39:_UpdateBackground()
	end)
	p_u_39:_OnOptionClicked("Favorited", function()
		-- upvalues: (copy) p_u_39, (ref) v_u_4, (ref) v_u_3, (ref) v_u_1
		local v40 = p_u_39.Customize.Interface.Equipment:GetSelectedWeapon()
		local v41 = p_u_39.Customize.Interface.Equipment:GetSelectedCosmetic()
		local v42 = p_u_39.Customize.Interface.Equipment:GetCustomizingType()
		local v43 = v_u_4:Get("FavoritedCosmetics")
		local v44 = v41 or "NONE_COSMETIC"
		local v45 = v43[v40]
		if v45 then
			v45 = v43[v40][v_u_3:GetNoneSpecificCosmeticName(v44, v42)]
		end
		local v46 = not v45
		local v47
		if v44 == "NONE_COSMETIC" then
			v47 = p_u_39.Customize.Interface.Equipment:GetCustomizingType()
		else
			v47 = nil
		end
		v_u_1.Remotes.Data.FavoriteCosmetic:FireServer(v40, v44, v46, v47)
	end)
	p_u_39:_OnOptionClicked("Inverted", function()
		-- upvalues: (copy) p_u_39, (ref) v_u_4, (ref) v_u_3, (ref) v_u_1
		local v48 = p_u_39.Customize.Interface.Equipment:GetSelectedWeapon()
		local v49 = p_u_39.Customize.Interface.Equipment:GetSelectedCosmetic()
		local v50 = p_u_39.Customize.Interface.Equipment:GetCustomizingType()
		local v51 = p_u_39.Customize.Interface.Equipment.EquipmentState.CosmeticInverted
		local v52 = v_u_4:GetWeaponData(v48)
		if v52 then
			if v49 then
				v49 = v_u_3:OwnsCosmetic(v_u_4:Get("CosmeticInventory"), v49, v48)
			end
		else
			v49 = v52
		end
		local v53 = v51 == nil and (v52 and v52.Wrap)
		if v53 then
			v53 = v52.Wrap.Inverted
		end
		local v54 = not v53
		p_u_39.Customize.Interface.Equipment.EquipmentState:SetCosmeticInvertedState(v54)
		if v49 then
			v_u_1.Remotes.Data.EquipCosmetic:FireServer(v48, v50, v52.Wrap.Name, {
				["IsInverted"] = v54
			})
		end
	end)
	p_u_39:_OnOptionClicked("OnlyUseFavorites", function()
		-- upvalues: (copy) p_u_39, (ref) v_u_4, (ref) v_u_1
		local v55 = p_u_39.Customize.Interface.Equipment:GetSelectedWeapon()
		local v56 = p_u_39.Customize.Interface.Equipment:GetCustomizingType()
		local v57 = v_u_4:GetWeaponData(v55)
		local v58 = {
			["OnlyUseFavorites"] = not v57[v56].OnlyUseFavorites
		}
		v_u_1.Remotes.Data.EquipCosmetic:FireServer(v55, v56, v57[v56].Name, v58)
	end)
	v_u_4:GetDataChangedSignal("WeaponInventory"):Connect(function()
		-- upvalues: (copy) p_u_39
		p_u_39:_Update()
	end)
	v_u_4:GetDataChangedSignal("CosmeticInventory"):Connect(function()
		-- upvalues: (copy) p_u_39
		p_u_39:_Update()
	end)
	v_u_4:GetDataChangedSignal("FavoritedCosmetics"):Connect(function()
		-- upvalues: (copy) p_u_39
		p_u_39:_Update()
	end)
	p_u_39:_UpdateBackground()
end
return v_u_6