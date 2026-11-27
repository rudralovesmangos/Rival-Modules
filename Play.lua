local v_u_1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("GuiService")
local v_u_3 = game:GetService("Players")
local v_u_4 = require(v_u_1.Modules.CONSTANTS)
require(v_u_1.Modules.InputLibrary)
local v_u_5 = require(v_u_3.LocalPlayer.PlayerScripts.Controllers:WaitForChild("MatchmakingController"))
local v_u_6 = require(v_u_3.LocalPlayer.PlayerScripts.Controllers:WaitForChild("PlayerDataController"))
require(v_u_3.LocalPlayer.PlayerScripts.Controllers:WaitForChild("FighterController"))
local v_u_7 = require(v_u_3.LocalPlayer.PlayerScripts.Controllers:WaitForChild("ArcadeController"))
local v_u_8 = require(v_u_3.LocalPlayer.PlayerScripts.Controllers:WaitForChild("PartyController"))
local v_u_9 = require(v_u_3.LocalPlayer.PlayerScripts.Modules.UserInterface:WaitForChild("Lobby"):WaitForChild("Matchmaking"))
local v_u_10 = require(v_u_3.LocalPlayer.PlayerScripts.Modules.UserInterface:WaitForChild("MobileInputs"))
local v_u_11 = require(v_u_3.LocalPlayer.PlayerScripts.Modules.UserInterface:WaitForChild("Teleporting"))
local v_u_12 = require(v_u_3.LocalPlayer.PlayerScripts.Modules.UserInterface:WaitForChild("Equipment"))
local v_u_13 = require(v_u_3.LocalPlayer.PlayerScripts.Modules.UserInterface:WaitForChild("Queue"))
local v_u_14 = require(v_u_3.LocalPlayer.PlayerScripts.Modules.UserInterface:WaitForChild("Pages"))
local v_u_15 = require(v_u_3.LocalPlayer.PlayerScripts.Modules:WaitForChild("ButtonEffect"))
local v_u_16 = require(v_u_3.LocalPlayer.PlayerScripts.Modules:WaitForChild("UILibrary"))
local v_u_17 = {}
v_u_17.__index = v_u_17
function v_u_17._new() -- name: _new
	-- upvalues: (copy) v_u_17, (copy) v_u_16
	local v18 = v_u_17
	local v19 = setmetatable({}, v18)
	v19.Frame = v_u_16:GetTo("MainFrame", "Lobby", "Play")
	v19.HubButton = v19.Frame:WaitForChild("Hub")
	v19.PlayButton = v19.Frame:WaitForChild("Play")
	v19.PlayButtonOffFrame = v19.PlayButton:WaitForChild("Off")
	v19.PlayButtonOffJoinText = v19.PlayButtonOffFrame:WaitForChild("Title")
	v19.PlayButtonJoinFrame = v19.PlayButton:WaitForChild("Join")
	v19.PlayButtonJoinText = v19.PlayButtonJoinFrame:WaitForChild("Title")
	v19.PlayButtonJoinBubble = v19.PlayButtonJoinFrame:WaitForChild("Bubble")
	v19.PlayButtonJoinBubbleText = v19.PlayButtonJoinBubble:WaitForChild("Title")
	v19.PlayButtonJoinBubbleBackground = v19.PlayButtonJoinBubble:WaitForChild("Background")
	v19.RematchButton = v19.Frame:WaitForChild("Rematch")
	v19.RematchCountText = v19.RematchButton:WaitForChild("Count")
	v19.IsHubVisible = false
	v19.IsPlayVisible = false
	v19.IsRematchVisible = false
	v19._bubble_effect = 0
	v19:_Init()
	return v19
end
function v_u_17.GoBackToHub(_) -- name: GoBackToHub
	-- upvalues: (copy) v_u_1
	v_u_1.Remotes.Matchmaking.BackToHub:FireServer()
end
function v_u_17.RematchRequest(_) -- name: RematchRequest
	-- upvalues: (copy) v_u_1
	v_u_1.Remotes.Duels.Rematch:FireServer()
end
function v_u_17.OpenPlayPage(_) -- name: OpenPlayPage
	-- upvalues: (copy) v_u_4, (copy) v_u_7, (copy) v_u_6, (copy) v_u_8, (copy) v_u_5, (copy) v_u_14
	if v_u_4.IS_ARCADE_SERVER or v_u_7.CurrentDuel then
		v_u_7:Join()
		return
	elseif v_u_6:GetStatistic("StatisticDuelsPlayed") <= 1 and (v_u_6:GetStatistic("StatisticDuelsWon") < v_u_4.BEGINNER_QUEUE_WINS and not v_u_8.CurrentParty) then
		v_u_5:QueueInto(v_u_4.BEGINNER_QUEUE_NAME)
	else
		v_u_14.PageSystem:OpenPage("Matchmaking", true)
	end
end
function v_u_17._UpdateLayouts(p20) -- name: _UpdateLayouts
	p20.PlayButtonJoinBubbleBackground.Size = UDim2.new(0, p20.PlayButtonJoinBubbleText.TextBounds.X + p20.PlayButtonJoinBubble.AbsoluteSize.Y, 1, 0)
end
function v_u_17._UpdateRematchButton(p21) -- name: _UpdateRematchButton
	-- upvalues: (copy) v_u_5
	local v22 = v_u_5:Get("MatchmadeRematchSuccess")
	local v23 = v_u_5:Get("MatchmadeRematchCount")
	local v24 = v_u_5:Get("MatchmadeRematchGoal")
	local v25 = v_u_5:IsRematchAvailable()
	p21.RematchCountText.Text = v22 and "\226\128\162 \226\128\162 \226\128\162" or (v25 and v23 .. " / " .. v24 or "Unavailable")
end
function v_u_17._BubbleEffect(p26) -- name: _BubbleEffect
	-- upvalues: (copy) v_u_3
	p26._bubble_effect = p26._bubble_effect + 1
	local v27 = p26._bubble_effect
	if p26.Frame.Visible and (p26.PlayButtonJoinFrame.Visible and p26.PlayButtonJoinBubble.Visible) then
		while v27 == p26._bubble_effect do
			if p26.PlayButtonJoinBubble:IsDescendantOf(v_u_3) then
				p26.PlayButtonJoinBubble:TweenPosition(UDim2.new(0.5, 0, -0.5, 0), "Out", "Sine", 0.5, true)
			end
			wait(0.5)
			if v27 ~= p26._bubble_effect then
				return
			end
			if p26.PlayButtonJoinBubble:IsDescendantOf(v_u_3) then
				p26.PlayButtonJoinBubble:TweenPosition(UDim2.new(0.5, 0, -0.2, 0), "In", "Sine", 0.5, true)
			end
			wait(0.5)
		end
	end
end
function v_u_17._UpdatePlayButton(p28) -- name: _UpdatePlayButton
	-- upvalues: (copy) v_u_4, (copy) v_u_7, (copy) v_u_6
	if v_u_4.IS_ARCADE_SERVER or v_u_7.CurrentDuel then
		local v29 = v_u_7:GetJoinCooldown()
		local v30 = v_u_7.CurrentDuel
		if v30 then
			if v_u_7.CurrentDuel:Get("Status") == "GameOver" then
				v30 = false
			else
				v30 = v29 <= 0
			end
		end
		p28.PlayButtonJoinBubble.Visible = false
		p28.PlayButtonOffJoinText.Text = v29 > 0 and v29 and v29 or "Join"
		p28.PlayButtonJoinFrame.Visible = v30
		p28.PlayButtonOffFrame.Visible = not v30
	else
		local v31 = next(v_u_6:Get("FreeWeaponTrialsRemaining"))
		p28.PlayButtonJoinBubble.Visible = v31 or v_u_6:GetStatistic("StatisticDuelsPlayed") <= 3
		p28.PlayButtonJoinBubbleText.Text = v31 and "Your free weapon trial is ready!" or "Join the queue to start playing!"
		p28.PlayButtonJoinText.Text = "Play"
		p28.PlayButtonJoinFrame.Visible = true
		p28.PlayButtonOffFrame.Visible = false
	end
	task.spawn(p28._BubbleEffect, p28)
end
function v_u_17._UpdateVisibility(p32) -- name: _UpdateVisibility
	-- upvalues: (copy) v_u_14, (copy) v_u_12, (copy) v_u_13, (copy) v_u_9, (copy) v_u_11, (copy) v_u_10, (copy) v_u_2, (copy) v_u_4, (copy) v_u_5, (copy) v_u_8, (copy) v_u_7
	local v33 = not (v_u_14.PageSystem.CurrentPage or v_u_12.IsOpen or (v_u_13:IsVisible() or v_u_9:IsVisible() or (v_u_11.Enabled or v_u_10.EditorEnabled)))
	if v33 then
		v33 = not v_u_2.MenuIsOpen
	end
	local v34 = v33 and (v_u_4.IS_ARCADE_SERVER or v_u_5:IsMatchmadeDuelOver())
	if v34 then
		v34 = v_u_8:IsPartyLeader()
	end
	p32.IsHubVisible = v34
	local v35
	if v33 then
		v35 = v_u_4.QUEUES_ACTIVE or v_u_4.IS_ARCADE_SERVER or (v_u_7.CurrentDuel or v_u_5:IsMatchmadeDuelOver())
	else
		v35 = v33
	end
	p32.IsPlayVisible = v35
	if v33 then
		v33 = v_u_5:IsRematchAvailable()
	end
	p32.IsRematchVisible = v33
	p32.HubButton:TweenPosition(p32.IsHubVisible and UDim2.new(-3.5, 0, 0.5, 0) or UDim2.new(-3.5, 0, 7, 0), "Out", "Quint", 0.25, true)
	p32.PlayButton:TweenPosition(p32.IsPlayVisible and UDim2.new(0.5, 0, 0.5, 0) or UDim2.new(0.5, 0, 7, 0), "Out", "Quint", 0.25, true)
	p32.RematchButton:TweenPosition(p32.IsRematchVisible and UDim2.new(4.5, 0, 0.5, 0) or UDim2.new(4.5, 0, 7, 0), "Out", "Quint", 0.25, true)
end
function v_u_17._Init(p_u_36) -- name: _Init
	-- upvalues: (copy) v_u_8, (copy) v_u_5, (copy) v_u_12, (copy) v_u_14, (copy) v_u_13, (copy) v_u_9, (copy) v_u_11, (copy) v_u_10, (copy) v_u_6, (copy) v_u_7, (copy) v_u_2, (copy) v_u_15
	p_u_36.PlayButton.MouseButton1Click:Connect(function()
		-- upvalues: (copy) p_u_36
		p_u_36:OpenPlayPage()
	end)
	p_u_36.HubButton.MouseButton1Click:Connect(function()
		-- upvalues: (copy) p_u_36
		p_u_36:GoBackToHub()
	end)
	p_u_36.RematchButton.MouseButton1Click:Connect(function()
		-- upvalues: (copy) p_u_36
		p_u_36:RematchRequest()
	end)
	p_u_36.Frame:GetPropertyChangedSignal("Visible"):Connect(function()
		-- upvalues: (copy) p_u_36
		p_u_36:_UpdatePlayButton()
	end)
	p_u_36.PlayButtonJoinBubbleText:GetPropertyChangedSignal("TextBounds"):Connect(function()
		-- upvalues: (copy) p_u_36
		p_u_36:_UpdateLayouts()
	end)
	p_u_36.PlayButtonJoinBubble:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
		-- upvalues: (copy) p_u_36
		p_u_36:_UpdateLayouts()
	end)
	v_u_8.PartyChanged:Connect(function()
		-- upvalues: (copy) p_u_36
		p_u_36:_UpdateVisibility()
	end)
	v_u_5.MatchmadeDuelEnded:Connect(function()
		-- upvalues: (copy) p_u_36
		p_u_36:_UpdateVisibility()
	end)
	v_u_5.RematchDetailsChanged:Connect(function()
		-- upvalues: (copy) p_u_36
		p_u_36:_UpdateVisibility()
		p_u_36:_UpdateRematchButton()
	end)
	v_u_12.Opened:Connect(function()
		-- upvalues: (copy) p_u_36
		p_u_36:_UpdateVisibility()
	end)
	v_u_14.PageSystem.PageOpened:Connect(function()
		-- upvalues: (copy) p_u_36
		p_u_36:_UpdateVisibility()
	end)
	v_u_14.PageSystem.PageClosed:Connect(function()
		-- upvalues: (copy) p_u_36
		p_u_36:_UpdateVisibility()
	end)
	v_u_13.VisibilityChanged:Connect(function()
		-- upvalues: (copy) p_u_36
		p_u_36:_UpdateVisibility()
	end)
	v_u_9.VisibilityChanged:Connect(function()
		-- upvalues: (copy) p_u_36
		p_u_36:_UpdateVisibility()
	end)
	v_u_11.EnabledChanged:Connect(function()
		-- upvalues: (copy) p_u_36
		p_u_36:_UpdateVisibility()
	end)
	v_u_10.EditorEnabledChanged:Connect(function()
		-- upvalues: (copy) p_u_36
		p_u_36:_UpdateVisibility()
	end)
	v_u_6:GetDataChangedSignal("StatisticDuelsPlayed"):Connect(function()
		-- upvalues: (copy) p_u_36
		p_u_36:_UpdatePlayButton()
	end)
	v_u_6:GetDataChangedSignal("FreeWeaponTrialsRemaining"):Connect(function()
		-- upvalues: (copy) p_u_36
		p_u_36:_UpdatePlayButton()
	end)
	v_u_7.DuelSet:Connect(function(_)
		-- upvalues: (copy) p_u_36
		p_u_36:_UpdateVisibility()
		p_u_36:_UpdatePlayButton()
	end)
	v_u_7.UpdateJoinCooldown:Connect(function()
		-- upvalues: (copy) p_u_36
		p_u_36:_UpdatePlayButton()
	end)
	v_u_2:GetPropertyChangedSignal("MenuIsOpen"):Connect(function()
		-- upvalues: (copy) p_u_36
		p_u_36:_UpdateVisibility()
	end)
	if v_u_7.CurrentDuel then
		task.defer(p_u_36._ArcadeDuelAdded, p_u_36, v_u_7.CurrentDuel)
	end
	p_u_36:_UpdateLayouts()
	p_u_36:_UpdatePlayButton()
	p_u_36:_UpdateVisibility()
	v_u_15:Add(p_u_36.HubButton)
	v_u_15:Add(p_u_36.PlayButton)
	v_u_15:Add(p_u_36.RematchButton)
end
return v_u_17._new()