local v_u_1 = game:GetService("ReplicatedStorage")
local v2 = game:GetService("Players")
local v_u_3 = require(v_u_1.Modules.EnumLibrary)
local v_u_4 = require(v_u_1.Modules.Utility)
local v_u_5 = require(v_u_1.Modules.Signal)
local v_u_6 = require(v2.LocalPlayer.PlayerScripts.Controllers.PlayerDataController)
local v_u_7 = require(v2.LocalPlayer.PlayerScripts.Controllers.CameraController)
local v_u_8 = {}
v_u_8.__index = v_u_8
function v_u_8.new(p9) -- name: new
	-- upvalues: (copy) v_u_8, (copy) v_u_5
	local v10 = v_u_8
	local v11 = setmetatable({}, v10)
	v11.EnabledChanged = v_u_5.new()
	v11.MobileInputs = p9
	v11.ModalFrame = v11.MobileInputs.Frame:WaitForChild("Modal")
	v11.Enabled = false
	v11._edits_pending = false
	v11:_Init()
	return v11
end
function v_u_8.SetEnabled(p12, p13) -- name: SetEnabled
	local v14 = p13 and true or false
	if v14 ~= p12.Enabled then
		p12.Enabled = v14 or false
		p12.EnabledChanged:Fire()
		if not p12.Enabled then
			p12:ApplyEdits()
		end
	end
end
function v_u_8.ResetLayout(p15) -- name: ResetLayout
	-- upvalues: (copy) v_u_1, (copy) v_u_6
	for _, v16 in pairs(p15.MobileInputs.Buttons.Buttons) do
		v16:ResetPositionAndSize()
	end
	p15._edits_pending = false
	v_u_1.Remotes.Data.UpdateMobileButtonSettings:FireServer(v_u_6:Get("SettingsProfile"), nil)
end
function v_u_8.ApplyEdits(p17) -- name: ApplyEdits
	-- upvalues: (copy) v_u_1, (copy) v_u_6
	if p17._edits_pending then
		p17._edits_pending = false
		v_u_1.Remotes.Data.UpdateMobileButtonSettings:FireServer(v_u_6:Get("SettingsProfile"), p17.MobileInputs.Buttons:GetCurrentProfile())
	end
end
function v_u_8.PendEdits(p18) -- name: PendEdits
	p18._edits_pending = true
end
function v_u_8.ImportProfile(p19, p20) -- name: ImportProfile
	-- upvalues: (copy) v_u_3, (copy) v_u_4
	local v21, v22 = v_u_3:DecryptTable(p20)
	if v21 then
		p19._edits_pending = true
		p19.MobileInputs.Buttons:UpdatePositionsAndSizes(v22)
	else
		v_u_4:CreateSound("rbxassetid://17153811469", 2, 1, script, true, 5)
	end
end
function v_u_8._UpdateModal(p23) -- name: _UpdateModal
	p23.ModalFrame.Visible = p23.Enabled
end
function v_u_8._Init(p_u_24) -- name: _Init
	-- upvalues: (copy) v_u_7
	p_u_24.EnabledChanged:Connect(function()
		-- upvalues: (copy) p_u_24, (ref) v_u_7
		p_u_24:_UpdateModal()
		v_u_7:SetIsEditingMobileButtons(p_u_24.Enabled)
	end)
	p_u_24:_UpdateModal()
end
return v_u_8