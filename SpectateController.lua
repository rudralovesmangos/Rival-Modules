local v_u_1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("UserInputService")
game:GetService("StarterGui")
local v_u_3 = game:GetService("RunService")
local v_u_4 = game:GetService("Players")
local v_u_5 = require(v_u_1.Modules.CONSTANTS)
local v_u_6 = require(v_u_1.Modules.InputLibrary)
local v_u_7 = require(v_u_1.Modules.Signal)
local v_u_8 = require(v_u_4.LocalPlayer.PlayerScripts.Controllers.FighterController)
local v_u_9 = require(v_u_4.LocalPlayer.PlayerScripts.Controllers.CameraController)
local v_u_10 = require(v_u_4.LocalPlayer.PlayerScripts.Controllers.DuelController)
local v_u_11 = require(v_u_4.LocalPlayer.PlayerScripts.Modules.UserInterface.Teleporting)
local v_u_12 = require(v_u_4.LocalPlayer.PlayerScripts.Modules.UserInterface.Queue)
local v_u_13 = {}
v_u_13.__index = v_u_13
function v_u_13._new() -- name: _new
	-- upvalues: (copy) v_u_13, (copy) v_u_7
	local v14 = v_u_13
	local v15 = setmetatable({}, v14)
	v15.SubjectChanged = v_u_7.new()
	v15.SubjectEmoteStatusChanged = v_u_7.new()
	v15.DuelSubjectChanged = v_u_7.new()
	v15.DuelSubjectEnvironmentIDChanged = v_u_7.new()
	v15.DuelSubjectStatusChanged = v_u_7.new()
	v15.Subjects = {}
	v15.CurrentSubject = nil
	v15.CurrentDuelSubject = nil
	v15._duel_connections = {}
	v15._subject_connections = {}
	v15._last_spectating_user_id = nil
	v15._spectate_duel_request_queue = {}
	v15._spectate_duel_request_queue_active = false
	v15._duel_just_spectated = {}
	v15._firing_subject_changed = nil
	v15._process_mb2_on_input_ended_delta = nil
	v15:_Init()
	return v15
end
function v_u_13.IsRendered(p16, p17) -- name: IsRendered
	-- upvalues: (copy) v_u_5, (copy) v_u_4
	local v18 = not v_u_5.IS_ARCADE_SERVER and (v_u_4.LocalPlayer:GetAttribute("EnvironmentID") ~= p17 and p16.CurrentDuelSubject)
	if v18 then
		v18 = p16.CurrentDuelSubject:Get("EnvironmentID") == p17
	end
	return v18
end
function v_u_13.IsSubjectEmoting(p19) -- name: IsSubjectEmoting
	local v20 = p19.CurrentSubject and p19.CurrentSubject.Entity
	if v20 then
		v20 = p19.CurrentSubject.Entity:IsEmoting()
	end
	return v20
end
function v_u_13.IsThereValidSubject(p21, p22) -- name: IsThereValidSubject
	for _, v23 in pairs(p21.Subjects) do
		if v23 == p22 or not p21:_IsValidSubject(v23) then
			continue
		end
		return true
	end
	return false
end
function v_u_13.Increment(p24, p25) -- name: Increment
	if p24.CurrentDuelSubject and not (p24.CurrentSubject and p24.CurrentSubject.IsLocalPlayer) then
		if p24:IsThereValidSubject(p24.CurrentSubject) then
			local v26 = p24.CurrentSubject and (table.find(p24.Subjects, p24.CurrentSubject) or 0) or 0
			local v27
			if v26 or p25 ~= 1 then
				if v26 or p25 ~= -1 then
					if p25 == 1 and v26 == #p24.Subjects then
						v27 = 1
					elseif p25 == -1 and v26 == 1 then
						v27 = #p24.Subjects
					else
						v27 = v26 + p25
					end
				else
					v27 = #p24.Subjects
				end
			else
				v27 = 1
			end
			p24:_RawSetCurrentSubject(p24.Subjects[v27])
			p24:_VerifySubject(p25 == -1)
		end
	else
		return
	end
end
function v_u_13.Next(p28) -- name: Next
	p28._duel_just_spectated = {}
	p28:Increment(1)
end
function v_u_13.Last(p29) -- name: Last
	p29._duel_just_spectated = {}
	p29:Increment(-1)
end
function v_u_13.Exit(p30) -- name: Exit
	if p30.CurrentDuelSubject and not p30.CurrentDuelSubject.LocalDueler then
		p30:SpectateDuelRequest(nil)
	end
end
function v_u_13.SpectateDuelRequest(p_u_31, p32) -- name: SpectateDuelRequest
	-- upvalues: (copy) v_u_12, (copy) v_u_10, (copy) v_u_4, (copy) v_u_1
	if not p32 or (p32.LocalDueler or not v_u_12:IsVisible() and p32:Get("Status") ~= "GameOver") then
		local v33 = v_u_10:GetDuel(v_u_4.LocalPlayer) or p32
		local v34 = p_u_31._spectate_duel_request_queue
		table.insert(v34, { v33 })
		task.spawn(function()
			-- upvalues: (copy) p_u_31, (ref) v_u_1
			if not p_u_31._spectate_duel_request_queue_active then
				p_u_31._spectate_duel_request_queue_active = true
				while #p_u_31._spectate_duel_request_queue > 0 do
					local v35 = table.remove(p_u_31._spectate_duel_request_queue, 1)
					local v36 = p_u_31.CurrentDuelSubject and p_u_31.CurrentDuelSubject:Get("ObjectID") or nil
					local v37 = v35[1] and v35[1]:Get("ObjectID") or nil
					if v37 == v36 then
						continue
					end
					v_u_1.Remotes.Replication.Fighter.SpectateDuel:FireServer(v37)
					wait(1)
				end
				p_u_31._spectate_duel_request_queue = {}
				p_u_31._spectate_duel_request_queue_active = false
			end
		end)
	end
end
function v_u_13.Update(p38, p39) -- name: Update
	-- upvalues: (copy) v_u_8, (copy) v_u_5
	local v40 = p38.CurrentDuelSubject and p38.CurrentDuelSubject:GetFighters() or v_u_8:GetFightersNotInDuel()
	if v_u_8.LocalFighter and not table.find(v40, v_u_8.LocalFighter) then
		local v41 = v_u_8.LocalFighter
		table.insert(v40, v41)
	end
	local v42 = {}
	for _, v43 in pairs(v40) do
		if v42[v43.Player] then
			continue
		end
		v42[v43.Player] = true
		if v_u_5.IS_TESTING_SERVER then
			v43:Update(p39)
		else
			local v44 = v43.Update
			local v45, v46 = pcall(v44, v43, p39)
			if v45 then
				continue
			end
			warn("ClientFighter::Update errored:", v46)
		end
	end
end
function v_u_13._IsValidSubject(p47, p48) -- name: _IsValidSubject
	-- upvalues: (copy) v_u_9
	if v_u_9:GetPublicState() == v_u_9.CameraState.States.CustomFreecam then
		return false
	end
	if not (p48 and p48:IsAlive()) then
		return false
	end
	if p47.CurrentDuelSubject and not table.find(p47.CurrentDuelSubject:GetFighters(), p48) then
		return false
	end
	if not (p47.CurrentDuelSubject and p47.CurrentDuelSubject.LocalDueler) then
		return true
	end
	if p47.CurrentDuelSubject and (p47.CurrentDuelSubject.LocalDueler and p47.CurrentDuelSubject.LocalDueler:IsAlive()) then
		return p48 == p47.CurrentDuelSubject.LocalDueler.ClientFighter
	end
	local v49 = p47.CurrentDuelSubject.LocalDueler:Get("TeamID")
	if not v49 then
		return true
	end
	if p47.CurrentDuelSubject:Get("IsCurrentArcadeDuel") then
		return true
	end
	local v50 = false
	for _, v51 in pairs(p47.CurrentDuelSubject.Duelers) do
		if v51:Get("TeamID") ~= v49 or not v51:IsAlive() then
			continue
		end
		v50 = true
	end
	return (not p47.CurrentDuelSubject:Get("StaggeredSpawns") or p47.CurrentDuelSubject:Get("Status") == "RoundFinished") and not v50 and true or p48:Get("TeamID") == v49
end
function v_u_13._RawSetCurrentSubject(p52, p53) -- name: _RawSetCurrentSubject
	if p53 ~= p52.CurrentSubject then
		for _, v54 in pairs(p52._subject_connections) do
			v54:Disconnect()
		end
		p52._subject_connections = {}
		if p52.CurrentSubject then
			p52.CurrentSubject:SetReplicate("IsSpectating", false)
			if p52.CurrentDuelSubject and p52.CurrentSubject.Player then
				p52._duel_just_spectated[p52.CurrentSubject.Player] = tick()
			end
		end
		p52.CurrentSubject = p53
		p52.SubjectChanged:FireDeferred()
		if p52.CurrentSubject then
			p52.CurrentSubject:SetReplicate("IsSpectating", true)
		end
	end
end
function v_u_13._VerifySubject(p_u_55, p56) -- name: _VerifySubject
	local v57 = p_u_55.CurrentSubject and (table.find(p_u_55.Subjects, p_u_55.CurrentSubject) or 1) or 1
	local v58 = p56 and -1 or 1
	local v59 = nil
	for v60 = 1, #p_u_55.Subjects do
		local v61 = (v57 + (v60 - 1) * v58 - 1) % #p_u_55.Subjects + 1
		local v62 = p_u_55.Subjects[v61]
		if not p_u_55:_IsValidSubject(v62) then
			continue
		end
		v59 = v62
	end
	if v59 == p_u_55.CurrentSubject then
		return
	else
		p_u_55:_RawSetCurrentSubject(v59)
		if p_u_55.CurrentSubject then
			local function v63() -- name: verify_subject
				-- upvalues: (copy) p_u_55
				p_u_55:_VerifySubject()
			end
			local v64 = p_u_55._subject_connections
			local v65 = p_u_55.CurrentSubject.EntityRemoved
			table.insert(v64, v65:Connect(v63))
			local v66 = p_u_55._subject_connections
			local v67 = p_u_55.CurrentSubject.EntityAdded
			table.insert(v66, v67:Connect(v63))
			local v68 = p_u_55._subject_connections
			local v69 = p_u_55.CurrentSubject.Died
			table.insert(v68, v69:Connect(v63))
			local v70 = p_u_55._subject_connections
			local v71 = p_u_55.CurrentSubject.EntityAdded
			table.insert(v70, v71:Connect(function(p72) -- name: entity_added
				-- upvalues: (copy) p_u_55
				local v73 = p_u_55._subject_connections
				local v74 = p72.EmoteStatusChanged
				local function v75()
					-- upvalues: (ref) p_u_55
					p_u_55.SubjectEmoteStatusChanged:Fire()
				end
				table.insert(v73, v74:Connect(v75))
			end))
			if p_u_55.CurrentSubject.Entity then
				local v76 = p_u_55.CurrentSubject.Entity
				local v77 = p_u_55._subject_connections
				local v78 = v76.EmoteStatusChanged
				table.insert(v77, v78:Connect(function()
					-- upvalues: (copy) p_u_55
					p_u_55.SubjectEmoteStatusChanged:Fire()
				end))
			end
		end
	end
end
function v_u_13._CleanupCurrentDuelSubject(p79, p80) -- name: _CleanupCurrentDuelSubject
	for _, v81 in pairs(p79._duel_connections) do
		v81:Disconnect()
	end
	p79._duel_connections = {}
	p79._duel_just_spectated = {}
	for v82 = #p79.Subjects, 1, -1 do
		p79:_RemoveSubject(p79.Subjects[v82], true)
	end
	p79:_VerifySubject()
	if p79.CurrentDuelSubject and p79.CurrentDuelSubject ~= p80 then
		p79.CurrentDuelSubject:SetReplicate("IsSpectating", false)
		for _, v83 in pairs(p79.CurrentDuelSubject.Duelers) do
			if not v83.ClientFighter then
				continue
			end
			v83.ClientFighter:ClearInterface()
			v83.ClientFighter:ClearSounds(true)
		end
	end
end
function v_u_13._SpectateDuel(p_u_84, p85) -- name: _SpectateDuel
	-- upvalues: (copy) v_u_10, (copy) v_u_4, (copy) v_u_9
	local v86 = v_u_10:GetDuel(v_u_4.LocalPlayer)
	if v86 and p85 ~= v86 then
		return
	else
		p_u_84:_CleanupCurrentDuelSubject(p85)
		p_u_84.CurrentDuelSubject = p85
		p_u_84.DuelSubjectChanged:Fire()
		if p_u_84.CurrentDuelSubject then
			p_u_84.CurrentDuelSubject:SetReplicate("IsSpectating", true)
			local v87 = p_u_84._duel_connections
			local v88 = p_u_84.CurrentDuelSubject:GetDataChangedSignal("EnvironmentID")
			table.insert(v87, v88:Connect(function()
				-- upvalues: (copy) p_u_84
				p_u_84.DuelSubjectEnvironmentIDChanged:Fire()
			end))
			local v89 = p_u_84._duel_connections
			local v90 = p_u_84.CurrentDuelSubject:GetDataChangedSignal("Status")
			table.insert(v89, v90:Connect(function()
				-- upvalues: (copy) p_u_84
				p_u_84.DuelSubjectStatusChanged:Fire()
			end))
			local function v_u_91() -- name: verify_subject
				-- upvalues: (copy) p_u_84
				p_u_84:_VerifySubject()
			end
			local v92 = p_u_84._duel_connections
			local v93 = p_u_84.CurrentDuelSubject:GetDataChangedSignal("IsCurrentArcadeDuel")
			table.insert(v92, v93:Connect(v_u_91))
			local v94 = p_u_84._duel_connections
			local v95 = p_u_84.CurrentDuelSubject:GetDataChangedSignal("Status")
			table.insert(v94, v95:Connect(v_u_91))
			task.defer(v_u_91)
			local v96 = p_u_84._duel_connections
			local v97 = p_u_84.CurrentDuelSubject.DuelerRemoved
			table.insert(v96, v97:Connect(function(p98) -- name: dueler_removed
				-- upvalues: (copy) p_u_84
				if p98.IsLocalPlayer then
					p_u_84:SpectateDuelRequest(nil)
				else
					p_u_84:_RemoveSubject(p98.ClientFighter)
				end
			end))
			local function v113(p99, p100) -- name: dueler_added
				-- upvalues: (ref) v_u_9, (copy) p_u_84, (copy) v_u_91
				if p99.IsLocalPlayer then
					v_u_9.CameraState:SetCustomFreecamEnabled(false)
				end
				local v101 = p_u_84._duel_connections
				local v102 = p99:GetDataChangedSignal("TeamID")
				local v103 = v_u_91
				table.insert(v101, v102:Connect(v103))
				local v104 = p_u_84._duel_connections
				local v105 = p99.EntityAdded
				local v106 = v_u_91
				table.insert(v104, v105:Connect(v106))
				local v107 = p_u_84._duel_connections
				local v108 = p99.Eliminated
				local v109 = v_u_91
				table.insert(v107, v108:Connect(v109))
				local v110 = p_u_84._duel_connections
				local v111 = p99.Died
				local v112 = v_u_91
				table.insert(v110, v111:Connect(v112))
				p_u_84:_AddSubject(p99.ClientFighter, p100)
			end
			local v114 = p_u_84._duel_connections
			local v115 = p_u_84.CurrentDuelSubject.DuelerAdded
			table.insert(v114, v115:Connect(v113))
			for _, v116 in pairs(p_u_84.CurrentDuelSubject.Duelers) do
				task.spawn(v113, v116, true)
			end
			local v117 = p_u_84._duel_connections
			local v118 = p_u_84.CurrentDuelSubject.SpectateThisPlayer
			table.insert(v117, v118:Connect(function(p119, p120)
				-- upvalues: (copy) p_u_84
				if tick() <= (p_u_84._duel_just_spectated[p119] or 0) + 0.3 then
					local v121 = nil
					for _, v122 in pairs(p_u_84.Subjects) do
						if v122.Player ~= p120 then
							continue
						end
						v121 = v122
					end
					p_u_84:_RawSetCurrentSubject(v121)
					p_u_84:_VerifySubject()
				end
			end))
		end
	end
end
function v_u_13._AddSubject(p123, p124, p125) -- name: _AddSubject
	if not table.find(p123.Subjects, p124) then
		local v126 = p123.Subjects
		table.insert(v126, p124)
		if not p125 then
			p123:_VerifySubject()
		end
	end
end
function v_u_13._RemoveSubject(p127, p128, p129) -- name: _RemoveSubject
	if p128.IsLocalPlayer then
		return
	else
		local v130 = table.find(p127.Subjects, p128)
		if v130 then
			if p128 == p127.CurrentSubject then
				p127:Increment(-1)
			end
			table.remove(p127.Subjects, v130)
			if not p129 then
				p127:_VerifySubject()
			end
		end
	end
end
function v_u_13._SpectatingReplicationLoop(p131) -- name: _SpectatingReplicationLoop
	-- upvalues: (copy) v_u_1
	while true do
		wait(1)
		local v132 = p131.CurrentSubject
		if v132 then
			v132 = p131.CurrentSubject.Player.UserId
		end
		if v132 == p131._last_spectating_user_id then
			continue
		end
		p131._last_spectating_user_id = v132
		v_u_1.Remotes.Replication.Fighter.Spectating:FireServer(p131._last_spectating_user_id)
	end
end
function v_u_13._ProcessInput(p133, p134) -- name: _ProcessInput
	-- upvalues: (copy) v_u_9, (copy) v_u_6
	local v135 = v_u_9:GetPublicState() == v_u_9.CameraState.States.CustomFreecam
	if v_u_6:InputIs(p134, "SpectateNext") and not v135 then
		p133:Next()
		return
	elseif v_u_6:InputIs(p134, "SpectateLast") and not v135 then
		p133:Last()
	elseif v_u_6:InputIs(p134, "SpectateExit") then
		p133:Exit()
	end
end
function v_u_13._HookLocalFighter(p_u_136) -- name: _HookLocalFighter
	-- upvalues: (copy) v_u_8, (copy) v_u_10
	local v_u_137 = v_u_8:WaitForLocalFighter()
	local function v139() -- name: update_duel_subject
		-- upvalues: (copy) v_u_137, (ref) v_u_10, (copy) p_u_136
		local v138 = v_u_137:Get("SpectatingDuelObjectID")
		p_u_136:_SpectateDuel(v138 and v_u_10:GetDuelByID(v138) or nil)
	end
	v_u_137:GetDataChangedSignal("SpectatingDuelObjectID"):Connect(v139)
	local v140 = v_u_137:Get("SpectatingDuelObjectID")
	p_u_136:_SpectateDuel(v140 and v_u_10:GetDuelByID(v140) or nil)
end
function v_u_13._Init(p_u_141) -- name: _Init
	-- upvalues: (copy) v_u_9, (copy) v_u_3, (copy) v_u_2, (copy) v_u_8, (copy) v_u_10, (copy) v_u_11, (copy) v_u_12
	p_u_141.SubjectChanged:Connect(function()
		-- upvalues: (copy) p_u_141, (ref) v_u_9
		p_u_141.SubjectEmoteStatusChanged:Fire()
		v_u_9:SetSubject(p_u_141.CurrentSubject)
	end)
	p_u_141.DuelSubjectChanged:Connect(function()
		-- upvalues: (copy) p_u_141, (ref) v_u_9
		p_u_141:_VerifySubject()
		v_u_9.CameraState:SetCustomFreecamEnabled(false)
		v_u_9:SetDuelSubject(p_u_141.CurrentDuelSubject)
	end)
	v_u_3:BindToRenderStep("SpectateController", Enum.RenderPriority.Camera.Value + 1, function(p142)
		-- upvalues: (copy) p_u_141
		p_u_141:Update(p142)
	end)
	v_u_2.InputBegan:Connect(function(p143, p144)
		-- upvalues: (ref) v_u_9, (copy) p_u_141
		if p144 then
			return
		elseif v_u_9:GetPublicState() == v_u_9.CameraState.States.ThirdPersonUnlockedMouse and p143.UserInputType == Enum.UserInputType.MouseButton2 then
			p_u_141._process_mb2_on_input_ended_delta = 0
		else
			p_u_141:_ProcessInput(p143)
		end
	end)
	v_u_2.InputChanged:Connect(function(p145, _)
		-- upvalues: (copy) p_u_141
		if p_u_141._process_mb2_on_input_ended_delta and p145.UserInputType == Enum.UserInputType.MouseMovement then
			local v146 = p_u_141
			v146._process_mb2_on_input_ended_delta = v146._process_mb2_on_input_ended_delta + Vector2.new(p145.Delta.X, p145.Delta.Y).Magnitude
		end
	end)
	v_u_2.InputEnded:Connect(function(p147, _)
		-- upvalues: (copy) p_u_141
		local v148 = p_u_141._process_mb2_on_input_ended_delta
		if v148 and p147.UserInputType == Enum.UserInputType.MouseButton2 then
			p_u_141._process_mb2_on_input_ended_delta = nil
			if v148 <= 5 then
				p_u_141:_ProcessInput(p147)
			end
		else
			return
		end
	end)
	v_u_8.ObjectAdded:Connect(function(p149)
		-- upvalues: (copy) p_u_141
		if p149.IsLocalPlayer then
			p149.EntityAdded:Connect(function()
				-- upvalues: (ref) p_u_141
				p_u_141:_VerifySubject()
			end)
			p149.EntityRemoved:Connect(function()
				-- upvalues: (ref) p_u_141
				p_u_141:_VerifySubject()
			end)
			p149.Died:Connect(function()
				-- upvalues: (ref) p_u_141
				p_u_141:_VerifySubject()
			end)
			p_u_141:_AddSubject(p149)
		end
	end)
	v_u_8.ObjectRemoved:Connect(function(p150)
		-- upvalues: (copy) p_u_141
		p_u_141:_RemoveSubject(p150)
	end)
	v_u_10.LocalPlayerJoinedDuel:Connect(function(p151, _)
		-- upvalues: (copy) p_u_141
		p_u_141:SpectateDuelRequest(p151)
	end)
	v_u_10.LocalPlayerLeftDuel:Connect(function(_, _)
		-- upvalues: (copy) p_u_141
		p_u_141:SpectateDuelRequest(nil)
	end)
	v_u_10.ObjectRemoved:Connect(function(p152)
		-- upvalues: (copy) p_u_141
		if p_u_141.CurrentDuelSubject == p152 then
			p_u_141:SpectateDuelRequest(nil)
		end
	end)
	v_u_9.CustomFreecamStateChanged:Connect(function()
		-- upvalues: (copy) p_u_141
		p_u_141:_VerifySubject()
	end)
	v_u_11.EnabledChanged:Connect(function()
		-- upvalues: (ref) v_u_11, (copy) p_u_141
		if v_u_11.Enabled then
			p_u_141:SpectateDuelRequest(nil)
		end
	end)
	v_u_12.VisibilityChanged:Connect(function()
		-- upvalues: (ref) v_u_12, (copy) p_u_141
		if v_u_12:IsVisible() then
			p_u_141:SpectateDuelRequest(nil)
		end
	end)
	p_u_141:_VerifySubject()
	task.spawn(p_u_141._HookLocalFighter, p_u_141)
	task.spawn(p_u_141._SpectatingReplicationLoop, p_u_141)
end
return v_u_13._new()