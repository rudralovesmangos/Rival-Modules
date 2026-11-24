local v_u_1 = game:GetService("LocalizationService")
local v_u_2 = game:GetService("CollectionService")
local v_u_3 = game:GetService("ReplicatedStorage")
local v_u_4 = game:GetService("UserInputService")
game:GetService("ServerStorage")
local v_u_5 = game:GetService("SoundService")
local v_u_6 = game:GetService("Players")
local v_u_7 = require(v_u_3.Modules.CONSTANTS)
local v_u_8 = require(v_u_3.Modules.ServerOsTime)
local v_u_9 = require(v_u_3.Modules.BetterDebris)
local v_u_10 = require(v_u_3.Modules.EnumLibrary)
local v_u_11 = require(script:WaitForChild("RenderstepForLoop"))
local v_u_12 = { "rbxassetid://17662038408", "rbxassetid://17662038274", "rbxassetid://17662037971" }
local v_u_13 = {
	["a"] = true,
	["e"] = true,
	["i"] = true,
	["o"] = true,
	["u"] = true
}
local v_u_14 = {}
v_u_14.__index = v_u_14
function v_u_14._new() -- name: _new
	-- upvalues: (copy) v_u_14
	local v15 = v_u_14
	local v16 = setmetatable({}, v15)
	v16._particle_hashes = {}
	v16._name_to_input_enum = nil
	v16._search_translator = nil
	v16._cached_sound_groups = {}
	v16:_Init()
	return v16
end
function v_u_14.IsUIElementVisible(p17, p18) -- name: IsUIElementVisible
	-- upvalues: (copy) v_u_6
	local v19 = p18:IsDescendantOf(v_u_6.LocalPlayer.PlayerGui) or p18:IsDescendantOf(workspace)
	if v19 then
		v19 = p17:_RecursiveIsUIElementVisible(p18)
	end
	return v19
end
function v_u_14.IsTextBoxFocused(_) -- name: IsTextBoxFocused
	-- upvalues: (copy) v_u_4
	local v20 = v_u_4.GetFocusedTextBox
	local v21 = v_u_4
	local v22, v23 = pcall(v20, v21)
	return not v22 or v23
end
function v_u_14.IsAprilFoolsRaw(_) -- name: IsAprilFoolsRaw
	-- upvalues: (copy) v_u_8
	local v24 = DateTime.fromUnixTimestamp(v_u_8:Get()):ToUniversalTime()
	local v25
	if v24.Month == 4 then
		v25 = v24.Day == 1
	else
		v25 = false
	end
	return v25
end
function v_u_14.IsAprilFoolsGamemodesEnabled(p26) -- name: IsAprilFoolsGamemodesEnabled
	return p26:IsAprilFoolsRaw()
end
function v_u_14.IsAprilFools(_) -- name: IsAprilFools
	return false
end
function v_u_14.DarkenColor(_, p27, p28) -- name: DarkenColor
	return Color3.new(p27.R * p28, p27.G * p28, p27.B * p28)
end
function v_u_14.IsWithinRotatedShape(_, p29, p30, p31, p32) -- name: IsWithinRotatedShape
	if p32 == Enum.PartType.Ball then
		local v33 = (p29 - p30.Position).Magnitude
		local v34 = p31.X
		local v35 = p31.Y
		local v36 = p31.Z
		return v33 <= math.max(v34, v35, v36) / 2
	elseif p32 == Enum.PartType.Cylinder then
		local v37 = p30:PointToObjectSpace(p29)
		local v38
		if v37.X >= -p31.X / 2 and v37.X <= p31.X / 2 then
			local v39 = v37.Y ^ 2 + v37.Z ^ 2
			local v40 = math.sqrt(v39)
			local v41 = p31.Y
			local v42 = p31.Z
			v38 = v40 <= math.max(v41, v42) / 2
		else
			v38 = false
		end
		return v38
	else
		local v43 = p30:PointToObjectSpace(p29)
		local v44
		if v43.X >= -p31.X / 2 and (v43.X <= p31.X / 2 and (v43.Y >= -p31.Y / 2 and (v43.Y <= p31.Y / 2 and v43.Z >= -p31.Z / 2))) then
			v44 = v43.Z <= p31.Z / 2
		else
			v44 = false
		end
		return v44
	end
end
function v_u_14.IsWithinPart(_, p45, p46, p47) -- name: IsWithinPart
	-- upvalues: (copy) v_u_14
	local v48 = (p45.Position - p46).Magnitude
	local v49 = p45.Size.X
	local v50 = p45.Size.Y
	local v51 = p45.Size.Z
	local v52
	if v48 < math.max(v49, v50, v51) * 1.7320508075688772 then
		v52 = v_u_14:IsWithinRotatedShape(p46, p45.CFrame, p45.Size + (p47 or Vector3.new(0, 0, 0)), p45.ClassName == "Part" and p45.Shape or Enum.PartType.Block)
	else
		v52 = false
	end
	return v52
end
function v_u_14.IsWithinTaggedParts(p53, p54, p55, p56, p57) -- name: IsWithinTaggedParts
	-- upvalues: (copy) v_u_2
	local v58 = {}
	for _, v59 in pairs(v_u_2:GetTagged(p54)) do
		if not p53:IsWithinPart(v59, p55, p56) then
			continue
		end
		if not p57 then
			return v59
		end
		table.insert(v58, v59)
	end
	if p57 then
		return v58
	else
		return nil
	end
end
function v_u_14.LookThrough(p60, p61, p62) -- name: LookThrough
	for _, v63 in pairs(p61:GetChildren()) do
		if v63:IsA("Model") and v63.Name == p62 then
			return v63
		end
		if not v63:IsA("Folder") then
			continue
		end
		local v64 = p60:LookThrough(v63, p62)
		if not v64 then
			continue
		end
		return v64
	end
end
function v_u_14.SilentWaitForChild(_, p65, p66) -- name: SilentWaitForChild
	while not p65:FindFirstChild(p66) do
		p65.ChildAdded:Wait()
	end
	return p65[p66]
end
function v_u_14.WaitForChildRecursive(_, p_u_67, p_u_68, p_u_69) -- name: WaitForChildRecursive
	local v70 = p_u_67:FindFirstChild(p_u_68, true)
	if v70 then
		return v70
	end
	local v_u_71 = Instance.new("BindableEvent")
	if p_u_69 then
		task.delay(p_u_69, v_u_71.Fire, v_u_71, nil)
	end
	task.defer(function()
		-- upvalues: (copy) p_u_69, (copy) p_u_67, (copy) p_u_68, (copy) v_u_71
		local v_u_72 = false
		if not p_u_69 then
			task.delay(5, function()
				-- upvalues: (ref) v_u_72, (ref) p_u_67, (ref) p_u_68
				if not v_u_72 then
					warn("Infinite yield possible for", p_u_67:GetFullName() .. ":WaitForChildRecursive(\"" .. p_u_68 .. "\")")
				end
			end)
		end
		while true do
			local v73 = p_u_67:FindFirstChild(p_u_68, true)
			if v73 then
				break
			end
			p_u_67.DescendantAdded:Wait()
		end
		v_u_71:Fire(v73)
	end)
	return v_u_71.Event:Wait()
end
function v_u_14.GetTaggedIn(_, p74, p75) -- name: GetTaggedIn
	-- upvalues: (copy) v_u_2
	local v76 = {}
	for _, v77 in pairs(v_u_2:GetTagged(p74)) do
		if not v77:IsDescendantOf(p75 or workspace) then
			continue
		end
		table.insert(v76, v77)
	end
	return v76
end
function v_u_14.GetCharacterModel(p78, p79) -- name: GetCharacterModel
	-- upvalues: (copy) v_u_6
	if p79 and p79 ~= workspace then
		if v_u_6:GetPlayerFromCharacter(p79) then
			return p79
		else
			return p78:GetCharacterModel(p79.Parent)
		end
	else
		return nil
	end
end
function v_u_14.GetProperArticle(_, p80) -- name: GetProperArticle
	-- upvalues: (copy) v_u_13
	local v81 = v_u_13
	local v82 = string.lower(p80)
	return "a" .. (v81[string.sub(v82, 1, 1)] and "n" or "")
end
function v_u_14.AntiBarcodeNames(_, p83) -- name: AntiBarcodeNames
	local v84 = 0
	local v85 = ""
	for v86 = 1, #p83 do
		local v87 = string.sub(p83, v86, v86)
		if v87 == "l" or v87 == "I" then
			v84 = v84 + 1
			v85 = v85 .. (v87 == "l" and "L" or (v87 == "I" and "i" or v87))
		else
			v85 = v85 .. v87
		end
	end
	if v84 > 3 then
		p83 = v85 or p83
	end
	return p83
end
function v_u_14.AntiCircleNames(_, p88) -- name: AntiCircleNames
	local v89 = 0
	local v90 = ""
	for v91 = 1, #p88 do
		local v92 = string.sub(p88, v91, v91)
		if v92 == "O" or v92 == "0" then
			v89 = v89 + 1
			v90 = v90 .. (v92 == "O" and "o" or v92)
		else
			v90 = v90 .. v92
		end
	end
	if v89 > 3 then
		p88 = v90 or p88
	end
	return p88
end
function v_u_14.SanitizeName(p93, p94) -- name: SanitizeName
	return p93:AntiCircleNames((p93:AntiBarcodeNames(p94)))
end
function v_u_14.GetName(_, p95, p96, p97) -- name: GetName
	local v98
	if p95.HasVerifiedBadge then
		v98 = " " .. utf8.char(57344)
	elseif p97 or not p95.HasRobloxSubscription then
		v98 = (p97 or p95.MembershipType ~= Enum.MembershipType.Premium) and "" or " " .. utf8.char(57345)
	else
		v98 = " " .. utf8.char(57347)
	end
	return p96 .. v98
end
function v_u_14.GetConnectionLevelIcon(_, p99) -- name: GetConnectionLevelIcon
	-- upvalues: (copy) v_u_12
	return v_u_12[p99]
end
function v_u_14.GetConnectionLevel(_, p100) -- name: GetConnectionLevel
	return p100 < 60 and 3 or (p100 < 150 and 2 or 1)
end
function v_u_14.GetLocalConnectionPing(_, p101) -- name: GetLocalConnectionPing
	-- upvalues: (copy) v_u_6
	local v102 = (p101 or v_u_6.LocalPlayer):GetNetworkPing() * 1000
	return math.floor(v102)
end
function v_u_14.DisableShadows(_, p103) -- name: DisableShadows
	for _, v104 in pairs(p103:GetDescendants()) do
		if v104:HasTag("DisabledTexturesBlacklist") then
			continue
		end
		if v104:IsA("Light") then
			v104.Shadows = false
		else
			if not v104:IsA("BasePart") then
				continue
			end
			v104.CastShadow = false
		end
	end
end
function v_u_14.DisableTextures(_, p105) -- name: DisableTextures
	for _, v106 in pairs(p105:GetDescendants()) do
		if v106:HasTag("DisabledTexturesBlacklist") then
			continue
		end
		if v106:IsA("BasePart") then
			for _, v107 in pairs(Enum.NormalId:GetEnumItems()) do
				v106[v107.Name .. "Surface"] = Enum.SurfaceType.Smooth
			end
			if v106.Material == Enum.Material.ForceField or v106.Material == Enum.Material.Neon then
				break
			end
			local v108 = v106.CurrentPhysicalProperties
			v106.Material = Enum.Material.SmoothPlastic
			v106.MaterialVariant = ""
			v106.CustomPhysicalProperties = v106.CustomPhysicalProperties or v108
		else
			if not (v106:IsA("Texture") or v106:IsA("Decal")) or v106.Texture == "rbxassetid://7658055825" then
				continue
			end
			v106:Destroy()
		end
	end
end
function v_u_14.IsVisibleFromSearch(p109, p110, ...) -- name: IsVisibleFromSearch
	if not p110 or p110 == "" then
		return true
	end
	local v111 = { ... }
	for v112 = 1, #v111, 2 do
		local v113 = v111[v112]
		if not v113 then
			continue
		end
		local v114 = v111[v112 + 1] or game
		if p109._search_translator then
			local v115 = p109._search_translator.Translate
			local v116 = p109._search_translator
			local v117, v118 = pcall(v115, v116, v114, v113)
			if v117 then
				v113 = string.lower(v118)
			end
		end
		if not string.find(string.lower(v113), p110) then
			continue
		end
		return true
	end
	return false
end
function v_u_14.IsValidHex(_, p119) -- name: IsValidHex
	if typeof(p119) ~= "string" or (#p119 ~= 7 or string.sub(p119, 1, 1) ~= "#") then
		return false
	end
	for v120 = 2, 7 do
		local v121 = string.sub(p119, v120, v120)
		local v122 = string.byte(v121)
		if v122 >= 48 and v122 <= 57 or v122 >= 97 and v122 <= 102 then
			continue
		end
		return false
	end
	return true
end
function v_u_14.Color3FromHex(p123, p124) -- name: Color3FromHex
	local v125 = p123:IsValidHex(p124)
	assert(v125, "Argument 1 invalid, expected a valid hex string")
	local v126 = "0x" .. string.sub(p124, 2, 3)
	local v127 = tonumber(v126)
	local v128 = "0x" .. string.sub(p124, 4, 5)
	local v129 = tonumber(v128)
	local v130 = "0x" .. string.sub(p124, 6, 7)
	local v131 = tonumber(v130)
	return Color3.fromRGB(v127, v129, v131)
end
function v_u_14.HexFromColor3(_, p132) -- name: HexFromColor3
	local v133 = typeof(p132) == "Color3"
	assert(v133, "Argument 1 invalid, expected a Color3")
	local v134 = p132.R * 255 + 0.5
	local v135 = math.floor(v134)
	local v136 = p132.G * 255 + 0.5
	local v137 = math.floor(v136)
	local v138 = p132.B * 255 + 0.5
	local v139 = math.floor(v138)
	return string.format("#%02x%02x%02x", v135, v137, v139)
end
function v_u_14.GetInputEnumFromName(p140, p141) -- name: GetInputEnumFromName
	if not p140._name_to_input_enum then
		p140._name_to_input_enum = {}
		local v142 = {}
		for _, v143 in pairs({ Enum.KeyCode, Enum.UserInputType }) do
			for _, v144 in pairs(v143:GetEnumItems()) do
				if v142[v144] == nil then
					v142[v144] = true
				else
					if v142[v144] ~= true then
						continue
					end
					v142[v144] = false
				end
			end
		end
		for v145, v146 in pairs(v142) do
			if not v146 then
				continue
			end
			p140._name_to_input_enum[v145.Name] = v145
		end
	end
	return p140._name_to_input_enum[p141]
end
function v_u_14.SphereLineIntersection(_, p147, p148, p149, p150) -- name: SphereLineIntersection
	local v151 = p150 - p149
	local v152 = v151.magnitude
	local v153 = v151.unit
	local v154 = p149 - p147
	local v155 = v154:Dot(v153)
	local v156 = v154:Dot(v154) - p148 * p148
	if v156 > 0 and v155 > 0 then
		return false
	else
		local v157 = v155 * v155 - v156
		if v157 < 0 then
			return false
		else
			return v152 >= -v155 - math.sqrt(v157)
		end
	end
end
function v_u_14.Knockback(_, p_u_158, p159, p160) -- name: Knockback
	-- upvalues: (copy) v_u_9
	p_u_158.Velocity = Vector3.new(0, 0, 0)
	local v161 = Instance.new("BodyVelocity")
	local v162 = p159.X
	local v163 = math.abs(v162) > 0.1 and 1 or 0
	local v164 = p159.Y
	local v165 = math.abs(v164) > 0.1 and 1 or 0
	local v166 = p159.Z
	local v167 = math.abs(v166) > 0.1 and 1 or 0
	v161.MaxForce = Vector3.new(v163, v165, v167) * 100000
	v161.Velocity = p159
	v161.Parent = p_u_158
	v_u_9:AddItem(v161, 0.2)
	if p160 then
		v_u_9:AddItem(v161, p160)
		task.delay(p160, function()
			-- upvalues: (copy) p_u_158
			p_u_158.Velocity = Vector3.new(0, 0, 0)
		end)
	end
	return v161
end
function v_u_14.GetArmsData(_, p168) -- name: GetArmsData
	if p168 then
		local v169 = p168:FindFirstChildOfClass("Shirt")
		if v169 then
			v169 = v169.ShirtTemplate
		end
		local v170 = p168:FindFirstChildOfClass("BodyColors")
		local v171
		if v170 then
			v171 = v170.LeftArmColor3
		else
			v171 = v170
		end
		if v170 then
			v170 = v170.RightArmColor3
		end
		return v169, v171, v170
	end
end
function v_u_14.TimeFormat(_, p172) -- name: TimeFormat
	local v173 = math.floor(p172)
	local v174 = v173 % 60
	local v175 = v173 / 60
	return math.floor(v175) .. ":" .. (v174 < 10 and "0" or "") .. v174
end
function v_u_14.TimeFormat2(_, p176, p177, p178) -- name: TimeFormat2
	if not p178 and p176 <= 0 then
		return "0s"
	end
	if p178 and p176 < 60 then
		return "0m"
	end
	local v179 = p176 % 60
	local v180 = p176 - v179
	local v181 = v180 / 60 % 60
	local v182 = v180 - v181 * 60
	local v183 = v182 / 60 / 60 % 24
	local v184 = v182 - v183 * 60 * 60
	local v185 = v184 / 60 / 60 / 24 % 365
	local v186 = (v184 - v185 * 24 * 60 * 60) / 60 / 60 / 24 / 365
	if not p177 then
		return (v186 > 0 and (v186 .. "y " or "") or "") .. ((v186 > 0 or v185 > 0) and (v185 .. "d " or "") or "") .. ((v186 > 0 or (v185 > 0 or v183 > 0)) and (v183 .. "h " or "") or "") .. ((v186 > 0 or (v185 > 0 or (v183 > 0 or v181 > 0))) and (v181 .. "m " or "") or "") .. ((v186 > 0 or (v185 > 0 or (v183 > 0 or (v181 > 0 or v179 > 0)))) and not p178 and (v179 .. "s" or "") or "")
	end
	local v187 = typeof(p177) == "number" and p177 and p177 or 1
	local v188 = 0
	local v189 = ""
	for _, v190 in pairs({
		{ v186, "y" },
		{ v185, "d" },
		{ v183, "h" },
		{ v181, "m" },
		{ v179, "s" }
	}) do
		if v190[1] <= 0 then
			continue
		end
		v188 = v188 + 1
		v189 = v189 .. (v188 > 1 and " " or "") .. v190[1] .. v190[2]
		if v187 > v188 then
			continue
		end
	end
	return v189
end
function v_u_14.ScaleParticleEmitter(_, p191, p192) -- name: ScaleParticleEmitter
	local v193 = p191:IsA("ParticleEmitter") and {} or p191:GetDescendants()
	table.insert(v193, p191)
	for _, v194 in pairs(v193) do
		if not v194:IsA("ParticleEmitter") then
			continue
		end
		local v195 = {}
		for _, v196 in pairs(v194.Size.Keypoints) do
			local v197 = NumberSequenceKeypoint.new
			local v198 = v196.Time
			local v199 = v196.Value * p192
			local v200 = v196.Envelope * p192
			table.insert(v195, v197(v198, v199, v200))
		end
		v194.Size = NumberSequence.new(v195)
		v194.Speed = NumberRange.new(v194.Speed.Min * p192, v194.Speed.Max * p192)
		v194.Acceleration = v194.Acceleration * p192 ^ 2
	end
end
function v_u_14.EncodeCFrame(_, p201) -- name: EncodeCFrame
	local v202, v203, v204 = p201:ToOrientation()
	return {
		[utf8.char(0)] = p201.X,
		[utf8.char(1)] = p201.Y,
		[utf8.char(2)] = p201.Z,
		[utf8.char(3)] = v202,
		[utf8.char(4)] = v203,
		[utf8.char(5)] = v204
	}
end
function v_u_14.DecodeCFrame(_, p205) -- name: DecodeCFrame
	return CFrame.new(p205[utf8.char(0)], p205[utf8.char(1)], p205[utf8.char(2)]) * CFrame.fromOrientation(p205[utf8.char(3)], p205[utf8.char(4)], p205[utf8.char(5)])
end
function v_u_14.FromXYToCameraRotation(_, p206, p207) -- name: FromXYToCameraRotation
	return Vector2.new(p206, p207) * 3.141592653589793 * 2 / 256
end
function v_u_14.DecodeCameraRotation(p208, p209) -- name: DecodeCameraRotation
	local v210, v211 = utf8.codepoint(p209, 1, #p209)
	return p208:FromXYToCameraRotation(v210, v211)
end
function v_u_14.DecodeCameraRotationBulk(_, p212) -- name: DecodeCameraRotationBulk
	local v213 = { utf8.codepoint(p212, 1, #p212) }
	local v214 = {}
	for v215 = 1, #p212, 3 do
		local v216 = { v213[v215], v213[v215 + 1], v213[v215 + 2] }
		table.insert(v214, v216)
	end
	return v214
end
function v_u_14.EncodeCameraRotation(_, p217) -- name: EncodeCameraRotation
	if p217 ~= p217 then
		return utf8.char(0) .. utf8.char(0)
	end
	local v218 = p217.X % 6.283185307179586 / 3.141592653589793 / 2 * 256 + 0.5
	local v219 = math.floor(v218)
	local v220 = math.clamp(v219, 0, 255)
	local v221 = p217.Y % 6.283185307179586 / 3.141592653589793 / 2 * 256 + 0.5
	local v222 = math.floor(v221)
	local v223 = math.clamp(v222, 0, 255)
	return utf8.char(v220) .. utf8.char(v223)
end
function v_u_14.AngleBetweenVectors(_, p224, p225) -- name: AngleBetweenVectors
	local v226 = p225:Dot(p224) / p225.Magnitude / p224.Magnitude
	return math.acos(v226)
end
function v_u_14.PlayParticles(p_u_227, p_u_228) -- name: PlayParticles
	if p_u_228 then
		local v229 = typeof(p_u_228) == "Instance" and true or typeof(p_u_228) == "table"
		assert(v229, "Argument 1 invalid, expected an Instance or table")
		local v_u_230 = typeof(p_u_228) == "Instance"
		local v231
		if v_u_230 then
			v231 = not p_u_228:IsDescendantOf(workspace)
		else
			v231 = v_u_230
		end
		local v_u_232
		if v_u_230 and not v231 then
			if not p_u_227._particle_hashes[p_u_228] then
				p_u_227._particle_hashes[p_u_228] = 0
				local v_u_233 = nil
				v_u_233 = p_u_228.AncestryChanged:Connect(function()
					-- upvalues: (copy) p_u_228, (ref) v_u_233, (copy) p_u_227
					if not p_u_228:IsDescendantOf(workspace) then
						v_u_233:Disconnect()
						p_u_227._particle_hashes[p_u_228] = nil
					end
				end)
			end
			local v234 = p_u_227._particle_hashes
			v234[p_u_228] = v234[p_u_228] + 1
			v_u_232 = p_u_227._particle_hashes[p_u_228]
		else
			v_u_232 = nil
		end
		local v235
		if v_u_230 then
			v235 = p_u_228:GetDescendants()
			table.insert(v235, p_u_228)
		else
			v235 = {}
			for _, v236 in pairs(p_u_228) do
				table.insert(v235, v236)
				for _, v237 in pairs(v236:GetDescendants()) do
					table.insert(v235, v237)
				end
			end
		end
		for _, v_u_238 in pairs(v235) do
			if v_u_238:IsA("ParticleEmitter") then
				local v239 = v_u_238:GetAttribute("EmitCount") or 0
				local v240 = v_u_238:GetAttribute("EmitDelay") or 0
				local v_u_241 = v_u_238:GetAttribute("EmitDuration") or 0
				if v240 > 0 then
					task.delay(v240, v_u_238.Emit, v_u_238, v239)
				else
					task.spawn(v_u_238.Emit, v_u_238, v239)
				end
				if v_u_241 <= 0 then
					continue
				end
				task.defer(function()
					-- upvalues: (copy) v_u_238, (copy) v_u_241
					v_u_238.Enabled = true
					task.wait(v_u_241)
					v_u_238.Enabled = false
				end)
			else
				if not v_u_238:IsA("Light") then
					continue
				end
				local v_u_242 = v_u_238:GetAttribute("Brightness") or 0
				local v_u_243 = v_u_238:GetAttribute("DecaySpeed") or 1
				if v231 then
					continue
				end
				task.spawn(function()
					-- upvalues: (copy) v_u_238, (copy) v_u_242, (copy) p_u_227, (copy) v_u_243, (copy) v_u_230, (copy) p_u_228, (ref) v_u_232
					v_u_238.Brightness = v_u_242
					v_u_238.Enabled = true
					p_u_227:RenderstepForLoop(0, 100, 10 * v_u_243, function(p244)
						-- upvalues: (ref) v_u_230, (ref) p_u_227, (ref) p_u_228, (ref) v_u_232, (ref) v_u_238, (ref) v_u_242
						if v_u_230 and p_u_227._particle_hashes[p_u_228] ~= v_u_232 then
							return true
						end
						v_u_238.Brightness = v_u_242 * (1 - p244 / 100)
					end)
					if not p_u_227._particle_hashes[p_u_228] then
						v_u_238.Brightness = 0
						v_u_238.Enabled = false
					end
				end)
			end
		end
	end
end
function v_u_14.StringLessThan(_, p245, p246) -- name: StringLessThan
	if p245 == p246 then
		return false
	end
	local v247 = #p245
	local v248 = #p246
	for v249 = 1, math.min(v247, v248) do
		local v250 = string.sub(p245, v249, v249)
		local v251 = string.byte(v250)
		local v252 = string.sub(p246, v249, v249)
		local v253 = string.byte(v252)
		if v251 == v253 then
			continue
		end
		return v251 < v253
	end
	return #p245 < #p246
end
function v_u_14.CloneTable(p254, p255, p256) -- name: CloneTable
	local v257 = {}
	for v258, v259 in pairs(p255) do
		if p256 or typeof(v259) ~= "table" then
			v257[v258] = v259
		else
			v257[v258] = p254:CloneTable(v259)
		end
	end
	return v257
end
function v_u_14.PrettyNumber(_, p260) -- name: PrettyNumber
	local v261 = tonumber(p260)
	if typeof(v261) ~= "number" then
		local v262 = "Argument 1 invalid, expected a number or string, got " .. tostring(p260)
		assert(false, v262)
	end
	if tostring(p260) == "inf" then
		return "inf"
	end
	local v263, v264, v265 = string.match(v261, "^([^%d]*%d)(%d*)(.-)$")
	return v263 .. v264:reverse():gsub("(%d%d%d)", "%1,"):reverse() .. v265
end
function v_u_14.MakeSafeRaycastResult(_, p266, p267, p268, p269) -- name: MakeSafeRaycastResult
	local v270 = {
		["Position"] = p266 and p266.Position or p267 + p268 * p269
	}
	if p266 then
		p269 = p266.Distance or p269
	end
	v270.Distance = p269
	local v271
	if p266 then
		v271 = p266.Instance or nil
	else
		v271 = nil
	end
	v270.Instance = v271
	local v272
	if p266 then
		v272 = p266.Material or nil
	else
		v272 = nil
	end
	v270.Material = v272
	v270.Normal = p266 and p266.Normal or nil
	return v270
end
function v_u_14.Raycast(p273, p274, p275, p276, p277, p278, p279) -- name: Raycast
	-- upvalues: (copy) v_u_9
	local v280 = typeof(p274) == "Vector3"
	assert(v280, "Argument 1 invalid, expected a Vector3")
	local v281 = typeof(p275) == "Vector3"
	assert(v281, "Argument 2 invalid, expected a Vector3")
	local v282 = typeof(p276) == "number"
	assert(v282, "Argument 3 invalid, expected a number")
	local v283 = not p277 or typeof(p277) == "table"
	assert(v283, "Argument 4 invalid, expected a table or nil")
	local v284 = not p278 or typeof(p278) == "EnumItem"
	assert(v284, "Argument 5 invalid, expected a RaycastFilterType")
	local v285 = not p279 or typeof(p279) == "boolean"
	assert(v285, "Argument 6 invalid, expected a boolean or nil")
	local v286 = p278 or Enum.RaycastFilterType.Exclude
	local v287 = (p275 - p274).Unit * p276
	local v288 = RaycastParams.new()
	v288.FilterDescendantsInstances = p277 or {}
	v288.FilterType = v286
	v288.IgnoreWater = true
	local v289 = p273:MakeSafeRaycastResult(workspace:Raycast(p274, v287, v288), p274, (p275 - p274).Unit, p276)
	if p279 then
		local v290 = (p274 - v289.Position).Magnitude
		local v291 = Instance.new("Part")
		v291.Color = Color3.fromHSV(math.random(), 1, 1)
		v291.Material = Enum.Material.Neon
		v291.Anchored = true
		v291.CanCollide = false
		v291.Size = Vector3.new(0.01, 0.01, v290)
		v291.CFrame = CFrame.new(p274, v289.Position) * CFrame.new(0, 0, -v290 / 2)
		v291.Parent = workspace
		v_u_9:AddItem(v291, 10)
	end
	return v289
end
function v_u_14.WaitForChildWhichIsA(_, p292, p293, p294) -- name: WaitForChildWhichIsA
	local v295 = typeof(p292) == "Instance"
	local v296 = "Argument 1 invalid, expected an Instance, got " .. tostring(p292)
	assert(v295, v296)
	local v297 = typeof(p293) == "string"
	local v298 = "Argument 2 invalid, expected a string, got " .. tostring(p293)
	assert(v297, v298)
	local v299 = not p294 or typeof(p294) == "boolean"
	local v300 = "Argument 3 invalid, expected a boolean or nil, got " .. tostring(p294)
	assert(v299, v300)
	while true do
		local v301 = p292:FindFirstChildWhichIsA(p293, p294)
		if v301 then
			break
		end
		if p294 then
			p292.DescendantAdded:Wait()
		else
			p292.ChildAdded:Wait()
		end
	end
	return v301
end
function v_u_14.GetSoundGroup(p302, p303) -- name: GetSoundGroup
	-- upvalues: (copy) v_u_5
	local v304 = p303 or "Other"
	if not p302._cached_sound_groups[v304] then
		p302._cached_sound_groups[v304] = v_u_5:FindFirstChild(v304, true)
	end
	return p302._cached_sound_groups[v304]
end
function v_u_14.CreateSound(p305, p306, p307, p308, p309, p310, p311, p312, p313, p314, p315) -- name: CreateSound
	-- upvalues: (copy) v_u_7, (copy) v_u_3, (copy) v_u_10, (copy) v_u_9
	local v316 = typeof(p306) == "string"
	assert(v316, p306)
	local v317 = not p307 or typeof(p307) == "number"
	assert(v317, p307)
	local v318 = not p308 or typeof(p308) == "number"
	assert(v318, p308)
	local v319 = not p309 or ((p309 == "script" or typeof(p309) == "Instance") and true or typeof(p309) == "Vector3")
	assert(v319, p309)
	local v320 = not p310 or typeof(p310) == "boolean"
	assert(v320, "Argument 5 invalid, expected a boolean", p310)
	local v321 = not p311 or typeof(p311) == "number"
	assert(v321, "Argument 6 invalid, expected a number or nil", p311)
	local v322 = not p312 or typeof(p312) == "number"
	assert(v322, "Argument 7 invalid, expected a number or nil", p312)
	local v323 = not p313 or typeof(p313) == "number"
	assert(v323, "Argument 8 invalid, expected a number or nil", p313)
	local v324 = not p314 or typeof(p314) == "string"
	assert(v324, "Argument 9 invalid, expected a string or nil", p314)
	local v325 = not p315 or typeof(p315) == "table"
	assert(v325, "Argument 10 invalid, expected a table or nil", p315)
	if not v_u_7.IS_SERVER then
		if typeof(p309) == "Vector3" then
			local v326 = Instance.new("Part")
			v326.CFrame = CFrame.new(p309)
			v326.Size = Vector3.new(1, 1, 1)
			v326.Transparency = 1
			v326.CastShadow = false
			v326.CanCollide = false
			v326.CanTouch = false
			v326.CanQuery = false
			v326.Anchored = true
			v326.Parent = workspace
			v_u_9:AddItem(v326, p311 or 60)
			p309 = v326
		elseif p309 == "script" then
			p309 = script
		end
		local v327 = Instance.new("Sound")
		v327.SoundId = p306
		v327.Volume = p307 or 1
		v327.PlaybackSpeed = p308 or 1
		v327.RollOffMinDistance = p312 or 50
		v327.RollOffMaxDistance = p313 or 400
		v327.RollOffMode = Enum.RollOffMode.Inverse
		v327.SoundGroup = p305:GetSoundGroup(p314)
		v327:AddTag("AudioVisualizer")
		for v328, v329 in pairs(p315 or {}) do
			v327[v328] = v329
		end
		v327.Parent = p309
		if p310 then
			v327:Play()
		end
		if p311 then
			v_u_9:AddItem(v327, p311)
		end
		return v327
	end
	v_u_3.Remotes.Misc.FunctionsUnreliable:FireAllClients(v_u_10:ToEnum("CreateSound"), p306, p307, p308, p309, p310, p311, p312, p313, p314, p315)
end
function v_u_14.WaitForChild(_, p330, ...) -- name: WaitForChild
	local v331 = typeof(p330) == "Instance"
	local v332 = "Argument 1 invalid, expected an Instance, got " .. tostring(p330)
	assert(v331, v332)
	for v333, v334 in pairs({ ... }) do
		local v335 = typeof(v334) == "string"
		local v336 = "Argument " .. v333 + 1 .. " invalid, expected a string, got " .. tostring(v334)
		assert(v335, v336)
		p330 = p330:WaitForChild(v334)
	end
	return p330
end
function v_u_14.RenderstepForLoop(_, ...) -- name: RenderstepForLoop
	-- upvalues: (copy) v_u_11
	v_u_11(...)
end
function v_u_14._RecursiveIsUIElementVisible(p337, p338) -- name: _RecursiveIsUIElementVisible
	if p338:IsA("ScreenGui") or (p338:IsA("SurfaceGui") or p338:IsA("BillboardGui")) then
		return p338.Enabled
	end
	local v339 = p338.Visible
	if v339 then
		v339 = p337:_RecursiveIsUIElementVisible(p338.Parent)
	end
	return v339
end
function v_u_14._SetupTranslator(p340) -- name: _SetupTranslator
	-- upvalues: (copy) v_u_7, (copy) v_u_1, (copy) v_u_6
	if v_u_7.IS_CLIENT then
		local v341 = v_u_1.GetTranslatorForPlayerAsync
		local v342 = v_u_1
		local v343 = v_u_6.LocalPlayer
		local v344, v345 = pcall(v341, v342, v343)
		if v344 then
			p340._search_translator = v345
		else
			warn("Failed to fetch translator, error:", v345)
		end
	else
		return
	end
end
function v_u_14._Init(p346) -- name: _Init
	task.defer(p346._SetupTranslator, p346)
end
return v_u_14._new()