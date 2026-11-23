-- Script Path: game:GetService("Players").royvolex.PlayerScripts.Modules.ClientReplicatedClasses.Enemies.ClientFighter.ClientItem.ItemInterface.Mouse
-- Took 0s to decompile.

local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("UserInputService")
local v_u_3 = game:GetService("TweenService")
game:GetService("GuiService")
local v4 = game:GetService("Players")
local v_u_5 = require(v1.Modules.CONSTANTS)
local v_u_6 = require(v1.Modules.BetterDebris)
local v_u_7 = require(v1.Modules.Spring)
require(v1.Modules.Signal)
require(v4.LocalPlayer.PlayerScripts.Controllers.ControlsController)
local v_u_8 = require(v4.LocalPlayer.PlayerScripts.Controllers.CameraController)
local v_u_9 = require(v4.LocalPlayer.PlayerScripts.Modules.UILibrary)
local v_u_10 = require(script:WaitForChild("MouseCrosshair"))
local v_u_11 = require(script:WaitForChild("Scope"))
local v_u_12 = v4.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("MouseCooldownSlot")
local v_u_13 = {}
v_u_13.__index = v_u_13
function v_u_13.new(p14) -- name: new
    -- upvalues: (copy) v_u_13, (copy) v_u_10, (copy) v_u_11, (copy) v_u_7
    local v15 = v_u_13
    local v16 = setmetatable({}, v15)
    v16.ItemInterface = p14
    v16.Frame = v16.ItemInterface.Frame:WaitForChild("Mouse")
    v16.CooldownsFrame = v16.Frame:WaitForChild("Cooldowns")
    v16.MouseCrosshair = v_u_10.new(v16)
    v16.Scope = v_u_11.new(v16)
    v16._connections = {}
    v16._slide_spring = v_u_7.new(0, 0.875, 20)
    v16:_Init()
    return v16
end
function v_u_13.SetVisible(p17, p18) -- name: SetVisible
    p17.Frame.Visible = p18
end
function v_u_13.Refresh(p19) -- name: Refresh
    -- upvalues: (copy) v_u_2, (copy) v_u_8, (copy) v_u_5
    local v20 = v_u_2.MouseIconEnabled
    if v20 then
        v20 = v_u_8:GetPublicState() == v_u_8.CameraState.States.ThirdPersonUnlockedMouse
    end
    local v21 = p19.MouseCrosshair.Crosshair
    local v22
    if v_u_5.DEVICE == "VR" then
        v22 = false
    else
        v22 = not v20
    end
    v21:SetVisible(v22)
    p19.CooldownsFrame.Visible = v_u_5.DEVICE ~= "VR"
    p19.Frame.Position = UDim2.new(0.5, 0, 0.5, 0)
end
function v_u_13.Update(p23, p24, p25, p26) -- name: Update
    -- upvalues: (copy) v_u_8, (copy) v_u_9
    if p25.IsSpectating then
        p23._slide_spring.Target = p25.IsSliding and (p25.IsFirstPerson and not p23.MouseCrosshair.Crosshair:IsStatic()) and 1 or 0
        p23._slide_spring.Value = p23._slide_spring.Target > p23._slide_spring.Value and p23._slide_spring.Target or p23._slide_spring.Value
        local v27 = p23._slide_spring.Value
        local v28 = UDim2.new()
        local v29 = v_u_8.ViewModelOffsetCFrame * v_u_8.ShakeCFrame
        if p25.IsFirstPerson and (v29 ~= CFrame.identity and not p23.MouseCrosshair.Crosshair:IsStatic()) then
            local v30 = workspace.CurrentCamera.CFrame * v29:Inverse() * CFrame.new(0, 0, -100)
            local v31 = workspace.CurrentCamera:WorldToScreenPoint(v30.Position)
            v28 = UDim2.new(0, v31.X - p25.MouseLocation.X, 0, v31.Y - p25.MouseLocation.Y)
        end
        local v32 = v_u_9:ScreenPointToPosition(p25.MouseLocation, p23.ItemInterface.Frame.AbsolutePosition)
        p23.Frame.Position = UDim2.new(0, v32.X, 0, v32.Y) + v28
        local v33 = p23.Frame
        local v34 = v27 * 20 + 0.5
        v33.Rotation = math.floor(v34)
        p23.MouseCrosshair:Update(p24, p25, p26)
        p23.Scope:Update(p24, p25, p26)
    end
end
function v_u_13.Destroy(p35) -- name: Destroy
    for _, v36 in pairs(p35._connections) do
        v36:Disconnect()
    end
    p35.MouseCrosshair:Destroy()
    p35.Scope:Destroy()
end
function v_u_13._CooldownEffect(p37, p38) -- name: _CooldownEffect
    -- upvalues: (copy) v_u_12, (copy) v_u_6, (copy) v_u_3
    local v39, v40, v41 = p38.GetVariables()
    local v42 = v_u_12:Clone()
    v42.Icon.Image = p38.Image
    v42.Icon.Container.Icon.Image = p38.Image
    v42.Icon.Container.Size = UDim2.new(v40, 0, 1, 0)
    v42.Bar.Bar.Size = UDim2.new(v40, 0, 1.5, 0)
    v42.Parent = p37.CooldownsFrame
    local v43 = p38.Cleanup
    table.insert(v43, v42)
    v_u_6:AddItem(v42, v39)
    v_u_3:Create(v42.Icon.Container, TweenInfo.new(v39, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {
        ["Size"] = UDim2.new(v41, 0, 1, 0)
    }):Play()
    v_u_3:Create(v42.Bar.Bar, TweenInfo.new(v39, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {
        ["Size"] = UDim2.new(v41, 0, 1.5, 0)
    }):Play()
end
function v_u_13._Init(p_u_44) -- name: _Init
    p_u_44.Frame:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
        -- upvalues: (copy) p_u_44
        p_u_44:Refresh()
    end)
    local v45 = p_u_44._connections
    local v46 = p_u_44.ItemInterface.ClientItem.Cooldowns.CooldownAdded
    table.insert(v45, v46:Connect(function(p47)
        -- upvalues: (copy) p_u_44
        p_u_44:_CooldownEffect(p47)
    end))
    for _, v48 in pairs(p_u_44.ItemInterface.ClientItem.Cooldowns.Cooldowns) do
        task.spawn(p_u_44._CooldownEffect, p_u_44, v48)
    end
end
return v_u_13
