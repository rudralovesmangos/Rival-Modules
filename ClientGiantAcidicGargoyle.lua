local v1 = game:GetService("ReplicatedStorage")
local v2 = game:GetService("Players")
local v_u_3 = require(v1.Modules.BetterDebris)
local v_u_4 = require(v1.Modules.Utility)
local v_u_5 = require(v2.LocalPlayer.PlayerScripts.Controllers.CameraController)
local v_u_6 = require(v2.LocalPlayer.PlayerScripts.Modules.ClientReplicatedClasses.ClientEntity.ClientHumanoidEntity.ClientEnemy)
local v_u_7 = v2.LocalPlayer.PlayerScripts.Assets.Misc.AcidExplosionParticles
local v_u_8 = setmetatable({}, v_u_6)
v_u_8.__index = v_u_8
function v_u_8.new(...) -- name: new
	-- upvalues: (copy) v_u_6, (copy) v_u_8
	local v9 = v_u_6.new(...)
	local v10 = v_u_8
	local v11 = setmetatable(v9, v10)
	v11:_Init()
	return v11
end
function v_u_8.ReplicateFromServer(p12, p13, ...) -- name: ReplicateFromServer
	-- upvalues: (copy) v_u_4, (copy) v_u_5, (copy) v_u_7, (copy) v_u_3, (copy) v_u_6
	if p13 == "FutileIntro" then
		if p12:IsRendered() then
			p12:_PlayAnimation("rbxassetid://122946493954520")
			wait(7.45)
			v_u_4:CreateSound("rbxassetid://129922197154277", 1.5, 0.875 + 0.25 * math.random(), p12.RootPart, true, 10)
			v_u_5:ShakeOnce(50, 10, 0.1, 0.4, Vector3.new(0.25, 0.25, 0), Vector3.new(0, 0, 0))
		end
	elseif p13 == "AcidSlam" then
		if p12:IsRendered() then
			wait(... - 0.55)
			p12:_PlayAnimation("rbxassetid://85325408755364")
			wait(0.55)
			v_u_4:CreateSound("rbxassetid://129922197154277", 1.5, 0.875 + 0.25 * math.random(), p12.RootPart, true, 10)
			v_u_5:ShakeOnce(50, 10, 0.1, 0.4, Vector3.new(0.25, 0.25, 0), Vector3.new(0, 0, 0))
		end
	elseif p13 == "AcidExplosion" then
		if p12:IsRendered() then
			local v14, v15 = ...
			local v16 = v_u_7:Clone()
			v16.CFrame = CFrame.new(v14) + Vector3.new(0, 1, 0) * v15 * 0.4
			v16.Parent = workspace
			v_u_3:AddItem(v16, 10)
			for _, v17 in pairs(v16:GetDescendants()) do
				if not v17:IsA("ParticleEmitter") then
					continue
				end
				v_u_4:ScaleParticleEmitter(v17, v15 / 4)
			end
			v_u_4:PlayParticles(v16)
			v_u_4:CreateSound("rbxassetid://79150386787758", 1, 1 + 0.1 * math.random(), v16, true, 10)
			v_u_4:CreateSound("rbxassetid://125902611007483", 0.8, 1 + 0.1 * math.random(), v16, true, 10)
		end
	else
		v_u_6.ReplicateFromServer(p12, p13, ...)
		return
	end
end
function v_u_8._Init(_) -- name: _Init end
return v_u_8