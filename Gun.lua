-- Script Path: game:GetService("StarterPlayer").StarterPlayerScripts.Modules.ItemTypes.Gun
-- Took 0.04s to decompile.

local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("RunService")
local v_u_3 = game:GetService("Players")
local v_u_4 = require(v1.Modules.CONSTANTS)
local v_u_5 = require(v1.Modules.AnimationLibrary)
local v_u_6 = require(v1.Modules.GameplayUtility)
local v_u_7 = require(v1.Modules.BetterDebris)
local v_u_8 = require(v1.Modules.Utility)
local v_u_9 = require(v1.Modules.Spring)
local v_u_10 = require(v1.Modules.Signal)
local v_u_11 = require(v_u_3.LocalPlayer.PlayerScripts.Controllers.PlayerDataController)
local v_u_12 = require(v_u_3.LocalPlayer.PlayerScripts.Controllers.CameraController)
local v_u_13 = require(v_u_3.LocalPlayer.PlayerScripts.Controllers.WrapController)
local v_u_14 = require(v_u_3.LocalPlayer.PlayerScripts.Modules.ClientReplicatedClasses.ClientFighter.ClientItem)
local v_u_15 = require(v_u_3.LocalPlayer.PlayerScripts.Modules.TracerEffect)
local v_u_16 = v_u_3.LocalPlayer.PlayerScripts.Assets:WaitForChild("Projectiles")
local v_u_17 = setmetatable({}, v_u_14)
v_u_17.__index = v_u_17
function v_u_17.new(...) -- name: new
    -- upvalues: (copy) v_u_14, (copy) v_u_17, (copy) v_u_10, (copy) v_u_9
    local v18 = v_u_14.new(...)
    local v19 = v_u_17
    local v20 = setmetatable(v18, v19)
    v20.Shot = v_u_10.new()
    v20.ProjectileShot = v_u_10.new()
    v20.ToggleAimEnabled = true
    v20.Data.IsAiming = false
    v20._last_shot = 0
    v20._burst_count = 0
    v20._shoot_cooldown = 0
    v20._is_revolver_quick_shooting = nil
    v20._shoot_animation_num = 1
    v20._last_shoot_animation_name = nil
    v20._shoot_cooldown_no_ammo = 0
    v20._on_shoot_callback = nil
    v20._shot_but_ammo_hasnt_updated = false
    v20._reload_threads = {}
    v20._reload_cooldown = 0
    v20._reload_cancel_cooldown = 0
    v20._reload_cancel_expiration = 0
    v20._reload_delay = 0
    v20._local_tracers = {}
    v20._on_reload_callback = nil
    v20._projectile_part_to_model = {}
    v20._is_input_queueing = false
    v20._camera_displacement_spring = v_u_9.new(Vector2.zero, 1, 25)
    v20._shoot_animation_name_prefix = nil
    v20._num_shooting_animations = nil
    v20:_Init()
    return v20
end
function v_u_17.CanQuickAttack(p21) -- name: CanQuickAttack
    local v22
    if tick() > p21._shoot_cooldown and p21:Get("Ammo") > 0 then
        v22 = not p21:IsEquipping()
    else
        v22 = false
    end
    return v22
end
function v_u_17.GetAimSpeed(p23) -- name: GetAimSpeed
    return p23:Get("IsAiming") and p23.Info.AimSpeed or 1
end
function v_u_17.IsFullyAiming(p24) -- name: IsFullyAiming
    return not (p24:Get("IsAiming") and p24.Info.AimScopePercent) or p24.ViewModel.CurrentAimValue >= p24.Info.AimScopePercent
end
function v_u_17.ChangeShootAnimationNamePrefix(p25, p26) -- name: ChangeShootAnimationNamePrefix
    p25._shoot_animation_name_prefix = p26
    p25._num_shooting_animations = #p25.ViewModel:GetAnimationKeys(p25._shoot_animation_name_prefix)
    local v27
    if p25._num_shooting_animations == 0 then
        v27 = 0
    else
        local v28 = p25._shoot_animation_num
        local v29 = p25._num_shooting_animations
        v27 = math.clamp(v28, 1, v29)
    end
    p25._shoot_animation_num = v27
end
function v_u_17.StartShooting(p_u_30, p31, p32) -- name: StartShooting
    if tick() < (p_u_30._is_revolver_quick_shooting or 0) and not p32 then
        return false
    end
    local v33 = p_u_30:Get("Ammo")
    if not p31 then
        if tick() < p_u_30._shoot_cooldown_no_ammo or p_u_30:IsEquipping() then
            return false
        end
        if tick() < p_u_30._reload_cooldown and (tick() < p_u_30._reload_cancel_cooldown or (v33 <= 0 or tick() >= p_u_30._reload_cancel_expiration)) then
            return false
        end
        if p_u_30.Info.MaxAmmo and (v33 <= 0 and tick() > p_u_30._reload_delay) then
            local v34 = { p_u_30:StartReloading() }
            if v34[1] then
                return table.unpack(v34)
            end
            local v35 = tick()
            local v36 = p_u_30.Info.ShootCooldown
            p_u_30._shoot_cooldown_no_ammo = v35 + math.max(0.1, v36)
            p_u_30:CreateSound("rbxassetid://13087319223", 1, 1, true, 5)
            return false
        end
        if tick() < p_u_30._shoot_cooldown then
            if not p_u_30._is_input_queueing and (not p_u_30.Info.InputSpammingEnabled.StartShooting and p_u_30._shoot_cooldown - tick() < 0.1) then
                p_u_30._is_input_queueing = true
                task.delay(p_u_30._shoot_cooldown - tick(), function()
                    -- upvalues: (copy) p_u_30
                    p_u_30._is_input_queueing = false
                    p_u_30.ClientFighter:Input("StartShooting")
                end)
            end
            return false
        end
        if p_u_30.Name == "Minigun" and (p_u_30.ViewModel.IsWindingMinigun or not p_u_30.ViewModel.IsChargingMinigun) then
            task.defer(p_u_30.ViewModel.StartChargingMinigun, p_u_30.ViewModel)
            return false
        end
    end
    if p32 then
        p_u_30._is_revolver_quick_shooting = tick() + p_u_30.Info.QuickShotCooldown * p_u_30.Info.MaxAmmo
    end
    p_u_30.ViewModel:StopAnimation("Equip")
    p_u_30.ViewModel:StopAnimation("EquipEmpty")
    p_u_30:_ResetReloadState()
    p_u_30._burst_count = tick() - p_u_30._last_shot >= p_u_30.Info.ShootCooldown and 0 or p_u_30._burst_count
    p_u_30._burst_count = p_u_30._burst_count % p_u_30.Info.BurstCount + 1
    p_u_30._last_shot = tick()
    local v37 = p_u_30:IsFullyAiming()
    local v38 = v33 + (p31 and 1 or 0)
    local v39 = p32 and p_u_30.Info.QuickShotCooldown or (p_u_30._burst_count < p_u_30.Info.BurstCount and p_u_30.Info.BurstCooldown or p_u_30.Info.ShootCooldown)
    p_u_30._shoot_cooldown = tick() + v39
    if p_u_30._num_shooting_animations > 0 then
        local v40 = p32 and (p_u_30.ViewModel.Info.Animations.FinalQuickShot and v38 == 1) and "FinalQuickShot" or (p32 and "QuickShot" or (p_u_30.ViewModel.Info.Animations.FinalShoot and v38 == 1 and "FinalShoot" or (p_u_30.ViewModel.Info.Animations.ShootAiming and v37 and "ShootAiming" or p_u_30._shoot_animation_name_prefix .. p_u_30._shoot_animation_num)))
        p_u_30._shoot_animation_num = p_u_30._num_shooting_animations == 0 and 0 or p_u_30._shoot_animation_num % p_u_30._num_shooting_animations + 1
        if p_u_30._last_shoot_animation_name then
            p_u_30.ViewModel:StopAnimation(p_u_30._last_shoot_animation_name)
        end
        p_u_30._last_shoot_animation_name = v40
        p_u_30.ViewModel:PlayAnimation(v40, v39, 0)
    end
    local v41 = p_u_30.ClientFighter:GetCameraData()
    if p_u_30._on_shoot_callback then
        p_u_30._on_shoot_callback(v41)
    end
    p_u_30:_Recoil(v37 and 0.5 or 1)
    p_u_30.ViewModel:MuzzleFlash()
    if v38 < (1 / 0) and v38 <= p_u_30.Info.MaxAmmo * 0.25 then
        p_u_30:CreateSound("rbxassetid://13087319223", 1, 1, true, 5)
    end
    if p_u_30.ClientFighter.IsLocalPlayer and (p_u_30.Info.IsRaycast and not p_u_30.Info.DisableTracerEffects) then
        p_u_30:_LocalTracers(v37, p32)
    end
    if p_u_30.Info.AimScopePercent or p_u_30.Name == "Shotgun" then
        task.defer(p_u_30.Input, p_u_30, "FinishAiming")
        p_u_30.ToggleOffMobileInputButton:Fire("mobile_aim")
    end
    p_u_30._shot_but_ammo_hasnt_updated = true
    p_u_30.Shot:Fire()
    if p_u_30.ClientFighter:Get("IsSpectating") then
        local v42 = p_u_30._camera_displacement_spring
        local v43 = Vector2.new
        local v44 = math.random() - 0.5
        v42.Value = v43(0.017453292519943295, math.sign(v44) * 0.017453292519943295) * (v37 and p_u_30.Info.ShootCameraDisplacementRecoilWhileAiming or p_u_30.Info.ShootCameraDisplacementRecoil)
        p_u_30:_StartCameraDisplacementLoop()
    end
    local v45 = true
    local v46 = "StartShooting"
    if not v37 then
        if p32 then
            v37 = false
        else
            v37 = nil
        end
    end
    return v45, v46, v41, v37, p32
end
function v_u_17.StartReloading(p_u_47, p48, p49, p50, p51) -- name: StartReloading
    -- upvalues: (copy) v_u_5
    local v52 = p_u_47:Get("Ammo")
    local v53 = p_u_47:Get("AmmoReserve")
    if p_u_47._shot_but_ammo_hasnt_updated then
        local v54 = v52 - 1
        v52 = math.max(0, v54)
    end
    if not p_u_47.Info.ReloadType then
        return false
    end
    if not p48 and (tick() < p_u_47._reload_cooldown or (p_u_47:IsEquipping() or not p_u_47.ClientFighter:Get("InfiniteAmmoReserve") and (v53 and v53 <= 0))) then
        return false
    end
    if p_u_47.Info.MaxAmmo <= v52 then
        return false
    end
    task.defer(p_u_47.Input, p_u_47, "FinishAiming")
    p_u_47.ToggleOffMobileInputButton:Fire("mobile_aim")
    p_u_47.ViewModel:StopAnimation("Equip")
    p_u_47.ViewModel:StopAnimation("EquipEmpty")
    if p_u_47._last_shoot_animation_name then
        p_u_47.ViewModel:StopAnimation(p_u_47._last_shoot_animation_name, 0)
    end
    p_u_47._is_revolver_quick_shooting = nil
    p_u_47._shoot_animation_num = 1
    p_u_47:_ResetReloadState()
    if p_u_47._on_reload_callback then
        p_u_47._on_reload_callback()
    end
    local v55 = v52 == 0
    local v56 = p49 and p_u_47:FromEnum(p49) or (v55 and p_u_47.Info.NumEmptyReloadFiles > 0 and "EmptyReload" or "Reload")
    local v57 = p_u_47:Get("NumReloadsSoFar") % p_u_47.Info.NumReloadFiles + 1
    local v58 = p_u_47.Info.ReloadFiles[v56][v57]
    local v_u_59 = p50 and p_u_47:FromEnum(p50) or (v55 and p_u_47.ViewModel.Animator:HasEmptyReloadAnimations() and "EmptyReload" or (v57 == 1 and "Reload" or ("Reload" .. v57 or "Reload")))
    if p_u_47.Info.ReloadType == "Regular" then
        local v_u_60 = v58.Length
        local v_u_61 = v58.ActionTimestamp
        p_u_47._reload_cooldown = tick() + v_u_60
        p_u_47._reload_cancel_expiration = tick() + v58.ActionTimestamp
        p_u_47._reload_cancel_cooldown = tick() + (not v55 and 0.25 or v_u_60)
        local v62 = p_u_47._reload_threads
        local v63 = task.spawn
        table.insert(v62, v63(function()
            -- upvalues: (copy) p_u_47, (copy) v_u_61, (copy) v_u_60
            p_u_47:CooldownEffect("rbxassetid://17139961241", v_u_61, "Reload", true)
            wait(v_u_61)
            p_u_47:CooldownEffect("rbxassetid://17156089790", v_u_60 - v_u_61, "Reload")
        end))
        local v64 = p_u_47._reload_threads
        local v65 = task.spawn
        table.insert(v64, v65(function()
            -- upvalues: (copy) p_u_47, (copy) v_u_59, (copy) v_u_60
            p_u_47.ViewModel:PlayAnimation(v_u_59, v_u_60, p_u_47.ViewModel.ShouldPlayReloadAnimationInstantly and 0 or 0.1)
        end))
    else
        if p_u_47.Info.ReloadType ~= "Segmented" then
            return false
        end
        local v_u_66 = v58.StartLength
        local v_u_67 = v58.StartActionTimestamp
        local v_u_68 = v58.SegmentLength
        local v_u_69 = v58.SegmentActionTimestamp
        local v70 = v58.FinishLength
        local v_u_71 = v58.FinishActionTimestamp
        local v_u_72
        if p51 then
            v_u_72 = utf8.codepoint(p51)
        else
            local v73 = (p_u_47.ClientFighter:Get("InfiniteAmmoReserve") or not v53) and (1 / 0) or v53
            local v74 = p_u_47.Info.MaxAmmo - v52
            v_u_72 = math.min(v73, v74) - (v_u_67 and 1 or 0) - (v_u_71 and 1 or 0)
        end
        local v75 = v_u_66 + v_u_68 * v_u_72 + v70
        local v76 = v_u_67 or v_u_66 + v_u_69
        p_u_47._reload_cooldown = tick() + v75
        p_u_47._reload_cancel_expiration = (1 / 0)
        if not v55 then
            v76 = tick() + 0.25
        end
        p_u_47._reload_cancel_cooldown = v76
        local v77 = p_u_47._reload_threads
        local v78 = task.spawn
        table.insert(v77, v78(function()
            -- upvalues: (copy) v_u_67, (copy) p_u_47, (copy) v_u_66, (copy) v_u_72, (copy) v_u_69, (copy) v_u_68, (copy) v_u_71
            if v_u_67 then
                p_u_47:CooldownEffect("rbxassetid://17139961241", v_u_67, "Reload", true)
            end
            wait(v_u_66)
            for _ = 1, v_u_72 do
                p_u_47:CooldownEffect("rbxassetid://17139961241", v_u_69, "Reload", true)
                wait(v_u_68)
            end
            if v_u_71 then
                p_u_47:CooldownEffect("rbxassetid://17139961241", v_u_71, "Reload", true)
            end
        end))
        local v79 = p_u_47._reload_threads
        local v80 = task.spawn
        local function v84()
            -- upvalues: (ref) v_u_5, (copy) p_u_47, (copy) v_u_59, (copy) v_u_72
            local v81 = v_u_5.Info[p_u_47.ViewModel.Info.Animations[v_u_59 .. "Start"]].Length
            local v82 = v_u_5.Info[p_u_47.ViewModel.Info.Animations[v_u_59 .. "Segment"]].Length
            local v83 = v_u_5.Info[p_u_47.ViewModel.Info.Animations[v_u_59 .. "Finish"]].Length
            p_u_47.ViewModel:PlayAnimation(v_u_59 .. "Start", v81, p_u_47.ViewModel.ShouldPlayReloadAnimationInstantly and 0 or 0.1)
            wait(v81)
            for _ = 1, v_u_72 do
                p_u_47.ViewModel:PlayAnimation(v_u_59 .. "Segment", v82, 0)
                wait(v82)
            end
            if p_u_47.ViewModel.Info.Animations[v_u_59 .. "SegmentFinal"] then
                p_u_47.ViewModel:PlayAnimation(v_u_59 .. "SegmentFinal", v82, 0)
                wait(v_u_5.Info[p_u_47.ViewModel.Info.Animations[v_u_59 .. "SegmentFinal"]].Length)
            end
            p_u_47.ViewModel:PlayAnimation(v_u_59 .. "Finish", v83, 0)
        end
        table.insert(v79, v80(v84))
    end
    return true, "StartReloading", p_u_47:ToEnum(v56), p_u_47:ToEnum(v_u_59)
end
function v_u_17.StartAiming(p85, p86) -- name: StartAiming
    if not p86 and (p85:Get("IsAiming") or (tick() < p85._reload_cooldown or p85:IsEquipping())) then
        return false
    end
    p85:SetReplicate("IsAiming", true)
    p85.StopSprinting:Fire()
    p85.ViewModel:SetAiming(true)
    p85:SetReplicate("FOVOffset", p85.Info.AimFOVOffset)
    p85:_StartAimAssist()
    if p85.ClientFighter:Get("IsSpectating") then
        p85:CreateSound("rbxassetid://13949557885", 1, 1, true, 5)
        if p85.ViewModel.PlayAimSound then
            p85.ViewModel:PlayAimSound(true)
        end
    end
    if p85.Info.AimScopePercent then
        p85.ViewModel:StopAnimation(p85.ViewModel.Animator:GetInspectAnimationKey())
        p85.ViewModel:StopAnimation(p85.ViewModel.Animator:GetRareInspectAnimationKey())
    end
    return true, "StartAiming"
end
function v_u_17.FinishAiming(p87, _) -- name: FinishAiming
    if not p87:Get("IsAiming") then
        return false
    end
    p87:_FinishAiming()
    p87.AttemptToSprintAgain:Fire()
    if p87.ClientFighter:Get("IsSpectating") then
        p87:CreateSound("rbxassetid://13949557844", 1, 1, true, 5)
        if p87.ViewModel.PlayAimSound then
            p87.ViewModel:PlayAimSound(false)
        end
    end
    return true, "FinishAiming"
end
function v_u_17.StartSprinting(p88, _) -- name: StartSprinting
    p88:SimulateInputFromGameplayMechanic("FinishAiming", true)
    return false
end
function v_u_17.Equip(p89, ...) -- name: Equip
    -- upvalues: (copy) v_u_14
    v_u_14.Equip(p89, ...)
    p89._is_revolver_quick_shooting = nil
    p89._shoot_cooldown = p89._shoot_cooldown and p89._shoot_cooldown >= (1 / 0) and 0 or p89._shoot_cooldown
    p89:_ResetReloadState()
end
function v_u_17.Unequip(p90, ...) -- name: Unequip
    -- upvalues: (copy) v_u_14
    p90._is_revolver_quick_shooting = nil
    p90._shoot_cooldown = p90._shoot_cooldown and p90._shoot_cooldown >= (1 / 0) and 0 or p90._shoot_cooldown
    p90:_ResetReloadState()
    p90:_FinishAiming()
    v_u_14.Unequip(p90, ...)
end
function v_u_17.Update(p91, ...) -- name: Update
    -- upvalues: (copy) v_u_14
    v_u_14.Update(p91, ...)
    if p91.ItemInterface then
        local v92 = p91.Info.AimScopePercent
        if v92 then
            if p91.ViewModel.CurrentAimValue >= p91.Info.AimScopePercent then
                v92 = p91.ClientFighter:IsActuallyFirstPerson()
            else
                v92 = false
            end
        end
        if not p91.ItemInterface:IsScopeActive() and v92 then
            p91.ItemInterface:SetScopeActive(true)
            return
        end
        if p91.ItemInterface:IsScopeActive() and not v92 then
            p91.ItemInterface:SetScopeActive(false)
        end
    end
end
function v_u_17.ReplicateFromServer(p93, p94, ...) -- name: ReplicateFromServer
    -- upvalues: (copy) v_u_14
    if p94 == "ShootEffect" then
        if p93:IsRendered() then
            p93:_ShootEffect(...)
        end
    elseif p94 == "ProjectileEffect" then
        if p93:IsRendered() then
            p93:_ProjectileEffect(...)
        end
    elseif p94 == "ResetReloadState" then
        if p93:IsRendered() then
            p93:_ResetReloadState()
        end
    else
        v_u_14.ReplicateFromServer(p93, p94, ...)
        return
    end
end
function v_u_17.Destroy(p95) -- name: Destroy
    -- upvalues: (copy) v_u_14
    p95.Shot:Destroy()
    p95.ProjectileShot:Destroy()
    p95:_ResetReloadState()
    p95:_FinishAiming()
    for _, v96 in pairs(p95._projectile_part_to_model) do
        v96:Destroy()
    end
    v_u_14.Destroy(p95)
end
function v_u_17._StartCameraDisplacementLoop(p_u_97) -- name: _StartCameraDisplacementLoop
    -- upvalues: (copy) v_u_2, (copy) v_u_12
    if not p_u_97._camera_displacement_loop_active and p_u_97._camera_displacement_spring.Value.Magnitude >= 0.001 then
        task.spawn(function()
            -- upvalues: (copy) p_u_97, (ref) v_u_2, (ref) v_u_12
            p_u_97._camera_displacement_loop_active = true
            while true do
                local v98 = v_u_2.RenderStepped:Wait()
                if p_u_97._destroyed or (p_u_97._camera_displacement_spring.Value.Magnitude < 0.001 or not p_u_97.ClientFighter:Get("IsSpectating")) then
                    break
                end
                v_u_12:ApplyRotationDelta(p_u_97._camera_displacement_spring.Value * v98, true)
            end
            p_u_97._camera_displacement_loop_active = false
        end)
    end
end
function v_u_17._FinishAiming(p99) -- name: _FinishAiming
    p99:SetReplicate("IsAiming", false)
    p99.ViewModel:SetAiming(false)
    p99:SetReplicate("FOVOffset", 0)
    p99:_FinishAimAssist()
end
function v_u_17._ProjectileEffect(p_u_100, p_u_101, p102) -- name: _ProjectileEffect
    -- upvalues: (copy) v_u_16, (copy) v_u_7, (copy) v_u_13, (copy) v_u_9, (copy) v_u_2, (copy) v_u_11, (copy) v_u_8
    if not p_u_101 then
        return
    end
    p_u_101.Transparency = 1
    local v103
    if p102 then
        v103 = p102.ProjectileNameOverride
    else
        v103 = p102
    end
    local v104 = (v103 and v_u_16:FindFirstChild(v103) or (v_u_16:FindFirstChild(p_u_100.ViewModel.Name) or v_u_16[p_u_100.Name])):Clone()
    v104.Parent = workspace
    p_u_100._projectile_part_to_model[p_u_101] = v104
    v_u_7:AddItem(v104, 60)
    v_u_13:ApplyWrap(v_u_13:RecordOriginalWrapProperties(v104), p_u_100:GetWrap(), true)
    p_u_101.Destroying:Connect(function()
        -- upvalues: (copy) p_u_100, (copy) p_u_101
        p_u_100._projectile_part_to_model[p_u_101] = nil
    end)
    for _, v105 in pairs(v104:GetChildren()) do
        v105.CanCollide = false
        v105.CanTouch = false
        v105.CanQuery = false
        v105.Massless = true
        v105.Anchored = true
    end
    p_u_100.ProjectileShot:Fire(p_u_101, v104)
    local v106
    if p102 and p102.ProjectileLogicOptimized ~= nil then
        v106 = p102.ProjectileLogicOptimized
    else
        v106 = p_u_100.Info.ProjectileLogicOptimized
    end
    if v106 then
        local v107 = CFrame.Angles(math.random() * 3.141592653589793 * 2, math.random() * 3.141592653589793 * 2, math.random() * 3.141592653589793 * 2)
        local v108 = v_u_9.new(p_u_101.Position, 1, 100)
        while not p_u_100._destroyed and p_u_101:IsDescendantOf(workspace) do
            v108.Target = p_u_101.Position
            v104:PivotTo(CFrame.new(v108.Value) * p_u_101.CFrame.Rotation * v107)
            v_u_2.RenderStepped:Wait()
        end
        v104:Destroy()
        return
    end
    local v109 = 0.5
    for _, v110 in pairs(v104:GetDescendants()) do
        if v110:IsA("Trail") then
            local v111 = v110.Lifetime
            v109 = math.max(v109, v111)
        else
            if not v110:IsA("ParticleEmitter") then
                continue
            end
            local v112 = v110.Lifetime.Max
            v109 = math.max(v109, v112)
        end
    end
    local v113
    if p102 and p102.ProjectileVisualSpinEnabled ~= nil then
        v113 = p102.ProjectileVisualSpinEnabled
    else
        v113 = p_u_100.Info.ProjectileVisualSpinEnabled
    end
    local v114
    if p102 and p102.ProjectileType ~= nil then
        v114 = p102.ProjectileType
    else
        v114 = p_u_100.Info.ProjectileType
    end
    local v115
    if v114 then
        local v116
        if p102 and p102.ProjectileType ~= nil then
            v116 = p102.ProjectileType
        else
            v116 = p_u_100.Info.ProjectileType
        end
        if v116 == "RaycastProjectile" then
            v115 = p_u_100.ClientFighter:IsActuallyFirstPerson()
            if v115 then
                v115 = v_u_11:GetSetting("Projectile Smoothing")
            end
        else
            v115 = false
            local v117
            if p102 and p102.ProjectileType ~= nil then
                v117 = p102.ProjectileType
            else
                v117 = p_u_100.Info.ProjectileType
            end
            if v117 == "PhysicalProjectile" then
                local v118
                if p102 and p102.ProjectilePhysicalClientSided ~= nil then
                    v118 = p102.ProjectilePhysicalClientSided
                else
                    v118 = p_u_100.Info.ProjectilePhysicalClientSided
                end
                v115 = not v118
                if v115 then
                    v115 = p_u_100.ClientFighter:IsActuallyFirstPerson()
                    if v115 then
                        v115 = v_u_11:GetSetting("Projectile Smoothing")
                    end
                end
            end
        end
    else
        v115 = p_u_100.ClientFighter:IsActuallyFirstPerson()
        if v115 then
            v115 = v_u_11:GetSetting("Projectile Smoothing")
        end
    end
    local v119 = v_u_9.new(p_u_101.Position + (v115 and (-p_u_101.Velocity.Unit * 200 or Vector3.new(0, 0, 0)) or Vector3.new(0, 0, 0)), 1, 40)
    local v120 = CFrame.Angles(0, 0, math.random() * 3.141592653589793 * 2)
    local v121 = tick()
    local v122 = tick() + v109
    local v123 = Vector3.new(0, 0, 0)
    local v124 = 0
    local v125 = false
    local v126 = Vector3.new(0, 0, 0)
    local v127 = 0
    while not p_u_100._destroyed and tick() < v122 do
        if p_u_101:IsDescendantOf(workspace) then
            v122 = tick() + v109
            v119.Target = p_u_101.Position
        else
            v119.Target = v119.Target + v123 * v124
            if not v125 then
                v125 = true
                for _, v_u_128 in pairs(v104:GetDescendants()) do
                    if v_u_128:IsA("BasePart") or (v_u_128:IsA("Texture") or v_u_128:IsA("Decal")) then
                        v_u_128.LocalTransparencyModifier = 1
                    elseif v_u_128:IsA("Beam") or v_u_128:IsA("ParticleEmitter") then
                        v_u_128.Enabled = false
                    else
                        if not v_u_128:IsA("Light") then
                            continue
                        end
                        local v_u_129 = v_u_128.Brightness
                        task.spawn(v_u_8.RenderstepForLoop, v_u_8, 0, 100, 1, function(p130)
                            -- upvalues: (copy) v_u_128, (copy) v_u_129
                            v_u_128.Brightness = v_u_129 * (1 - p130 / 100)
                        end)
                    end
                end
            end
        end
        v127 = v127 + p_u_101.Velocity.Magnitude * v124 * 0.25
        local v131 = tick() - v121
        v119.Speed = math.clamp(v131, 0.01, 1) * 60 + 40
        if p_u_101.Velocity.Magnitude > 0.01 then
            v126 = p_u_101.Velocity or v126
        end
        local v132
        if v113 then
            v132 = CFrame.Angles(-v127, 0, 0)
        else
            v132 = CFrame.identity
        end
        if v126.Magnitude > 0.01 and p_u_100.Name ~= "Flare Gun" then
            v104:PivotTo(CFrame.new(v119.Position, v119.Position + v126) * v120 * v132)
        else
            v104:PivotTo(CFrame.new(v119.Position) * v120 * p_u_101.CFrame.Rotation * v132)
        end
        v123 = v126.Magnitude > v123.Magnitude and v126 and v126 or v123
        v124 = v_u_2.RenderStepped:Wait()
    end
    v104:SetAttribute("Destroying", true)
    v_u_7:AddItem(v104, v109)
end
function v_u_17._ResetReloadState(p133) -- name: _ResetReloadState
    p133._reload_cooldown = 0
    for _, v134 in pairs(p133._reload_threads) do
        local v135 = task.cancel
        pcall(v135, v134)
    end
    p133:StopCooldownEffect("Reload")
    p133.ViewModel:StopAnimation("Reload")
    p133.ViewModel:StopAnimation("EmptyReload")
    p133.ViewModel:StopAnimation("ReloadStart")
    p133.ViewModel:StopAnimation("ReloadSegment")
    p133.ViewModel:StopAnimation("ReloadFinish")
    p133.ViewModel:StopAnimation("EmptyReloadStart")
    p133.ViewModel:StopAnimation("EmptyReloadSegment")
    p133.ViewModel:StopAnimation("EmptyReloadFinish")
    for v136 = 2, p133.Info.NumReloadFiles do
        p133.ViewModel:StopAnimation("Reload" .. v136)
    end
end
function v_u_17._LocalTracers(p_u_137, p138, p139) -- name: _LocalTracers
    -- upvalues: (copy) v_u_6, (copy) v_u_4
    local v140 = p_u_137.ClientFighter:GetEntityLookupParams()
    local v141 = p_u_137.ClientFighter:Get("EnvironmentID")
    local v142 = p_u_137.ClientFighter:IsCrouching()
    local v143 = p_u_137.ClientFighter:GetRaycastWhitelist(true)
    local v_u_144 = {}
    for v145 = 1, p_u_137.Info.ShootPellets do
        local v146 = p139 and p_u_137.Info.QuickShotSpread or p_u_137.Info.ShootSpread
        local v147 = p_u_137.Info.ShootSpreadPerVelocityLimit
        local v148 = p_u_137.ClientFighter.Entity.RootPart.Velocity.Magnitude * p_u_137.Info.ShootSpreadPerVelocityUnit
        local v149 = v_u_6:GetSpread(v146 + math.min(v147, v148), p_u_137.Info.AimSpreadMultiplier, p138, v142, v145, p_u_137.Info.ShootPellets, p_u_137.Info.ShootSpreadConsistent)
        local v150 = p_u_137.ClientFighter:GetCameraData(v143, v149, true)
        local v151 = v150[utf8.char(0)]
        local v152 = v150[utf8.char(1)]
        local v153 = v150[utf8.char(2)]
        local v154 = v150[utf8.char(3)]
        local v155 = v153 and (v153.CFrame * v154).Position or (v152 * v149 * CFrame.new(0, 0, -v_u_4.MAX_RAYCAST_DISTANCE)).Position
        local v156 = v151.Position
        local v157 = (v155 - v156).Unit
        for v158 = 0, p_u_137.Info.RaycastBounceCount do
            if v157 ~= v157 then
                local v159 = {
                    ["Position"] = v156 + v157 * v_u_4.MAX_RAYCAST_DISTANCE
                }
                table.insert(v_u_144, v159)
                break
            end
            local _, v160 = v_u_6:GetEntitiesFromRaycast(v141, v140, v156, v157, v_u_4.MAX_RAYCAST_DISTANCE, nil, p_u_137.Info.RaycastPierceCount)
            local v161 = {
                ["Position"] = v160.Position
            }
            if v158 > 0 then
                v161.LastRaycastResult = v_u_144[#v_u_144]
                v161.StartPosition = v161.LastRaycastResult.Position
            end
            table.insert(v_u_144, v161)
            if not v160.Normal then
                break
            end
            v156 = v160.Position
            v157 = v_u_6:GetRaycastRedirection(v141, v140, v157 - 2 * v157:Dot(v160.Normal) * v160.Normal, v156, p_u_137.Info.RaycastBounceRedirectionAngle)
        end
    end
    local v162 = p_u_137._local_tracers
    table.insert(v162, v_u_144)
    task.delay(1, function()
        -- upvalues: (copy) p_u_137, (copy) v_u_144
        local v163 = table.find(p_u_137._local_tracers, v_u_144)
        if v163 then
            table.remove(p_u_137._local_tracers, v163)
        end
    end)
    p_u_137:_Tracers({
        ["RaycastResults"] = nil,
        ["IsEnemy"] = false,
        ["IsLocal"] = true,
        ["RaycastResults"] = v_u_144
    })
end
function v_u_17._CorrectLocalTracers(p164, p165) -- name: _CorrectLocalTracers
    local v166 = table.remove(p164._local_tracers, 1)
    if v166 then
        for v167, v168 in pairs(p165) do
            for v169, v170 in pairs(v168) do
                v166[v167][v169] = v170
            end
            v166[v167].StartPosition = v166[v167].CurrentTracerPosition
        end
    end
end
function v_u_17._Tracers(p171, p172, p173) -- name: _Tracers
    -- upvalues: (copy) v_u_15
    local v174 = {}
    local v175 = p171.ViewModel.GetFriendlyTracerColor
    if v175 then
        v175 = p171.ViewModel:GetFriendlyTracerColor()
    end
    v174.FriendlyTracerColor = v175
    v174.ActuallyFirstPerson = p171.ClientFighter:IsActuallyFirstPerson()
    v174.MuzzlePosition = p171.ViewModel:GetMuzzlePosition()
    local v176, v177, v178 = v_u_15:VerifyTracerData(p172, p173, v174)
    if p171.ViewModel.CustomTracers then
        return p171.ViewModel:CustomTracers(v176, v177, v178)
    end
    v_u_15:Play(v176, v177, v178)
end
function v_u_17._ShootEffect(p179, p180) -- name: _ShootEffect
    -- upvalues: (copy) v_u_3
    local v181 = {}
    for v182, v183 in pairs(p180) do
        v181[utf8.codepoint(v182) + 1] = {
            ["Position"] = v183[utf8.char(0)] or nil,
            ["Instance"] = v183[utf8.char(1)] or nil,
            ["Normal"] = v183[utf8.char(2)] or nil,
            ["LastRaycastIndex"] = v183[utf8.char(3)] and utf8.codepoint(v183[utf8.char(3)]) + 1 or nil
        }
    end
    for _, v184 in pairs(v181) do
        local v185
        if v184.LastRaycastIndex then
            v185 = v181[v184.LastRaycastIndex] or nil
        else
            v185 = nil
        end
        v184.LastRaycastResult = v185
        v184.LastRaycastIndex = nil
        local v186
        if v184.LastRaycastResult then
            v186 = v184.LastRaycastResult.Position or nil
        else
            v186 = nil
        end
        v184.StartPosition = v186
    end
    if not p179.ClientFighter.IsLocalPlayer or #p179._local_tracers <= 0 then
        p179:_Tracers({
            ["RaycastResults"] = v181,
            ["IsEnemy"] = v_u_3.LocalPlayer:GetAttribute("TeamID") ~= p179.ClientFighter.Player:GetAttribute("TeamID"),
            ["IsLocal"] = p179.ClientFighter.IsLocalPlayer
        })
    end
    p179:_TryImpactMarkers(v181)
end
function v_u_17._CheckReload(p187) -- name: _CheckReload
    if p187:Get("Ammo") <= 0 then
        if p187.Name == "Daggers" then
            p187._reload_delay = tick() + 0.2
            wait(0.2)
        end
        p187:SimulateInputFromGameplayMechanic("StartReloading")
    end
end
function v_u_17._Init(p_u_188) -- name: _Init
    p_u_188:GetDataChangedSignal("Ammo"):Connect(function()
        -- upvalues: (copy) p_u_188
        p_u_188._shot_but_ammo_hasnt_updated = false
        p_u_188:_CheckReload()
    end)
    p_u_188:GetDataChangedSignal("AmmoReserve"):Connect(function()
        -- upvalues: (copy) p_u_188
        p_u_188:_CheckReload()
    end)
    p_u_188.ViewModel.AnimationPlayed:Connect(function(p189)
        -- upvalues: (copy) p_u_188
        if (p189 == p_u_188.ViewModel.Animator:GetInspectAnimationKey() or p189 == p_u_188.ViewModel.Animator:GetRareInspectAnimationKey()) and p_u_188._last_shoot_animation_name then
            p_u_188.ViewModel:StopAnimation(p_u_188._last_shoot_animation_name, 0)
        end
    end)
    local v190 = p_u_188._connections
    local v191 = p_u_188.ClientFighter.Interrupted
    table.insert(v190, v191:Connect(function()
        -- upvalues: (copy) p_u_188
        p_u_188:_ResetReloadState()
        p_u_188:SimulateInputFromGameplayMechanic("FinishAiming", true)
    end))
    p_u_188:ChangeShootAnimationNamePrefix("Shoot")
end
return v_u_17
