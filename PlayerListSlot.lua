local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("UserInputService")
local v_u_3 = game:GetService("HttpService")
local v_u_4 = game:GetService("StarterGui")
local v_u_5 = game:GetService("RunService")
local v6 = game:GetService("Players")
local v_u_7 = require(v1.Modules.CONSTANTS)
local v_u_8 = require(v1.Modules.PlayerDataUtility)
require(v1.Modules.DebugLibrary)
local v_u_9 = require(v1.Modules.Utility)
local v_u_10 = require(v1.Modules.Signal)
local v_u_11 = require(v6.LocalPlayer.PlayerScripts.Controllers.MatchmakingController)
local v_u_12 = require(v6.LocalPlayer.PlayerScripts.Controllers.LeaderboardController)
require(v6.LocalPlayer.PlayerScripts.Controllers.PlayerDataController)
local v_u_13 = require(v6.LocalPlayer.PlayerScripts.Controllers.SocialController)
local v_u_14 = require(v6.LocalPlayer.PlayerScripts.Modules.WeaponStatusHandler)
local v_u_15 = require(v6.LocalPlayer.PlayerScripts.Modules.ButtonEffect)
local v_u_16 = require(v6.LocalPlayer.PlayerScripts.Modules.RankIcon)
local v_u_17 = v6.LocalPlayer.PlayerScripts.UserInterface.PlayerListSlot
local v_u_18 = { 0.45, "rbxassetid://89686341813708" }
local v_u_19 = { 0.625, "rbxassetid://140099562989635" }
local v_u_20 = { 0.45, "rbxassetid://114408044569826" }
local v_u_21 = { 0.6, "rbxassetid://134084662516990" }
local v_u_22 = { 0.5, "rbxassetid://108431611670429" }
local v_u_23 = { 0.5, "rbxassetid://104322490200835" }
local v_u_24 = { 0.4, "rbxassetid://97625610157994" }
local v_u_25 = { 0.5, "rbxassetid://118031781381166" }
local v_u_26 = { 0.4, "rbxassetid://105897927" }
local v_u_27 = { 0.6, "rbxassetid://113059239" }
local v_u_28 = { 0.6, "rbxassetid://134032333" }
local v_u_29 = {}
v_u_29.__index = v_u_29
function v_u_29.new(p30, p31) -- name: new
	-- upvalues: (copy) v_u_29, (copy) v_u_10, (copy) v_u_17
	local v32 = v_u_29
	local v33 = setmetatable({}, v32)
	v33.Clicked = v_u_10.new()
	v33.Elements = p30
	v33.ClientFighter = p31
	v33.Frame = v_u_17:Clone()
	v33.Button = v33.Frame:WaitForChild("Button")
	v33.RequestsFrame = v33.Frame:WaitForChild("Requests")
	v33.HighlightFrame = v33.Frame:WaitForChild("Highlight")
	v33.LeaderstatFrame = v33.Frame:WaitForChild("Leaderstat")
	v33.LeaderstatTitle = v33.LeaderstatFrame:WaitForChild("Title")
	v33.LeaderstatRankContainer = v33.LeaderstatFrame:WaitForChild("RankContainer")
	v33.PlayerContainer = v33.Frame:WaitForChild("Player"):WaitForChild("Container")
	v33.PlayerIcon = v33.PlayerContainer:WaitForChild("Icon")
	v33.PlayerTitle = v33.PlayerContainer:WaitForChild("Title")
	v33.PlayerTitleIcon = v33.PlayerTitle:WaitForChild("Icon")
	v33._connections = {}
	v33._is_highlighted = false
	v33._is_hovered = false
	v33._leaderstat_name = nil
	v33._leaderstat_rank_icon = nil
	v33._is_friend = nil
	v33._is_blocked = nil
	v33._request_effect_threads = {}
	v33:_Init()
	return v33
end
function v_u_29.IsFriend(p34) -- name: IsFriend
	return p34._is_friend
end
function v_u_29.IsBlocked(p35) -- name: IsBlocked
	return p35._is_blocked
end
function v_u_29.SetParent(p36, p37) -- name: SetParent
	p36.Frame.Parent = p37
end
function v_u_29.SetLeaderstat(p38, p39) -- name: SetLeaderstat
	p38._leaderstat_name = p39
	p38:_UpdateLeaderstat()
end
function v_u_29.SetHighlighted(p40, p41) -- name: SetHighlighted
	p40._is_highlighted = p41
	p40:_UpdateHighlight()
end
function v_u_29.SetIsFriend(p42, p43) -- name: SetIsFriend
	if p42._is_friend ~= p43 then
		p42._is_friend = p43
		p42:_UpdateIcon()
	end
end
function v_u_29.SetIsBlocked(p44, p45) -- name: SetIsBlocked
	if p44._is_blocked ~= p45 then
		p44._is_blocked = p45
		p44:_UpdateIcon()
	end
end
function v_u_29.SetRequestDuration(p_u_46, p_u_47, p_u_48) -- name: SetRequestDuration
	-- upvalues: (copy) v_u_5
	if p_u_46._request_effect_threads[p_u_47] then
		task.cancel(p_u_46._request_effect_threads[p_u_47])
		p_u_46._request_effect_threads[p_u_47] = nil
	end
	p_u_46._request_effect_threads[p_u_47] = task.spawn(function()
		-- upvalues: (copy) p_u_48, (copy) p_u_46, (copy) p_u_47, (ref) v_u_5
		local v49 = tick() + p_u_48
		local v50 = p_u_46.RequestsFrame[p_u_47]
		local v51 = v50.UIStroke.UIGradient
		v50.Visible = true
		while tick() < v49 do
			v51.Rotation = tick() * 90 % 360
			v_u_5.RenderStepped:Wait()
		end
		v50.Visible = false
	end)
end
function v_u_29.OnOpened(p52) -- name: OnOpened
	p52:_UpdateLeaderstat()
	p52:_UpdateIcon()
	p52:_UpdateVisuals()
	p52:_UpdateStatus()
end
function v_u_29.Destroy(p53) -- name: Destroy
	for _, v54 in pairs(p53._connections) do
		v54:Disconnect()
	end
	for _, v55 in pairs(p53._request_effect_threads) do
		local v56 = task.cancel
		pcall(v56, v55)
	end
	if p53._leaderstat_rank_icon then
		p53._leaderstat_rank_icon:Destroy()
		p53._leaderstat_rank_icon = nil
	end
	p53.Clicked:Destroy()
	p53.Frame:Destroy()
end
function v_u_29._UpdateVisuals(p_u_57) -- name: _UpdateVisuals
	if p_u_57.Elements.PlayerList.IsOpen then
		task.delay(0, function()
			-- upvalues: (copy) p_u_57
			p_u_57.PlayerTitleIcon.Position = UDim2.new(0, p_u_57.PlayerTitle.TextBounds.X, 0.5, 0)
		end)
	end
end
function v_u_29._UpdateIcon(p58) -- name: _UpdateIcon
	-- upvalues: (copy) v_u_24, (copy) v_u_25, (copy) v_u_26, (copy) v_u_27, (copy) v_u_28, (copy) v_u_18, (copy) v_u_8, (copy) v_u_3, (copy) v_u_19, (copy) v_u_20, (copy) v_u_21, (copy) v_u_23, (copy) v_u_22, (copy) v_u_7
	if p58.Elements.PlayerList.IsOpen then
		local v59
		if p58._is_blocked then
			v59 = v_u_24
		elseif p58._is_friend then
			v59 = v_u_25
		elseif p58.ClientFighter.Player.UserId == 261 then
			v59 = v_u_26
		elseif p58.ClientFighter.Player.UserId == 13268404 then
			v59 = v_u_27
		elseif p58.ClientFighter.Player.UserId == 7210880 then
			v59 = v_u_28
		elseif p58.ClientFighter.Player:GetAttribute("DisableTeamVisuals") or not p58.ClientFighter.Player:GetAttribute("IsAdministrator") then
			if p58.ClientFighter.Player:GetAttribute("DisableTeamVisuals") or not v_u_8:IsNosniyGamesTeamMemberRaw(v_u_3:JSONDecode(p58.ClientFighter.Player:GetAttribute("GroupRoleIDs") or {})) then
				if p58.ClientFighter.Player:GetAttribute("IsRobloxEmployee") then
					v59 = v_u_20
				elseif p58.ClientFighter.Player:GetAttribute("IsInfluencer") then
					v59 = v_u_21
				elseif p58.ClientFighter.Player.HasRobloxSubscription then
					v59 = v_u_23
				elseif p58.ClientFighter.Player.MembershipType == Enum.MembershipType.Premium then
					v59 = v_u_22
				else
					v59 = nil
				end
			else
				v59 = v_u_19
			end
		else
			v59 = v_u_18
		end
		p58.PlayerIcon.Image = v59 and (v59[2] or "") or ""
		p58.PlayerIcon.Size = v59 and UDim2.new(v59[1], 0, v59[1], 0) or UDim2.new(0, 0, 0, 0)
		p58.PlayerTitleIcon.Image = v_u_7.CONTROLS_IMAGES_CENTERED[p58.ClientFighter:Get("Controls")] or ""
	end
end
function v_u_29._UpdateStatus(p60) -- name: _UpdateStatus
	-- upvalues: (copy) v_u_14
	if p60.Elements.PlayerList.IsOpen then
		v_u_14:ClearStatusElements(p60.PlayerTitle)
		v_u_14:ApplyItemStatusToText(p60.PlayerTitle, p60.ClientFighter.Player:GetAttribute("PlayerStatus"))
	end
end
function v_u_29._UpdateLeaderstat(p61) -- name: _UpdateLeaderstat
	-- upvalues: (copy) v_u_7, (copy) v_u_11, (copy) v_u_16, (copy) v_u_9
	if p61.Elements.PlayerList.IsOpen then
		if p61._leaderstat_rank_icon then
			p61._leaderstat_rank_icon:Destroy()
			p61._leaderstat_rank_icon = nil
		end
		local v62 = p61._leaderstat_name and p61.ClientFighter.Player:FindFirstChild("CustomLeaderstats")
		if v62 then
			v62 = p61.ClientFighter.Player.CustomLeaderstats:FindFirstChild(p61._leaderstat_name)
		end
		p61.Frame.LayoutOrder = v62 and (-v62.Value or 1) or 1
		if v62 and not v62:GetAttribute("StillLoading") then
			if p61._leaderstat_name == "Current ELO" then
				p61.LeaderstatTitle.Text = ""
				local v63 = v_u_7.IS_MATCHMAKING_SERVER
				if v63 then
					v63 = not v_u_11:Get("MatchmadeGameOver")
				end
				if not v63 then
					p61._leaderstat_rank_icon = v_u_16.new(v62.Value, p61.ClientFighter.Player.UserId)
					p61._leaderstat_rank_icon:SetParent(p61.LeaderstatRankContainer)
				end
			else
				p61.LeaderstatTitle.Text = not v62.Value and "\226\128\162 \226\128\162 \226\128\162" or v_u_9:PrettyNumber(v62.Value)
			end
		else
			p61.LeaderstatTitle.Text = "\226\128\162 \226\128\162 \226\128\162"
			return
		end
	else
		return
	end
end
function v_u_29._UpdateHighlight(p64) -- name: _UpdateHighlight
	p64.HighlightFrame.BackgroundTransparency = p64._is_highlighted and 0.875 or (p64._is_hovered and 0.95 or 1)
end
function v_u_29._SetHovered(p65, p66) -- name: _SetHovered
	p65._is_hovered = p66
	p65:_UpdateHighlight()
end
function v_u_29._FetchIsBlocked(p67) -- name: _FetchIsBlocked
	-- upvalues: (copy) v_u_4
	local v68 = v_u_4.GetCore
	local v69 = v_u_4
	local v70, v71 = pcall(v68, v69, "GetBlockedUserIds")
	if v70 then
		v70 = table.find(v71, p67.ClientFighter.Player.UserId) ~= nil
	end
	p67:SetIsBlocked(v70)
end
function v_u_29._FetchIsFriend(p72) -- name: _FetchIsFriend
	-- upvalues: (copy) v_u_13
	if p72.ClientFighter.IsLocalPlayer then
		p72:SetIsFriend(false)
	else
		p72:SetIsFriend(v_u_13:IsFriendsWith(p72.ClientFighter.Player.UserId))
	end
end
function v_u_29._SetupLeaderstats(p_u_73) -- name: _SetupLeaderstats
	local v74 = p_u_73.ClientFighter.Player:WaitForChild("CustomLeaderstats")
	local v75 = p_u_73._connections
	local v76 = v74.ChildRemoved
	table.insert(v75, v76:Connect(function()
		-- upvalues: (copy) p_u_73
		p_u_73:_UpdateLeaderstat()
	end))
	local function v79(p77, p78) -- name: object_added
		-- upvalues: (copy) p_u_73
		p77:GetPropertyChangedSignal("Value"):Connect(function()
			-- upvalues: (ref) p_u_73
			p_u_73:_UpdateLeaderstat()
		end)
		p77:GetAttributeChangedSignal("StillLoading"):Connect(function()
			-- upvalues: (ref) p_u_73
			p_u_73:_UpdateLeaderstat()
		end)
		if not p78 then
			p_u_73:_UpdateLeaderstat()
		end
	end
	local v80 = p_u_73._connections
	local v81 = v74.ChildAdded
	table.insert(v80, v81:Connect(v79))
	for _, v82 in pairs(v74:GetChildren()) do
		task.spawn(v79, v82, true)
	end
	p_u_73:_UpdateLeaderstat()
end
function v_u_29._Setup(p83) -- name: _Setup
	-- upvalues: (copy) v_u_9
	p83.PlayerTitle.Text = v_u_9:GetName(p83.ClientFighter.Player, p83.ClientFighter.Player.DisplayName, true)
end
function v_u_29._Init(p_u_84) -- name: _Init
	-- upvalues: (copy) v_u_12, (copy) v_u_2, (copy) v_u_11, (copy) v_u_15
	p_u_84.Button.MouseButton1Click:Connect(function()
		-- upvalues: (copy) p_u_84
		p_u_84.Clicked:Fire()
	end)
	p_u_84.Button.MouseEnter:Connect(function()
		-- upvalues: (copy) p_u_84
		p_u_84:_SetHovered(true)
	end)
	p_u_84.Button.MouseLeave:Connect(function()
		-- upvalues: (copy) p_u_84
		p_u_84:_SetHovered(false)
	end)
	p_u_84.PlayerTitle:GetPropertyChangedSignal("TextBounds"):Connect(function()
		-- upvalues: (copy) p_u_84
		p_u_84:_UpdateVisuals()
	end)
	p_u_84.PlayerTitle:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
		-- upvalues: (copy) p_u_84
		p_u_84:_UpdateVisuals()
	end)
	p_u_84.PlayerTitle:GetPropertyChangedSignal("AbsolutePosition"):Connect(function()
		-- upvalues: (copy) p_u_84
		p_u_84:_UpdateVisuals()
	end)
	local v85 = p_u_84._connections
	local v86 = p_u_84.ClientFighter:GetDataChangedSignal("Controls")
	table.insert(v85, v86:Connect(function()
		-- upvalues: (copy) p_u_84
		p_u_84:_UpdateIcon()
	end))
	local v87 = p_u_84._connections
	local v88 = p_u_84.ClientFighter.Player:GetAttributeChangedSignal("GroupRoleIDs")
	table.insert(v87, v88:Connect(function()
		-- upvalues: (copy) p_u_84
		p_u_84:_UpdateIcon()
	end))
	local v89 = p_u_84._connections
	local v90 = p_u_84.ClientFighter.Player:GetAttributeChangedSignal("IsAdministrator")
	table.insert(v89, v90:Connect(function()
		-- upvalues: (copy) p_u_84
		p_u_84:_UpdateIcon()
	end))
	local v91 = p_u_84._connections
	local v92 = p_u_84.ClientFighter.Player:GetAttributeChangedSignal("IsRobloxEmployee")
	table.insert(v91, v92:Connect(function()
		-- upvalues: (copy) p_u_84
		p_u_84:_UpdateIcon()
	end))
	local v93 = p_u_84._connections
	local v94 = p_u_84.ClientFighter.Player:GetAttributeChangedSignal("IsInfluencer")
	table.insert(v93, v94:Connect(function()
		-- upvalues: (copy) p_u_84
		p_u_84:_UpdateIcon()
	end))
	local v95 = p_u_84._connections
	local v96 = p_u_84.ClientFighter.Player:GetPropertyChangedSignal("MembershipType")
	table.insert(v95, v96:Connect(function()
		-- upvalues: (copy) p_u_84
		p_u_84:_UpdateIcon()
	end))
	local v97 = p_u_84._connections
	local v98 = p_u_84.ClientFighter.Player:GetAttributeChangedSignal("DisableTeamVisuals")
	table.insert(v97, v98:Connect(function()
		-- upvalues: (copy) p_u_84
		p_u_84:_UpdateIcon()
	end))
	local v99 = p_u_84._connections
	local v100 = p_u_84.ClientFighter.Player:GetAttributeChangedSignal("PlayerStatus")
	table.insert(v99, v100:Connect(function()
		-- upvalues: (copy) p_u_84
		p_u_84:_UpdateStatus()
	end))
	local v101 = p_u_84._connections
	local v102 = v_u_12:GetLeaderboardRefreshedSignal("Highest ELO")
	table.insert(v101, v102:Connect(function()
		-- upvalues: (copy) p_u_84
		p_u_84:_UpdateLeaderstat()
	end))
	local v103 = p_u_84._connections
	local v104 = v_u_2.WindowFocused
	table.insert(v103, v104:Connect(function()
		-- upvalues: (copy) p_u_84
		p_u_84:_UpdateVisuals()
	end))
	local v105 = p_u_84._connections
	local v106 = v_u_2.WindowFocusReleased
	table.insert(v105, v106:Connect(function()
		-- upvalues: (copy) p_u_84
		p_u_84:_UpdateVisuals()
	end))
	local v107 = p_u_84._connections
	local v108 = v_u_11:GetDataChangedSignal("MatchmadeGameOver")
	table.insert(v107, v108:Connect(function()
		-- upvalues: (copy) p_u_84
		p_u_84:_UpdateLeaderstat()
	end))
	p_u_84:_Setup()
	p_u_84:_UpdateIcon()
	p_u_84:_UpdateStatus()
	p_u_84:_UpdateVisuals()
	p_u_84:_UpdateHighlight()
	p_u_84:_UpdateLeaderstat()
	task.spawn(p_u_84._FetchIsFriend, p_u_84)
	task.spawn(p_u_84._FetchIsBlocked, p_u_84)
	task.spawn(p_u_84._SetupLeaderstats, p_u_84)
	v_u_15:Add(p_u_84.Button, true)
end
return v_u_29