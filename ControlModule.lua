-- Script Path: game:GetService("StarterPlayer").StarterPlayerScripts.PlayerModule.ControlModule
-- Took 0.02s to decompile.

local v_u_1 = {}
v_u_1.__index = v_u_1
local v_u_2 = game:GetService("Players")
local v_u_3 = game:GetService("RunService")
local v_u_4 = game:GetService("UserInputService")
local v_u_5 = game:GetService("GuiService")
local v_u_6 = game:GetService("Workspace")
local v_u_7 = UserSettings():GetService("UserGameSettings")
local v_u_8 = game:GetService("VRService")
script.Parent:WaitForChild("CommonUtils")
local v_u_9 = require(script:WaitForChild("Keyboard"))
local v_u_10 = require(script:WaitForChild("Gamepad"))
local v_u_11 = require(script:WaitForChild("DynamicThumbstick"))
local v12, v13 = pcall(function()
    return UserSettings():IsUserFeatureEnabled("UserDynamicThumbstickSafeAreaUpdate")
end)
local v_u_14 = v12 and v13
local v_u_15 = require(script:WaitForChild("TouchThumbstick"))
local v_u_16 = require(script:WaitForChild("ClickToMoveController"))
local v_u_17 = require(script:WaitForChild("TouchJump"))
local v_u_18 = require(script:WaitForChild("VehicleController"))
local v19, v20 = pcall(function()
    return UserSettings():IsUserFeatureEnabled("UserPlayerScriptsSupportMicroGamepad")
end)
local v_u_21 = v19 and v20
local v_u_22 = Enum.ContextActionPriority.Medium.Value
local v_u_23 = {
    [Enum.TouchMovementMode.DPad] = v_u_11,
    [Enum.DevTouchMovementMode.DPad] = v_u_11,
    [Enum.TouchMovementMode.Thumbpad] = v_u_11,
    [Enum.DevTouchMovementMode.Thumbpad] = v_u_11,
    [Enum.TouchMovementMode.Thumbstick] = v_u_15,
    [Enum.DevTouchMovementMode.Thumbstick] = v_u_15,
    [Enum.TouchMovementMode.DynamicThumbstick] = v_u_11,
    [Enum.DevTouchMovementMode.DynamicThumbstick] = v_u_11,
    [Enum.TouchMovementMode.ClickToMove] = v_u_16,
    [Enum.DevTouchMovementMode.ClickToMove] = v_u_16,
    [Enum.TouchMovementMode.Default] = v_u_11,
    [Enum.ComputerMovementMode.Default] = v_u_9,
    [Enum.ComputerMovementMode.KeyboardMouse] = v_u_9,
    [Enum.DevComputerMovementMode.KeyboardMouse] = v_u_9,
    [Enum.DevComputerMovementMode.Scriptable] = nil,
    [Enum.ComputerMovementMode.ClickToMove] = v_u_16,
    [Enum.DevComputerMovementMode.ClickToMove] = v_u_16
}
function v_u_1.new() -- name: new
    -- upvalues: (copy) v_u_1, (copy) v_u_2, (copy) v_u_18, (copy) v_u_22, (copy) v_u_3, (copy) v_u_7, (copy) v_u_5, (copy) v_u_4
    local v24 = v_u_1
    local v_u_25 = setmetatable({}, v24)
    v_u_25.controllers = {}
    v_u_25.activeControlModule = nil
    v_u_25.activeController = nil
    v_u_25.touchJumpController = nil
    v_u_25.moveFunction = v_u_2.LocalPlayer.Move
    v_u_25.humanoid = nil
    v_u_25.controlsEnabled = true
    v_u_25.humanoidSeatedConn = nil
    v_u_25.vehicleController = nil
    v_u_25.touchControlFrame = nil
    v_u_25.currentTorsoAngle = 0
    v_u_25.inputMoveVector = Vector3.new(0, 0, 0)
    v_u_25.vehicleController = v_u_18.new(v_u_22)
    v_u_2.LocalPlayer.CharacterAdded:Connect(function(p26)
        -- upvalues: (copy) v_u_25
        v_u_25:OnCharacterAdded(p26)
    end)
    v_u_2.LocalPlayer.CharacterRemoving:Connect(function(p27)
        -- upvalues: (copy) v_u_25
        v_u_25:OnCharacterRemoving(p27)
    end)
    if v_u_2.LocalPlayer.Character then
        v_u_25:OnCharacterAdded(v_u_2.LocalPlayer.Character)
    end
    v_u_3:BindToRenderStep("ControlScriptRenderstep", Enum.RenderPriority.Input.Value, function(p28)
        -- upvalues: (copy) v_u_25
        v_u_25:OnRenderStepped(p28)
    end)
    v_u_7:GetPropertyChangedSignal("TouchMovementMode"):Connect(function()
        -- upvalues: (copy) v_u_25
        v_u_25:UpdateMovementMode()
    end)
    v_u_2.LocalPlayer:GetPropertyChangedSignal("DevTouchMovementMode"):Connect(function()
        -- upvalues: (copy) v_u_25
        v_u_25:UpdateMovementMode()
    end)
    v_u_7:GetPropertyChangedSignal("ComputerMovementMode"):Connect(function()
        -- upvalues: (copy) v_u_25
        v_u_25:UpdateMovementMode()
    end)
    v_u_2.LocalPlayer:GetPropertyChangedSignal("DevComputerMovementMode"):Connect(function()
        -- upvalues: (copy) v_u_25
        v_u_25:UpdateMovementMode()
    end)
    v_u_25.playerGui = nil
    v_u_25.touchGui = nil
    v_u_25.playerGuiAddedConn = nil
    v_u_5:GetPropertyChangedSignal("TouchControlsEnabled"):Connect(function()
        -- upvalues: (copy) v_u_25
        v_u_25:UpdateMovementMode()
        v_u_25:UpdateActiveControlModuleEnabled()
    end)
    v_u_4:GetPropertyChangedSignal("PreferredInput"):Connect(function()
        -- upvalues: (copy) v_u_25
        v_u_25:UpdateMovementMode()
    end)
    v_u_25.playerGui = v_u_2.LocalPlayer:FindFirstChildOfClass("PlayerGui")
    if not v_u_25.playerGui then
        v_u_25.playerGuiAddedConn = v_u_2.LocalPlayer.ChildAdded:Connect(function(p29)
            -- upvalues: (copy) v_u_25
            if p29:IsA("PlayerGui") then
                v_u_25.playerGui = p29
                v_u_25.playerGuiAddedConn:Disconnect()
                v_u_25.playerGuiAddedConn = nil
                v_u_25:UpdateMovementMode()
            end
        end)
    end
    v_u_25:UpdateMovementMode()
    return v_u_25
end
function v_u_1.GetMoveVector(p30) -- name: GetMoveVector
    return not p30.activeController and Vector3.new(0, 0, 0) or p30.activeController:GetMoveVector()
end
function v_u_1.GetEstimatedVRTorsoFrame(p31) -- name: GetEstimatedVRTorsoFrame
    -- upvalues: (copy) v_u_8
    local v32 = v_u_8:GetUserCFrame(Enum.UserCFrame.Head)
    local _, v33, _ = v32:ToEulerAnglesYXZ()
    local v34 = -v33
    if v_u_8:GetUserCFrameEnabled(Enum.UserCFrame.RightHand) and v_u_8:GetUserCFrameEnabled(Enum.UserCFrame.LeftHand) then
        local v35 = v_u_8:GetUserCFrame(Enum.UserCFrame.LeftHand)
        local v36 = v_u_8:GetUserCFrame(Enum.UserCFrame.RightHand)
        local v37 = v32.Position - v35.Position
        local v38 = v32.Position - v36.Position
        local v39 = v37.X
        local v40 = v37.Z
        local v41 = -math.atan2(v39, v40)
        local v42 = v38.X
        local v43 = v38.Z
        local v44 = (-math.atan2(v42, v43) - v41 + 12.566370614359172) % 6.283185307179586
        if v44 > 3.141592653589793 then
            v44 = v44 - 6.283185307179586
        end
        local v45 = (v41 + v44 / 2 + 12.566370614359172) % 6.283185307179586
        if v45 > 3.141592653589793 then
            v45 = v45 - 6.283185307179586
        end
        local v46 = (v34 - p31.currentTorsoAngle + 12.566370614359172) % 6.283185307179586
        if v46 > 3.141592653589793 then
            v46 = v46 - 6.283185307179586
        end
        local v47 = (v45 - p31.currentTorsoAngle + 12.566370614359172) % 6.283185307179586
        if v47 > 3.141592653589793 then
            v47 = v47 - 6.283185307179586
        end
        local v48
        if v47 > -1.5707963267948966 then
            v48 = v47 < 1.5707963267948966
        else
            v48 = false
        end
        if not v48 then
            v47 = v46
        end
        local v49 = math.min(v47, v46)
        local v50 = math.max(v47, v46)
        local v51 = 0
        if v49 > 0 then
            v50 = v49
        elseif v50 >= 0 then
            v50 = v51
        end
        p31.currentTorsoAngle = v50 + p31.currentTorsoAngle
    else
        p31.currentTorsoAngle = v34
    end
    return CFrame.new(v32.Position) * CFrame.fromEulerAnglesYXZ(0, -p31.currentTorsoAngle, 0)
end
function v_u_1.GetActiveController(p52) -- name: GetActiveController
    return p52.activeController
end
function v_u_1.UpdateActiveControlModuleEnabled(p_u_53) -- name: UpdateActiveControlModuleEnabled
    -- upvalues: (copy) v_u_2, (copy) v_u_4, (copy) v_u_16, (copy) v_u_15, (copy) v_u_11, (copy) v_u_17, (copy) v_u_5
    local function v54()
        -- upvalues: (copy) p_u_53, (ref) v_u_4, (ref) v_u_16, (ref) v_u_15, (ref) v_u_11, (ref) v_u_17, (ref) v_u_2
        if p_u_53.touchControlFrame and (v_u_4.PreferredInput == Enum.PreferredInput.Touch and (p_u_53.activeControlModule == v_u_16 or (p_u_53.activeControlModule == v_u_15 or p_u_53.activeControlModule == v_u_11))) then
            if not p_u_53.controllers[v_u_17] then
                p_u_53.controllers[v_u_17] = v_u_17.new()
            end
            p_u_53.touchJumpController = p_u_53.controllers[v_u_17]
            p_u_53.touchJumpController:Enable(true, p_u_53.touchControlFrame)
        elseif p_u_53.touchJumpController then
            p_u_53.touchJumpController:Enable(false)
        end
        if p_u_53.activeControlModule == v_u_16 then
            p_u_53.activeController:Enable(true, v_u_2.LocalPlayer.DevComputerMovementMode == Enum.DevComputerMovementMode.UserChoice, p_u_53.touchJumpController)
            return
        elseif p_u_53.touchControlFrame then
            p_u_53.activeController:Enable(true, p_u_53.touchControlFrame)
        else
            p_u_53.activeController:Enable(true)
        end
    end
    if p_u_53.activeController then
        if p_u_53.controlsEnabled then
            if v_u_5.TouchControlsEnabled or (v_u_4.PreferredInput ~= Enum.PreferredInput.Touch or p_u_53.activeControlModule ~= v_u_16 and (p_u_53.activeControlModule ~= v_u_15 and p_u_53.activeControlModule ~= v_u_11)) then
                v54()
            else
                p_u_53.activeController:Enable(false)
                if p_u_53.touchJumpController then
                    p_u_53.touchJumpController:Enable(false)
                end
                if p_u_53.moveFunction then
                    p_u_53.moveFunction(v_u_2.LocalPlayer, Vector3.new(0, 0, 0), true)
                end
            end
        else
            p_u_53.activeController:Enable(false)
            if p_u_53.touchJumpController then
                p_u_53.touchJumpController:Enable(false)
            end
            if p_u_53.moveFunction then
                p_u_53.moveFunction(v_u_2.LocalPlayer, Vector3.new(0, 0, 0), true)
            end
            return
        end
    else
        return
    end
end
function v_u_1.Enable(p55, p56) -- name: Enable
    local v57 = p56 == nil and true or p56
    if p55.controlsEnabled == v57 then
        return
    else
        p55.controlsEnabled = v57
        if p55.activeController then
            p55:UpdateActiveControlModuleEnabled()
        end
    end
end
function v_u_1.Disable(p58) -- name: Disable
    p58:Enable(false)
end
function v_u_1.SelectComputerMovementModule(_) -- name: SelectComputerMovementModule
    -- upvalues: (copy) v_u_4, (copy) v_u_2, (ref) v_u_21, (copy) v_u_10, (copy) v_u_9, (copy) v_u_7, (copy) v_u_16, (copy) v_u_23
    if v_u_4.KeyboardEnabled or v_u_4.GamepadEnabled then
        local v59 = nil
        local v60 = v_u_2.LocalPlayer.DevComputerMovementMode
        if v60 == Enum.DevComputerMovementMode.UserChoice then
            local v_u_61 = false
            if v_u_21 then
                local function v62()
                    -- upvalues: (ref) v_u_61, (ref) v_u_4
                    v_u_61 = v_u_4.PreferredInput == Enum.PreferredInput.MicroGamepad
                end
                pcall(v62)
            end
            if v_u_4.PreferredInput == Enum.PreferredInput.Gamepad or v_u_61 then
                v59 = v_u_10
            elseif v_u_4.PreferredInput == Enum.PreferredInput.KeyboardAndMouse then
                v59 = v_u_9
            end
            if v_u_7.ComputerMovementMode == Enum.ComputerMovementMode.ClickToMove and v59 == v_u_9 then
                v59 = v_u_16
            end
        else
            v59 = v_u_23[v60]
            if not v59 and v60 ~= Enum.DevComputerMovementMode.Scriptable then
                warn("No character control module is associated with DevComputerMovementMode ", v60)
            end
        end
        if v59 then
            return v59, true
        elseif v60 == Enum.DevComputerMovementMode.Scriptable then
            return nil, true
        else
            return nil, false
        end
    else
        return nil, false
    end
end
function v_u_1.SelectTouchModule(_) -- name: SelectTouchModule
    -- upvalues: (copy) v_u_2, (copy) v_u_23, (copy) v_u_7
    local v63 = v_u_2.LocalPlayer.DevTouchMovementMode
    local v64
    if v63 == Enum.DevTouchMovementMode.UserChoice then
        v64 = v_u_23[v_u_7.TouchMovementMode]
    else
        if v63 == Enum.DevTouchMovementMode.Scriptable then
            return nil, true
        end
        v64 = v_u_23[v63]
    end
    return v64, true
end
local function v_u_67() -- name: getGamepadRightThumbstickPosition
    -- upvalues: (copy) v_u_4
    local v65 = v_u_4:GetGamepadState(Enum.UserInputType.Gamepad1)
    for _, v66 in pairs(v65) do
        if v66.KeyCode ~= Enum.KeyCode.Thumbstick2 then
            continue
        end
        return v66.Position
    end
    return Vector3.new(0, 0, 0)
end
function v_u_1.calculateRawMoveVector(p68, p69, p70) -- name: calculateRawMoveVector
    -- upvalues: (copy) v_u_6, (copy) v_u_8, (copy) v_u_67
    local v71 = v_u_6.CurrentCamera
    if not v71 then
        return p70
    end
    local v72 = v71.CFrame
    if v_u_8.VREnabled and p69.RootPart then
        v_u_8:GetUserCFrame(Enum.UserCFrame.Head)
        local v73 = p68:GetEstimatedVRTorsoFrame()
        if (v71.Focus.Position - v72.Position).Magnitude < 3 then
            v72 = v72 * v73
        else
            v72 = v71.CFrame * (v73.Rotation + v73.Position * v71.HeadScale)
        end
    end
    if p69:GetState() ~= Enum.HumanoidStateType.Swimming then
        local _, _, _, v78, v75, v76, _, _, v77, _, _, v78 = v72:GetComponents()
        if v77 >= 1 or v77 <= -1 then
            v76 = -v75 * math.sign(v77)
        end
        local v79 = v78 * v78 + v76 * v76
        local v80 = math.sqrt(v79)
        local v81 = (v78 * p70.X + v76 * p70.Z) / v80
        local v82 = (v78 * p70.Z - v76 * p70.X) / v80
        return Vector3.new(v81, 0, v82)
    end
    if not v_u_8.VREnabled then
        return v72:VectorToWorldSpace(p70)
    end
    local v83 = p70.X
    local v84 = p70.Z
    local v85 = Vector3.new(v83, 0, v84)
    if v85.Magnitude < 0.01 then
        return Vector3.new(0, 0, 0)
    end
    local v86 = -v_u_67().Y * 1.3962634015954636
    local v87 = -v85.X
    local v88 = -v85.Z
    local v89 = math.atan2(v87, v88)
    local _, v90, _ = v72:ToEulerAnglesYXZ()
    local v91 = v89 + v90
    return CFrame.fromEulerAnglesYXZ(v86, v91, 0).LookVector
end
function v_u_1.OnRenderStepped(p92, p93) -- name: OnRenderStepped
    -- upvalues: (copy) v_u_10, (copy) v_u_8, (copy) v_u_2
    if p92.activeController and (p92.activeController.enabled and p92.humanoid) then
        local v94 = p92.activeController:GetMoveVector()
        local v95 = p92.activeController:IsMoveVectorCameraRelative()
        local v96 = p92:GetClickToMoveController()
        if p92.activeController == v96 then
            v96:OnRenderStepped(p93)
        elseif v94.magnitude > 0 then
            v96:CleanupPath()
        else
            v96:OnRenderStepped(p93)
            v94 = v96:GetMoveVector()
            v95 = v96:IsMoveVectorCameraRelative()
        end
        if p92.vehicleController then
            local v97
            v94, v97 = p92.vehicleController:Update(v94, v95, p92.activeControlModule == v_u_10)
        end
        if v95 then
            v94 = p92:calculateRawMoveVector(p92.humanoid, v94)
        end
        p92.inputMoveVector = v94
        if v_u_8.VREnabled then
            v94 = p92:updateVRMoveVector(v94)
        end
        p92.moveFunction(v_u_2.LocalPlayer, v94, false)
        local v98 = p92.humanoid
        local v99 = not p92.activeController:GetIsJumping() and p92.touchJumpController
        if v99 then
            v99 = p92.touchJumpController:GetIsJumping()
        end
        v98.Jump = v99
    end
end
function v_u_1.updateVRMoveVector(p100, p101) -- name: updateVRMoveVector
    -- upvalues: (copy) v_u_8
    local v102 = workspace.CurrentCamera
    local v103 = (v102.Focus.Position - v102.CFrame.Position).Magnitude < 5
    if p101.Magnitude ~= 0 or (not v103 or (not v_u_8.AvatarGestures or (not p100.humanoid or p100.humanoid.Sit))) then
        return p101
    end
    local v104 = v_u_8:GetUserCFrame(Enum.UserCFrame.Head)
    local v105 = v104.Rotation + v104.Position * v102.HeadScale
    local v106 = -0.7 * p100.humanoid.RootPart.Size.Y / 2
    local v107 = (v102.CFrame * v105 * CFrame.new(0, v106, 0)).Position - p100.humanoid.RootPart.CFrame.Position
    local v108 = v107.x
    local v109 = v107.z
    return Vector3.new(v108, 0, v109)
end
function v_u_1.OnHumanoidSeated(p110, p111, p112) -- name: OnHumanoidSeated
    -- upvalues: (copy) v_u_22
    if p111 then
        if p112 and p112:IsA("VehicleSeat") then
            if not p110.vehicleController then
                p110.vehicleController = p110.vehicleController.new(v_u_22)
            end
            p110.vehicleController:Enable(true, p112)
            return
        end
    elseif p110.vehicleController then
        p110.vehicleController:Enable(false, p112)
    end
end
function v_u_1.OnCharacterAdded(p_u_113, p114) -- name: OnCharacterAdded
    p_u_113.humanoid = p114:FindFirstChildOfClass("Humanoid")
    while not p_u_113.humanoid do
        p114.ChildAdded:wait()
        p_u_113.humanoid = p114:FindFirstChildOfClass("Humanoid")
    end
    if p_u_113.humanoidSeatedConn then
        p_u_113.humanoidSeatedConn:Disconnect()
        p_u_113.humanoidSeatedConn = nil
    end
    p_u_113.humanoidSeatedConn = p_u_113.humanoid.Seated:Connect(function(p115, p116)
        -- upvalues: (copy) p_u_113
        p_u_113:OnHumanoidSeated(p115, p116)
    end)
    p_u_113:UpdateMovementMode()
end
function v_u_1.OnCharacterRemoving(p117, _) -- name: OnCharacterRemoving
    p117.humanoid = nil
    p117:UpdateMovementMode()
end
function v_u_1.UpdateTouchGuiVisibility(p118) -- name: UpdateTouchGuiVisibility
    -- upvalues: (copy) v_u_5, (copy) v_u_4
    local v119 = p118.humanoid and v_u_5.TouchControlsEnabled
    if v119 then
        v119 = v_u_4.PreferredInput == Enum.PreferredInput.Touch
    end
    if v119 and not p118.touchGui then
        p118:CreateTouchGuiContainer()
    end
    if p118.touchGui then
        p118.touchGui.Enabled = v119 and true or false
    end
end
function v_u_1.SwitchToController(p120, p121) -- name: SwitchToController
    -- upvalues: (copy) v_u_22
    if p121 then
        if not p120.controllers[p121] then
            p120.controllers[p121] = p121.new(v_u_22)
        end
        if p120.activeController ~= p120.controllers[p121] then
            if p120.activeController then
                p120.activeController:Enable(false)
            end
            p120.activeController = p120.controllers[p121]
            p120.activeControlModule = p121
            p120:UpdateActiveControlModuleEnabled()
        end
    else
        if p120.activeController then
            p120.activeController:Enable(false)
        end
        p120.activeController = nil
        p120.activeControlModule = nil
    end
end
function v_u_1.UpdateMovementMode(p122) -- name: UpdateMovementMode
    -- upvalues: (copy) v_u_4
    p122:UpdateTouchGuiVisibility()
    if v_u_4.PreferredInput == Enum.PreferredInput.Touch then
        local v123, v124 = p122:SelectTouchModule()
        if v124 and p122.touchControlFrame then
            p122:SwitchToController(v123)
            return
        end
    else
        p122:SwitchToController((p122:SelectComputerMovementModule()))
    end
end
function v_u_1.CreateTouchGuiContainer(p125) -- name: CreateTouchGuiContainer
    -- upvalues: (ref) v_u_14
    if p125.playerGui then
        if p125.touchGui then
            p125.touchGui:Destroy()
        end
        p125.touchGui = Instance.new("ScreenGui")
        p125.touchGui.Name = "TouchGui"
        p125.touchGui.ResetOnSpawn = false
        p125.touchGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        if v_u_14 then
            p125.touchGui.ClipToDeviceSafeArea = false
        end
        p125.touchControlFrame = Instance.new("Frame")
        p125.touchControlFrame.Name = "TouchControlFrame"
        p125.touchControlFrame.Size = UDim2.new(1, 0, 1, 0)
        p125.touchControlFrame.BackgroundTransparency = 1
        p125.touchControlFrame.Parent = p125.touchGui
        p125.touchGui.Parent = p125.playerGui
    end
end
function v_u_1.GetClickToMoveController(p126) -- name: GetClickToMoveController
    -- upvalues: (copy) v_u_16, (copy) v_u_22
    if not p126.controllers[v_u_16] then
        p126.controllers[v_u_16] = v_u_16.new(v_u_22)
    end
    return p126.controllers[v_u_16]
end
return v_u_1.new()
