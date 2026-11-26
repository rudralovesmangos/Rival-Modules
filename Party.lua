local v_u_1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("Players")
local v_u_3 = require(v_u_1.Modules.CONSTANTS)
local v_u_4 = require(v_u_2.LocalPlayer.PlayerScripts.Controllers:WaitForChild("ComplianceController"))
local v_u_5 = require(v_u_2.LocalPlayer.PlayerScripts.Controllers:WaitForChild("QueuePadController"))
local v_u_6 = require(v_u_2.LocalPlayer.PlayerScripts.Controllers:WaitForChild("FighterController"))
local v_u_7 = require(v_u_2.LocalPlayer.PlayerScripts.Controllers:WaitForChild("SocialController"))
local v_u_8 = require(v_u_2.LocalPlayer.PlayerScripts.Controllers:WaitForChild("PartyController"))
local v_u_9 = require(v_u_2.LocalPlayer.PlayerScripts.Modules:WaitForChild("UserInterface"):WaitForChild("MatchmakingCountdown"))
local v_u_10 = require(v_u_2.LocalPlayer.PlayerScripts.Modules:WaitForChild("PartyInviteSlot"))
local v_u_11 = require(v_u_2.LocalPlayer.PlayerScripts.Modules:WaitForChild("ButtonEffect"))
local v_u_12 = require(v_u_2.LocalPlayer.PlayerScripts.Modules:WaitForChild("Page"))
local v_u_13 = v_u_2.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("PartyMemberBigSlot")
local v_u_14 = setmetatable({}, v_u_12)
v_u_14.__index = v_u_14
function v_u_14._new() -- name: _new
	-- upvalues: (copy) v_u_12, (copy) v_u_14
	local v15 = v_u_12.new(script.Name)
	local v16 = v_u_14
	local v17 = setmetatable(v15, v16)
	v17.CloseButton = v17.PageFrame:WaitForChild("Close")
	v17.MembersFrame = v17.PageFrame:WaitForChild("Members")
	v17.List = v17.PageFrame:WaitForChild("List")
	v17.Container = v17.List:WaitForChild("Container")
	v17.Layout = v17.Container:WaitForChild("Layout")
	v17.EmptyFrame = v17.Container:WaitForChild("Empty")
	v17.TopFrame = v17.Container:WaitForChild("Top")
	v17.SearchBox = v17.TopFrame:WaitForChild("Search"):WaitForChild("Box")
	v17.TabsFrame = v17.TopFrame:WaitForChild("Tabs")
	v17.AllButton = v17.TabsFrame:WaitForChild("All")
	v17.AllButtonText = v17.AllButton:WaitForChild("Title")
	v17.AllButtonBackground = v17.AllButton:WaitForChild("Background")
	v17.AllButtonBackgroundGradient = v17.AllButtonBackground:WaitForChild("UIGradient")
	v17.FriendsButton = v17.TabsFrame:WaitForChild("Friends")
	v17.FriendsButtonText = v17.FriendsButton:WaitForChild("Title")
	v17.FriendsButtonBackground = v17.FriendsButton:WaitForChild("Background")
	v17.FriendsButtonBackgroundGradient = v17.FriendsButtonBackground:WaitForChild("UIGradient")
	v17.LobbyButton = v17.TabsFrame:WaitForChild("Lobby")
	v17.LobbyButtonText = v17.LobbyButton:WaitForChild("Title")
	v17.LobbyButtonBackground = v17.LobbyButton:WaitForChild("Background")
	v17.LobbyButtonBackgroundGradient = v17.LobbyButtonBackground:WaitForChild("UIGradient")
	v17.PlayersFrame = v17.Container:WaitForChild("Players")
	v17.PlayersContainer = v17.PlayersFrame:WaitForChild("Container")
	v17.PlayersLayout = v17.PlayersContainer:WaitForChild("Layout")
	v17.HidePartyDisplay = true
	v17._member_slots = {}
	v17._invite_slots = {}
	v17._offline_invite_slots = {}
	v17._invite_generation_disabled = 0
	v17._leave_buttons = {}
	v17:_Init()
	return v17
end
function v_u_14.Open(p_u_18, ...) -- name: Open
	-- upvalues: (copy) v_u_12, (copy) v_u_5, (copy) v_u_8
	v_u_12.Open(p_u_18, ...)
	local v19 = p_u_18._open_connections
	local v20 = v_u_5.ChallengeRequestCooldownChanged
	table.insert(v19, v20:Connect(function()
		-- upvalues: (copy) p_u_18
		p_u_18:_UpdateCooldowns()
	end))
	local v21 = p_u_18._open_connections
	local v22 = v_u_8.InviteRequestCooldownChanged
	table.insert(v21, v22:Connect(function()
		-- upvalues: (copy) p_u_18
		p_u_18:_UpdateCooldowns()
	end))
	p_u_18:_GenerateMembers()
	p_u_18:_GeneratePlayers(true)
	p_u_18:_UpdateCooldowns()
	p_u_18._invite_generation_disabled = tick() + 0.375
	task.delay(0.375, p_u_18._GeneratePlayers, p_u_18)
	p_u_18.SearchBox.Text = ""
end
function v_u_14._UpdateLayouts(p23) -- name: _UpdateLayouts
	p23.List.CanvasSize = UDim2.new(0, 0, 0, p23.Layout.AbsoluteContentSize.Y)
	p23.PlayersFrame.Size = UDim2.new(1, 0, 0, p23.PlayersLayout.AbsoluteContentSize.Y)
	p23.EmptyFrame.Visible = p23.PlayersLayout.AbsoluteContentSize.Y < 5
end
function v_u_14._UpdateLeaveButtons(p24) -- name: _UpdateLeaveButtons
	-- upvalues: (copy) v_u_9
	local v25 = v_u_9:IsVisible()
	for _, v26 in pairs(p24._leave_buttons) do
		v26.Visible = v25
	end
end
function v_u_14._UpdateCooldowns(p27) -- name: _UpdateCooldowns
	for _, v28 in pairs(p27._invite_slots) do
		v28:UpdateCooldowns()
	end
end
function v_u_14._SetTab(p29, p30) -- name: _SetTab
	p29._current_tab = p30
	p29.AllButtonText.TextColor3 = p29._current_tab == "All" and Color3.fromRGB(0, 0, 0) or Color3.fromRGB(255, 255, 255)
	p29.AllButtonBackground.ImageColor3 = p29._current_tab == "All" and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(0, 0, 0)
	p29.AllButtonBackground.ImageTransparency = p29._current_tab == "All" and 0 or 0.25
	p29.AllButtonBackgroundGradient.Enabled = p29._current_tab ~= "All"
	p29.FriendsButtonText.TextColor3 = p29._current_tab == "Friends" and Color3.fromRGB(0, 0, 0) or Color3.fromRGB(255, 255, 255)
	p29.FriendsButtonBackground.ImageColor3 = p29._current_tab == "Friends" and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(0, 0, 0)
	p29.FriendsButtonBackground.ImageTransparency = p29._current_tab == "Friends" and 0 or 0.25
	p29.FriendsButtonBackgroundGradient.Enabled = p29._current_tab ~= "Friends"
	p29.LobbyButtonText.TextColor3 = p29._current_tab == "Lobby" and Color3.fromRGB(0, 0, 0) or Color3.fromRGB(255, 255, 255)
	p29.LobbyButtonBackground.ImageColor3 = p29._current_tab == "Lobby" and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(0, 0, 0)
	p29.LobbyButtonBackground.ImageTransparency = p29._current_tab == "Lobby" and 0 or 0.25
	p29.LobbyButtonBackgroundGradient.Enabled = p29._current_tab ~= "Lobby"
	p29:_UpdatePlayersVisibility()
end
function v_u_14._UpdatePlayerVisibility(p31, p32) -- name: _UpdatePlayerVisibility
	local v33 = string.lower(p31.SearchBox.Text)
	local v34 = p32.Frame
	local v35
	if p31._current_tab == "All" or p31._current_tab == p32.Frame.Name then
		v35 = string.find(string.lower(p32.Frame.DisplayName.Text), v33) or string.find(string.lower(p32.Frame.Username.Text), v33)
	else
		v35 = false
	end
	v34.Visible = v35
end
function v_u_14._UpdatePlayersVisibility(p36) -- name: _UpdatePlayersVisibility
	for _, v37 in pairs(p36._invite_slots) do
		p36:_UpdatePlayerVisibility(v37)
	end
	for _, v38 in pairs(p36._offline_invite_slots) do
		p36:_UpdatePlayerVisibility(v38)
	end
end
function v_u_14._GeneratePlayers(p_u_39, p40) -- name: _GeneratePlayers
	-- upvalues: (copy) v_u_2, (copy) v_u_3, (copy) v_u_10, (copy) v_u_6, (copy) v_u_7
	if p_u_39:IsOpen() then
		for v41 = #p_u_39._invite_slots, 1, -1 do
			local v42 = p_u_39._invite_slots[v41]
			if not p40 and v42:StillHere() then
				continue
			end
			v42:Destroy()
			table.remove(p_u_39._invite_slots, v41)
		end
		if p40 then
			for _, v43 in pairs(p_u_39._offline_invite_slots) do
				v43:Destroy()
			end
			p_u_39._offline_invite_slots = {}
		end
		if tick() >= p_u_39._invite_generation_disabled then
			local v_u_44 = {}
			for _, v45 in pairs(p_u_39._invite_slots) do
				v_u_44[tostring(v45:GetUserID())] = true
			end
			local v_u_46 = 0
			local function v54(p47, p48, p49, p50, p51) -- name: generate_slot
				-- upvalues: (ref) v_u_2, (ref) v_u_3, (copy) v_u_44, (ref) v_u_46, (ref) v_u_10, (copy) p_u_39
				if not p49 then
					if p48 then
						p49 = p48.UserId or nil
					else
						p49 = nil
					end
				end
				if (p49 ~= v_u_2.LocalPlayer.UserId or v_u_3.IS_STUDIO) and not v_u_44[tostring(p49)] then
					v_u_44[tostring(p49)] = true
					v_u_46 = v_u_46 + 1
					local v52 = v_u_10.new(p48, p49, p50, p51)
					local v53 = v52.Frame
					v53.LayoutOrder = v53.LayoutOrder + v_u_46
					v52.Frame.Parent = p_u_39.PlayersContainer
					p_u_39:_UpdatePlayerVisibility(v52)
					if p47 then
						table.insert(p47, v52)
					end
				end
			end
			for _, v55 in pairs(v_u_6.Objects) do
				v54(p_u_39._invite_slots, v55.Player)
			end
			if #p_u_39._offline_invite_slots == 0 then
				for _, v56 in pairs(v_u_7.Friends) do
					v54(p_u_39._offline_invite_slots, nil, v56.VisitorId, v56.DisplayName, v56.UserName)
				end
			end
			p_u_39:_UpdatePlayersVisibility()
		end
	else
		return
	end
end
function v_u_14._GenerateMembers(p_u_57) -- name: _GenerateMembers
	-- upvalues: (copy) v_u_8, (copy) v_u_2, (copy) v_u_6, (copy) v_u_13, (copy) v_u_3, (copy) v_u_4, (copy) v_u_11, (copy) v_u_1
	if p_u_57:IsOpen() then
		for _, v58 in pairs(p_u_57._member_slots) do
			v58:Destroy()
		end
		p_u_57._member_slots = {}
		p_u_57._leave_buttons = {}
		local v_u_59 = v_u_8.CurrentParty or { v_u_2.LocalPlayer }
		local function v75(p60, p_u_61) -- name: generate_slot
			-- upvalues: (ref) v_u_6, (ref) v_u_13, (ref) v_u_3, (ref) v_u_8, (ref) v_u_2, (copy) v_u_59, (ref) v_u_4, (copy) p_u_57, (ref) v_u_11, (ref) v_u_1
			local v62
			if p_u_61 then
				v62 = v_u_6:GetFighter(p_u_61)
			else
				v62 = p_u_61
			end
			local v_u_63 = v_u_13:Clone()
			v_u_63.Icon.Image = not p_u_61 and "" or string.format(v_u_3.HEADSHOT_IMAGE, p_u_61.UserId)
			local v64 = v_u_63.Leader
			local v65 = p_u_61 and v_u_8.CurrentParty
			if v65 then
				v65 = p60 == 1
			end
			v64.Visible = v65
			local v66 = v_u_63.Kick
			local v67 = p_u_61 and v_u_8.CurrentParty
			if v67 then
				if v_u_2.LocalPlayer == v_u_59[1] then
					v67 = p_u_61 ~= v_u_2.LocalPlayer
				else
					v67 = false
				end
			end
			v66.Visible = v67
			local v68 = v_u_63.Promote
			local v69 = p_u_61 and v_u_8.CurrentParty
			if v69 then
				if v_u_2.LocalPlayer == v_u_59[1] then
					v69 = p_u_61 ~= v_u_2.LocalPlayer
				else
					v69 = false
				end
			end
			v68.Visible = v69
			local v70 = v_u_63.Leave
			local v71 = p_u_61 and v_u_8.CurrentParty
			if v71 then
				v71 = p_u_61 == v_u_2.LocalPlayer
			end
			v70.Visible = v71
			v_u_63.DisplayName.Controls.Image = v62 and v_u_3.CONTROLS_IMAGES[v62:Get("Controls")] or ""
			v_u_63.DisplayName.Text = not p_u_61 and "" or v_u_4:GetName(p_u_61)
			v_u_63.Username.Text = not p_u_61 and "" or "@" .. p_u_61.Name
			v_u_63.Background.Visible = p_u_61 ~= nil
			v_u_63.TransparentBackground.Visible = not p_u_61
			v_u_63.LayoutOrder = p60
			v_u_63.Parent = p_u_57.MembersFrame
			local v72 = p_u_57._member_slots
			table.insert(v72, v_u_63)
			local v73 = p_u_57._leave_buttons
			local v74 = v_u_63.Leave
			table.insert(v73, v74)
			v_u_11:Add(v_u_63.Kick)
			v_u_11:Add(v_u_63.Leave)
			v_u_11:Add(v_u_63.Promote)
			v_u_63.Kick.MouseButton1Click:Connect(function()
				-- upvalues: (ref) v_u_1, (copy) p_u_61
				v_u_1.Remotes.Matchmaking.KickPlayerFromParty:FireServer(p_u_61)
			end)
			v_u_63.Leave.MouseButton1Click:Connect(function()
				-- upvalues: (ref) v_u_1
				v_u_1.Remotes.Matchmaking.TryLeaveParty:FireServer()
			end)
			v_u_63.Promote.MouseButton1Click:Connect(function()
				-- upvalues: (ref) v_u_1, (copy) p_u_61
				v_u_1.Remotes.Matchmaking.TransferPartyLeader:FireServer(p_u_61)
			end)
			v_u_63.DisplayName:GetPropertyChangedSignal("TextBounds"):Connect(function() -- name: update
				-- upvalues: (copy) v_u_63
				v_u_63.DisplayName.Controls.Position = UDim2.new(0, v_u_63.DisplayName.TextBounds.X, 0.5, 0)
			end)
			v_u_63.DisplayName.Controls.Position = UDim2.new(0, v_u_63.DisplayName.TextBounds.X, 0.5, 0)
		end
		for v76, v77 in pairs(v_u_59) do
			v75(v76, v77)
		end
		for v78 = #v_u_59 + 1, v_u_3.MAX_PARTY_SIZE do
			v75(v78, nil)
		end
	end
end
function v_u_14._Init(p_u_79) -- name: _Init
	-- upvalues: (copy) v_u_8, (copy) v_u_7, (copy) v_u_6, (copy) v_u_9, (copy) v_u_11
	p_u_79.CloseButton.MouseButton1Click:Connect(function()
		-- upvalues: (copy) p_u_79
		p_u_79:CloseRequest()
	end)
	p_u_79.Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		-- upvalues: (copy) p_u_79
		p_u_79:_UpdateLayouts()
	end)
	p_u_79.PlayersLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		-- upvalues: (copy) p_u_79
		p_u_79:_UpdateLayouts()
	end)
	p_u_79.AllButton.MouseButton1Click:Connect(function()
		-- upvalues: (copy) p_u_79
		p_u_79:_SetTab("All")
	end)
	p_u_79.FriendsButton.MouseButton1Click:Connect(function()
		-- upvalues: (copy) p_u_79
		p_u_79:_SetTab("Friends")
	end)
	p_u_79.LobbyButton.MouseButton1Click:Connect(function()
		-- upvalues: (copy) p_u_79
		p_u_79:_SetTab("Lobby")
	end)
	p_u_79.SearchBox:GetPropertyChangedSignal("Text"):Connect(function()
		-- upvalues: (copy) p_u_79
		p_u_79:_UpdatePlayersVisibility()
	end)
	v_u_8.PartyChanged:Connect(function()
		-- upvalues: (copy) p_u_79
		p_u_79:_GenerateMembers()
		p_u_79:_GeneratePlayers()
	end)
	v_u_7.FriendsFetched:Connect(function()
		-- upvalues: (copy) p_u_79
		p_u_79:_GeneratePlayers()
	end)
	v_u_6.ObjectAdded:Connect(function()
		-- upvalues: (copy) p_u_79
		p_u_79:_GeneratePlayers()
	end)
	v_u_6.ObjectRemoved:Connect(function()
		-- upvalues: (copy) p_u_79
		p_u_79:_GeneratePlayers()
	end)
	v_u_9.VisibilityChanged:Connect(function()
		-- upvalues: (copy) p_u_79
		p_u_79:_UpdateLeaveButtons()
	end)
	p_u_79:_UpdateLayouts()
	p_u_79:_UpdateLeaveButtons()
	task.defer(p_u_79._SetTab, p_u_79, "All")
	task.defer(p_u_79._GeneratePlayers, p_u_79)
	task.defer(p_u_79._GenerateMembers, p_u_79)
	v_u_11:Add(p_u_79.CloseButton)
	v_u_11:Add(p_u_79.AllButton)
	v_u_11:Add(p_u_79.FriendsButton)
	v_u_11:Add(p_u_79.LobbyButton)
end
return v_u_14._new()