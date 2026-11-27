local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("UserInputService")
local v_u_3 = game:GetService("StarterGui")
local v_u_4 = game:GetService("GuiService")
local v5 = game:GetService("Players")
local v_u_6 = require(v1.Modules.InputLibrary)
local v_u_7 = require(v1.Modules.Signal)
require(v5.LocalPlayer.PlayerScripts.Controllers.PlayerDataController)
local v_u_8 = require(v5.LocalPlayer.PlayerScripts.Controllers.ControlsController)
local v_u_9 = require(v5.LocalPlayer.PlayerScripts.Controllers.SpectateController)
local v_u_10 = require(v5.LocalPlayer.PlayerScripts.Controllers.FighterController)
local v_u_11 = require(v5.LocalPlayer.PlayerScripts.Modules.UserInterface:WaitForChild("MatchmakingCountdown"))
local v_u_12 = require(v5.LocalPlayer.PlayerScripts.Modules.UserInterface:WaitForChild("MobileInputs"))
local v_u_13 = require(v5.LocalPlayer.PlayerScripts.Modules.UserInterface:WaitForChild("Teleporting"))
local v_u_14 = require(v5.LocalPlayer.PlayerScripts.Modules.UserInterface:WaitForChild("Equipment"))
local v_u_15 = require(v5.LocalPlayer.PlayerScripts.Modules.UserInterface:WaitForChild("Pages"))
local v_u_16 = require(v5.LocalPlayer.PlayerScripts.Modules.UserInterface:WaitForChild("Queue"))
local v_u_17 = require(v5.LocalPlayer.PlayerScripts.Modules:WaitForChild("UILibrary"))
local v_u_18 = require(script:WaitForChild("Elements"))
local v_u_19 = require(script:WaitForChild("Inspect"))
local v_u_20 = {}
v_u_20.__index = v_u_20
function v_u_20._new() -- name: _new
	-- upvalues: (copy) v_u_20, (copy) v_u_7, (copy) v_u_17, (copy) v_u_18, (copy) v_u_19
	local v21 = v_u_20
	local v22 = setmetatable({}, v21)
	v22.OpenedChanged = v_u_7.new()
	v22.ClosedByInputsChanged = v_u_7.new()
	v22.BaseVisibilityChanged = v_u_7.new()
	v22.Frame = v_u_17:GetTo("PlayerList")
	v22.Container = v22.Frame:WaitForChild("Container")
	v22.IsOpen = nil
	v22.ClosedByInputs = false
	v22.Elements = v_u_18.new(v22)
	v22.Inspect = v_u_19.new(v22)
	v22._local_fighter = nil
	v22._opened_connections = {}
	v22._is_disabled = false
	v22._scale = 1
	v22:_Init()
	return v22
end
function v_u_20.GetBaseVisibility(p23) -- name: GetBaseVisibility
	-- upvalues: (copy) v_u_12, (copy) v_u_13, (copy) v_u_9, (copy) v_u_14, (copy) v_u_15, (copy) v_u_11, (copy) v_u_4, (copy) v_u_16
	local v24 = not (v_u_12.EditorEnabled or v_u_13.Enabled or (v_u_9.CurrentDuelSubject or v_u_14.IsOpen) or (v_u_15.PageSystem.CurrentPage or v_u_11:IsVisible() or (v_u_4.MenuIsOpen or v_u_16:IsVisible())))
	if v24 then
		local v25 = p23._local_fighter
		if v25 then
			v25 = p23._local_fighter:Get("IsInShootingRange")
		end
		v24 = not v25
	end
	return v24
end
function v_u_20.SetDisabled(p26, p27) -- name: SetDisabled
	if p27 ~= p26._is_disabled then
		p26._is_disabled = p27
		p26:_UpdateVisibility()
	end
end
function v_u_20.SetScale(p28, p29) -- name: SetScale
	p28._scale = p29
	p28.Container.Size = UDim2.new(p28._scale, 0, p28._scale, 0)
	p28:_UpdateSize()
	p28.Inspect:SetScale(p29)
end
function v_u_20.SetClosedByInputs(p30, p31) -- name: SetClosedByInputs
	p30.ClosedByInputs = p31
	p30.ClosedByInputsChanged:Fire()
end
function v_u_20.SetIsFriend(p32, p33, p34) -- name: SetIsFriend
	for v35, v36 in pairs(p32.Elements.PlayerListSlots) do
		if v35.Player ~= p33 then
			continue
		end
		v36:SetIsFriend(p34)
	end
end
function v_u_20.SetIsBlocked(p37, p38, p39) -- name: SetIsBlocked
	for v40, v41 in pairs(p37.Elements.PlayerListSlots) do
		if v40.Player ~= p38 then
			continue
		end
		v41:SetIsBlocked(p39)
	end
end
function v_u_20.SetRequestDuration(p42, p43, ...) -- name: SetRequestDuration
	local v44 = p42.Elements:GetPlayerListSlot(p43)
	if v44 then
		v44:SetRequestDuration(...)
	end
end
function v_u_20.SelectPlayerExternally(p45, p46) -- name: SelectPlayerExternally
	p45.Inspect:SelectPlayer(p45.Elements:GetPlayerListSlot(p46))
end
function v_u_20.OnOpened(p_u_47) -- name: OnOpened
	-- upvalues: (copy) v_u_4
	p_u_47:AddOpenedConnection(p_u_47.Frame.Parent:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
		-- upvalues: (copy) p_u_47
		p_u_47:_UpdateSize()
	end))
	p_u_47:AddOpenedConnection(v_u_4:GetPropertyChangedSignal("TopbarInset"):Connect(function()
		-- upvalues: (copy) p_u_47
		p_u_47:_UpdatePosition()
	end))
	p_u_47:_UpdateSize()
	p_u_47:_UpdatePosition()
	p_u_47.Elements:OnOpened()
	p_u_47.Inspect:OnOpened()
end
function v_u_20.AddOpenedConnection(p48, p49) -- name: AddOpenedConnection
	local v50 = p48._opened_connections
	table.insert(v50, p49)
end
function v_u_20._IsVisibleRegardlessOfInputs(p51) -- name: _IsVisibleRegardlessOfInputs
	local v52 = p51:GetBaseVisibility()
	if v52 then
		v52 = not p51._is_disabled
	end
	return v52
end
function v_u_20._UpdateSize(p53) -- name: _UpdateSize
	local v54 = p53.Frame
	local v55 = UDim2.new
	local v56 = p53.Frame.Parent.AbsoluteSize.X * 0.5
	v54.Size = v55(0, math.min(320, v56), 0.5 * p53._scale, 0)
end
function v_u_20._UpdatePosition(p57) -- name: _UpdatePosition
	-- upvalues: (copy) v_u_4
	p57.Container.Position = UDim2.new(1, 0, 0, v_u_4.TopbarInset.Height)
end
function v_u_20._UpdateVisibility(p58) -- name: _UpdateVisibility
	p58.BaseVisibilityChanged:Fire()
	local v59 = p58:_IsVisibleRegardlessOfInputs()
	if v59 then
		v59 = not p58.ClosedByInputs
	end
	if v59 == p58.IsOpen then
		return
	else
		p58.IsOpen = v59
		p58.OpenedChanged:Fire()
		task.defer(p58.Frame.TweenPosition, p58.Frame, p58.IsOpen and UDim2.new(1, -10, 0, 10) or UDim2.new(1, 650, 0, 10), "Out", "Quint", 0.25, true)
		if p58.IsOpen then
			p58:OnOpened()
		else
			for _, v60 in pairs(p58._opened_connections) do
				v60:Disconnect()
			end
			p58._opened_connections = {}
		end
	end
end
function v_u_20._HookGetCore(_, p_u_61, p_u_62) -- name: _HookGetCore
	-- upvalues: (copy) v_u_3
	task.spawn(function()
		-- upvalues: (ref) v_u_3, (copy) p_u_61, (copy) p_u_62
		local v63 = nil
		while true do
			if v63 then
				v68 = v63
				break
			end
			local v64 = v_u_3.GetCore
			local v65 = v_u_3
			local v66 = p_u_61
			local v67, v68 = pcall(v64, v65, v66)
			if v67 then
				break
			end
			wait(1)
		end
		v68.Event:Connect(p_u_62)
	end)
end
function v_u_20._HookLocalFighter(p_u_69) -- name: _HookLocalFighter
	-- upvalues: (copy) v_u_10
	p_u_69._local_fighter = v_u_10:WaitForLocalFighter()
	p_u_69._local_fighter:GetDataChangedSignal("IsInShootingRange"):Connect(function()
		-- upvalues: (copy) p_u_69
		p_u_69:_UpdateVisibility()
	end)
	p_u_69:_UpdateVisibility()
end
function v_u_20._Init(p_u_70) -- name: _Init
	-- upvalues: (copy) v_u_8, (copy) v_u_9, (copy) v_u_14, (copy) v_u_15, (copy) v_u_13, (copy) v_u_12, (copy) v_u_11, (copy) v_u_4, (copy) v_u_16, (copy) v_u_2, (copy) v_u_6
	p_u_70.ClosedByInputsChanged:Connect(function()
		-- upvalues: (copy) p_u_70
		p_u_70:_UpdateVisibility()
	end)
	p_u_70:_HookGetCore("PlayerFriendedEvent", function(p71)
		-- upvalues: (copy) p_u_70
		p_u_70:SetIsFriend(p71, true)
	end)
	p_u_70:_HookGetCore("PlayerUnfriendedEvent", function(p72)
		-- upvalues: (copy) p_u_70
		p_u_70:SetIsFriend(p72, false)
	end)
	p_u_70:_HookGetCore("PlayerBlockedEvent", function(p73)
		-- upvalues: (copy) p_u_70
		p_u_70:SetIsBlocked(p73, true)
	end)
	p_u_70:_HookGetCore("PlayerUnblockedEvent", function(p74)
		-- upvalues: (copy) p_u_70
		p_u_70:SetIsBlocked(p74, false)
	end)
	v_u_8.ControlsChanged:Connect(function()
		-- upvalues: (copy) p_u_70
		p_u_70:_UpdateVisibility()
	end)
	v_u_9.DuelSubjectChanged:Connect(function()
		-- upvalues: (copy) p_u_70
		p_u_70:_UpdateVisibility()
	end)
	v_u_14.Opened:Connect(function()
		-- upvalues: (copy) p_u_70
		p_u_70:_UpdateVisibility()
	end)
	v_u_15.PageSystem.PagesActivity:Connect(function()
		-- upvalues: (copy) p_u_70
		p_u_70:_UpdateVisibility()
	end)
	v_u_13.EnabledChanged:Connect(function()
		-- upvalues: (copy) p_u_70
		p_u_70:_UpdateVisibility()
	end)
	v_u_12.EditorEnabledChanged:Connect(function()
		-- upvalues: (copy) p_u_70
		p_u_70:_UpdateVisibility()
	end)
	v_u_11.VisibilityChanged:Connect(function()
		-- upvalues: (copy) p_u_70
		p_u_70:_UpdateVisibility()
	end)
	v_u_4:GetPropertyChangedSignal("MenuIsOpen"):Connect(function()
		-- upvalues: (copy) p_u_70
		p_u_70:_UpdateVisibility()
	end)
	v_u_16.VisibilityChanged:Connect(function()
		-- upvalues: (copy) p_u_70
		p_u_70:_UpdateVisibility()
	end)
	v_u_2.InputBegan:Connect(function(p75, p76)
		-- upvalues: (copy) p_u_70, (ref) v_u_6, (ref) v_u_2
		if not p76 and (p_u_70:_IsVisibleRegardlessOfInputs() and (v_u_6:InputIs(p75, "OpenPlayerList") and not v_u_2:IsKeyDown(Enum.KeyCode.LeftAlt))) then
			p_u_70:SetClosedByInputs(not p_u_70.ClosedByInputs)
		end
	end)
	p_u_70:_UpdateSize()
	p_u_70:_UpdatePosition()
	p_u_70:_UpdateVisibility()
	task.defer(p_u_70._HookLocalFighter, p_u_70)
end
return v_u_20._new()