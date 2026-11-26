local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("Players")
local v_u_3 = require(v1.Modules.CONSTANTS)
local v_u_4 = require(v1.Modules.ReplicatedClass)
local v_u_5 = require(v1.Modules.SeasonLibrary)
local v_u_6 = require(v1.Modules.Signal)
local v_u_7 = require(v_u_2.LocalPlayer.PlayerScripts.Controllers.SpectateController)
local v_u_8 = require(v_u_2.LocalPlayer.PlayerScripts.Controllers.FighterController)
local v_u_9 = require(v_u_2.LocalPlayer.PlayerScripts.Modules.UserInterface.Pages)
local v_u_10 = require(script:WaitForChild("DuelInterface"))
local v_u_11 = require(script:WaitForChild("BeginnerDuel"))
local v_u_12 = require(script:WaitForChild("ChickenGame"))
local v_u_13 = require(script:WaitForChild("ClientMap"))
local v_u_14 = v_u_2.LocalPlayer.PlayerScripts.Modules.Maps
local v_u_15 = setmetatable({}, v_u_4)
v_u_15.__index = v_u_15
function v_u_15.new(p16) -- name: new
	-- upvalues: (copy) v_u_4, (copy) v_u_15, (copy) v_u_6, (copy) v_u_10, (copy) v_u_5, (copy) v_u_12, (copy) v_u_11
	local v17 = v_u_4.new(p16)
	local v18 = v_u_15
	local v19 = setmetatable(v17, v18)
	v19.DuelerAdded = v_u_6.new()
	v19.DuelerRemoved = v_u_6.new()
	v19.MapAdded = v_u_6.new()
	v19.SpectateThisPlayer = v_u_6.new()
	v19.Duelers = {}
	v19.Map = nil
	v19.DuelInterface = v_u_10.new(v19)
	v19.LocalDueler = nil
	v19.IsRanked = v_u_5:IsRankedQueue(v19:Get("QueueName"))
	v19.ChickenGame = v_u_12.new(v19)
	v19.BeginnerDuel = v_u_11.new(v19)
	v19.Data.IsSpectating = false
	v19.Data.LastRoundStartingStatus = nil
	v19.Data.DuelMusic = nil
	v19._temp_serial = p16
	v19._connections = {}
	v19._client_fighters = {}
	v19._duelers_by_player = {}
	v19:_Init()
	return v19
end
function v_u_15.IsRendered(p20) -- name: IsRendered
	-- upvalues: (copy) v_u_3, (copy) v_u_7
	return v_u_3.SHOULD_ALWAYS_REPLICATE() or p20.LocalDueler or p20 == v_u_7.CurrentDuelSubject
end
function v_u_15.CanLeave(p21) -- name: CanLeave
	-- upvalues: (copy) v_u_9
	if v_u_9.PageSystem.CurrentPage then
		return false
	else
		return p21:Get("IsCurrentArcadeDuel") or p21:Get("RoundNum") > 1 and p21:Get("Status") == "RoundFinished" and not p21:Get("CanTrackStatistics") or p21:Get("WasSelfQueued")
	end
end
function v_u_15.GetDueler(p22, p23) -- name: GetDueler
	if p22._duelers_by_player[p23] then
		return p22._duelers_by_player[p23]
	end
	for v24, v25 in pairs(p22.Duelers) do
		if v25.Player ~= p23 and v25:Get("ObjectID") ~= p23 then
			continue
		end
		return v25, v24
	end
end
function v_u_15.GetFighters(p26) -- name: GetFighters
	return table.clone(p26._client_fighters)
end
function v_u_15.CountTeam(p27, p28) -- name: CountTeam
	local v29 = 0
	for _, v30 in pairs(p27.Duelers) do
		v29 = v29 + (v30:Get("TeamID") == p28 and 1 or 0)
	end
	return v29
end
function v_u_15.LeaveDuelRequest(p31) -- name: LeaveDuelRequest
	-- upvalues: (copy) v_u_9
	if p31:CanLeave() then
		v_u_9.PageSystem:OpenPage("LeaveDuel", true)
	end
end
function v_u_15.ReplicateFromServer(p32, p33, ...) -- name: ReplicateFromServer
	-- upvalues: (copy) v_u_4
	if p33 == "DuelerAdded" then
		p32:_DuelerAdded(...)
		return
	elseif p33 == "DuelerRemoved" then
		p32:_DuelerRemoved(...)
		return
	elseif p33 == "DuelerChanged" then
		p32:_DuelerChanged(...)
		return
	elseif p33 == "MapAdded" then
		p32:_MapAdded(...)
	elseif p33 == "MapChanged" then
		local v34 = ...
		local v35 = p32:FromEnum(v34) or v34
		if p32.Map then
			p32.Map:ReplicateFromServer(v35, select(2, ...))
			return
		end
	else
		if p33 == "RoundStarting" then
			if p32:IsRendered() then
				local v36, v37 = ...
				local v38 = p32:FromEnum(v37)
				p32:SetReplicate("LastRoundStartingStatus", v38)
				if v38 == "MatchPoint" then
					p32.DuelInterface.MatchPoint:Play(false)
				elseif v38 == "SuddenDeath" then
					p32.DuelInterface.MatchPoint:Play(true)
				end
				p32.DuelInterface.Timer:Set(v36)
			end
		end
		if p33 == "RoundStart" then
			if p32:IsRendered() then
				p32.DuelInterface.Timer:Set(...)
			end
		end
		if p33 == "RoundFinish" then
			if p32:IsRendered() then
				local v39, v40 = ...
				p32.DuelInterface.Timer:Pause(v40)
				p32.DuelInterface.RoundResult:Play(v39)
			end
		end
		if p33 == "FinalResults" then
			if p32:IsRendered() then
				p32.DuelInterface.FinalResults:Play(...)
			end
		end
		if p33 == "Countdown" then
			if p32:IsRendered() then
				p32.DuelInterface.Timer:Set(...)
			end
		end
		if p33 == "ChosenMapEffect" then
			if p32:IsRendered() then
				p32.DuelInterface.Voting:PlayMapChosenEffect(...)
			end
		end
		if p33 == "PauseTimer" then
			if p32:IsRendered() then
				p32.DuelInterface.Timer:Pause(...)
			end
		end
		if p33 == "RespawnNowAnimation" then
			if p32:IsRendered() then
				local v41, v42 = ...
				if p32.LocalDueler and v41 == p32.LocalDueler.Player then
					p32.DuelInterface.Buttons:RespawnNowAnimation(v42)
				end
			else
				return
			end
		end
		if p33 == "ChickenGamesRedLight" then
			if p32:IsRendered() then
				p32.ChickenGame:RedLight(...)
			end
		end
		if p33 == "ChickenGamesGreenLight" then
			if p32:IsRendered() then
				p32.ChickenGame:GreenLight(...)
			end
		end
		if p33 == "ChickenGamesElimination" then
			if p32:IsRendered() then
				p32.ChickenGame:Elimination(...)
			end
		end
		if p33 == "ChickenGamesStop" then
			if p32:IsRendered() then
				p32.ChickenGame:Stop(...)
			end
		end
		if p33 == "TimerStopwatchStarted" then
			if p32:IsRendered() then
				p32.DuelInterface.Timer:StopwatchStart(...)
			end
		end
		if p33 == "TimerStopwatchFinished" then
			if p32:IsRendered() then
				p32.DuelInterface.Timer:StopwatchFinish(...)
			end
		end
		if p33 == "SpectateThisPlayer" then
			if p32:IsRendered() then
				local v43, v44 = ...
				if v43 and v44 then
					p32.SpectateThisPlayer:Fire(v43, v44)
				end
			else
				return
			end
		end
		v_u_4.ReplicateFromServer(p32, p33, ...)
	end
end
function v_u_15.Destroy(p45) -- name: Destroy
	-- upvalues: (copy) v_u_4
	for _, v46 in pairs(p45._connections) do
		v46:Disconnect()
	end
	for _, v47 in pairs(p45.Duelers) do
		v47:Destroy()
	end
	p45._client_fighters = {}
	p45._duelers_by_player = {}
	if p45.Map then
		p45.Map:Destroy()
	end
	p45.DuelInterface:Destroy()
	p45.ChickenGame:Destroy()
	p45.BeginnerDuel:Destroy()
	p45.DuelerAdded:Destroy()
	p45.DuelerRemoved:Destroy()
	p45.MapAdded:Destroy()
	p45.SpectateThisPlayer:Destroy()
	v_u_4.Destroy(p45)
end
function v_u_15._UpdateAllies(p48) -- name: _UpdateAllies
	-- upvalues: (copy) v_u_2
	local v49 = p48:GetDueler(v_u_2.LocalPlayer)
	local v50
	if v49 then
		v50 = v49:Get("TeamID")
	else
		v50 = v49
	end
	for _, v51 in pairs(p48.Duelers) do
		local v52
		if v50 then
			if v51 == v49 then
				v52 = false
			else
				v52 = v50 == v51:Get("TeamID")
			end
		else
			v52 = v50
		end
		v51:SetAlly(v52)
	end
end
function v_u_15._DuelerChanged(p53, p54, p55, ...) -- name: _DuelerChanged
	local v56 = p53:GetDueler(p54)
	if v56 then
		v56:ReplicateFromServer(p53:FromEnum(p55) or p55, ...)
	end
end
function v_u_15._DuelerAdded(p57, p58) -- name: _DuelerAdded
	-- upvalues: (copy) v_u_8, (copy) v_u_4
	if not p57:GetDueler(p58[p57:ToEnum("Data")][p57:ToEnum("ObjectID")]) then
		local v59 = p58[p57:ToEnum("ClientReplicatedClassType")]
		local v60 = v_u_8:WaitForFighter(p58[p57:ToEnum("Player")])
		local v61 = v_u_4:GetReplicatedClass(p57:FromEnum(v59) or v59).new(p58, v60, p57)
		local v62 = p57.Duelers
		table.insert(v62, v61)
		local v63 = p57._client_fighters
		table.insert(v63, v60)
		p57._duelers_by_player[v61.Player] = v61
		local v64
		if v60.IsLocalPlayer then
			v64 = v61
		else
			v64 = p57.LocalDueler
		end
		p57.LocalDueler = v64
		p57.DuelerAdded:Fire(v61)
	end
end
function v_u_15._DuelerRemoved(p65, p66) -- name: _DuelerRemoved
	local v67, v68 = p65:GetDueler(p66)
	if v68 then
		if v67 == p65.LocalDueler then
			p65.LocalDueler = nil
		end
		local v69 = v67.ClientFighter and table.find(p65._client_fighters, v67.ClientFighter)
		if v69 then
			table.remove(p65._client_fighters, v69)
		end
		table.remove(p65.Duelers, v68)
		p65._duelers_by_player[v67.Player] = nil
		p65.DuelerRemoved:Fire(v67)
		v67:Destroy()
	end
end
function v_u_15._MapAdded(p70, p71) -- name: _MapAdded
	-- upvalues: (copy) v_u_14, (copy) v_u_13
	local v72 = p71[p70:ToEnum("Name")]
	p70.Map = (v_u_14:FindFirstChild(v72) and require(v_u_14[v72]) or v_u_13).new(p71, p70)
	p70.MapAdded:Fire(p70.Map)
end
function v_u_15._Setup(p73) -- name: _Setup
	for _, v74 in pairs(p73._temp_serial.Duelers) do
		task.spawn(p73._DuelerAdded, p73, v74)
	end
	if p73._temp_serial.Map then
		task.spawn(p73._MapAdded, p73, p73._temp_serial.Map)
	end
	p73._temp_serial = nil
end
function v_u_15._Init(p_u_75) -- name: _Init
	p_u_75.DuelerAdded:Connect(function()
		-- upvalues: (copy) p_u_75
		p_u_75:_UpdateAllies()
	end)
	p_u_75:_Setup()
	p_u_75:_UpdateAllies()
end
return v_u_15