local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("RunService")
local v3 = game:GetService("Players")
local v_u_4 = require(v1.Modules.ReplicatedClass)
local v_u_5 = require(v1.Modules.Utility)
require(v1.Modules.Signal)
local v_u_6 = require(v3.LocalPlayer.PlayerScripts.Controllers.PlayerDataController)
local v_u_7 = {
	["Docks"] = { "rbxassetid://17813065011", 0.25, 0 },
	["Station"] = { "rbxassetid://17813065464", 0.25, 13 },
	["Big Station"] = { "rbxassetid://17813065464", 0.25, 13 },
	["Backrooms"] = { "rbxassetid://17813170797", 1, 0 },
	["Construction"] = { "rbxassetid://93752516938586", 1, 0 },
	["Big Backrooms"] = { "rbxassetid://17813170797", 1, 0 },
	["Onyx"] = { "rbxassetid://12099785239", 0.375, 0 },
	["Big Onyx"] = { "rbxassetid://12099785239", 0.375, 0 },
	["Splash"] = { "rbxassetid://18963688210", 0.75, 0 },
	["Big Splash"] = { "rbxassetid://18963688210", 0.75, 0 },
	["Zombie Tower"] = { "rbxassetid://90122406367653", 0.25, 0 },
	["Iceberg"] = { "rbxassetid://103004663415392", 0.25, 0 },
	["Village"] = { "rbxassetid://103004663415392", 0.25, 0 },
	["Studio"] = { "rbxassetid://90866007129930", 1, 0 },
	["Westown"] = { "rbxassetid://116999944271223", 1, 0 },
	["Gargoyle Tower"] = { "rbxassetid://90122406367653", 0.25, 0 }
}
local v_u_8 = setmetatable({}, v_u_4)
v_u_8.__index = v_u_8
function v_u_8.new(p9, p10) -- name: new
	-- upvalues: (copy) v_u_4, (copy) v_u_8
	local v11 = v_u_4.new(p9)
	local v12 = v_u_8
	local v13 = setmetatable(v11, v12)
	v13.Name = p9.Name
	v13.Model = p9.Model
	v13.ClientDuel = p10
	v13.Data.IsHidden = nil
	v13.Data.LightingProfileOverride = nil
	v13._destroyed = false
	v13._connections = {}
	v13._active_connections = {}
	v13._seed = p9.Seed
	v13._on_hidden_update_callback = nil
	v13._textures_deleted = false
	v13._shadows_deleted = false
	v13._ambience_sound = nil
	v13._spectate_part = nil
	v13._lighting_objects_folder = v13.Model:FindFirstChild("LightingObjects")
	v13._lighting_objects_folders = v13._lighting_objects_folder and (v13._lighting_objects_folder:GetChildren() or {}) or {}
	v13:_Init()
	return v13
end
function v_u_8.IsRendered(p14) -- name: IsRendered
	return p14.ClientDuel:IsRendered()
end
function v_u_8.GetSpectatePart(p15) -- name: GetSpectatePart
	if not p15._spectate_part then
		p15._spectate_part = p15.Model:FindFirstChild("Spectate")
	end
	return p15._spectate_part
end
function v_u_8.GetScoreboardDisplay(_) -- name: GetScoreboardDisplay
	return nil
end
function v_u_8.SetHidden(p_u_16, p17) -- name: SetHidden
	-- upvalues: (copy) v_u_6, (copy) v_u_2
	if p17 == p_u_16:Get("IsHidden") then
		return
	else
		for _, v18 in pairs(p_u_16._active_connections) do
			v18:Disconnect()
		end
		p_u_16._active_connections = {}
		p_u_16:SetReplicate("IsHidden", p17)
		local v19 = p_u_16.Model
		local v20
		if p17 then
			v20 = nil
		else
			v20 = workspace or nil
		end
		v19.Parent = v20
		p_u_16:_UpdateAmbience()
		if not p17 then
			local v21 = p_u_16._active_connections
			local v22 = v_u_6:GetSettingChangedSignal("Textures Disabled")
			table.insert(v21, v22:Connect(function()
				-- upvalues: (copy) p_u_16
				p_u_16:_UpdateTextures()
			end))
			local v23 = p_u_16._active_connections
			local v24 = v_u_6:GetSettingChangedSignal("Shadows Disabled")
			table.insert(v23, v24:Connect(function()
				-- upvalues: (copy) p_u_16
				p_u_16:_UpdateShadows()
			end))
			local v25 = p_u_16._active_connections
			local v26 = v_u_2.RenderStepped
			table.insert(v25, v26:Connect(function(p27)
				-- upvalues: (copy) p_u_16
				p_u_16:Update(p27)
			end))
			p_u_16:_UpdateTextures()
			p_u_16:_UpdateShadows()
		end
	end
end
function v_u_8.CreateSound(p28, ...) -- name: CreateSound
	-- upvalues: (copy) v_u_5
	if not p28:Get("IsHidden") then
		return v_u_5:CreateSound(...)
	end
end
function v_u_8.Update(_, _) -- name: Update end
function v_u_8.Destroy(p29) -- name: Destroy
	-- upvalues: (copy) v_u_4
	p29._destroyed = true
	for _, v30 in pairs(p29._active_connections) do
		v30:Disconnect()
	end
	for _, v31 in pairs(p29._connections) do
		v31:Disconnect()
	end
	if p29._ambience_sound then
		p29._ambience_sound:Destroy()
	end
	v_u_4.Destroy(p29)
end
function v_u_8._UpdateLightingObjects(p32) -- name: _UpdateLightingObjects
	local v33 = p32:Get("LightingProfileOverride") or p32.Name
	for _, v34 in pairs(p32._lighting_objects_folders) do
		local v35
		if v34.Name == v33 then
			v35 = p32._lighting_objects_folder or nil
		else
			v35 = nil
		end
		v34.Parent = v35
	end
end
function v_u_8._UpdateHidden(p_u_36) -- name: _UpdateHidden
	local v37, v38 = pcall(function()
		-- upvalues: (copy) p_u_36
		p_u_36:SetHidden(not p_u_36.ClientDuel:Get("IsSpectating"))
	end)
	if not v37 then
		warn("Failed to hide/unhide map, error:", v38)
	end
end
function v_u_8._UpdateAmbience(p39) -- name: _UpdateAmbience
	-- upvalues: (copy) v_u_7, (copy) v_u_5
	if p39:Get("IsHidden") and p39._ambience_sound then
		p39._ambience_sound:Destroy()
		p39._ambience_sound = nil
	else
		local v40 = not p39:Get("IsHidden") and (not p39._ambience_sound and v_u_7[p39.Name])
		if v40 then
			p39._ambience_sound = v_u_5:CreateSound(v40[1], v40[2], 1, script, true)
			p39._ambience_sound.Looped = true
			p39._ambience_sound.TimePosition = v40[3]
		end
	end
end
function v_u_8._UpdateShadows(p41) -- name: _UpdateShadows
	-- upvalues: (copy) v_u_6, (copy) v_u_5
	if not p41._shadows_deleted and (not p41:Get("IsHidden") and v_u_6:GetSetting("Shadows Disabled")) then
		p41._shadows_deleted = true
		v_u_5:DisableShadows(p41.Model)
	end
end
function v_u_8._UpdateTextures(p42) -- name: _UpdateTextures
	-- upvalues: (copy) v_u_6, (copy) v_u_5
	if not p42._textures_deleted and (not p42:Get("IsHidden") and v_u_6:GetSetting("Textures Disabled")) then
		p42._textures_deleted = true
		v_u_5:DisableTextures(p42.Model)
	end
end
function v_u_8._Init(p_u_43) -- name: _Init
	local v44 = p_u_43._connections
	local v45 = p_u_43.ClientDuel:GetDataChangedSignal("IsSpectating")
	table.insert(v44, v45:Connect(function()
		-- upvalues: (copy) p_u_43
		p_u_43:_UpdateHidden()
	end))
	p_u_43:GetDataChangedSignal("LightingProfileOverride"):Connect(function()
		-- upvalues: (copy) p_u_43
		p_u_43:_UpdateLightingObjects()
	end)
	p_u_43:_UpdateHidden()
	task.defer(p_u_43._UpdateLightingObjects, p_u_43)
end
return v_u_8