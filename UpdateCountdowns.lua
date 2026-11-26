local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("CollectionService")
local v_u_3 = game:GetService("SocialService")
local v4 = game:GetService("Players")
local v_u_5 = require(v1.Modules.ServerOsTime)
local v_u_6 = require(v1.Modules.Utility)
local v_u_7 = require(v4.LocalPlayer.PlayerScripts.Controllers.PlayerDataController)
local v_u_8 = require(v4.LocalPlayer.PlayerScripts.Modules.LobbyElement)
local v_u_9 = setmetatable({}, v_u_8)
v_u_9.__index = v_u_9
function v_u_9._new(...) -- name: _new
	-- upvalues: (copy) v_u_8, (copy) v_u_9
	local v10 = v_u_8.new(...)
	local v11 = v_u_9
	local v12 = setmetatable(v10, v11)
	v12._models = {}
	v12._countdown_hash = 0
	v12._next_event_details = nil
	v12:_Init()
	return v12
end
function v_u_9.Update(p13, _) -- name: Update
	if p13._next_event_details then
		for _, v14 in pairs(p13._models) do
			local v15 = workspace.CurrentCamera.CFrame.X
			local v16 = v14.CountdownCFrame.Y + (workspace.CurrentCamera.CFrame.Y - v14.CountdownCFrame.Y) / 2
			local v17 = workspace.CurrentCamera.CFrame.Z
			local v18 = Vector3.new(v15, v16, v17)
			v14.CountdownPart.CFrame = CFrame.new(v14.CountdownCFrame.Position, v18) * CFrame.Angles(0.2617993877991494, 0, 0)
		end
	end
end
function v_u_9._GetDateTime(_, p19) -- name: _GetDateTime
	return DateTime.fromUniversalTime(p19.Year, p19.Month, p19.Day, p19.Hour, p19.Minute, p19.Second, p19.Millisecond)
end
function v_u_9._UpdateCountdown(p_u_20) -- name: _UpdateCountdown
	-- upvalues: (copy) v_u_7, (copy) v_u_3, (copy) v_u_5, (copy) v_u_6
	for v21, v22 in pairs(p_u_20._models) do
		v22.CountdownModel.Parent = nil
		v22.LogoModel.Parent = v21
	end
	p_u_20._next_event_details = nil
	p_u_20._countdown_hash = p_u_20._countdown_hash + 1
	local v23 = p_u_20._countdown_hash
	if v_u_7:GetStatistic("StatisticDuelsPlayed") < 10 or v_u_7:GetSetting("Hide Intrusive Lobby Elements") then
		return
	else
		local v24 = v_u_3.GetUpcomingExperienceEventsAsync
		local v25 = v_u_3
		local v26, v27 = pcall(v24, v25)
		if v26 then
			if p_u_20._countdown_hash == v23 then
				table.sort(v27, function(p28, p29)
					-- upvalues: (copy) p_u_20
					local v30 = p_u_20:_GetDateTime(p28.StartTime)
					local v31 = p_u_20:_GetDateTime(p29.StartTime)
					return v30.UnixTimestamp < v31.UnixTimestamp
				end)
				local v32 = nil
				for _, v33 in pairs(v27) do
					if v33.HasStarted or (v33.HasEnded or v33.Status ~= Enum.ExperienceEventStatus.Active) then
						continue
					end
					v32 = v33
				end
				if v32 then
					local v34 = v_u_3.GetExperienceEventAsync
					local v35 = v_u_3
					local v36 = v32.Id
					local v37, v38 = pcall(v34, v35, v36)
					if v37 then
						if p_u_20._countdown_hash == v23 then
							p_u_20._next_event_details = v38
							for v39, v40 in pairs(p_u_20._models) do
								v40.CountdownModel.Parent = v39
								v40.LogoModel.Parent = nil
								v40.CountdownTitle.Text = string.upper(p_u_20._next_event_details.Title)
							end
							local v41 = p_u_20:_GetDateTime(p_u_20._next_event_details.StartTime)
							local v42 = v41.UnixTimestamp - v_u_5:Get()
							local v43 = math.ceil(v42)
							for _, v44 in pairs(p_u_20._models) do
								v44.CountdownText.Text = v43 <= 0 and "ANY SECOND NOW" or v_u_6:TimeFormat2(v43)
							end
							wait(1)
							if p_u_20._countdown_hash == v23 then
								break
							end
						end
					else
						warn("Failed to fetch event details, error:", v27)
						return
					end
				else
					return
				end
			else
				return
			end
		else
			warn("Failed to fetch upcoming events, error:", v27)
			return
		end
	end
end
function v_u_9._ModelAdded(p_u_45, p46) -- name: _ModelAdded
	-- upvalues: (copy) v_u_3
	p46:WaitForChild("Countdown"):PivotTo(p46:WaitForChild("Countdown"):GetPivot() + Vector3.new(0, 100, 0))
	local v47 = {
		["CountdownModel"] = p46:WaitForChild("Countdown"),
		["CountdownPart"] = p46:WaitForChild("Countdown"):WaitForChild("Part"),
		["CountdownCFrame"] = p46:WaitForChild("Countdown"):WaitForChild("Part").CFrame,
		["CountdownTitle"] = p46:WaitForChild("Countdown"):WaitForChild("Part"):WaitForChild("SurfaceGui"):WaitForChild("Title"),
		["CountdownText"] = p46:WaitForChild("Countdown"):WaitForChild("Part"):WaitForChild("SurfaceGui"):WaitForChild("Countdown"),
		["LogoModel"] = p46:WaitForChild("Logo")
	}
	p_u_45._models[p46] = v47
	p46:WaitForChild("Countdown"):WaitForChild("Prompt"):WaitForChild("ProximityPrompt").Triggered:Connect(function()
		-- upvalues: (copy) p_u_45, (ref) v_u_3
		if p_u_45._next_event_details then
			local v48 = v_u_3.PromptRsvpToEventAsync
			local v49 = v_u_3
			local v50 = p_u_45._next_event_details.Id
			local v51, v52 = pcall(v48, v49, v50)
			if not v51 then
				warn("Failed to prompt event RSVP, error:", v52)
			end
		end
	end)
	p_u_45:_UpdateCountdown()
end
function v_u_9._Init(p_u_53) -- name: _Init
	-- upvalues: (copy) v_u_7, (copy) v_u_2
	v_u_7:GetDataChangedSignal("StatisticDuelsPlayed"):Connect(function()
		-- upvalues: (copy) p_u_53
		p_u_53:_UpdateCountdown()
	end)
	v_u_7:GetSettingChangedSignal("Hide Intrusive Lobby Elements"):Connect(function()
		-- upvalues: (copy) p_u_53
		p_u_53:_UpdateCountdown()
	end)
	v_u_2:GetInstanceAddedSignal("LobbyUpdateCountdown"):Connect(function(p54)
		-- upvalues: (copy) p_u_53
		p_u_53:_ModelAdded(p54)
	end)
	for _, v55 in pairs(v_u_2:GetTagged("LobbyUpdateCountdown")) do
		task.defer(p_u_53._ModelAdded, p_u_53, v55)
	end
end
return v_u_9._new()