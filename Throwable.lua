-- Script Path: game:GetService("StarterPlayer").StarterPlayerScripts.Modules.ItemTypes.Throwable
-- Took 0.01s to decompile.

local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("RunService")
local v3 = game:GetService("Players")
local v_u_4 = require(v1.Modules.AnimationLibrary)
local v_u_5 = require(v1.Modules.BetterDebris)
local v_u_6 = require(v1.Modules.Utility)
local v_u_7 = require(v1.Modules.Spring)
local v_u_8 = require(v1.Modules.Signal)
local v_u_9 = require(v3.LocalPlayer.PlayerScripts.Controllers.WrapController)
local v_u_10 = require(v3.LocalPlayer.PlayerScripts.Modules.ClientReplicatedClasses.ClientFighter.ClientItem)
local v_u_11 = require(v3.LocalPlayer.PlayerScripts.Modules.TrajectoryVisual)
local v_u_12 = v3.LocalPlayer.PlayerScripts.Assets:WaitForChild("Throwables")
local v_u_13 = CFrame.new(0.75, -0.5, 0)
local v_u_14 = setmetatable({}, v_u_10)
v_u_14.__index = v_u_14
function v_u_14.new(...) -- name: new
    -- upvalues: (copy) v_u_10, (copy) v_u_14, (copy) v_u_8
    local v15 = v_u_10.new(...)
    local v16 = v_u_14
    local v17 = setmetatable(v15, v16)
    v17.ProjectileThrown = v_u_8.new()
    v17._is_throwing = nil
    v17._throw_type = nil
    v17._throw_cooldown = 0
    v17._throw_hash = 0
    v17._trajectory_visual = nil
    local v18 = v17.Info.CanCook
    if v18 then
        v18 = v17.Info.DetonateDelay
    end
    v17._cook_detonate_delay = v18
    v17._throwable_part_to_model = {}
    v17:_Init()
    return v17
end
function v_u_14.CanQuickAttack(p19) -- name: CanQuickAttack
    local v20 = not p19._is_throwing
    if v20 then
        if tick() > p19._throw_cooldown and (p19:Get("Ammo") or (1 / 0)) > 0 then
            v20 = not p19:IsEquipping()
        else
            v20 = false
        end
    end
    return v20
end
function v_u_14.StartShooting(p21, p22) -- name: StartShooting
    if not p22 and (p21._is_throwing or (tick() < p21._throw_cooldown or ((p21:Get("Ammo") or (1 / 0)) <= 0 or p21:IsEquipping()))) then
        return false
    end
    p21._throw_type = "Throw"
    p21:_StartThrow("ThrowStart", "ThrowIdle", p21.Info.ThrowMaxChargeTime, p21.Info.ThrowForceMin, p21.Info.ThrowForceMax, p21.Info.ThrowGravity, "FinishShooting")
    return true, "StartShooting"
end
function v_u_14.FinishShooting(p23, p24) -- name: FinishShooting
    if p24 or p23._is_throwing and (tick() >= p23._throw_cooldown and ((p23:Get("Ammo") or (1 / 0)) > 0 and p23._throw_type == "Throw")) then
        p23._throw_type = nil
        local v25, v26 = p23:_FinishThrow("ThrowStart", "ThrowIdle", "ThrowFinish", p23.Info.ThrowMaxChargeTime)
        if v25 then
            return true, "FinishShooting", p23:_GetThrowCameraCFrame(), v25, v26
        else
            return false
        end
    else
        return false
    end
end
function v_u_14.StartAiming(p27, p28) -- name: StartAiming
    if not p28 and (p27._is_throwing or (tick() < p27._throw_cooldown or ((p27:Get("Ammo") or (1 / 0)) <= 0 or p27:IsEquipping()))) then
        return false
    end
    p27._throw_type = "Lob"
    p27:_StartThrow("LobStart", "LobIdle", p27.Info.LobMaxChargeTime, p27.Info.LobForceMin, p27.Info.LobForceMax, p27.Info.LobGravity, "FinishAiming")
    return true, "StartAiming"
end
function v_u_14.FinishAiming(p29, p30) -- name: FinishAiming
    if p30 or p29._is_throwing and (tick() >= p29._throw_cooldown and ((p29:Get("Ammo") or (1 / 0)) > 0 and p29._throw_type == "Lob")) then
        p29._throw_type = nil
        local v31, v32 = p29:_FinishThrow("LobStart", "LobIdle", "LobFinish", p29.Info.LobMaxChargeTime)
        if v31 then
            return true, "FinishAiming", p29:_GetThrowCameraCFrame(), v31, v32
        else
            return false
        end
    else
        return false
    end
end
function v_u_14.Unequip(p33, ...) -- name: Unequip
    -- upvalues: (copy) v_u_10
    p33:_CancelThrow()
    v_u_10.Unequip(p33, ...)
end
function v_u_14.ReplicateFromServer(p_u_34, p35, ...) -- name: ReplicateFromServer
    -- upvalues: (copy) v_u_12, (copy) v_u_5, (copy) v_u_9, (copy) v_u_7, (copy) v_u_2, (copy) v_u_10
    if p35 == "ThrowEffect" then
        if p_u_34:IsRendered() then
            local v_u_36 = ...
            if v_u_36 then
                v_u_36.Transparency = 1
                v_u_36.CanCollide = false
                local v_u_37 = (v_u_12:FindFirstChild(p_u_34.ViewModel.Name) or v_u_12[p_u_34.Name]):Clone()
                v_u_37.WorldPivot = v_u_37.Primary.CFrame
                v_u_37.Parent = workspace
                p_u_34._throwable_part_to_model[v_u_36] = v_u_37
                v_u_5:AddItem(v_u_37, p_u_34.Info.Lifetime + 10)
                v_u_9:ApplyWrap(v_u_9:RecordOriginalWrapProperties(v_u_37), p_u_34:GetWrap(), true)
                v_u_36.Destroying:Connect(function()
                    -- upvalues: (copy) p_u_34, (copy) v_u_36
                    p_u_34._throwable_part_to_model[v_u_36] = nil
                end)
                for _, v38 in pairs(v_u_37:GetDescendants()) do
                    if not v38:IsA("BasePart") then
                        continue
                    end
                    v38.CanCollide = false
                    v38.CanTouch = false
                    v38.CanQuery = false
                    v38.Anchored = true
                end
                p_u_34.ProjectileThrown:Fire(v_u_36, v_u_37)
                task.defer(function()
                    -- upvalues: (copy) p_u_34, (ref) v_u_7, (copy) v_u_36, (copy) v_u_37, (ref) v_u_2, (ref) v_u_5
                    local v39 = p_u_34.ClientFighter:IsActuallyFirstPerson()
                    local v40 = v_u_7.new(v_u_36.Position + (v39 and -v_u_36.Velocity.Unit * 200 or Vector3.new(0, 0, 0)), 1, 40)
                    local v41 = CFrame.Angles(math.random() * 3.141592653589793 * 2, math.random() * 3.141592653589793 * 2, math.random() * 3.141592653589793 * 2)
                    local v42 = tick()
                    local v43 = 0
                    local v44 = 0
                    local v45 = nil
                    local v_u_46 = nil
                    local v_u_47 = nil
                    local function v48() -- name: update_throwable_orientation
                        -- upvalues: (ref) v_u_47, (ref) v_u_36, (ref) v_u_46
                        v_u_47 = v_u_36:GetAttribute("ThrowableOrientation")
                        v_u_46 = v_u_36:GetAttribute("ThrowableRotateYAxis")
                    end
                    v_u_36:GetAttributeChangedSignal("ThrowableOrientation"):Connect(v48)
                    v_u_36:GetAttributeChangedSignal("ThrowableRotateYAxis"):Connect(v48)
                    v_u_47 = v_u_36:GetAttribute("ThrowableOrientation")
                    v_u_46 = v_u_36:GetAttribute("ThrowableRotateYAxis")
                    local v49 = v_u_47
                    local v50 = v_u_46
                    while v_u_36:IsDescendantOf(workspace) do
                        local v51 = (tick() - v42) * 1.5
                        local v52 = math.clamp(v51, 0.01, 1)
                        v40.Speed = v52 * 60 + 40
                        v40.Target = v_u_36.Position - workspace.CurrentCamera.CFrame.UpVector * (1 - v52) * 0.5
                        v43 = v43 + v_u_36.Velocity.Magnitude * v44 * 0.25
                        v45 = v_u_36.Velocity.Magnitude > 0.01 and CFrame.new(v40.Position, v40.Position + v_u_36.Velocity) or CFrame.new(v40.Position) * (v45 and v45.Rotation or CFrame.identity)
                        local v53
                        if v50 then
                            v53 = v45 * CFrame.Angles(0, -v43, 0)
                        else
                            v53 = v45 * (v41 * CFrame.Angles(-v43, 0, 0))
                        end
                        if v49 then
                            v53 = CFrame.new(v53.Position) * v49.Rotation
                        end
                        if p_u_34.ViewModel.Name == "Skullbang" and not v53.Position:FuzzyEq(workspace.CurrentCamera.CFrame.Position) then
                            local v54 = CFrame.new(v53.Position, workspace.CurrentCamera.CFrame.Position)
                            local v55 = 1.25 * (tick() - v42) / p_u_34.Info.DetonateDelay
                            v53 = v53:Lerp(v54, (math.min(1, v55)))
                        end
                        v_u_37:ScaleTo(v52 * 1.5)
                        v_u_37:PivotTo(v53)
                        v44 = v_u_2.RenderStepped:Wait()
                    end
                    local v56 = 0
                    for _, v57 in pairs(v_u_37:GetDescendants()) do
                        if v57:IsA("BasePart") or (v57:IsA("Texture") or (v57:IsA("Beam") or v57:IsA("Decal"))) then
                            v57.LocalTransparencyModifier = 1
                        elseif v57:IsA("ParticleEmitter") then
                            v57.Enabled = false
                        else
                            if not v57:IsA("Trail") then
                                continue
                            end
                            local v58 = v57.Lifetime
                            v56 = math.max(v56, v58)
                        end
                    end
                    v_u_5:AddItem(v_u_37, v56)
                end)
            end
        else
            return
        end
    else
        v_u_10.ReplicateFromServer(p_u_34, p35, ...)
        return
    end
end
function v_u_14.Destroy(p59) -- name: Destroy
    -- upvalues: (copy) v_u_10
    p59.ProjectileThrown:Destroy()
    p59:_ClearTrajectoryVisual()
    for _, v60 in pairs(p59._throwable_part_to_model) do
        v60:Destroy()
    end
    v_u_10.Destroy(p59)
end
function v_u_14._CancelThrow(p61) -- name: _CancelThrow
    p61:_ClearTrajectoryVisual()
    if p61._is_throwing then
        p61._throw_type = nil
        p61._is_throwing = nil
        p61._throw_hash = p61._throw_hash + 1
    end
    p61.ViewModel:StopAnimation("ThrowStart")
    p61.ViewModel:StopAnimation("ThrowIdle")
    p61.ViewModel:StopAnimation("ThrowFinish")
    p61.ViewModel:StopAnimation("LobStart")
    p61.ViewModel:StopAnimation("LobIdle")
    p61.ViewModel:StopAnimation("LobFinish", nil, 0)
end
function v_u_14._FinishThrow(p62, p63, p64, p65, p66) -- name: _FinishThrow
    -- upvalues: (copy) v_u_4
    p62:_ClearTrajectoryVisual()
    local v67 = p62._is_throwing
    if v67 then
        local v68 = (tick() - p62._is_throwing) / p66
        v67 = math.clamp(v68, 0, 1)
    end
    local v69 = p62._is_throwing
    if v69 then
        v69 = p62._cook_detonate_delay and p62._is_throwing + (p62._cook_detonate_delay or 0) - tick() or p62.Info.DetonateDelay
    end
    p62._is_throwing = nil
    p62._throw_cooldown = p62.Info.Cooldown and (tick() + p62.Info.Cooldown or 0) or 0
    p62._throw_hash = p62._throw_hash + 1
    p62.ViewModel:StopAnimation(p63, nil, 0)
    p62.ViewModel:StopAnimation(p64, nil, 0)
    if not p62._cook_detonate_delay or (not v69 or v69 > 0) then
        p62.ViewModel:PlayAnimation(p65, v_u_4.Info[p62.ViewModel.Info.Animations[p65]].Length)
    end
    if p62.Info.Cooldown then
        p62:CooldownEffect("rbxassetid://17156089790", p62.Info.Cooldown, "Throw")
    end
    return v67, v69
end
function v_u_14._StartThrow(p_u_70, p_u_71, p_u_72, p73, p74, p75, p76, p_u_77) -- name: _StartThrow
    -- upvalues: (copy) v_u_4
    p_u_70._is_throwing = tick()
    p_u_70._throw_hash = p_u_70._throw_hash + 1
    p_u_70.ViewModel:StopAnimation("Equip")
    p_u_70.ViewModel:PlayAnimation(p_u_71, (1 / 0))
    if p_u_70.ClientFighter.IsLocalPlayer then
        p_u_70:_CreateTractoryVisual(p73, p74, p75, p76)
    end
    local v_u_78 = p_u_70._throw_hash
    task.spawn(function()
        -- upvalues: (ref) v_u_4, (copy) p_u_70, (copy) p_u_71, (copy) v_u_78, (copy) p_u_72
        wait(v_u_4.Info[p_u_70.ViewModel.Info.Animations[p_u_71]].Length or 0.1)
        if v_u_78 == p_u_70._throw_hash then
            p_u_70.ViewModel:PlayAnimation(p_u_72, nil, 0)
        end
    end)
    if p_u_70._cook_detonate_delay then
        task.delay(p_u_70._cook_detonate_delay, function()
            -- upvalues: (copy) v_u_78, (copy) p_u_70, (copy) p_u_77
            if v_u_78 == p_u_70._throw_hash then
                p_u_70:SimulateInputFromGameplayMechanic(p_u_77, true)
            end
        end)
    end
end
function v_u_14._GetThrowCameraCFrame(p79, p80, p81, p82) -- name: _GetThrowCameraCFrame
    -- upvalues: (copy) v_u_6, (copy) v_u_13
    local v83 = p79.ClientFighter:GetCameraData(p80, p81, true)
    local v84 = v83[utf8.char(0)]
    local v85 = v83[utf8.char(1)]
    local v86 = v83[utf8.char(2)]
    local v87 = v83[utf8.char(3)]
    if v86 then
        v86 = v86.CFrame * (v87 or CFrame.identity)
    end
    if v86 then
        v85 = CFrame.new(v85.Position, v86.Position) or v85
    end
    local v88 = v_u_6:Raycast(v85.Position, v85.Position + v85.LookVector * 999, 999, p80, Enum.RaycastFilterType.Include)
    local v89 = CFrame.new(v84.Position, v88.Position) * v_u_13
    if p82 then
        return v89
    else
        return v_u_6:EncodeCFrame(v89)
    end
end
function v_u_14._ClearTrajectoryVisual(p90) -- name: _ClearTrajectoryVisual
    if p90._trajectory_visual then
        p90._trajectory_visual:Destroy()
        p90._trajectory_visual = nil
    end
end
function v_u_14._CreateTractoryVisual(p_u_91, p_u_92, p_u_93, p_u_94, p_u_95) -- name: _CreateTractoryVisual
    -- upvalues: (copy) v_u_11
    p_u_91:_ClearTrajectoryVisual()
    local v_u_96 = p_u_91.ClientFighter:GetRaycastWhitelist(true)
    p_u_91._trajectory_visual = v_u_11.new()
    p_u_91._trajectory_visual:OnStep(function()
        -- upvalues: (copy) p_u_91, (copy) v_u_96, (copy) p_u_92, (copy) p_u_93, (copy) p_u_94, (copy) p_u_95
        local v97 = p_u_91:_GetThrowCameraCFrame(v_u_96, nil, true)
        local v98 = (tick() - (p_u_91._is_throwing or p_u_91._is_lobbing)) / p_u_92
        local v99 = math.clamp(v98, 0, 1)
        local v100 = p_u_93 + (p_u_94 - p_u_93) * v99
        local v101
        if p_u_91._cook_detonate_delay then
            v101 = p_u_91._is_throwing + p_u_91._cook_detonate_delay - tick()
        else
            v101 = p_u_91.Info.DetonateDelay
        end
        p_u_91._trajectory_visual:Update(v97.Position, v97.LookVector * v100, workspace.Gravity * 0.5 * p_u_95, nil, v_u_96, v101)
    end)
end
function v_u_14._Init(p_u_102) -- name: _Init
    local v103 = p_u_102._connections
    local v104 = p_u_102.ClientFighter.Interrupted
    table.insert(v103, v104:Connect(function()
        -- upvalues: (copy) p_u_102
        p_u_102:_CancelThrow()
    end))
end
return v_u_14
