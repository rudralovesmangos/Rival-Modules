local v1 = game:GetService("ReplicatedStorage")
local v2 = game:GetService("Players")
local v_u_3 = require(v1.Modules.ItemLibrary)
local v_u_4 = require(v2.LocalPlayer.PlayerScripts.Modules:WaitForChild("WeaponStatusHandler"))
local v_u_5 = require(v2.LocalPlayer.PlayerScripts.Modules:WaitForChild("DropdownSlot"))
local v_u_6 = require(v2.LocalPlayer.PlayerScripts.Modules:WaitForChild("ButtonEffect"))
local v_u_7 = require(v2.LocalPlayer.PlayerScripts.Modules:WaitForChild("SettingSlot"))
local v_u_8 = setmetatable({}, v_u_7)
v_u_8.__index = v_u_8
function v_u_8.new(...) -- name: new
	-- upvalues: (copy) v_u_7, (copy) v_u_8
	local v9 = v_u_7.new(...)
	local v10 = v_u_8
	local v11 = setmetatable(v9, v10)
	v11.DropdownContainer = v11.ControlsSettingFrame:WaitForChild("Container")
	v11.DropdownButton = v11.DropdownContainer:WaitForChild("Button")
	v11.DropdownText = v11.DropdownButton:WaitForChild("Title")
	v11._dropdown_slot = nil
	v11:_Init()
	return v11
end
function v_u_8.Destroy(p12) -- name: Destroy
	-- upvalues: (copy) v_u_4, (copy) v_u_7
	if p12._dropdown_slot then
		p12._dropdown_slot:Destroy()
	end
	v_u_4:ClearStatusElements(p12.DropdownText)
	v_u_7.Destroy(p12)
end
function v_u_8._Update(p13) -- name: _Update
	-- upvalues: (copy) v_u_4, (copy) v_u_3
	p13.DropdownText.Text = p13.Value
	p13.DropdownText.Position = UDim2.new(0.05, 0, 0.5, 0)
	v_u_4:ClearStatusElements(p13.DropdownText)
	local v14 = v_u_4
	local v15 = p13.DropdownText
	local v16 = v_u_3.Items[p13.Value]
	if v16 then
		v16 = v_u_3.Items[p13.Value].Status
	end
	v14:ApplyItemStatusToText(v15, v16)
end
function v_u_8._Init(p_u_17) -- name: _Init
	-- upvalues: (copy) v_u_5, (copy) v_u_6
	p_u_17.Changed:Connect(function()
		-- upvalues: (copy) p_u_17
		p_u_17:_Update()
	end)
	p_u_17.DropdownButton.MouseButton1Click:Connect(function()
		-- upvalues: (copy) p_u_17, (ref) v_u_5
		p_u_17.DropdownButton.Visible = false
		if p_u_17._dropdown_slot then
			p_u_17._dropdown_slot:Cancel()
			p_u_17._dropdown_slot = nil
		end
		p_u_17._dropdown_slot = v_u_5.new(p_u_17.DropdownContainer, p_u_17.SettingsInfo.Options)
		p_u_17._dropdown_slot.Selected:Connect(function(p18)
			-- upvalues: (ref) p_u_17
			p_u_17.DropdownButton.Visible = true
			if p18 then
				p_u_17:InputValue(p18)
			end
			p_u_17._dropdown_slot = nil
		end)
	end)
	p_u_17:_Update()
	v_u_6:Add(p_u_17.DropdownButton, nil, {
		["ReleaseRatio"] = 1.025,
		["HoverRatio"] = 1.025
	})
end
return v_u_8