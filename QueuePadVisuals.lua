local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("Players")
local v_u_3 = require(v1.Modules.CONSTANTS)
local v_u_4 = require(v1.Modules.EventLibrary)
local v_u_5 = require(v1.Modules.DuelLibrary)
local v_u_6 = require(v_u_2.LocalPlayer.PlayerScripts.Modules.TeammateSlot)
local v_u_7 = v_u_2.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("LobbyVisuals")
local v_u_8 = v_u_2.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("QueuePadPlayerSlot")
local v_u_9 = {}
v_u_9.__index = v_u_9
function v_u_9.new(p10) -- name: new
	-- upvalues: (copy) v_u_9
	local v11 = v_u_9
	local v12 = setmetatable({}, v11)
	v12.ClientQueuePad = p10
	v12._visuals_folder = v12.ClientQueuePad:Get("Model"):WaitForChild("Visuals")
	v12._teammate_slots = {}
	v12._team_slots = {}
	v12._pads = {}
	v12._surface_guis = {}
	v12:_Init()
	return v12
end
function v_u_9.Destroy(p13) -- name: Destroy
	for _, v14 in pairs(p13._surface_guis) do
		v14:Destroy()
	end
end
function v_u_9._UpdateQueueName(p15) -- name: _UpdateQueueName
	-- upvalues: (copy) v_u_5, (copy) v_u_3
	local v16 = p15.ClientQueuePad:Get("NumTeams")
	local v17 = p15.ClientQueuePad:Get("PlayersPerTeam")
	local v18 = p15.ClientQueuePad:Get("InfinitePlayersPerTeam")
	local v19 = p15.ClientQueuePad:GetActualQueueName()
	local v20 = v_u_5.MatchmakingQueues[v19]
	for v21, v22 in pairs(p15._surface_guis) do
		local v23 = v22.MainFrame.Warning
		local v24 = v21 == 1 and not (v20 and v20.AreStreaksDisabled())
		if v24 then
			v24 = v_u_3.IS_PUBLIC_SERVER
		end
		v23.Visible = v24
	end
	if v20 then
		v20 = v20.TitleName
	end
	local v25 = string.rep((v18 and "\226\136\158" or v17) .. "v", v16)
	local v26 = #v25 - 1
	local v27 = string.sub(v25, 1, v26)
	p15._visuals_folder:WaitForChild("QueueName"):WaitForChild("Players"):WaitForChild("SurfaceGui"):WaitForChild("TextLabel").Text = v27
	p15._visuals_folder:WaitForChild("QueueName"):WaitForChild("Title"):WaitForChild("SurfaceGui"):WaitForChild("Frame"):WaitForChild("TextLabel").Text = v20 or ""
	p15._visuals_folder:WaitForChild("QueueName"):WaitForChild("Title"):WaitForChild("SurfaceGui").Enabled = v20
	p15._visuals_folder:WaitForChild("QueueName"):WaitForChild("Title").Transparency = v20 and 0.4 or 1
end
function v_u_9._Update(p28) -- name: _Update
	-- upvalues: (copy) v_u_6, (copy) v_u_5, (copy) v_u_4
	for _, v29 in pairs(p28._teammate_slots) do
		v29:Destroy()
	end
	p28._teammate_slots = {}
	local v30 = p28.ClientQueuePad:Get("PlayersPerTeam")
	local v31 = p28.ClientQueuePad:Get("InfinitePlayersPerTeam")
	local v32 = p28.ClientQueuePad:GetClientFightersWaiting()
	for v33, v34 in pairs(v32) do
		local v35 = p28._team_slots[v33]
		local v36 = v31 and (#v34 or v30) or v30
		v35.Slot.Title.Text = #v34 .. "/" .. (v31 and "\226\136\158" or v30)
		local v37 = v35.Slot.Full
		local v38
		if v30 <= #v34 then
			v38 = not v31
		else
			v38 = false
		end
		v37.Visible = v38
		v35.SetCellSize(v36)
		v35.CreatePlayerSlots(v36)
		for v39, v40 in pairs(v34) do
			local v41 = v35.PlayerSlots[v39]
			if not v41 then
				continue
			end
			local v42 = v_u_6.new(v40.Player.UserId, v40:Get("Controls"), 1, false, true, v40.Player:GetAttribute("StatisticDuelsWinStreak"), v40.Player:GetAttribute("Level"))
			v42.SlotFrame.Container.Background.Visible = false
			v42.SlotFrame.Parent = v41
			local v43 = p28._teammate_slots
			table.insert(v43, v42)
		end
	end
	for v44, v45 in pairs(p28._pads) do
		local v46 = v_u_5.Teams[v44]
		local v47 = #v32[v44] > 0
		local v48 = not v47
		local v49 = v47 and v46.PadColor or Color3.fromRGB(202, 203, 209)
		local v50 = v47 and v46.PadColor2 or Color3.fromRGB(252, 250, 255)
		if v_u_4.LOBBY_VISUALS_PROFILE == "Festive" then
			v45.Outer.Anchored = v48
			v45.Inner.Anchored = v48
			v45.Glow.Transparency = v47 and 0.02 or 1
			v45.Outer.Transparency = v47 and 0.02 or 1
			v45.Inner.Transparency = v47 and 0.02 or 1
			v45.Extra.Ribbon.Transparency = v47 and 0 or 1
		elseif v_u_4.LOBBY_VISUALS_PROFILE == "Spooky" then
			v45.Outer.Anchored = v48
			v45.Inner.Anchored = v48
			v45.Glow.Transparency = v47 and 0.02 or 1
			v45.Glow.Color = v49
		else
			v45.Outer.Anchored = v48
			v45.Outer2.Anchored = v48
			v45.Outer3.Anchored = v48
			v45.Inner.Anchored = v48
			v45.Inner2.Anchored = v48
			v45.Inner3.Anchored = v48
			v45.Glow.Transparency = v47 and 0.02 or 1
			v45.Outer.Transparency = v47 and 0 or 0.75
			v45.Inner.Transparency = v47 and 0 or 0.75
			v45.Glow.Color = v49
			v45.Inner.Color = v49
			v45.Outer.Color = v49
			v45.Inner2.Color = v50
			v45.Inner3.Color = v50
			v45.Outer2.Color = v50
			v45.Outer3.Color = v50
		end
	end
	p28:_UpdateQueueName()
end
function v_u_9._SetupSurfaceGui(p51, p52) -- name: _SetupSurfaceGui
	-- upvalues: (copy) v_u_5, (copy) v_u_7, (copy) v_u_4, (copy) v_u_8, (copy) v_u_2
	local v53 = v_u_5.Teams[p52]
	local v54 = (v_u_7:FindFirstChild(v_u_4.LOBBY_VISUALS_PROFILE) and v_u_7[v_u_4.LOBBY_VISUALS_PROFILE]:FindFirstChild("QueuePadBoardGui") or v_u_7.Default.QueuePadBoardGui):Clone()
	v54.Name = v54.Name .. p51.ClientQueuePad:Get("Model").Name
	local v_u_55 = (v_u_7:FindFirstChild(v_u_4.LOBBY_VISUALS_PROFILE) and v_u_7[v_u_4.LOBBY_VISUALS_PROFILE]:FindFirstChild("QueuePadTeamSlot") or v_u_7.Default.QueuePadTeamSlot):Clone()
	v_u_55.Logo.Image = v53.Logo
	v_u_55.LayoutOrder = p52
	v_u_55.Parent = v54.MainFrame.TeamSlotContainer
	local v_u_56 = {}
	local function v61(p57) -- name: create_player_slots
		-- upvalues: (copy) v_u_56, (ref) v_u_8, (copy) v_u_55
		for _, v58 in pairs(v_u_56) do
			v58:Destroy()
		end
		table.clear(v_u_56)
		for v59 = 1, p57 do
			local v60 = v_u_8:Clone()
			v60.LayoutOrder = v59
			v60.Parent = v_u_55.Players
			v_u_56[v59] = v60
		end
	end
	v54.Adornee = p51._visuals_folder:WaitForChild("Board" .. p52)
	v54.Parent = v_u_2.LocalPlayer.PlayerGui
	p51._surface_guis[p52] = v54
	p51._team_slots[p52] = {
		["Slot"] = v_u_55,
		["PlayerSlots"] = v_u_56,
		["SetCellSize"] = function(p62) -- name: set_cell_size
			-- upvalues: (copy) v_u_55
			local v63 = math.max(p62, 1)
			local v64 = math.sqrt(v63)
			local v65 = 1 / math.ceil(v64)
			v_u_55.Players.Layout.CellSize = UDim2.new(v65, -1, v65, -1)
		end,
		["CreatePlayerSlots"] = v61
	}
end
function v_u_9._SetupPad(p66, p67) -- name: _SetupPad
	p66.ClientQueuePad:Get("Model"):WaitForChild("Important"):WaitForChild("Team" .. p67).Transparency = 1
	local v68 = p66._visuals_folder:WaitForChild("Team" .. p67)
	local v69 = v68:Clone()
	v69.Outer.CanCollide = false
	v69.Outer.CanTouch = false
	v69.Outer.CanQuery = false
	v69.Outer.Anchored = true
	local v70 = Instance.new("Attachment")
	v70.CFrame = CFrame.Angles(0, 0, 1.5707963267948966)
	v70.Parent = v69.Outer
	local v71 = Instance.new("AlignPosition")
	v71.RigidityEnabled = true
	v71.Mode = Enum.PositionAlignmentMode.OneAttachment
	v71.Position = v69.Outer.Position
	v71.Attachment0 = v70
	v71.Parent = v69.Outer
	local v72 = Instance.new("AlignOrientation")
	v72.CFrame = v70.WorldCFrame
	v72.Mode = Enum.OrientationAlignmentMode.OneAttachment
	v72.AlignType = Enum.AlignType.PrimaryAxisParallel
	v72.RigidityEnabled = true
	v72.Attachment0 = v70
	v72.Parent = v69.Outer
	local v73 = Instance.new("AngularVelocity")
	local v74 = 2 * (p67 % 2 == 0 and 1 or -1)
	v73.AngularVelocity = Vector3.new(0, v74, 0)
	v73.MaxTorque = 10000
	v73.Attachment0 = v70
	v73.Parent = v69.Outer
	v69.Inner.CanCollide = false
	v69.Inner.CanTouch = false
	v69.Inner.CanQuery = false
	v69.Inner.Anchored = true
	local v75 = Instance.new("Attachment")
	v75.CFrame = CFrame.Angles(0, 0, 1.5707963267948966)
	v75.Parent = v69.Inner
	local v76 = Instance.new("AlignPosition")
	v76.RigidityEnabled = true
	v76.Mode = Enum.PositionAlignmentMode.OneAttachment
	v76.Position = v69.Inner.Position
	v76.Attachment0 = v75
	v76.Parent = v69.Inner
	local v77 = Instance.new("AlignOrientation")
	v77.CFrame = v75.WorldCFrame
	v77.Mode = Enum.OrientationAlignmentMode.OneAttachment
	v77.AlignType = Enum.AlignType.PrimaryAxisParallel
	v77.RigidityEnabled = true
	v77.Attachment0 = v75
	v77.Parent = v69.Inner
	local v78 = Instance.new("AngularVelocity")
	local v79 = -2 * (p67 % 2 == 0 and 1 or -1)
	v78.AngularVelocity = Vector3.new(0, v79, 0)
	v78.MaxTorque = 10000
	v78.Attachment0 = v75
	v78.Parent = v69.Inner
	v69.Parent = v68.Parent
	p66._pads[p67] = v69
	v68:Destroy()
end
function v_u_9._Setup(p80) -- name: _Setup
	for v81 = 1, p80.ClientQueuePad:Get("NumTeams") do
		p80:_SetupSurfaceGui(v81)
		p80:_SetupPad(v81)
	end
	p80:_Update()
end
function v_u_9._Init(p_u_82) -- name: _Init
	p_u_82.ClientQueuePad.Activity:Connect(function()
		-- upvalues: (copy) p_u_82
		p_u_82:_Update()
	end)
	task.spawn(p_u_82._Setup, p_u_82)
end
return v_u_9