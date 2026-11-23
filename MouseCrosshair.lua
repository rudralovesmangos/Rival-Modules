-- Script Path: game:GetService("Players").royvolex.PlayerScripts.Modules.ClientReplicatedClasses.Enemies.ClientFighter.ClientItem.ItemInterface.Mouse.MouseCrosshair
-- Took 0.01s to decompile.

local v1 = game:GetService("ReplicatedStorage")
local v2 = game:GetService("Players")
local v_u_3 = require(v1.Modules.CONSTANTS)
local v_u_4 = require(v1.Modules.SettingsLibrary)
local v_u_5 = require(v1.Modules.Spring)
local v_u_6 = require(v2.LocalPlayer.PlayerScripts.Controllers.PlayerDataController)
local v_u_7 = require(v2.LocalPlayer.PlayerScripts.Modules.Crosshair)
local v_u_8 = {}
v_u_8.__index = v_u_8
function v_u_8.new(p9) -- name: new
    -- upvalues: (copy) v_u_8, (copy) v_u_7, (copy) v_u_5
    local v10 = v_u_8
    local v11 = setmetatable({}, v10)
    v11.Mouse = p9
    v11.Crosshair = v_u_7.new()
    v11._crouch_spring = v_u_5.new(0, 0.875, 20)
    v11._speed_spring = v_u_5.new(0, 0.875, 20)
    v11._jump_spring = v_u_5.new(0, 0.875, 20)
    v11._hitmarker_spring = v_u_5.new(1, 1, 20)
    v11._hitmarker_rotation = 0
    v11._last_damage_dealt_time = 0
    v11:_Init()
    return v11
end
function v_u_8.Refresh(p12) -- name: Refresh
    -- upvalues: (copy) v_u_4, (copy) v_u_6
    if p12.Mouse.ItemInterface.ClientItem.ClientFighter.IsLocalPlayer then
        p12.Crosshair:SetAppearance(v_u_4:GenerateCrosshairAppearance(v_u_6))
        p12.Mouse:Refresh()
    else
        local v13 = p12.Mouse.ItemInterface.ClientItem.ClientFighter:Get("CompressedCrosshairAppearance")
        if v13 then
            p12.Crosshair:SetAppearance(v_u_4:DecodeCrosshairAppearance(v13))
            p12.Mouse:Refresh()
        end
    end
end
function v_u_8.DamageEffect(p14, p15, p16) -- name: DamageEffect
    if p15[utf8.char(0)] ~= 0 then
        local v17 = math.random() - 0.5
        p14._hitmarker_rotation = math.sign(v17) * 15
        p14._hitmarker_spring.Value = 0
        p14._last_damage_dealt_time = tick()
        p14.Crosshair:SetHitmarkerColor(p15[utf8.char(1)])
        p14.Mouse.ItemInterface.ClientItem.ViewModel:PlayHitmarkerSound(p16, p15[utf8.char(1)], p15[utf8.char(4)])
    end
end
function v_u_8.Update(p18, _, p19, _) -- name: Update
    -- upvalues: (copy) v_u_3
    if p18.Crosshair.Info.DotEnabled or p18.Crosshair.Info.BarsEnabled then
        local v20 = p18.Mouse.ItemInterface.ClientItem.ViewModel.CurrentAimValue
        local v21 = p18.Mouse.ItemInterface.ClientItem.ViewModel.CurrentRecoilValue
        local v22 = p18.Mouse.ItemInterface.ClientItem.ViewModel.CurrentInspectValue
        local v23 = p18.Mouse.ItemInterface.ClientItem.Info.ShootAccuracy or 1
        local v24 = p18.Mouse.ItemInterface.ClientItem.ViewModel:IsAimingAnimationEnabled()
        p18._speed_spring.Target = p19.MoveSpeed > 4 and (p19.MoveSpeed or 0) or 0
        p18._jump_spring.Target = p19.IsGrounded and 0 or 1
        p18._crouch_spring.Target = p19.IsCrouching and 0.25 or 1
        for _, v25 in pairs({ p18._speed_spring, p18._jump_spring, p18._crouch_spring }) do
            v25.Value = v25.Target > v25.Value and v25.Target or v25.Value
        end
        local v26 = p18._crouch_spring.Value
        local v27 = p18._speed_spring.Value * 0.75
        local v28 = p18._jump_spring.Value
        local v29 = not p18.Mouse.Scope:IsActive() and p18.Crosshair:ShowWhileAiming() and 1 or 1 - v20
        local v30 = (p18.Crosshair:GetAppearanceSpacing() + 8 * (v27 / v_u_3.BASE_WALKSPEED) ^ 2 + 32 * v28 + 100 * v21.Magnitude / v23) * v26 / v23
        local v31 = p19.IsFirstPerson and (p18.Mouse.ItemInterface.ClientItem.Name ~= "Minigun" and v24) and (1 - v29 or 0) or 0
        local v32 = v31 + (1 - v31) * (p18.Crosshair:ShowWhileInspecting() and 0 or v22)
        p18.Crosshair:SetSpacing(v30, v29)
        p18.Crosshair:SetTransparency(v32)
    end
    local v33 = p18._hitmarker_spring.Value
    local v34 = 32 + -26 * v33
    local v35 = 16 + -8 * v33
    local v36 = UDim2.new(0, v35, 0, v35)
    local v37 = (tick() - p18._last_damage_dealt_time) / 2
    local v38 = math.min(1, v37) ^ 10
    local v39 = (1 - v33) * p18._hitmarker_rotation
    p18.Crosshair:SetHitmarkerVisuals(v34, v36, v38, v39)
end
function v_u_8.Destroy(p40) -- name: Destroy
    p40.Crosshair:Destroy()
end
function v_u_8._Setup(p41) -- name: _Setup
    p41.Crosshair:SetType(p41.Mouse.ItemInterface.ClientItem.Info.CrosshairType)
    p41.Crosshair:SetParent(p41.Mouse.Frame)
end
function v_u_8._Init(p42) -- name: _Init
    p42:_Setup()
end
return v_u_8
