local v1 = game:GetService("ReplicatedStorage")
local v2 = game:GetService("Players")
local v_u_3 = require(v1.Modules.Utility)
local v_u_4 = require(v2.LocalPlayer.PlayerScripts.Modules.ClientReplicatedClasses.ClientEntity.ClientHumanoidEntity.ClientEnemy)
local v_u_5 = setmetatable({}, v_u_4)
v_u_5.__index = v_u_5
function v_u_5.new(...) -- name: new
	-- upvalues: (copy) v_u_4, (copy) v_u_5
	local v6 = v_u_4.new(...)
	local v7 = v_u_5
	local v8 = setmetatable(v6, v7)
	v8:_Init()
	return v8
end
function v_u_5.ReplicateFromServer(p9, p10, ...) -- name: ReplicateFromServer
	-- upvalues: (copy) v_u_3, (copy) v_u_4
	if p10 == "HunterLeapEffect" then
		if p9:IsRendered() then
			p9:_PlayAnimation("rbxassetid://89570876299263", 0, nil, 3)
			v_u_3:CreateSound("rbxassetid://118467983008802", 1, 1 + 0.25 * math.random(), p9.RootPart, true, 10)
		end
	else
		v_u_4.ReplicateFromServer(p9, p10, ...)
		return
	end
end
function v_u_5._Init(_) -- name: _Init end
return v_u_5