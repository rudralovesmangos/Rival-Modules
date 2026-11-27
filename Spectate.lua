local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("Players")
require(v1.Modules.CONSTANTS)
local v_u_3 = require(v_u_2.LocalPlayer.PlayerScripts.Controllers:WaitForChild("ComplianceController"))
local v_u_4 = require(v_u_2.LocalPlayer.PlayerScripts.Controllers:WaitForChild("ControlsController"))
local v_u_5 = require(v_u_2.LocalPlayer.PlayerScripts.Controllers:WaitForChild("SpectateController"))
local v_u_6 = require(v_u_2.LocalPlayer.PlayerScripts.Controllers:WaitForChild("ArcadeController"))
local v_u_7 = require(v_u_2.LocalPlayer.PlayerScripts.Controllers:WaitForChild("CameraController"))
local v_u_8 = require(v_u_2.LocalPlayer.PlayerScripts.Modules:WaitForChild("UserInterface"):WaitForChild("EliminatedEffect"))
local v_u_9 = require(v_u_2.LocalPlayer.PlayerScripts.Modules:WaitForChild("UserInterface"):WaitForChild("Pages"))
local v_u_10 = require(v_u_2.LocalPlayer.PlayerScripts.Modules:WaitForChild("ButtonEffect"))
local v_u_11 = require(v_u_2.LocalPlayer.PlayerScripts.Modules:WaitForChild("UILibrary"))
local v_u_12 = {}
v_u_12.__index = v_u_12
function v_u_12._new() -- name: _new
	-- upvalues: (copy) v_u_12, (copy) v_u_11
	local v13 = v_u_12
	local v14 = setmetatable({}, v13)
	v14.BottomStackFrame = v_u_11:GetTo("MainFrame", "BottomStack")
	v14.BufferFrame = v_u_11:GetTo("MainFrame", "BottomStack", "SpectateBuffer")
	v14.Frame = v_u_11:GetTo("MainFrame", "BottomStack", "Spectate")
	v14.Container = v14.Frame:WaitForChild("Container")
	v14.Background = v14.Container:WaitForChild("Background")
	v14.NextButton = v14.Container:WaitForChild("Next")
	v14.LastButton = v14.Container:WaitForChild("Last")
	v14.ExitButton = v14.Container:WaitForChild("Exit")
	v14.JoinButton = v14.Container:WaitForChild("Join")
	v14.JoinButtonOff = v14.JoinButton:WaitForChild("Off")
	v14.JoinButtonOffTitle = v14.JoinButtonOff:WaitForChild("Title")
	v14.JoinButtonOn = v14.JoinButton:WaitForChild("On")
	v14.JoinBubble = v14.JoinButtonOn:WaitForChild("Bubble")
	v14.PlayerText = v14.Container:WaitForChild("Player")
	v14.UsernameText = v14.Container:WaitForChild("Username")
	v14.FreecamButton = v14.Container:WaitForChild("Freecam")
	v14.ExitFreecamButton = v14.Container:WaitForChild("ExitFreecam")
	v14._duel_connections = {}
	v14._fighter_connections = {}
	v14._join_bubble_connection = nil
	v14._join_bubble_hash = 0
	v14:_Init()
	return v14
end
function v_u_12._UpdateBuffer(p15) -- name: _UpdateBuffer
	-- upvalues: (copy) v_u_5
	local v16 = v_u_5.CurrentSubject and (v_u_5.CurrentSubject.FighterInterface and v_u_5.CurrentSubject.FighterInterface.BottomCenter.Layout.AbsoluteContentSize.Y) or 0
	local v17 = p15.BufferFrame
	local v18 = UDim2.new
	local v19 = v16 + p15.BottomStackFrame.AbsoluteSize.Y * 0.03
	local v20 = p15.BottomStackFrame.AbsoluteSize.Y * 0.2
	v17.Size = v18(1, 0, 0, (math.max(v19, v20)))
end
function v_u_12._UpdateJoinCooldown(p21) -- name: _UpdateJoinCooldown
	-- upvalues: (copy) v_u_6
	local v22 = v_u_6:GetJoinCooldown()
	local v23 = v_u_6:CanJoin()
	p21.JoinButtonOffTitle.Text = v22 > 0 and v22 and v22 or "Join"
	p21.JoinButtonOff.Visible = not v23
	p21.JoinButtonOn.Visible = v23
end
function v_u_12._Update(p_u_24) -- name: _Update
	-- upvalues: (copy) v_u_9, (copy) v_u_5, (copy) v_u_7, (copy) v_u_3, (copy) v_u_4, (copy) v_u_8, (copy) v_u_2
	local v25 = not v_u_9.PageSystem.CurrentPage
	if v25 then
		local v26 = v_u_5.CurrentDuelSubject and v_u_5.CurrentDuelSubject.LocalDueler
		if v26 then
			v26 = not v_u_5:IsThereValidSubject()
		end
		v25 = not v26
	end
	local v27 = v_u_7:GetPublicState() == v_u_7.CameraState.States.CustomFreecam
	local v28 = p_u_24.JoinButton
	local v29 = v25 and not v27 and (v_u_5.CurrentDuelSubject and not v_u_5.CurrentDuelSubject.LocalDueler)
	if v29 then
		v29 = v_u_5.CurrentDuelSubject:Get("IsCurrentArcadeDuel")
	end
	v28.Visible = v29
	local v30 = p_u_24.Background
	local v31
	if v25 then
		v31 = not v27
	else
		v31 = v25
	end
	v30.Visible = v31
	local v32 = p_u_24.LastButton
	local v33
	if v25 then
		v33 = not v27
	else
		v33 = v25
	end
	v32.Visible = v33
	local v34 = p_u_24.NextButton
	local v35
	if v25 then
		v35 = not v27
	else
		v35 = v25
	end
	v34.Visible = v35
	local v36 = p_u_24.PlayerText
	local v37
	if v25 then
		v37 = not v27
	else
		v37 = v25
	end
	v36.Visible = v37
	local v38 = p_u_24.UsernameText
	local v39
	if v25 then
		v39 = not v27
	else
		v39 = v25
	end
	v38.Visible = v39
	p_u_24.ExitFreecamButton.Visible = false
	p_u_24.PlayerText.Text = v25 and not v_u_5.CurrentDuelSubject and "" or (not v_u_5.CurrentSubject and p_u_24.PlayerText.Text or v_u_3:GetName(v_u_5.CurrentSubject.Player))
	p_u_24.UsernameText.Text = v25 and not v_u_5.CurrentDuelSubject or not v_u_5.CurrentSubject and p_u_24.UsernameText.Text or (v_u_5.CurrentSubject.Player.DisplayName ~= v_u_5.CurrentSubject.Player.Name and "@" .. v_u_5.CurrentSubject.Player.Name or "")
	p_u_24.PlayerText.Position = v25 and p_u_24.UsernameText.Text == "" and UDim2.new(0.5, 0, 0.5, 0) or UDim2.new(0.5, 0, 0.35, 0)
	local v40 = p_u_24.FreecamButton
	local v41 = v25 and (v_u_5.CurrentDuelSubject and not v_u_5.CurrentDuelSubject.LocalDueler)
	if v41 then
		if v_u_4.CurrentControls == "MouseKeyboard" then
			v41 = not v27
		else
			v41 = false
		end
	end
	v40.Visible = v41
	local v42 = p_u_24.ExitButton
	if v25 then
		v25 = v_u_5.CurrentDuelSubject and not v_u_5.CurrentDuelSubject.LocalDueler
		if v25 then
			v25 = not v27
		end
	end
	v42.Visible = v25
	p_u_24.Frame.Size = p_u_24.ExitButton.Visible and UDim2.new(0.04, 20, 0.08, 40) or UDim2.new(0.04, 20, 0.04, 20)
	local v43 = p_u_24.Frame
	local v44 = v_u_5.CurrentDuelSubject
	if v44 then
		local v45 = v_u_5.CurrentSubject
		if v45 then
			v45 = v_u_5.CurrentSubject.IsLocalPlayer
		end
		v44 = not (v45 or v_u_5.CurrentDuelSubject:Get("VoteOptions")) and (v_u_5.CurrentDuelSubject:Get("Status") ~= "GameOver" and not (v_u_5.CurrentDuelSubject.DuelInterface.Buttons:IsAnythingVisible() or v_u_5.CurrentDuelSubject.DuelInterface.Scoreboard:IsOpen()))
		if v44 then
			v44 = not v_u_8:IsVisible()
		end
	end
	v43.Visible = v44
	p_u_24._join_bubble_hash = p_u_24._join_bubble_hash + 1
	local v_u_46 = p_u_24._join_bubble_hash
	task.defer(function()
		-- upvalues: (copy) p_u_24, (copy) v_u_46, (ref) v_u_2
		if p_u_24.JoinButton.Visible and p_u_24.JoinBubble.Visible then
			if v_u_46 == p_u_24._join_bubble_hash then
				if p_u_24.JoinBubble:IsDescendantOf(v_u_2) then
					p_u_24.JoinBubble:TweenPosition(UDim2.new(0.5, 0, -0.6, 0), "Out", "Sine", 0.5, true)
				end
				wait(0.5)
				if v_u_46 == p_u_24._join_bubble_hash then
					if p_u_24.JoinBubble:IsDescendantOf(v_u_2) then
						p_u_24.JoinBubble:TweenPosition(UDim2.new(0.5, 0, -0.25, 0), "In", "Sine", 0.5, true)
					end
					wait(0.5)
					if v_u_46 == p_u_24._join_bubble_hash then
						continue
					end
				end
			else
				return
			end
		else
			return
		end
	end)
end
function v_u_12._ListenFighterSubject(p_u_47) -- name: _ListenFighterSubject
	-- upvalues: (copy) v_u_5
	for _, v48 in pairs(p_u_47._fighter_connections) do
		v48:Disconnect()
	end
	p_u_47._fighter_connections = {}
	if v_u_5.CurrentSubject then
		local v49 = p_u_47._fighter_connections
		local v50 = v_u_5.CurrentSubject.InterfaceRemoved
		table.insert(v49, v50:Connect(function(_)
			-- upvalues: (copy) p_u_47
			p_u_47:_UpdateBuffer()
		end))
		local function v55(p51) -- name: interface_added
			-- upvalues: (copy) p_u_47
			local v52 = p_u_47._fighter_connections
			local v53 = p51.BottomCenter.Layout:GetPropertyChangedSignal("AbsoluteContentSize")
			local function v54()
				-- upvalues: (ref) p_u_47
				p_u_47:_UpdateBuffer()
			end
			table.insert(v52, v53:Connect(v54))
			p_u_47:_UpdateBuffer()
		end
		local v56 = p_u_47._fighter_connections
		local v57 = v_u_5.CurrentSubject.InterfaceAdded
		table.insert(v56, v57:Connect(v55))
		if v_u_5.CurrentSubject.FighterInterface then
			task.spawn(v55, v_u_5.CurrentSubject.FighterInterface)
		end
		p_u_47:_UpdateBuffer()
	else
		p_u_47:_UpdateBuffer()
	end
end
function v_u_12._ListenDuelSubject(p_u_58) -- name: _ListenDuelSubject
	-- upvalues: (copy) v_u_5, (copy) v_u_4, (copy) v_u_9, (copy) v_u_6
	for _, v59 in pairs(p_u_58._duel_connections) do
		v59:Disconnect()
	end
	p_u_58._duel_connections = {}
	if v_u_5.CurrentDuelSubject then
		local v60 = p_u_58._duel_connections
		local v61 = v_u_5.CurrentDuelSubject:GetDataChangedSignal("VoteOptions")
		table.insert(v60, v61:Connect(function()
			-- upvalues: (copy) p_u_58
			p_u_58:_Update()
		end))
		local v62 = p_u_58._duel_connections
		local v63 = v_u_5.CurrentDuelSubject:GetDataChangedSignal("Status")
		table.insert(v62, v63:Connect(function()
			-- upvalues: (copy) p_u_58
			p_u_58:_Update()
		end))
		local v64 = p_u_58._duel_connections
		local v65 = v_u_5.CurrentDuelSubject:GetDataChangedSignal("IsCurrentArcadeDuel")
		table.insert(v64, v65:Connect(function()
			-- upvalues: (copy) p_u_58
			p_u_58:_Update()
		end))
		local v66 = p_u_58._duel_connections
		local v67 = v_u_5.CurrentDuelSubject.DuelInterface.Scoreboard.VisibilityChanged
		table.insert(v66, v67:Connect(function()
			-- upvalues: (copy) p_u_58
			p_u_58:_Update()
		end))
		local v68 = p_u_58._duel_connections
		local v69 = v_u_5.CurrentDuelSubject.DuelInterface.Buttons.Updated
		table.insert(v68, v69:Connect(function()
			-- upvalues: (copy) p_u_58
			p_u_58:_Update()
		end))
		local v70 = p_u_58._duel_connections
		local v71 = v_u_5.SubjectChanged
		table.insert(v70, v71:Connect(function()
			-- upvalues: (copy) p_u_58
			p_u_58:_Update()
		end))
		local v72 = p_u_58._duel_connections
		local v73 = v_u_4.ControlsChanged
		table.insert(v72, v73:Connect(function()
			-- upvalues: (copy) p_u_58
			p_u_58:_Update()
		end))
		local v74 = p_u_58._duel_connections
		local v75 = v_u_9.PageSystem.PagesActivity
		table.insert(v74, v75:Connect(function()
			-- upvalues: (copy) p_u_58
			p_u_58:_Update()
		end))
		local v76 = p_u_58._duel_connections
		local v77 = v_u_6.UpdateJoinCooldown
		table.insert(v76, v77:Connect(function()
			-- upvalues: (copy) p_u_58
			p_u_58:_UpdateJoinCooldown()
		end))
		p_u_58:_Update()
		p_u_58:_UpdateBuffer()
		p_u_58:_UpdateJoinCooldown()
	else
		p_u_58:_Update()
		p_u_58:_UpdateBuffer()
	end
end
function v_u_12._Init(p_u_78) -- name: _Init
	-- upvalues: (copy) v_u_5, (copy) v_u_7, (copy) v_u_6, (copy) v_u_8, (copy) v_u_10
	p_u_78.NextButton.MouseButton1Click:Connect(function()
		-- upvalues: (ref) v_u_5
		v_u_5:Next()
	end)
	p_u_78.LastButton.MouseButton1Click:Connect(function()
		-- upvalues: (ref) v_u_5
		v_u_5:Last()
	end)
	p_u_78.ExitButton.MouseButton1Click:Connect(function()
		-- upvalues: (ref) v_u_5
		v_u_5:Exit()
	end)
	p_u_78.FreecamButton.MouseButton1Click:Connect(function()
		-- upvalues: (ref) v_u_7
		v_u_7.CameraState:SetCustomFreecamEnabled(true)
	end)
	p_u_78.ExitFreecamButton.MouseButton1Click:Connect(function()
		-- upvalues: (ref) v_u_7
		v_u_7.CameraState:SetCustomFreecamEnabled(false)
	end)
	p_u_78.JoinButton.MouseButton1Click:Connect(function()
		-- upvalues: (ref) v_u_6, (copy) p_u_78
		v_u_6:Join()
		p_u_78.JoinBubble.Visible = false
		p_u_78:_Update()
	end)
	p_u_78.BottomStackFrame:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
		-- upvalues: (copy) p_u_78
		p_u_78:_UpdateBuffer()
	end)
	v_u_7.CustomFreecamStateChanged:Connect(function()
		-- upvalues: (copy) p_u_78
		p_u_78:_Update()
	end)
	v_u_8.VisibilityChanged:Connect(function()
		-- upvalues: (copy) p_u_78
		p_u_78:_Update()
	end)
	v_u_5.SubjectChanged:Connect(function()
		-- upvalues: (copy) p_u_78
		p_u_78:_ListenFighterSubject()
	end)
	v_u_5.DuelSubjectChanged:Connect(function()
		-- upvalues: (copy) p_u_78
		p_u_78:_ListenDuelSubject()
	end)
	p_u_78:_UpdateBuffer()
	task.spawn(p_u_78._ListenDuelSubject, p_u_78)
	task.spawn(p_u_78._ListenFighterSubject, p_u_78)
	v_u_10:Add(p_u_78.NextButton)
	v_u_10:Add(p_u_78.LastButton)
	v_u_10:Add(p_u_78.ExitButton)
	v_u_10:Add(p_u_78.JoinButton)
	v_u_10:Add(p_u_78.FreecamButton)
	v_u_10:Add(p_u_78.ExitFreecamButton)
end
return v_u_12._new()