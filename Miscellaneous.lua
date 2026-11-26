local v_u_1 = game:GetService("CollectionService")
local v2 = game:GetService("ReplicatedStorage")
local v3 = game:GetService("Players")
local v_u_4 = require(v2.Modules.SeasonLibrary)
local v_u_5 = require(v3.LocalPlayer.PlayerScripts.Modules.LobbyElement)
local v_u_6 = setmetatable({}, v_u_5)
v_u_6.__index = v_u_6
function v_u_6._new(...) -- name: _new
	-- upvalues: (copy) v_u_5, (copy) v_u_6
	local v7 = v_u_5.new(...)
	local v8 = v_u_6
	local v9 = setmetatable(v7, v8)
	v9:_Init()
	return v9
end
function v_u_6.Update(p10, _) -- name: Update
	-- upvalues: (copy) v_u_1
	local v11 = tick() * 0.25
	local v12 = math.sin(v11) ^ 30 * 1
	local v13 = tick() * 0.1 % 6.283185307179586
	Vector3.new(0, v12, 0)
	CFrame.Angles(0, v13, 0)
	local v14 = tick() * 0.75
	local v15 = math.sin(v14) ^ 30 * 1
	local v16 = tick() * -0.2 % 6.283185307179586
	local v17 = Vector3.new(0, v15, 0)
	local v18 = CFrame.Angles(0, v16, 0)
	for _, v19 in pairs(v_u_1:GetTagged("LobbyFloatingDisplay")) do
		if not v19:IsDescendantOf(workspace) then
			continue
		end
		local v20 = p10:_GetOriginalPivot(v19)
		local v21 = v19:GetAttribute("GlobalSpin") and v20.Rotation:Inverse() or CFrame.identity
		local v22
		if v19:GetAttribute("NoSpin") then
			v22 = CFrame.identity or v18
		else
			v22 = v18
		end
		v19:PivotTo(p10:_GetOriginalPivot(v19) * v21 * v22 * v21:Inverse() + v17)
	end
	for _, v23 in pairs(v_u_1:GetTagged("LobbyRing")) do
		local v24 = v23:GetAttribute("Multiplier") or 1
		local v25 = v23:GetAttribute("IsGlobalSpace") or false
		local v26 = p10:_GetOriginalPivot(v23)
		local v27 = CFrame.Angles(0, tick() * 0.1 * v24 % 6.283185307179586, 0)
		if v25 then
			v23:PivotTo(CFrame.new(v26.Position) * v27 * v26.Rotation)
		else
			v23:PivotTo(v26 * v27)
		end
	end
	for _, v28 in pairs(v_u_1:GetTagged("LobbyHologramGift")) do
		v28:PivotTo(p10:_GetOriginalPivot(v28) * v18 + v17)
	end
	for _, v29 in pairs(v_u_1:GetTagged("LobbyHologramMobile")) do
		v29.Earth:PivotTo(p10:_GetOriginalPivot(v29.Earth) * CFrame.Angles(0, tick() * 0.35 % 6.283185307179586, 0))
		local v30 = v29.Phone
		local v31 = p10:_GetOriginalPivot(v29.Phone)
		local v32 = tick() * 0.75
		local v33 = math.sin(v32) * 0.75
		v30:PivotTo(v31 + Vector3.new(0, v33, 0))
		local v34 = v29.Tablet
		local v35 = p10:_GetOriginalPivot(v29.Tablet)
		local v36 = tick() * 0.375
		local v37 = math.cos(v36)
		v34:PivotTo(v35 + Vector3.new(0, v37, 0))
	end
end
function v_u_6._UpdateSeasonTexts(_) -- name: _UpdateSeasonTexts
	-- upvalues: (copy) v_u_1, (copy) v_u_4
	for _, v38 in pairs(v_u_1:GetTagged("SeasonNameDisplay")) do
		v38.Text = string.upper(v_u_4.CurrentSeason.Name)
	end
	for _, v39 in pairs(v_u_1:GetTagged("SeasonVersionDisplay")) do
		v39.Text = "SEASON " .. v_u_4.CurrentSeason.Version
	end
end
function v_u_6._Init(p_u_40) -- name: _Init
	-- upvalues: (copy) v_u_1
	v_u_1:GetInstanceAddedSignal("SeasonNameDisplay"):Connect(function()
		-- upvalues: (copy) p_u_40
		p_u_40:_UpdateSeasonTexts()
	end)
	v_u_1:GetInstanceAddedSignal("SeasonVersionDisplay"):Connect(function()
		-- upvalues: (copy) p_u_40
		p_u_40:_UpdateSeasonTexts()
	end)
	p_u_40:_UpdateSeasonTexts()
end
return v_u_6._new()