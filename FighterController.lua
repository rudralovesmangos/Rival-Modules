-- Script Path: game:GetService("StarterPlayer").StarterPlayerScripts.Controllers.FighterController
-- Took 0.02s to decompile.

local v_u_1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("StarterGui")
game:GetService("RunService")
local v_u_3 = game:GetService("Players")
require(v_u_1.Modules.CONSTANTS)
local v_u_4 = require(v_u_1.Modules.EnumLibrary)
local v_u_5 = require(v_u_1.Modules.Utility)
require(v_u_3.LocalPlayer.PlayerScripts.Controllers.PlayerDataController)
local v_u_6 = require(v_u_3.LocalPlayer.PlayerScripts.Controllers.ControlsController)
local v_u_7 = require(v_u_3.LocalPlayer.PlayerScripts.Controllers.CameraController)
local v_u_8 = require(v_u_3.LocalPlayer.PlayerScripts.Modules.ReplicatedController)
local v_u_9 = v_u_3.LocalPlayer.PlayerScripts.Assets:WaitForChild("Misc"):WaitForChild("DefaultCharacter")
local v_u_10 = setmetatable({}, v_u_8)
v_u_10.__index = v_u_10
function v_u_10._new() -- name: _new
    -- upvalues: (copy) v_u_8, (copy) v_u_10
    local v11 = v_u_8.new("Fighter")
    local v12 = v_u_10
    local v13 = setmetatable(v11, v12)
    v13.LocalFighter = nil
    v13._network_id_map = {}
    v13._last_connection_level = nil
    v13._player_to_fighter = {}
    v13._model_to_fighter = {}
    v13._last_controls_replicated_time = 0
    v13._character_model_cache = {}
    v13:_Init()
    return v13
end
function v_u_10.GetFighter(p14, p15) -- name: GetFighter
    -- upvalues: (copy) v_u_3
    local v16 = p14._player_to_fighter[p15] or p14._model_to_fighter[p15]
    if v16 then
        return v16
    elseif p15 then
        if typeof(p15) == "Instance" then
            if not p15:IsA("Player") then
                return p14:GetFighter(v_u_3:GetPlayerFromCharacter(p15))
            end
            for v17, v18 in pairs(p14.Objects) do
                if v18.Player ~= p15 then
                    continue
                end
                return v18, v17
            end
            return nil
        end
        if typeof(p15) == "number" then
            return p14:GetFighter(v_u_3:GetPlayerByUserId(p15))
        end
        local v19 = "Argument 1 invalid, expected a Player or a Model or nil, got " .. tostring(p15) .. " (type: " .. (typeof(p15) == "Instance" and p15.ClassName or typeof(p15)) .. ")"
        assert(false, v19)
    end
end
function v_u_10.GetFighterFromNetworkID(p20, p21) -- name: GetFighterFromNetworkID
    return p20._network_id_map[p21]
end
function v_u_10.GetFightersNotInDuel(p22) -- name: GetFightersNotInDuel
    local v23 = {}
    for _, v24 in pairs(p22.Objects) do
        if v24:Get("IsInDuel") then
            continue
        end
        table.insert(v23, v24)
    end
    return v23
end
function v_u_10.GetEntities(p25) -- name: GetEntities
    local v26 = {}
    for _, v27 in pairs(p25.Objects) do
        if not v27.Entity then
            continue
        end
        local v28 = v27.Entity
        table.insert(v26, v28)
    end
    return v26
end
function v_u_10.GetFighterModels(p29, p30) -- name: GetFighterModels
    local v31 = {}
    for _, v32 in pairs(p29.Objects) do
        if not v32.Entity or p30 and v32.IsLocalPlayer then
            continue
        end
        local v33 = v32.Entity.Model
        table.insert(v31, v33)
    end
    return v31
end
function v_u_10.GetWrap(p34, p35) -- name: GetWrap
    for _, v36 in pairs(p34.Objects) do
        local v37 = v36:GetItem(p35)
        if not v37 then
            continue
        end
        return v37:GetWrap()
    end
end
function v_u_10.WaitForFighter(p38, ...) -- name: WaitForFighter
    while true do
        local v39 = p38:GetFighter(...)
        if v39 then
            break
        end
        p38.ObjectAdded:Wait()
    end
    return v39
end
function v_u_10.WaitForLocalFighter(p40) -- name: WaitForLocalFighter
    -- upvalues: (copy) v_u_3
    return p40:WaitForFighter(v_u_3.LocalPlayer)
end
function v_u_10.GenerateCharacterModel(p_u_41, p_u_42, p43) -- name: GenerateCharacterModel
    -- upvalues: (copy) v_u_3, (copy) v_u_9
    if p_u_41._character_model_cache[tostring(p_u_42)] then
        return p_u_41._character_model_cache[tostring(p_u_42)]
    end
    local function v56() -- name: generate
        -- upvalues: (ref) v_u_3, (copy) p_u_42, (copy) p_u_41
        local v44 = v_u_3.GetHumanoidDescriptionFromUserIdAsync
        local v45 = v_u_3
        local v46 = p_u_42
        local v47, v48 = pcall(v44, v45, v46)
        if v47 then
            v48.Torso = 15365012259
            v48.LeftArm = 15365010034
            v48.RightArm = 15365012263
            v48.LeftLeg = 15365010038
            v48.RightLeg = 15365010030
            local v49 = v_u_3.CreateHumanoidModelFromDescriptionAsync
            local v50 = v_u_3
            local v51 = Enum.HumanoidRigType.R15
            local v52, v53 = pcall(v49, v50, v48, v51)
            if v52 then
                p_u_41._preloaded_character_model = v53
                local v54 = {
                    ["Template"] = v53
                }
                local v55 = p_u_42
                p_u_41._character_model_cache[tostring(v55)] = v54
                return v54
            end
            warn("Failed to create humanoid model:", v53)
        else
            warn("Failed to fetch humanoid description:", v48)
        end
    end
    if p43 then
        return v56()
    end
    task.spawn(v56)
    return p_u_41._character_model_cache[tostring(p_u_42)] or {
        ["Template"] = v_u_9
    }
end
function v_u_10._VerifyEntityLoop(p_u_57) -- name: _VerifyEntityLoop
    -- upvalues: (copy) v_u_3, (copy) v_u_1
    local function v59() -- name: is_inaccurate
        -- upvalues: (copy) p_u_57, (ref) v_u_3
        local v58 = not (p_u_57.LocalFighter:Get("IsInDuel") or p_u_57.LocalFighter:Get("IsInShootingRange"))
        if v58 then
            v58 = not (v_u_3.LocalPlayer.Character and p_u_57.LocalFighter.Entity) or p_u_57.LocalFighter.Entity.Model ~= v_u_3.LocalPlayer.Character
        end
        return v58
    end
    while wait(1) do
        if not v59() then
            continue
        end
        wait(2)
        if not v59() then
            continue
        end
        v_u_1.Remotes.Replication.Fighter.VerifyClientEntity:FireServer()
        wait(10)
    end
end
function v_u_10._ConnectionLevelReplicationLoop(p60) -- name: _ConnectionLevelReplicationLoop
    -- upvalues: (copy) v_u_5, (copy) v_u_1
    while true do
        repeat
            wait(1)
        until p60.LocalFighter and p60.LocalFighter:Get("IsInDuel")
        local v61 = v_u_5:GetConnectionLevel((v_u_5:GetLocalConnectionPing()))
        if v61 == p60._last_connection_level then
            continue
        end
        p60._last_connection_level = v61
        v_u_1.Remotes.Replication.Fighter.UpdateConnectionLevel:FireServer(v61)
    end
end
function v_u_10._UpdateNetworkIDMap(p62) -- name: _UpdateNetworkIDMap
    p62._network_id_map = {}
    for _, v63 in pairs(p62.Objects) do
        local v64 = v63:Get("DecodedNetworkID")
        if not v64 then
            continue
        end
        p62._network_id_map[v64] = v63
    end
end
function v_u_10._FighterAdded(p_u_65, p_u_66) -- name: _FighterAdded
    p_u_66:GetDataChangedSignal("DecodedNetworkID"):Connect(function()
        -- upvalues: (copy) p_u_65
        p_u_65:_UpdateNetworkIDMap()
    end)
    p_u_66.EntityAdded:Connect(function(p67)
        -- upvalues: (copy) p_u_65, (copy) p_u_66
        p_u_65._model_to_fighter[p67.Model] = p_u_66
    end)
    p_u_66.EntityRemoved:Connect(function(_)
        -- upvalues: (copy) p_u_65, (copy) p_u_66
        for v68, v69 in pairs(p_u_65._model_to_fighter) do
            if v69 ~= p_u_66 then
                continue
            end
            p_u_65._model_to_fighter[v68] = nil
        end
    end)
    if p_u_66.Entity and p_u_66.Entity.Model then
        p_u_65._model_to_fighter[p_u_66.Entity.Model] = p_u_66
    end
    p_u_65._player_to_fighter[p_u_66.Player] = p_u_66
    p_u_65:_UpdateNetworkIDMap()
end
function v_u_10._ReplicateControls(p70) -- name: _ReplicateControls
    -- upvalues: (copy) v_u_6, (copy) v_u_1
    if p70.LocalFighter then
        local v71 = 0.2 - (tick() - p70._last_controls_replicated_time)
        local v72 = math.max(v71, 0.2)
        task.delay(v72, function()
            -- upvalues: (ref) v_u_6, (ref) v_u_1
            local v73 = v_u_6.CurrentControls
            if typeof(v73) == "string" then
                v_u_1.Remotes.Replication.Fighter.SetControls:FireServer(v_u_6.CurrentControls)
            end
        end)
    end
end
function v_u_10._CameraReplicationLoop(p74) -- name: _CameraReplicationLoop
    -- upvalues: (copy) v_u_1, (copy) v_u_7, (copy) v_u_5
    local function v76(p75) -- name: send
        -- upvalues: (ref) v_u_1
        if not p75 or utf8.len(p75) then
            v_u_1.Remotes.Replication.Fighter.UpdateCameraRotation:FireServer(p75, nil)
        end
    end
    local v77 = false
    local v78 = nil
    while true do
        while true do
            wait(0.1)
            if p74.LocalFighter and (p74.LocalFighter:Get("IsSpectating") and v_u_7:GetPublicState()) then
                break
            end
            if v77 then
                continue
            end
            task.defer(v76, v_u_5:EncodeCameraRotation(Vector2.zero))
            v77 = true
        end
        local v79 = v_u_5:EncodeCameraRotation(v_u_7.Rotation)
        if v77 or v79 ~= v78 then
            task.defer(v76, v79)
            v78 = v79
            v77 = false
        else
            v78 = v79
            v77 = false
        end
    end
end
function v_u_10._HookLocalFighter(p_u_80) -- name: _HookLocalFighter
    -- upvalues: (copy) v_u_7, (copy) v_u_1, (copy) v_u_2
    p_u_80.LocalFighter = p_u_80:WaitForLocalFighter()
    local function v81() -- name: update_third_person_overide
        -- upvalues: (ref) v_u_7, (copy) p_u_80
        v_u_7:SetThirdPersonOverride(p_u_80.LocalFighter:Get("ThirdPersonOverride"))
    end
    p_u_80.LocalFighter:GetDataChangedSignal("ThirdPersonOverride"):Connect(v81)
    task.defer(v81)
    local v_u_82 = 0
    local v_u_83 = Instance.new("BindableEvent")
    v_u_83.Event:Connect(function()
        -- upvalues: (ref) v_u_1
        v_u_1.Remotes.Replication.Fighter.ResetCharacter:FireServer()
    end)
    local function v91() -- name: update_reset_button
        -- upvalues: (ref) v_u_82, (ref) v_u_2, (copy) p_u_80, (copy) v_u_83
        v_u_82 = v_u_82 + 1
        local v84 = v_u_82
        while v_u_82 == v84 do
            local v85 = v_u_2.SetCore
            local v86 = v_u_2
            local v87 = "ResetButtonCallback"
            local v88 = not p_u_80.LocalFighter:Get("IsInDuel")
            if v88 then
                v88 = v_u_83
            end
            local v89, v90 = pcall(v85, v86, v87, v88)
            if v89 then
                break
            end
            warn("Failed to set reset button callback", v90)
            wait(0.1)
        end
    end
    p_u_80.LocalFighter:GetDataChangedSignal("IsInDuel"):Connect(v91)
    task.defer(v91)
    p_u_80:_ReplicateControls()
    task.defer(p_u_80._CameraReplicationLoop, p_u_80)
    task.defer(p_u_80._ConnectionLevelReplicationLoop, p_u_80)
    task.defer(p_u_80._VerifyEntityLoop, p_u_80)
end
function v_u_10._Setup(p92) -- name: _Setup
    -- upvalues: (copy) v_u_4, (copy) v_u_3
    function p92._reject_object_added_serial_callback(p93)
        -- upvalues: (ref) v_u_4, (ref) v_u_3
        local v94 = not p93[v_u_4:ToEnum("Player")]
        if v94 then
            v94 = not v_u_3:GetPlayerByUserId(p93[v_u_4:ToEnum("UserID")])
        end
        return v94
    end
end
function v_u_10._Init(p_u_95) -- name: _Init
    -- upvalues: (copy) v_u_6, (copy) v_u_1, (copy) v_u_5
    p_u_95.ObjectAdded:Connect(function(p96)
        -- upvalues: (copy) p_u_95
        p_u_95:_FighterAdded(p96)
    end)
    p_u_95.ObjectRemoved:Connect(function(p97)
        -- upvalues: (copy) p_u_95
        for v98, v99 in pairs(p_u_95._player_to_fighter) do
            if v99 ~= p97 then
                continue
            end
            p_u_95._model_to_fighter[v98] = nil
        end
        for v100, v101 in pairs(p_u_95._model_to_fighter) do
            if v101 ~= p97 then
                continue
            end
            p_u_95._model_to_fighter[v100] = nil
        end
    end)
    v_u_6.ControlsChanged:Connect(function()
        -- upvalues: (copy) p_u_95
        p_u_95:_ReplicateControls()
    end)
    v_u_1.Remotes.Replication.Fighter.UpdateCameraRotations.OnClientEvent:Connect(function(p102)
        -- upvalues: (ref) v_u_5, (copy) p_u_95
        local v103 = v_u_5:DecodeCameraRotationBulk(p102)
        for _, v104 in pairs(v103) do
            local v105, v106, v107 = table.unpack(v104)
            local v108 = p_u_95:GetFighterFromNetworkID(v105)
            if not v108 then
                continue
            end
            v108:SetReplicate("CameraRotation", v_u_5:FromXYToCameraRotation(v106, v107))
        end
    end)
    for _, v109 in pairs(p_u_95.Objects) do
        task.spawn(p_u_95._FighterAdded, p_u_95, v109)
    end
    p_u_95:_Setup()
    task.defer(p_u_95._HookLocalFighter, p_u_95)
end
return v_u_10._new()
