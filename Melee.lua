-- Script Path: game:GetService("StarterPlayer").StarterPlayerScripts.Modules.ItemTypes.Melee
-- Took 0s to decompile.

local v1 = game:GetService("ReplicatedStorage")
local v2 = game:GetService("Players")
require(v1.Modules.Utility)
local v_u_3 = require(v2.LocalPlayer.PlayerScripts.Modules.ClientReplicatedClasses.ClientFighter.ClientItem)
local v_u_4 = setmetatable({}, v_u_3)
v_u_4.__index = v_u_4
function v_u_4.new(...) -- name: new
    -- upvalues: (copy) v_u_3, (copy) v_u_4
    local v5 = v_u_3.new(...)
    local v6 = v_u_4
    local v7 = setmetatable(v5, v6)
    v7._last_attack = 0
    v7._burst_count = 0
    v7._attack_cooldown = 0
    v7._attack_num = 0
    v7._attack_hash = 0
    v7._last_attack_animation_name = nil
    v7._on_attack_callback = nil
    v7:_Init()
    return v7
end
function v_u_4.GetAutoShootReach(p8) -- name: GetAutoShootReach
    return p8.Info.AttackReach
end
function v_u_4.CanQuickAttack(p9) -- name: CanQuickAttack
    local v10 = not p9:IsEquipping()
    if v10 then
        v10 = tick() <= p9._attack_cooldown or not p9.Info.NeedsAmmoToAttack or p9:Get("Ammo") > 0
    end
    return v10
end
function v_u_4.StartShooting(p_u_11, p12, p13) -- name: StartShooting
    if not p12 and (p_u_11:IsEquipping() or (tick() < p_u_11._attack_cooldown or p_u_11.Info.NeedsAmmoToAttack and p_u_11:Get("Ammo") <= 0)) then
        return false
    end
    if p_u_11._last_attack_animation_name then
        p_u_11.ViewModel:StopAnimation(p_u_11._last_attack_animation_name, p_u_11.Info.BurstCount > 1 and 0 or nil)
    end
    p_u_11._burst_count = tick() - p_u_11._last_attack >= p_u_11.Info.AttackCooldown and 0 or p_u_11._burst_count
    p_u_11._burst_count = p_u_11._burst_count % p_u_11.Info.BurstCount + 1
    p_u_11._last_attack = tick()
    local v14 = p_u_11._burst_count < p_u_11.Info.BurstCount and p_u_11.Info.BurstCooldown or p_u_11.Info.AttackCooldown
    p_u_11._attack_cooldown = tick() + v14
    p_u_11._attack_hash = p_u_11._attack_hash + 1
    local v_u_15 = p_u_11._attack_hash
    p_u_11._attack_num = p_u_11._attack_num % #p_u_11.ViewModel:GetAnimationKeys("Attack") + 1
    local v16 = p13 and p_u_11:FromEnum(p13) or "Attack" .. p_u_11._attack_num
    p_u_11._last_attack_animation_name = v16
    for _, v17 in pairs(p_u_11.ViewModel:GetAnimationKeys("AttackHit")) do
        p_u_11.ViewModel:StopAnimation(v17)
    end
    p_u_11.ViewModel:StopAnimation("Equip")
    p_u_11.ViewModel:PlayAnimation(v16, v14)
    if p_u_11._on_attack_callback then
        p_u_11._on_attack_callback()
    end
    task.delay(p_u_11.Info.AttackDelay, function()
        -- upvalues: (copy) v_u_15, (copy) p_u_11
        if v_u_15 == p_u_11._attack_hash then
            if p_u_11.ClientFighter.IsLocalPlayer then
                local v18, v19 = p_u_11.ClientFighter:GetCameraData()
                p_u_11:_TryImpactMarkerSlash(p_u_11.Info.AttackReach, v18, v19)
            end
            p_u_11:_Shake("Bump")
        end
    end)
    return true, "StartShooting", p_u_11.ClientFighter:GetCameraData(), p_u_11:ToEnum(v16)
end
function v_u_4.Equip(p20, ...) -- name: Equip
    -- upvalues: (copy) v_u_3
    v_u_3.Equip(p20, ...)
    p20._attack_hash = p20._attack_hash + 1
end
function v_u_4.Unequip(p21, ...) -- name: Unequip
    -- upvalues: (copy) v_u_3
    p21._attack_hash = p21._attack_hash + 1
    v_u_3.Unequip(p21, ...)
end
function v_u_4._Init(_) -- name: _Init end
return v_u_4
