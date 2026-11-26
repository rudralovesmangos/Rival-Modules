local v1 = game:GetService("ReplicatedStorage")
local v2 = game:GetService("Players")
local v_u_3 = require(v1.Modules.Utility)
local v_u_4 = require(v2.LocalPlayer.PlayerScripts.Modules.ClientReplicatedClasses.ClientEntity.ClientHumanoidEntity.ClientEnemy)
local v_u_5 = { "rbxassetid://135005054893837", "rbxassetid://131160196025684" }
local v_u_6 = setmetatable({}, v_u_4)
v_u_6.__index = v_u_6
function v_u_6.new(...) -- name: new
	-- upvalues: (copy) v_u_4, (copy) v_u_6
	local v7 = v_u_4.new(...)
	local v8 = v_u_6
	local v9 = setmetatable(v7, v8)
	v9:_Init()
	return v9
end
function v_u_6.ReplicateFromServer(p_u_10, p11, ...) -- name: ReplicateFromServer
	-- upvalues: (copy) v_u_3, (copy) v_u_5, (copy) v_u_4
	if p11 == "ZombieReanimation" then
		if p_u_10:IsRendered() then
			local v12 = p_u_10:_PlayAnimation("rbxassetid://116248625896064", 0)
			local v13 = p_u_10:_PlayAnimation("rbxassetid://80790379621135", 0)
			local v14 = p_u_10:_PlayAnimation("rbxassetid://106390578093849", 0)
			v13:Stop(0)
			v14:Stop(0)
			wait(2.4)
			v12:Stop(0)
			v13:Play(0)
			wait(... - 2.4 - 3.4)
			v13:Stop(0)
			v14:Play(0)
			task.spawn(function()
				-- upvalues: (ref) v_u_3, (copy) p_u_10, (ref) v_u_5
				wait(1.65)
				v_u_3:CreateSound("rbxassetid://87428186485980", 0.75 + 0.25 * math.random(), 1 + 0.25 * math.random(), p_u_10.RootPart, true, 10)
				wait(1)
				v_u_3:CreateSound(v_u_5[math.random(#v_u_5)], 0.75 + 0.25 * math.random(), 1 + 0.25 * math.random(), p_u_10.RootPart, true, 10)
			end)
			wait(3.4)
			v14:Stop(0)
		end
	else
		v_u_4.ReplicateFromServer(p_u_10, p11, ...)
		return
	end
end
function v_u_6._Init(_) -- name: _Init end
return v_u_6