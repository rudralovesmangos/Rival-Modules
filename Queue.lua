local v_u_1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("TweenService")
local v_u_3 = game:GetService("RunService")
local v_u_4 = game:GetService("Players")
local v_u_5 = require(v_u_1.Modules.CONSTANTS)
local v_u_6 = require(v_u_1.Modules.Utility)
local v_u_7 = require(v_u_1.Modules.Signal)
local v_u_8 = require(v_u_4.LocalPlayer.PlayerScripts.Controllers:WaitForChild("FighterController"))
local v_u_9 = require(v_u_4.LocalPlayer.PlayerScripts.Controllers:WaitForChild("SocialController"))
local v_u_10 = require(v_u_4.LocalPlayer.PlayerScripts.Controllers:WaitForChild("QueuePadController"))
local v_u_11 = require(v_u_4.LocalPlayer.PlayerScripts.Modules:WaitForChild("ButtonEffect"))
local v_u_12 = require(v_u_4.LocalPlayer.PlayerScripts.Modules:WaitForChild("TeammateSlot"))
local v_u_13 = require(v_u_4.LocalPlayer.PlayerScripts.Modules:WaitForChild("UILibrary"))
local v_u_14 = v_u_4.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("LocalQueuePlayerSlot")
local v_u_15 = v_u_4.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("TitleVS")
local v_u_16 = {}
v_u_16.__index = v_u_16
function v_u_16._new() -- name: _new
	-- upvalues: (copy) v_u_16, (copy) v_u_7, (copy) v_u_13
	local v17 = v_u_16
	local v18 = setmetatable({}, v17)
	v18.VisibilityChanged = v_u_7.new()
	v18.Frame = v_u_13:GetTo("MainFrame", "Queue")
	v18.Container = v18.Frame:WaitForChild("Container")
	v18._cleanup = {}
	v18._countdown_hash = 0
	v18._last_countdown_sound = nil
	v18:_Init()
	return v18
end
function v_u_16.IsVisible(p19) -- name: IsVisible
	return p19.Frame.Visible
end
function v_u_16._UpdateInviteFrame(p20) -- name: _UpdateInviteFrame
	-- upvalues: (copy) v_u_9
	local v21 = p20.Container.Invite
	local v22 = v_u_9.CanSendGameInvite
	if v22 then
		v22 = not p20.Container.Countdown.Visible
	end
	v21.Visible = v22
end
function v_u_16._UpdateWaitingBackground(p23) -- name: _UpdateWaitingBackground
	p23.Container.Waiting.Background.Size = UDim2.new(0, p23.Container.Background.AbsoluteSize.X, 0, p23.Container.Background.AbsoluteSize.Y)
end
function v_u_16._StartCountdown(p24) -- name: _StartCountdown
	-- upvalues: (copy) v_u_6, (copy) v_u_2, (copy) v_u_3
	p24._countdown_hash = p24._countdown_hash + 1
	local v25 = p24._countdown_hash
	p24.Container.Countdown.Visible = true
	p24.Container.Waiting.Visible = false
	p24.Container.Start.Visible = false
	for v26 = 3, 1, -1 do
		if v25 ~= p24._countdown_hash then
			return
		end
		p24.Container.Countdown.Value.Text = v26
		p24._last_countdown_sound = v_u_6:CreateSound("rbxassetid://17259538274", 0.5, 1, script, true, 5)
		local v27 = tick()
		while tick() < v27 + 0.375 do
			if v25 ~= p24._countdown_hash then
				return
			end
			local v28 = (tick() - v27) / 0.375
			local v29 = v_u_2:GetValue(v28, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
			local v30 = v_u_2:GetValue(v28, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
			p24.Container.Countdown.Value.Size = UDim2.new(1, 0, 1.25 - 0.625 * v29)
			p24.Container.Countdown.Glow.ImageTransparency = 0.875 - 0.25 * v30
			p24.Container.Countdown.Glow.Size = UDim2.new(v30, 0, v30, 0)
			v_u_3.RenderStepped:Wait()
		end
		local v31 = tick()
		while tick() < v31 + 0.625 do
			if v25 ~= p24._countdown_hash then
				return
			end
			local v32 = (tick() - v31) / 0.625
			local v33 = v_u_2:GetValue(v32, Enum.EasingStyle.Quint, Enum.EasingDirection.In)
			local v34 = v_u_2:GetValue(v32, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
			p24.Container.Countdown.Value.Size = UDim2.new(1, 0, 0.625 - 0.625 * v33)
			p24.Container.Countdown.Glow.ImageTransparency = 0.625 + 0.25 * v34
			v_u_3.RenderStepped:Wait()
		end
	end
end
function v_u_16._StopCountdown(p35) -- name: _StopCountdown
	p35._countdown_hash = p35._countdown_hash + 1
	p35.Container.Countdown.Visible = false
	if p35._last_countdown_sound then
		p35._last_countdown_sound:Destroy()
		p35._last_countdown_sound = nil
	end
end
function v_u_16._Update(p36) -- name: _Update
	-- upvalues: (copy) v_u_10, (copy) v_u_4, (copy) v_u_8, (copy) v_u_14, (copy) v_u_12, (copy) v_u_15, (copy) v_u_5
	for _, v37 in pairs(p36._cleanup) do
		v37:Destroy()
	end
	p36._cleanup = {}
	local v38 = v_u_10:GetQueuePad(v_u_4.LocalPlayer)
	p36.Frame.Visible = v38 and true or false
	p36.VisibilityChanged:Fire()
	if not p36.Frame.Visible then
		p36.Frame.UIScale.Scale = 1
		p36:_StopCountdown()
		return
	end
	local v39 = v38:GetClientFightersWaiting()
	local v40 = 0
	local v41 = 0
	local v42 = 0
	local v43 = 0
	local v44 = 0
	local v45 = 0
	local v46 = 0
	for v47 = 1, v38:Get("NumTeams") do
		local v48 = v39[v47]
		local v49 = #v48
		v40 = math.max(v40, v49)
		v46 = table.find(v48, v_u_8.LocalFighter) and (#v48 or v46) or v46
		local v50 = false
		local v51 = false
		for v52 = 1, v38:Get("InfinitePlayersPerTeam") and (1 / 0) or v38:Get("PlayersPerTeam") do
			local v53 = v48[v52]
			if not v53 and v38:Get("InfinitePlayersPerTeam") then
				if v50 then
					break
				end
				v50 = true
			end
			local v54 = v_u_14:Clone()
			local v55
			if v38:Get("NumTeams") == 2 and v47 == 1 then
				v55 = -v44 or v44
			else
				v55 = v44
			end
			v54.LayoutOrder = v55
			local v56 = v54.Container.Ready
			local v57
			if v53 then
				v57 = v38:IsReady(v53.Player)
			else
				v57 = v53
			end
			v56.Visible = v57
			v54.Parent = p36.Container.Details
			local v58 = p36._cleanup
			table.insert(v58, v54)
			v45 = v45 + 1
			v44 = v44 + 1
			if v53 then
				v54.Container.Dots:Destroy()
				local v59 = v_u_12.new(v53.Player.UserId, v53:Get("Controls"), 1, false, true, v53.Player:GetAttribute("StatisticDuelsWinStreak"), v53.Player:GetAttribute("Level"))
				v59.SlotFrame.Container.Background.Visible = false
				v59.SlotFrame.Parent = v54.Container
				local v60 = p36._cleanup
				table.insert(v60, v59)
				v42 = v42 + 1
				v51 = true
			else
				v54.Container.Dots:AddTag("UILoadingDots")
			end
		end
		if v47 ~= v38:Get("NumTeams") then
			local v61 = v_u_15:Clone()
			v61.LayoutOrder = v44
			v61.Parent = p36.Container.Details
			local v62 = p36._cleanup
			table.insert(v62, v61)
			v41 = v41 + 1
			v44 = v44 + 1
		end
		if not v51 then
			break
		end
		v43 = v43 + 1
	end
	local v63 = p36.Frame.UIScale
	local v64 = 1.3 - v45 * 0.05
	v63.Scale = math.clamp(v64, 0.5, 1)
	p36.Container.Background.Size = UDim2.new(v41 * 0.7 + 0.125 + v45 * 0.875, 0, 1, 0)
	local v65 = p36.Container.Ready
	local v66 = not v38:Get("InfinitePlayersPerTeam")
	if v66 then
		if v43 == v38:Get("NumTeams") and v46 < v40 then
			v66 = not v38:IsReady(v_u_8.LocalFighter.Player)
		else
			v66 = false
		end
	end
	v65.Visible = v66
	local v67 = p36.Container.Start
	local v68 = v38:Get("InfinitePlayersPerTeam")
	if v68 then
		if v43 > 1 then
			v68 = v_u_5.IS_PRIVATE_SERVER_OWNER(v_u_4.LocalPlayer.UserId)
		else
			v68 = false
		end
	end
	v67.Visible = v68
	local v69 = p36.Container.Waiting
	local v70 = v38:Get("InfinitePlayersPerTeam")
	if v70 then
		if v43 > 1 then
			v70 = not v_u_5.IS_PRIVATE_SERVER_OWNER(v_u_4.LocalPlayer.UserId)
		else
			v70 = false
		end
	end
	v69.Visible = v70
	if v38:Get("IsStarting") then
		p36:_StartCountdown()
	else
		p36:_StopCountdown()
	end
end
function v_u_16._WaitForLocalFighter(p71) -- name: _WaitForLocalFighter
	-- upvalues: (copy) v_u_8
	v_u_8:WaitForLocalFighter()
	p71:_Update()
end
function v_u_16._Init(p_u_72) -- name: _Init
	-- upvalues: (copy) v_u_1, (copy) v_u_9, (copy) v_u_10, (copy) v_u_11
	p_u_72.Container.Background:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
		-- upvalues: (copy) p_u_72
		p_u_72:_UpdateWaitingBackground()
	end)
	p_u_72.Container.Countdown:GetPropertyChangedSignal("Visible"):Connect(function()
		-- upvalues: (copy) p_u_72
		p_u_72:_UpdateInviteFrame()
	end)
	p_u_72.Container.Start.MouseButton1Click:Connect(function()
		-- upvalues: (ref) v_u_1
		v_u_1.Remotes.PrivateServer.StartQueuePad:FireServer()
	end)
	p_u_72.Container.Ready.MouseButton1Click:Connect(function()
		-- upvalues: (ref) v_u_1
		v_u_1.Remotes.Misc.QueueReady:FireServer()
	end)
	p_u_72.Container.Invite.Button.MouseButton1Click:Connect(function()
		-- upvalues: (ref) v_u_9
		v_u_9:PromptFriendInvite()
	end)
	v_u_10.LocalPlayerActivity:Connect(function()
		-- upvalues: (copy) p_u_72
		p_u_72:_Update()
	end)
	v_u_9.CanSendGameInviteChanged:Connect(function()
		-- upvalues: (copy) p_u_72
		p_u_72:_UpdateInviteFrame()
	end)
	p_u_72:_Update()
	p_u_72:_UpdateInviteFrame()
	p_u_72:_UpdateWaitingBackground()
	task.spawn(p_u_72._WaitForLocalFighter, p_u_72)
	v_u_11:Add(p_u_72.Container.Start)
	v_u_11:Add(p_u_72.Container.Ready)
	v_u_11:Add(p_u_72.Container.Invite.Button, nil, {
		["HoverRatio"] = UDim2.new(0, 10, 0, 10),
		["ReleaseRatio"] = UDim2.new(0, 10, 0, 10)
	})
end
return v_u_16._new()