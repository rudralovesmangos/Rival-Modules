-- Script Path: game:GetService("StarterPlayer").StarterPlayerScripts.Modules.ClientReplicatedClasses.ClientFighter
-- Took 0.04s to decompile.

local v_u_1 = game:GetService("Players")
local v2 = game:GetService("ReplicatedStorage")
local v_u_3 = v2:WaitForChild("Modules")
local v_u_4 = require(v_u_3:WaitForChild("EnumLibrary"))
local v_u_5 = require(v_u_3:WaitForChild("ReplicatedClass"))
local v_u_6 = require(v_u_3:WaitForChild("Signal"))
local v_u_7 = nil
local v_u_8 = setmetatable({}, v_u_5)
v_u_8.__index = v_u_8
local v_u_9 = {
    "EntityAdded",
    "EntityRemoved",
    "Died",
    "Eliminated",
    "Elimination",
    "EquippedItemChanged",
    "HealthChanged",
    "InterfaceAdded",
    "InterfaceRemoved",
    "ItemAdded",
    "ItemRemoved",
    "StopSliding",
    "Interrupted",
    "InvincibilityChanged"
}
function v_u_8.new(p_u_10) -- name: new
    -- upvalues: (copy) v_u_5, (copy) v_u_8, (copy) v_u_1, (copy) v_u_9, (copy) v_u_6
    local v11 = v_u_5.new(p_u_10)
    local v12 = v_u_8
    local v_u_13 = setmetatable(v11, v12)
    v_u_13.ClassName = "ClientFighter"
    v_u_13.Player = v_u_13:Get("Player") or v_u_1:GetPlayerByUserId(tonumber(v_u_13:Get("UserID")) or 0)
    local v14
    if v_u_13.Player == nil then
        v14 = false
    else
        v14 = v_u_13.Player == v_u_1.LocalPlayer
    end
    v_u_13.IsLocalPlayer = v14
    v_u_13.Entity = nil
    v_u_13.EquippedItem = nil
    v_u_13.FighterInterface = nil
    v_u_13.Items = {}
    v_u_13._items_by_id = {}
    for _, v15 in v_u_9 do
        v_u_13[v15] = v_u_6.new()
    end
    if type(p_u_10) == "table" then
        local v16 = p_u_10.Entity
        if type(v16) == "table" then
            task.defer(v_u_13._SetEntity, v_u_13, p_u_10.Entity)
        end
    end
    if type(p_u_10) == "table" then
        local v17 = p_u_10.Items
        if type(v17) == "table" then
            task.defer(function()
                -- upvalues: (copy) p_u_10, (copy) v_u_13
                for _, v18 in p_u_10.Items do
                    v_u_13:_AddItem(v18)
                end
            end)
        end
    end
    v_u_13:GetDataChangedSignal("EquippedItemID"):Connect(function()
        -- upvalues: (copy) v_u_13
        v_u_13:_SyncEquippedItem()
    end)
    v_u_13:GetDataChangedSignal("IsSpectating"):Connect(function()
        -- upvalues: (copy) v_u_13
        v_u_13:_SyncInterface()
    end)
    task.defer(v_u_13._SyncInterface, v_u_13)
    return v_u_13
end
local function v_u_23(p19, p20) -- name: field
    -- upvalues: (copy) v_u_4
    local v21 = v_u_4:ToEnum(p20, true)
    if p19[p20] ~= nil then
        return p19[p20], p20
    end
    local v22
    if v21 then
        v22 = p19[v21]
    else
        v22 = v21
    end
    return v22, v21
end
local function v_u_31(p24, p25) -- name: completeCharacter
    -- upvalues: (copy) v_u_4, (copy) v_u_23
    local v26 = v_u_4:ToEnum("Model", true)
    local v27
    if p25.Model == nil then
        if v26 then
            v27 = p25[v26]
        else
            v27 = v26
        end
    else
        v27 = p25.Model
        v26 = "Model"
    end
    if v27 then
        return true
    end
    local v28 = p24.Player
    if v28 then
        v28 = v28.Character or v28.CharacterAdded:Wait()
    end
    local v29
    if v28 then
        v29 = v28:WaitForChild("HumanoidRootPart", 10)
    else
        v29 = v28
    end
    local v30
    if v28 then
        v30 = v28:WaitForChild("Humanoid", 10)
    else
        v30 = v28
    end
    if not (v29 and v30) then
        return false
    end
    p25[v26 or "Model"] = v28
    p25[select(2, v_u_23(p25, "RootPart")) or "RootPart"] = v29
    p25[select(2, v_u_23(p25, "Humanoid")) or "Humanoid"] = v30
    return true
end
function v_u_8._SetEntity(p_u_32, p33) -- name: _SetEntity
    -- upvalues: (copy) v_u_31, (ref) v_u_7
    if v_u_31(p_u_32, p33) then
        p_u_32:_RemoveEntity()
        v_u_7 = v_u_7 or require(script:WaitForChild("ClientFighterCharacter"))
        local v34 = v_u_7.new
        local v35, v36 = pcall(v34, p33, p_u_32)
        if v35 then
            p_u_32.Entity = v36
            p_u_32._entity_connections = { v36.Died:Connect(function(...)
                    -- upvalues: (copy) p_u_32
                    p_u_32.Died:Fire(...)
                end), v36.HealthChanged:Connect(function(...)
                    -- upvalues: (copy) p_u_32
                    p_u_32.HealthChanged:Fire(...)
                end) }
            p_u_32.EntityAdded:Fire(v36)
            p_u_32.HealthChanged:Fire()
            p_u_32:_SyncArms()
        else
            warn("[ClientFighter] character failed to build: " .. tostring(v36))
        end
    else
        local v37 = warn
        local v38 = p_u_32.Player
        v37("[ClientFighter] no character for " .. tostring(v38))
        return
    end
end
function v_u_8._SyncArms(p39) -- name: _SyncArms
    local v40 = p39.Entity
    if v40 and v40.SetIKControlTargetItem then
        local v41 = v40.SetIKControlTargetItem
        local v42 = p39.EquippedItem
        local v43, v44 = pcall(v41, v40, v42)
        if not (v43 or p39._arms_warned) then
            p39._arms_warned = true
            warn("[ClientFighter] arms: " .. tostring(v44))
        end
    end
end
function v_u_8._RemoveEntity(p45) -- name: _RemoveEntity
    local v46 = p45.Entity
    if v46 then
        for _, v47 in p45._entity_connections or {} do
            v47:Disconnect()
        end
        p45._entity_connections = nil
        p45.Entity = nil
        p45.EntityRemoved:Fire(v46)
        v46:Destroy()
    end
end
function v_u_8.IsA(_, p48) -- name: IsA
    return p48 == "ClientFighter" and true or p48 == "ReplicatedClass"
end
function v_u_8.GetItem(p49, p50) -- name: GetItem
    return p49._items_by_id[p50]
end
local v_u_51 = game:GetService("UserInputService")
local v_u_52 = game:GetService("GuiService")
local function v_u_55(p53) -- name: getAimPoint
    -- upvalues: (copy) v_u_51, (copy) v_u_52
    local v54 = workspace.CurrentCamera
    if p53.IsLocalPlayer and (v_u_51.TouchEnabled and (p53.EquippedItem and (p53:IsAlive() and v54))) then
        return v54.ViewportSize / 2 - v_u_52:GetGuiInset()
    else
        return v_u_51:GetMouseLocation() - v_u_52:GetGuiInset()
    end
end
function v_u_8._FrameState(p56) -- name: _FrameState
    -- upvalues: (copy) v_u_55
    local v57 = p56.Entity
    local v58
    if v57 then
        v58 = v57.Humanoid
    else
        v58 = v57
    end
    if v57 then
        v57 = v57.RootPart
    end
    local v59 = v57 and v57.AssemblyLinearVelocity or Vector3.new(0, 0, 0)
    local v60 = v59 * Vector3.new(1, 0, 1)
    local v61
    if v58 then
        v61 = v58:GetState()
    else
        v61 = v58
    end
    local v62
    if v58 == nil then
        v62 = false
    else
        v62 = v58.FloorMaterial ~= Enum.Material.Air
    end
    local v63
    if v62 then
        v63 = p56._was_grounded == false
    else
        v63 = v62
    end
    p56._was_grounded = v62
    local v64 = p56:IsActuallyFirstPerson()
    local v65
    if p56.IsLocalPlayer then
        local v66, v67 = pcall(function()
            return camera().Rotation
        end)
        v65 = v66 and v67 and v67 or nil
    else
        v65 = p56:_SmoothedRotation()
    end
    local v68 = {
        ["IsAlive"] = nil,
        ["IsGrounded"] = nil,
        ["JustLanded"] = nil,
        ["IsClimbing"] = nil,
        ["IsCrouching"] = nil,
        ["IsSliding"] = nil,
        ["IsBeingKnockedBack"] = false,
        ["IsHiddenByCutscene"] = false,
        ["IsHiddenByEmotes"] = nil,
        ["IsSpectating"] = nil,
        ["IsFirstPerson"] = nil,
        ["IsActuallyFirstPerson"] = nil,
        ["IsActuallySprinting"] = nil,
        ["PlayerVelocity"] = nil,
        ["MoveVelocity"] = nil,
        ["MoveSpeed"] = nil,
        ["CameraRotationRaw"] = nil,
        ["CameraLean"] = nil,
        ["MouseLocation"] = nil
    }
    local v69
    if v58 == nil then
        v69 = false
    else
        v69 = v58.Health > 0
    end
    v68.IsAlive = v69
    v68.IsGrounded = v62
    v68.JustLanded = v63
    v68.IsClimbing = v61 == Enum.HumanoidStateType.Climbing
    v68.IsCrouching = p56:IsCrouching()
    v68.IsSliding = p56:IsSliding()
    v68.IsHiddenByEmotes = p56:Get("IsHiddenByEmotes") == true
    v68.IsSpectating = p56:Get("IsSpectating") == true
    v68.IsFirstPerson = v64
    v68.IsActuallyFirstPerson = v64
    v68.IsActuallySprinting = p56:IsSprinting()
    v68.PlayerVelocity = v59
    v68.MoveVelocity = v60
    v68.MoveSpeed = v60.Magnitude
    v68.CameraRotationRaw = typeof(v65) == "Vector2" and v65 and v65 or Vector2.zero
    v68.CameraLean = p56:GetCameraLean()
    v68.MouseLocation = p56.IsLocalPlayer and v_u_55(p56) or Vector2.zero
    return v68
end
local function v_u_80(p_u_70, p71, p72) -- name: setFirstPersonBodyHidden
    if p_u_70._first_person_character ~= p71 then
        if p_u_70._first_person_added_connection then
            p_u_70._first_person_added_connection:Disconnect()
            p_u_70._first_person_added_connection = nil
        end
        for v73, v74 in p_u_70._first_person_transparency or {} do
            if not v73.Parent then
                continue
            end
            v73.LocalTransparencyModifier = v74
        end
        p_u_70._first_person_transparency = {}
        p_u_70._first_person_character = p71
    end
    if p71 then
        if p72 then
            local function v76(p75) -- name: hidePart
                -- upvalues: (copy) p_u_70
                if p75:IsA("BasePart") and p_u_70._first_person_transparency[p75] == nil then
                    p_u_70._first_person_transparency[p75] = p75.LocalTransparencyModifier
                    p75.LocalTransparencyModifier = 1
                end
            end
            for _, v77 in p71:GetDescendants() do
                if not v77:IsA("BasePart") or p_u_70._first_person_transparency[v77] ~= nil then
                    continue
                end
                p_u_70._first_person_transparency[v77] = v77.LocalTransparencyModifier
                v77.LocalTransparencyModifier = 1
            end
            if not p_u_70._first_person_added_connection then
                p_u_70._first_person_added_connection = p71.DescendantAdded:Connect(v76)
            end
        elseif p_u_70._first_person_body_hidden then
            if p_u_70._first_person_added_connection then
                p_u_70._first_person_added_connection:Disconnect()
                p_u_70._first_person_added_connection = nil
            end
            for v78, v79 in p_u_70._first_person_transparency do
                if not v78.Parent then
                    continue
                end
                v78.LocalTransparencyModifier = v79
            end
            table.clear(p_u_70._first_person_transparency)
        end
        p_u_70._first_person_body_hidden = p72
    else
        p_u_70._first_person_body_hidden = p72
    end
end
function v_u_8.Update(p81, p82) -- name: Update
    -- upvalues: (copy) v_u_80
    if p81.Entity then
        local v83 = p81:_FrameState()
        p81.FrameState = v83
        local v84
        if p81.IsLocalPlayer and p81.Player then
            v84 = p81.Player.Character or nil
        else
            v84 = nil
        end
        if p81._first_person_character ~= v84 or p81._first_person_body_hidden ~= v83.IsActuallyFirstPerson then
            v_u_80(p81, v84, v83.IsActuallyFirstPerson)
        end
        p81.Entity:Update(p82, v83)
        for _, v85 in p81.Items do
            v85:Update(p82, v83)
        end
        if p81.FighterInterface then
            local v86 = p81.FighterInterface.Update
            local v87 = p81.FighterInterface
            local v88, v89 = pcall(v86, v87, p82, v83)
            if not (v88 or p81._interface_warned) then
                p81._interface_warned = true
                warn("[ClientFighter] interface: " .. tostring(v89))
            end
        end
    elseif p81._first_person_body_hidden then
        v_u_80(p81, p81.Player and p81.Player.Character or nil, false)
    end
end
function v_u_8.IsAlive(p90, ...) -- name: IsAlive
    local v91
    if p90.Entity == nil then
        v91 = false
    else
        v91 = p90.Entity:IsAlive(...)
    end
    return v91
end
local v_u_92 = require(v_u_3:WaitForChild("CONSTANTS")).BASE_HEALTH
function v_u_8.GetMaxHealth(p93) -- name: GetMaxHealth
    -- upvalues: (copy) v_u_92
    return p93.Entity and p93.Entity:GetMaxHealth() or v_u_92
end
function v_u_8.GetHealth(p94) -- name: GetHealth
    -- upvalues: (copy) v_u_92
    return p94.Entity and p94.Entity:GetHealth() or v_u_92
end
function v_u_8.GetMoveVector(p95, _, p96, p97) -- name: GetMoveVector
    local v98 = p95.Player
    if v98 then
        v98 = p95.Player.Character
    end
    if v98 then
        v98 = v98:FindFirstChildOfClass("Humanoid")
    end
    local v99 = v98 and v98.MoveDirection or Vector3.new(0, 0, 0)
    if p96 then
        v99 = v99 * Vector3.new(1, 0, 1)
    elseif v99.Magnitude > 0.01 then
        local v100 = workspace.CurrentCamera.CFrame
        local v101 = v100.LookVector * Vector3.new(1, 0, 1)
        if v101.Magnitude > 0.01 then
            local v102 = v101.Unit
            local v103 = (v100.RightVector * Vector3.new(1, 0, 1)).Unit
            v99 = v100.LookVector * v99:Dot(v102) + v100.RightVector * v99:Dot(v103)
        end
    end
    if v99.Magnitude < 0.01 and p97 then
        if p96 then
            p97 = p97 * Vector3.new(1, 0, 1) or p97
        end
    else
        p97 = v99
    end
    return p97.Magnitude > 0.01 and p97.Unit or Vector3.new(0, 0, 0)
end
function v_u_8.IsGrounded(p104) -- name: IsGrounded
    local v105 = p104.Player
    if v105 then
        v105 = p104.Player.Character
    end
    if v105 then
        v105 = v105:FindFirstChildOfClass("Humanoid")
    end
    local v106
    if v105 == nil then
        v106 = false
    else
        v106 = v105.FloorMaterial ~= Enum.Material.Air
    end
    return v106
end
function v_u_8.GetFloor(p107) -- name: GetFloor
    local v108 = p107.Player
    if v108 then
        v108 = p107.Player.Character
    end
    if v108 then
        v108 = v108:FindFirstChildOfClass("Humanoid")
    end
    local v109
    if v108 then
        v109 = v108.RootPart
    else
        v109 = v108
    end
    if not v109 then
        return nil
    end
    local v110 = RaycastParams.new()
    v110.FilterType = Enum.RaycastFilterType.Exclude
    v110.FilterDescendantsInstances = { p107.Player.Character }
    local v111 = workspace
    local v112 = v109.Position
    local v113 = -(v109.Size.Y / 2 + v108.HipHeight + 1)
    local v114 = v111:Raycast(v112, Vector3.new(0, v113, 0), v110)
    if v114 then
        v114 = v114.Instance
    end
    return v114
end
function v_u_8.CanSprint(p115) -- name: CanSprint
    local v116 = p115:IsAlive()
    if v116 then
        local v117
        if p115.Entity == nil then
            v117 = false
        else
            v117 = p115.Entity:Get("IsFrozen") == true
        end
        v116 = not v117
        if v116 then
            v116 = not p115:Get("SprintingDisabled")
        end
    end
    return v116
end
function v_u_8.CanSlide(p118) -- name: CanSlide
    local v119 = p118:IsAlive()
    if v119 then
        local v120
        if p118.Entity == nil then
            v120 = false
        else
            v120 = p118.Entity:Get("IsFrozen") == true
        end
        v119 = not v120
        if v119 then
            v119 = not p118:Get("SlidingDisabled")
        end
    end
    return v119
end
function v_u_8.AreItemsLocked(p121) -- name: AreItemsLocked
    return not p121:IsAlive() or p121:Get("ItemsLocked") == true
end
function v_u_8.GetJoinCooldown(_) -- name: GetJoinCooldown
    return 0
end
local v_u_122 = nil
local v_u_123 = require(v_u_3:WaitForChild("Utility"))
local v_u_124 = nil
local v_u_125 = nil
function v_u_8.IsActuallyFirstPerson(p_u_126) -- name: IsActuallyFirstPerson
    -- upvalues: (ref) v_u_122, (copy) v_u_1
    local function v129()
        -- upvalues: (ref) v_u_122, (ref) v_u_1, (copy) p_u_126
        v_u_122 = v_u_122 or require(v_u_1.LocalPlayer.PlayerScripts.Controllers.CameraController)
        local v127 = v_u_122
        local v128
        if v127:GetPublicState() == "FirstPerson" then
            v128 = v127:GetCurrentSubject() == p_u_126
        else
            v128 = false
        end
        return v128
    end
    local v130, v131 = pcall(v129)
    if v130 then
        v130 = v131 == true
    end
    return v130
end
function v_u_8.IsActive(p132) -- name: IsActive
    local v133
    if #p132.Items > 0 then
        v133 = p132:IsAlive()
    else
        v133 = false
    end
    return v133
end
local function v_u_137(p134, p135, p136) -- name: movementState
    if p134.IsLocalPlayer then
        return p134[p135]
    else
        return p134:Get(p136)
    end
end
function v_u_8.IsSliding(p138) -- name: IsSliding
    local v139
    if p138.IsLocalPlayer then
        v139 = p138.IsSlidingLocally
    else
        v139 = p138:Get("IsSliding")
    end
    return v139 == true
end
function v_u_8.GetEquippedItems(p140) -- name: GetEquippedItems
    return p140.EquippedItem and {
        [p140.EquippedItem] = true
    } or {}
end
function v_u_8.GetRaycastWhitelist(p141, p142) -- name: GetRaycastWhitelist
    -- upvalues: (ref) v_u_124
    if p142 then
        return v_u_124():GetRaycastWhitelist(p141:Get("EnvironmentID"), p141:GetEntityLookupParams())
    end
    local v143 = {}
    for _, v144 in { "Lobby", "Map", "Maps" } do
        local v145 = workspace:FindFirstChild(v144)
        if not v145 then
            continue
        end
        table.insert(v143, v145)
    end
    return v143
end
local function v_u_156(p146) -- name: smoothedRotation
    local v147 = p146:Get("CameraRotation")
    if typeof(v147) == "Vector2" then
        local v148 = Vector2.new((v147.X + 3.141592653589793) % 6.283185307179586 - 3.141592653589793, v147.Y)
        local v149 = os.clock()
        local v150 = p146._smoothed_rotation
        if v150 then
            local v151 = v149 - (p146._smoothed_at or v149)
            if v151 > 0 then
                p146._smoothed_at = v149
                local v152 = math.min(v151, 0.25) * -18
                local v153 = 1 - math.exp(v152)
                local v154 = (v148.X - v150.X + 3.141592653589793) % 6.283185307179586 - 3.141592653589793
                local v155 = (v148.Y - v150.Y + 3.141592653589793) % 6.283185307179586 - 3.141592653589793
                v150 = Vector2.new(v150.X + v154 * v153, v150.Y + v155 * v153)
                p146._smoothed_rotation = v150
            end
            return v150
        else
            p146._smoothed_rotation = v148
            p146._smoothed_at = v149
            return v148
        end
    else
        return nil
    end
end
v_u_8._SmoothedRotation = v_u_156
function v_u_8.GetRotationCFrame(p_u_157) -- name: GetRotationCFrame
    -- upvalues: (ref) v_u_122, (copy) v_u_1, (copy) v_u_156
    local function v160()
        -- upvalues: (copy) p_u_157, (ref) v_u_122, (ref) v_u_1, (ref) v_u_156
        if p_u_157.IsLocalPlayer then
            v_u_122 = v_u_122 or require(v_u_1.LocalPlayer.PlayerScripts.Controllers.CameraController)
            return v_u_122:GetRotationCFrame()
        end
        local v158 = v_u_156(p_u_157)
        local v159
        if v158 then
            v_u_122 = v_u_122 or require(v_u_1.LocalPlayer.PlayerScripts.Controllers.CameraController)
            v159 = v_u_122:GetRotationCFrame(v158) or nil
        else
            v159 = nil
        end
        return v159
    end
    local v161, v162 = pcall(v160)
    if v161 and v162 then
        return v162
    end
    local v163 = p_u_157.Entity
    if v163 then
        v163 = p_u_157.Entity.RootPart
    end
    return v163 and v163.CFrame.Rotation or CFrame.identity
end
function v_u_8.CreateSound(p164, p165, p166, p167, ...) -- name: CreateSound
    -- upvalues: (copy) v_u_123
    local v168 = p164.Entity
    if v168 then
        v168 = p164.Entity.RootPart
    end
    if v168 then
        return v_u_123:CreateSound(p165, p166, p167, v168, ...)
    else
        return nil
    end
end
function v_u_8.ReplicateFromServer(p169, p170, ...) -- name: ReplicateFromServer
    -- upvalues: (copy) v_u_5, (copy) v_u_4, (ref) v_u_125
    if p170 == "DataValueChanged" then
        return v_u_5.ReplicateFromServer(p169, p170, ...)
    elseif p170 == "ItemAdded" then
        p169:_AddItem(...)
        return
    elseif p170 == "ItemRemoved" then
        p169:_RemoveItem(...)
    elseif p170 == "ItemChanged" then
        local v171, v172 = ...
        local v173 = p169._items_by_id[v171]
        if v173 then
            v173:ReplicateFromServer(v_u_4:FromEnum(v172, true) or v172, select(3, ...))
            return
        end
    elseif p170 == "PlayMechanicsSound" then
        if not p169.IsLocalPlayer and type((...)) == "string" then
            p169:PlayMechanicsSound((...))
            return
        end
    elseif p170 == "HitEffect" then
        local v174 = ...
        local v175 = p169.EquippedItem
        if v175 then
            v175 = p169.EquippedItem.ItemInterface
        end
        if v175 then
            local v176 = v175.DamageEffect
            pcall(v176, v175, v174, 1)
        end
        local v177
        if type(v174) == "table" then
            v177 = v174[utf8.char(2)]
        else
            v177 = false
        end
        local v178
        if typeof(v177) == "Instance" then
            v178 = v177:FindFirstChildOfClass("Humanoid") ~= nil
        else
            v178 = false
        end
        if p169.IsLocalPlayer and v178 then
            local v179 = v_u_125().Show
            local v180 = v174[utf8.char(0)]
            local v181 = v174[utf8.char(1)] == true
            local v182 = v174[utf8.char(4)]
            pcall(v179, v177, v180, v181, v182)
            return
        end
    elseif p170 == "EliminationEffect" then
        local v183 = p169.FighterInterface
        if p169.IsLocalPlayer and (v183 and v183.EliminationEffect) then
            local v184 = v183.EliminationEffect
            pcall(v184, v183, ...)
            return
        end
    elseif p170 == "SplatEffect" then
        local v185 = p169.FighterInterface
        if p169.IsLocalPlayer and (v185 and v185.SplatEffect) then
            local v186 = v185.SplatEffect
            pcall(v186, v185, ...)
            return
        end
    else
        if p170 == "EntityAdded" then
            p169:_SetEntity(...)
            return
        end
        if p170 == "EntityRemoved" then
            p169:_RemoveEntity()
            return
        end
        if p170 == "EntityChanged" and p169.Entity then
            local v187 = ...
            p169.Entity:ReplicateFromServer(v_u_4:FromEnum(v187, true) or v187, select(2, ...))
        end
    end
end
local v_u_188 = require(v_u_3:WaitForChild("ItemLibrary"))
local v_u_189 = require(v_u_3:WaitForChild("EntityLookupParams"))
local v_u_190 = require(v_u_3:WaitForChild("CONSTANTS"))
local v_u_191 = v2:WaitForChild("Remotes"):WaitForChild("Replication"):WaitForChild("Fighter")
local v_u_192 = v_u_1.LocalPlayer:WaitForChild("PlayerScripts"):WaitForChild("Modules")
local v_u_193 = {}
local function v_u_194()
    -- upvalues: (copy) v_u_3
    return require(v_u_3:WaitForChild("GameplayUtility"))
end
local v_u_195 = "GameplayUtility"
v_u_124 = function()
    -- upvalues: (copy) v_u_193, (copy) v_u_195, (copy) v_u_194
    if v_u_193[v_u_195] == nil then
        v_u_193[v_u_195] = v_u_194()
    end
    return v_u_193[v_u_195]
end
local function v_u_196()
    return require(script:WaitForChild("ClientItem"))
end
local v_u_197 = "ClientItem"
local function v_u_198()
    -- upvalues: (copy) v_u_193, (copy) v_u_197, (copy) v_u_196
    if v_u_193[v_u_197] == nil then
        v_u_193[v_u_197] = v_u_196()
    end
    return v_u_193[v_u_197]
end
local function v_u_199()
    return require(script:WaitForChild("FighterInterface"))
end
local v_u_200 = "FighterInterface"
local function v_u_201()
    -- upvalues: (copy) v_u_193, (copy) v_u_200, (copy) v_u_199
    if v_u_193[v_u_200] == nil then
        v_u_193[v_u_200] = v_u_199()
    end
    return v_u_193[v_u_200]
end
local function v_u_202()
    return require(script:WaitForChild("QuickAttackSystem"))
end
local v_u_203 = "QuickAttackSystem"
local function v_u_204()
    -- upvalues: (copy) v_u_193, (copy) v_u_203, (copy) v_u_202
    if v_u_193[v_u_203] == nil then
        v_u_193[v_u_203] = v_u_202()
    end
    return v_u_193[v_u_203]
end
local function v_u_205()
    -- upvalues: (copy) v_u_192
    return require(v_u_192:WaitForChild("DamageNumbers"))
end
local v_u_206 = "DamageNumbers"
v_u_125 = function()
    -- upvalues: (copy) v_u_193, (copy) v_u_206, (copy) v_u_205
    if v_u_193[v_u_206] == nil then
        v_u_193[v_u_206] = v_u_205()
    end
    return v_u_193[v_u_206]
end
local function v_u_207()
    -- upvalues: (copy) v_u_1
    return require(v_u_1.LocalPlayer.PlayerScripts.Controllers:WaitForChild("PlayerDataController"))
end
local v_u_208 = "PlayerDataController"
local function v_u_209()
    -- upvalues: (copy) v_u_193, (copy) v_u_208, (copy) v_u_207
    if v_u_193[v_u_208] == nil then
        v_u_193[v_u_208] = v_u_207()
    end
    return v_u_193[v_u_208]
end
local function v_u_218(p210) -- name: itemClass
    -- upvalues: (copy) v_u_192, (copy) v_u_188, (copy) v_u_198
    local v211 = v_u_192:FindFirstChild("Items")
    if v211 then
        v211 = v_u_192.Items:FindFirstChild(p210)
    end
    local v212 = v_u_188.Items[p210]
    local v213 = v212 and v_u_192:FindFirstChild("ItemTypes")
    if v213 then
        v213 = v_u_192.ItemTypes:FindFirstChild(v212.Type)
    end
    for _, v214 in { v211, v213 } do
        if not v214 then
            continue
        end
        local v215 = require
        local v216, v217 = pcall(v215, v214)
        if v216 and (type(v217) == "table" and v217.new) then
            return v217
        end
        warn("[ClientFighter] item class " .. v214.Name .. " failed: " .. tostring(v217))
    end
    return v_u_198()
end
function v_u_8._AddItem(p_u_219, p220) -- name: _AddItem
    -- upvalues: (copy) v_u_198, (copy) v_u_4, (copy) v_u_204, (copy) v_u_218
    if type(p220) == "table" then
        local v_u_221 = v_u_198().DecodeSerialKeys(p220)
        local v222 = v_u_221.Data or {}
        local v_u_223 = v222[v_u_4:ToEnum("Name")]
        local v224 = v222[v_u_4:ToEnum("ObjectID")]
        if v_u_223 and (v224 and not p_u_219._items_by_id[v224]) then
            if not p_u_219._quick_attack_system then
                p_u_219._quick_attack_system = v_u_204().new(p_u_219)
            end
            local _ = p_u_219._quick_attack_system
            local function v225()
                -- upvalues: (ref) v_u_218, (copy) v_u_223, (copy) v_u_221, (copy) p_u_219
                return v_u_218(v_u_223).new(v_u_221, p_u_219)
            end
            local v226, v227 = pcall(v225)
            if v226 then
                p_u_219._items_by_id[v224] = v227
                local v228 = p_u_219.Items
                table.insert(v228, v227)
                table.sort(p_u_219.Items, function(p229, p230)
                    return (p229:Get("ItemIndex") or 0) < (p230:Get("ItemIndex") or 0)
                end)
                p_u_219.ItemAdded:Fire(v227)
                if p_u_219:Get("EquippedItemID") == v224 then
                    p_u_219:_SyncEquippedItem()
                end
            else
                warn("[ClientFighter] item " .. tostring(v_u_223) .. " failed to build: " .. tostring(v227))
            end
        else
            return
        end
    else
        return
    end
end
function v_u_8._RemoveItem(p231, p232) -- name: _RemoveItem
    local v233 = p231._items_by_id[p232]
    if v233 then
        if p231.EquippedItem == v233 then
            p231:_SetEquippedItem(nil)
        end
        p231._items_by_id[p232] = nil
        local v234 = table.find(p231.Items, v233)
        if v234 then
            table.remove(p231.Items, v234)
        end
        p231.ItemRemoved:Fire(v233)
        v233:Destroy()
    end
end
function v_u_8._SetEquippedItem(p235, p236, p237) -- name: _SetEquippedItem
    if p235.EquippedItem ~= p236 then
        local v238 = p235.EquippedItem
        p235.EquippedItem = p236
        if v238 then
            local v239 = v238.Unequip
            pcall(v239, v238)
        end
        if p236 then
            local v240 = p236.Equip
            local v241, v242 = pcall(v240, p236, p237)
            if not v241 then
                warn("[ClientFighter] equip " .. p236.Name .. ": " .. tostring(v242))
            end
        end
        p235:_SyncArms()
        p235.EquippedItemChanged:Fire(p236)
    end
end
function v_u_8._SyncEquippedItem(p243) -- name: _SyncEquippedItem
    local v244 = p243._items_by_id[p243:Get("EquippedItemID")]
    if not p243.IsLocalPlayer or (not p243._pending_equip or tick() >= p243._pending_equip) then
        p243:_SetEquippedItem(v244)
    end
end
function v_u_8.EquipItem(p_u_245, p246, p247) -- name: EquipItem
    -- upvalues: (copy) v_u_204, (copy) v_u_191
    local v_u_248 = p_u_245.Items[p246]
    if v_u_248 and (v_u_248 ~= p_u_245.EquippedItem and p_u_245:IsAlive()) then
        if not p_u_245._quick_attack_system then
            p_u_245._quick_attack_system = v_u_204().new(p_u_245)
        end
        local v249 = p_u_245._quick_attack_system
        if p247 or not v249:IsEquippingLocked(v_u_248:Get("ObjectID")) then
            local v250 = v249:ShouldSkipEquipAnimation(v_u_248) and true or nil
            p_u_245._pending_equip = tick() + 1
            p_u_245:_SetEquippedItem(v_u_248, v250)
            task.spawn(function()
                -- upvalues: (ref) v_u_191, (copy) v_u_248, (copy) p_u_245
                local v251 = v_u_191.EquipItemFeedback.InvokeServer
                local v252 = v_u_191.EquipItemFeedback
                local v253 = v_u_248
                pcall(v251, v252, v253:Get("ObjectID"))
                p_u_245._pending_equip = nil
            end)
        end
    else
        return
    end
end
function v_u_8.EquipIncrement(p254, p255) -- name: EquipIncrement
    local v256 = #p254.Items
    if v256 ~= 0 then
        p254:EquipItem(((table.find(p254.Items, p254.EquippedItem) or 1) - 1 + p255) % v256 + 1)
    end
end
function v_u_8.Input(p257, p258, ...) -- name: Input
    if p257.EquippedItem then
        return p257.EquippedItem:Input(p258, ...)
    else
        return false
    end
end
function v_u_8.QuickAttackDown(p259, p260, ...) -- name: QuickAttackDown
    -- upvalues: (copy) v_u_204
    if not p259._quick_attack_system then
        p259._quick_attack_system = v_u_204().new(p259)
    end
    return p259._quick_attack_system:InputDown(p260, ...)
end
function v_u_8.QuickAttackUp(p261, p262, ...) -- name: QuickAttackUp
    -- upvalues: (copy) v_u_204
    if not p261._quick_attack_system then
        p261._quick_attack_system = v_u_204().new(p261)
    end
    return p261._quick_attack_system:InputUp(p262, ...)
end
function v_u_8.GetQuickAttackIndex(p263, p264) -- name: GetQuickAttackIndex
    -- upvalues: (copy) v_u_204
    if not p263._quick_attack_system then
        p263._quick_attack_system = v_u_204().new(p263)
    end
    return p263._quick_attack_system:GetQuickAttackIndex(p264)
end
function v_u_8.GetMaxEquippableWeapons(_) -- name: GetMaxEquippableWeapons
    -- upvalues: (copy) v_u_188
    return #v_u_188.SlotToClass
end
function v_u_8.CanUseWeapon(p265, p266, p267) -- name: CanUseWeapon
    -- upvalues: (ref) v_u_124, (copy) v_u_209
    local v268 = v_u_124().CanUseWeapon
    local v269 = v_u_124()
    local v270 = v_u_209()
    local v271, v272 = pcall(v268, v269, p265, v270, p266, p267)
    if v271 then
        v271 = v272 == true
    end
    return v271
end
function v_u_8.GetEntityLookupParams(p273) -- name: GetEntityLookupParams
    -- upvalues: (copy) v_u_189
    local v274 = v_u_189.new(p273:Get("TeamID"), false, false)
    v274.SourceEntity = p273.Entity
    return v274
end
function v_u_8.IsCrouching(p275) -- name: IsCrouching
    local v276
    if p275.IsLocalPlayer then
        v276 = p275.IsCrouchingLocally
    else
        v276 = p275:Get("IsCrouching")
    end
    return v276 == true
end
function v_u_8.IsSprinting(p277) -- name: IsSprinting
    local v278
    if p277.IsLocalPlayer then
        v278 = p277.IsSprintingLocally
    else
        v278 = p277:Get("IsSprinting")
    end
    return v278 == true
end
function v_u_8.GetCameraLean(p279) -- name: GetCameraLean
    -- upvalues: (copy) v_u_137
    local v280 = v_u_137
    return tonumber(v280(p279, "LocalCameraLean", "CameraLean")) or 0
end
function v_u_8.GetAimSpeed(p281) -- name: GetAimSpeed
    return p281.EquippedItem and p281.EquippedItem:GetAimSpeed() or 1
end
function v_u_8.GetFOVOffset(p282) -- name: GetFOVOffset
    return p282.EquippedItem and p282.EquippedItem:Get("FOVOffset") or 0
end
function v_u_8.IsRendered(p283) -- name: IsRendered
    return p283.Entity ~= nil
end
function v_u_8.GetCameraSway(_) -- name: GetCameraSway
    return Vector2.zero
end
function v_u_8.GetMouseLocation(_) -- name: GetMouseLocation
    -- upvalues: (copy) v_u_51
    return v_u_51:GetMouseLocation()
end
function v_u_8.GetCameraData(p284, p285, p286, p287) -- name: GetCameraData
    -- upvalues: (copy) v_u_55, (copy) v_u_123, (copy) v_u_190
    local v288 = workspace.CurrentCamera
    local v289 = v_u_55(p284)
    local v290 = v288:ScreenPointToRay(v289.X, v289.Y)
    local v291 = CFrame.lookAt(v290.Origin, v290.Origin + v290.Direction)
    if p286 then
        v291 = v291 * p286
    end
    local v292 = p285 or p284:GetRaycastWhitelist(true)
    local v293 = v_u_123:Raycast(v291.Position, v291.Position + v291.LookVector, v_u_190.MAX_RAYCAST_DISTANCE, v292, Enum.RaycastFilterType.Include)
    local v294 = p284.Entity
    if v294 then
        v294 = p284.Entity.Head or p284.Entity.RootPart
    end
    local v295 = {
        [utf8.char(0)] = CFrame.new(v294 and v294.Position or v291.Position) * v291.Rotation,
        [utf8.char(1)] = v291
    }
    if v293.Instance then
        v295[utf8.char(2)] = v293.Instance
        v295[utf8.char(3)] = v293.Instance.CFrame:ToObjectSpace(CFrame.new(v293.Position))
    end
    if not p287 then
        for _, v296 in { utf8.char(0), utf8.char(1), utf8.char(3) } do
            if not v295[v296] then
                continue
            end
            v295[v296] = v_u_123:EncodeCFrame(v295[v296])
        end
    end
    return v295, v293
end
function v_u_8._SyncInterface(p_u_297) -- name: _SyncInterface
    -- upvalues: (copy) v_u_201
    if p_u_297:Get("IsSpectating") and p_u_297.Player then
        if not p_u_297.FighterInterface then
            local function v298()
                -- upvalues: (ref) v_u_201, (copy) p_u_297
                return v_u_201().new(p_u_297)
            end
            local v299, v300 = pcall(v298)
            if v299 then
                p_u_297.FighterInterface = v300
                p_u_297.InterfaceAdded:Fire(v300)
            else
                warn("[ClientFighter] interface failed to build: " .. tostring(v300))
            end
        end
    else
        p_u_297:ClearInterface()
    end
end
function v_u_8.ClearInterface(p301) -- name: ClearInterface
    local v302 = p301.FighterInterface
    if v302 then
        p301.FighterInterface = nil
        p301.InterfaceRemoved:Fire()
        local v303 = v302.Destroy
        pcall(v303, v302)
    end
end
function v_u_8.ClearSounds(_) -- name: ClearSounds end
function v_u_8.Ping(_) -- name: Ping end
local v_u_304 = {
    ["Slide"] = { "rbxassetid://107823842483100", 0.375 },
    ["DoubleJump"] = { "rbxassetid://121581577562065", 0.75 },
    ["Warp"] = { "rbxassetid://121581577562065", 1 }
}
function v_u_8.PlayMechanicsSound(p305, p306) -- name: PlayMechanicsSound
    -- upvalues: (copy) v_u_304, (copy) v_u_123
    local v307 = v_u_304[p306]
    local v308 = p305.Entity
    if v308 then
        v308 = p305.Entity.RootPart
    end
    if v307 and v308 then
        return v_u_123:CreateSound(v307[1], v307[2], 1, v308, true, 5)
    end
    local v309 = Instance.new("Sound")
    v309.Name = tostring(p306)
    return v309
end
function v_u_8.Destroy(p310) -- name: Destroy
    -- upvalues: (copy) v_u_9, (copy) v_u_5
    for v311 = #p310.Items, 1, -1 do
        p310:_RemoveItem(p310.Items[v311]:Get("ObjectID"))
    end
    p310:ClearInterface()
    p310:_RemoveEntity()
    for _, v312 in v_u_9 do
        p310[v312]:Destroy()
    end
    v_u_5.Destroy(p310)
end
return v_u_8
