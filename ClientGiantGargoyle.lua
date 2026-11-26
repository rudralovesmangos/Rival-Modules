local v1 = game:GetService("ReplicatedStorage")
local v2 = game:GetService("Players")
local v_u_3 = require(v1.Modules.Utility)
local v_u_4 = require(v2.LocalPlayer.PlayerScripts.Controllers.CameraController)
local v_u_5 = require(v2.LocalPlayer.PlayerScripts.Modules.ClientReplicatedClasses.ClientEntity.ClientHumanoidEntity.ClientEnemy)
local v_u_6 = setmetatable({}, v_u_5)
v_u_6.__index = v_u_6
function v_u_6.new(...) -- name: new
	-- upvalues: (copy) v_u_5, (copy) v_u_6
	local v7 = v_u_5.new(...)
	local v8 = v_u_6
	local v9 = setmetatable(v7, v8)
	v9:_Init()
	return v9
end
function v_u_6.ReplicateFromServer(p_u_10, p11, ...) -- name: ReplicateFromServer
	-- upvalues: (copy) v_u_3, (copy) v_u_4, (copy) v_u_5
	if p11 == "FlightIntro" then
		if p_u_10:IsRendered() then
			p_u_10:_PlayAnimation("rbxassetid://91697782514164")
		end
	elseif p11 == "ClawAttack" then
		if p_u_10:IsRendered() then
			p_u_10:_PlayAnimation("rbxassetid://83924855123571")
			task.delay(0.7, function()
				-- upvalues: (ref) v_u_3, (copy) p_u_10
				v_u_3:CreateSound("rbxassetid://128361063555965", 2.25 + 0.25 * math.random(), 1.25 + 0.2 * math.random(), p_u_10.RootPart, true, 10)
			end)
			wait((...))
			v_u_3:CreateSound("rbxassetid://134852748577803", 2, 0.75 + 0.25 * math.random(), p_u_10.RootPart, true, 10)
			v_u_4:ShakeOnce(25, 10, 0.1, 0.4, Vector3.new(0.25, 0.25, 0), Vector3.new(0, 0, 0))
		end
	else
		v_u_5.ReplicateFromServer(p_u_10, p11, ...)
		return
	end
end
function v_u_6._Init(_) -- name: _Init end
return v_u_6