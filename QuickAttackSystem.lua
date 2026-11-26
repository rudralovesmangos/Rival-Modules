local v_u_1 = game:GetService("ReplicatedStorage")
game:GetService("HttpService")
local v_u_2 = game:GetService("RunService")
local v3 = game:GetService("Players")
local v_u_4 = require(v_u_1.Modules.BetterDebris)
local v_u_5 = require(v_u_1.Modules.ItemLibrary)
local v_u_6 = require(v3.LocalPlayer.PlayerScripts.Controllers.PlayerDataController)
local v_u_7 = {}
v_u_7.__index = v_u_7
function v_u_7.new(p8) -- name: new
	-- upvalues: (copy) v_u_7
	local v9 = v_u_7
	local v10 = setmetatable({}, v9)
	v10.ClientFighter = p8
	v10._quick_attack_down_starts = {}
	v10._is_quick_attacking = false
	v10._keep_quick_attack = false
	v10._quick_attack_hash = 0
	v10._quick_attack_cooldown = 0
	v10._quick_attack_original_item = nil
	v10._quick_attack_target_item = nil
	v10._quick_attack_inputs = nil
	v10._quick_attack_keep_window = 0
	v10._dont_skip_equip_animation_from_quick_attacks = 0
	v10:_Init()
	return v10
end
function v_u_7.IsEquippingLocked(p11, p12) -- name: IsEquippingLocked
	local v13 = p11._quick_attack_target_item
	if v13 then
		v13 = p11._quick_attack_target_item:Get("ObjectID") ~= p12
	end
	return v13
end
function v_u_7.GetQuickAttackIndex(p14, p15) -- name: GetQuickAttackIndex
	-- upvalues: (copy) v_u_5
	return p14.ClientFighter:Get("OverrideQuickAttacks") and p14.ClientFighter:Get("OverrideQuickAttacks")[p15] or v_u_5.QUICK_ATTACK_ITEM_INDEX_DEFAULTS[p15]
end
function v_u_7.ShouldSkipEquipAnimation(_, p16) -- name: ShouldSkipEquipAnimation
	return p16:Get("QuickAttackQueued") or p16:Get("SkipEquipAnimation")
end
function v_u_7.InputDown(p_u_17, p18) -- name: InputDown
	-- upvalues: (copy) v_u_6, (copy) v_u_1, (copy) v_u_5
	p_u_17._quick_attack_down_starts[p18] = tick()
	if p_u_17.ClientFighter:AreItemsLocked() or tick() < p_u_17._quick_attack_cooldown then
		return
	else
		local v19 = p_u_17:GetQuickAttackIndex(p18)
		local v20 = p_u_17.ClientFighter.Items[v19]
		local v21 = p_u_17.ClientFighter.EquippedItem
		if v21 and v20 then
			local v22 = v_u_6:GetSetting("Easy Quick Attack") and v20:CanEasyQuickAttack()
			if v22 then
				v22 = v20.Info.QuickAttackInputsEasy ~= nil
			end
			local v23 = v22 and v20.Info.QuickAttackInputsEasy
			if not v23 then
				if v20:CanQuickAttack() then
					v23 = v20.Info.QuickAttackInputs or nil
				else
					v23 = nil
				end
			end
			if v21 == v20 or not v23 then
				v20:PlayEquipFailedEffect()
			else
				p_u_17._is_quick_attacking = true
				p_u_17._keep_quick_attack = v_u_6:GetSetting("Keep Quick Attack Enabled")
				p_u_17._quick_attack_hash = p_u_17._quick_attack_hash + 1
				p_u_17._quick_attack_keep_window = tick() + (not p_u_17._keep_quick_attack and (1 / 0) or v_u_6:GetSetting("Keep Quick Attack Window"))
				p_u_17._quick_attack_cooldown = (1 / 0)
				p_u_17._quick_attack_original_item = v21
				p_u_17._quick_attack_target_item = v20
				p_u_17._quick_attack_inputs = v23
				v_u_1.Remotes.Replication.Fighter.RegisterQuickAttack:FireServer(p18, v22)
				v20:SetReplicate("QuickAttackQueued", true)
				p_u_17.ClientFighter:EquipItem(table.find(p_u_17.ClientFighter.Items, v20), true)
				task.defer(function()
					-- upvalues: (copy) p_u_17, (ref) v_u_5
					local v24 = p_u_17._quick_attack_hash
					wait(v_u_5.QUICK_ATTACK_TIMEOUT)
					if v24 == p_u_17._quick_attack_hash then
						p_u_17:_Cancel(false)
					end
				end)
			end
		else
			return
		end
	end
end
function v_u_7.InputUp(p25, p26) -- name: InputUp
	-- upvalues: (copy) v_u_6
	if p25._quick_attack_down_starts[p26] then
		if (not v_u_6:GetSetting("Keep Quick Attack Enabled") and (1 / 0) or v_u_6:GetSetting("Keep Quick Attack Window")) > tick() - p25._quick_attack_down_starts[p26] and tick() < p25._quick_attack_keep_window then
			p25._keep_quick_attack = false
		end
	end
end
function v_u_7.OnReEquip(p27) -- name: OnReEquip
	for _, v28 in pairs(p27.ClientFighter.Items) do
		v28:SetReplicate("SkipEquipAnimation", nil)
	end
	p27._dont_skip_equip_animation_from_quick_attacks = tick() + 1
end
function v_u_7.Clear(p29) -- name: Clear
	p29._is_quick_attacking = false
	p29._keep_quick_attack = false
	p29._quick_attack_hash = p29._quick_attack_hash + 1
	p29._quick_attack_cooldown = tick() + 0
	p29._quick_attack_original_item = nil
	p29._quick_attack_target_item = nil
	p29._quick_attack_inputs = nil
end
function v_u_7.Destroy(_) -- name: Destroy end
function v_u_7._Cancel(p30, p31) -- name: _Cancel
	if p31 == nil then
		p31 = p30._keep_quick_attack
	end
	if p30._quick_attack_original_item then
		if p30._quick_attack_target_item then
			p30._quick_attack_target_item:SetReplicate("QuickAttackQueued", nil)
		end
		if not p31 then
			if tick() > p30._dont_skip_equip_animation_from_quick_attacks then
				p30._quick_attack_original_item:SetReplicate("SkipEquipAnimation", true)
			end
			p30.ClientFighter:EquipItem(table.find(p30.ClientFighter.Items, p30._quick_attack_original_item), true)
		end
		p30:Clear()
	end
end
function v_u_7._TryQuickAttackInputs(p32, p33) -- name: _TryQuickAttackInputs
	if not p32._quick_attack_inputs then
		return false
	end
	for _, v34 in pairs(p32._quick_attack_inputs) do
		if not p33:Input(v34) then
			return false
		end
		wait(0.05)
	end
	return true
end
function v_u_7._OnEquip(p_u_35, p_u_36) -- name: _OnEquip
	-- upvalues: (copy) v_u_4, (copy) v_u_5, (copy) v_u_2
	if p_u_36 then
		if p_u_36:Get("SkipEquipAnimation") then
			p_u_36:SetReplicate("SkipEquipAnimation", nil)
		end
		if p_u_36:Get("QuickAttackQueued") and p_u_35.ClientFighter.IsLocalPlayer then
			task.defer(function()
				-- upvalues: (copy) p_u_35, (ref) v_u_4, (ref) v_u_5, (copy) p_u_36, (ref) v_u_2
				local v_u_37 = p_u_35._quick_attack_hash
				local v_u_38 = false
				local v_u_39 = Instance.new("BindableEvent")
				v_u_4:AddItem(v_u_39, v_u_5.QUICK_ATTACK_TIMEOUT)
				task.spawn(function()
					-- upvalues: (ref) p_u_35, (ref) p_u_36, (copy) v_u_37, (ref) v_u_38, (copy) v_u_39
					local v40 = p_u_35._quick_attack_inputs
					if v40 then
						v40 = p_u_35._quick_attack_inputs[#p_u_35._quick_attack_inputs]
					end
					if v40 then
						local v41 = p_u_36.ServerInputWorkDone:Wait()
						if p_u_35._quick_attack_hash ~= v_u_37 then
							return
						end
						if v41 ~= v40 then
							continue
						end
					end
					v_u_38 = true
					v_u_39:Fire()
					task.defer(v_u_39.Destroy, v_u_39)
				end)
				local v42 = p_u_35:_TryQuickAttackInputs(p_u_36)
				if p_u_35._quick_attack_hash == v_u_37 then
					if v42 then
						if not v_u_38 then
							v_u_39.Event:Wait()
						end
						if p_u_35._keep_quick_attack and tick() < p_u_35._quick_attack_keep_window then
							v_u_2.Heartbeat:Wait()
							if p_u_35._quick_attack_hash == v_u_37 then
								continue
							end
							return
						end
						p_u_35:_Cancel(nil)
					else
						p_u_35:_Cancel(false)
					end
				end
			end)
		end
	else
		return
	end
end
function v_u_7._Init(p_u_43) -- name: _Init
	p_u_43.ClientFighter.EquippedItemChanged:Connect(function(p44)
		-- upvalues: (copy) p_u_43
		p_u_43:_OnEquip(p44)
	end)
end
return v_u_7