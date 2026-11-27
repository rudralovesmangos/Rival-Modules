local v_u_1 = game:GetService("ReplicatedStorage")
local v2 = game:GetService("Players")
local v_u_3 = require(v_u_1.Modules.ModerationLibrary)
local v_u_4 = require(v_u_1.Modules.SettingsInfo)
require(v_u_1.Modules.BanLibrary)
local v_u_5 = require(v2.LocalPlayer.PlayerScripts.Controllers:WaitForChild("PlayerDataController"))
local v_u_6 = require(v2.LocalPlayer.PlayerScripts.Modules:WaitForChild("Settings"):WaitForChild("Dropdown"))
local v_u_7 = require(v2.LocalPlayer.PlayerScripts.Modules:WaitForChild("ButtonEffect"))
local v_u_8 = require(v2.LocalPlayer.PlayerScripts.Modules:WaitForChild("Prompt"))
local v_u_9 = {
	"Exploiting",
	"Exploiting - Movement Cheats",
	"Exploiting - Aim Cheats",
	"Exploiting - Vision Cheats",
	"Requesting Exploits",
	"Playing With Exploiters",
	"Fake Reporting",
	"Farming",
	"Abusing Minor Bugs",
	"Harassment / Hate Speech",
	"Ban Evasion",
	"Custom"
}
local v_u_10 = {
	"Permanent",
	"1 day",
	"3 days",
	"7 days",
	"14 days",
	"30 days",
	"90 days",
	"180 days",
	"365 days",
	"Custom"
}
local v_u_11 = setmetatable({}, v_u_8)
v_u_11.__index = v_u_11
function v_u_11.new(p12) -- name: new
	-- upvalues: (copy) v_u_8, (copy) v_u_11, (copy) v_u_6, (copy) v_u_4, (copy) v_u_9, (copy) v_u_10
	local v13 = v_u_8.new(script.Name)
	local v14 = v_u_11
	local v15 = setmetatable(v13, v14)
	v15.CloseButton = v15.PromptFrame:WaitForChild("Close")
	v15.ConfirmButton = v15.PromptFrame:WaitForChild("Confirm")
	v15.TitleText = v15.PromptFrame:WaitForChild("Title")
	v15.RestrictionNotice = v15.PromptFrame:WaitForChild("RestrictionNotice")
	v15.DetailsFrame = v15.PromptFrame:WaitForChild("Details")
	v15.ReasonFrame = v15.DetailsFrame:WaitForChild("Reason")
	v15.ReasonDropdownFrame = v15.ReasonFrame:WaitForChild("Dropdown")
	v15.ReasonCustomFrame = v15.DetailsFrame:WaitForChild("ReasonCustom")
	v15.ReasonCustomBox = v15.ReasonCustomFrame:WaitForChild("Input"):WaitForChild("Box")
	v15.DurationFrame = v15.DetailsFrame:WaitForChild("Duration")
	v15.DurationDropdownFrame = v15.DurationFrame:WaitForChild("Dropdown")
	v15.DurationCustomFrame = v15.DetailsFrame:WaitForChild("DurationCustom")
	v15.DurationCustomBox = v15.DurationCustomFrame:WaitForChild("Input"):WaitForChild("Box")
	v15.WarnFrame = v15.DetailsFrame:WaitForChild("Warn")
	v15.WarnContainer = v15.WarnFrame:WaitForChild("Container")
	v15.WarnButton = v15.WarnContainer:WaitForChild("Button")
	v15.WarnButtonEmpty = v15.WarnButton:WaitForChild("Empty")
	v15.WarnButtonFilled = v15.WarnButton:WaitForChild("Filled")
	v15.CasualLBsFrame = v15.DetailsFrame:WaitForChild("CasualLBs")
	v15.CasualLBsContainer = v15.CasualLBsFrame:WaitForChild("Container")
	v15.CasualLBsButton = v15.CasualLBsContainer:WaitForChild("Button")
	v15.CasualLBsButtonEmpty = v15.CasualLBsButton:WaitForChild("Empty")
	v15.CasualLBsButtonFilled = v15.CasualLBsButton:WaitForChild("Filled")
	v15.CompLBsFrame = v15.DetailsFrame:WaitForChild("CompLBs")
	v15.CompLBsContainer = v15.CompLBsFrame:WaitForChild("Container")
	v15.CompLBsButton = v15.CompLBsContainer:WaitForChild("Button")
	v15.CompLBsButtonEmpty = v15.CompLBsButton:WaitForChild("Empty")
	v15.CompLBsButtonFilled = v15.CompLBsButton:WaitForChild("Filled")
	v15.ReasonDropdown = v_u_6.new(v_u_4.new("", "", "", "", "", "Dropdown", v_u_9[1], v_u_9))
	v15.DurationDropdown = v_u_6.new(v_u_4.new("", "", "", "", "", "Dropdown", v_u_10[1], v_u_10))
	v15._ban_data = p12
	v15:_Init()
	return v15
end
function v_u_11.Confirm(p16) -- name: Confirm
	-- upvalues: (copy) v_u_3, (copy) v_u_5, (copy) v_u_1
	local v17
	if p16.ReasonDropdown.Value == "Custom" then
		v17 = p16.ReasonCustomBox.Text
	else
		v17 = p16.ReasonDropdown.Value
	end
	local v18 = p16:_GetBanDurationInteger()
	if v18 then
		if #v17 >= 5 and #v17 <= 100 then
			if v_u_3:CanWarnTemplate(v_u_5:Get("PermissionsRoles")) then
				local _ = p16.WarnButtonFilled.Visible
			end
			local v19
			if v_u_3:CanRestrict(v_u_5:Get("PermissionsRoles")) then
				v19 = {}
				local v20 = not p16.CasualLBsButtonFilled.Visible and p16._ban_data.Restrictions
				if v20 then
					v20 = p16._ban_data.Restrictions.RestrictedFromCasualLeaderboards
				end
				v19.RestrictedFromCasualLeaderboards = v20
				local v21 = not p16.CompLBsButtonFilled.Visible and p16._ban_data.Restrictions
				if v21 then
					v21 = p16._ban_data.Restrictions.RestrictedFromCompetitiveLeaderboards
				end
				v19.RestrictedFromCompetitiveLeaderboards = v21
			else
				v19 = nil
			end
			v_u_1.Remotes.Moderator.Ban:FireServer(p16._ban_data.Name, v18, v17, p16.WarnButtonFilled.Visible, v19)
			task.defer(p16.CloseRequest, p16)
		end
	else
		return
	end
end
function v_u_11.Destroy(p22) -- name: Destroy
	-- upvalues: (copy) v_u_8
	p22.ReasonDropdown:Destroy()
	p22.DurationDropdown:Destroy()
	v_u_8.Destroy(p22)
end
function v_u_11._GetBanDurationInteger(p23) -- name: _GetBanDurationInteger
	if p23.DurationDropdown.Value == "Custom" then
		local v24 = p23.DurationCustomBox.Text
		return tonumber(v24)
	end
	if p23.DurationDropdown.Value == "Permanent" then
		return -1
	end
	local v25 = p23.DurationDropdown.Value
	local v26 = string.find(p23.DurationDropdown.Value, " ") - 1
	local v27 = string.sub(v25, 1, v26)
	return tonumber(v27)
end
function v_u_11._SetCasualLBsRestriction(p28, p29) -- name: _SetCasualLBsRestriction
	p28.CasualLBsButtonFilled.Visible = p29
	p28.CasualLBsButtonEmpty.Visible = not p29
end
function v_u_11._SetCompLBsRestriction(p30, p31) -- name: _SetCompLBsRestriction
	p30.CompLBsButtonFilled.Visible = p31
	p30.CompLBsButtonEmpty.Visible = not p31
end
function v_u_11._SetWarn(p32, p33) -- name: _SetWarn
	p32.WarnButtonFilled.Visible = p33
	p32.WarnButtonEmpty.Visible = not p33
end
function v_u_11._AutomaticallyCheckBoxes(p34) -- name: _AutomaticallyCheckBoxes
	local v35 = p34:_GetBanDurationInteger()
	local v36 = not v35 and 0 or (v35 == -1 and (1 / 0) or v35)
	p34:_SetCasualLBsRestriction(v36 >= 3)
	p34:_SetCompLBsRestriction(v36 >= 7)
end
function v_u_11._Update(p37) -- name: _Update
	local v38 = p37.ReasonDropdown.Value
	local v39 = p37.DurationDropdown.Value
	p37.ReasonCustomFrame.Visible = v38 == "Custom"
	p37.DurationFrame.Visible = true
	p37.DurationCustomFrame.Visible = v39 == "Custom"
end
function v_u_11._FormatSettingSlot(_, p40) -- name: _FormatSettingSlot
	p40.SettingFrame.Size = UDim2.new(1, 0, 1, 0)
	p40.SettingFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
	p40.SettingFrame.SizeConstraint = Enum.SizeConstraint.RelativeXY
	p40.ControlsFrame.Size = UDim2.new(1, 0, 1, 0)
	p40.ControlsFrame.SizeConstraint = Enum.SizeConstraint.RelativeXY
	p40.DropdownContainer.Size = UDim2.new(1, 0, 1, 0)
	p40.Background.Visible = false
	p40.DetailsResetButton.Size = UDim2.new(0, 0, 0, 0)
end
function v_u_11._Setup(p41) -- name: _Setup
	-- upvalues: (copy) v_u_3, (copy) v_u_5
	p41.TitleText.Text = "@" .. p41._ban_data.Name
	p41.ReasonDropdown.SettingFrame.Parent = p41.ReasonDropdownFrame
	p41.DurationDropdown.SettingFrame.Parent = p41.DurationDropdownFrame
	p41.WarnFrame.Visible = v_u_3:CanWarnTemplate(v_u_5:Get("PermissionsRoles"))
	p41.CasualLBsFrame.Visible = v_u_3:CanRestrict(v_u_5:Get("PermissionsRoles"))
	p41.CompLBsFrame.Visible = v_u_3:CanRestrict(v_u_5:Get("PermissionsRoles"))
	p41.RestrictionNotice.Visible = v_u_3:CanRestrict(v_u_5:Get("PermissionsRoles"))
end
function v_u_11._Init(p_u_42) -- name: _Init
	-- upvalues: (copy) v_u_7
	p_u_42.CloseButton.MouseButton1Click:Connect(function()
		-- upvalues: (copy) p_u_42
		p_u_42:CloseRequest()
	end)
	p_u_42.ConfirmButton.MouseButton1Click:Connect(function()
		-- upvalues: (copy) p_u_42
		p_u_42:Confirm()
	end)
	p_u_42.DurationCustomBox.FocusLost:Connect(function()
		-- upvalues: (copy) p_u_42
		if p_u_42.DurationCustomBox.Text ~= "" then
			local v43 = p_u_42.DurationCustomBox
			local v44 = p_u_42.DurationCustomBox.Text
			local v45
			if tonumber(v44) then
				local v46 = p_u_42.DurationCustomBox.Text
				local v47 = tonumber(v46)
				local v48 = math.floor(v47)
				v45 = math.clamp(v48, 1, 999) or ""
			else
				v45 = ""
			end
			v43.Text = v45
		end
		p_u_42:_AutomaticallyCheckBoxes()
	end)
	p_u_42.ReasonDropdown.Replicate:Connect(function()
		-- upvalues: (copy) p_u_42
		p_u_42:_Update()
	end)
	p_u_42.DurationDropdown.Replicate:Connect(function()
		-- upvalues: (copy) p_u_42
		p_u_42:_Update()
		p_u_42:_AutomaticallyCheckBoxes()
	end)
	p_u_42.WarnButton.MouseButton1Click:Connect(function()
		-- upvalues: (copy) p_u_42
		p_u_42:_SetWarn(not p_u_42.WarnButtonFilled.Visible)
	end)
	p_u_42.CasualLBsButton.MouseButton1Click:Connect(function()
		-- upvalues: (copy) p_u_42
		p_u_42:_SetCasualLBsRestriction(not p_u_42.CasualLBsButtonFilled.Visible)
	end)
	p_u_42.CompLBsButton.MouseButton1Click:Connect(function()
		-- upvalues: (copy) p_u_42
		p_u_42:_SetCasualLBsRestriction(not p_u_42.CompLBsButtonFilled.Visible)
	end)
	p_u_42:_Setup()
	p_u_42:_FormatSettingSlot(p_u_42.ReasonDropdown)
	p_u_42:_FormatSettingSlot(p_u_42.DurationDropdown)
	p_u_42:_Update()
	p_u_42:_AutomaticallyCheckBoxes()
	p_u_42:_SetWarn(true)
	v_u_7:Add(p_u_42.CloseButton)
	v_u_7:Add(p_u_42.ConfirmButton)
	v_u_7:Add(p_u_42.WarnButton)
	v_u_7:Add(p_u_42.CasualLBsButton)
	v_u_7:Add(p_u_42.CompLBsButton)
end
return v_u_11