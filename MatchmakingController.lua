local v_u_1 = game:GetService("ReplicatedStorage")
local v2 = game:GetService("Players")
local v_u_3 = require(v_u_1.Modules.CONSTANTS)
local v_u_4 = require(v_u_1.Modules.ReplicatedClass)
local v_u_5 = require(v_u_1.Modules.Signal)
local v_u_6 = require(v2.LocalPlayer.PlayerScripts.Controllers.PlayerDataController)
local v_u_7 = {
	"ServerRegion",
	"MatchmadeStatus",
	"MatchmadeExpectedPlayers",
	"MatchmadeConnectedPlayers",
	"MatchmadeGameOver",
	"MatchmadeCountdown",
	"MatchmadeRematchAvailable",
	"MatchmadeRematchCount",
	"MatchmadeRematchGoal",
	"MatchmadeRematchSuccess"
}
local v_u_8 = setmetatable({}, v_u_4)
v_u_8.__index = v_u_8
function v_u_8._new() -- name: _new
	-- upvalues: (copy) v_u_4, (copy) v_u_8, (copy) v_u_5
	local v9 = v_u_4.new()
	local v10 = v_u_8
	local v11 = setmetatable(v9, v10)
	v11.MatchmadeDuelEnded = v_u_5.new()
	v11.RematchDetailsChanged = v_u_5.new()
	v11:_Init()
	return v11
end
function v_u_8.IsMatchmadeDuelOver(p12) -- name: IsMatchmadeDuelOver
	-- upvalues: (copy) v_u_3
	local v13 = v_u_3.IS_MATCHMAKING_SERVER
	if v13 then
		v13 = p12:Get("MatchmadeGameOver")
	end
	return v13
end
function v_u_8.IsRematchAvailable(p14) -- name: IsRematchAvailable
	local v15 = not p14:Get("MatchmadeRematchSuccess") and (p14:Get("MatchmadeRematchCount") and p14:Get("MatchmadeRematchGoal"))
	if v15 then
		v15 = p14:Get("MatchmadeRematchAvailable")
	end
	return v15
end
function v_u_8.QueueInto(_, p16) -- name: QueueInto
	-- upvalues: (copy) v_u_1
	return v_u_1.Remotes.Matchmaking.JoinQueue:InvokeServer(p16)
end
function v_u_8.TryLeaveQueue(_) -- name: TryLeaveQueue
	-- upvalues: (copy) v_u_1
	v_u_1.Remotes.Matchmaking.TryLeaveQueue:FireServer()
end
function v_u_8._OnboardingQueue(p17) -- name: _OnboardingQueue
	-- upvalues: (copy) v_u_3, (copy) v_u_6
	if not v_u_3.IS_STUDIO and (not v_u_3.IS_PRIVATE_HUB_SERVER and v_u_6:GetStatistic("StatisticDuelsPlayed") <= 0) then
		p17:QueueInto(v_u_3.BEGINNER_QUEUE_NAME)
	end
end
function v_u_8._Setup(p_u_18) -- name: _Setup
	-- upvalues: (copy) v_u_7
	for _, v_u_19 in pairs(v_u_7) do
		local v_u_20 = string.find(v_u_19, "Rematch")
		workspace:GetAttributeChangedSignal(v_u_19):Connect(function()
			-- upvalues: (copy) p_u_18, (copy) v_u_19, (copy) v_u_20
			p_u_18:SetReplicate(v_u_19, workspace:GetAttribute(v_u_19))
			if v_u_20 then
				p_u_18.RematchDetailsChanged:Fire()
			end
		end)
		p_u_18:SetReplicate(v_u_19, workspace:GetAttribute(v_u_19))
	end
end
function v_u_8._Init(p_u_21) -- name: _Init
	p_u_21:GetDataChangedSignal("MatchmadeGameOver"):Connect(function()
		-- upvalues: (copy) p_u_21
		p_u_21.MatchmadeDuelEnded:Fire()
	end)
	p_u_21:_Setup()
	task.defer(p_u_21._OnboardingQueue, p_u_21)
end
return v_u_8._new()