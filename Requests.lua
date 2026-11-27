local v_u_1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("GuiService")
local v3 = game:GetService("Players")
local v_u_4 = require(v_u_1.Modules.CONSTANTS)
local v_u_5 = require(v3.LocalPlayer.PlayerScripts.Controllers:WaitForChild("PlayerDataController"))
local v_u_6 = require(v3.LocalPlayer.PlayerScripts.Controllers:WaitForChild("ComplianceController"))
local v_u_7 = require(v3.LocalPlayer.PlayerScripts.Controllers:WaitForChild("QueuePadController"))
local v_u_8 = require(v3.LocalPlayer.PlayerScripts.Controllers:WaitForChild("FighterController"))
local v_u_9 = require(v3.LocalPlayer.PlayerScripts.Controllers:WaitForChild("SocialController"))
local v_u_10 = require(v3.LocalPlayer.PlayerScripts.Modules.UserInterface:WaitForChild("MobileInputs"))
local v_u_11 = require(v3.LocalPlayer.PlayerScripts.Modules.UserInterface:WaitForChild("Teleporting"))
local v_u_12 = require(v3.LocalPlayer.PlayerScripts.Modules.UserInterface:WaitForChild("PlayerList"))
local v_u_13 = require(v3.LocalPlayer.PlayerScripts.Modules.UserInterface:WaitForChild("Equipment"))
local v_u_14 = require(v3.LocalPlayer.PlayerScripts.Modules:WaitForChild("JoinQueuePadSlot"))
local v_u_15 = require(v3.LocalPlayer.PlayerScripts.Modules.UserInterface:WaitForChild("Queue"))
local v_u_16 = require(v3.LocalPlayer.PlayerScripts.Modules.UserInterface:WaitForChild("Pages"))
local v_u_17 = require(v3.LocalPlayer.PlayerScripts.Modules:WaitForChild("ButtonEffect"))
local v_u_18 = require(v3.LocalPlayer.PlayerScripts.Modules:WaitForChild("UILibrary"))
local v_u_19 = v3.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("RequestChallengeSlot")
local v_u_20 = v3.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("RequestPartySlot")
local v_u_21 = {}
v_u_21.__index = v_u_21
function v_u_21._new() -- name: _new
	-- upvalues: (copy) v_u_21, (copy) v_u_18
	local v22 = v_u_21
	local v23 = setmetatable({}, v22)
	v23.Frame = v_u_18:GetTo("MainFrame", "Lobby", "Requests")
	v23.Container = v23.Frame:WaitForChild("Container")
	v23.PlayerListBuffer = v23.Container:WaitForChild("PlayerListBuffer")
	v23:_Init()
	return v23
end
function v_u_21.SendRequest(p24, p_u_25, p26, p27, p_u_28, p_u_29) -- name: SendRequest
	-- upvalues: (copy) v_u_8, (copy) v_u_18, (copy) v_u_6, (copy) v_u_4, (copy) v_u_17, (copy) v_u_12
	if p_u_25 then
		local v30 = v_u_8:GetFighter(p_u_25)
		local v_u_31 = p26:Clone()
		v_u_31.Container.Background.ImageColor3 = v_u_18.BUTTON_BACKGROUND_COLOR
		v_u_31.Container.Background.ImageTransparency = v_u_18.BUTTON_BACKGROUND_TRANSPARENCY
		v_u_31.Container.DisplayName.Text = v_u_6:GetName(p_u_25)
		local v32 = v_u_31.Container.DisplayName.Controls
		local v33 = v_u_4.CONTROLS_IMAGES
		if v30 then
			v30 = v30:Get("Controls")
		end
		v32.Image = v33[v30] or ""
		v_u_31.Container.Headshot.Image = string.format(v_u_4.HEADSHOT_IMAGE, p_u_25.UserId)
		v_u_31.Parent = p24.Container
		v_u_17:Add(v_u_31.Container.Accept)
		v_u_17:Add(v_u_31.Container.Decline)
		local function v34() -- name: remove
			-- upvalues: (copy) v_u_31, (copy) p_u_28, (ref) v_u_12, (copy) p_u_25
			v_u_31:Destroy()
			if p_u_28 then
				v_u_12:SetRequestDuration(p_u_25, p_u_28, 0)
			end
		end
		v_u_31.Container.Decline.MouseButton1Click:Connect(v34)
		task.delay(p27, v34)
		v_u_31.Container.Accept.MouseButton1Click:Connect(function()
			-- upvalues: (copy) p_u_29, (copy) v_u_31, (copy) p_u_28, (ref) v_u_12, (copy) p_u_25
			if p_u_29 then
				p_u_29()
			end
			v_u_31:Destroy()
			if p_u_28 then
				v_u_12:SetRequestDuration(p_u_25, p_u_28, 0)
			end
		end)
		v_u_31.Container.DisplayName:GetPropertyChangedSignal("TextBounds"):Connect(function() -- name: update
			-- upvalues: (copy) v_u_31
			v_u_31.Container.DisplayName.Controls.Position = UDim2.new(0, v_u_31.Container.DisplayName.TextBounds.X, 0.5, 0)
		end)
		v_u_31.Container.DisplayName.Controls.Position = UDim2.new(0, v_u_31.Container.DisplayName.TextBounds.X, 0.5, 0)
		v_u_31.Container.Position = UDim2.new(4, 0, 0, 0)
		v_u_31.Container:TweenPosition(UDim2.new(0, 0, 0, 0), "Out", "Quint", 0.5, true)
		v_u_31.Container.Timeout.Bar.Size = UDim2.new(1, 0, 1, 0)
		v_u_31.Container.Timeout.Bar:TweenSize(UDim2.new(0, 0, 1, 0), "Out", "Linear", p27, true)
		if p_u_28 then
			v_u_12:SetRequestDuration(p_u_25, p_u_28, p27)
		end
	end
end
function v_u_21.ChallengeRequest(p35, p_u_36, p37) -- name: ChallengeRequest
	-- upvalues: (copy) v_u_19, (copy) v_u_1
	if p35:_CanReceiveRequest(p_u_36, "Challenge Requests") then
		p35:SendRequest(p_u_36, v_u_19, p37, "Challenge", function()
			-- upvalues: (ref) v_u_1, (copy) p_u_36
			v_u_1.Remotes.Misc.AcceptChallengeRequest:FireServer(p_u_36)
		end)
	end
end
function v_u_21.PartyRequest(p38, p_u_39, p40) -- name: PartyRequest
	-- upvalues: (copy) v_u_20, (copy) v_u_1
	if p38:_CanReceiveRequest(p_u_39, "Party Invites") then
		p38:SendRequest(p_u_39, v_u_20, p40, "Party", function()
			-- upvalues: (ref) v_u_1, (copy) p_u_39
			v_u_1.Remotes.Matchmaking.AcceptPartyInvite:FireServer(p_u_39)
		end)
	end
end
function v_u_21._UpdatePlayerList(p41) -- name: _UpdatePlayerList
	-- upvalues: (copy) v_u_12
	local v42 = v_u_12.Elements.Frame.AbsolutePosition.Y - v_u_12.Frame.AbsolutePosition.Y + (not v_u_12.IsOpen and -4 or v_u_12.Elements.Frame.AbsoluteSize.Y)
	p41.PlayerListBuffer:TweenSize(UDim2.new(1, 0, 0, v42), "Out", "Quint", 0.25, true)
	p41.Container.Size = UDim2.new(0, v_u_12.Elements.Frame.AbsoluteSize.X, 0, v_u_12.Elements.Frame.AbsoluteSize.X)
end
function v_u_21._UpdateVisibility(p43) -- name: _UpdateVisibility
	-- upvalues: (copy) v_u_16, (copy) v_u_13, (copy) v_u_15, (copy) v_u_11, (copy) v_u_10, (copy) v_u_2
	local v44 = not (v_u_16.PageSystem.CurrentPage or (v_u_13.IsOpen or v_u_15:IsVisible() or (v_u_11.Enabled or v_u_10.EditorEnabled)))
	if v44 then
		v44 = not v_u_2.MenuIsOpen
	end
	local v45 = p43.Container
	local v46
	if v44 then
		v46 = UDim2.new(1, 0, 0, 0)
	else
		v46 = UDim2.new(2, 20, 0, 0)
	end
	v45:TweenPosition(v46, "Out", "Quint", 0.25, true)
end
function v_u_21._CanReceiveRequest(_, p47, p48) -- name: _CanReceiveRequest
	-- upvalues: (copy) v_u_5, (copy) v_u_9
	local v49 = v_u_5:GetSetting(p48)
	if v49 == "Everyone" then
		return true
	elseif v49 == "Friends" then
		return v_u_9:IsFriendsWith(p47.UserId)
	else
		return false
	end
end
function v_u_21._QueuePadAdded(p50, p51) -- name: _QueuePadAdded
	-- upvalues: (copy) v_u_14
	v_u_14.new(p51).Frame.Parent = p50.Container
end
function v_u_21._Init(p_u_52) -- name: _Init
	-- upvalues: (copy) v_u_13, (copy) v_u_16, (copy) v_u_15, (copy) v_u_11, (copy) v_u_10, (copy) v_u_2, (copy) v_u_12, (copy) v_u_7
	v_u_13.Opened:Connect(function()
		-- upvalues: (copy) p_u_52
		p_u_52:_UpdateVisibility()
	end)
	v_u_16.PageSystem.PageOpened:Connect(function()
		-- upvalues: (copy) p_u_52
		p_u_52:_UpdateVisibility()
	end)
	v_u_16.PageSystem.PageClosed:Connect(function()
		-- upvalues: (copy) p_u_52
		p_u_52:_UpdateVisibility()
	end)
	v_u_15.VisibilityChanged:Connect(function()
		-- upvalues: (copy) p_u_52
		p_u_52:_UpdateVisibility()
	end)
	v_u_11.EnabledChanged:Connect(function()
		-- upvalues: (copy) p_u_52
		p_u_52:_UpdateVisibility()
	end)
	v_u_10.EditorEnabledChanged:Connect(function()
		-- upvalues: (copy) p_u_52
		p_u_52:_UpdateVisibility()
	end)
	v_u_2:GetPropertyChangedSignal("MenuIsOpen"):Connect(function()
		-- upvalues: (copy) p_u_52
		p_u_52:_UpdateVisibility()
	end)
	v_u_12.Frame:GetPropertyChangedSignal("AbsolutePosition"):Connect(function()
		-- upvalues: (copy) p_u_52
		p_u_52:_UpdatePlayerList()
	end)
	v_u_12.Elements.Frame:GetPropertyChangedSignal("AbsolutePosition"):Connect(function()
		-- upvalues: (copy) p_u_52
		p_u_52:_UpdatePlayerList()
	end)
	v_u_12.Elements.Frame:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
		-- upvalues: (copy) p_u_52
		p_u_52:_UpdatePlayerList()
	end)
	v_u_12.OpenedChanged:Connect(function()
		-- upvalues: (copy) p_u_52
		p_u_52:_UpdatePlayerList()
	end)
	v_u_7.ObjectAdded:Connect(function(p53)
		-- upvalues: (copy) p_u_52
		p_u_52:_QueuePadAdded(p53)
	end)
	for _, v54 in pairs(v_u_7.Objects) do
		task.defer(p_u_52._QueuePadAdded, p_u_52, v54)
	end
	p_u_52:_UpdateVisibility()
	p_u_52:_UpdatePlayerList()
end
return v_u_21._new()