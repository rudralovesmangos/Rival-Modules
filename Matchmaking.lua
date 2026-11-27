local v_u_1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("GuiService")
local v_u_3 = game:GetService("RunService")
local v4 = game:GetService("Players")
local v_u_5 = require(v_u_1.Modules.DuelLibrary)
local v_u_6 = require(v_u_1.Modules.Utility)
local v_u_7 = require(v_u_1.Modules.Signal)
local v_u_8 = require(v4.LocalPlayer.PlayerScripts.Controllers:WaitForChild("MatchmakingController"))
require(v4.LocalPlayer.PlayerScripts.Controllers:WaitForChild("PlayerDataController"))
local v_u_9 = require(v4.LocalPlayer.PlayerScripts.Modules.UserInterface:WaitForChild("MobileInputs"))
local v_u_10 = require(v4.LocalPlayer.PlayerScripts.Modules.UserInterface:WaitForChild("Teleporting"))
local v_u_11 = require(v4.LocalPlayer.PlayerScripts.Modules.UserInterface:WaitForChild("Equipment"))
local v_u_12 = require(v4.LocalPlayer.PlayerScripts.Modules.UserInterface:WaitForChild("Queue"))
local v_u_13 = require(v4.LocalPlayer.PlayerScripts.Modules.UserInterface:WaitForChild("Pages"))
local v_u_14 = require(v4.LocalPlayer.PlayerScripts.Modules:WaitForChild("ButtonEffect"))
local v_u_15 = require(v4.LocalPlayer.PlayerScripts.Modules:WaitForChild("UILibrary"))
local v_u_16 = {}
v_u_16.__index = v_u_16
function v_u_16._new() -- name: _new
	-- upvalues: (copy) v_u_16, (copy) v_u_7, (copy) v_u_15
	local v17 = v_u_16
	local v18 = setmetatable({}, v17)
	v18.VisibilityChanged = v_u_7.new()
	v18.OpenedChanged = v_u_7.new()
	v18.Frame = v_u_15:GetTo("MainFrame", "Lobby", "Matchmaking")
	v18.Container = v18.Frame:WaitForChild("Container")
	v18.LeavingFrame = v18.Container:WaitForChild("Leaving")
	v18.LeavingDotsFrame = v18.LeavingFrame:WaitForChild("Dots")
	v18.LeaveButton = v18.Container:WaitForChild("Leave")
	v18.Icon = v18.Container:WaitForChild("Icon")
	v18.TitleText = v18.Container:WaitForChild("Title")
	v18.TimerText = v18.Container:WaitForChild("Timer")
	v18.QueueText = v18.Container:WaitForChild("Queue")
	v18._current_queue_name = nil
	v18._queue_hash = 0
	v18._renderstep_connection = nil
	v18._is_open = false
	v18:_Init()
	return v18
end
function v_u_16.IsVisible(p19) -- name: IsVisible
	return p19.Container.Visible
end
function v_u_16.IsOpened(p20) -- name: IsOpened
	local v21 = p20:IsVisible()
	if v21 then
		v21 = p20._is_open
	end
	return v21
end
function v_u_16._SetIsLeaving(p22, p23) -- name: _SetIsLeaving
	p22.LeavingFrame.Visible = p23
	p22.LeaveButton.Visible = not p23
	if p23 then
		p22.LeavingDotsFrame:AddTag("UILoadingDots")
	else
		p22.LeavingDotsFrame:RemoveTag("UILoadingDots")
	end
end
function v_u_16._SetQueueName(p_u_24, p25) -- name: _SetQueueName
	-- upvalues: (copy) v_u_5, (copy) v_u_6
	p_u_24._queue_hash = p_u_24._queue_hash + 1
	p_u_24._current_queue_name = p25
	local v_u_26 = p_u_24._queue_hash
	local v27 = v_u_5.MatchmakingQueues[p_u_24._current_queue_name]
	p_u_24.Container.Visible = p_u_24._current_queue_name ~= nil
	p_u_24.QueueText.Text = v27 and (v27.DisplayName or "") or ""
	p_u_24.Icon.Image = v27 and v27.Image or ""
	p_u_24:_SetIsLeaving(false)
	p_u_24.VisibilityChanged:Fire()
	p_u_24.OpenedChanged:Fire()
	if p_u_24._current_queue_name then
		v_u_6:CreateSound("rbxassetid://18525513345", 1, 1, script, true, 5)
		task.spawn(function()
			-- upvalues: (copy) p_u_24, (copy) v_u_26, (ref) v_u_6
			for v28 = 0, (1 / 0) do
				if p_u_24._queue_hash ~= v_u_26 then
					return
				end
				p_u_24.TimerText.Text = v_u_6:TimeFormat(v28)
				wait(1)
			end
		end)
	end
end
function v_u_16._UpdateVisibility(p_u_29) -- name: _UpdateVisibility
	-- upvalues: (copy) v_u_13, (copy) v_u_11, (copy) v_u_12, (copy) v_u_10, (copy) v_u_9, (copy) v_u_2, (copy) v_u_3, (copy) v_u_5
	local v30 = not (v_u_13.PageSystem.CurrentPage or (v_u_11.IsOpen or v_u_12:IsVisible() or (v_u_10.Enabled or v_u_9.EditorEnabled)))
	if v30 then
		v30 = not v_u_2.MenuIsOpen
	end
	p_u_29._is_open = v30
	p_u_29.OpenedChanged:Fire()
	p_u_29.Container:TweenPosition(p_u_29._is_open and UDim2.new(0.5, 0, 0.075, 40) or UDim2.new(0.5, 0, -0.2, -40), "Out", "Quint", 0.25, true)
	if p_u_29._renderstep_connection then
		p_u_29._renderstep_connection:Disconnect()
		p_u_29._renderstep_connection = nil
	end
	local v_u_31 = 0
	local v_u_32 = tick() + 0.5
	local v33 = p_u_29._is_open
	if v33 then
		v33 = v_u_3.RenderStepped:Connect(function(_)
			-- upvalues: (copy) p_u_29, (ref) v_u_32, (ref) v_u_31, (ref) v_u_5
			local v34 = p_u_29.Icon
			local v35 = tick()
			v34.Rotation = math.sin(v35) * 5
			if tick() >= v_u_32 then
				v_u_31 = (v_u_31 + 1) % 4
				v_u_32 = tick() + 0.5
				local v36 = p_u_29._current_queue_name
				if v36 then
					v36 = v_u_5.PlaySources[p_u_29._current_queue_name]
				end
				local v37 = v36 and (v36.DuelLogic == "Zombie Tower" and "Searching for zombies" or (v36.DatabaseInfo.NumTeams * v36.DatabaseInfo.PlayersPerTeam <= 1 and "Waiting for server" or "Searching for players")) or "Searching for players"
				p_u_29.TitleText.Text = v37 .. string.rep(".", v_u_31)
			end
		end)
	end
	p_u_29._renderstep_connection = v33
end
function v_u_16._Init(p_u_38) -- name: _Init
	-- upvalues: (copy) v_u_8, (copy) v_u_11, (copy) v_u_13, (copy) v_u_12, (copy) v_u_10, (copy) v_u_9, (copy) v_u_2, (copy) v_u_1, (copy) v_u_14
	p_u_38.LeaveButton.MouseButton1Click:Connect(function()
		-- upvalues: (copy) p_u_38, (ref) v_u_8
		p_u_38:_SetIsLeaving(true)
		v_u_8:TryLeaveQueue()
	end)
	v_u_11.Opened:Connect(function()
		-- upvalues: (copy) p_u_38
		p_u_38:_UpdateVisibility()
	end)
	v_u_13.PageSystem.PageOpened:Connect(function()
		-- upvalues: (copy) p_u_38
		p_u_38:_UpdateVisibility()
	end)
	v_u_13.PageSystem.PageClosed:Connect(function()
		-- upvalues: (copy) p_u_38
		p_u_38:_UpdateVisibility()
	end)
	v_u_12.VisibilityChanged:Connect(function()
		-- upvalues: (copy) p_u_38
		p_u_38:_UpdateVisibility()
	end)
	v_u_10.EnabledChanged:Connect(function()
		-- upvalues: (copy) p_u_38
		p_u_38:_UpdateVisibility()
	end)
	v_u_9.EditorEnabledChanged:Connect(function()
		-- upvalues: (copy) p_u_38
		p_u_38:_UpdateVisibility()
	end)
	v_u_2:GetPropertyChangedSignal("MenuIsOpen"):Connect(function()
		-- upvalues: (copy) p_u_38
		p_u_38:_UpdateVisibility()
	end)
	v_u_1.Remotes.Matchmaking.UpdateQueueStatus.OnClientEvent:Connect(function(...)
		-- upvalues: (copy) p_u_38
		p_u_38:_SetQueueName(...)
	end)
	p_u_38:_SetQueueName(nil)
	p_u_38:_SetIsLeaving(false)
	p_u_38:_UpdateVisibility()
	v_u_14:Add(p_u_38.LeaveButton)
end
return v_u_16._new()