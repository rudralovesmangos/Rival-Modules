-- Script Path: game:GetService("StarterPlayer").StarterCharacterScripts.Animate
-- Took 0.03s to decompile.

local v_u_1 = script.Parent
local v_u_2 = v_u_1:WaitForChild("Humanoid")
local v_u_3 = "Standing"
UserSettings():GetService("UserGameSettings")
local _, _ = pcall(function()
    return UserSettings():IsUserFeatureEnabled("UserNoUpdateOnLoop")
end)
local v4, v5 = pcall(function()
    return UserSettings():IsUserFeatureEnabled("UserAnimateScaleRun")
end)
local v_u_6 = v4 and v5
local v_u_7 = script:FindFirstChild("ScaleDampeningPercent")
local v_u_8 = 0
local v_u_9 = 0
local v_u_10 = {
    ["x"] = 0,
    ["y"] = 0
}
local v_u_11 = 0
local v_u_12 = ""
local v_u_13 = nil
local v_u_14 = nil
local v_u_15 = nil
local v_u_16 = 1
local v_u_17 = {}
local v_u_18 = {}
local v_u_19 = {
    ["idle"] = {
        {
            ["id"] = "http://www.roblox.com/asset/?id=507766666",
            ["weight"] = 1
        },
        {
            ["id"] = "http://www.roblox.com/asset/?id=507766951",
            ["weight"] = 1
        },
        {
            ["id"] = "http://www.roblox.com/asset/?id=507766388",
            ["weight"] = 9
        }
    },
    ["walk"] = {
        {
            ["id"] = "http://www.roblox.com/asset/?id=507777826",
            ["weight"] = 10
        }
    },
    ["run"] = {
        {
            ["id"] = "http://www.roblox.com/asset/?id=507767714",
            ["weight"] = 10
        }
    },
    ["swim"] = {
        {
            ["id"] = "http://www.roblox.com/asset/?id=507784897",
            ["weight"] = 10
        }
    },
    ["swimidle"] = {
        {
            ["id"] = "http://www.roblox.com/asset/?id=507785072",
            ["weight"] = 10
        }
    },
    ["jump"] = {
        {
            ["id"] = "http://www.roblox.com/asset/?id=507765000",
            ["weight"] = 10
        }
    },
    ["fall"] = {
        {
            ["id"] = "http://www.roblox.com/asset/?id=507767968",
            ["weight"] = 10
        }
    },
    ["climb"] = {
        {
            ["id"] = "http://www.roblox.com/asset/?id=507765644",
            ["weight"] = 10
        }
    },
    ["sit"] = {
        {
            ["id"] = "http://www.roblox.com/asset/?id=2506281703",
            ["weight"] = 10
        }
    },
    ["toolnone"] = {
        {
            ["id"] = "http://www.roblox.com/asset/?id=507768375",
            ["weight"] = 10
        }
    },
    ["toolslash"] = {
        {
            ["id"] = "http://www.roblox.com/asset/?id=522635514",
            ["weight"] = 10
        }
    },
    ["toollunge"] = {
        {
            ["id"] = "http://www.roblox.com/asset/?id=522638767",
            ["weight"] = 10
        }
    }
}
local v_u_20 = {}
local v_u_21 = {}
local v_u_22 = v_u_20
local v_u_23 = {}
math.randomseed(tick())
function findExistingAnimationInSet(p24, p25) -- name: findExistingAnimationInSet
    if p24 == nil or p25 == nil then
        return 0
    end
    for v26 = 1, p24.count do
        if p24[v26].anim.AnimationId ~= p25.AnimationId then
            continue
        end
        return v26
    end
    return 0
end
local function v_u_29() -- name: destroyWalkAnimations
    -- upvalues: (copy) v_u_20, (copy) v_u_21, (ref) v_u_9
    for _, v27 in pairs(v_u_20) do
        if not v27.track then
            continue
        end
        v27.track:Stop()
        v27.track:Destroy()
        v27.track = nil
    end
    for _, v28 in pairs(v_u_21) do
        if not v28.track then
            continue
        end
        v28.track:Stop()
        v28.track:Destroy()
        v28.track = nil
    end
    v_u_9 = 0
end
local v_u_30 = nil
local v_u_31 = nil
local v_u_32 = nil
local v_u_33 = nil
local function v_u_34(_) -- name: checkStrafingEnabled
    -- upvalues: (ref) v_u_30, (ref) v_u_31, (ref) v_u_32, (ref) v_u_33, (ref) v_u_22, (copy) v_u_20, (copy) v_u_21
    if v_u_30 == 0 or (v_u_31 == 0 or (v_u_32 == 0 or v_u_33 == 0)) then
        if v_u_22 == v_u_20 then
            warn("Strafe blending disabled.  Not all quadrants of motion represented.")
        end
        v_u_22 = v_u_21
        return
    elseif v_u_20.run and v_u_20.walk then
        if v_u_22 ~= v_u_20 then
            v_u_22 = v_u_20
            warn("Strafing reenabled")
        end
    else
        if v_u_22 == v_u_20 then
            warn("Strafe blending disabled.  Run and walk must be strafing-friendly.")
        end
        v_u_22 = v_u_21
    end
end
local function v_u_39() -- name: setupWalkAnimations
    -- upvalues: (ref) v_u_31, (ref) v_u_30, (ref) v_u_33, (ref) v_u_32, (copy) v_u_20, (copy) v_u_34, (ref) v_u_22, (copy) v_u_2, (copy) v_u_18
    v_u_31 = 0
    v_u_30 = 0
    v_u_33 = 0
    v_u_32 = 0
    for _, v35 in pairs(v_u_20) do
        local v36 = v35.lv
        if not v36 then
            continue
        end
        if v_u_30 < v36.x then
            v_u_30 = v36.x
        end
        if v_u_32 < v36.y then
            v_u_32 = v36.y
        end
        if v36.x < v_u_31 then
            v_u_31 = v36.x
        end
        if v36.y >= v_u_33 then
            continue
        end
        v_u_33 = v36.y
    end
    v_u_34()
    for v37, v38 in pairs(v_u_22) do
        v38.track = v_u_2:LoadAnimation(v_u_18[v37][1].anim)
        v38.track.Priority = Enum.AnimationPriority.Core
    end
end
local function v_u_44(p40, p41) -- name: replaceLocomotionTrack
    -- upvalues: (ref) v_u_12, (ref) v_u_22, (copy) v_u_29, (copy) v_u_20, (copy) v_u_21, (copy) v_u_39, (ref) v_u_11
    local v42
    if v_u_12 == "walk" and v_u_22[p40] then
        v_u_29()
        v42 = true
    else
        v42 = false
    end
    if p41 then
        v_u_20[p40] = {
            ["lv"] = p41,
            ["speed"] = p41.Magnitude
        }
    else
        v_u_20[p40] = nil
    end
    if p40 == "run" or p40 == "walk" then
        if p41 then
            v_u_21[p40] = v_u_20[p40]
        else
            local v43 = p40 == "run" and 12.8 or 6.4
            v_u_21[p40] = {
                ["lv"] = Vector2.new(0, v43),
                ["speed"] = v43
            }
            v_u_20[p40] = nil
        end
    end
    if v42 then
        v_u_39()
        v_u_11 = 0
    end
end
function configureAnimationSet(p_u_45, p_u_46) -- name: configureAnimationSet
    -- upvalues: (copy) v_u_18, (copy) v_u_44, (copy) v_u_17, (copy) v_u_2
    if v_u_18[p_u_45] ~= nil then
        for _, v47 in pairs(v_u_18[p_u_45].connections) do
            v47:disconnect()
        end
    end
    v_u_18[p_u_45] = {}
    v_u_18[p_u_45].count = 0
    v_u_18[p_u_45].totalWeight = 0
    v_u_18[p_u_45].connections = {}
    local v48 = script:FindFirstChild(p_u_45)
    if v48 ~= nil then
        local v49 = v_u_18[p_u_45].connections
        local v50 = v48.ChildAdded
        table.insert(v49, v50:connect(function(_)
            -- upvalues: (copy) p_u_45, (copy) p_u_46
            configureAnimationSet(p_u_45, p_u_46)
        end))
        local v51 = v_u_18[p_u_45].connections
        local v52 = v48.ChildRemoved
        table.insert(v51, v52:connect(function(_)
            -- upvalues: (copy) p_u_45, (copy) p_u_46
            configureAnimationSet(p_u_45, p_u_46)
        end))
        for _, v53 in pairs(v48:GetChildren()) do
            if not v53:IsA("Animation") then
                continue
            end
            local v54 = v53:FindFirstChild("Weight")
            local v55 = v54 == nil and 1 or v54.Value
            v_u_18[p_u_45].count = v_u_18[p_u_45].count + 1
            local v56 = v_u_18[p_u_45].count
            v_u_18[p_u_45][v56] = {}
            v_u_18[p_u_45][v56].anim = v53
            v_u_18[p_u_45][v56].weight = v55
            v_u_18[p_u_45].totalWeight = v_u_18[p_u_45].totalWeight + v_u_18[p_u_45][v56].weight
            local v57 = v_u_18[p_u_45].connections
            local v58 = v53.Changed
            table.insert(v57, v58:connect(function(_)
                -- upvalues: (copy) p_u_45, (copy) p_u_46
                configureAnimationSet(p_u_45, p_u_46)
            end))
            local v59 = v_u_18[p_u_45].connections
            local v60 = v53.ChildAdded
            table.insert(v59, v60:connect(function(_)
                -- upvalues: (copy) p_u_45, (copy) p_u_46
                configureAnimationSet(p_u_45, p_u_46)
            end))
            local v61 = v_u_18[p_u_45].connections
            local v62 = v53.ChildRemoved
            table.insert(v61, v62:connect(function(_)
                -- upvalues: (copy) p_u_45, (copy) p_u_46
                configureAnimationSet(p_u_45, p_u_46)
            end))
            v_u_44(p_u_45, (v53:GetAttribute("LinearVelocity")))
        end
    end
    if v_u_18[p_u_45].count <= 0 then
        for v63, v64 in pairs(p_u_46) do
            v_u_18[p_u_45][v63] = {}
            v_u_18[p_u_45][v63].anim = Instance.new("Animation")
            v_u_18[p_u_45][v63].anim.Name = p_u_45
            v_u_18[p_u_45][v63].anim.AnimationId = v64.id
            v_u_18[p_u_45][v63].weight = v64.weight
            v_u_18[p_u_45].count = v_u_18[p_u_45].count + 1
            v_u_18[p_u_45].totalWeight = v_u_18[p_u_45].totalWeight + v64.weight
        end
    end
    for _, v65 in pairs(v_u_18) do
        for v66 = 1, v65.count do
            if v_u_17[v65[v66].anim.AnimationId] ~= nil then
                continue
            end
            v_u_2:LoadAnimation(v65[v66].anim)
            v_u_17[v65[v66].anim.AnimationId] = true
        end
    end
end
function scriptChildModified(p67) -- name: scriptChildModified
    -- upvalues: (copy) v_u_19
    local v68 = v_u_19[p67.Name]
    if v68 == nil then
        if p67:isA("StringValue") then
            v_u_19[p67.Name] = {}
            configureAnimationSet(p67.Name, v_u_19[p67.Name])
        end
    else
        configureAnimationSet(p67.Name, v68)
    end
end
script.ChildAdded:connect(scriptChildModified)
script.ChildRemoved:connect(scriptChildModified)
local v69
if v_u_2 then
    v69 = v_u_2:FindFirstChildOfClass("Animator")
else
    v69 = nil
end
local v_u_70, v_u_71, v_u_72, v_u_73
if v69 then
    local v74 = v69:GetPlayingAnimationTracks()
    v_u_70 = v_u_22
    v_u_71 = v_u_9
    v_u_72 = v_u_12
    v_u_73 = v_u_11
    for _, v75 in ipairs(v74) do
        v75:Stop(0)
        v75:Destroy()
    end
else
    v_u_70 = v_u_22
    v_u_71 = v_u_9
    v_u_72 = v_u_12
    v_u_73 = v_u_11
end
for v76, v77 in pairs(v_u_19) do
    configureAnimationSet(v76, v77)
end
for _, v78 in script:GetChildren() do
    if not v78:isA("StringValue") then
        continue
    end
    v_u_19[v78.Name] = {}
    configureAnimationSet(v78.Name, v_u_19[v78.Name])
end
local v_u_79 = "None"
local v_u_80 = 0
local v_u_81 = 0
local v_u_82 = false
function stopAllAnimations() -- name: stopAllAnimations
    -- upvalues: (ref) v_u_72, (copy) v_u_23, (ref) v_u_82, (ref) v_u_13, (ref) v_u_15, (ref) v_u_14, (ref) v_u_70
    local v83 = v_u_72
    local v84 = v_u_23[v83] ~= nil and v_u_23[v83] == false and "idle" or v83
    if v_u_82 then
        v84 = "idle"
        v_u_82 = false
    end
    v_u_72 = ""
    v_u_13 = nil
    if v_u_15 ~= nil then
        v_u_15:disconnect()
    end
    if v_u_14 ~= nil then
        v_u_14:Stop()
        v_u_14:Destroy()
        v_u_14 = nil
    end
    for _, v85 in pairs(v_u_70) do
        if not v85.track then
            continue
        end
        v85.track:Stop()
        v85.track:Destroy()
        v85.track = nil
    end
    return v84
end
local function v_u_86() -- name: getRigScale
    -- upvalues: (copy) v_u_6, (copy) v_u_1
    return not v_u_6 and 1 or v_u_1:GetScale()
end
function getHeightScale() -- name: getHeightScale
    -- upvalues: (copy) v_u_2, (copy) v_u_86, (ref) v_u_7
    if not v_u_2 then
        return v_u_86()
    end
    if not v_u_2.AutomaticScalingEnabled then
        return v_u_86()
    end
    local v87 = v_u_2.HipHeight / 2
    if v_u_7 == nil then
        v_u_7 = script:FindFirstChild("ScaleDampeningPercent")
    end
    if v_u_7 ~= nil then
        v87 = 1 + (v_u_2.HipHeight - 2) * v_u_7.Value / 2
    end
    return v87
end
local function v_u_103(p88, p89, p90, p91, p92, p93) -- name: get2DWeight
    local v94 = 0.5 * (p92 + p93)
    local v95 = {
        ["x"] = (p91 - p92) / v94
    }
    local v96 = p89.x * p88.y - p89.y * p88.x
    local v97 = p89.x * p88.x + p89.y * p88.y
    v95.y = 2 * -math.atan2(v96, v97)
    local v98 = {
        ["x"] = (p93 - p92) / v94
    }
    local v99 = p89.x * p90.y - p89.y * p90.x
    local v100 = p89.x * p90.x + p89.y * p90.y
    v98.y = 2 * -math.atan2(v99, v100)
    local v101 = 0.0001 + (v98.x * v98.x + v98.y * v98.y)
    local v102 = 1 - (v95.x * v98.x + v95.y * v98.y) / v101
    return math.clamp(v102, 0, 1)
end
local function v_u_128(p104, p105) -- name: blend2D
    -- upvalues: (copy) v_u_6, (ref) v_u_70, (copy) v_u_103
    if v_u_6 then
        local v106 = getHeightScale()
        p104 = p104 / v106
        p105 = p105 / v106
    end
    local v107 = {}
    local v108 = 0
    for v109, v110 in pairs(v_u_70) do
        if p104.x * v110.lv.x < 0 or p104.y * v110.lv.y < 0 then
            v107[v109] = 0
        else
            v107[v109] = (1 / 0)
            for _, v111 in pairs(v_u_70) do
                if p104.x * v111.lv.x < 0 or p104.y * v111.lv.y < 0 then
                    continue
                end
                local v112 = v107[v109]
                local v113 = v_u_103(p104, v110.lv, v111.lv, p105, v110.speed, v111.speed)
                v107[v109] = math.min(v112, v113)
            end
            v108 = v108 + v107[v109]
        end
    end
    local v114 = 0
    local v115 = 0
    local v116 = 0
    for v117, v118 in pairs(v_u_70) do
        if v107[v117] / v108 > 0.1 then
            v114 = v114 + v107[v117]
            v115 = v115 + v107[v117] * v118.lv.x
            v116 = v116 + v107[v117] * v118.lv.y
        else
            v107[v117] = 0
        end
    end
    local v119 = v115 * v115 + v116 * v116
    local v120
    if v119 > 0.0001 then
        local v121 = p105 * p105 / v119
        v120 = math.sqrt(v121)
    else
        v120 = 0
    end
    if not v_u_6 then
        v120 = v120 / getHeightScale()
    end
    local v122 = 0
    for _, v123 in pairs(v_u_70) do
        if not v123.track.IsPlaying then
            continue
        end
        v122 = v123.track.TimePosition
    end
    for v124, v125 in pairs(v_u_70) do
        if v107[v124] > 0 then
            if not v125.track.IsPlaying then
                v125.track:Play(0.2)
                v125.track.TimePosition = v122
            end
            local v126 = v107[v124] / v114
            local v127 = math.max(0.0001, v126)
            v125.track:AdjustWeight(v127, 0.2)
            v125.track:AdjustSpeed(v120)
        else
            v125.track:Stop(0.2)
        end
    end
end
local function v_u_136() -- name: getWalkDirection
    -- upvalues: (copy) v_u_2
    local v129 = v_u_2.WalkToPoint
    local v130 = v_u_2.WalkToPart
    if v_u_2.MoveDirection ~= Vector3.new(0, 0, 0) then
        return v_u_2.MoveDirection
    end
    if not v130 and v129 == Vector3.new(0, 0, 0) then
        return v_u_2.MoveDirection
    end
    if v130 then
        v129 = v130.CFrame:PointToWorldSpace(v129)
    end
    local v131
    if v_u_2.RootPart then
        local v132 = v129 - v_u_2.RootPart.CFrame.Position
        local v133 = v132.x
        local v134 = v132.z
        v131 = Vector3.new(v133, 0, v134)
        local v135 = v131.Magnitude
        if v135 > 0.01 then
            v131 = v131 / v135
        end
    else
        v131 = Vector3.new(0, 0, 0)
    end
    return v131
end
local function v_u_154(p137) -- name: updateVelocity
    -- upvalues: (ref) v_u_70, (copy) v_u_20, (copy) v_u_136, (copy) v_u_2, (ref) v_u_3, (ref) v_u_8, (ref) v_u_10, (ref) v_u_71, (ref) v_u_73, (copy) v_u_128
    if v_u_70 == v_u_20 then
        local v138 = v_u_136()
        if not v_u_2.RootPart then
            return
        end
        local v139 = v_u_2.RootPart.CFrame
        local v140 = v139.UpVector.Y
        if math.abs(v140) < 0.0001 or (v_u_3 ~= "Running" or v_u_8 < 0.001) then
            for _, v141 in pairs(v_u_70) do
                if not v141.track then
                    continue
                end
                v141.track:AdjustWeight(0.0001, 0.2)
            end
            return
        end
        local v142 = v139.LookVector
        local v143 = v142.X
        local v144 = v142.Z
        local v145 = Vector3.new(v143, 0, v144)
        local v146 = v145 / v145.Magnitude
        local v147 = v138:Dot(v146)
        local v148 = v147 <= 0 and v147 > -0.05 and 0.0001 or v147
        local v149 = v146.X * v138.Z - v146.Z * v138.X
        local v150 = Vector2.new(v149, v148)
        local v151 = Vector2.new(v150.x - v_u_10.x, v150.y - v_u_10.y)
        if v151:Dot(v151) > 0.001 then
            v_u_10 = v150
            v_u_71 = v_u_8
            v_u_73 = p137
            v_u_128(v_u_10, v_u_71)
            return
        else
            local v152 = v_u_8 - v_u_71
            if math.abs(v152) > 0.01 or p137 - v_u_73 > 1 then
                v_u_10 = v150
                v_u_71 = v_u_8
                v_u_73 = p137
                v_u_128(v_u_10, v_u_71)
            end
        end
    else
        local v153 = v_u_8 - v_u_71
        if math.abs(v153) > 0.01 or p137 - v_u_73 > 1 then
            v_u_71 = v_u_8
            v_u_73 = p137
            v_u_128(Vector2.yAxis, v_u_71)
        end
        return
    end
end
function setAnimationSpeed(p155) -- name: setAnimationSpeed
    -- upvalues: (ref) v_u_72, (ref) v_u_16, (ref) v_u_14
    if v_u_72 ~= "walk" and p155 ~= v_u_16 then
        v_u_16 = p155
        v_u_14:AdjustSpeed(v_u_16)
    end
end
function keyFrameReachedFunc(p156) -- name: keyFrameReachedFunc
    -- upvalues: (ref) v_u_72, (copy) v_u_23, (ref) v_u_82, (ref) v_u_14, (ref) v_u_16, (copy) v_u_2
    if p156 == "End" then
        local v157 = v_u_72
        local v158 = v_u_23[v157] ~= nil and v_u_23[v157] == false and "idle" or v157
        if v_u_82 then
            if v_u_14.Looped then
                return
            end
            v158 = "idle"
            v_u_82 = false
        end
        local v159 = v_u_16
        playAnimation(v158, 0.15, v_u_2)
        setAnimationSpeed(v159)
    end
end
function rollAnimation(p160) -- name: rollAnimation
    -- upvalues: (copy) v_u_18
    local v161 = math.random(1, v_u_18[p160].totalWeight)
    local v162 = 1
    while v_u_18[p160][v162].weight < v161 do
        v161 = v161 - v_u_18[p160][v162].weight
        v162 = v162 + 1
    end
    return v162
end
local function v_u_168(p163, p164, p165, p166, p167) -- name: switchToAnim
    -- upvalues: (ref) v_u_13, (ref) v_u_14, (ref) v_u_15, (ref) v_u_16, (ref) v_u_72, (copy) v_u_39, (copy) v_u_29
    if p163 ~= v_u_13 or p167 then
        if v_u_14 ~= nil then
            v_u_14:Stop(p165)
            v_u_14:Destroy()
        end
        if v_u_15 ~= nil then
            v_u_15:disconnect()
            v_u_15 = nil
        end
        v_u_16 = 1
        v_u_72 = p164
        v_u_13 = p163
        if p164 == "walk" then
            v_u_39()
            return
        end
        v_u_29()
        v_u_14 = p166:LoadAnimation(p163)
        v_u_14.Priority = Enum.AnimationPriority.Core
        v_u_14:Play(p165)
        v_u_15 = v_u_14.KeyframeReached:connect(keyFrameReachedFunc)
    end
end
local v_u_169 = nil
function playAnimation(p170, p171, p172, ...) -- name: playAnimation
    -- upvalues: (ref) v_u_169, (copy) v_u_18, (copy) v_u_168, (ref) v_u_82
    v_u_169 = { p170, p171, p172 }
    local v173 = rollAnimation(p170)
    v_u_168(v_u_18[p170][v173].anim, p170, p171, p172, ...)
    v_u_82 = false
end
script:WaitForChild("Refresh").Event:Connect(function(...)
    -- upvalues: (ref) v_u_169
    if v_u_169 then
        for _, v174 in pairs(script.Parent.Humanoid:GetPlayingAnimationTracks()) do
            v174:Stop()
            v174:Destroy()
        end
        script.RefreshServer:FireServer()
        playAnimation(v_u_169[1], v_u_169[2], v_u_169[3], true, ...)
    end
end)
function playEmote(p175, p176, p177) -- name: playEmote
    -- upvalues: (copy) v_u_168, (ref) v_u_82
    v_u_168(p175, p175.Name, p176, p177)
    v_u_82 = true
end
local v_u_178 = ""
local v_u_179 = nil
local v_u_180 = nil
local v_u_181 = nil
function toolKeyFrameReachedFunc(p182) -- name: toolKeyFrameReachedFunc
    -- upvalues: (ref) v_u_178, (copy) v_u_2
    if p182 == "End" then
        playToolAnimation(v_u_178, 0, v_u_2)
    end
end
function playToolAnimation(p183, p184, p185, p186) -- name: playToolAnimation
    -- upvalues: (copy) v_u_18, (ref) v_u_180, (ref) v_u_179, (ref) v_u_178, (ref) v_u_181
    local v187 = rollAnimation(p183)
    local v188 = v_u_18[p183][v187].anim
    if v_u_180 ~= v188 then
        if v_u_179 ~= nil then
            v_u_179:Stop()
            v_u_179:Destroy()
            p184 = 0
        end
        v_u_179 = p185:LoadAnimation(v188)
        if p186 then
            v_u_179.Priority = p186
        end
        v_u_179:Play(p184)
        v_u_178 = p183
        v_u_180 = v188
        v_u_181 = v_u_179.KeyframeReached:connect(toolKeyFrameReachedFunc)
    end
end
function stopToolAnimations() -- name: stopToolAnimations
    -- upvalues: (ref) v_u_178, (ref) v_u_181, (ref) v_u_180, (ref) v_u_179
    local v189 = v_u_178
    if v_u_181 ~= nil then
        v_u_181:disconnect()
    end
    v_u_178 = ""
    v_u_180 = nil
    if v_u_179 ~= nil then
        v_u_179:Stop()
        v_u_179:Destroy()
        v_u_179 = nil
    end
    return v189
end
function onRunning(p190) -- name: onRunning
    -- upvalues: (copy) v_u_6, (ref) v_u_82, (copy) v_u_2, (ref) v_u_8, (ref) v_u_3, (copy) v_u_154, (copy) v_u_23, (ref) v_u_72
    local v191 = not v_u_6 and 1 or getHeightScale()
    local v192 = v_u_82
    if v192 then
        v192 = v_u_2.MoveDirection == Vector3.new(0, 0, 0)
    end
    local v193 = v192 and (v_u_2.WalkSpeed / v191 or 0.75) or 0.75
    v_u_8 = p190
    if v193 * v191 < p190 then
        playAnimation("walk", 0.2, v_u_2)
        if v_u_3 ~= "Running" then
            v_u_3 = "Running"
            v_u_154(0)
            return
        end
    elseif v_u_23[v_u_72] == nil and not v_u_82 then
        playAnimation("idle", 0.2, v_u_2)
        v_u_3 = "Standing"
    end
end
function onDied() -- name: onDied
    -- upvalues: (ref) v_u_3
    v_u_3 = "Dead"
end
function onJumping() -- name: onJumping
    -- upvalues: (copy) v_u_2, (ref) v_u_81, (ref) v_u_3
    playAnimation("jump", 0.1, v_u_2)
    v_u_81 = 0.31
    v_u_3 = "Jumping"
end
function onClimbing(p194) -- name: onClimbing
    -- upvalues: (copy) v_u_6, (copy) v_u_2, (ref) v_u_3
    if v_u_6 then
        p194 = p194 / getHeightScale()
    end
    playAnimation("climb", 0.1, v_u_2)
    setAnimationSpeed(p194 / 5)
    v_u_3 = "Climbing"
end
function onGettingUp() -- name: onGettingUp
    -- upvalues: (ref) v_u_3
    v_u_3 = "GettingUp"
end
function onFreeFall() -- name: onFreeFall
    -- upvalues: (ref) v_u_81, (copy) v_u_2, (ref) v_u_3
    if v_u_81 <= 0 then
        playAnimation("fall", 0.2, v_u_2)
    end
    v_u_3 = "FreeFall"
end
function onFallingDown() -- name: onFallingDown
    -- upvalues: (ref) v_u_3
    v_u_3 = "FallingDown"
end
function onSeated() -- name: onSeated
    -- upvalues: (ref) v_u_3
    v_u_3 = "Seated"
end
function onPlatformStanding() -- name: onPlatformStanding
    -- upvalues: (ref) v_u_3
    v_u_3 = "PlatformStanding"
end
function onSwimming(p195) -- name: onSwimming
    -- upvalues: (copy) v_u_6, (copy) v_u_2, (ref) v_u_3
    if v_u_6 then
        p195 = p195 / getHeightScale()
    end
    if p195 > 1 then
        playAnimation("swim", 0.4, v_u_2)
        setAnimationSpeed(p195 / 10)
        v_u_3 = "Swimming"
    else
        playAnimation("swimidle", 0.4, v_u_2)
        v_u_3 = "Standing"
    end
end
function animateTool() -- name: animateTool
    -- upvalues: (ref) v_u_79, (copy) v_u_2
    if v_u_79 == "None" then
        playToolAnimation("toolnone", 0.1, v_u_2, Enum.AnimationPriority.Idle)
        return
    elseif v_u_79 == "Slash" then
        playToolAnimation("toolslash", 0, v_u_2, Enum.AnimationPriority.Action)
        return
    elseif v_u_79 == "Lunge" then
        playToolAnimation("toollunge", 0, v_u_2, Enum.AnimationPriority.Action)
    end
end
function getToolAnim(p196) -- name: getToolAnim
    for _, v197 in ipairs(p196:GetChildren()) do
        if v197.Name ~= "toolanim" or v197.className ~= "StringValue" then
            continue
        end
        return v197
    end
    return nil
end
local v_u_198 = 0
function stepAnimate(p199) -- name: stepAnimate
    -- upvalues: (ref) v_u_198, (ref) v_u_81, (ref) v_u_3, (copy) v_u_2, (copy) v_u_154, (copy) v_u_1, (ref) v_u_79, (ref) v_u_80, (ref) v_u_180
    local v200 = p199 - v_u_198
    v_u_198 = p199
    if v_u_81 > 0 then
        v_u_81 = v_u_81 - v200
    end
    if v_u_3 == "FreeFall" and v_u_81 <= 0 then
        playAnimation("fall", 0.2, v_u_2)
    else
        if v_u_3 == "Seated" then
            playAnimation("sit", 0.5, v_u_2)
            return
        end
        if v_u_3 == "Running" then
            playAnimation("walk", 0.2, v_u_2)
            v_u_154(p199)
        elseif v_u_3 == "Dead" or (v_u_3 == "GettingUp" or (v_u_3 == "FallingDown" or (v_u_3 == "Seated" or v_u_3 == "PlatformStanding"))) then
            stopAllAnimations()
        end
    end
    local v201 = v_u_1:FindFirstChildOfClass("Tool")
    if v201 and v201:FindFirstChild("Handle") then
        local v202 = getToolAnim(v201)
        if v202 then
            v_u_79 = v202.Value
            v202.Parent = nil
            v_u_80 = p199 + 0.3
        end
        if v_u_80 < p199 then
            v_u_80 = 0
            v_u_79 = "None"
        end
        animateTool()
    else
        stopToolAnimations()
        v_u_79 = "None"
        v_u_180 = nil
        v_u_80 = 0
    end
end
v_u_2.Died:connect(onDied)
v_u_2.Running:connect(onRunning)
v_u_2.Jumping:connect(onJumping)
v_u_2.Climbing:connect(onClimbing)
v_u_2.GettingUp:connect(onGettingUp)
v_u_2.FreeFalling:connect(onFreeFall)
v_u_2.FallingDown:connect(onFallingDown)
v_u_2.Seated:connect(onSeated)
v_u_2.PlatformStanding:connect(onPlatformStanding)
v_u_2.Swimming:connect(onSwimming)
game:GetService("Players").LocalPlayer.Chatted:connect(function(p203)
    -- upvalues: (ref) v_u_3, (copy) v_u_23, (copy) v_u_2
    local v204 = ""
    if string.sub(p203, 1, 3) == "/e " then
        v204 = string.sub(p203, 4)
    elseif string.sub(p203, 1, 7) == "/emote " then
        v204 = string.sub(p203, 8)
    end
    if v_u_3 == "Standing" and v_u_23[v204] ~= nil then
        playAnimation(v204, 0.1, v_u_2)
    end
end)
script:WaitForChild("PlayEmote").OnInvoke = function(p205)
    -- upvalues: (ref) v_u_3, (copy) v_u_23, (copy) v_u_2, (ref) v_u_14
    if v_u_3 == "Standing" then
        if v_u_23[p205] ~= nil then
            playAnimation(p205, 0.1, v_u_2)
            return true, v_u_14
        end
        if typeof(p205) ~= "Instance" or not p205:IsA("Animation") then
            return false
        end
        playEmote(p205, 0.1, v_u_2)
        return true, v_u_14
    end
end
if v_u_1.Parent ~= nil then
    playAnimation("idle", 0.1, v_u_2)
    local _ = "Standing"
end
while v_u_1.Parent ~= nil do
    local _, v206 = wait(0.1)
    stepAnimate(v206)
end
