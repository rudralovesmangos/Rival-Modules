-- Script Path: game:GetService("StarterPlayer").StarterPlayerScripts.Modules.ClientReplicatedClasses.ClientFighter.ClientItem
-- Took 0.02s to decompile.

local v_u_1 = game:GetService("Players")
local v2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("CollectionService")
local v_u_4 = game:GetService("TweenService")
local v5 = v2:WaitForChild("Modules")
local v_u_6 = require(v5:WaitForChild("BetterDebris"))
local v_u_7 = require(v5:WaitForChild("CONSTANTS"))
local v_u_8 = require(v5:WaitForChild("EnumLibrary"))
local v_u_9 = require(v5:WaitForChild("ItemLibrary"))
local v_u_10 = require(v5:WaitForChild("ReplicatedClass"))
local v_u_11 = require(v5:WaitForChild("Signal"))
local v_u_12 = require(v5:WaitForChild("Utility"))
local v_u_13 = require(script:WaitForChild("ClientViewModel"))
local v_u_14 = require(script:WaitForChild("ItemInterface"))
local v_u_15 = require(script:WaitForChild("Cooldowns"))
local v_u_16 = v2:WaitForChild("Remotes"):WaitForChild("Replication"):WaitForChild("Fighter"):WaitForChild("UseItem")
local v_u_17 = v_u_1.LocalPlayer.PlayerScripts:WaitForChild("Modules"):WaitForChild("ViewModels")
local v_u_18 = v_u_1.LocalPlayer.PlayerScripts:WaitForChild("Modules"):WaitForChild("ItemInterfaces")
local v_u_19 = {
    "EquippedChanged",
    "EquipFailedEffect",
    "StopSprinting",
    "AttemptToSprintAgain",
    "ToggleOffMobileInputButton",
    "ServerInputWorkDone",
    "InterfaceAdded"
}
local v_u_20 = v_u_1.LocalPlayer.PlayerScripts:WaitForChild("Assets"):WaitForChild("Misc"):WaitForChild("ImpactMarkerBullet")
local v_u_21 = setmetatable({}, v_u_10)
v_u_21.__index = v_u_21
local function v_u_27(p22) -- name: decodeTop
    -- upvalues: (copy) v_u_8
    local v23 = {}
    for v26, v25 in p22 do
        if type(v26) == "string" then
            local v26 = v_u_8:FromEnum(v26, true) or v26
        end
        v23[v26] = v25
    end
    return v23
end
v_u_21.DecodeSerialKeys = v_u_27
function v_u_21.new(p28, p29) -- name: new
    -- upvalues: (copy) v_u_10, (copy) v_u_21, (copy) v_u_9, (copy) v_u_19, (copy) v_u_11, (copy) v_u_15, (copy) v_u_27, (copy) v_u_8, (copy) v_u_17, (copy) v_u_13, (copy) v_u_18, (copy) v_u_14
    local v30 = v_u_10.new(p28)
    local v31 = v_u_21
    local v32 = setmetatable(v30, v31)
    v32.ClientFighter = p29
    v32.Name = v32:Get("Name")
    v32.Info = v_u_9.Items[v32.Name]
    v32.IsEquipped = false
    for _, v33 in v_u_19 do
        v32[v33] = v_u_11.new()
    end
    v32._connections = {}
    v32._destroyed = false
    v32._equip_finish = 0
    v32._impact_markers = {}
    v32.Cooldowns = v_u_15.new(v32)
    local v34 = p28.ViewModel and v_u_27(p28.ViewModel) or {
        ["Data"] = {
            [v_u_8:ToEnum("Name")] = v32.Name
        }
    }
    local v35 = v34.Data or {}
    local v36 = v35.Name or (v35[v_u_8:ToEnum("Name", true)] or v32.Name)
    v32._pending_wrap = v35.Wrap or v35[v_u_8:ToEnum("Wrap", true)]
    local v37 = v_u_17:FindFirstChild(v36, true)
    local v38
    if v37 and v37:IsA("ModuleScript") then
        local v39 = require
        local v40
        v40, v38 = pcall(v39, v37)
        if v40 and (type(v38) == "table" and v38.new) then
            v32.ViewModel = v38.new(v34, v32)
            v32:_ApplyArms()
            if not p29.IsLocalPlayer then
                return v32
            end
        else
            v38 = v_u_13
            v32.ViewModel = v38.new(v34, v32)
            v32:_ApplyArms()
            if not p29.IsLocalPlayer then
                return v32
            end
        end
    else
        v38 = v_u_13
        v32.ViewModel = v38.new(v34, v32)
        v32:_ApplyArms()
        if not p29.IsLocalPlayer then
            return v32
        end
    end
    local v41 = v_u_18:FindFirstChild(v32.Name)
    local v42
    if v41 and v41:IsA("ModuleScript") then
        local v43 = require
        local v44
        v44, v42 = pcall(v43, v41)
        if v44 and (type(v42) == "table" and v42.new) then
            v32.ItemInterface = v42.new(v32)
        else
            v42 = v_u_14
            v32.ItemInterface = v42.new(v32)
        end
    else
        v42 = v_u_14
        v32.ItemInterface = v42.new(v32)
    end
    return v32
end
function v_u_21._ApplyArms(p45) -- name: _ApplyArms
    local v46 = p45.ClientFighter.Player
    if v46 then
        v46 = p45.ClientFighter.Player.Character
    end
    local v47
    if v46 then
        v47 = v46:FindFirstChildOfClass("Shirt")
    else
        v47 = v46
    end
    if v46 then
        v46 = v46:FindFirstChildOfClass("BodyColors")
    end
    local v48 = p45.ViewModel.SetArmsData
    local v49 = p45.ViewModel
    local v50 = v47 and v47.ShirtTemplate or nil
    local v51
    if v46 then
        v51 = v46.LeftArmColor3 or nil
    else
        v51 = nil
    end
    local v52 = v46 and v46.RightArmColor3 or nil
    pcall(v48, v49, v50, v51, v52)
end
function v_u_21.Input(p_u_53, p54, ...) -- name: Input
    -- upvalues: (copy) v_u_16
    if p_u_53._destroyed or not p_u_53.IsEquipped then
        return false
    end
    if p_u_53.ClientFighter.IsLocalPlayer and p_u_53.ClientFighter:AreItemsLocked() then
        return false
    end
    local v55 = p_u_53[p54]
    if type(v55) ~= "function" then
        return false
    end
    local v56 = table.pack(v55(p_u_53, ...))
    if not v56[1] then
        return false
    end
    local v_u_57 = v56[2] or p54
    if p_u_53.ClientFighter.IsLocalPlayer then
        local v58 = v_u_16
        local v59 = p_u_53:Get("ObjectID")
        local v60 = p_u_53:ToEnum(v_u_57)
        local v61 = v56.n
        v58:FireServer(v59, v60, table.unpack(v56, 3, v61))
        local function v62() -- name: workDone
            -- upvalues: (copy) p_u_53, (copy) v_u_57
            if not p_u_53._destroyed then
                p_u_53.ServerInputWorkDone:Fire(v_u_57)
            end
        end
        if p_u_53:Get("QuickAttackQueued") then
            task.delay(0.5, v62)
        else
            task.defer(v62)
        end
    end
    return true
end
function v_u_21.StartInspecting(p63, p64, p65) -- name: StartInspecting
    if p63.ViewModel then
        local v66 = p63.ViewModel
        local v67
        if p64 then
            v67 = p65 == true
        else
            v67 = nil
        end
        local v68, v69 = v66:Inspect(v67)
        if v68 then
            return true, "StartInspecting", v69 == true
        else
            return false
        end
    else
        return false
    end
end
function v_u_21.SimulateInputFromGameplayMechanic(p70, p71, ...) -- name: SimulateInputFromGameplayMechanic
    return p70:Input(p71, ...)
end
function v_u_21.IsEquipping(p72) -- name: IsEquipping
    return tick() < p72._equip_finish
end
function v_u_21.IsMainItem(p73) -- name: IsMainItem
    return p73.ClientFighter.EquippedItem == p73
end
function v_u_21.IsRendered(p74) -- name: IsRendered
    return p74.ClientFighter:IsRendered()
end
function v_u_21.GetAmmoVariables(p75) -- name: GetAmmoVariables
    local v76 = p75:Get("Ammo")
    local v77 = v76 == (1 / 0)
    return v76, p75:Get("AmmoReserve"), v77 or p75.ClientFighter:Get("InfiniteAmmo") == true, p75.ClientFighter:Get("InfiniteAmmoReserve") == true
end
function v_u_21.GetWrap(p78) -- name: GetWrap
    if p78.ViewModel then
        return p78.ViewModel:GetWrap()
    else
        return p78._pending_wrap
    end
end
function v_u_21.GetMobileInputSettings(p79) -- name: GetMobileInputSettings
    return p79.Info.MobileInputSettings or {}
end
function v_u_21.GetViewModelDetails(p80) -- name: GetViewModelDetails
    return {
        ["ViewModelName"] = p80.ViewModel.Name,
        ["Name"] = p80.ViewModel.Name,
        ["Wrap"] = p80.ViewModel:Get("Wrap"),
        ["Charm"] = p80.ViewModel:Get("Charm")
    }
end
function v_u_21.GetAimSpeed(_) -- name: GetAimSpeed
    return 1
end
function v_u_21.GetAutoShootReach(_) -- name: GetAutoShootReach
    -- upvalues: (copy) v_u_7
    return v_u_7.MAX_RAYCAST_DISTANCE
end
function v_u_21.GetAutoShootReactionTime(_) -- name: GetAutoShootReactionTime
    return nil
end
function v_u_21.CanQuickAttack(p81) -- name: CanQuickAttack
    return not p81:IsEquipping()
end
function v_u_21.CanEasyQuickAttack(p82) -- name: CanEasyQuickAttack
    return p82:CanQuickAttack()
end
function v_u_21.PlayEquipFailedEffect(p83) -- name: PlayEquipFailedEffect
    p83.EquipFailedEffect:Fire()
end
function v_u_21.Equip(p84, p85) -- name: Equip
    if not p84.IsEquipped then
        p84.IsEquipped = true
        p84._equip_finish = tick() + (p85 and 0 or (p84.Info.EquipCooldown or 0))
        p84.ViewModel:Equip(p85)
        if p84.ItemInterface then
            p84.ItemInterface:Equip()
        end
        p84.EquippedChanged:Fire(true)
    end
end
function v_u_21.Unequip(p86) -- name: Unequip
    if p86.IsEquipped then
        p86.IsEquipped = false
        p86.ViewModel:Unequip()
        if p86.ItemInterface then
            p86.ItemInterface:Unequip()
        end
        p86.EquippedChanged:Fire(false)
    end
end
function v_u_21.Update(p87, p88, p89) -- name: Update
    if not p87._destroyed then
        local v90 = p87.IsEquipped and (p89.IsAlive and p87:IsRendered())
        if v90 then
            v90 = not p89.IsHiddenByEmotes
        end
        local v91 = p87.ViewModel.Update
        local v92 = p87.ViewModel
        local v93 = {
            ["IsActive"] = v90,
            ["ViewModelOffset"] = CFrame.identity
        }
        local v94, v95 = pcall(v91, v92, p88, p89, v93)
        if not (v94 or p87._warned) then
            p87._warned = true
            warn("[ClientItem] " .. p87.Name .. " viewmodel: " .. tostring(v95))
        end
        if p87.ItemInterface then
            p87.ItemInterface:Update(p88, p89, {
                ["IsActive"] = v90
            })
        end
    end
end
local v_u_96 = {
    ["StartShooting"] = true,
    ["StartReloading"] = true,
    ["StartAiming"] = true,
    ["FinishAiming"] = true,
    ["StartInspecting"] = true
}
function v_u_21.ReplicateFromServer(p97, p98, ...) -- name: ReplicateFromServer
    -- upvalues: (copy) v_u_10, (copy) v_u_96
    if p98 == "DataValueChanged" then
        return v_u_10.ReplicateFromServer(p97, p98, ...)
    elseif p98 == "ExplosionEffect" then
        local v99 = p97.ViewModel
        if v99 and (v99.ExplosionEffect and p97:IsRendered()) then
            local v100 = v99.ExplosionEffect
            local v101, v102 = pcall(v100, v99, ...)
            if not v101 then
                warn("[ClientItem] " .. p97.Name .. " explosion effect: " .. tostring(v102))
            end
        end
    elseif v_u_96[p98] and (not p97.ClientFighter.IsLocalPlayer and (p97.IsEquipped and p97:IsRendered())) then
        local v103 = p97.Input
        local v104, v105 = pcall(v103, p97, p98, true, ...)
        if not (v104 or p97._replay_warned) then
            p97._replay_warned = true
            warn("[ClientItem] " .. p97.Name .. " replaying " .. p98 .. ": " .. tostring(v105))
        end
    end
end
function v_u_21.CooldownEffect(p106, p107, p108, p109, p110) -- name: CooldownEffect
    if p108 and p108 > 0 then
        p106.Cooldowns:Create(p107, p108, p109, p110)
    end
end
function v_u_21.StopCooldownEffect(p111, p112) -- name: StopCooldownEffect
    p111.Cooldowns:Clear(p112)
end
function v_u_21.CreateSound(p113, p114, p115, p116, ...) -- name: CreateSound
    -- upvalues: (copy) v_u_12
    if p113.ClientFighter:Get("IsSpectating") and p113.ItemInterface then
        return p113.ItemInterface:CreateSound(p114, p115, p116, "script", ...)
    else
        local v117 = p113.ClientFighter.Entity
        if v117 then
            v117 = p113.ClientFighter.Entity.RootPart
        end
        if v117 then
            return v_u_12:CreateSound(p114, p115, p116, v117, ...)
        else
            return nil
        end
    end
end
function v_u_21.CreateSpectatorSound(p118, p119, p120, p121, ...) -- name: CreateSpectatorSound
    -- upvalues: (copy) v_u_12
    if p118.ClientFighter:Get("IsSpectating") then
        return v_u_12:CreateSound(p119, p120, p121, "script", ...)
    else
        return nil
    end
end
local v_u_122 = nil
local v_u_123 = nil
local function v_u_133() -- name: shakeModules
    -- upvalues: (ref) v_u_122, (copy) v_u_1, (ref) v_u_123
    if not v_u_122 then
        local v124 = v_u_1.LocalPlayer.PlayerScripts
        local v125 = require
        local v126 = v124:WaitForChild("Controllers")
        local v127, v128 = pcall(v125, v126:WaitForChild("CameraController"))
        local v129 = require
        local v130 = v124:WaitForChild("Modules")
        local v131, v132 = pcall(v129, v130:WaitForChild("CameraShaker"))
        if not (v127 and v131) then
            return nil, nil
        end
        v_u_122 = v128
        v_u_123 = v132
    end
    return v_u_122, v_u_123
end
local function v_u_145(p134, p_u_135, p136) -- name: shakeFor
    -- upvalues: (copy) v_u_133
    if p134.ClientFighter:Get("IsSpectating") then
        local v137, v_u_138 = v_u_133()
        if v_u_138 then
            v_u_138 = v_u_138.Presets
        end
        local v142, v143 = pcall(function()
            -- upvalues: (copy) v_u_138, (copy) p_u_135
            local v139 = v_u_138
            if v139 then
                local v140 = v_u_138
                local v141 = p_u_135
                v139 = rawget(v140, v141)
            end
            return v139
        end)
        if v137 and (v142 and type(v143) == "function") then
            local v144 = v143()
            if p136 then
                v144.Magnitude = p136
            end
            v137:Shake(v144)
        end
    else
        return
    end
end
function v_u_21._Recoil(p146, p147) -- name: _Recoil
    -- upvalues: (copy) v_u_145, (copy) v_u_133
    local v148 = p146.Info.ChargingSpeedBoost ~= nil
    local v149 = (p146.Info.ShootRecoil or 1) * (v148 and 1 or (p147 or 1))
    local v150 = p146.ViewModel
    local v151 = (math.random() - 0.5) * 0.06
    v150:ApplyRecoil(Vector3.new(v151, 0.05, 0.1) * v149)
    if v149 > 0 then
        v_u_145(p146, "Recoil", math.min(v149, 5) * 0.6)
    end
    local v152 = v148 and (p146.ClientFighter:Get("IsSpectating") and v_u_133())
    if v152 then
        local v153 = v152.ApplyRotationDelta
        local v154 = Vector2.new(0.0024434609527920616, (math.random() - 0.5) * 0.005235987755982988)
        pcall(v153, v152, v154, true)
    end
end
function v_u_21._StartAimAssist(_) -- name: _StartAimAssist end
function v_u_21._FinishAimAssist(_) -- name: _FinishAimAssist end
function v_u_21._Shake(p155, p156) -- name: _Shake
    -- upvalues: (copy) v_u_145
    if type(p156) == "string" then
        v_u_145(p155, p156)
    end
end
function v_u_21._ImpactMarkerSlash(_, _, _, _) -- name: _ImpactMarkerSlash end
local function v_u_159(p157) -- name: isMarkableSurface
    -- upvalues: (copy) v_u_3
    if not p157 or (not p157:IsA("BasePart") or v_u_3:HasTag(p157, "EntityHitbox")) then
        return false
    end
    local v158 = p157:FindFirstAncestorOfClass("Model")
    if v158 then
        v158 = v158:FindFirstChildOfClass("Humanoid")
    end
    return not v158
end
function v_u_21._AddImpactMarker(p160, p_u_161, p162, p163) -- name: _AddImpactMarker
    -- upvalues: (copy) v_u_4, (copy) v_u_6
    local v_u_164 = p160._impact_markers
    table.insert(v_u_164, p_u_161)
    while (p163 or 40) < #v_u_164 do
        table.remove(v_u_164, 1):Destroy()
    end
    local v165 = p162 or 8
    local v166 = task.delay
    local v167 = v165 - 1
    v166(math.max(v167, 0), function()
        -- upvalues: (copy) p_u_161, (ref) v_u_4
        local v168 = p_u_161.Parent
        if v168 then
            v168 = p_u_161:FindFirstChildOfClass("Decal")
        end
        if v168 then
            v_u_4:Create(v168, TweenInfo.new(1), {
                ["Transparency"] = 1
            }):Play()
        end
    end)
    p_u_161.Destroying:Once(function()
        -- upvalues: (copy) v_u_164, (copy) p_u_161
        local v169 = table.find(v_u_164, p_u_161)
        if v169 then
            table.remove(v_u_164, v169)
        end
    end)
    v_u_6:AddItem(p_u_161, v165)
end
local function v_u_183(p170) -- name: visibleSurface
    -- upvalues: (copy) v_u_1
    local v171 = p170.Instance
    if v171.Transparency < 0.95 then
        return p170
    end
    local v172 = { v171 }
    for _, v173 in v_u_1:GetPlayers() do
        if not v173.Character then
            continue
        end
        local v174 = v173.Character
        table.insert(v172, v174)
    end
    local v175 = nil
    local v176 = nil
    for _, v177 in { 1, -1 } do
        local v178 = RaycastParams.new()
        v178.FilterType = Enum.RaycastFilterType.Exclude
        v178.FilterDescendantsInstances = table.clone(v172)
        local v179 = p170.Position + p170.Normal * (v177 * 0.05 + (v177 > 0 and 4 or 0))
        local v180 = -p170.Normal * 4
        if v177 < 0 then
            v179 = p170.Position + p170.Normal * 0.05
            v180 = -p170.Normal * 4
        end
        for _ = 1, 6 do
            local v181 = workspace:Raycast(v179, v180, v178)
            if not v181 then
                break
            end
            if v181.Instance.Transparency < 0.95 and v181.Normal:Dot(p170.Normal) > 0.5 then
                local v182 = (v181.Position - p170.Position).Magnitude
                if v182 > 4 or v175 and v182 >= v175 then
                    break
                end
                v176 = v181
                v175 = v182
                break
            end
            v178:AddToFilter(v181.Instance)
        end
    end
    return v176 and {
        ["Position"] = v176.Position,
        ["Normal"] = v176.Normal,
        ["Instance"] = v176.Instance
    } or nil
end
function v_u_21._ImpactMarker(p184, p185, p186) -- name: _ImpactMarker
    -- upvalues: (copy) v_u_183, (copy) v_u_20, (copy) v_u_4
    local v187 = p186 or {}
    local v188 = v_u_183(p185)
    if not v188 then
        return nil
    end
    local v189 = v188.Instance
    local v190 = v_u_20:Clone()
    local v191 = v_u_20.Size.X * (0.85 + 0.3 * math.random())
    local v192 = v_u_20.Size.Z
    v190.Size = Vector3.new(v191, v191, v192)
    v190.CFrame = CFrame.new(v188.Position + v188.Normal * 0.005, v188.Position + v188.Normal) * CFrame.Angles(0, 0, math.random() * 3.141592653589793 * 2)
    if v187.Color then
        v190.Decal.Color3 = v187.Color
    end
    if not v189.Anchored then
        v190.Anchored = false
        v190.Massless = true
        local v193 = Instance.new("WeldConstraint")
        v193.Part0 = v190
        v193.Part1 = v189
        v193.Parent = v190
    end
    v190.Parent = workspace:FindFirstChild("Debris") or workspace
    p184:_AddImpactMarker(v190)
    if not v187.NoTween then
        local v194 = v190.Size
        v190.Size = v194 * Vector3.new(0.5, 0.5, 1)
        v_u_4:Create(v190, TweenInfo.new(0.08, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            ["Size"] = v194
        }):Play()
    end
    local v195 = v190:FindFirstChild("Particles")
    if v195 and v195:IsA("ParticleEmitter") then
        v195.Color = ColorSequence.new(v189.Color)
        v195:Emit(4)
    end
    return v190
end
function v_u_21._ImpactMarkers(p196, p197) -- name: _ImpactMarkers
    -- upvalues: (copy) v_u_159
    for _, v198 in p197 do
        if not (v198.Position and (v198.Normal and v_u_159(v198.Instance))) then
            continue
        end
        local v199 = p196._ImpactMarker
        local v200 = {
            ["Position"] = v198.Position,
            ["Normal"] = v198.Normal,
            ["Instance"] = v198.Instance,
            ["Part"] = v198.Part or v198.Instance,
            ["IsFromPaintGrenade"] = v198.IsFromPaintGrenade
        }
        local v201, v202 = pcall(v199, p196, v200)
        if v201 then
            continue
        end
        warn("[ClientItem] impact marker failed: " .. tostring(v202))
    end
end
function v_u_21.Destroy(p203) -- name: Destroy
    -- upvalues: (copy) v_u_19, (copy) v_u_10
    if not p203._destroyed then
        p203._destroyed = true
        if p203.IsEquipped then
            local v204 = p203.Unequip
            pcall(v204, p203)
        end
        for _, v205 in p203._connections do
            v205:Disconnect()
        end
        p203._connections = {}
        if p203.ItemInterface then
            p203.ItemInterface:Destroy()
        end
        p203.Cooldowns:Destroy()
        p203.ViewModel:Destroy()
        for _, v206 in v_u_19 do
            p203[v206]:Destroy()
        end
        v_u_10.Destroy(p203)
    end
end
return v_u_21
