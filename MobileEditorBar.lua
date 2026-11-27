local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("Players")
local v_u_3 = require(v1.Modules.SettingsLibrary)
local v_u_4 = require(v1.Modules.Utility)
local v_u_5 = require(v1.Modules.Signal)
local v_u_6 = require(v_u_2.LocalPlayer.PlayerScripts.Controllers:WaitForChild("PlayerDataController"))
local v_u_7 = require(v_u_2.LocalPlayer.PlayerScripts.Controllers:WaitForChild("SettingsController"))
local v_u_8 = require(v_u_2.LocalPlayer.PlayerScripts.Modules.UserInterface:WaitForChild("MobileInputs"))
local v_u_9 = require(v_u_2.LocalPlayer.PlayerScripts.Modules:WaitForChild("InsetButtonsBar"))
local v_u_10 = require(v_u_2.LocalPlayer.PlayerScripts.Modules:WaitForChild("ButtonEffect"))
local v_u_11 = require(v_u_2.LocalPlayer.PlayerScripts.Modules.UserInterface:WaitForChild("Pages"))
local v_u_12 = require(v_u_2.LocalPlayer.PlayerScripts.Modules:WaitForChild("UILibrary"))
local v_u_13 = v_u_2.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("InsetBarButtonShareBubble")
local v_u_14 = {}
local v_u_15 = {
	{ "Close", "Finish editing", "rbxassetid://108220438104376" },
	{ "Settings", "Edit your settings", "rbxassetid://14641612286" },
	{ "Reset", "Double tap to reset this layout", "rbxassetid://81857929131936" },
	{ "Share", "Share & import this layout", "rbxassetid://13733474711" }
}
local v_u_16 = {}
v_u_16.__index = v_u_16
function v_u_16.new(p17) -- name: new
	-- upvalues: (copy) v_u_16, (copy) v_u_9, (copy) v_u_12, (copy) v_u_5, (copy) v_u_13
	local v18 = v_u_16
	local v19 = setmetatable({}, v18)
	v19.Inset = p17
	v19.Bar = v_u_9.new(v_u_12.BUTTON_BACKGROUND_TRANSPARENCY, v_u_12.BUTTON_BACKGROUND_COLOR, v_u_12.BUTTON_ICON_COLOR)
	v19._last_reset_click = 0
	v19._reset_button_hash = 0
	v19._interruption_internal = v_u_5.new()
	v19._share_bubble_frame = v_u_13:Clone()
	v19._was_from_settings = false
	v19:_Init()
	return v19
end
function v_u_16.SetVisible(p20, p21, p22, p23) -- name: SetVisible
	-- upvalues: (copy) v_u_8
	local v24
	if p21 then
		v24 = p20._was_from_settings or p23
	else
		v24 = false
	end
	p20._was_from_settings = v24
	p20.Bar.Buttons.Close.Frame.Visible = not p20._was_from_settings
	p20.Bar.Frame.Visible = p21
	p20.Bar.Frame.Size = p22 or p20.Bar.Frame.Size
	p20.Bar:Toggle(true)
	p20:_CloseButtonAnimation()
	v_u_8.EditorLogic:SetEnabled(p21)
	if not p21 then
		p20._interruption_internal:Fire()
	end
end
function v_u_16._UpdateShareBubble(p25) -- name: _UpdateShareBubble
	p25._share_bubble_frame.Position = UDim2.new(0, p25.Bar.Buttons.Share.Frame.AbsolutePosition.X - p25.Inset.InsetGui.AbsolutePosition.X + p25.Bar.Buttons.Share.Frame.AbsoluteSize.X / 2, 0, p25.Bar.Buttons.Share.Frame.AbsolutePosition.Y + p25.Bar.Buttons.Share.Frame.AbsoluteSize.Y - p25.Inset.InsetGui.AbsolutePosition.Y)
	p25._share_bubble_frame.Size = UDim2.new(0, p25.Bar.Buttons.Share.Frame.AbsoluteSize.X * 15, 0, p25.Bar.Buttons.Share.Frame.AbsoluteSize.Y * 3)
end
function v_u_16._CloseButtonAnimation(p26) -- name: _CloseButtonAnimation
	-- upvalues: (copy) v_u_2
	local v27 = p26.Bar.Buttons.Close
	if v27.Frame:IsDescendantOf(v_u_2) then
		v27.Frame.Button.Icon.Size = UDim2.new(0, 0, 0, 0)
		v27.Frame.Button.Icon:TweenSize(UDim2.new(0.5, 0, 0.5, 0), "Out", "Quint", 0.25, true)
	else
		v27.Frame.Button.Icon.Size = UDim2.new(0.5, 0, 0.5, 0)
	end
end
function v_u_16._UpdateProfileButtons(p28) -- name: _UpdateProfileButtons
	-- upvalues: (copy) v_u_6
	local v29 = v_u_6:Get("MobileButtonSettings")
	local v30 = v_u_6:Get("SettingsProfile")
	for v31, _ in pairs(v29) do
		local v32 = v30 == v31
		local v33 = p28.Bar.Buttons["Profile" .. v31]
		v33.Frame.Button.IsSelected.Visible = v32
		v33.Frame.Button.Title.TextColor3 = v32 and p28.Bar:GetBackgroundColor() or p28.Bar:GetVisualColor()
		v33.Frame.Button.Icon.ImageColor3 = v32 and p28.Bar:GetBackgroundColor() or p28.Bar:GetVisualColor()
	end
end
function v_u_16._Setup(p_u_34) -- name: _Setup
	-- upvalues: (copy) v_u_15, (copy) v_u_6, (copy) v_u_8, (copy) v_u_14, (copy) v_u_3, (copy) v_u_7, (copy) v_u_11, (copy) v_u_4
	for v35, v36 in pairs(v_u_15) do
		p_u_34.Bar:CreateButton(v35, table.unpack(v36))
	end
	local v37 = v_u_6:Get("MobileButtonSettings")
	for v_u_38, _ in pairs(v37) do
		local v39 = p_u_34.Bar:CreateButton(#v_u_15 + v_u_38, "Profile" .. v_u_38, "Switch to layout #" .. v_u_38, v_u_38)
		local v40 = Instance.new("Frame")
		v40.AnchorPoint = Vector2.new(0.5, 0.5)
		v40.Size = UDim2.new(0.75, 0, 0.75, 0)
		v40.Position = UDim2.new(0.5, 0, 0.5, 0)
		v40.ZIndex = 0
		v40.Name = "IsSelected"
		v40.BackgroundColor3 = p_u_34.Bar:GetVisualColor()
		v40.Parent = v39.Frame.Button
		local v41 = Instance.new("UICorner")
		v41.CornerRadius = UDim.new(1, 0)
		v41.Parent = v40
		v39.Clicked:Connect(function()
			-- upvalues: (ref) v_u_8, (copy) v_u_38
			v_u_8:SwitchProfile(v_u_38)
		end)
	end
	for v42, v_u_43 in pairs(v_u_14) do
		local v_u_44 = v_u_3.Info[v_u_43]
		local v_u_45 = p_u_34.Bar:CreateButton(#v_u_15 + #v37 + v42, "Settings" .. v42, nil, v_u_44.Image)
		v_u_45.Clicked:Connect(function()
			-- upvalues: (ref) v_u_7, (copy) v_u_43, (ref) v_u_6
			v_u_7:ChangeSetting(v_u_43, not v_u_6:GetSetting(v_u_43))
		end)
		local v_u_46 = 0
		local function v_u_51(p47) -- name: update_value
			-- upvalues: (copy) p_u_34, (copy) v_u_43, (ref) v_u_46, (ref) v_u_6, (copy) v_u_45, (copy) v_u_44
			p_u_34._interruption_internal:Fire(v_u_43)
			v_u_46 = v_u_46 + 1
			local v48 = v_u_6:GetSetting(v_u_43)
			v_u_45.Frame.Button.Icon.ImageColor3 = v48 and Color3.fromRGB(100, 255, 50) or Color3.fromRGB(255, 50, 50)
			local v49 = v_u_45
			local v50
			if p47 then
				v50 = string.format("%s <font weight=\"900\" color=\"rgb(%s)\">%s</font>", v_u_44.DisplayName, v48 and "100,255,50" or "255,50,50", v48 and "ON" or "OFF")
			else
				v50 = nil
			end
			v49:PlayBubbleEffect(v50)
		end
		v_u_6:GetSettingChangedSignal(v_u_43):Connect(function()
			-- upvalues: (copy) v_u_51
			v_u_51(true)
		end)
		v_u_51(false)
		p_u_34._interruption_internal:Connect(function(p52)
			-- upvalues: (copy) v_u_43, (copy) v_u_45
			if p52 ~= v_u_43 then
				v_u_45:PlayBubbleEffect(nil)
			end
		end)
	end
	p_u_34.Bar.Buttons.Close.Clicked:Connect(function()
		-- upvalues: (copy) p_u_34
		p_u_34:SetVisible(false)
		p_u_34.Inset.MainBar:SetVisible(true, p_u_34.Bar.Frame.Size)
	end)
	p_u_34.Bar.Buttons.Settings.Clicked:Connect(function()
		-- upvalues: (copy) p_u_34, (ref) v_u_11
		p_u_34:SetVisible(false)
		p_u_34.Inset.MainBar:SetVisible(true, p_u_34.Bar.Frame.Size)
		v_u_11.PageSystem:OpenPage("Settings", true)
		v_u_11.PageSystem:WaitForPage("Settings"):SetPage("Touch")
	end)
	p_u_34.Bar.Buttons.Reset.Clicked:Connect(function()
		-- upvalues: (copy) p_u_34, (ref) v_u_4, (ref) v_u_8
		if tick() > p_u_34._last_reset_click + 0.5 then
			p_u_34._last_reset_click = tick()
		else
			local v53 = p_u_34
			v53._reset_button_hash = v53._reset_button_hash + 1
			local v_u_54 = p_u_34._reset_button_hash
			task.spawn(v_u_4.RenderstepForLoop, v_u_4, 0, 100, 5, function(p55)
				-- upvalues: (ref) p_u_34, (copy) v_u_54
				if p_u_34._reset_button_hash ~= v_u_54 then
					return true
				end
				local v56 = 1 - (1 - p55 / 100) ^ 3
				p_u_34.Bar.Buttons.Reset.Frame.Button.Icon.Rotation = -360 * (1 - v56)
			end)
			v_u_8.EditorLogic:ResetLayout()
		end
	end)
	p_u_34.Bar.Buttons.Share.Clicked:Connect(function()
		-- upvalues: (copy) p_u_34, (ref) v_u_8, (ref) v_u_6
		p_u_34._share_bubble_frame.Import.Box.Text = ""
		p_u_34._share_bubble_frame.Export.Text = v_u_8.Buttons:EncryptProfile()
		p_u_34._share_bubble_frame.ExportTitle.Text = "Share layout #" .. v_u_6:Get("SettingsProfile") .. " by copying this: "
		p_u_34._share_bubble_frame.Visible = true
		p_u_34._interruption_internal:Fire("Share")
	end)
	p_u_34.Bar.Buttons.Share.Frame:GetPropertyChangedSignal("AbsolutePosition"):Connect(function()
		-- upvalues: (copy) p_u_34
		p_u_34:_UpdateShareBubble()
	end)
	p_u_34.Bar.Buttons.Share.Frame:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
		-- upvalues: (copy) p_u_34
		p_u_34:_UpdateShareBubble()
	end)
	p_u_34._interruption_internal:Connect(function(p57)
		-- upvalues: (copy) p_u_34
		if p57 ~= "Share" then
			p_u_34._share_bubble_frame.Visible = false
		end
	end)
	p_u_34._share_bubble_frame.ZIndex = 999999
	p_u_34._share_bubble_frame.Parent = p_u_34.Inset.InsetGui
	p_u_34.Bar.Frame.Parent = p_u_34.Inset.LeftButtonsFrame
end
function v_u_16._Init(p_u_58) -- name: _Init
	-- upvalues: (copy) v_u_8, (copy) v_u_6, (copy) v_u_10
	p_u_58.Inset.InsetGui:GetPropertyChangedSignal("AbsolutePosition"):Connect(function()
		-- upvalues: (copy) p_u_58
		p_u_58:_UpdateShareBubble()
	end)
	p_u_58.Inset.InsetGui:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
		-- upvalues: (copy) p_u_58
		p_u_58:_UpdateShareBubble()
	end)
	p_u_58._share_bubble_frame.Close.MouseButton1Click:Connect(function()
		-- upvalues: (copy) p_u_58
		p_u_58._share_bubble_frame.Visible = false
	end)
	p_u_58._share_bubble_frame.Import.Button.MouseButton1Click:Connect(function()
		-- upvalues: (ref) v_u_8, (copy) p_u_58
		v_u_8.EditorLogic:ImportProfile(p_u_58._share_bubble_frame.Import.Box.Text)
	end)
	v_u_6:GetDataChangedSignal("MobileButtonSettings"):Connect(function()
		-- upvalues: (copy) p_u_58
		p_u_58:_UpdateProfileButtons()
	end)
	v_u_6:GetDataChangedSignal("SettingsProfile"):Connect(function()
		-- upvalues: (copy) p_u_58
		p_u_58:_UpdateProfileButtons()
	end)
	p_u_58:_Setup()
	p_u_58:_UpdateShareBubble()
	p_u_58:_UpdateProfileButtons()
	p_u_58:SetVisible(false)
	v_u_10:Add(p_u_58._share_bubble_frame.Import.Button, true)
end
return v_u_16