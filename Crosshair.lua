-- Script Path: game:GetService("Players").royvolex.PlayerScripts.Modules.Crosshair
-- Took 0.03s to decompile.

local v1 = game:GetService("ReplicatedStorage")
local v2 = game:GetService("Players")
local v_u_3 = require(v1.Modules.ItemLibrary)
local v_u_4 = require(v1.Modules.Utility)
local v_u_5 = v2.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("Crosshair")
local v_u_6 = {}
v_u_6.__index = v_u_6
function v_u_6.new() -- name: new
    -- upvalues: (copy) v_u_6, (copy) v_u_5
    local v7 = v_u_6
    local v8 = setmetatable({}, v7)
    v8.Type = nil
    v8.Info = nil
    v8.Appearance = nil
    v8.Frame = v_u_5:Clone()
    v8._destroyed = false
    v8._visible = true
    v8._spacing = 16
    v8._spacing_multiplier = 1
    v8._transparency = 0
    v8._update_queued = false
    v8._hitmarker_color = nil
    v8._hitmarker_color_crit = nil
    v8._last_hitmarker_crit_set = false
    v8:_Init()
    return v8
end
function v_u_6.GetDisplayAppearance(p9) -- name: GetDisplayAppearance
    if p9.Info.IsSpecial and not (p9.Appearance and p9.Appearance.Override) then
        return nil
    else
        return p9.Appearance
    end
end
function v_u_6.IsStatic(p10) -- name: IsStatic
    local v11 = p10:GetDisplayAppearance()
    if v11 then
        return v11.IsStatic
    else
        return false
    end
end
function v_u_6.IsScopedRedDotDisabled(p12) -- name: IsScopedRedDotDisabled
    local v13 = p12:GetDisplayAppearance()
    if v13 then
        return v13.ScopedRedDotDisabled
    else
        return false
    end
end
function v_u_6.IsScopedBarsDisabled(p14) -- name: IsScopedBarsDisabled
    local v15 = p14:GetDisplayAppearance()
    if v15 then
        return v15.ScopedBarsDisabled
    else
        return false
    end
end
function v_u_6.GetScopedRedDotColor(p16) -- name: GetScopedRedDotColor
    local v17 = p16:GetDisplayAppearance()
    if v17 then
        v17 = v17.ScopedRedDotColor
    end
    return v17
end
function v_u_6.ShowWhileAiming(p18) -- name: ShowWhileAiming
    local v19 = p18:GetDisplayAppearance()
    if v19 then
        return v19.ShowWhileAiming
    else
        return false
    end
end
function v_u_6.ShowWhileInspecting(p20) -- name: ShowWhileInspecting
    local v21 = p20:GetDisplayAppearance()
    if v21 then
        return v21.ShowWhileInspecting
    else
        return false
    end
end
function v_u_6.GetAppearanceSpacing(p22) -- name: GetAppearanceSpacing
    local v23 = p22:GetDisplayAppearance()
    return v23 and v23.BarsSpacing or 16
end
function v_u_6.SetParent(p24, p25) -- name: SetParent
    p24.Frame.Parent = p25
end
function v_u_6.SetType(p26, p27, p28) -- name: SetType
    -- upvalues: (copy) v_u_3
    p26.Type = p27
    p26.Info = v_u_3.Crosshairs[p26.Type]
    p26:_UpdateDeferred(p28)
end
function v_u_6.SetVisible(p29, p30, p31) -- name: SetVisible
    if p30 ~= p29._visible then
        p29._visible = p30
        p29:_UpdateDeferred(p31)
    end
end
function v_u_6.SetSpacing(p32, p33, p34, p35) -- name: SetSpacing
    if p33 ~= p32._spacing or p34 ~= p32._spacing_multiplier then
        p32._spacing = p33 or p32._spacing
        p32._spacing_multiplier = p34 or p32._spacing_multiplier
        p32:_UpdateDeferred(p35)
    end
end
function v_u_6.SetTransparency(p36, p37, p38) -- name: SetTransparency
    if p37 ~= p36._transparency then
        p36._transparency = p37
        p36:_UpdateDeferred(p38)
    end
end
function v_u_6.SetAppearance(p39, p40, p41) -- name: SetAppearance
    p39.Appearance = p40
    p39:_UpdateDeferred(p41)
end
function v_u_6.SetHitmarkerColor(p42, p43) -- name: SetHitmarkerColor
    -- upvalues: (copy) v_u_4
    p42._last_hitmarker_crit_set = p43
    local v44 = v_u_4
    local v45
    if p42._last_hitmarker_crit_set then
        v45 = p42._hitmarker_color_crit or "#ff3232"
    else
        v45 = p42._hitmarker_color or "#ffffff"
    end
    local v46 = v44:Color3FromHex(v45)
    p42.Frame.Hitmarker.TL.ImageColor3 = v46
    p42.Frame.Hitmarker.TR.ImageColor3 = v46
    p42.Frame.Hitmarker.BR.ImageColor3 = v46
    p42.Frame.Hitmarker.BL.ImageColor3 = v46
end
function v_u_6.SetHitmarkerVisuals(p47, p48, p49, p50, _) -- name: SetHitmarkerVisuals
    local v51 = p47.Appearance
    local v52 = p47._last_hitmarker_crit_set and v51 and v51.HitmarkerTransparencyCrit or (v51 and v51.HitmarkerTransparency or 0)
    local v53 = v52 + (1 - v52) * p50
    p47.Frame.Hitmarker.TL.Position = UDim2.new(0.5, -p48, 0.5, -p48)
    p47.Frame.Hitmarker.TR.Position = UDim2.new(0.5, p48, 0.5, -p48)
    p47.Frame.Hitmarker.BR.Position = UDim2.new(0.5, p48, 0.5, p48)
    p47.Frame.Hitmarker.BL.Position = UDim2.new(0.5, -p48, 0.5, p48)
    p47.Frame.Hitmarker.TL.Size = p49
    p47.Frame.Hitmarker.TR.Size = p49
    p47.Frame.Hitmarker.BR.Size = p49
    p47.Frame.Hitmarker.BL.Size = p49
    p47.Frame.Hitmarker.TL.ImageTransparency = v53
    p47.Frame.Hitmarker.TR.ImageTransparency = v53
    p47.Frame.Hitmarker.BR.ImageTransparency = v53
    p47.Frame.Hitmarker.BL.ImageTransparency = v53
end
function v_u_6.Destroy(p54) -- name: Destroy
    if not p54._destroyed then
        p54._destroyed = true
        local v55 = p54.Frame.Destroy
        local v56 = p54.Frame
        pcall(v55, v56)
    end
end
function v_u_6._UpdateDeferred(p_u_57, ...) -- name: _UpdateDeferred
    if p_u_57._update_queued then
        task.cancel(p_u_57._update_queued)
        p_u_57._update_queued = nil
    end
    p_u_57._update_queued = task.defer(function(...)
        -- upvalues: (copy) p_u_57
        p_u_57._update_queued = nil
        p_u_57:_Update(...)
    end, ...)
end
function v_u_6._Update(p58, p59) -- name: _Update
    -- upvalues: (copy) v_u_3, (copy) v_u_4
    if p58._destroyed or p59 then
        return
    else
        local v60 = p58.Appearance
        local v61 = p58._visible
        if v61 then
            v61 = not v60 and true or not v60.IsDisabled
        end
        p58.Frame.Foreground.Visible = v61
        p58.Frame.Background.Visible = v61
        local v62 = not v60 and true or not v60.HitmarkerDisabled
        local v63
        if v60 then
            v63 = v60.HitmarkerColor
        else
            v63 = v60
        end
        p58._hitmarker_color = v63
        if v60 then
            v60 = v60.HitmarkerColorCrit
        end
        p58._hitmarker_color_crit = v60
        p58.Frame.Hitmarker.Visible = v62
        if v61 then
            local v64 = p58:GetDisplayAppearance()
            local v65 = v64 and (v64.Scale or 1) or 1
            local v66 = v64 and (v64.Rotation or 0) or 0
            local v67 = v64 and (v64.HitmarkerScale or 1) or 1
            local v68 = v64 and (v64.HitmarkerRotation or 0) or 0
            p58.Frame.UIScale.Scale = v65
            p58.Frame.Rotation = v66
            p58.Frame.Hitmarker.UIScale.Scale = v67 / v65
            p58.Frame.Hitmarker.Rotation = -v66 + v68
            local v69 = p58.Info.IsSpecial and (p58.Appearance and p58.Appearance.Override) and v_u_3.Crosshairs.Default or p58.Info
            p58.Frame.Foreground.Dot.Image = v69.DotImage
            p58.Frame.Foreground.Right.Image = v69.RightBarImage
            p58.Frame.Foreground.Left.Image = v69.LeftBarImage
            p58.Frame.Foreground.Down.Image = v69.BottomBarImage
            p58.Frame.Foreground.Up.Image = v69.TopBarImage
            p58.Frame.Background.Dot.Image = p58.Frame.Foreground.Dot.Image
            p58.Frame.Background.Right.Image = p58.Frame.Foreground.Right.Image
            p58.Frame.Background.Left.Image = p58.Frame.Foreground.Left.Image
            p58.Frame.Background.Down.Image = p58.Frame.Foreground.Down.Image
            p58.Frame.Background.Up.Image = p58.Frame.Foreground.Up.Image
            local v70 = not v64 and true or not v64.DotDisabled
            local v71 = not v64 and true or not v64.BarsDisabled
            local v72 = not v64 and true or not v64.BarsTopDisabled
            local v73 = not v64 and true or not v64.BarsBottomDisabled
            local v74 = not v64 and true or not v64.BarsRightDisabled
            local v75 = not v64 and true or not v64.BarsLeftDisabled
            local v76 = not v64 and true or not v64.CircleDisabled
            p58.Frame.Foreground.Dot.Visible = v69.DotEnabled and v70
            local v77 = p58.Frame.Foreground.Right
            local v78 = v69.BarsEnabled
            if v78 then
                if not v71 then
                    v74 = v71
                end
            else
                v74 = v78
            end
            v77.Visible = v74
            local v79 = p58.Frame.Foreground.Left
            local v80 = v69.BarsEnabled
            if v80 then
                if not v71 then
                    v75 = v71
                end
            else
                v75 = v80
            end
            v79.Visible = v75
            local v81 = p58.Frame.Foreground.Down
            local v82 = v69.BarsEnabled
            if v82 then
                if not v71 then
                    v73 = v71
                end
            else
                v73 = v82
            end
            v81.Visible = v73
            local v83 = p58.Frame.Foreground.Up
            local v84 = v69.BarsEnabled
            if v84 then
                if not v71 then
                    v72 = v71
                end
            else
                v72 = v84
            end
            v83.Visible = v72
            p58.Frame.Foreground.Circle.Visible = v69.CircleEnabled and v76
            p58.Frame.Background.Dot.Visible = p58.Frame.Foreground.Dot.Visible
            p58.Frame.Background.Right.Visible = p58.Frame.Foreground.Right.Visible
            p58.Frame.Background.Left.Visible = p58.Frame.Foreground.Left.Visible
            p58.Frame.Background.Down.Visible = p58.Frame.Foreground.Down.Visible
            p58.Frame.Background.Up.Visible = p58.Frame.Foreground.Up.Visible
            p58.Frame.Background.Circle.Visible = p58.Frame.Foreground.Circle.Visible
            local v85
            if v64 then
                v85 = v64.IsStatic
            else
                v85 = false
            end
            local v86 = (v85 and p58:GetAppearanceSpacing() or p58._spacing) * p58._spacing_multiplier
            p58.Frame.Foreground.Right.Position = UDim2.new(0.5, v86, 0.5, 0)
            p58.Frame.Foreground.Left.Position = UDim2.new(0.5, -v86, 0.5, 0)
            p58.Frame.Foreground.Down.Position = UDim2.new(0.5, 0, 0.5, v86)
            p58.Frame.Foreground.Up.Position = UDim2.new(0.5, 0, 0.5, -v86)
            p58.Frame.Background.Right.Position = p58.Frame.Foreground.Right.Position
            p58.Frame.Background.Left.Position = p58.Frame.Foreground.Left.Position
            p58.Frame.Background.Down.Position = p58.Frame.Foreground.Down.Position
            p58.Frame.Background.Up.Position = p58.Frame.Foreground.Up.Position
            local v87 = v64 and (v64.DotTransparency or 0) or 0
            local v88 = v87 + (1 - v87) * p58._transparency
            local v89 = v64 and (v64.BarsTransparency or 0) or 0
            local v90 = v89 + (1 - v89) * p58._transparency
            local v91 = v64 and (v64.CircleTransparency or 0) or 0
            local v92 = v91 + (1 - v91) * p58._transparency
            p58.Frame.Foreground.Dot.ImageTransparency = v88
            p58.Frame.Foreground.Right.ImageTransparency = v90
            p58.Frame.Foreground.Left.ImageTransparency = v90
            p58.Frame.Foreground.Down.ImageTransparency = v90
            p58.Frame.Foreground.Up.ImageTransparency = v90
            p58.Frame.Foreground.Circle.UIStroke.Transparency = v92
            p58.Frame.Background.Dot.ImageTransparency = p58.Frame.Foreground.Dot.ImageTransparency
            p58.Frame.Background.Right.ImageTransparency = p58.Frame.Foreground.Right.ImageTransparency
            p58.Frame.Background.Left.ImageTransparency = p58.Frame.Foreground.Left.ImageTransparency
            p58.Frame.Background.Down.ImageTransparency = p58.Frame.Foreground.Down.ImageTransparency
            p58.Frame.Background.Up.ImageTransparency = p58.Frame.Foreground.Up.ImageTransparency
            local v93 = v64 and (v64.DotThickness or 2) or 2
            local v94 = v64 and (v64.BarsLength or 6) or 6
            local v95 = v64 and (v64.BarsThickness or 2) or 2
            local v96 = v64 and (v64.CircleSize or 16) or 16
            local v97 = v64 and (v64.CircleThickness or 2) or 2
            p58.Frame.Foreground.Dot.Size = v69.DotSize or UDim2.new(0, v93, 0, v93)
            p58.Frame.Foreground.Right.Size = v69.RightBarSize or UDim2.new(0, v94, 0, v95)
            p58.Frame.Foreground.Left.Size = v69.LeftBarSize or UDim2.new(0, v94, 0, v95)
            p58.Frame.Foreground.Down.Size = v69.BottomBarSize or UDim2.new(0, v95, 0, v94)
            p58.Frame.Foreground.Up.Size = v69.TopBarSize or UDim2.new(0, v95, 0, v94)
            p58.Frame.Foreground.Circle.Size = v69.CircleSize or UDim2.new(0, v96, 0, v96)
            p58.Frame.Foreground.Circle.UIStroke.Thickness = v69.CircleThickness or v97
            p58.Frame.Background.Dot.Size = p58.Frame.Foreground.Dot.Size
            p58.Frame.Background.Right.Size = p58.Frame.Foreground.Right.Size
            p58.Frame.Background.Left.Size = p58.Frame.Foreground.Left.Size
            p58.Frame.Background.Down.Size = p58.Frame.Foreground.Down.Size
            p58.Frame.Background.Up.Size = p58.Frame.Foreground.Up.Size
            local v98 = not v64 and true or not v64.OutlineDisabled
            p58.Frame.Background.Circle.UIStroke.Enabled = v98
            p58.Frame.Background.Dot.UIStroke.Enabled = v98
            p58.Frame.Background.Right.UIStroke.Enabled = v98
            p58.Frame.Background.Left.UIStroke.Enabled = v98
            p58.Frame.Background.Down.UIStroke.Enabled = v98
            p58.Frame.Background.Up.UIStroke.Enabled = v98
            if v98 then
                local v99 = v64 and (v64.OutlineTransparency or 0) or 0
                local v100 = v99 + (1 - v99) * p58._transparency
                p58.Frame.Background.Dot.UIStroke.Transparency = v100
                p58.Frame.Background.Right.UIStroke.Transparency = v100
                p58.Frame.Background.Left.UIStroke.Transparency = v100
                p58.Frame.Background.Down.UIStroke.Transparency = v100
                p58.Frame.Background.Up.UIStroke.Transparency = v100
                p58.Frame.Background.Circle.UIStroke.Transparency = v100
                local v101 = v64 and (v64.OutlineThickness or 0) or 0
                local _ = v101 * 2 + v97
                p58.Frame.Background.Dot.UIStroke.Thickness = v101
                p58.Frame.Background.Right.UIStroke.Thickness = v101
                p58.Frame.Background.Left.UIStroke.Thickness = v101
                p58.Frame.Background.Down.UIStroke.Thickness = v101
                p58.Frame.Background.Up.UIStroke.Thickness = v101
                p58.Frame.Background.Circle.UIStroke.Thickness = v101 * 2 + v97
                local v102 = p58.Frame.Background.Circle
                local v103 = UDim2.new
                local v104 = p58.Frame.Foreground.Circle.Size.X.Offset - v101 * 2
                local v105 = math.max(0, v104)
                local v106 = p58.Frame.Foreground.Circle.Size.Y.Offset - v101 * 2
                v102.Size = v103(0, v105, 0, (math.max(0, v106)))
                local v107 = Enum.LineJoinMode[v64 and (v64.OutlineType or "Miter") or "Miter"]
                p58.Frame.Background.Dot.UIStroke.LineJoinMode = v107
                p58.Frame.Background.Right.UIStroke.LineJoinMode = v107
                p58.Frame.Background.Left.UIStroke.LineJoinMode = v107
                p58.Frame.Background.Down.UIStroke.LineJoinMode = v107
                p58.Frame.Background.Up.UIStroke.LineJoinMode = v107
            end
            local v108 = v_u_4:Color3FromHex(v64 and (v64.DotColor or "#ffffff") or "#ffffff")
            local v109 = v_u_4:Color3FromHex(v64 and (v64.BarsColor or "#ffffff") or "#ffffff")
            local v110 = v_u_4:Color3FromHex(v64 and (v64.CircleColor or "#ffffff") or "#ffffff")
            p58.Frame.Foreground.Dot.ImageColor3 = v108
            p58.Frame.Foreground.Right.ImageColor3 = v109
            p58.Frame.Foreground.Left.ImageColor3 = v109
            p58.Frame.Foreground.Down.ImageColor3 = v109
            p58.Frame.Foreground.Up.ImageColor3 = v109
            p58.Frame.Foreground.Circle.UIStroke.Color = v110
            p58.Frame.Background.Dot.ImageColor3 = p58.Frame.Foreground.Dot.ImageColor3
            p58.Frame.Background.Right.ImageColor3 = p58.Frame.Foreground.Right.ImageColor3
            p58.Frame.Background.Left.ImageColor3 = p58.Frame.Foreground.Left.ImageColor3
            p58.Frame.Background.Down.ImageColor3 = p58.Frame.Foreground.Down.ImageColor3
            p58.Frame.Background.Up.ImageColor3 = p58.Frame.Foreground.Up.ImageColor3
            local v111 = v_u_4:Color3FromHex(v64 and (v64.OutlineColor or "#000000") or "#000000")
            p58.Frame.Background.Dot.UIStroke.Color = v111
            p58.Frame.Background.Right.UIStroke.Color = v111
            p58.Frame.Background.Left.UIStroke.Color = v111
            p58.Frame.Background.Down.UIStroke.Color = v111
            p58.Frame.Background.Up.UIStroke.Color = v111
            p58.Frame.Background.Circle.UIStroke.Color = v111
            local v112 = v64 and (v64.BarsShape or "Sharp") or "Sharp"
            local v113 = v64 and (v64.DotShape or "Sharp") or "Sharp"
            local v114 = v64 and v64.CircleShape or "Circle"
            p58.Frame.Foreground.Dot.UICorner.CornerRadius = v113 == "Round" and UDim.new(1, 0) or UDim.new(0, 0)
            p58.Frame.Foreground.Right.UICorner.CornerRadius = v112 == "Round" and UDim.new(1, 0) or UDim.new(0, 0)
            p58.Frame.Foreground.Left.UICorner.CornerRadius = v112 == "Round" and UDim.new(1, 0) or UDim.new(0, 0)
            p58.Frame.Foreground.Down.UICorner.CornerRadius = v112 == "Round" and UDim.new(1, 0) or UDim.new(0, 0)
            p58.Frame.Foreground.Up.UICorner.CornerRadius = v112 == "Round" and UDim.new(1, 0) or UDim.new(0, 0)
            p58.Frame.Foreground.Circle.UICorner.CornerRadius = v114 == "Circle" and UDim.new(1, 0) or (v114 == "Round" and UDim.new(0.25, 0) or UDim.new(0, 0))
            p58.Frame.Background.Dot.UICorner.CornerRadius = p58.Frame.Foreground.Dot.UICorner.CornerRadius
            p58.Frame.Background.Right.UICorner.CornerRadius = p58.Frame.Foreground.Right.UICorner.CornerRadius
            p58.Frame.Background.Left.UICorner.CornerRadius = p58.Frame.Foreground.Left.UICorner.CornerRadius
            p58.Frame.Background.Down.UICorner.CornerRadius = p58.Frame.Foreground.Down.UICorner.CornerRadius
            p58.Frame.Background.Up.UICorner.CornerRadius = p58.Frame.Foreground.Up.UICorner.CornerRadius
            p58.Frame.Background.Circle.UICorner.CornerRadius = p58.Frame.Foreground.Circle.UICorner.CornerRadius
        end
    end
end
function v_u_6._Setup(p115) -- name: _Setup
    p115.Frame.Visible = true
end
function v_u_6._Init(p_u_116) -- name: _Init
    p_u_116.Frame.Destroying:Connect(function()
        -- upvalues: (copy) p_u_116
        p_u_116:Destroy()
    end)
    p_u_116:_Setup()
    p_u_116:SetType("Default", true)
    p_u_116:SetSpacing(16, 1, true)
    p_u_116:SetTransparency(0, true)
    p_u_116:SetHitmarkerVisuals(0, UDim2.new(0, 0, 0), 1, 0)
    p_u_116:SetVisible(true, true)
    p_u_116:SetAppearance(nil, true)
    p_u_116:_Update()
end
return v_u_6
