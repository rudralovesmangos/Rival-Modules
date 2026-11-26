local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("Players")
local v_u_3 = require(v1.Modules.CONSTANTS)
local v_u_4 = require(v1.Modules.SeasonLibrary)
local v_u_5 = require(v1.Modules.DuelLibrary)
local v_u_6 = require(v1.Modules.Utility)
local v_u_7 = require(v_u_2.LocalPlayer.PlayerScripts.Controllers:WaitForChild("ComplianceController"))
local v_u_8 = require(v_u_2.LocalPlayer.PlayerScripts.Controllers:WaitForChild("PlayerDataController"))
local v_u_9 = require(v_u_2.LocalPlayer.PlayerScripts.Modules:WaitForChild("ButtonEffect"))
local v_u_10 = require(v_u_2.LocalPlayer.PlayerScripts.Modules:WaitForChild("RankIcon"))
local v_u_11 = require(v_u_2.LocalPlayer.PlayerScripts.Modules:WaitForChild("Page"))
local v_u_12 = v_u_2.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("DuelHistoryRageQuitSlot")
local v_u_13 = v_u_2.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("DuelHistoryHeadshotSlot")
local v_u_14 = v_u_2.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("DuelHistoryDuelerSlot")
local v_u_15 = v_u_2.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("DuelHistoryEmptySlot")
local v_u_16 = v_u_2.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("DuelHistorySlot")
local v_u_17 = setmetatable({}, v_u_11)
v_u_17.__index = v_u_17
function v_u_17._new() -- name: _new
	-- upvalues: (copy) v_u_11, (copy) v_u_17
	local v18 = v_u_11.new(script.Name)
	local v19 = v_u_17
	local v20 = setmetatable(v18, v19)
	v20.CloseButton = v20.PageFrame:WaitForChild("Close")
	v20.List = v20.PageFrame:WaitForChild("List")
	v20.Container = v20.List:WaitForChild("Container")
	v20.Layout = v20.Container:WaitForChild("Layout")
	v20._duel_history_slots = {}
	v20._generate_hash = 0
	v20:_Init()
	return v20
end
function v_u_17.Open(p21, ...) -- name: Open
	-- upvalues: (copy) v_u_11
	v_u_11.Open(p21, ...)
	task.spawn(p21._Generate, p21)
end
function v_u_17._SetupELOEventLog(_, p22, p23) -- name: _SetupELOEventLog
	-- upvalues: (copy) v_u_10
	p22.Visible = p23
	if p23 then
		local v24 = v_u_10.new(p23.CurrentELO, nil, p23.CurrentLeaderboardRanking or (1 / 0))
		v24:SetLabelFromELOEvent(p23.ELOIncrement, p23.CurrentELO, p23.DuelsPlayed)
		v24:SetParent(p22)
	end
end
function v_u_17._Generate(p25) -- name: _Generate
	-- upvalues: (copy) v_u_8, (copy) v_u_12, (copy) v_u_2, (copy) v_u_16, (copy) v_u_5, (copy) v_u_4, (copy) v_u_13, (copy) v_u_3, (copy) v_u_14, (copy) v_u_6, (copy) v_u_10, (copy) v_u_9, (copy) v_u_7, (copy) v_u_15
	for _, v26 in pairs(p25._duel_history_slots) do
		v26:Destroy()
	end
	p25._duel_history_slots = {}
	p25._generate_hash = p25._generate_hash + 1
	local v27 = p25._generate_hash
	local v28 = {}
	for _, v29 in pairs(v_u_8:Get("LoggedELOEvents")) do
		if not v29.LogID then
			continue
		end
		v28[v29.LogID] = v29
	end
	for v30, v_u_31 in pairs(v_u_8:Get("DuelHistory")) do
		if v27 ~= p25._generate_hash then
			return
		end
		local v32 = v28[v_u_31.LogID]
		if v_u_31.IsRageQuit then
			local v33 = v_u_12:Clone()
			v33.LayoutOrder = v30
			v33.Parent = p25.Container
			local v34 = p25._duel_history_slots
			table.insert(v34, v33)
			p25:_SetupELOEventLog(v33.RankContainer, v32)
			wait(0.03)
		else
			local v35 = false
			for _, v36 in pairs(v_u_31.Duelers) do
				if v36.UserID ~= v_u_2.LocalPlayer.UserId then
					continue
				end
				v35 = true
			end
			if not v35 then
				break
			end
			local v_u_37 = v_u_16:Clone()
			v_u_37.LayoutOrder = v30
			v_u_37.Map.Image = v_u_31.Map and v_u_5.Maps[v_u_31.Map] and (v_u_5.Maps[v_u_31.Map].Image or "") or ""
			v_u_37.Container.QueueName.Text = v_u_31.QueueName and v_u_5.MatchmakingQueues[v_u_31.QueueName] and v_u_5.MatchmakingQueues[v_u_31.QueueName].DisplayName or (v_u_31.QueueName or "")
			v_u_37.Container.Score.Text = ""
			v_u_37.Container.EDATitle.Visible = false
			v_u_37.Container.EDA.Visible = false
			v_u_37.Container.Duelers.LookupID.Text = "ID: " .. (v_u_31.LookupID or "???")
			v_u_37.Container.Duelers.LookupID.Visible = v_u_31.LookupID ~= nil
			p25:_SetupELOEventLog(v_u_37.Container.RankContainer, v32)
			for v38 = 1, v_u_31.NumTeams do
				local v39 = v_u_37.Container.Score
				v39.Text = v39.Text .. v_u_31.Scores[v38] .. (v38 == v_u_31.NumTeams and "" or " \226\128\162 ")
			end
			local v40 = v_u_4:IsRankedQueue(v_u_31.QueueName)
			local v_u_41 = {}
			for v42, v43 in pairs(v_u_31.Duelers) do
				local v44 = v_u_5
				local v45 = v43.TeamIndex and v_u_5.Teams[v43.TeamIndex]
				if v45 then
					v45 = v_u_5.Teams[v43.TeamIndex].TeamID
				end
				local v46 = v44:GetTeamColor(v45)
				if v43.UserID == v_u_2.LocalPlayer.UserId then
					local v47 = v_u_31.WinningTeamIndex
					if v47 then
						v47 = v_u_31.WinningTeamIndex == v43.TeamIndex
					end
					v_u_37.Container.Background.ImageColor3 = v47 and Color3.fromRGB(100, 255, 50) or Color3.fromRGB(255, 50, 50)
					v_u_37.Container.Title.Text = v47 and "VICTORY" or "DEFEAT"
					v_u_37.Container.EDA.Text = (v43.Eliminations or "?") .. " \226\128\162 " .. (v43.Deaths or "?") .. " \226\128\162 " .. (v43.Assists or "?")
					v_u_37.Container.EDA.Visible = not v_u_37.Container.RankContainer.Visible
					v_u_37.Container.EDATitle.Visible = v_u_37.Container.EDA.Visible
				end
				local v48 = v_u_13:Clone()
				v48.Picture.Image = not v43.UserID and "rbxassetid://18623501726" or string.format(v_u_3.HEADSHOT_IMAGE, v43.UserID)
				v48.Picture.ImageColor3 = not v43.UserID and Color3.fromRGB(0, 0, 0) or v48.Picture.ImageColor3
				v48.Picture.ImageTransparency = not v43.UserID and 0.5 or v48.Picture.ImageTransparency
				v48.Picture.Size = not v43.UserID and UDim2.new(0.75, 0, 0.75, 0) or v48.Picture.Size
				v48.Background.BackgroundColor3 = v46
				v48.LayoutOrder = v43.TeamIndex * 1000 + v42
				v48.Parent = v_u_37.Container.Headshots
				local v49 = v_u_14:Clone()
				v49.Player.Image = not v43.UserID and "rbxassetid://18623501726" or string.format(v_u_3.HEADSHOT_IMAGE, v43.UserID)
				v49.DisplayName.Text = "\226\128\162 \226\128\162 \226\128\162"
				v49.Username.Text = "@\226\128\162 \226\128\162 \226\128\162"
				local v50 = v49.Damage
				local v51
				if v43.Damage then
					local v52 = v_u_6
					local v53 = v43.Damage + 0.5
					v51 = v52:PrettyNumber((math.floor(v53))) or ""
				else
					v51 = ""
				end
				v50.Text = v51
				v49.Eliminations.Text = v43.Eliminations or ""
				v49.Deaths.Text = v43.Deaths or ""
				v49.Assists.Text = v43.Assists or ""
				v49.MVPText.Visible = v43.IsMVP
				v49.MVPIcon.Visible = v43.IsMVP
				v49.BackgroundColor3 = v46
				v49.LayoutOrder = v42
				v49.Parent = v_u_37.Container.Duelers
				if v43.UserID then
					local v54 = v43.UserID
					v_u_41[tostring(v54)] = v49
				end
				if not v40 then
					continue
				end
				v_u_10.new(v43.DisplayELO, nil, v43.DisplayELOLeaderboardRanking or (1 / 0)):SetParent(v49.Rank)
			end
			v_u_37.Parent = p25.Container
			local v55 = p25._duel_history_slots
			table.insert(v55, v_u_37)
			local v_u_56 = v_u_9:Add(v_u_37, nil, {
				["HoverRatio"] = 1.025,
				["ReleaseRatio"] = 1.025
			})
			local v_u_57 = false
			local v_u_58 = false
			v_u_37.MouseButton1Click:Connect(function()
				-- upvalues: (ref) v_u_58, (copy) v_u_37, (copy) v_u_56, (ref) v_u_57, (copy) v_u_31, (ref) v_u_7, (copy) v_u_41
				v_u_58 = not v_u_58
				local v59 = v_u_58 and UDim2.new(1, 0, (#v_u_37.Container.Duelers:GetChildren() - 4) * 0.07500000000000001 + 0.2875, 0) or UDim2.new(1, 0, 0.2, 0)
				v_u_56.UpdateOriginalSize(v59)
				v_u_37.Size = v59
				v_u_37.Container.Duelers.Visible = v_u_58
				if not v_u_57 then
					v_u_57 = true
					local v60 = {}
					for _, v61 in pairs(v_u_31.Duelers) do
						if not v61.UserID then
							continue
						end
						local v62 = v61.UserID
						table.insert(v60, v62)
					end
					local v63 = v_u_7:GetUserInfos(v60)
					for v64, v65 in pairs(v_u_41) do
						local v66 = v63[v64]
						if not v66 then
							continue
						end
						v65.Username.Text = v66.Username == v66.DisplayName and "" or "@" .. v66.Username
						v65.DisplayName.Text = v66.DisplayName
						v65.DisplayName.Position = v65.Username.Text == "" and UDim2.new(0.1, 0, 0.5, 0) or UDim2.new(0.1, 0, 0.35, 0)
					end
				end
			end)
			wait(0.03)
		end
	end
	for _ = #p25._duel_history_slots + 1, 6 do
		if v27 ~= p25._generate_hash then
			return
		end
		local v67 = v_u_15:Clone()
		v67.LayoutOrder = 99999
		v67.Parent = p25.Container
		local v68 = p25._duel_history_slots
		table.insert(v68, v67)
		wait(0.03)
	end
end
function v_u_17._Init(p_u_69) -- name: _Init
	-- upvalues: (copy) v_u_9
	p_u_69.CloseButton.MouseButton1Click:Connect(function()
		-- upvalues: (copy) p_u_69
		p_u_69:CloseRequest()
	end)
	p_u_69.Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		-- upvalues: (copy) p_u_69
		p_u_69.List.CanvasSize = UDim2.new(0, 0, 0, p_u_69.Layout.AbsoluteContentSize.Y)
	end)
	v_u_9:Add(p_u_69.CloseButton)
end
return v_u_17._new()