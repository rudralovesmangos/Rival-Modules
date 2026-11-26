local v1 = game:GetService("ReplicatedStorage")
local v2 = game:GetService("Players")
local v_u_3 = require(v1.Modules.CONSTANTS)
require(v1.Modules.GameplayUtility)
local v_u_4 = require(v1.Modules.Utility)
local v_u_5 = require(v2.LocalPlayer.PlayerScripts.Controllers.PlayerDataController)
local v_u_6 = require(v2.LocalPlayer.PlayerScripts.Controllers.FighterController)
local v_u_7 = require(v2.LocalPlayer.PlayerScripts.Controllers.EnemyController)
local v_u_8 = {}
v_u_8.__index = v_u_8
function v_u_8._new() -- name: _new
	-- upvalues: (copy) v_u_8
	local v9 = v_u_8
	local v10 = setmetatable({}, v9)
	v10._hurt_effect_enabled = false
	v10._hurt_effect_outline_only = false
	v10._hurt_effect_color_fill = Color3.fromRGB(255, 50, 50)
	v10._hurt_effect_color_outline = Color3.fromRGB(255, 255, 255)
	v10:_Init()
	return v10
end
function v_u_8.GetScreenPoints(_, p11, p12) -- name: GetScreenPoints
	-- upvalues: (copy) v_u_7, (copy) v_u_6, (copy) v_u_3
	local v13 = {}
	for _, v14 in pairs({ v_u_7.Objects, v_u_6:GetEntities() }) do
		for _, v15 in pairs(v14) do
			if p12 and v15.AimAssistBlacklist or not p11:IsValidTarget(v15) then
				continue
			end
			local v16, v17 = v15:GetScreenPoint()
			if not v17 or v16.Z >= v_u_3.RENDER_DISTANCE then
				continue
			end
			v13[v15] = v16
		end
	end
	return v13
end
function v_u_8._UpdateSettings(p18) -- name: _UpdateSettings
	-- upvalues: (copy) v_u_5, (copy) v_u_4
	local v19 = v_u_5:GetSetting("Damage Flashing")
	p18._hurt_effect_enabled = v19 ~= "Disabled"
	p18._hurt_effect_outline_only = v19 == "Outline"
	p18._hurt_effect_color_fill = v_u_4:Color3FromHex(v_u_5:GetSetting("Damage Flashing Color Base"))
	p18._hurt_effect_color_outline = v_u_4:Color3FromHex(v_u_5:GetSetting("Damage Flashing Color Flash"))
end
function v_u_8._SetupHurtEffect(p_u_20, p_u_21) -- name: _SetupHurtEffect
	-- upvalues: (copy) v_u_4
	local v22
	if typeof(p_u_21) == "Instance" then
		v22 = p_u_21:IsA("Model")
	else
		v22 = false
	end
	assert(v22, "Argument 1 invalid, expected a Model")
	p_u_21:SetAttribute("PlayHurtEffect", 0)
	local v_u_23 = nil
	p_u_21:GetAttributeChangedSignal("PlayHurtEffect"):Connect(function()
		-- upvalues: (copy) p_u_20, (ref) v_u_23, (copy) p_u_21, (ref) v_u_4
		if p_u_20._hurt_effect_enabled then
			if v_u_23 then
				v_u_23:Destroy()
				v_u_23 = nil
			end
			local v_u_24 = Instance.new("Highlight")
			v_u_24.DepthMode = Enum.HighlightDepthMode.Occluded
			v_u_24.Name = "HurtEffect"
			v_u_24.Adornee = p_u_21
			v_u_24.Parent = p_u_21
			v_u_23 = v_u_24
			v_u_4:RenderstepForLoop(0, 100, 1, function(p25)
				-- upvalues: (copy) v_u_24, (ref) v_u_23, (ref) p_u_20
				if v_u_24 ~= v_u_23 then
					return true
				end
				local v26 = 1 - (1 - p25 / 100) ^ 5
				local v27 = p_u_20._hurt_effect_color_outline
				local v28 = p_u_20._hurt_effect_color_fill
				local v29 = p25 / 5
				local v30 = v27:Lerp(v28, (math.min(1, v29)))
				v_u_24.FillColor = v30
				v_u_24.FillTransparency = p_u_20._hurt_effect_outline_only and 1 or v26
				v_u_24.OutlineTransparency = v26
				local v31 = v_u_24
				if not p_u_20._hurt_effect_outline_only then
					v30 = p_u_20._hurt_effect_color_fill
				end
				v31.OutlineColor = v30
			end)
			v_u_24:Destroy()
		end
	end)
end
function v_u_8._SetupHurtEffects(p32) -- name: _SetupHurtEffects
	local v33 = Instance.new("Model")
	v33.Name = "HurtEffect"
	v33.Parent = workspace
	p32:_SetupHurtEffect(v33)
	p32:_SetupHurtEffect(workspace:WaitForChild("ViewModels"):WaitForChild("FirstPerson"))
end
function v_u_8._Init(p_u_34) -- name: _Init
	-- upvalues: (copy) v_u_5
	v_u_5:GetSettingChangedSignal("Damage Flashing"):Connect(function()
		-- upvalues: (copy) p_u_34
		p_u_34:_UpdateSettings()
	end)
	v_u_5:GetSettingChangedSignal("Damage Flashing Color Base"):Connect(function()
		-- upvalues: (copy) p_u_34
		p_u_34:_UpdateSettings()
	end)
	v_u_5:GetSettingChangedSignal("Damage Flashing Color Flash"):Connect(function()
		-- upvalues: (copy) p_u_34
		p_u_34:_UpdateSettings()
	end)
	task.spawn(p_u_34._SetupHurtEffects, p_u_34)
	p_u_34:_UpdateSettings()
end
return v_u_8._new()