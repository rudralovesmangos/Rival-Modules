local v_u_1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("TeleportService")
local v3 = game:GetService("Players")
local v_u_4 = require(v3.LocalPlayer.PlayerScripts.Controllers.PlayerDataController)
local v_u_5 = {}
v_u_5.__index = v_u_5
function v_u_5._new() -- name: _new
	-- upvalues: (copy) v_u_5
	local v6 = v_u_5
	local v7 = setmetatable({}, v6)
	v7._default_settings_cooldown = 0
	v7:_Init()
	return v7
end
function v_u_5.GetMobileButtonSetting(_, p8, p9, p10, p11) -- name: GetMobileButtonSetting
	-- upvalues: (copy) v_u_4
	local v12 = "MobileButton " .. p8 .. " Override"
	local v13
	if p10 then
		v13 = "MobileButton " .. p8 .. " " .. p10
	else
		v13 = nil
	end
	if v13 and v_u_4:GetSetting(v12) then
		if p11 and p11[v13] ~= nil then
			return p11[v13]
		else
			return v_u_4:GetSetting(v13)
		end
	elseif p9 then
		if p11 and p11[p9] ~= nil then
			return p11[p9]
		else
			return v_u_4:GetSetting(p9)
		end
	else
		return nil
	end
end
function v_u_5.SwitchSettingsProfile(_, p14) -- name: SwitchSettingsProfile
	-- upvalues: (copy) v_u_1
	local v15 = typeof(p14) == "number"
	assert(v15)
	v_u_1.Remotes.Data.SwitchSettingsProfile:FireServer(p14)
end
function v_u_5.ChangeSetting(p16, p17, p18, p19) -- name: ChangeSetting
	-- upvalues: (copy) v_u_4
	if p19 then
		v_u_4:SetSetting(p17, p18)
	else
		p16:ChangeSettings({
			{ p17, p18 }
		})
	end
end
function v_u_5.ChangeSettings(_, p20) -- name: ChangeSettings
	-- upvalues: (copy) v_u_1
	v_u_1.Remotes.Data.ChangeSettings:FireServer(p20)
end
function v_u_5.DefaultSettings(p21, p22) -- name: DefaultSettings
	-- upvalues: (copy) v_u_1
	if tick() >= p21._default_settings_cooldown then
		p21._default_settings_cooldown = tick() + 1
		v_u_1.Remotes.Data.DefaultSettings:FireServer(p22)
	end
end
function v_u_5._ResetHUDSetting(p23) -- name: _ResetHUDSetting
	-- upvalues: (copy) v_u_2
	if not v_u_2:GetTeleportSetting("DontResetHUDSetting") then
		p23:ChangeSetting("Hide HUD", false)
	end
end
function v_u_5._Init(p24) -- name: _Init
	task.defer(p24._ResetHUDSetting, p24)
end
return v_u_5._new()