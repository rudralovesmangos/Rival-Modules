local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("GuiService")
local v_u_3 = game:GetService("Players")
local v_u_4 = require(v1.Modules.BetterDebris)
local v_u_5 = require(v1.Modules.DuelLibrary)
local v_u_6 = require(v1.Modules.ItemLibrary)
local v_u_7 = require(v1.Modules.Utility)
local v_u_8 = require(v1.Modules.Signal)
local v_u_9 = require(v_u_3.LocalPlayer.PlayerScripts.Controllers:WaitForChild("ComplianceController"))
local v_u_10 = require(v_u_3.LocalPlayer.PlayerScripts.Controllers:WaitForChild("ControlsController"))
local v_u_11 = require(v_u_3.LocalPlayer.PlayerScripts.Controllers:WaitForChild("FighterController"))
local v_u_12 = require(v_u_3.LocalPlayer.PlayerScripts.Controllers:WaitForChild("DuelController"))
local v_u_13 = require(v_u_3.LocalPlayer.PlayerScripts.Modules:WaitForChild("WeaponStatusHandler"))
local v_u_14 = require(v_u_3.LocalPlayer.PlayerScripts.Modules:WaitForChild("TeammateSlot"))
local v_u_15 = require(v_u_3.LocalPlayer.PlayerScripts.Modules:WaitForChild("UILibrary"))
local v_u_16 = v_u_3.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("EliminatedCard")
local v_u_17 = {}
v_u_17.__index = v_u_17
function v_u_17._new() -- name: _new
	-- upvalues: (copy) v_u_17, (copy) v_u_8, (copy) v_u_15
	local v18 = v_u_17
	local v19 = setmetatable({}, v18)
	v19.VisibilityChanged = v_u_8.new()
	v19.Frame = v_u_15:GetTo("MainFrame", "EliminatedEffect")
	v19._last_eliminated_card = nil
	v19:_Init()
	return v19
end
function v_u_17.IsVisible(p20) -- name: IsVisible
	return p20._last_eliminated_card ~= nil
end
function v_u_17.Play(p21, p22, p23, p24, p25, p26) -- name: Play
	-- upvalues: (copy) v_u_7, (copy) v_u_3, (copy) v_u_16, (copy) v_u_9, (copy) v_u_6, (copy) v_u_5, (copy) v_u_13, (copy) v_u_4, (copy) v_u_12, (copy) v_u_14
	if p21._last_eliminated_card then
		p21._last_eliminated_card:Destroy()
	end
	v_u_7:CreateSound("rbxassetid://17016581922", 0.75, 1 + 0.1 * math.random(), script, true, 10)
	local v27 = p22 or v_u_3.LocalPlayer
	local v28 = v27 == v_u_3.LocalPlayer
	local v29 = typeof(v27) == "Instance"
	local v30
	if typeof(v27) == "table" then
		v30 = v27
	else
		v30 = false
	end
	local v_u_31 = v_u_16:Clone()
	v_u_31.Frame.Container.Clip.Container.Description.Text = "eliminated " .. (v28 and "yourself" or "you") .. (p25 and (" with " .. p25 or "") or "")
	v_u_31.Frame.Container.Clip.Container.Username.Text = (v28 or (not v29 or v27.Name == v27.DisplayName)) and "" or ("@" .. v27.Name or "")
	v_u_31.Frame.Container.Clip.Container.Player.Text = v28 or v29 and v_u_9:GetName(v27) or (v30 and (v30.DisplayName or "???") or "???")
	v_u_31.Frame.Container.Clip.Container.Player.Position = v_u_31.Frame.Container.Clip.Container.Username.Text == "" and UDim2.new(0.2, 0, 0.35, 0) or UDim2.new(0.2, 0, 0.225, 0)
	v_u_31.Frame.Container.Clip.Container.Weapon.Image = v_u_6:GetViewModelImage(p25, p26, true) or ""
	v_u_31.Frame.Container.Clip.Container.Background.ImageColor3 = v29 and v_u_5:GetTeamColor(v27:GetAttribute("TeamID")) or v_u_5.EMPTY_TEAM_COLOR
	v_u_31.Frame.Container.Clip.Container.PlayerSlot.FakeEliminator.Image = v30 and v30.Image or ""
	v_u_31.Frame.Container.Weapon.Image = v_u_31.Frame.Container.Clip.Container.Weapon.Image
	if p25 and v_u_6.Items[p25] then
		v_u_13:ApplyItemStatusToText(v_u_31.Frame.Container.Clip.Container.Description, v_u_6.Items[p25].Status)
	end
	v_u_31.Parent = p21.Frame
	v_u_4:AddItem(v_u_31, 10)
	p21:_SetLastEliminatedCard(v_u_31)
	if v29 then
		local v32 = v_u_12:GetDuel(v_u_3.LocalPlayer)
		local v33
		if v32 then
			v33 = v32:GetDueler(v27)
		else
			v33 = v32
		end
		if v32 then
			v32 = v32.IsRanked
		end
		local v34
		if v32 then
			v34 = nil
		else
			v34 = v27:GetAttribute("StatisticDuelsWinStreak")
		end
		local v35
		if v32 then
			v35 = nil
		else
			v35 = v27:GetAttribute("Level")
		end
		local v36 = v27:GetAttribute("DisplayELO")
		local v37 = v_u_14.new(v27.UserId, p23, p24, nil, nil, v34, v35)
		v37.SlotFrame.Parent = v_u_31.Frame.Container.Clip.Container.PlayerSlot
		if v32 and (v33 and v33:CanShowRankToLocalPlayer()) then
			v37:SetDisplayELO(v36)
		end
	end
	v_u_31.Frame.Container.Size = UDim2.new(0, 0, 1, 0)
	v_u_31.Frame.Container:TweenSize(UDim2.new(1, 0, 1, 0), "Out", "Quint", 1, true)
	wait(5)
	v_u_7:RenderstepForLoop(0, 100, 5, function(p38)
		-- upvalues: (copy) v_u_31
		v_u_31.GroupTransparency = (p38 / 100) ^ 5
	end)
	v_u_31:Destroy()
	if p21._last_eliminated_card == v_u_31 then
		p21:_SetLastEliminatedCard(nil)
	end
end
function v_u_17._UpdateVisibility(p39) -- name: _UpdateVisibility
	-- upvalues: (copy) v_u_2
	p39.Frame.Visible = not v_u_2.MenuIsOpen
end
function v_u_17._SetLastEliminatedCard(p40, p41) -- name: _SetLastEliminatedCard
	p40._last_eliminated_card = p41
	p40.VisibilityChanged:Fire()
end
function v_u_17._HookLocalFighter(p_u_42) -- name: _HookLocalFighter
	-- upvalues: (copy) v_u_11, (copy) v_u_10
	v_u_11:WaitForLocalFighter().EntityAdded:Connect(function()
		-- upvalues: (copy) p_u_42, (ref) v_u_10
		if p_u_42._last_eliminated_card and v_u_10.CurrentControls == "Touch" then
			p_u_42._last_eliminated_card:Destroy()
			p_u_42:_SetLastEliminatedCard(nil)
		end
	end)
end
function v_u_17._Init(p_u_43) -- name: _Init
	-- upvalues: (copy) v_u_2
	v_u_2:GetPropertyChangedSignal("MenuIsOpen"):Connect(function()
		-- upvalues: (copy) p_u_43
		p_u_43:_UpdateVisibility()
	end)
	p_u_43:_UpdateVisibility()
	task.defer(p_u_43._HookLocalFighter, p_u_43)
end
return v_u_17._new()