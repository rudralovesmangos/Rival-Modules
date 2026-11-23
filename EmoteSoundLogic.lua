-- Script Path: game:GetService("StarterPlayer").StarterPlayerScripts.Controllers.EmoteController.EmoteSoundLogic
-- Took 0s to decompile.

local v1 = game:GetService("ReplicatedStorage")
local v2 = game:GetService("Players")
local v_u_3 = require(v1.Modules.CosmeticLibrary)
local v_u_4 = require(v2.LocalPlayer.PlayerScripts.Controllers.SpectateController)
local v_u_5 = require(v2.LocalPlayer.PlayerScripts.Controllers.FighterController)
local v_u_6 = {}
v_u_6.__index = v_u_6
function v_u_6.new(p7) -- name: new
    -- upvalues: (copy) v_u_6
    local v8 = v_u_6
    local v9 = setmetatable({}, v8)
    v9.EmoteController = p7
    v9._emotes_order = {}
    v9:_Init()
    return v9
end
function v_u_6._GetDistance(_, p10) -- name: _GetDistance
    local v11 = workspace.CurrentCamera.CFrame.Position
    local v12 = p10.Entity and p10.Entity.RootPart
    if v12 then
        v12 = p10.Entity.RootPart.Position
    end
    if v12 then
        return (v11 - v12).Magnitude
    else
        return nil
    end
end
function v_u_6._IsValidFighter(p13, p14) -- name: _IsValidFighter
    -- upvalues: (copy) v_u_4
    local v15
    if v_u_4.CurrentSubject then
        v15 = v_u_4.CurrentSubject:Get("EnvironmentID")
    elseif v_u_4.CurrentDuelSubject then
        v15 = v_u_4.CurrentDuelSubject:Get("EnvironmentID")
    else
        v15 = nil
    end
    if v15 ~= p14:Get("EnvironmentID") then
        return false
    end
    local v16 = p13:_GetDistance(p14)
    return v16 and v16 <= 128 and true or false
end
function v_u_6._VerifyEmotesOrder(p_u_17) -- name: _VerifyEmotesOrder
    -- upvalues: (copy) v_u_5, (copy) v_u_3
    local v18 = {}
    for v19 = #p_u_17._emotes_order, 1, -1 do
        local v20 = p_u_17._emotes_order[v19]
        v18[v20.ClientFighter] = true
        if not v20.Emote:IsDestroyed() and p_u_17:_IsValidFighter(v20.ClientFighter) then
            continue
        end
        v20.Emote:HideSounds(false)
        table.remove(p_u_17._emotes_order, v19)
    end
    for _, v21 in pairs(v_u_5.Objects) do
        if v18[v21] then
            continue
        end
        local v22 = v21.Entity and v21.Entity:IsEmoting()
        if v22 then
            v22 = v21.Entity:GetCurrentEmote()
        end
        if not (v22 and (v_u_3.Cosmetics[v22.Name].IsAudioIntrusive and p_u_17:_IsValidFighter(v21))) then
            continue
        end
        local v23 = p_u_17._emotes_order
        table.insert(v23, {
            ["Emote"] = v22,
            ["ClientFighter"] = v21
        })
    end
    table.clear(v18)
    table.sort(p_u_17._emotes_order, function(p24, p25)
        -- upvalues: (copy) p_u_17
        return p_u_17:_GetDistance(p24.ClientFighter) < p_u_17:_GetDistance(p25.ClientFighter)
    end)
end
function v_u_6._Check(p26) -- name: _Check
    -- upvalues: (copy) v_u_4, (copy) v_u_3
    p26:_VerifyEmotesOrder()
    local v27 = v_u_4:IsSubjectEmoting()
    if v27 then
        v27 = v_u_3.Cosmetics[v_u_4.CurrentSubject.Entity:GetCurrentEmote().Name].IsAudioIntrusive
    end
    for v28, v29 in pairs(p26._emotes_order) do
        if v27 then
            v29.Emote:HideSounds(v29.ClientFighter ~= v_u_4.CurrentSubject)
        else
            v29.Emote:HideSounds(v28 > 1)
        end
    end
end
function v_u_6._CheckLoop(p30) -- name: _CheckLoop
    while true do
        p30:_Check()
        wait(1)
    end
end
function v_u_6._FighterAdded(p_u_31, p32, p_u_33) -- name: _FighterAdded
    local function v35(p34) -- name: entity_added
        -- upvalues: (copy) p_u_31, (copy) p_u_33
        p34.EmoteStatusChanged:Connect(function()
            -- upvalues: (ref) p_u_31
            p_u_31:_Check()
        end)
        if not p_u_33 then
            p_u_31:_Check()
        end
    end
    p32.EntityAdded:Connect(v35)
    if p32.Entity then
        task.spawn(v35, p32.Entity)
    end
    if not p_u_33 then
        p_u_31:_Check()
    end
end
function v_u_6._Init(p_u_36) -- name: _Init
    -- upvalues: (copy) v_u_4, (copy) v_u_5
    v_u_4.SubjectEmoteStatusChanged:Connect(function()
        -- upvalues: (copy) p_u_36
        p_u_36:_Check()
    end)
    v_u_5.ObjectAdded:Connect(function(p37)
        -- upvalues: (copy) p_u_36
        p_u_36:_FighterAdded(p37)
    end)
    for _, v38 in pairs(v_u_5.Objects) do
        task.spawn(p_u_36._FighterAdded, p_u_36, v38, true)
    end
    task.defer(p_u_36._CheckLoop, p_u_36)
end
return v_u_6
