local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("Lighting")
local v3 = game:GetService("Players")
local v_u_4 = require(v1.Modules.EventLibrary)
local v_u_5 = require(v1.Modules.Utility)
local v_u_6 = require(v3.LocalPlayer.PlayerScripts.Controllers.PlayerDataController)
local v_u_7 = require(script:WaitForChild("FinisherPlayer"))
local v_u_8 = require(script:WaitForChild("EmotePlayer"))
local v_u_9 = require(script:WaitForChild("UnlockModel"))
local v_u_10 = v3.LocalPlayer.PlayerScripts.Assets.Misc:WaitForChild("EquipmentScenes")
local v_u_11 = {
	"Default",
	"Green Screen",
	"Pink Screen",
	"Blue Screen"
}
local v_u_12 = {}
v_u_12.__index = v_u_12
function v_u_12.new(p13) -- name: new
	-- upvalues: (copy) v_u_12, (copy) v_u_10, (copy) v_u_4, (copy) v_u_7, (copy) v_u_8, (copy) v_u_9
	local v14 = v_u_12
	local v15 = setmetatable({}, v14)
	v15.Equipment = p13
	v15.Model = (v_u_10:FindFirstChild(v_u_4.LOBBY_VISUALS_PROFILE) or v_u_10:WaitForChild("Default")):Clone()
	v15.FinisherPlayer = v_u_7.new(v15)
	v15.EmotePlayer = v_u_8.new(v15)
	v15.UnlockModel = v_u_9.new(v15)
	v15._textures_deleted = false
	v15._backgrounds_folder = v15.Model:WaitForChild("Backgrounds")
	v15._hide_career_folder = v15._backgrounds_folder:WaitForChild("Default"):WaitForChild("HideCareer")
	v15._backgrounds = {}
	v15._dof = Instance.new("DepthOfFieldEffect")
	v15:_Init()
	return v15
end
function v_u_12.GetCFrame(p16) -- name: GetCFrame
	return p16.Model.Primary.CFrame
end
function v_u_12.GetHumanoidCFrame(p17) -- name: GetHumanoidCFrame
	return p17.FinisherPlayer:GetHumanoidCFrame()
end
function v_u_12.OnOpen(p18, ...) -- name: OnOpen
	p18.Model.Parent = p18.Equipment.IsOpen and workspace or nil
	p18:_UpdateDOF()
	p18.UnlockModel:OnOpen(...)
end
function v_u_12.OnCustomizingStateChanged(p19, ...) -- name: OnCustomizingStateChanged
	p19.FinisherPlayer:OnCustomizingStateChanged(...)
	p19.EmotePlayer:OnCustomizingStateChanged(...)
end
function v_u_12.OnStateChanged(p20, ...) -- name: OnStateChanged
	p20.FinisherPlayer:OnStateChanged(...)
	p20.EmotePlayer:OnStateChanged(...)
	p20.UnlockModel:OnStateChanged(...)
end
function v_u_12._UpdateTextures(p21) -- name: _UpdateTextures
	-- upvalues: (copy) v_u_6, (copy) v_u_5
	if not p21._textures_deleted and v_u_6:GetSetting("Textures Disabled") then
		p21._textures_deleted = true
		v_u_5:DisableTextures(p21.Model)
	end
end
function v_u_12._UpdateDOF(p22) -- name: _UpdateDOF
	-- upvalues: (copy) v_u_2
	local v23 = p22._dof
	local v24
	if p22.Equipment.IsOpen and p22.Equipment:IsOpenEffectDone() ~= p22.Equipment.Camera:IsClosing() then
		v24 = v_u_2 or nil
	else
		v24 = nil
	end
	v23.Parent = v24
end
function v_u_12._UpdateCareerFolder(p25) -- name: _UpdateCareerFolder
	local v26 = p25.Equipment:IsCareerPageOpen()
	local v27 = p25.Equipment:GetCustomizingType()
	local v28 = v26 or (v27 == "Finisher" and true or v27 == "Emote")
	local v29 = p25._hide_career_folder
	local v30
	if v28 then
		v30 = nil
	else
		v30 = p25._backgrounds.Default or nil
	end
	v29.Parent = v30
end
function v_u_12._UpdateBackgroundFolder(p31) -- name: _UpdateBackgroundFolder
	-- upvalues: (copy) v_u_6
	local v32 = v_u_6:GetSetting("Equipment Background")
	for v33, v34 in pairs(p31._backgrounds) do
		local v35
		if v33 == v32 then
			v35 = p31._backgrounds_folder or nil
		else
			v35 = nil
		end
		v34.Parent = v35
	end
end
function v_u_12._Setup(p36) -- name: _Setup
	-- upvalues: (copy) v_u_11
	for _, v37 in pairs(v_u_11) do
		p36._backgrounds[v37] = p36._backgrounds_folder:WaitForChild(v37)
	end
	p36._dof.FarIntensity = 0.75
	p36._dof.FocusDistance = 0.05
	p36._dof.InFocusRadius = 15
	p36._dof.NearIntensity = 0
	p36._dof.Name = "Equipment"
end
function v_u_12._Init(p_u_38) -- name: _Init
	-- upvalues: (copy) v_u_6
	p_u_38.Equipment.CareerPageOpened:Connect(function()
		-- upvalues: (copy) p_u_38
		p_u_38:_UpdateCareerFolder()
	end)
	p_u_38.Equipment.CustomizingChanged:Connect(function()
		-- upvalues: (copy) p_u_38
		p_u_38:_UpdateCareerFolder()
	end)
	p_u_38.Equipment.FinishedOpenEffect:Connect(function()
		-- upvalues: (copy) p_u_38
		p_u_38:_UpdateDOF()
	end)
	v_u_6:GetSettingChangedSignal("Equipment Background"):Connect(function()
		-- upvalues: (copy) p_u_38
		p_u_38:_UpdateBackgroundFolder()
	end)
	v_u_6:GetSettingChangedSignal("Textures Disabled"):Connect(function()
		-- upvalues: (copy) p_u_38
		p_u_38:_UpdateTextures()
	end)
	p_u_38:_Setup()
	p_u_38:_UpdateTextures()
	p_u_38:_UpdateCareerFolder()
	p_u_38:_UpdateBackgroundFolder()
end
return v_u_12