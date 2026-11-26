local v_u_1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("Players")
local v_u_3 = require(v_u_1.Modules.CONSTANTS)
local v_u_4 = require(v_u_1.Modules.SettingsInfo)
local v_u_5 = require(v_u_1.Modules.DuelLibrary)
require(v_u_1.Modules.Utility)
local v_u_6 = require(v_u_2.LocalPlayer.PlayerScripts.Controllers:WaitForChild("PrivateServerController"))
require(v_u_2.LocalPlayer.PlayerScripts.Controllers:WaitForChild("ComplianceController"))
local v_u_7 = require(v_u_2.LocalPlayer.PlayerScripts.Controllers:WaitForChild("FighterController"))
local v_u_8 = require(v_u_2.LocalPlayer.PlayerScripts.Controllers:WaitForChild("ArcadeController"))
local v_u_9 = require(v_u_2.LocalPlayer.PlayerScripts.Modules:WaitForChild("ButtonEffect"))
local v_u_10 = require(v_u_2.LocalPlayer.PlayerScripts.Modules:WaitForChild("Page"))
local v_u_11 = v_u_2.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("PrivateServerPlayerSlot")
local v_u_12 = v_u_2.LocalPlayer.PlayerScripts.Modules:WaitForChild("Settings")
local v_u_13 = {
	{
		"ArcadeStart",
		"",
		"",
		"Private Arcade",
		"rbxassetid://81276179444570",
		"Launch a private Arcade duel",
		"DropdownConfirm",
		v_u_5:GetArcadeModeDisplayNames()[1],
		v_u_5:GetArcadeModeDisplayNames(),
		true
	},
	{
		"ArcadeCanPlayAllMaps",
		"",
		"",
		"Play Any Map",
		"rbxassetid://18129688386",
		"Allows you to vote for any map in this duel",
		"Toggle",
		false
	},
	{
		"ArcadeEnd",
		"",
		"",
		"Private Arcade",
		"rbxassetid://81276179444570",
		"End the private Arcade duel",
		"Confirm",
		false
	},
	{
		"FreecamEnabled",
		"",
		"",
		"Freecam Access",
		"rbxassetid://17548980857",
		"Activated by pressing [Shift] + [P]",
		"Dropdown",
		"Everyone",
		{ "Everyone", "Server Owner", "Nobody" }
	},
	{
		"UseLockedWeapons",
		"",
		"",
		"Use Locked Weapons",
		"rbxassetid://17229230506",
		"Allows all players to use locked weapons in duels",
		"Toggle",
		true
	},
	{
		"ShootingRangePVP",
		"",
		"",
		"Shooting Range PVP",
		"rbxassetid://119084789924359",
		"Allows you to battle each other in the Shooting Range",
		"Toggle",
		false
	}
}
local v_u_14 = setmetatable({}, v_u_10)
v_u_14.__index = v_u_14
function v_u_14._new() -- name: _new
	-- upvalues: (copy) v_u_10, (copy) v_u_14
	local v15 = v_u_10.new(script.Name)
	local v16 = v_u_14
	local v17 = setmetatable(v15, v16)
	v17.CloseButton = v17.PageFrame:WaitForChild("Close")
	v17.LockedFrame = v17.PageFrame:WaitForChild("Locked")
	v17.List = v17.PageFrame:WaitForChild("List")
	v17.Container = v17.List:WaitForChild("Container")
	v17.Layout = v17.Container:WaitForChild("Layout")
	v17.PlayersFrame = v17.Container:WaitForChild("Players")
	v17.PlayersContainer = v17.PlayersFrame:WaitForChild("Container")
	v17.PlayersLayout = v17.PlayersContainer:WaitForChild("Layout")
	v17.BannedPlayersFrame = v17.Container:WaitForChild("BannedPlayers")
	v17.BannedPlayersContainer = v17.BannedPlayersFrame:WaitForChild("Container")
	v17.BannedPlayersLayout = v17.BannedPlayersContainer:WaitForChild("Layout")
	v17._setting_objects = {}
	v17._player_slots = {}
	v17._arcade_mode_display_names = nil
	v17._to_arcade_mode_name = nil
	v17:_Init()
	return v17
end
function v_u_14.Open(p18, ...) -- name: Open
	-- upvalues: (copy) v_u_10
	v_u_10.Open(p18, ...)
	p18:_UpdatePlayers()
	p18:_UpdateArcadeStatus()
end
function v_u_14._UpdateArcade(p19) -- name: _UpdateArcade
	-- upvalues: (copy) v_u_5
	local v20, v21 = v_u_5:GetArcadeModeDisplayNames()
	p19._arcade_mode_display_names = v20
	p19._to_arcade_mode_name = v21
end
function v_u_14._UpdateArcadeStatus(p22) -- name: _UpdateArcadeStatus
	-- upvalues: (copy) v_u_8
	if p22:IsOpen() then
		local v23 = v_u_8.CurrentDuel ~= nil
		p22._setting_objects.ArcadeStart.SettingFrame.Visible = not v23
		p22._setting_objects.ArcadeCanPlayAllMaps.SettingFrame.Visible = not v23
		p22._setting_objects.ArcadeEnd.SettingFrame.Visible = v23
	end
end
function v_u_14._CreatePlayerSlot(p24, p25, p26, p27, p28, p29, p30, p31, p32) -- name: _CreatePlayerSlot
	-- upvalues: (copy) v_u_11, (copy) v_u_3, (copy) v_u_9
	local v_u_33 = v_u_11:Clone()
	v_u_33.Kick.Visible = p30
	v_u_33.Ban.Visible = p31
	v_u_33.Unban.Visible = p32
	v_u_33.Icon.Image = string.format(v_u_3.HEADSHOT_IMAGE, p27)
	v_u_33.DisplayName.Controls.Image = ""
	v_u_33.DisplayName.Text = p28
	v_u_33.Username.Text = "@" .. p29
	v_u_33.LayoutOrder = p25
	v_u_33.Parent = p26
	p24._player_slots[tostring(p27)] = v_u_33
	v_u_33.DisplayName:GetPropertyChangedSignal("TextBounds"):Connect(function() -- name: update
		-- upvalues: (copy) v_u_33
		v_u_33.DisplayName.Controls.Position = UDim2.new(0, v_u_33.DisplayName.TextBounds.X, 0.5, 0)
	end)
	v_u_33.DisplayName.Controls.Position = UDim2.new(0, v_u_33.DisplayName.TextBounds.X, 0.5, 0)
	v_u_9:Add(v_u_33.Kick)
	v_u_9:Add(v_u_33.Ban)
	v_u_9:Add(v_u_33.Unban)
	return v_u_33
end
function v_u_14._UpdatePlayers(p34) -- name: _UpdatePlayers
	-- upvalues: (copy) v_u_7, (copy) v_u_3, (copy) v_u_2, (copy) v_u_6, (copy) v_u_1
	if p34:IsOpen() then
		local v35 = {}
		for v36, v37 in pairs(v_u_7.Objects) do
			local v_u_38 = v37.Player
			if not v_u_3.IS_STUDIO and v_u_38 == v_u_2.LocalPlayer then
				continue
			end
			local v39 = v_u_38.UserId
			v35[tostring(v39)] = true
			local v40 = p34._player_slots
			local v41 = v_u_38.UserId
			if v40[tostring(v41)] then
				continue
			end
			local v42 = p34:_CreatePlayerSlot(v36, p34.PlayersContainer, v_u_38.UserId, v_u_38.DisplayName, v_u_38.Name, v_u_3.IS_STUDIO or v_u_38 ~= v_u_2.LocalPlayer, true, false)
			v42.Kick.MouseButton1Click:Connect(function()
				-- upvalues: (ref) v_u_6, (copy) v_u_38
				v_u_6:ServerKick(v_u_38)
			end)
			v42.Ban.MouseButton1Click:Connect(function()
				-- upvalues: (ref) v_u_6, (copy) v_u_38
				v_u_6:ServerBan(v_u_38)
			end)
		end
		for v43, v44 in pairs(v_u_6.BannedPlayers) do
			local v_u_45, v46, v47 = table.unpack(v44)
			v35[tostring(v_u_45)] = true
			if p34._player_slots[tostring(v_u_45)] then
				continue
			end
			p34:_CreatePlayerSlot(v43, p34.BannedPlayersContainer, v_u_45, v46, v47, false, false, true).Unban.MouseButton1Click:Connect(function()
				-- upvalues: (ref) v_u_1, (copy) v_u_45
				v_u_1.Remotes.PrivateServer.UnbanPlayer:FireServer(v_u_45)
			end)
		end
		local v48 = {}
		for v49, v50 in pairs(p34._player_slots) do
			if v35[v49] then
				continue
			end
			v48[v49] = true
			v50:Destroy()
		end
		for v51 in pairs(v48) do
			p34._player_slots[v51] = nil
		end
	else
		for _, v52 in pairs(p34._player_slots) do
			v52:Destroy()
		end
		p34._player_slots = {}
	end
end
function v_u_14._Setup(p_u_53) -- name: _Setup
	-- upvalues: (copy) v_u_13, (copy) v_u_4, (copy) v_u_12, (copy) v_u_1, (copy) v_u_3, (copy) v_u_2
	for v54, v55 in pairs(v_u_13) do
		local v56 = v55[1]
		local v57 = v_u_4.new(select(2, table.unpack(v55)))
		require(v_u_12:WaitForChild(v57.InputType))
		local v58 = require(v_u_12:WaitForChild(v57.InputType)).new(v57)
		v58.SettingFrame.LayoutOrder = v54
		v58.SettingFrame.Parent = p_u_53.Container
		p_u_53._setting_objects[v56] = v58
	end
	p_u_53._setting_objects.UseLockedWeapons.Replicate:Connect(function(p59)
		-- upvalues: (ref) v_u_1
		v_u_1.Remotes.PrivateServer.SetUseLockedWeapons:FireServer(p59 or false)
	end)
	p_u_53._setting_objects.ShootingRangePVP.Replicate:Connect(function(p60)
		-- upvalues: (ref) v_u_1
		v_u_1.Remotes.PrivateServer.SetShootingRangePVP:FireServer(p60 or false)
	end)
	p_u_53._setting_objects.FreecamEnabled.Replicate:Connect(function(p61)
		-- upvalues: (ref) v_u_1
		v_u_1.Remotes.PrivateServer.SetFreecamEnabled:FireServer(p61)
	end)
	p_u_53._setting_objects.ArcadeCanPlayAllMaps.Replicate:Connect(function(p62)
		-- upvalues: (ref) v_u_1
		v_u_1.Remotes.PrivateServer.SetArcadeCanPlayAllMaps:FireServer(p62)
	end)
	p_u_53._setting_objects.ArcadeStart.Replicate:Connect(function(p63)
		-- upvalues: (copy) p_u_53, (ref) v_u_1
		p_u_53:_UpdateArcade()
		v_u_1.Remotes.PrivateServer.StartArcadeMode:FireServer(p_u_53._to_arcade_mode_name[p63])
	end)
	p_u_53._setting_objects.ArcadeEnd.Replicate:Connect(function()
		-- upvalues: (ref) v_u_1
		v_u_1.Remotes.PrivateServer.EndArcadeMode:FireServer()
	end)
	p_u_53._setting_objects.ArcadeEnd:SetConfirmColor("Red")
	p_u_53._setting_objects.ArcadeCanPlayAllMaps:Scale(0.95)
	local v64 = v_u_3.IS_PRIVATE_SERVER_OWNER(v_u_2.LocalPlayer.UserId)
	p_u_53.LockedFrame.Visible = not v64
	p_u_53.List.Visible = v64
end
function v_u_14._Init(p_u_65) -- name: _Init
	-- upvalues: (copy) v_u_7, (copy) v_u_6, (copy) v_u_8, (copy) v_u_9
	p_u_65.CloseButton.MouseButton1Click:Connect(function()
		-- upvalues: (copy) p_u_65
		p_u_65:CloseRequest()
	end)
	p_u_65.Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		-- upvalues: (copy) p_u_65
		p_u_65.List.CanvasSize = UDim2.new(0, 0, 0, p_u_65.Layout.AbsoluteContentSize.Y)
		p_u_65.List.Active = p_u_65.Layout.AbsoluteContentSize.Y >= p_u_65.List.AbsoluteSize.Y
	end)
	p_u_65.PlayersLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		-- upvalues: (copy) p_u_65
		p_u_65.PlayersFrame.Size = UDim2.new(1, 0, 0, p_u_65.PlayersLayout.AbsoluteContentSize.Y)
	end)
	p_u_65.PlayersFrame:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
		-- upvalues: (copy) p_u_65
		p_u_65.PlayersFrame.Visible = p_u_65.PlayersFrame.AbsoluteSize.Y > 0
	end)
	p_u_65.BannedPlayersLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		-- upvalues: (copy) p_u_65
		p_u_65.BannedPlayersFrame.Size = UDim2.new(1, 0, 0, p_u_65.BannedPlayersLayout.AbsoluteContentSize.Y)
	end)
	p_u_65.BannedPlayersFrame:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
		-- upvalues: (copy) p_u_65
		p_u_65.BannedPlayersFrame.Visible = p_u_65.BannedPlayersFrame.AbsoluteSize.Y > 0
	end)
	v_u_7.ObjectAdded:Connect(function()
		-- upvalues: (copy) p_u_65
		p_u_65:_UpdatePlayers()
	end)
	v_u_7.ObjectRemoved:Connect(function()
		-- upvalues: (copy) p_u_65
		p_u_65:_UpdatePlayers()
	end)
	v_u_6.BannedPlayersChanged:Connect(function()
		-- upvalues: (copy) p_u_65
		p_u_65:_UpdatePlayers()
	end)
	v_u_8.DuelSet:Connect(function()
		-- upvalues: (copy) p_u_65
		p_u_65:_UpdateArcadeStatus()
	end)
	p_u_65:_Setup()
	p_u_65:_UpdateArcade()
	v_u_9:Add(p_u_65.CloseButton)
end
return v_u_14._new()