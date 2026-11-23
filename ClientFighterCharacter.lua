-- Script Path: game:GetService("StarterPlayer").StarterPlayerScripts.Modules.ClientReplicatedClasses.ClientFighter.ClientFighterCharacter
-- Took 0s to decompile.

local v1 = game:GetService("ReplicatedStorage")
local v2 = game:GetService("Players")
local v_u_3 = require(v1.Modules.CONSTANTS)
local v_u_4 = require(v1.Modules.Utility)
local v_u_5 = require(v1.Modules.Signal)
local v_u_6 = require(v2.LocalPlayer.PlayerScripts.Modules.ClientReplicatedClasses.ClientEntity.ClientHumanoidEntity)
local v_u_7 = require(script:WaitForChild("ChatBubbleMover"))
local v_u_8 = require(script:WaitForChild("CustomNametag"))
local v_u_9 = require(script:WaitForChild("Animations"))
local v_u_10 = require(script:WaitForChild("Flashlight"))
local v_u_11 = require(script:WaitForChild("Visibility"))
local v_u_12 = require(script:WaitForChild("Airborne"))
local v_u_13 = require(script:WaitForChild("Gameplay"))
local v_u_14 = require(script:WaitForChild("Snowball"))
local v_u_15 = require(script:WaitForChild("Visuals"))
local v_u_16 = require(script:WaitForChild("Avatar"))
local v_u_17 = require(script:WaitForChild("Boosts"))
local v_u_18 = require(script:WaitForChild("Sounds"))
local v_u_19 = require(script:WaitForChild("Joints"))
local v_u_20 = require(script:WaitForChild("State"))
local v_u_21 = require(script:WaitForChild("Arms"))
local v_u_22 = setmetatable({}, v_u_6)
v_u_22.__index = v_u_22
function v_u_22.new(p23, p24) -- name: new
    -- upvalues: (copy) v_u_6, (copy) v_u_22, (copy) v_u_5, (copy) v_u_20, (copy) v_u_7, (copy) v_u_8, (copy) v_u_9, (copy) v_u_10, (copy) v_u_11, (copy) v_u_12, (copy) v_u_13, (copy) v_u_14, (copy) v_u_15, (copy) v_u_16, (copy) v_u_17, (copy) v_u_18, (copy) v_u_19, (copy) v_u_21
    local v25 = v_u_6.new(p23)
    local v26 = v_u_22
    local v27 = setmetatable(v25, v26)
    v27.EnteredWorld = v_u_5.new()
    v27.BoostsChanged = v_u_5.new()
    v27.AirborneChanged = v_u_5.new()
    v27.RedirectSliding = v_u_5.new()
    v27.ClientFighter = p24
    v27.Player = p23.Player
    v27.Head = nil
    v27.State = v_u_20.new(v27)
    v27.ChatBubbleMover = v_u_7.new(v27)
    v27.CustomNametag = v_u_8.new(v27)
    v27.Animations = v_u_9.new(v27)
    v27.Flashlight = v_u_10.new(v27)
    v27.Visibility = v_u_11.new(v27)
    v27.Airborne = v_u_12.new(v27)
    v27.Gameplay = v_u_13.new(v27)
    v27.Snowball = v_u_14.new(v27)
    v27.Visuals = v_u_15.new(v27)
    v27.Avatar = v_u_16.new(v27)
    v27.Boosts = v_u_17.new(v27)
    v27.Sounds = v_u_18.new(v27)
    v27.Joints = v_u_19.new(v27)
    v27.Arms = v_u_21.new(v27)
    v27._destroyed = false
    v27._is_in_world = false
    v27:_Init()
    return v27
end
function v_u_22.IsRendered(p28) -- name: IsRendered
    -- upvalues: (copy) v_u_6
    local v29 = v_u_6.IsRendered(p28)
    if v29 then
        v29 = not p28.ClientFighter:Get("IsHiddenByEmotes")
    end
    return v29
end
function v_u_22.IsAlive(p30, ...) -- name: IsAlive
    return p30.State:IsAliveCached(...)
end
function v_u_22.IsGrounded(p31, ...) -- name: IsGrounded
    return p31.State:IsGroundedCached(...)
end
function v_u_22.IsAirborne(p32, ...) -- name: IsAirborne
    return p32.Airborne:IsActive(...)
end
function v_u_22.GetBoostByName(p33, ...) -- name: GetBoostByName
    return p33.Boosts:GetBoostByName(...)
end
function v_u_22.GetBoost(p34, ...) -- name: GetBoost
    return p34.Boosts:GetBoost(...)
end
function v_u_22.GetFOVOffset(p35, ...) -- name: GetFOVOffset
    return p35.Gameplay:GetFOVOffset(...)
end
function v_u_22.IsInWorld(p36) -- name: IsInWorld
    return p36._is_in_world
end
function v_u_22.GetClampedVelocity(p37) -- name: GetClampedVelocity
    -- upvalues: (copy) v_u_3
    if not p37.RootPart then
        return Vector3.new(0, 0, 0)
    end
    local v38 = p37.RootPart.Velocity.Magnitude <= 0.01 and p37.RootPart.Velocity
    if not v38 then
        local v39 = p37.RootPart.Velocity.Unit
        local v40 = p37.RootPart.Velocity.Magnitude
        local v41 = v_u_3.BASE_WALKSPEED * 2.5
        v38 = v39 * math.clamp(v40, 0, v41)
    end
    return v38
end
function v_u_22.GetFloor(p42, p43) -- name: GetFloor
    -- upvalues: (copy) v_u_4
    local v44 = v_u_4:Raycast(p42.RootPart.Position, p42.RootPart.Position - Vector3.new(0, 1, 0), p43 or 3.5 * p42.RootPart.Size.Z, p42.ClientFighter:GetRaycastWhitelist(), Enum.RaycastFilterType.Include)
    return v44.Instance, v44
end
function v_u_22.GetArmsData(p45) -- name: GetArmsData
    -- upvalues: (copy) v_u_4
    return v_u_4:GetArmsData(p45.Model)
end
function v_u_22.WaitUntilIsInWorld(p46) -- name: WaitUntilIsInWorld
    if not p46._is_in_world then
        p46.EnteredWorld:Wait()
    end
end
function v_u_22.HardDash(p47, ...) -- name: HardDash
    return p47.Gameplay:HardDash(...)
end
function v_u_22.WarpTo(p48, ...) -- name: WarpTo
    return p48.Gameplay:WarpTo(...)
end
function v_u_22.SetRedFigureMode(p49, ...) -- name: SetRedFigureMode
    return p49.Visuals:SetRedFigureMode(...)
end
function v_u_22.AirborneRedirect(p50, ...) -- name: AirborneRedirect
    return p50.Airborne:Redirect(...)
end
function v_u_22.AirborneTrigger(p51, ...) -- name: AirborneTrigger
    return p51.Airborne:Trigger(...)
end
function v_u_22.AirborneCancel(p52, ...) -- name: AirborneCancel
    return p52.Airborne:Cancel(...)
end
function v_u_22.SetHitboxesVisible(p53, ...) -- name: SetHitboxesVisible
    return p53.Visibility:SetHitboxesVisible(...)
end
function v_u_22.CloneModel(p54, ...) -- name: CloneModel
    return p54.Visibility:CloneModel(...)
end
function v_u_22.SetTranslucent(p55, ...) -- name: SetTranslucent
    return p55.Visibility:SetTranslucent(...)
end
function v_u_22.SetBoost(p56, ...) -- name: SetBoost
    return p56.Boosts:SetBoost(...)
end
function v_u_22.RemoveBoost(p57, ...) -- name: RemoveBoost
    return p57.Boosts:RemoveBoost(...)
end
function v_u_22.SetIKControlTargetItem(p58, ...) -- name: SetIKControlTargetItem
    return p58.Arms:SetIKControlTargetItem(...)
end
function v_u_22.DisableIKArms(p59, ...) -- name: DisableIKArms
    return p59.Arms:DisableIKArms(...)
end
function v_u_22.PlaySlidingAnimationAsync(p60, ...) -- name: PlaySlidingAnimationAsync
    return p60.Animations:PlaySlidingAnimationAsync(...)
end
function v_u_22.StopSlidingAnimation(p61, ...) -- name: StopSlidingAnimation
    return p61.Animations:StopSlidingAnimation(...)
end
function v_u_22.AddConnection(p62, p63) -- name: AddConnection
    local v64 = p62._connections
    table.insert(v64, p63)
end
function v_u_22.Update(p65, p66, p67) -- name: Update
    p65.State:Update(p66, p67)
    p65.Sounds:Update(p66, p67)
    p65.ChatBubbleMover:Update(p66, p67)
    p65.CustomNametag:Update(p66, p67)
    p65.Animations:Update(p66, p67)
    p65.Flashlight:Update(p66, p67)
    p65.Airborne:Update(p66, p67)
    p65.Snowball:Update(p66, p67)
    p65.Visuals:Update(p66, p67)
    p65.Boosts:Update(p66, p67)
    p65.Joints:Update(p66, p67)
    p65.Arms:Update(p66, p67)
end
function v_u_22.ReplicateFromServer(p68, p69, ...) -- name: ReplicateFromServer
    -- upvalues: (copy) v_u_6
    if p69 == "HurtEffect" then
        if p68:IsRendered() then
            p68.Visuals:HurtEffect(...)
            p68:_HurtEffect(...)
        end
    else
        if p69 == "HealEffect" then
            if not p68:IsRendered() then
                return
            end
            if p68.ClientFighter.FighterInterface then
                p68.ClientFighter.FighterInterface:HealEffect(...)
                return
            end
        else
            if p69 == "BlindedEffect" then
                if p68:IsRendered() and not p68.ClientFighter:Get("IsSpectating") then
                    p68.Visuals:BlindedEffect(...)
                end
            end
            if p69 == "KnockbackEffect" then
                p68.Airborne:FromServer(...)
                return
            end
            if p69 == "CancelKnockbackEffect" then
                p68.Airborne:Cancel(...)
                p68.ClientFighter.StopSliding:Fire()
                return
            end
            if p69 == "SetBoost" then
                p68:SetBoost(...)
                return
            end
            if p69 == "ThrowSnowball" then
                p68.Snowball:ThrowSnowball(...)
                return
            end
            if p69 == "WarpTo" then
                p68:WarpTo(...)
                return
            end
            v_u_6.ReplicateFromServer(p68, p69, ...)
        end
        return
    end
end
function v_u_22.Destroy(p70) -- name: Destroy
    -- upvalues: (copy) v_u_6
    p70._destroyed = true
    p70.EnteredWorld:Destroy()
    p70.BoostsChanged:Destroy()
    p70.AirborneChanged:Destroy()
    p70.RedirectSliding:Destroy()
    p70.State:Destroy()
    p70.ChatBubbleMover:Destroy()
    p70.CustomNametag:Destroy()
    p70.Animations:Destroy()
    p70.Flashlight:Destroy()
    p70.Visibility:Destroy()
    p70.Airborne:Destroy()
    p70.Gameplay:Destroy()
    p70.Snowball:Destroy()
    p70.Visuals:Destroy()
    p70.Avatar:Destroy()
    p70.Boosts:Destroy()
    p70.Sounds:Destroy()
    p70.Joints:Destroy()
    p70.Arms:Destroy()
    v_u_6.Destroy(p70)
end
function v_u_22._SetupAsync(p71) -- name: _SetupAsync
    while not p71.Model:IsDescendantOf(workspace) do
        p71.Model.AncestryChanged:Wait()
    end
    if p71._destroyed then
        return
    else
        p71.Head = p71.Model:WaitForChild("Head")
        if not p71._destroyed then
            p71._is_in_world = true
            p71.EnteredWorld:Fire()
        end
    end
end
function v_u_22._Init(p_u_72) -- name: _Init
    p_u_72.Boosts.BoostsChanged:Connect(function(...)
        -- upvalues: (copy) p_u_72
        p_u_72.BoostsChanged:Fire(...)
    end)
    p_u_72.Airborne.AirborneChanged:Connect(function(...)
        -- upvalues: (copy) p_u_72
        p_u_72.AirborneChanged:Fire(...)
    end)
    p_u_72.Gameplay.RedirectSliding:Connect(function(...)
        -- upvalues: (copy) p_u_72
        p_u_72.RedirectSliding:Fire(...)
    end)
    task.spawn(p_u_72._SetupAsync, p_u_72)
end
return v_u_22
