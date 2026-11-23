-- Script Path: game:GetService("StarterPlayer").StarterPlayerScripts.Controllers.CameraController
-- Took 0.03s to decompile.

local v_u_1 = game:GetService("CollectionService")
local v2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("UserInputService")
game:GetService("GuiService")
local v_u_4 = game:GetService("RunService")
local v_u_5 = game:GetService("VRService")
local v6 = game:GetService("Players")
local v_u_7 = require(v2.Modules.CONSTANTS)
local v_u_8 = require(v2.Modules.QuaternionSpring)
local v_u_9 = require(v2.Modules.GameplayUtility)
require(v2.Modules.DebugLibrary)
local v_u_10 = require(v2.Modules.InputLibrary)
require(v2.Modules.TaskLibrary)
require(v2.Modules.TestLibrary)
local v_u_11 = require(v2.Modules.Quaternion)
local v_u_12 = require(v2.Modules.Utility)
local v_u_13 = require(v2.Modules.Spring)
local v_u_14 = require(v2.Modules.Signal)
require(v6.LocalPlayer.PlayerScripts.Controllers.PrivateServerController)
local v_u_15 = require(v6.LocalPlayer.PlayerScripts.Controllers.UserInterfaceController)
local v_u_16 = require(v6.LocalPlayer.PlayerScripts.Controllers.PlayerDataController)
local v_u_17 = require(v6.LocalPlayer.PlayerScripts.Controllers.ControlsController)
local v_u_18 = require(v6.LocalPlayer.PlayerScripts.Controllers.SettingsController)
local v_u_19 = require(v6.LocalPlayer.PlayerScripts.Controllers.DebugController.DebugState)
local v_u_20 = require(v6.LocalPlayer.PlayerScripts.Modules.CameraShaker)
local v_u_21 = require(script:WaitForChild("CameraState"))
local v_u_22 = Enum.RenderPriority.Camera.Value
local v_u_23 = Vector2.new(0.77, 1) * 0.008726646259971648
local v_u_24 = {
    ["MouseKeyboard"] = 1,
    ["Touch"] = 0.875,
    ["Gamepad"] = 0.75
}
local v_u_25 = {}
v_u_25.__index = v_u_25
function v_u_25._new() -- name: _new
    -- upvalues: (copy) v_u_25, (copy) v_u_14, (copy) v_u_21, (copy) v_u_13, (copy) v_u_8, (copy) v_u_11
    local v26 = v_u_25
    local v27 = setmetatable({}, v26)
    v27.StateChanged = v_u_14.new()
    v27.ActiveStateChanged = v_u_14.new()
    v27.POVStateChanged = v_u_14.new()
    v27.CustomFreecamStateChanged = v_u_14.new()
    v27.RotationDeltaApplied = v_u_14.new()
    v27.SubjectChanged = v_u_14.new()
    v27.CameraState = v_u_21.new(v27)
    v27.Rotation = Vector2.zero
    v27.ShakeCFrame = CFrame.identity
    v27.ViewModelOffsetCFrame = CFrame.identity
    v27.VRCameraCFrame = nil
    v27._current_subject = nil
    v27._current_duel_subject = nil
    v27._third_person_override = nil
    v27._external_fov_offsets = {}
    v27._is_editing_mobile_buttons = false
    v27._last_dt = 0
    v27._last_mouse_behavior = nil
    v27._gamepad_rotation_input = Vector2.zero
    v27._bobbing_tick = 0
    v27._fov_gameplay_spring = v_u_13.new(60, 0.75, 30)
    v27._fov_weapons_spring = v_u_13.new(0, 1, 20)
    v27._position_spring = v_u_13.new(Vector3.new(0, 0, 0), 0.75, 30)
    v27._pov_spring = v_u_13.new(Vector3.new(0, 0, 0), 0.875, 25)
    v27._sway_spring = v_u_13.new(Vector2.zero, 0.5, 12.5)
    v27._bobbing_speed_spring = v_u_13.new(0, 0.5, 12.5)
    v27._bobbing_value_spring = v_u_13.new(0, 0.75, 12.5)
    v27._jump_spring = v_u_13.new(0, 0.5, 15)
    v27._sliding_spring = v_u_13.new(0, 0.5, 15)
    v27._leaning_spring = v_u_13.new(0, 1, 20)
    v27._camera_shaker = nil
    v27._next_collision_whitelist_fetch = 0
    v27._collision_check_params = RaycastParams.new()
    v27._viewmodel_animation_spring = v_u_8.new(v_u_11.fromCFrame(CFrame.identity), 1, 10)
    v27._crosshair_disabled = false
    v27._base_fov = 80
    v27._gameplay_fov_effects_enabled = true
    v27._shake_enabled = true
    v27._open_playerlist_input_down = false
    v27._inverted_identity_vector = Vector2.one
    v27._camera_sensitivity = 1
    v27._camera_sensitivity_ads_multiplier = 1
    v27._camera_sensitivity_ads_multiplier_scoped = 1
    v27._camera_sensitivity_x = 1
    v27._camera_sensitivity_y = 1
    v27._fov_offset_strength = 0
    v27._fov_offset_strength_scoped = 0
    v27._gamepad_deadzone = 0.25
    v27:_Init()
    return v27
end
function v_u_25.GetPublicState(p28, ...) -- name: GetPublicState
    return p28.CameraState:GetPublicState(...)
end
function v_u_25.GetCurrentSubject(p29) -- name: GetCurrentSubject
    return p29._current_subject
end
function v_u_25.IsSubjectEmoting(p30) -- name: IsSubjectEmoting
    local v31 = p30:GetCurrentSubject()
    local v32 = v31 and v31.Entity
    if v32 then
        v32 = v31.Entity:IsEmoting()
    end
    return v32
end
function v_u_25.HasThirdPersonAccess(p33, p34) -- name: HasThirdPersonAccess
    -- upvalues: (copy) v_u_19, (copy) v_u_17
    if p33._third_person_override == nil then
        return p33._current_subject and p33._current_subject:Get("CheaterMode") and true or (not p34 and p33:IsSubjectEmoting() and true or (v_u_19:Get("AreHandicapsEnabled") or v_u_17.CurrentControls == "Touch"))
    else
        return p33._third_person_override
    end
end
function v_u_25.HasUnlockedMouseAccess(p35) -- name: HasUnlockedMouseAccess
    -- upvalues: (copy) v_u_17
    local v36 = p35:HasThirdPersonAccess()
    if v36 then
        v36 = v_u_17.CurrentControls == "MouseKeyboard" and true or p35:IsSubjectEmoting()
    end
    return v36
end
function v_u_25.GetLastHeartbeatDeltaTime(p37) -- name: GetLastHeartbeatDeltaTime
    return p37._last_dt
end
function v_u_25.GetRenderstepPriority(_) -- name: GetRenderstepPriority
    -- upvalues: (copy) v_u_22
    return v_u_22
end
function v_u_25.GetCameraCFrame(p38, p39) -- name: GetCameraCFrame
    -- upvalues: (copy) v_u_17
    local v40 = p39 or p38._current_subject
    if v_u_17.CurrentControls == "VR" then
        return workspace.CurrentCamera.CFrame * p38.VRCameraCFrame
    end
    if not (v40 and v40.Entity) then
        return CFrame.identity
    end
    local v41
    if p38.CameraState:GetPublicState() == p38.CameraState.States.FirstPerson then
        v41 = CFrame.new(p38._leaning_spring.Value * Vector3.new(2, 0.1, 0))
    else
        v41 = CFrame.identity
    end
    return CFrame.new(v40.Entity.RootPart.Position) * CFrame.new(p38._position_spring.Value) * p38:GetRotationCFrame() * v41
end
function v_u_25.GetRotationCFrame(p42, p43) -- name: GetRotationCFrame
    local v44 = p43 or p42.Rotation
    return CFrame.Angles(0, v44.Y, 0) * CFrame.Angles(v44.X, 0, 0)
end
function v_u_25.GetGamepadRotationInput(p45, p46) -- name: GetGamepadRotationInput
    return p46 and Vector2.new(p45._gamepad_rotation_input.Y, p45._gamepad_rotation_input.X) or p45._gamepad_rotation_input
end
function v_u_25.GetExternalFOVOffset(p47) -- name: GetExternalFOVOffset
    local v48 = 0
    for _, v49 in pairs(p47._external_fov_offsets) do
        v48 = v48 + v49
    end
    return v48
end
function v_u_25.GetCameraSensitivity(p50) -- name: GetCameraSensitivity
    local v51 = p50._current_subject and p50._current_subject.EquippedItem
    if v51 then
        v51 = p50._current_subject.EquippedItem:Get("IsAiming")
    end
    local v52 = p50._current_subject and p50._current_subject.EquippedItem
    if v52 then
        v52 = p50._current_subject.EquippedItem.Info.AimScopePercent
    end
    local v53
    if v51 and v52 then
        v53 = p50._camera_sensitivity_ads_multiplier_scoped
    else
        v53 = not v51 and 1 or p50._camera_sensitivity_ads_multiplier
    end
    return p50._camera_sensitivity * (v53 or 1)
end
function v_u_25.SetRotation(p54, p55, p56) -- name: SetRotation
    if p56 or not (p54._current_subject and (p54._current_subject.Entity and p54._current_subject.Entity:Get("IsFrozen"))) then
        local v57 = Vector2.new
        local v58 = p55.X
        p54.Rotation = v57(math.clamp(v58, -1.5690509975429023, 1.5690509975429023), p55.Y)
    end
end
function v_u_25.SetSubject(p59, p60) -- name: SetSubject
    p59._current_subject = p60
    p59.SubjectChanged:Fire()
end
function v_u_25.SetDuelSubject(p61, p62) -- name: SetDuelSubject
    p61._current_duel_subject = p62
end
function v_u_25.SetExternalFOVOffset(p63, p64, p65) -- name: SetExternalFOVOffset
    local v66 = p63._external_fov_offsets
    if p65 == 0 then
        p65 = nil
    end
    v66[p64] = p65
end
function v_u_25.SetThirdPersonOverride(p67, p68) -- name: SetThirdPersonOverride
    p67._third_person_override = p68
    p67.CameraState:VerifyPOV()
end
function v_u_25.SetIsEditingMobileButtons(p69, p70) -- name: SetIsEditingMobileButtons
    p69._is_editing_mobile_buttons = p70
end
function v_u_25.Freeze(p71, p72) -- name: Freeze
    -- upvalues: (copy) v_u_3
    if p72 and not p71.IsFrozen then
        v_u_3.MouseIconEnabled = true
        v_u_3.MouseBehavior = Enum.MouseBehavior.Default
    elseif not p72 and p71.IsFrozen then
        p71._last_mouse_behavior = nil
    end
    p71.IsFrozen = p72
    p71:Update(0)
end
function v_u_25.ApplyRotationDelta(p73, p74, p75) -- name: ApplyRotationDelta
    local v76
    if p75 then
        v76 = Vector2.one
    else
        v76 = p73._inverted_identity_vector * p73:GetCameraSensitivity() * Vector2.new(p73._camera_sensitivity_y, p73._camera_sensitivity_x)
    end
    local v77 = p74 * v76
    p73:SetRotation(p73.Rotation + v77)
    p73.RotationDeltaApplied:Fire(v77)
end
function v_u_25.ShakeOnce(p78, ...) -- name: ShakeOnce
    p78._camera_shaker:ShakeOnce(...)
end
function v_u_25.Shake(p79, ...) -- name: Shake
    p79._camera_shaker:Shake(...)
end
function v_u_25.MimicRotation(p80, p81) -- name: MimicRotation
    local v82, v83, _ = p81:ToOrientation()
    p80:SetRotation(Vector2.new(v82, v83), true)
end
function v_u_25.MimicRotationSmooth(p84, p85, p86) -- name: MimicRotationSmooth
    -- upvalues: (copy) v_u_11, (copy) v_u_4
    local v87 = p85.Rotation
    local v88 = v_u_11.fromCFrame(p84:GetRotationCFrame().Rotation)
    local v89 = v_u_11.fromCFrame(v87)
    local v90 = tick()
    while tick() < v90 + p86 do
        local v91 = (tick() - v90) / p86
        local v92, v93, _ = v88:Slerp(v89, (math.clamp(v91, 0, 1))):ToCFrame():ToOrientation()
        p84:SetRotation(Vector2.new(v92, v93), true)
        v_u_4.RenderStepped:Wait()
    end
    local v94, v95, _ = v87:ToOrientation()
    p84:SetRotation(Vector2.new(v94, v95), true)
end
function v_u_25.Update(p96, p97) -- name: Update
    -- upvalues: (copy) v_u_1, (copy) v_u_3, (copy) v_u_17, (copy) v_u_7, (copy) v_u_15, (copy) v_u_11, (copy) v_u_9
    if p96.IsFrozen or p96.CameraState:GetPublicState() == p96.CameraState.States.CustomFreecam then
        return
    else
        local v98 = p97 or 0
        local v99 = p96._current_subject ~= nil and p96._current_subject:IsAlive()
        if v99 then
            v99 = p96._current_subject
        end
        local v100 = p96.CameraState
        local v101
        if v99 then
            v101 = v99:IsActive()
        else
            v101 = v99
        end
        v100:SetActive(v101)
        local v102 = p96.CameraState:GetPublicState()
        local v103 = not v102 and p96._current_duel_subject
        if v103 then
            v103 = not p96._current_duel_subject.LocalDueler
        end
        local v104
        if v103 then
            v104 = p96._current_duel_subject.Map and p96._current_duel_subject.Map:GetSpectatePart() or v_u_1:GetTagged("WaitingRoomSpectate")[1]
        else
            v104 = nil
        end
        if v104 then
            v_u_3.MouseIconEnabled = true
            v_u_3.MouseBehavior = Enum.MouseBehavior.Default
            workspace.CurrentCamera.CameraSubject = nil
            workspace.CurrentCamera.CameraType = Enum.CameraType.Scriptable
            workspace.CurrentCamera.CFrame = v104.CFrame
            return
        else
            local v105 = v102 == p96.CameraState.States.ThirdPersonUnlockedMouse and true or not (v99 and v99.IsLocalPlayer)
            local v106
            if v102 then
                v106 = v102 ~= p96.CameraState.States.ThirdPersonUnlockedMouse
            else
                v106 = v102
            end
            local v107
            if v99 then
                v107 = v99.EquippedItem
            else
                v107 = v99
            end
            local v108 = p96:_Modal()
            local v109
            if v108 then
                v109 = v_u_17.CurrentControls == "MouseKeyboard"
            else
                v109 = v108
            end
            local v110 = v106 and (not v105 and (v_u_17.CurrentControls == "MouseKeyboard" and not v109)) and Enum.MouseBehavior.LockCenter or Enum.MouseBehavior.Default
            local v111 = workspace.CurrentCamera.CameraType
            local v112 = workspace.CurrentCamera
            local v113
            if v99 and v99.Entity then
                v113 = v99.Entity.Humanoid or nil
            else
                v113 = nil
            end
            v112.CameraSubject = v113
            workspace.CurrentCamera.CameraType = v106 and Enum.CameraType.Scriptable or Enum.CameraType.Custom
            v_u_3.MouseIconEnabled = v109 or (not (v107 and v99) or (not v99.IsLocalPlayer or (v_u_17.CurrentControls == "Touch" and true or (p96._crosshair_disabled and v105 and v105 or p96:IsSubjectEmoting()))))
            if v110 == Enum.MouseBehavior.LockCenter or v110 ~= p96._last_mouse_behavior then
                v_u_3.MouseBehavior = v110
                p96._last_mouse_behavior = v110
            end
            if not v106 then
                p96:MimicRotation(workspace.CurrentCamera.CFrame.Rotation * CFrame.Angles(0.17453292519943295, 0, 0))
            end
            if v99 then
                local v114 = CFrame.new(v99.Entity.RootPart.Position)
                local v115
                if v111 == Enum.CameraType.Custom and workspace.CurrentCamera.CameraType ~= Enum.CameraType.Custom then
                    v115 = (workspace.CurrentCamera.CFrame.Position - v114.Position).Magnitude < 128
                else
                    v115 = false
                end
                if v115 then
                    p96._fov_gameplay_spring.Value = workspace.CurrentCamera.FieldOfView
                end
                local v116 = v99.IsLocalPlayer
                v99:IsSprinting()
                local v117 = v99:IsCrouching()
                local v118 = v99:IsSliding()
                local v119 = v99:IsGrounded()
                local v120 = v99 and (v99.Entity and v99.Entity.Humanoid)
                if v120 then
                    v120 = v99.Entity.Humanoid:GetState() == Enum.HumanoidStateType.Climbing
                end
                local v121 = v99:GetRotationCFrame()
                local v122 = v99:GetCameraSway() * 0.25
                local v123 = v99:GetCameraLean()
                local v124 = v99.Entity:GetClampedVelocity()
                local v125 = (v124 * Vector3.new(1, 0, 1)).Magnitude
                local v126
                if v107 and v107.Info.AimScopePercent then
                    v126 = p96._fov_offset_strength_scoped
                else
                    v126 = p96._fov_offset_strength
                end
                p96._fov_weapons_spring.Speed = 20 * v99:GetAimSpeed()
                p96._fov_weapons_spring.Target = v102 == p96.CameraState.States.ThirdPersonUnlockedMouse and 0 or v99:GetFOVOffset() * v126
                local v127 = p96._fov_gameplay_spring
                local v128 = p96._base_fov
                local v129
                if p96._gameplay_fov_effects_enabled then
                    local v130 = v125 - v_u_7.BASE_WALKSPEED
                    v129 = math.max(0, v130) * 10 / v_u_7.BASE_WALKSPEED or 0
                else
                    v129 = 0
                end
                v127.Target = v128 + v129 + p96:GetExternalFOVOffset()
                local v131 = p96._fov_gameplay_spring.Value + p96._fov_weapons_spring.Value * (p96._fov_gameplay_spring.Value / 80)
                workspace.CurrentCamera.FieldOfView = v131
                p96._position_spring.Target = Vector3.new(0, 1.75, 0) + Vector3.new(0, v118 and -3 or (v120 and -2.5 or (v117 and -2 or 0)), 0)
                if workspace.CurrentCamera.CameraType == Enum.CameraType.Scriptable then
                    if v115 then
                        p96._position_spring.Value = workspace.CurrentCamera.CFrame:ToObjectSpace(v114):Inverse().Position * 0.5
                    end
                    if v_u_17.CurrentControls == "Gamepad" and not (v108 or v_u_15:IsPageOpen()) then
                        p96:ApplyRotationDelta(p96._gamepad_rotation_input * p96:_GetFOVMultiplier() * v98 * 60)
                    end
                    local v132 = CFrame.new(p96._position_spring.Value)
                    local v133 = CFrame.identity
                    local v134 = CFrame.identity
                    if v102 == p96.CameraState.States.FirstPerson and not v116 then
                        p96._bobbing_speed_spring.Target = v125 / v_u_7.BASE_WALKSPEED * (v119 and 1 or 0) * 0.111
                        p96._bobbing_tick = p96._bobbing_tick + p96._bobbing_speed_spring.Value * v98 * 60
                        local v135 = p96._bobbing_value_spring
                        local v136 = p96._bobbing_tick
                        local v137 = math.sin(v136)
                        v135.Target = (math.abs(v137) - 0.5) * (v125 / v_u_7.BASE_WALKSPEED) ^ 2 * (v118 and 0 or 1) * 0.125
                        local v138 = p96._bobbing_value_spring.Value
                        v133 = CFrame.new(0, v138, 0)
                        v134 = CFrame.Angles(v138 * 0.08726646259971647, 0, 0)
                    end
                    local v139 = p96._pov_spring.Value
                    local v140 = CFrame.new(v139)
                    local v141 = p96._sway_spring
                    v141.Value = v141.Value + Vector2.new(v122.Y * 0.5, v122.X)
                    local v142 = p96._sway_spring.Value * (v116 and 0 or 0.025)
                    local v143 = CFrame.Angles(v142.X, 0, v142.Y)
                    local v144 = v116 and CFrame.identity
                    if not v144 then
                        local v145 = CFrame.Angles
                        local v146 = tick() * 0.23983 % 6.283185307179586
                        local v147 = math.sin(v146) * 0.004363323129985824
                        local v148 = tick() * 0.372721 % 6.283185307179586
                        local v149 = math.sin(v148) * 0.004363323129985824
                        local v150 = tick() * 0.43123 % 6.283185307179586
                        v144 = v145(v147, v149, math.sin(v150) * 0.004363323129985824)
                    end
                    p96._jump_spring.Target = v124.Y
                    local v151 = p96._jump_spring.Value / v_u_7.BASE_GRAVITY * (v116 and 0 or 0.5)
                    local v152 = CFrame.Angles
                    local v153 = -v151 / 15
                    local v154 = math.rad(v153)
                    local v155 = v152(math.clamp(v154, -0.7853981633974483, 0.7853981633974483), 0, 0)
                    p96._sliding_spring.Target = v118 and 1 or 0
                    local v156 = p96._sliding_spring.Value
                    local v157 = CFrame.Angles(0, 0, -0.08726646259971647 * v156)
                    p96._leaning_spring.Target = v102 == p96.CameraState.States.FirstPerson and v123 and v123 or 0
                    local v158 = p96._leaning_spring.Value
                    local v159 = CFrame.new(v158 * Vector3.new(2, 0.1, 0)) * CFrame.Angles(0, 0, v158 * -0.08726646259971647)
                    p96._viewmodel_animation_spring.Target = v_u_11.fromCFrame(v107 and (v107.ViewModel and v107.ViewModel:GetCameraOffset()) or CFrame.identity)
                    p96.ViewModelOffsetCFrame = CFrame.identity
                    local v160 = v114 * v132 * (v133 * v121 * v134 * v140 * v143 * v144 * v155 * v157 * v159 * p96.ViewModelOffsetCFrame * p96.ShakeCFrame)
                    local v161 = v160.Position
                    if tick() > p96._next_collision_whitelist_fetch then
                        p96._next_collision_whitelist_fetch = tick() + 5
                        p96._collision_check_params.FilterDescendantsInstances = v_u_9:GetRaycastWhitelist(v99:Get("EnvironmentID"))
                    end
                    local v162 = workspace:Raycast(v99.Entity.RootPart.Position, v160.Position - v99.Entity.RootPart.Position, p96._collision_check_params)
                    if v162 and v162.Instance then
                        v161 = v99.Entity.RootPart.Position + (v160.Position - v99.Entity.RootPart.Position).Unit * ((v99.Entity.RootPart.Position - v162.Position).Magnitude - 0.5)
                    end
                    workspace.CurrentCamera.CFrame = CFrame.new(v161) * v160.Rotation
                end
            else
                workspace.CurrentCamera.FieldOfView = p96._base_fov
                return
            end
        end
    end
end
function v_u_25._UpdateSettings(p163) -- name: _UpdateSettings
    -- upvalues: (copy) v_u_16
    p163._crosshair_disabled = v_u_16:GetSetting("Crosshair Disabled")
    p163._base_fov = v_u_16:GetSetting("Camera FOV")
    p163._gameplay_fov_effects_enabled = v_u_16:GetSetting("Camera FOV Effects")
    p163._shake_enabled = v_u_16:GetSetting("Camera Shake")
    p163._inverted_identity_vector = Vector2.new(v_u_16:GetSetting("Camera Inverted Y") and -1 or 1, v_u_16:GetSetting("Camera Inverted X") and -1 or 1)
    p163._camera_sensitivity = v_u_16:GetSetting("Camera Sensitivity")
    p163._camera_sensitivity_ads_multiplier = v_u_16:GetSetting("Camera Sensitivity ADS")
    p163._camera_sensitivity_ads_multiplier_scoped = v_u_16:GetSetting("Camera Sensitivity Scoped")
    p163._camera_sensitivity_x = v_u_16:GetSetting("Camera Sensitivity X")
    p163._camera_sensitivity_y = v_u_16:GetSetting("Camera Sensitivity Y")
    p163._fov_offset_strength = v_u_16:GetSetting("Camera Zoom Effects")
    p163._fov_offset_strength_scoped = v_u_16:GetSetting("Camera Zoom Effects Scoped")
    p163._gamepad_deadzone = v_u_16:GetSetting("Gamepad Deadzone")
end
function v_u_25._Modal(p164) -- name: _Modal
    -- upvalues: (copy) v_u_15
    local v165 = p164._current_duel_subject and p164._current_duel_subject.DuelInterface
    if v165 then
        v165 = p164._current_duel_subject.DuelInterface.Scoreboard:IsOpen()
    end
    return v165 or (v_u_15:IsPageOpen() or p164._open_playerlist_input_down)
end
function v_u_25._GetFOVMultiplier(p166) -- name: _GetFOVMultiplier
    return workspace.CurrentCamera.FieldOfView < p166._base_fov and workspace.CurrentCamera.FieldOfView / p166._base_fov or 1
end
function v_u_25._InputChanged(p167, p168, p169) -- name: _InputChanged
    -- upvalues: (copy) v_u_17, (copy) v_u_24, (copy) v_u_23
    if p169 or p167._is_editing_mobile_buttons then
        return
    elseif v_u_17.CurrentControls == "MouseKeyboard" and (p168.UserInputType ~= Enum.UserInputType.MouseMovement and p168.UserInputType ~= Enum.UserInputType.MouseWheel) then
        return
    else
        local v170 = v_u_24[v_u_17.CurrentControls]
        if v_u_17.CurrentControls == "MouseKeyboard" or v_u_17.CurrentControls == "Touch" then
            p167:ApplyRotationDelta(Vector2.new(p168.Delta.Y, p168.Delta.X) * v_u_23 * v170 * p167:_GetFOVMultiplier() * -1)
        elseif v_u_17.CurrentControls == "Gamepad" and (p168.KeyCode == Enum.KeyCode.Thumbstick1 or p168.KeyCode == Enum.KeyCode.Thumbstick2) then
            local v171 = (Vector2.new(p168.Position.X, p168.Position.Y).Magnitude - p167._gamepad_deadzone) / (1 - p167._gamepad_deadzone)
            local v172 = math.max(0, v171)
            local v173 = p168.Position.X * v172
            local v174 = p168.Position.Y * v172 * 10 + 0.5
            local v175 = math.floor(v174) * v170
            local v176 = v173 * 10 + 0.5
            local v177 = -math.floor(v176) * v170
            p167._gamepad_rotation_input = Vector2.new(v175, v177) * 0.01
        end
    end
end
function v_u_25._Setup(p_u_178) -- name: _Setup
    -- upvalues: (copy) v_u_5, (copy) v_u_20
    if v_u_5:GetUserCFrameEnabled(Enum.UserCFrame.RightHand) then
        p_u_178.VRCameraCFrame = v_u_5:GetUserCFrame(Enum.UserCFrame.RightHand)
    end
    p_u_178._camera_shaker = v_u_20.new(Enum.RenderPriority.Camera.Value + 1, function(p179)
        -- upvalues: (copy) p_u_178
        p_u_178.ShakeCFrame = p_u_178._shake_enabled and p179 and p179 or CFrame.identity
    end)
    p_u_178._camera_shaker:Start()
    p_u_178._collision_check_params.FilterType = Enum.RaycastFilterType.Include
    p_u_178._collision_check_params.CollisionGroup = "Players"
    p_u_178._collision_check_params.IgnoreWater = true
end
function v_u_25._Init(p_u_180) -- name: _Init
    -- upvalues: (copy) v_u_3, (copy) v_u_12, (copy) v_u_10, (copy) v_u_18, (copy) v_u_16, (copy) v_u_5, (copy) v_u_4, (copy) v_u_22
    p_u_180.StateChanged:Connect(function()
        -- upvalues: (copy) p_u_180
        local v181 = p_u_180.CameraState:GetPublicState()
        p_u_180._pov_spring.Target = v181 == p_u_180.CameraState.States.ThirdPerson and Vector3.new(3, 1.5, 7.5) or (v181 == p_u_180.CameraState.States.ThirdPersonMirrored and Vector3.new(-3, 1.5, 7.5) or (v181 == p_u_180.CameraState.States.ThirdPersonUnlockedMouse and Vector3.new(0, 3, 10) or Vector3.new(0, 0, 0)))
    end)
    p_u_180.CameraState.StateChanged:Connect(function(p182, p183)
        -- upvalues: (copy) p_u_180
        p_u_180.StateChanged:Fire(p182, p183)
        if not (p182 and p183) then
            p_u_180.ActiveStateChanged:Fire(p182, p183)
        end
        if p182 == p_u_180.CameraState.States.CustomFreecam or p183 == p_u_180.CameraState.States.CustomFreecam then
            p_u_180.CustomFreecamStateChanged:Fire(p182, p183)
        end
        local v184 = table.find(p_u_180.CameraState.POVStates, p182)
        local v185 = table.find(p_u_180.CameraState.POVStates, p183)
        if v184 or v185 then
            p_u_180.POVStateChanged:Fire(p182, p183, v184 and v185)
        end
    end)
    v_u_3.InputBegan:Connect(function(p186, p187)
        -- upvalues: (copy) p_u_180, (ref) v_u_12, (ref) v_u_10, (ref) v_u_18, (ref) v_u_16
        local v188 = p_u_180.CameraState:GetPublicState()
        local v189
        if v188 == p_u_180.CameraState.States.CustomFreecam then
            v189 = v_u_12:IsTextBoxFocused()
        else
            v189 = p187
        end
        if not v189 and v_u_10:InputIs(p186, "HideHUD") then
            v_u_18:ChangeSetting("Hide HUD", not v_u_16:GetSetting("Hide HUD"), true)
        end
        if p_u_180.IsFrozen or not v188 then
            return
        elseif p187 or not v_u_10:InputIs(p186, "SwitchCameraPOV") then
            if not p187 and v_u_10:InputIs(p186, "OpenPlayerList") then
                p_u_180._open_playerlist_input_down = true
            end
        else
            p_u_180.CameraState:TogglePOV()
        end
    end)
    v_u_3.InputChanged:Connect(function(...)
        -- upvalues: (copy) p_u_180
        if not p_u_180.IsFrozen and p_u_180.CameraState:GetPublicState() then
            p_u_180:_InputChanged(...)
        end
    end)
    v_u_3.InputEnded:Connect(function(p190, _)
        -- upvalues: (ref) v_u_10, (copy) p_u_180
        if v_u_10:InputIs(p190, "OpenPlayerList") then
            p_u_180._open_playerlist_input_down = false
        end
    end)
    v_u_5.UserCFrameChanged:Connect(function(_, _)
        -- upvalues: (copy) p_u_180, (ref) v_u_5
        if not p_u_180.IsFrozen and p_u_180.CameraState:GetPublicState() then
            local v191 = v_u_5:GetUserCFrameEnabled(Enum.UserCFrame.RightHand)
            if v191 then
                v191 = v_u_5:GetUserCFrame(Enum.UserCFrame.RightHand)
            end
            local v192 = v_u_5:GetUserCFrameEnabled(Enum.UserCFrame.Head)
            if v192 then
                v192 = v_u_5:GetUserCFrame(Enum.UserCFrame.Head)
            end
            local v193 = v192 or (v191 or CFrame.identity)
            local v194 = v191 or (v192 or CFrame.identity)
            p_u_180.VRCameraCFrame = CFrame.new(v193.Position) * (v194 - v194.Position)
        end
    end)
    v_u_4:BindToRenderStep("CameraController", v_u_22, function(p195)
        -- upvalues: (copy) p_u_180
        p_u_180._last_dt = p195
        p_u_180:Update(p195)
    end)
    v_u_16:GetSettingChangedSignal("Crosshair Disabled"):Connect(function()
        -- upvalues: (copy) p_u_180
        p_u_180:_UpdateSettings()
    end)
    v_u_16:GetSettingChangedSignal("Camera FOV"):Connect(function()
        -- upvalues: (copy) p_u_180
        p_u_180:_UpdateSettings()
    end)
    v_u_16:GetSettingChangedSignal("Camera FOV Effects"):Connect(function()
        -- upvalues: (copy) p_u_180
        p_u_180:_UpdateSettings()
    end)
    v_u_16:GetSettingChangedSignal("Camera Inverted X"):Connect(function()
        -- upvalues: (copy) p_u_180
        p_u_180:_UpdateSettings()
    end)
    v_u_16:GetSettingChangedSignal("Camera Inverted Y"):Connect(function()
        -- upvalues: (copy) p_u_180
        p_u_180:_UpdateSettings()
    end)
    v_u_16:GetSettingChangedSignal("Camera Shake"):Connect(function()
        -- upvalues: (copy) p_u_180
        p_u_180:_UpdateSettings()
    end)
    v_u_16:GetSettingChangedSignal("Camera Sensitivity"):Connect(function()
        -- upvalues: (copy) p_u_180
        p_u_180:_UpdateSettings()
    end)
    v_u_16:GetSettingChangedSignal("Camera Sensitivity ADS"):Connect(function()
        -- upvalues: (copy) p_u_180
        p_u_180:_UpdateSettings()
    end)
    v_u_16:GetSettingChangedSignal("Camera Zoom Effects"):Connect(function()
        -- upvalues: (copy) p_u_180
        p_u_180:_UpdateSettings()
    end)
    v_u_16:GetSettingChangedSignal("Camera Zoom Effects Scoped"):Connect(function()
        -- upvalues: (copy) p_u_180
        p_u_180:_UpdateSettings()
    end)
    v_u_16:GetSettingChangedSignal("Gamepad Deadzone"):Connect(function()
        -- upvalues: (copy) p_u_180
        p_u_180:_UpdateSettings()
    end)
    v_u_16:GetSettingChangedSignal("Camera Sensitivity X"):Connect(function()
        -- upvalues: (copy) p_u_180
        p_u_180:_UpdateSettings()
    end)
    v_u_16:GetSettingChangedSignal("Camera Sensitivity Y"):Connect(function()
        -- upvalues: (copy) p_u_180
        p_u_180:_UpdateSettings()
    end)
    v_u_16:GetSettingChangedSignal("Camera Sensitivity Scoped"):Connect(function()
        -- upvalues: (copy) p_u_180
        p_u_180:_UpdateSettings()
    end)
    v_u_16.SettingsSliderChanged:Connect(function(p196, p197)
        -- upvalues: (copy) p_u_180
        if p196 == "Camera FOV" then
            p_u_180._base_fov = p197
        end
    end)
    p_u_180:_Setup()
    p_u_180:_UpdateSettings()
end
return v_u_25._new()
