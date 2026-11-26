local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = require(v1.Modules.DuelLibrary)
local v_u_3 = {}
v_u_3.__index = v_u_3
function v_u_3.new(p4) -- name: new
	-- upvalues: (copy) v_u_3
	local v5 = v_u_3
	local v6 = setmetatable({}, v5)
	v6.ClientDuel = p4
	v6:_Init()
	return v6
end
function v_u_3.Destroy(_) -- name: Destroy end
function v_u_3._Highlight(p7) -- name: _Highlight
	-- upvalues: (copy) v_u_2
	if p7.ClientDuel.LocalDueler and p7.ClientDuel:Get("IsSpectating") then
		local v8 = p7.ClientDuel:Get("QueueName")
		if v8 and (v_u_2.MatchmakingQueues[v8] and v_u_2.MatchmakingQueues[v8].TitleName == "Beginner") then
			for _, v9 in pairs(p7.ClientDuel.Duelers) do
				if not v9.ClientFighter or (not v9.ClientFighter.Entity or p7.ClientDuel.LocalDueler:Get("TeamID") and p7.ClientDuel.LocalDueler:Get("TeamID") == v9:Get("TeamID")) then
					continue
				end
				v9.ClientFighter.Entity:SetRedFigureMode(true, true)
			end
		end
	else
		return
	end
end
function v_u_3._Init(p_u_10) -- name: _Init
	p_u_10.ClientDuel:GetDataChangedSignal("IsSpectating"):Connect(function()
		-- upvalues: (copy) p_u_10
		p_u_10:_Highlight()
	end)
	p_u_10.ClientDuel:GetDataChangedSignal("Status"):Connect(function()
		-- upvalues: (copy) p_u_10
		if p_u_10.ClientDuel:Get("Status") == "RoundStarted" or p_u_10.ClientDuel:Get("Status") == "RoundStarting" then
			p_u_10:_Highlight()
		end
	end)
	task.defer(p_u_10._Highlight, p_u_10)
end
return v_u_3