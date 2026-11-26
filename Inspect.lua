local v1 = game:GetService("ReplicatedStorage")
local v2 = game:GetService("Players")
local v_u_3 = require(v1.Modules.SettingsLibrary)
local v_u_4 = require(v1.Modules.InputLibrary)
local v_u_5 = require(v1.Modules.ServerOsTime)
local v_u_6 = require(v1.Modules.DuelLibrary)
local v_u_7 = require(v1.Modules.Utility)
local v_u_8 = require(v2.LocalPlayer.PlayerScripts.Controllers.PlayerDataController)
local v_u_9 = require(v2.LocalPlayer.PlayerScripts.Controllers.SettingsController)
local v_u_10 = require(v2.LocalPlayer.PlayerScripts.Modules.Crosshair)
local v_u_11 = v2.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("MobileButton")
local v_u_12 = {}
v_u_12.__index = v_u_12
function v_u_12.new(p13) -- name: new
	-- upvalues: (copy) v_u_12, (copy) v_u_10, (copy) v_u_11
	local v14 = v_u_12
	local v15 = setmetatable({}, v14)
	v15.Page = p13
	v15.Frame = v15.Page.Container:WaitForChild("Inspect")
	v15.ServerDescriptionText = v15.Frame:WaitForChild("ServerDescription")
	v15.Container = v15.Frame:WaitForChild("Container")
	v15.DescriptionFrame = v15.Container:WaitForChild("Description")
	v15.DescriptionText = v15.DescriptionFrame:WaitForChild("Description")
	v15.DescriptionInvisibleText = v15.DescriptionFrame:WaitForChild("InvisibleDescription")
	v15.DescriptionTitleContainer = v15.DescriptionFrame:WaitForChild("TitleContainer")
	v15.DescriptionTitleIcon = v15.DescriptionTitleContainer:WaitForChild("Icon")
	v15.DescriptionTitleText = v15.DescriptionTitleContainer:WaitForChild("Title")
	v15.MapFrame = v15.Container:WaitForChild("Map")
	v15.MapContainer = v15.MapFrame:WaitForChild("Container")
	v15.MapBackground = v15.MapContainer:WaitForChild("Background")
	v15.MapCurrent = v15.MapBackground:WaitForChild("Current")
	v15.MapNext = v15.MapBackground:WaitForChild("Next")
	v15._current_settings_info = nil
	v15._map_hash = 0
	v15._map_num = 0
	v15._crosshair = v_u_10.new()
	v15._mobile_button = v_u_11:Clone()
	v15._mobile_input_name_connections = {}
	v15._current_mobile_input_name = nil
	v15._update_uptime_thread = nil
	v15:_Init()
	return v15
end
function v_u_12.Inspect(p_u_16, p17) -- name: Inspect
	-- upvalues: (copy) v_u_8
	if p17 == p_u_16._current_settings_info or p17 and p17.InputType == "Divider" then
		return
	else
		for _, v18 in pairs(p_u_16._mobile_input_name_connections) do
			v18:Disconnect()
		end
		p_u_16._mobile_input_name_connections = {}
		p_u_16._current_settings_info = p17
		local v19 = p_u_16._current_settings_info
		if v19 then
			v19 = p_u_16._current_settings_info.Name
		end
		p_u_16._current_mobile_input_name = p_u_16:_GetMobileInputNameFromSettingsName(v19) or (p_u_16._current_mobile_input_name or "mobile_shoot")
		p_u_16.DescriptionFrame.Visible = p_u_16._current_settings_info ~= nil
		p_u_16:_UpdateMapVisibility()
		p_u_16:_UpdateMobileButton()
		if p_u_16._current_settings_info then
			p_u_16.DescriptionTitleIcon.Image = p_u_16._current_settings_info.Image
			p_u_16.DescriptionTitleIcon.Visible = p_u_16.DescriptionTitleIcon.Image ~= ""
			p_u_16.DescriptionTitleText.Text = p_u_16._current_settings_info.DisplayName
			p_u_16.DescriptionInvisibleText.Text = p_u_16._current_settings_info.Description
			if p_u_16._current_mobile_input_name then
				local v20 = p_u_16._mobile_input_name_connections
				local v21 = v_u_8:GetSettingChangedSignal("MobileButton " .. p_u_16._current_mobile_input_name .. " Enabled")
				table.insert(v20, v21:Connect(function()
					-- upvalues: (copy) p_u_16
					p_u_16:_UpdateMobileButton()
				end))
				local v22 = p_u_16._mobile_input_name_connections
				local v23 = v_u_8:GetSettingChangedSignal("Mobile Buttons Transparency")
				table.insert(v22, v23:Connect(function()
					-- upvalues: (copy) p_u_16
					p_u_16:_UpdateMobileButton()
				end))
				local v24 = p_u_16._mobile_input_name_connections
				local v25 = v_u_8:GetSettingChangedSignal("MobileButton " .. p_u_16._current_mobile_input_name .. " Transparency")
				table.insert(v24, v25:Connect(function()
					-- upvalues: (copy) p_u_16
					p_u_16:_UpdateMobileButton()
				end))
				local v26 = p_u_16._mobile_input_name_connections
				local v27 = v_u_8.SettingsSliderChanged
				table.insert(v26, v27:Connect(function(p28, p29)
					-- upvalues: (copy) p_u_16
					p_u_16:_UpdateMobileButton({
						[p28] = p29
					})
				end))
			end
		else
			return
		end
	end
end
function v_u_12.SetVisible(p30, p31) -- name: SetVisible
	p30.Frame.Visible = p31
end
function v_u_12.SetPage(p32, p33) -- name: SetPage
	p32:Inspect(nil)
	p32:SetVisible(p33 ~= "Hotkeys")
	p32._crosshair:SetVisible(p33 == "Crosshair")
	p32:_UpdateMapVisibility()
	p32:_UpdateMobileButton()
end
function v_u_12.Open(p_u_34) -- name: Open
	p_u_34._map_hash = p_u_34._map_hash + 1
	task.spawn(p_u_34._PlayMapEffect, p_u_34)
	if p_u_34._update_uptime_thread then
		local v35 = task.cancel
		local v36 = p_u_34._update_uptime_thread
		pcall(v35, v36)
	end
	p_u_34._update_uptime_thread = task.spawn(function()
		-- upvalues: (copy) p_u_34
		while true do
			p_u_34:_UpdateServerDescription()
			wait(1)
		end
	end)
end
function v_u_12.Close(p37) -- name: Close
	p37._map_hash = p37._map_hash + 1
	p37:Inspect(nil)
	if p37._update_uptime_thread then
		local v38 = task.cancel
		local v39 = p37._update_uptime_thread
		pcall(v38, v39)
	end
end
function v_u_12._UpdateServerDescription(p40) -- name: _UpdateServerDescription
	-- upvalues: (copy) v_u_7, (copy) v_u_5
	local v41 = p40.ServerDescriptionText
	local v42 = game.PlaceVersion
	local v43 = v_u_7
	local v44 = v_u_5:Get() - (workspace:GetAttribute("ServerStartTime") or 0)
	v41.Text = "Version " .. v42 .. "   \226\128\162   Uptime " .. v43:TimeFormat2((math.floor(v44)))
end
function v_u_12._GetMobileInputNameFromSettingsName(_, p45) -- name: _GetMobileInputNameFromSettingsName
	if not p45 or string.sub(p45, 1, 13) ~= "MobileButton " then
		return nil
	end
	local v46 = #p45
	local v47 = string.sub(p45, 14, v46)
	local v48 = string.find(v47, " ")
	if not v48 then
		return nil
	end
	local v49 = v48 - 1
	return string.sub(v47, 1, v49)
end
function v_u_12._UpdateMobileButton(p50, p51) -- name: _UpdateMobileButton
	-- upvalues: (copy) v_u_9, (copy) v_u_8, (copy) v_u_4
	local v52 = p50._mobile_button
	local v53
	if p50.Page.CurrentPage == "Touch" then
		v53 = p50._current_mobile_input_name ~= nil
	else
		v53 = false
	end
	v52.Visible = v53
	if p50._mobile_button.Visible then
		local v54 = v_u_9:GetMobileButtonSetting(p50._current_mobile_input_name, "Mobile Buttons Transparency", "Transparency", p51)
		local v55 = v_u_8:GetSetting("MobileButton " .. p50._current_mobile_input_name .. " Enabled")
		local v56 = v_u_4.MobileButtons[p50._current_mobile_input_name].Image
		p50._mobile_button.Invisible.Visible = not v55
		local v57 = p50._mobile_button.IconContainer
		local v58 = v54 * 2
		v57.ImageTransparency = math.clamp(v58, 0, 1) * 1 + 0
		p50._mobile_button.IconContainer.Icon.ImageTransparency = math.clamp(v54, 0, 1)
		p50._mobile_button.IconContainer.Icon.Image = v56
	end
end
function v_u_12._UpdateMapVisibility(p59) -- name: _UpdateMapVisibility
	local v60 = p59.MapFrame
	local v61
	if p59.Page.CurrentPage == "Crosshair" then
		v61 = true
	elseif p59.Page.CurrentPage == "Touch" then
		v61 = p59._current_mobile_input_name
	else
		v61 = false
	end
	v60.Visible = v61
end
function v_u_12._GetMapImage(_, p62) -- name: _GetMapImage
	-- upvalues: (copy) v_u_6
	return v_u_6.Maps[v_u_6:GetReleasedMapOrder()[(p62 - 1) % #v_u_6:GetReleasedMapOrder() + 1]].Image
end
function v_u_12._PlayMapEffect(p63) -- name: _PlayMapEffect
	p63._map_hash = p63._map_hash + 1
	local v64 = p63._map_hash
	p63._map_num = p63._map_num + 1
	p63.MapNext.Image = p63:_GetMapImage(p63._map_num + 1)
	p63.MapCurrent.Image = p63:_GetMapImage(p63._map_num)
	p63.MapCurrent.Position = UDim2.new(0.625, 0, 0.5, 0)
	p63.MapCurrent:TweenPosition(UDim2.new(0.5, 0, 0.5, 0), "Out", "Quint", 0.25, true)
	wait(5)
	if v64 == p63._map_hash then
		p63.MapCurrent:TweenPosition(UDim2.new(0.375, 0, 0.5, 0), "In", "Quint", 0.25, true)
		wait(0.25)
		if v64 == p63._map_hash then
			continue
		end
	end
end
function v_u_12._UpdateCrosshairAppearance(p65, p66) -- name: _UpdateCrosshairAppearance
	-- upvalues: (copy) v_u_3, (copy) v_u_8
	p65._crosshair:SetAppearance(v_u_3:GenerateCrosshairAppearance(v_u_8, p66))
	p65._crosshair:SetSpacing(p65._crosshair:GetAppearanceSpacing())
end
function v_u_12._UpdateText(p67) -- name: _UpdateText
	p67.DescriptionText.Text = p67.DescriptionInvisibleText.Text
	local v68 = p67.DescriptionText
	local v69 = UDim2.new
	local v70 = p67.DescriptionInvisibleText.Size.Y.Scale
	local v71 = p67.DescriptionInvisibleText.TextBounds.X / p67.DescriptionText.AbsoluteSize.X
	v68.Size = v69(0.9, 0, v70 * math.ceil(v71), 0)
end
function v_u_12._Setup(p72) -- name: _Setup
	p72._crosshair:SetParent(p72.MapContainer)
	p72._mobile_button.Parent = p72.MapContainer
	p72._mobile_button.AnchorPoint = Vector2.new(0.5, 0.5)
	p72._mobile_button.Position = UDim2.new(0.5, 0, 0.5, 0)
	p72._mobile_button.Size = UDim2.new(0.5, 0, 0.5, 0)
	p72._mobile_button.Resize.Visible = false
end
function v_u_12._Init(p_u_73) -- name: _Init
	-- upvalues: (copy) v_u_8, (copy) v_u_3
	p_u_73.DescriptionInvisibleText:GetPropertyChangedSignal("TextBounds"):Connect(function()
		-- upvalues: (copy) p_u_73
		p_u_73:_UpdateText()
	end)
	p_u_73.DescriptionInvisibleText:GetPropertyChangedSignal("Text"):Connect(function()
		-- upvalues: (copy) p_u_73
		p_u_73:_UpdateText()
	end)
	p_u_73.DescriptionInvisibleText:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
		-- upvalues: (copy) p_u_73
		p_u_73:_UpdateText()
	end)
	p_u_73.DescriptionInvisibleText:GetPropertyChangedSignal("AbsolutePosition"):Connect(function()
		-- upvalues: (copy) p_u_73
		p_u_73:_UpdateText()
	end)
	p_u_73.DescriptionText:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
		-- upvalues: (copy) p_u_73
		p_u_73:_UpdateText()
	end)
	v_u_8.SettingsSliderChanged:Connect(function(p74, p75)
		-- upvalues: (copy) p_u_73
		p_u_73:_UpdateCrosshairAppearance({
			[p74] = p75
		})
	end)
	for v76, v77 in pairs(v_u_3.Info) do
		if v77.Section ~= "Crosshair" then
			continue
		end
		v_u_8:GetSettingChangedSignal(v76):Connect(function()
			-- upvalues: (copy) p_u_73
			p_u_73:_UpdateCrosshairAppearance()
		end)
	end
	p_u_73:_Setup()
	p_u_73:_UpdateText()
	p_u_73:_UpdateCrosshairAppearance()
end
return v_u_12