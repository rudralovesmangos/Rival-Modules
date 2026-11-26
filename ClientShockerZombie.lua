local v1 = game:GetService("ReplicatedStorage")
local v2 = game:GetService("Players")
local v_u_3 = require(v1.Modules.BetterDebris)
local v_u_4 = require(v1.Modules.Utility)
local v_u_5 = require(v2.LocalPlayer.PlayerScripts.Modules.ClientReplicatedClasses.ClientEntity.ClientHumanoidEntity.ClientEnemy)
local v_u_6 = v2.LocalPlayer.PlayerScripts.Assets.Misc.ShockerZombieZapEffect.Attachment
local v_u_7 = { "rbxassetid://95537657751620", "rbxassetid://79660414273289" }
local v_u_8 = setmetatable({}, v_u_5)
v_u_8.__index = v_u_8
function v_u_8.new(...) -- name: new
	-- upvalues: (copy) v_u_5, (copy) v_u_8
	local v9 = v_u_5.new(...)
	local v10 = v_u_8
	local v11 = setmetatable(v9, v10)
	v11:_Init()
	return v11
end
function v_u_8.ReplicateFromServer(p12, p13, ...) -- name: ReplicateFromServer
	-- upvalues: (copy) v_u_4, (copy) v_u_7, (copy) v_u_3, (copy) v_u_6, (copy) v_u_5
	if p13 == "DinkEffect" then
		if p12:IsRendered() then
			v_u_4:CreateSound(v_u_7[math.random(1, #v_u_7)], 0.625 + 0.25 * math.random(), 1 + 0.5 * math.random(), p12.RootPart, true, 10)
			local v14 = v_u_4
			local v15 = p12.Model:FindFirstChild("Head")
			if v15 then
				v15 = p12.Model.Head:FindFirstChild("DinkVFX")
			end
			v14:PlayParticles(v15)
		end
	elseif p13 == "ShockerZombieZap" then
		if p12:IsRendered() then
			local v16 = ...
			if v16 then
				v_u_4:CreateSound("rbxassetid://125973620031504", 0.375, 1 + 0.25 * math.random(), v16, true, 10)
				local v17 = Instance.new("Attachment")
				v17.Parent = v16
				v_u_3:AddItem(v17, 0.2)
				local v18 = v_u_6:Clone()
				v18.Beam1.Attachment1 = v17
				v18.Beam2.Attachment1 = v17
				v18.Parent = p12.Model.Appearance.Head.ContainsParticles:FindFirstChild("ZapStart")
				v_u_3:AddItem(v18, 0.2)
			end
		else
			return
		end
	else
		v_u_5.ReplicateFromServer(p12, p13, ...)
		return
	end
end
function v_u_8._Init(_) -- name: _Init end
return v_u_8