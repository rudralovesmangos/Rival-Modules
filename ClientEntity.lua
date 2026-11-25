local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("CollectionService")
local v_u_3 = game:GetService("RunService")
local v4 = game:GetService("Players")
local v_u_5 = require(v1.Modules.CONSTANTS)
local v_u_6 = require(v1.Modules.ReplicatedClass)
local v_u_7 = require(v1.Modules.GameplayUtility)
local v_u_8 = require(v1.Modules.BetterDebris)
local v_u_9 = require(v1.Modules.Utility)
local v_u_10 = require(v1.Modules.Signal)
local v_u_11 = require(v4.LocalPlayer.PlayerScripts.Controllers.WrapController)
local v_u_12 = v4.LocalPlayer.PlayerScripts.Assets.Misc.ShieldBreakEffect.Attachment
local v_u_13 = v4.LocalPlayer.PlayerScripts.Assets.Misc.InvincibilityParticles.Attachment
local v_u_14 = v4.LocalPlayer.PlayerScripts.Assets.Misc.ExtinguishParticles
local v_u_15 = v4.LocalPlayer.PlayerScripts.Assets.Misc.FreezeEffects
local v_u_16 = v4.LocalPlayer.PlayerScripts.Assets.Misc.SlowParticles
local v_u_17 = v4.LocalPlayer.PlayerScripts.Assets.Misc.BurningEffects
local v_u_18 = v4.LocalPlayer.PlayerScripts.Assets.Misc.BlipEffects
local v_u_19 = v1.Modules.Finishers
local v_u_20 = setmetatable({}, v_u_6)
v_u_20.__index = v_u_20
function v_u_20.new(p21) -- name: new
	-- upvalues: (copy) v_u_6, (copy) v_u_20, (copy) v_u_10
	local v22 = v_u_6.new(p21)
	local v23 = v_u_20
	local v24 = setmetatable(v22, v23)
	v24.Died = v_u_10.new()
	v24.HealthChanged = v_u_10.new()
	v24.ShieldChanged = v_u_10.new()
	v24.BurnEffectPlaying = v_u_10.new()
	v24.Model = p21.Model
	v24.RootPart = p21.RootPart
	v24.AimAssistBlacklist = false
	v24._destroyed = nil
	v24._is_hidden = nil
	v24._is_dead = nil
	v24._connections = {}
	v24._hurt_effect_hash = 0
	v24._hitboxes = {}
	v24._hitboxes_small = {}
	v24._burn_effect_finish = 0
	v24._burn_effect_sound = nil
	v24._burn_effect_particles = {}
	v24._model_original_parent_hurt_effect = nil
	v24._thaw_callback = nil
	v24._thaw_highlight = nil
	v24._current_finisher = nil
	v24._invincibility_visual = nil
	v24._headshot_particles = nil
	v24._permafrost_slow_particles = nil
	v24:_Init()
	return v24
end
function v_u_20.IsRendered(p25) -- name: IsRendered
	-- upvalues: (copy) v_u_5
	local v26 = v_u_5.SHOULD_ALWAYS_REPLICATE()
	if not v26 then
		if p25.ClientFighter then
			return p25.ClientFighter:IsRendered()
		end
		v26 = (workspace.CurrentCamera.CFrame.Position - p25.RootPart.Position).Magnitude < v_u_5.RENDER_DISTANCE
	end
	return v26
end
function v_u_20.IsAlive(p27) -- name: IsAlive
	local v28 = not (p27._destroyed or p27._is_dead)
	if v28 then
		v28 = p27:GetHealth() > 0
	end
	return v28
end
function v_u_20.IsHidden(p29) -- name: IsHidden
	return p29._is_hidden
end
function v_u_20.GetScreenPoint(p30) -- name: GetScreenPoint
	return workspace.CurrentCamera:WorldToScreenPoint(p30.RootPart.Position)
end
function v_u_20.GetHitboxes(p31, p32) -- name: GetHitboxes
	return p32 and #p31._hitboxes_small > 0 and p31._hitboxes_small or p31._hitboxes
end
function v_u_20.GetShield(_) -- name: GetShield
	return 0
end
function v_u_20.GetMaxShield(_) -- name: GetMaxShield
	return 0
end
function v_u_20.SetHidden(p33, p34) -- name: SetHidden
	p33._is_hidden = p34
end
function v_u_20.ReplicateFromServer(p35, p36, ...) -- name: ReplicateFromServer
	-- upvalues: (copy) v_u_6
	if p36 == "BurnEffect" then
		if p35:IsRendered() then
			p35:_BurnEffect(...)
		end
	elseif p36 == "ExtinguishEffect" then
		if p35:IsRendered() then
			p35:_ExtinguishEffect(...)
		end
	elseif p36 == "HurtEffect" then
		if p35:IsRendered() then
			p35:_HurtEffect(...)
		end
	elseif p36 == "HealEffect" then
		if p35:IsRendered() then
			p35:_HealEffect(...)
		end
	elseif p36 == "FreezeEffect" then
		if p35:IsRendered() then
			p35:_FreezeEffect(...)
		end
	elseif p36 == "ThawFreezeEffect" then
		if p35:IsRendered() then
			p35:_ThawFreezeEffect(...)
		end
	elseif p36 == "FinisherEffect" then
		if p35:IsRendered() then
			local v37, v38, v39, v40 = ...
			p35:_PlayFinisher(p35:FromEnum(v37), v38, v39, v40)
		end
	elseif p36 == "BlipEffect" then
		if p35:IsRendered() then
			p35:_BlipEffect(...)
		end
	elseif p36 == "SlowEffect" then
		if p35:IsRendered() then
			p35:_SlowEffect(...)
		end
	elseif p36 == "BrokeShieldEffect" then
		if p35:IsRendered() then
			p35:_BrokeShieldEffect(...)
		end
	elseif p36 == "CreateSound" then
		if p35:IsRendered() then
			p35:_CreateSound(...)
		end
	elseif p36 == "Died" then
		p35._is_dead = true
		p35.Died:Fire()
	else
		v_u_6.ReplicateFromServer(p35, p36, ...)
	end
end
function v_u_20.Destroy(p41) -- name: Destroy
	-- upvalues: (copy) v_u_6
	p41._destroyed = true
	for _, v42 in pairs(p41._connections) do
		v42:Disconnect()
	end
	p41._hitboxes = {}
	p41._hitboxes_small = {}
	p41.Died:Destroy()
	p41.HealthChanged:Destroy()
	p41.ShieldChanged:Destroy()
	p41.BurnEffectPlaying:Destroy()
	if p41.Model then
		p41.Model:Destroy()
	end
	if p41._current_finisher then
		p41._current_finisher:Destroy()
		p41._current_finisher = nil
	end
	v_u_6.Destroy(p41)
end
function v_u_20._CreateSound(p43, p44, p45, p46, p47, p48) -- name: _CreateSound
	-- upvalues: (copy) v_u_9
	local v49 = p48 and 400 or nil
	local v50 = v_u_9:CreateSound(p44, p45 * (p48 and 2 or 1), p46, p43.RootPart, true, 15, v49, v49)
	if p47 and p47 ~= 1 then
		local v51 = Instance.new("PitchShiftSoundEffect")
		v51.Octave = p47
		v51.Parent = v50
	end
end
function v_u_20._UpdatePermafrostSlowStacks(p52) -- name: _UpdatePermafrostSlowStacks
	-- upvalues: (copy) v_u_16
	if p52._permafrost_slow_highlight then
		p52._permafrost_slow_highlight:Destroy()
		p52._permafrost_slow_highlight = nil
	end
	if p52:IsAlive() then
		local v53 = p52:IsAlive() and p52:Get("ReplicatedExternalGameplayData")
		if v53 then
			v53 = p52:Get("ReplicatedExternalGameplayData").PermafrostSlowStacks
		end
		local v54 = v53 and (v53.Stacks or 0) or 0
		local v55 = v53 and v53.MaxStacks or 0
		local v56 = v54 / math.max(1, v55)
		if v56 <= 0 then
			for _, v57 in pairs(p52._permafrost_slow_particles or {}) do
				v57:Destroy()
			end
			p52._permafrost_slow_particles = nil
		else
			if not p52._permafrost_slow_particles then
				p52._permafrost_slow_particles = {}
				for _, v58 in pairs(v_u_16:GetChildren()) do
					local v59 = v58:Clone()
					v59.Parent = p52.RootPart
					local v60 = p52._permafrost_slow_particles
					table.insert(v60, v59)
				end
			end
			for _, v61 in pairs(p52._permafrost_slow_particles) do
				v61.LocalTransparencyModifier = 1 + -1 * v56
			end
		end
	else
		return
	end
end
function v_u_20._UpdateInvincibilityVisual(p62) -- name: _UpdateInvincibilityVisual
	-- upvalues: (copy) v_u_13
	if p62:Get("IsInvincible") or not p62._invincibility_visual then
		if p62:Get("IsInvincible") and not p62._invincibility_visual then
			p62._invincibility_visual = v_u_13:Clone()
			p62._invincibility_visual.Parent = p62.RootPart
		end
	else
		p62._invincibility_visual:Destroy()
		p62._invincibility_visual = nil
	end
end
function v_u_20._PlayFinisher(p63, p64, p65, p66, p67) -- name: _PlayFinisher
	-- upvalues: (copy) v_u_19, (copy) v_u_5
	local v68 = p63.Humanoid or p63.RootPart
	if v68 and v68:IsDescendantOf(workspace) then
		if p63._current_finisher then
			p63._current_finisher:Destroy()
		end
		p63._current_finisher = require(v_u_19[p64]).new(v68, p65, p66)
		p63._current_finisher:SetSerial(p67)
		if v_u_5.IS_STUDIO then
			p63._current_finisher:PlayClient()
		else
			local v69 = p63._current_finisher.PlayClient
			local v70 = p63._current_finisher
			pcall(v69, v70)
		end
	else
		return
	end
end
function v_u_20._SlowEffect(p71, p72) -- name: _SlowEffect
	-- upvalues: (copy) v_u_16, (copy) v_u_8
	for _, v73 in pairs(v_u_16:GetChildren()) do
		local v74 = v73:Clone()
		v74.Parent = p71.RootPart
		v_u_8:AddItem(v74, p72)
	end
end
function v_u_20._BlipEffect(p75, p76, p77, p78, p79) -- name: _BlipEffect
	-- upvalues: (copy) v_u_18, (copy) v_u_8, (copy) v_u_9, (copy) v_u_11
	local v80 = p79 and p75.ClientFighter
	if v80 then
		v80 = p75.ClientFighter:GetItem(p79)
	end
	if v80 then
		v80 = v80:GetWrap()
	end
	for _, v81 in pairs({ p76, p77 }) do
		local v82 = (v_u_18:FindFirstChild(p78) or v_u_18.Default):Clone()
		v82.CFrame = v81 or p75.RootPart.CFrame
		v82.Parent = workspace
		v_u_8:AddItem(v82, 5)
		v_u_9:PlayParticles(v82)
		if not v80 then
			continue
		end
		v_u_11:ApplyWrap(v_u_11:RecordOriginalWrapProperties(v82), v80, true)
	end
	v_u_9:CreateSound("rbxassetid://123181974576488", 1, 1.5 + 0.2 * math.random(), p75.RootPart, true, 5)
end
function v_u_20._BrokeShieldEffect(p83) -- name: _BrokeShieldEffect
	-- upvalues: (copy) v_u_12, (copy) v_u_8, (copy) v_u_9
	local v84 = v_u_12:Clone()
	v84.Parent = p83.RootPart
	v_u_8:AddItem(v84, 5)
	v_u_9:PlayParticles(v84)
	v_u_9:CreateSound("rbxassetid://77066159140457", 1, 1.375 + 0.25 * math.random(), p83.RootPart, true, 5)
	v_u_9:CreateSound("rbxassetid://82787629279726", 1.25, 1 + 0.2 * math.random(), p83.RootPart, true, 5)
end
function v_u_20._ThawFreezeEffect(p_u_85, p_u_86) -- name: _ThawFreezeEffect
	-- upvalues: (copy) v_u_8, (copy) v_u_3
	if p_u_85._thaw_highlight then
		p_u_85._thaw_highlight:Destroy()
		p_u_85._thaw_highlight = nil
	end
	if p_u_86 and p_u_86 > 0 then
		p_u_85._thaw_highlight = Instance.new("Highlight")
		p_u_85._thaw_highlight.FillColor = Color3.fromRGB(161, 222, 255)
		p_u_85._thaw_highlight.OutlineColor = Color3.fromRGB(0, 200, 255)
		p_u_85._thaw_highlight.DepthMode = Enum.HighlightDepthMode.Occluded
		p_u_85._thaw_highlight.Adornee = p_u_85.Model
		p_u_85._thaw_highlight.Parent = p_u_85.Model
		v_u_8:AddItem(p_u_85._thaw_highlight, p_u_86)
		task.spawn(function()
			-- upvalues: (copy) p_u_85, (copy) p_u_86, (ref) v_u_3
			local v87 = p_u_85._thaw_highlight
			local v88 = tick()
			while tick() < v88 + p_u_86 do
				local v89 = ((tick() - v88) / p_u_86) ^ 4
				v87.FillTransparency = 0.5 + 0.5 * v89
				v87.OutlineTransparency = 0 + 1 * v89
				v_u_3.RenderStepped:Wait()
			end
		end)
	end
	if p_u_85._thaw_callback then
		local v90 = p_u_85._thaw_callback
		pcall(v90, p_u_85)
		p_u_85._thaw_callback = nil
	end
end
function v_u_20._FreezeEffect(p_u_91, p92, p_u_93) -- name: _FreezeEffect
	-- upvalues: (copy) v_u_15, (copy) v_u_8, (copy) v_u_9
	p_u_91:_ThawFreezeEffect()
	local v_u_94 = (v_u_15:FindFirstChild(p_u_93 or "Default") or v_u_15.Default):Clone()
	v_u_94.PrimaryPart = v_u_94.Primary
	for _, v95 in pairs(v_u_94:GetDescendants()) do
		if not v95:IsA("BasePart") then
			continue
		end
		v95.CanCollide = false
		v95.CanTouch = false
		v95.CanQuery = false
		v95.CanTouch = false
		v95.Massless = true
		v95.Anchored = false
		if v95 == v_u_94.PrimaryPart then
			continue
		end
		local v96 = Instance.new("WeldConstraint")
		v96.Part0 = v_u_94.PrimaryPart
		v96.Part1 = v95
		v96.Parent = v_u_94.PrimaryPart
	end
	v_u_94:SetPrimaryPartCFrame(p_u_91.RootPart.CFrame)
	v_u_94.Parent = workspace
	v_u_8:AddItem(v_u_94, p92 + 3)
	local v97 = Instance.new("WeldConstraint")
	v97.Part0 = p_u_91.RootPart
	v97.Part1 = v_u_94.PrimaryPart
	v97.Parent = v_u_94
	if p_u_93 == "Bubble" or p_u_93 == "Gum" then
		function p_u_91._thaw_callback()
			-- upvalues: (copy) v_u_94, (ref) v_u_8, (ref) v_u_9
			if v_u_94.PrimaryPart then
				v_u_8:AddItem(v_u_94, 2)
				local v98 = v_u_9
				local v99 = "rbxassetid://18763517194"
				local v100 = 1
				local v101 = 1
				local v102 = v_u_94.PrimaryPart
				if v102 then
					v102 = v_u_94.PrimaryPart.Position
				end
				v98:CreateSound(v99, v100, v101, v102, true, 10)
				local v_u_103 = v_u_94.PrimaryPart.Size
				v_u_9:RenderstepForLoop(0, 100, 10, function(p104)
					-- upvalues: (ref) v_u_94, (copy) v_u_103
					if not v_u_94.PrimaryPart then
						return true
					end
					local v105 = 1 - (1 - p104 / 100) ^ 3
					v_u_94.PrimaryPart.Transparency = 0.5 + 0.5 * v105
					v_u_94.PrimaryPart.Size = v_u_103 * (1 + 2 * v105)
				end)
				v_u_94:Destroy()
			else
				v_u_94:Destroy()
			end
		end
	elseif p_u_93 == "Temporal" then
		v_u_9:CreateSound("rbxassetid://18431054727", 1.5, 1 + 0.1 * math.random(), v_u_94.PrimaryPart, true, 10)
		v_u_9:CreateSound("rbxassetid://8571334160", 0.75, 1.2, v_u_94.PrimaryPart, true, 10)
		function p_u_91._thaw_callback()
			-- upvalues: (copy) v_u_94, (ref) v_u_8, (ref) v_u_9
			if v_u_94.PrimaryPart then
				v_u_8:AddItem(v_u_94, 2)
				local v106 = v_u_9
				local v107 = "rbxassetid://8571436177"
				local v108 = 0.5
				local v109 = 2
				local v110 = v_u_94.PrimaryPart
				if v110 then
					v110 = v_u_94.PrimaryPart.Position
				end
				v106:CreateSound(v107, v108, v109, v110, true, 10)
				local v_u_111 = v_u_94.PrimaryPart.Size
				v_u_9:RenderstepForLoop(0, 100, 5, function(p112)
					-- upvalues: (ref) v_u_94, (copy) v_u_111
					if not v_u_94.PrimaryPart then
						return true
					end
					local v113 = (p112 / 100) ^ 3
					v_u_94.PrimaryPart.Transparency = v113
					v_u_94.PrimaryPart.Size = v_u_111 * (1 + 2 * v113)
				end)
				v_u_94:Destroy()
			else
				v_u_94:Destroy()
			end
		end
	elseif p_u_93 == "Cocoon" then
		function p_u_91._thaw_callback()
			-- upvalues: (copy) v_u_94, (ref) v_u_8, (ref) v_u_9
			local v114 = v_u_94:FindFirstChild("Cocoon")
			if v114 then
				v114.Transparency = 1
				v_u_8:AddItem(v_u_94, 2)
				v_u_9:PlayParticles(v114)
			else
				v_u_94:Destroy()
			end
		end
	elseif p_u_93 == "SandBucket" then
		function p_u_91._thaw_callback()
			-- upvalues: (copy) v_u_94
			v_u_94:Destroy()
		end
	elseif p_u_93 == "Wires" or (p_u_93 == "Ropes" or (p_u_93 == "WhiteWires" or p_u_93 == "PurpleWires")) then
		function p_u_91._thaw_callback()
			-- upvalues: (copy) v_u_94
			v_u_94:Destroy()
		end
	elseif p_u_93 == "Selection" then
		function p_u_91._thaw_callback()
			-- upvalues: (copy) v_u_94
			v_u_94:Destroy()
		end
	elseif p_u_93 == "Starforge" then
		function p_u_91._thaw_callback()
			-- upvalues: (copy) v_u_94
			v_u_94:Destroy()
		end
	elseif p_u_93 == "UFOBeam" then
		function p_u_91._thaw_callback()
			-- upvalues: (copy) v_u_94
			v_u_94:Destroy()
		end
	else
		if p_u_93 == "Wrapped" then
			v_u_9:CreateSound("rbxassetid://74885181688460", 0.875, 1 + 0.1 * math.random(), v_u_94.PrimaryPart, true, 5)
		else
			v_u_9:CreateSound("rbxassetid://18429138544", 0.75, 2 + 0.5 * math.random(), v_u_94.PrimaryPart, true, 10)
		end
		function p_u_91._thaw_callback()
			-- upvalues: (copy) v_u_94, (ref) v_u_8, (copy) p_u_93, (ref) v_u_9
			if v_u_94.PrimaryPart then
				v_u_8:AddItem(v_u_94, 2)
				local v115 = v_u_94.PrimaryPart.Position
				v_u_94.PrimaryPart:Destroy()
				for _, v116 in pairs(v_u_94:GetChildren()) do
					if not v116:IsA("BasePart") then
						continue
					end
					v116.Velocity = CFrame.new(v115, v116.Position).LookVector * (25 + 25 * math.random())
					v116.RotVelocity = CFrame.Angles(math.random() * 3.141592653589793 * 2, math.random() * 3.141592653589793 * 2, math.random() * 3.141592653589793 * 2).LookVector * (10 + 10 * math.random())
				end
				if p_u_93 == "Wrapped" then
					v_u_9:CreateSound("rbxassetid://121822631205080", 0.875, 1, v115, true, 10)
				else
					v_u_9:CreateSound("rbxassetid://135970869546121", 0.875, 1, v115, true, 10)
				end
			else
				v_u_94:Destroy()
				return
			end
		end
	end
	local v_u_117 = p_u_91._thaw_callback
	task.delay(p92, function()
		-- upvalues: (copy) p_u_91, (copy) v_u_117
		if p_u_91._thaw_callback == v_u_117 then
			p_u_91._thaw_callback = nil
			v_u_117()
		end
	end)
end
function v_u_20._ExtinguishEffect(p118) -- name: _ExtinguishEffect
	-- upvalues: (copy) v_u_14, (copy) v_u_8, (copy) v_u_9
	for _, v119 in pairs(p118._burn_effect_particles) do
		v119:Destroy()
	end
	p118._burn_effect_particles = {}
	p118._burn_effect_finish = 0
	if p118._burn_effect_sound then
		p118._burn_effect_sound:Destroy()
		p118._burn_effect_sound = nil
	end
	local v120 = v_u_14:Clone()
	v120.CFrame = p118.RootPart.CFrame
	v120.Parent = workspace
	v_u_8:AddItem(v120, 10)
	v_u_9:CreateSound("rbxassetid://16812185839", 0.75, 1.3 + 0.2 * math.random(), v120, true)
	v_u_9:CreateSound("rbxassetid://16812389263", 0.75, 1.3 + 0.2 * math.random(), v120, true)
	v_u_9:PlayParticles(v120.Attachment)
end
function v_u_20._BurnEffect(p121, p122, p123, p124) -- name: _BurnEffect
	-- upvalues: (copy) v_u_9, (copy) v_u_17, (copy) v_u_8, (copy) v_u_11
	if p123 then
		p123 = p121:FromEnum(p123)
	end
	local v125 = tick() < p121._burn_effect_finish
	if p121._burn_effect_sound then
		p121._burn_effect_sound:Destroy()
	end
	p121._burn_effect_sound = v_u_9:CreateSound("rbxassetid://13702989275", 0.25, 0.9 + 0.2 * math.random(), p121.RootPart, true, 10)
	p121._burn_effect_finish = tick() + p122
	if not v125 then
		local v126 = p121.RootPart.Size.Y / 2
		local v127 = {}
		for _, v128 in pairs((v_u_17:FindFirstChild(p123 or "Default") or v_u_17.Default):GetChildren()) do
			if v128:IsA("ParticleEmitter") then
				local v129 = v128:Clone()
				v129.Parent = p121.RootPart
				table.insert(v127, v129)
				v_u_9:ScaleParticleEmitter(v129, v126)
			else
				if not v128:IsA("Light") then
					continue
				end
				local v130 = v128:Clone()
				v130.Range = v130.Range * v126
				v130.Parent = p121.RootPart
				v_u_8:AddItem(v130, p122 + 4)
				table.insert(v127, v130)
			end
		end
		if p124 then
			v_u_11:ApplyWrap(v_u_11:RecordOriginalWrapProperties(v127), p124, true)
		end
		p121._burn_effect_particles = v127
		p121.BurnEffectPlaying:Fire(p121._burn_effect_particles)
		while tick() < p121._burn_effect_finish do
			wait(p121._burn_effect_finish - tick())
		end
		for _, v_u_131 in pairs(v127) do
			if v_u_131:IsA("ParticleEmitter") then
				v_u_131.Enabled = false
				v_u_8:AddItem(v_u_131, v_u_131.Lifetime.Max / v_u_131.TimeScale)
			else
				if not v_u_131:IsA("Light") then
					continue
				end
				task.spawn(function()
					-- upvalues: (copy) v_u_131, (ref) v_u_9
					local v_u_132 = v_u_131.Brightness
					v_u_9:RenderstepForLoop(0, 100, 1, function(p133)
						-- upvalues: (ref) v_u_131, (copy) v_u_132
						v_u_131.Brightness = v_u_132 * (1 - p133 / 100)
					end)
					v_u_131:Destroy()
				end)
			end
		end
		p121._burn_effect_sound = nil
	end
end
function v_u_20._HealEffect(p134) -- name: _HealEffect
	-- upvalues: (copy) v_u_9
	local v_u_135 = Instance.new("Highlight")
	v_u_135.FillColor = Color3.fromRGB(100, 255, 50)
	v_u_135.OutlineColor = Color3.fromRGB(179, 255, 153)
	v_u_135.DepthMode = Enum.HighlightDepthMode.Occluded
	v_u_135.Adornee = p134.Model
	v_u_135.Parent = p134.Model
	v_u_9:RenderstepForLoop(0, 100, 2, function(p136)
		-- upvalues: (copy) v_u_135
		local v137 = p136 / 100
		v_u_135.OutlineTransparency = v137
		v_u_135.FillTransparency = v137
	end)
	v_u_135:Destroy()
end
function v_u_20._HurtEffect(p138, p139) -- name: _HurtEffect
	-- upvalues: (copy) v_u_9, (copy) v_u_7
	local v140 = p139[utf8.char(0)] or 0
	if math.abs(v140) < 0.001 then
		return
	else
		if p139[utf8.char(1)] and (not p138._is_hidden and p138._headshot_particles) then
			v_u_9:PlayParticles(p138._headshot_particles)
		end
		if #v_u_7:GetSmokeCloudsInSphere(p138.RootPart.Position) > 0 then
			return
		else
			p138._hurt_effect_hash = p138._hurt_effect_hash + 1
			local v141 = p138._hurt_effect_hash
			if p138.Model.Parent then
				p138._model_original_parent_hurt_effect = p138._model_original_parent_hurt_effect or p138.Model.Parent
				p138.Model.Parent = workspace.HurtEffect
				workspace.HurtEffect:SetAttribute("PlayHurtEffect", workspace.HurtEffect:GetAttribute("PlayHurtEffect") + 1)
				wait(1)
				if p138._hurt_effect_hash == v141 and p138.Model.Parent then
					p138.Model.Parent = p138._model_original_parent_hurt_effect
					p138._model_original_parent_hurt_effect = nil
				end
			else
				return
			end
		end
	end
end
function v_u_20._PotentialHitboxAdded(p_u_142, p_u_143) -- name: _PotentialHitboxAdded
	-- upvalues: (copy) v_u_2
	if p_u_143:IsA("BasePart") then
		local function v148() -- name: check
			-- upvalues: (copy) p_u_142, (copy) p_u_143, (ref) v_u_2
			local v144 = table.find(p_u_142._hitboxes_small, p_u_143)
			local v145 = table.find(p_u_142._hitboxes, p_u_143)
			if v144 then
				table.remove(p_u_142._hitboxes_small, v144)
			end
			if v145 then
				table.remove(p_u_142._hitboxes, v145)
			end
			if v_u_2:HasTag(p_u_143, "EntityHitbox") then
				local v146
				if p_u_143:GetAttribute("IsSmallHitbox") then
					v146 = p_u_142._hitboxes_small
				else
					v146 = p_u_142._hitboxes
				end
				local v147 = p_u_143
				table.insert(v146, v147)
			end
		end
		p_u_143:GetAttributeChangedSignal("EntityHitboxUpdate"):Connect(v148)
		v148()
	end
end
function v_u_20._Setup(p_u_149) -- name: _Setup
	if p_u_149.Model then
		p_u_149.Model.DescendantAdded:Connect(function(p150)
			-- upvalues: (copy) p_u_149
			p_u_149:_PotentialHitboxAdded(p150)
		end)
		for _, v151 in pairs(p_u_149.Model:GetDescendants()) do
			p_u_149:_PotentialHitboxAdded(v151)
		end
	end
end
function v_u_20._Init(p_u_152) -- name: _Init
	p_u_152.Died:Connect(function()
		-- upvalues: (copy) p_u_152
		p_u_152.HealthChanged:Fire()
		p_u_152:_UpdatePermafrostSlowStacks()
	end)
	p_u_152:GetDataChangedSignal("IsInvincible"):Connect(function()
		-- upvalues: (copy) p_u_152
		p_u_152:_UpdateInvincibilityVisual()
	end)
	p_u_152:GetDataChangedSignal("ReplicatedExternalGameplayData"):Connect(function()
		-- upvalues: (copy) p_u_152
		p_u_152:_UpdatePermafrostSlowStacks()
	end)
	p_u_152:_Setup()
	p_u_152:_UpdateInvincibilityVisual()
	task.defer(p_u_152._UpdatePermafrostSlowStacks, p_u_152)
end
return v_u_20