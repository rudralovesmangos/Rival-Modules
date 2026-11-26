local v1 = game:GetService("ReplicatedStorage")
local v2 = game:GetService("Players")
local v_u_3 = require(v1.Modules.SettingsLibrary)
local v_u_4 = require(v1.Modules.EnumLibrary)
local v_u_5 = require(v1.Modules.Utility)
local v_u_6 = require(v1.Modules.Signal)
local v_u_7 = require(v2.LocalPlayer.PlayerScripts.Controllers:WaitForChild("PlayerDataController"))
local v_u_8 = require(v2.LocalPlayer.PlayerScripts.Controllers:WaitForChild("SettingsController"))
local v_u_9 = require(v2.LocalPlayer.PlayerScripts.Modules:WaitForChild("ButtonEffect"))
local v_u_10 = v2.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("SettingsProfileSlot")
local v_u_11 = {}
v_u_11.__index = v_u_11
function v_u_11.new(p12) -- name: new
	-- upvalues: (copy) v_u_11, (copy) v_u_6
	local v13 = v_u_11
	local v14 = setmetatable({}, v13)
	v14.Clicked = v_u_6.new()
	v14.Page = p12
	v14.Frame = v14.Page.Container:WaitForChild("Profiles")
	v14.Background = v14.Frame:WaitForChild("Background")
	v14.Container = v14.Frame:WaitForChild("Container")
	v14.Layout = v14.Container:WaitForChild("Layout")
	v14.ShareFrame = v14.Container:WaitForChild("Share")
	v14.ShareButton = v14.ShareFrame:WaitForChild("Button")
	v14.ShareBubbleFrame = v14.ShareFrame:WaitForChild("Bubble")
	v14.ShareCloseButton = v14.ShareBubbleFrame:WaitForChild("Close")
	v14.ShareExportBox = v14.ShareBubbleFrame:WaitForChild("Export")
	v14.ShareExportSectionBox = v14.ShareBubbleFrame:WaitForChild("ExportSection")
	v14.ShareExportSectionTitle = v14.ShareBubbleFrame:WaitForChild("ExportSectionTitle")
	v14.ShareImportFrame = v14.ShareBubbleFrame:WaitForChild("Import")
	v14.ShareImportButton = v14.ShareImportFrame:WaitForChild("Button")
	v14.ShareImportButtonTitle = v14.ShareImportButton:WaitForChild("Title")
	v14.ShareImportButtonSection = v14.ShareImportButton:WaitForChild("Section")
	v14.ShareImportBox = v14.ShareImportFrame:WaitForChild("Box")
	v14._slots = {}
	v14._update_hash = 0
	v14:_Init()
	return v14
end
function v_u_11.SetPage(p15) -- name: SetPage
	p15:_SetShareBubbleVisible(false)
end
function v_u_11.Open(p16) -- name: Open
	p16:_SetShareBubbleVisible(false)
end
function v_u_11._ImportSettings(p17) -- name: _ImportSettings
	-- upvalues: (copy) v_u_4, (copy) v_u_5, (copy) v_u_8
	local v18, v19 = v_u_4:DecryptTable(p17.ShareImportBox.Text)
	if v18 then
		v_u_8:ChangeSettings(v19)
		p17:_SetShareBubbleVisible(false)
	else
		v_u_5:CreateSound("rbxassetid://17153811469", 2, 1, script, true, 5)
	end
end
function v_u_11._GetBulkSettings(_, p20) -- name: _GetBulkSettings
	-- upvalues: (copy) v_u_3, (copy) v_u_7
	local v21 = {}
	for _, v22 in pairs(v_u_3.Order) do
		if v22.InputType == "Divider" or p20 and v22.Section ~= p20 then
			continue
		end
		local v23 = { v22.Name, v_u_7:GetSetting(v22.Name) }
		table.insert(v21, v23)
	end
	return v21
end
function v_u_11._UpdateImportButton(p24) -- name: _UpdateImportButton
	-- upvalues: (copy) v_u_4, (copy) v_u_3
	local v25, v26 = v_u_4:DecryptTable(p24.ShareImportBox.Text)
	local v27 = nil
	if v25 then
		for _, v28 in pairs(v26) do
			local v29 = v_u_3.Info[v28[1]]
			if v29 then
				v29 = v_u_3.Info[v28[1]].Section
			end
			if not v29 then
				continue
			end
			if v27 then
				if v27 == v29 then
					continue
				end
				if v27 == v29 then
					continue
				end
				v27 = "Everything"
				break
			end
			v27 = v29
		end
	end
	local v30 = p24.ShareImportButtonTitle
	local v31
	if v25 then
		v31 = UDim2.new(0.5, 0, 0.35, 0)
	else
		v31 = UDim2.new(0.5, 0, 0.5, 0)
	end
	v30.Position = v31
	p24.ShareImportButtonSection.Visible = v25
	p24.ShareImportButtonSection.Text = v27 or "Nothing"
end
function v_u_11._SetShareBubbleVisible(p32, p33) -- name: _SetShareBubbleVisible
	-- upvalues: (copy) v_u_4
	if p33 ~= p32.ShareBubbleFrame.Visible then
		p32.ShareBubbleFrame.Visible = p33
		p32.ShareExportSectionTitle.Text = string.format("Share only your %s settings by copying this: ", p32.Page.CurrentPage or "")
		p32.ShareExportBox.Text = v_u_4:EncryptTable(p32:_GetBulkSettings(nil))
		p32.ShareExportSectionBox.Text = not p32.Page.CurrentPage and "???" or v_u_4:EncryptTable(p32:_GetBulkSettings(p32.Page.CurrentPage))
		p32.ShareImportBox.Text = ""
	end
end
function v_u_11._Update(p_u_34, p35) -- name: _Update
	-- upvalues: (copy) v_u_7
	p_u_34._update_hash = p_u_34._update_hash + 1
	local v_u_36 = p_u_34._update_hash
	local v37 = v_u_7:Get("SettingsProfile")
	for v38, v_u_39 in pairs(p_u_34._slots) do
		local v40 = v38 == v37
		v_u_39.Button.Background.Visible = v40
		local v41 = v_u_39.Button.Title
		local v42
		if v40 then
			v42 = Color3.fromRGB(0, 0, 0)
		else
			v42 = Color3.fromRGB(255, 255, 255)
		end
		v41.TextColor3 = v42
		v_u_39.Bubble.Visible = false
		if not v40 or p35 then
			continue
		end
		v_u_39.Bubble.Visible = true
		v_u_39.Bubble.Size = UDim2.new(0.5, 0, 0.5, 0)
		v_u_39.Bubble:TweenSize(UDim2.new(1, 0, 1, 0), "Out", "Quint", 0.25, true)
		task.delay(3, function()
			-- upvalues: (copy) v_u_36, (copy) p_u_34, (copy) v_u_39
			if v_u_36 == p_u_34._update_hash then
				v_u_39.Bubble:TweenSize(UDim2.new(0.5, 0, 0.5, 0), "In", "Quint", 0.25, true)
				task.delay(0.25, function()
					-- upvalues: (ref) v_u_36, (ref) p_u_34, (ref) v_u_39
					if v_u_36 == p_u_34._update_hash then
						v_u_39.Bubble.Visible = false
					end
				end)
			end
		end)
	end
end
function v_u_11._ButtonEffect(_, p_u_43) -- name: _ButtonEffect
	-- upvalues: (copy) v_u_9
	p_u_43.MouseEnter:Connect(function()
		-- upvalues: (copy) p_u_43
		p_u_43.OnHover.Visible = true
	end)
	p_u_43.MouseLeave:Connect(function()
		-- upvalues: (copy) p_u_43
		p_u_43.OnHover.Visible = false
	end)
	v_u_9:Add(p_u_43)
end
function v_u_11._Setup(p_u_44) -- name: _Setup
	-- upvalues: (copy) v_u_3, (copy) v_u_10
	for v_u_45 = 1, v_u_3.NUM_PROFILES do
		local v46 = v_u_10:Clone()
		v46.Button.Title.Text = v_u_45
		v46.Bubble.Container.Title.Text = "Switched to profile #" .. v_u_45
		v46.Parent = p_u_44.Container
		v46.Button.MouseButton1Click:Connect(function()
			-- upvalues: (copy) p_u_44, (copy) v_u_45
			p_u_44.Clicked:Fire(v_u_45)
		end)
		p_u_44._slots[v_u_45] = v46
		p_u_44:_ButtonEffect(v46.Button)
	end
end
function v_u_11._Init(p_u_47) -- name: _Init
	-- upvalues: (copy) v_u_7, (copy) v_u_9
	p_u_47.Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		-- upvalues: (copy) p_u_47
		p_u_47.Background.Size = UDim2.new(1, 0, 0, p_u_47.Layout.AbsoluteContentSize.Y)
	end)
	p_u_47.ShareButton.MouseButton1Click:Connect(function()
		-- upvalues: (copy) p_u_47
		p_u_47:_SetShareBubbleVisible(true)
	end)
	p_u_47.ShareCloseButton.MouseButton1Click:Connect(function()
		-- upvalues: (copy) p_u_47
		p_u_47:_SetShareBubbleVisible(false)
	end)
	p_u_47.ShareImportButton.MouseButton1Click:Connect(function()
		-- upvalues: (copy) p_u_47
		p_u_47:_ImportSettings()
	end)
	p_u_47.ShareImportBox:GetPropertyChangedSignal("Text"):Connect(function()
		-- upvalues: (copy) p_u_47
		p_u_47:_UpdateImportButton()
	end)
	v_u_7:GetDataChangedSignal("SettingsProfile"):Connect(function()
		-- upvalues: (copy) p_u_47
		p_u_47:_Update()
	end)
	p_u_47:_Setup()
	p_u_47:_Update(true)
	p_u_47:_UpdateImportButton()
	p_u_47:_ButtonEffect(p_u_47.ShareButton)
	v_u_9:Add(p_u_47.ShareImportButton, true)
end
return v_u_11