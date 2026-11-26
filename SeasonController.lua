local v_u_1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("Players")
require(v_u_1.Modules.CONSTANTS)
local v_u_3 = require(v_u_1.Modules.PlayerDataUtility)
local v_u_4 = require(v_u_1.Modules.SeasonLibrary)
local v_u_5 = require(v_u_1.Modules.Utility)
local v_u_6 = require(v_u_2.LocalPlayer.PlayerScripts.Controllers.PlayerDataController)
local v_u_7 = {}
v_u_7.__index = v_u_7
function v_u_7._new() -- name: _new
	-- upvalues: (copy) v_u_7
	local v8 = v_u_7
	local v9 = setmetatable({}, v8)
	v9._last_update = -1
	v9._time_remaining = nil
	v9:_Init()
	return v9
end
function v_u_7.GetTimeRemaining(p10) -- name: GetTimeRemaining
	if not p10._time_remaining then
		return nil
	end
	local v11 = p10._time_remaining - (tick() - p10._last_update)
	local v12 = math.ceil(v11)
	return math.max(0, v12)
end
function v_u_7.GetCountdownText(p13) -- name: GetCountdownText
	-- upvalues: (copy) v_u_5, (copy) v_u_4
	local v14 = p13:GetTimeRemaining()
	if not v14 then
		return nil
	end
	local v15 = v14 <= 0 and "" or "in "
	local v16 = v14 <= 0 and "ANY SECOND NOW" or v_u_5:TimeFormat2((math.ceil(v14)))
	return string.format("Season %s ends %s<font color=\"rgb(255,50,50)\" weight=\"700\">%s</font>", v_u_4.CurrentSeason.Version, v15, v16)
end
function v_u_7.IsRankedUnlocked(_) -- name: IsRankedUnlocked
	-- upvalues: (copy) v_u_3, (copy) v_u_6, (copy) v_u_2
	return v_u_3:IsRankedUnlocked(v_u_6, v_u_2.LocalPlayer)
end
function v_u_7._UpdateTimer(p17, p18) -- name: _UpdateTimer
	p17._last_update = tick()
	p17._time_remaining = p18
end
function v_u_7._Fetch(p19) -- name: _Fetch
	-- upvalues: (copy) v_u_1
	p19:_UpdateTimer(v_u_1.Remotes.Misc.RequestSeasonTimer:InvokeServer())
end
function v_u_7._Init(p_u_20) -- name: _Init
	-- upvalues: (copy) v_u_1
	v_u_1.Remotes.Misc.UpdateSeasonTimer.OnClientEvent:Connect(function(p21)
		-- upvalues: (copy) p_u_20
		p_u_20:_UpdateTimer(p21)
	end)
	task.defer(p_u_20._Fetch, p_u_20)
end
return v_u_7._new()