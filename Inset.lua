local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("GuiService")
local v_u_3 = game:GetService("Players")
require(v1.Modules.CONSTANTS)
local v_u_4 = require(v_u_3.LocalPlayer.PlayerScripts.Controllers:WaitForChild("ControlsController"))
local v_u_5 = require(v_u_3.LocalPlayer.PlayerScripts.Controllers:WaitForChild("FighterController"))
local v_u_6 = require(v_u_3.LocalPlayer.PlayerScripts.Modules.UserInterface:WaitForChild("MatchmakingCountdown"))
local v_u_7 = require(v_u_3.LocalPlayer.PlayerScripts.Modules.UserInterface:WaitForChild("Teleporting"))
local v_u_8 = require(v_u_3.LocalPlayer.PlayerScripts.Modules.UserInterface:WaitForChild("Equipment"))
local v_u_9 = require(v_u_3.LocalPlayer.PlayerScripts.Modules.UserInterface:WaitForChild("Shutdown"))
require(v_u_3.LocalPlayer.PlayerScripts.Modules:WaitForChild("ButtonEffect"))
local v_u_10 = require(v_u_3.LocalPlayer.PlayerScripts.Modules.UserInterface:WaitForChild("Pages"))
local v_u_11 = require(script:WaitForChild("MobileEditorBar"))
local v_u_12 = require(script:WaitForChild("ContextBar"))
local v_u_13 = require(script:WaitForChild("MainBar"))
local v_u_14 = require(script:WaitForChild("Details"))
local v_u_15 = v_u_3.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("InsetGui")
local v_u_16 = {}
v_u_16.__index = v_u_16
function v_u_16._new() -- name: _new
	-- upvalues: (copy) v_u_16, (copy) v_u_15, (copy) v_u_14, (copy) v_u_11, (copy) v_u_12, (copy) v_u_13
	local v17 = v_u_16
	local v18 = setmetatable({}, v17)
	v18.InsetGui = v_u_15
	v18.MainFrame = v18.InsetGui:WaitForChild("MainFrame")
	v18.Container = v18.MainFrame:WaitForChild("Container")
	v18.LeftButtonsFrame = v18.Container:WaitForChild("LeftButtons")
	v18.RightButtonsFrame = v18.Container:WaitForChild("RightButtons")
	v18.Details = v_u_14.new(v18)
	v18.MobileEditorBar = v_u_11.new(v18)
	v18.ContextBar = v_u_12.new(v18)
	v18.MainBar = v_u_13.new(v18)
	v18._local_fighter = nil
	v18:_Init()
	return v18
end
function v_u_16.IsWithinAnyBar(p19, p20, p21) -- name: IsWithinAnyBar
	return p19.MobileEditorBar.Bar:IsWithin(p20, p21) or (p19.ContextBar.Bar:IsWithin(p20, p21) or p19.MainBar.Bar:IsWithin(p20, p21))
end
function v_u_16._UpdateMirrored(p22) -- name: _UpdateMirrored
	-- upvalues: (copy) v_u_4
	local v23
	if v_u_4.CurrentControls == "Touch" then
		v23 = not p22._local_fighter or p22._local_fighter:Get("IsInDuel") or (p22._local_fighter:Get("IsInShootingRange") or #p22._local_fighter.Items > 0)
	else
		v23 = false
	end
	local v24 = not v23
	local v25
	if v23 then
		v25 = p22.LeftButtonsFrame
	else
		v25 = p22.RightButtonsFrame
	end
	p22.MainBar.Bar:SetMirrored(v24)
	p22.MainBar.Bar.Frame.Parent = v25
	p22.ContextBar.Bar:SetMirrored(v24)
	p22.ContextBar.Bar.Frame.Parent = v25
	local v26 = v24 and 1 or -1
	p22.ContextBar.Bar.Frame.LayoutOrder = v26 * 1
	p22.MainBar.Bar.Frame.LayoutOrder = v26 * 2
end
function v_u_16._UpdateVisibility(p27) -- name: _UpdateVisibility
	-- upvalues: (copy) v_u_10, (copy) v_u_7, (copy) v_u_6, (copy) v_u_2, (copy) v_u_9
	local v28 = not (v_u_10.PageSystem.CurrentPage or v_u_7.Enabled or (v_u_6:IsVisible() or v_u_2.MenuIsOpen))
	if v28 then
		v28 = not v_u_9.Enabled
	end
	p27.Details:SetVisible(v28)
	local v29 = p27.MainBar
	local v30
	if v28 then
		v30 = not p27.MobileEditorBar.Bar.Frame.Visible
	else
		v30 = v28
	end
	v29:SetVisible(v30)
	local v31 = p27.ContextBar
	local v32
	if v28 then
		v32 = not p27.MobileEditorBar.Bar.Frame.Visible
	else
		v32 = v28
	end
	v31:SetVisible(v32)
	local v33 = p27.MobileEditorBar
	if v28 then
		v28 = not p27.MainBar.Bar.Frame.Visible
	end
	v33:SetVisible(v28)
end
function v_u_16._CheckBigInset(p34) -- name: _CheckBigInset
	-- upvalues: (copy) v_u_2
	p34.LeftButtonsFrame.Size = UDim2.new(1, 0, 1, -12)
	p34.LeftButtonsFrame.Position = UDim2.new(0, 12, 1, 0)
	p34.LeftButtonsFrame.AnchorPoint = Vector2.new(0, 1)
	local v35 = p34.MainFrame.AbsoluteSize.Y > 100
	p34.Container.Size = v35 and UDim2.new(0, v_u_2.TopbarInset.Width, 0, 58) or UDim2.new(1, 0, 1, 0)
	p34.Container.Position = v35 and UDim2.new(0, v_u_2.TopbarInset.Min.X, 0, 0) or UDim2.new(0, 0, 0, 0)
	p34.RightButtonsFrame.Size = p34.LeftButtonsFrame.Size
	p34.RightButtonsFrame.Position = UDim2.new(-p34.LeftButtonsFrame.Position.X.Scale, -p34.LeftButtonsFrame.Position.X.Offset, p34.LeftButtonsFrame.Position.Y.Scale, p34.LeftButtonsFrame.Position.Y.Offset)
	p34.RightButtonsFrame.AnchorPoint = p34.LeftButtonsFrame.AnchorPoint
end
function v_u_16._HookLocalFighter(p_u_36) -- name: _HookLocalFighter
	-- upvalues: (copy) v_u_5
	p_u_36._local_fighter = v_u_5:WaitForLocalFighter()
	p_u_36._local_fighter:GetDataChangedSignal("IsInDuel"):Connect(function()
		-- upvalues: (copy) p_u_36
		p_u_36:_UpdateMirrored()
	end)
	p_u_36._local_fighter:GetDataChangedSignal("IsInShootingRange"):Connect(function()
		-- upvalues: (copy) p_u_36
		p_u_36:_UpdateMirrored()
	end)
	p_u_36._local_fighter.ItemAdded:Connect(function()
		-- upvalues: (copy) p_u_36
		p_u_36:_UpdateMirrored()
	end)
	p_u_36._local_fighter.ItemRemoved:Connect(function()
		-- upvalues: (copy) p_u_36
		p_u_36:_UpdateMirrored()
	end)
	p_u_36:_UpdateMirrored()
end
function v_u_16._Setup(p37) -- name: _Setup
	-- upvalues: (copy) v_u_3
	p37.MainFrame.Size = UDim2.new(1, 0, 1, 0)
	p37.InsetGui.Parent = v_u_3.LocalPlayer.PlayerGui
end
function v_u_16._Init(p_u_38) -- name: _Init
	-- upvalues: (copy) v_u_4, (copy) v_u_8, (copy) v_u_7, (copy) v_u_9, (copy) v_u_10, (copy) v_u_6, (copy) v_u_2
	p_u_38.MainFrame:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
		-- upvalues: (copy) p_u_38
		p_u_38:_CheckBigInset()
	end)
	p_u_38.MainBar.Bar.Frame:GetPropertyChangedSignal("Visible"):Connect(function()
		-- upvalues: (copy) p_u_38
		p_u_38:_UpdateVisibility()
	end)
	p_u_38.MobileEditorBar.Bar.Frame:GetPropertyChangedSignal("Visible"):Connect(function()
		-- upvalues: (copy) p_u_38
		p_u_38:_UpdateVisibility()
	end)
	v_u_4.ControlsChanged:Connect(function()
		-- upvalues: (copy) p_u_38
		p_u_38:_UpdateMirrored()
	end)
	v_u_8.Opened:Connect(function()
		-- upvalues: (copy) p_u_38
		p_u_38:_UpdateVisibility()
	end)
	v_u_7.EnabledChanged:Connect(function()
		-- upvalues: (copy) p_u_38
		p_u_38:_UpdateVisibility()
	end)
	v_u_9.EnabledChanged:Connect(function()
		-- upvalues: (copy) p_u_38
		p_u_38:_UpdateVisibility()
	end)
	v_u_10.PageSystem.PagesActivity:Connect(function()
		-- upvalues: (copy) p_u_38
		p_u_38:_UpdateVisibility()
		task.defer(p_u_38._UpdateVisibility, p_u_38)
	end)
	v_u_6.VisibilityChanged:Connect(function()
		-- upvalues: (copy) p_u_38
		p_u_38:_UpdateVisibility()
	end)
	v_u_2:GetPropertyChangedSignal("TopbarInset"):Connect(function()
		-- upvalues: (copy) p_u_38
		p_u_38:_CheckBigInset()
	end)
	v_u_2:GetPropertyChangedSignal("MenuIsOpen"):Connect(function()
		-- upvalues: (copy) p_u_38
		p_u_38:_UpdateVisibility()
	end)
	p_u_38:_Setup()
	p_u_38:_CheckBigInset()
	p_u_38:_UpdateVisibility()
	task.defer(p_u_38._HookLocalFighter, p_u_38)
end
return v_u_16._new()