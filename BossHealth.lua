local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("CollectionService")
local v_u_3 = game:GetService("TweenService")
local v_u_4 = game:GetService("GuiService")
local v_u_5 = game:GetService("Players")
local v_u_6 = require(v1.Modules.Signal)
local v_u_7 = require(v_u_5.LocalPlayer.PlayerScripts.Controllers.SpectateController)
local v_u_8 = require(v_u_5.LocalPlayer.PlayerScripts.Modules.UserInterface:WaitForChild("Lobby"):WaitForChild("Matchmaking"))
local v_u_9 = require(v_u_5.LocalPlayer.PlayerScripts.Modules.UserInterface:WaitForChild("MobileInputs"))
local v_u_10 = require(v_u_5.LocalPlayer.PlayerScripts.Modules.UserInterface:WaitForChild("Teleporting"))
local v_u_11 = require(v_u_5.LocalPlayer.PlayerScripts.Modules.UserInterface:WaitForChild("Equipment"))
local v_u_12 = require(v_u_5.LocalPlayer.PlayerScripts.Modules.UserInterface:WaitForChild("Queue"))
local v_u_13 = require(v_u_5.LocalPlayer.PlayerScripts.Modules.UserInterface:WaitForChild("Pages"))
local v_u_14 = require(v_u_5.LocalPlayer.PlayerScripts.Modules:WaitForChild("UILibrary"))
local v_u_15 = v_u_5.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("BossHealthBar")
local v_u_16 = {}
v_u_16.__index = v_u_16
function v_u_16._new() -- name: _new
	-- upvalues: (copy) v_u_16, (copy) v_u_14, (copy) v_u_6
	local v17 = v_u_16
	local v18 = setmetatable({}, v17)
	v18.Frame = v_u_14:GetTo("MainFrame", "BossHealth")
	v18.Container = v18.Frame:WaitForChild("Container")
	v18._duel_subject_connections = {}
	v18._boss_health_bars = {}
	v18._last_changed_health_bar_frame = nil
	v18._update_health_bar_internal = v_u_6.new()
	v18:_Init()
	return v18
end
function v_u_16._UpdateVisibility(p19) -- name: _UpdateVisibility
	-- upvalues: (copy) v_u_7, (copy) v_u_13, (copy) v_u_11, (copy) v_u_12, (copy) v_u_10, (copy) v_u_9, (copy) v_u_8, (copy) v_u_4
	local v20 = v_u_7.CurrentDuelSubject
	if v20 then
		v20 = v_u_7.CurrentDuelSubject.DuelInterface.Voting:IsOpen()
	end
	local v21 = p19.Frame
	local v22 = not (v20 or (v_u_13.PageSystem.CurrentPage or v_u_11.IsOpen) or (v_u_12:IsVisible() or v_u_10.Enabled or (v_u_9.EditorEnabled or v_u_8:IsVisible())))
	if v22 then
		v22 = not v_u_4.MenuIsOpen
	end
	v21.Visible = v22
end
function v_u_16._DuelSubjectChanged(p_u_23) -- name: _DuelSubjectChanged
	-- upvalues: (copy) v_u_7
	for _, v24 in pairs(p_u_23._duel_subject_connections) do
		v24:Disconnect()
	end
	p_u_23._duel_subject_connections = {}
	p_u_23:_UpdateVisibility()
	if v_u_7.CurrentDuelSubject then
		local v25 = p_u_23._duel_subject_connections
		local v26 = v_u_7.CurrentDuelSubject.DuelInterface.Voting.VisibilityChanged
		table.insert(v25, v26:Connect(function()
			-- upvalues: (copy) p_u_23
			p_u_23:_UpdateVisibility()
		end))
	end
end
function v_u_16._HumanoidAdded(p_u_27, p_u_28) -- name: _HumanoidAdded
	-- upvalues: (copy) v_u_15, (copy) v_u_5, (copy) v_u_3
	p_u_27:_HumanoidRemoved(p_u_28)
	local v29 = {}
	local v30 = {}
	local v_u_31 = v_u_15:Clone()
	v_u_31.Parent = p_u_27.Container
	local function v32() -- name: update_name
		-- upvalues: (copy) v_u_31, (copy) p_u_28, (ref) v_u_5
		v_u_31.Title.Text = p_u_28.Parent and p_u_28.Parent.Name or ""
		v_u_31.Title.AutoLocalize = not (p_u_28.Parent and v_u_5:GetPlayerFromCharacter(p_u_28.Parent))
	end
	local v33 = p_u_28.Parent:GetPropertyChangedSignal("Name")
	table.insert(v29, v33:Connect(v32))
	v_u_31.Title.Text = p_u_28.Parent and (p_u_28.Parent.Name or "") or ""
	v_u_31.Title.AutoLocalize = not (p_u_28.Parent and v_u_5:GetPlayerFromCharacter(p_u_28.Parent))
	local v_u_34 = false
	local function v_u_37() -- name: update_visibility
		-- upvalues: (copy) v_u_31, (copy) p_u_27, (copy) p_u_28, (ref) v_u_34, (ref) v_u_15
		local v35 = v_u_31
		local v36 = p_u_27.Frame.Visible and (p_u_28.Health > 0 and p_u_28.RootPart)
		if v36 then
			v36 = (p_u_28.RootPart.Position - workspace.CurrentCamera.CFrame.Position).Magnitude <= 256
		end
		v35.Visible = v36
		if v_u_31.Visible and not v_u_34 then
			v_u_31.Size = UDim2.new(0, 0, 0, 0)
			v_u_31:TweenSize(v_u_15.Size, "Out", "Quint", 0.5, true)
		end
		v_u_34 = v_u_31.Visible
	end
	local v38 = p_u_27._update_health_bar_internal
	table.insert(v29, v38:Connect(v_u_37))
	local v39 = p_u_27.Frame:GetPropertyChangedSignal("Visible")
	table.insert(v29, v39:Connect(v_u_37))
	local v40 = task.defer
	table.insert(v30, v40(function()
		-- upvalues: (copy) v_u_37
		while true do
			v_u_37()
			wait(1)
		end
	end))
	local v_u_41 = nil
	local v_u_42 = nil
	local function v51() -- name: refresh
		-- upvalues: (copy) p_u_27, (copy) v_u_31, (copy) p_u_28, (ref) v_u_41, (ref) v_u_42, (ref) v_u_3, (copy) v_u_37
		p_u_27._last_changed_health_bar_frame = v_u_31
		p_u_27._update_health_bar_internal:Fire()
		local v43 = p_u_28.MaxHealth
		local v44 = p_u_28.Health
		local v45 = v44 / v43
		local v46 = math.clamp(v45, 0, 1)
		local v47 = Color3.fromRGB(255, 50, 50):Lerp(Color3.fromRGB(255, 215, 0):Lerp(Color3.fromRGB(100, 255, 50), v46), v46)
		local v48 = Color3.new(v47.R / 2, v47.G / 2, v47.B / 2)
		v_u_31.Health.BackgroundColor3 = v48
		v_u_31.Health.UIStroke.Color = v48
		v_u_31.Health.Bar.BackgroundColor3 = v47
		v_u_31.Health.Bar.Visible = v46 > 0
		v_u_31.Health.Bar.UIStroke.Color = v47
		v_u_31.Health.Bar.Value.Title.Text = v44 > 1 and math.ceil(v44) or ""
		local v49 = v_u_41 and v46 >= v_u_41 and 0.5 or 1
		local v50 = UDim2.new(math.max(0.06, v46), 2, 1, 2)
		if v_u_42 then
			v_u_42:Pause()
		end
		v_u_42 = v_u_3:Create(v_u_31.Health.Bar, TweenInfo.new(0.5 / v49, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
			["Size"] = v50
		})
		v_u_42:Play()
		v_u_41 = v46
		v_u_37()
	end
	local v52 = p_u_28:GetPropertyChangedSignal("MaxHealth")
	table.insert(v29, v52:Connect(v51))
	local v53 = p_u_28:GetPropertyChangedSignal("Health")
	table.insert(v29, v53:Connect(v51))
	v51()
	p_u_27._boss_health_bars[p_u_28] = {
		["Frame"] = v_u_31,
		["Connections"] = v29,
		["Threads"] = v30
	}
end
function v_u_16._HumanoidRemoved(p54, p55) -- name: _HumanoidRemoved
	local v56 = p54._boss_health_bars[p55]
	if v56 then
		v56.Frame:Destroy()
		for _, v57 in pairs(v56.Connections) do
			v57:Disconnect()
		end
		for _, v58 in pairs(v56.Threads) do
			local v59 = task.cancel
			pcall(v59, v58)
		end
		p54._boss_health_bars[p55] = nil
	end
end
function v_u_16._Init(p_u_60) -- name: _Init
	-- upvalues: (copy) v_u_11, (copy) v_u_13, (copy) v_u_12, (copy) v_u_8, (copy) v_u_10, (copy) v_u_9, (copy) v_u_4, (copy) v_u_7, (copy) v_u_2
	v_u_11.Opened:Connect(function()
		-- upvalues: (copy) p_u_60
		p_u_60:_UpdateVisibility()
	end)
	v_u_13.PageSystem.PageOpened:Connect(function()
		-- upvalues: (copy) p_u_60
		p_u_60:_UpdateVisibility()
	end)
	v_u_13.PageSystem.PageClosed:Connect(function()
		-- upvalues: (copy) p_u_60
		p_u_60:_UpdateVisibility()
	end)
	v_u_12.VisibilityChanged:Connect(function()
		-- upvalues: (copy) p_u_60
		p_u_60:_UpdateVisibility()
	end)
	v_u_8.VisibilityChanged:Connect(function()
		-- upvalues: (copy) p_u_60
		p_u_60:_UpdateVisibility()
	end)
	v_u_10.EnabledChanged:Connect(function()
		-- upvalues: (copy) p_u_60
		p_u_60:_UpdateVisibility()
	end)
	v_u_9.EditorEnabledChanged:Connect(function()
		-- upvalues: (copy) p_u_60
		p_u_60:_UpdateVisibility()
	end)
	v_u_4:GetPropertyChangedSignal("MenuIsOpen"):Connect(function()
		-- upvalues: (copy) p_u_60
		p_u_60:_UpdateVisibility()
	end)
	v_u_7.DuelSubjectChanged:Connect(function()
		-- upvalues: (copy) p_u_60
		p_u_60:_DuelSubjectChanged()
	end)
	v_u_2:GetInstanceAddedSignal("BossHealthBar"):Connect(function(p61)
		-- upvalues: (copy) p_u_60
		p_u_60:_HumanoidAdded(p61)
	end)
	v_u_2:GetInstanceRemovedSignal("BossHealthBar"):Connect(function(p62)
		-- upvalues: (copy) p_u_60
		p_u_60:_HumanoidRemoved(p62)
	end)
	for _, v63 in pairs(v_u_2:GetTagged("BossHealthBar")) do
		task.defer(p_u_60._HumanoidAdded, p_u_60, v63)
	end
	p_u_60:_UpdateVisibility()
	task.defer(p_u_60._DuelSubjectChanged, p_u_60)
end
return v_u_16._new()