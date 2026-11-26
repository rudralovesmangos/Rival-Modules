local v1 = game:GetService("ReplicatedStorage")
local v2 = game:GetService("Players")
local v_u_3 = require(v1.Modules.Utility)
local v_u_4 = require(v2.LocalPlayer.PlayerScripts.Modules.ClientReplicatedClasses.ClientEntity.ClientHumanoidEntity.ClientEnemy)
local v_u_5 = { "rbxassetid://95537657751620", "rbxassetid://79660414273289" }
local v_u_6 = setmetatable({}, v_u_4)
v_u_6.__index = v_u_6
function v_u_6.new(...) -- name: new
	-- upvalues: (copy) v_u_4, (copy) v_u_6
	local v7 = v_u_4.new(...)
	local v8 = v_u_6
	local v9 = setmetatable(v7, v8)
	v9._charge_hash = 0
	v9._charge_animation_tracks = {}
	v9:_Init()
	return v9
end
function v_u_6.ReplicateFromServer(p_u_10, p11, ...) -- name: ReplicateFromServer
	-- upvalues: (copy) v_u_3, (copy) v_u_5, (copy) v_u_4
	if p11 == "ChargerZombieChargeStart" then
		if p_u_10:IsRendered() then
			local v_u_12 = ...
			p_u_10._charge_hash = p_u_10._charge_hash + 1
			local v_u_13 = p_u_10._charge_hash
			local v14 = p_u_10._charge_animation_tracks
			table.insert(v14, p_u_10:_PlayAnimation("rbxassetid://89451767520037", 0))
			task.spawn(function()
				-- upvalues: (copy) p_u_10, (copy) v_u_13, (ref) v_u_3
				wait(0.4)
				if p_u_10._charge_hash == v_u_13 then
					v_u_3:CreateSound("rbxassetid://104718122128210", 0.5, 0.75 + 0.125 * math.random(), p_u_10.RootPart, true, 10)
					v_u_3:CreateSound("rbxassetid://129922197154277", 1, 0.875 + 0.25 * math.random(), p_u_10.RootPart, true, 10)
					wait(3.05)
					if p_u_10._charge_hash == v_u_13 then
						local v15 = p_u_10._charge_animation_tracks
						local v16 = p_u_10
						table.insert(v15, v16:_PlayAnimation("rbxassetid://81364239879886", 0))
					end
				else
					return
				end
			end)
			task.spawn(function()
				-- upvalues: (copy) v_u_12, (ref) v_u_3, (copy) p_u_10
				wait(0.6)
				for _ = 0, v_u_12 - 0.6, 0.2 do
					v_u_3:CreateSound("rbxassetid://76804323076444", 0.75 + 0.25 * math.random(), 0.875 + 0.25 * math.random(), p_u_10.RootPart, true, 10)
					wait(0.2)
				end
			end)
			wait(v_u_12)
			if p_u_10._charge_hash == v_u_13 then
				p_u_10._charge_hash = p_u_10._charge_hash + 1
				p_u_10:_StopChargingAnimationTracks()
				p_u_10:_PlayAnimation("rbxassetid://114972482950857")
			end
		else
			return
		end
	elseif p11 == "ChargerZombieChargeImpact" then
		if p_u_10:IsRendered() then
			p_u_10._charge_hash = p_u_10._charge_hash + 1
			p_u_10:_StopChargingAnimationTracks()
			p_u_10:_PlayAnimation("rbxassetid://102061691949401", 0)
		end
	elseif p11 == "DinkEffect" then
		if p_u_10:IsRendered() then
			v_u_3:CreateSound(v_u_5[math.random(1, #v_u_5)], 0.625 + 0.25 * math.random(), 1 + 0.5 * math.random(), p_u_10.RootPart, true, 10)
			local v17 = v_u_3
			local v18 = p_u_10.Model:FindFirstChild("Head")
			if v18 then
				v18 = p_u_10.Model.Head:FindFirstChild("DinkVFX")
			end
			v17:PlayParticles(v18)
		end
	else
		v_u_4.ReplicateFromServer(p_u_10, p11, ...)
		return
	end
end
function v_u_6.Destroy(p19) -- name: Destroy
	-- upvalues: (copy) v_u_4
	p19._charge_hash = p19._charge_hash + 1
	v_u_4.Destroy(p19)
end
function v_u_6._StopChargingAnimationTracks(p20) -- name: _StopChargingAnimationTracks
	for _, v21 in pairs(p20._charge_animation_tracks) do
		v21:Stop()
	end
	p20._charge_animation_tracks = {}
end
function v_u_6._Init(_) -- name: _Init end
return v_u_6