local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("TweenService")
local v3 = game:GetService("Players")
local v_u_4 = require(v1.Modules.ContractsLibrary)
local v_u_5 = require(v1.Modules.DuelLibrary)
local v_u_6 = require(v1.Modules.Utility)
local v_u_7 = require(v3.LocalPlayer.PlayerScripts.Controllers.MatchmakingController)
local v_u_8 = require(v3.LocalPlayer.PlayerScripts.Controllers.PlayerDataController)
local v_u_9 = require(v3.LocalPlayer.PlayerScripts.Controllers.ArcadeController)
local v_u_10 = require(v3.LocalPlayer.PlayerScripts.Modules.UserInterface:WaitForChild("Equipment"))
local v_u_11 = require(v3.LocalPlayer.PlayerScripts.Modules:WaitForChild("BaseContractSlot"):WaitForChild("ContractSlot"))
local v_u_12 = require(v3.LocalPlayer.PlayerScripts.Modules:WaitForChild("StatisticsList"))
local v_u_13 = require(v3.LocalPlayer.PlayerScripts.Modules:WaitForChild("LockedMapSlot"))
local v_u_14 = require(v3.LocalPlayer.PlayerScripts.Modules:WaitForChild("PromptSystem"))
local v_u_15 = require(v3.LocalPlayer.PlayerScripts.Modules:WaitForChild("ButtonEffect"))
local v_u_16 = require(v3.LocalPlayer.PlayerScripts.Modules:WaitForChild("MapSlot"))
local v_u_17 = require(v3.LocalPlayer.PlayerScripts.Modules:WaitForChild("Page"))
local v_u_18 = v3.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("ContractDivider")
v3.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("LockedMapSlot")
local v_u_19 = v3.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("PlaySourceLabel")
local v_u_20 = v3.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("EmptySlot")
local v_u_21 = setmetatable({}, v_u_17)
v_u_21.__index = v_u_21
function v_u_21._new() -- name: _new
	-- upvalues: (copy) v_u_17, (copy) v_u_21, (copy) v_u_14, (copy) v_u_12
	local v22 = v_u_17.new(script.Name)
	local v23 = v_u_21
	local v24 = setmetatable(v22, v23)
	v24.PromptsFrame = v24.PageFrame:WaitForChild("Prompts")
	v24.PageContainer = v24.PageFrame:WaitForChild("Container")
	v24.CloseButton = v24.PageContainer:WaitForChild("Close")
	v24.CloseButtonIcon = v24.CloseButton:WaitForChild("Icon")
	v24.List = v24.PageContainer:WaitForChild("List")
	v24.Container = v24.List:WaitForChild("Container")
	v24.Layout = v24.Container:WaitForChild("Layout")
	v24.SlotsFrame = v24.Container:WaitForChild("Slots")
	v24.SlotsContainer = v24.SlotsFrame:WaitForChild("Container")
	v24.SlotsLayout = v24.SlotsContainer:WaitForChild("Layout")
	v24.InspectList = v24.PageContainer:WaitForChild("Inspect")
	v24.InspectContainer = v24.InspectList:WaitForChild("Container")
	v24.InspectLayout = v24.InspectContainer:WaitForChild("Layout")
	v24.InspectDetailsFrame = v24.InspectContainer:WaitForChild("Details")
	v24.InspectDetailsFrameUIScale = v24.InspectDetailsFrame:WaitForChild("UIScale")
	v24.InspectDetailsContainer = v24.InspectDetailsFrame:WaitForChild("Container")
	v24.InspectDetailsLayout = v24.InspectDetailsContainer:WaitForChild("Layout")
	v24.InspectDetailsThumbnail = v24.InspectDetailsContainer:WaitForChild("Thumbnail")
	v24.InspectDetailsTextLabelsFrame = v24.InspectDetailsContainer:WaitForChild("TextLabels")
	v24.InspectDetailsTextLabelsContainer = v24.InspectDetailsTextLabelsFrame:WaitForChild("Container")
	v24.InspectDetailsTextLabelsLayout = v24.InspectDetailsTextLabelsContainer:WaitForChild("Layout")
	v24.InspectDetailsTitle = v24.InspectDetailsTextLabelsContainer:WaitForChild("Title")
	v24.InspectDetailsDescription = v24.InspectDetailsTextLabelsContainer:WaitForChild("Description")
	v24.InspectDetailsCreator = v24.InspectDetailsTextLabelsContainer:WaitForChild("Creator")
	v24.InspectQueuesFrame = v24.InspectContainer:WaitForChild("Queues")
	v24.InspectQueuesFrameUIScale = v24.InspectQueuesFrame:WaitForChild("UIScale")
	v24.InspectQueuesContainer = v24.InspectQueuesFrame:WaitForChild("Container")
	v24.InspectQueuesLabelsFrame = v24.InspectQueuesContainer:WaitForChild("Labels")
	v24.InspectQueuesLabelsLayout = v24.InspectQueuesLabelsFrame:WaitForChild("Layout")
	v24.InspectStatisticsFrame = v24.InspectContainer:WaitForChild("Statistics")
	v24.InspectStatisticsFrameUIScale = v24.InspectStatisticsFrame:WaitForChild("UIScale")
	v24.InspectStatisticsContainer = v24.InspectStatisticsFrame:WaitForChild("Container")
	v24.InspectStatisticsLayout = v24.InspectStatisticsContainer:WaitForChild("Layout")
	v24.InspectStatisticsTextLabelsFrame = v24.InspectStatisticsContainer:WaitForChild("TextLabels")
	v24.InspectStatisticsTextLabelsContainer = v24.InspectStatisticsTextLabelsFrame:WaitForChild("Container")
	v24.InspectStatisticsTextLabelsLayout = v24.InspectStatisticsTextLabelsContainer:WaitForChild("Layout")
	v24.PromptSystem = v_u_14.new(v24.PromptsFrame)
	v24.StatisticsList = v_u_12.new(v24.InspectStatisticsTextLabelsContainer, 1, true)
	v24._map_slots = {}
	v24._locked_map_slots = {}
	v24._empty_map_slots = {}
	v24._map_slot_ui_scales = {}
	v24._map_slot_tweens = {}
	v24._inspected_map_name = nil
	v24._inspected_map_info = nil
	v24._inspected_map_locked_slot = nil
	v24._inspected_queue_labels = {}
	v24._inspected_map_contract_slots = {}
	v24._inspect_tweens = {}
	v24:_Init()
	return v24
end
function v_u_21.CloseRequest(p25) -- name: CloseRequest
	-- upvalues: (copy) v_u_17
	if p25._inspected_map_name then
		p25:Inspect(nil)
	else
		v_u_17.CloseRequest(p25)
	end
end
function v_u_21.Inspect(p_u_26, p27) -- name: Inspect
	-- upvalues: (copy) v_u_5, (copy) v_u_13, (copy) v_u_19, (copy) v_u_7, (copy) v_u_9, (copy) v_u_10, (copy) v_u_8, (copy) v_u_4, (copy) v_u_18, (copy) v_u_11, (copy) v_u_2
	for _, v28 in pairs(p_u_26._inspect_tweens) do
		v28:Cancel()
	end
	for _, v29 in pairs(p_u_26._inspected_queue_labels) do
		v29:Destroy()
	end
	for _, v30 in pairs(p_u_26._inspected_map_contract_slots) do
		v30:Destroy()
	end
	p_u_26._inspected_map_contract_slots = {}
	p_u_26._inspect_tweens = {}
	p_u_26._inspected_queue_labels = {}
	if p_u_26._inspected_map_locked_slot then
		p_u_26._inspected_map_locked_slot:Destroy()
		p_u_26._inspected_map_locked_slot = nil
	end
	p_u_26._inspected_map_name = p27
	p_u_26._inspected_map_info = v_u_5.Maps[p_u_26._inspected_map_name]
	p_u_26.List.Visible = not p_u_26._inspected_map_name
	p_u_26.InspectList.Visible = p_u_26._inspected_map_name
	p_u_26.CloseButtonIcon.Image = p_u_26._inspected_map_name and "rbxassetid://17562685319" or "rbxassetid://17838290166"
	if p_u_26._inspected_map_name then
		local v31 = p_u_26:_IsMapUnlocked(p_u_26._inspected_map_name)
		p_u_26.InspectDetailsTitle.Text = v31 and (p_u_26._inspected_map_name or "Discover this map in a duel to learn more!") or "Discover this map in a duel to learn more!"
		p_u_26.InspectDetailsTitle.TextTransparency = v31 and 0 or 0.5
		p_u_26.InspectDetailsTitle.FontFace = v31 and Font.fromId(12187365977, Enum.FontWeight.Bold, Enum.FontStyle.Normal) or Font.fromId(12187365977, Enum.FontWeight.Medium, Enum.FontStyle.Italic)
		p_u_26.InspectDetailsTitle.Size = v31 and UDim2.new(0.95, 0, 0.066, 0) or UDim2.new(0.95, 0, 0.035, 0)
		p_u_26.InspectDetailsThumbnail.Image = v31 and (p_u_26._inspected_map_info.Image or "") or ""
		p_u_26.InspectDetailsDescription.Text = not v31 and "" or (not p_u_26._inspected_map_info.Description and "" or "\226\128\162 " .. p_u_26._inspected_map_info.Description)
		local v32 = p_u_26.InspectDetailsCreator
		local v33
		if v31 then
			if #p_u_26._inspected_map_info.Contributors > 0 then
				v33 = string.format("\226\128\162 Created by %s with contributions from %s", p_u_26:_GetUsernamesString(p_u_26._inspected_map_info.Creators), p_u_26:_GetUsernamesString(p_u_26._inspected_map_info.Contributors))
			else
				v33 = #p_u_26._inspected_map_info.Creators <= 0 and "" or string.format("\226\128\162 Created by %s", p_u_26:_GetUsernamesString(p_u_26._inspected_map_info.Creators))
			end
		else
			v33 = ""
		end
		v32.Text = v33
		p_u_26.InspectDetailsDescription.Visible = p_u_26.InspectDetailsDescription.Text ~= ""
		p_u_26.InspectDetailsCreator.Visible = p_u_26.InspectDetailsCreator.Text ~= ""
		if not v31 then
			p_u_26._inspected_map_locked_slot = v_u_13.new(p_u_26._inspected_map_name, true)
			p_u_26._inspected_map_locked_slot.Frame.Size = UDim2.new(1, 0, 1, 0)
			p_u_26._inspected_map_locked_slot.Frame.SizeConstraint = Enum.SizeConstraint.RelativeXY
			p_u_26._inspected_map_locked_slot.Frame.Position = UDim2.new(0.5, 0, 0.5, 0)
			p_u_26._inspected_map_locked_slot.Frame.AnchorPoint = Vector2.new(0.5, 0.5)
			p_u_26._inspected_map_locked_slot.Frame.Button.Difficulty.UIStroke.Enabled = false
			p_u_26._inspected_map_locked_slot:SetParent(p_u_26.InspectDetailsThumbnail)
		end
		local function v49(p34, p_u_35, p36, p37) -- name: create_playsource_label
			-- upvalues: (ref) v_u_5, (ref) v_u_19, (copy) p_u_26, (ref) v_u_7, (ref) v_u_9, (ref) v_u_10
			local v_u_38 = v_u_5.PlaySources[p_u_35]
			if v_u_38 and v_u_38.DatabaseInfo then
				local v39 = v_u_38.DatabaseInfo.CanBeStartedFromClient
				if typeof(v39) == "function" and not v_u_38.DatabaseInfo.CanBeStartedFromClient() then
					return
				end
			end
			local v_u_40 = p36 or (v_u_38 and v_u_38.AssignedColor or Color3.fromRGB(0, 0, 0))
			local v_u_41 = p37 or v_u_40:Lerp(Color3.fromRGB(0, 0, 0), 0.5)
			local v_u_42 = v_u_19:Clone()
			v_u_42.LayoutOrder = p34
			local v43 = v_u_42.Container.Title
			local v44
			if v_u_38 then
				v44 = v_u_38.DisplayName or p_u_35
			else
				v44 = p_u_35
			end
			v43.Text = v44
			v_u_42.Play.ImageColor3 = v_u_40
			v_u_42.Parent = p_u_26.InspectQueuesLabelsFrame
			local v45 = p_u_26._inspected_queue_labels
			table.insert(v45, v_u_42)
			v_u_42.Container.Title:GetPropertyChangedSignal("TextBounds"):Connect(function() -- name: update
				-- upvalues: (copy) v_u_42
				v_u_42.Size = UDim2.new(0.05, v_u_42.Container.Title.TextBounds.X, 0.05, 0)
			end)
			v_u_42.Size = UDim2.new(0.05, v_u_42.Container.Title.TextBounds.X, 0.05, 0)
			local function v46() -- name: hover
				-- upvalues: (copy) v_u_42, (copy) v_u_40, (copy) v_u_41
				v_u_42.Play.Visible = true
				v_u_42.Container.Title.Visible = false
				v_u_42.Container.Title.TextColor3 = v_u_40
				v_u_42.Background.ImageColor3 = v_u_41
			end
			local function v47() -- name: unhover
				-- upvalues: (copy) v_u_42, (copy) v_u_41, (copy) v_u_40
				v_u_42.Play.Visible = false
				v_u_42.Container.Title.Visible = true
				v_u_42.Container.Title.TextColor3 = v_u_41
				v_u_42.Background.ImageColor3 = v_u_40
			end
			v_u_42.Play.Visible = false
			v_u_42.Container.Title.Visible = true
			v_u_42.Container.Title.TextColor3 = v_u_41
			v_u_42.Background.ImageColor3 = v_u_40
			if v_u_38 then
				v_u_42.MouseButton1Click:Connect(function()
					-- upvalues: (copy) v_u_38, (ref) v_u_7, (copy) p_u_35, (ref) v_u_9, (ref) p_u_26, (ref) v_u_10
					local v48
					if v_u_38.Type == "MatchmakingQueue" then
						v48 = v_u_7:QueueInto(p_u_35)
					elseif v_u_38.Type == "ArcadeMode" then
						v48 = v_u_9:ToArcadeServer(p_u_35)
					else
						v48 = assert(false, "???")
					end
					if v48 == "Success" then
						p_u_26.Closed:Fire()
						v_u_10:Close()
					else
						p_u_26.PromptSystem:Open("ErrorMessage", "Whoops!", v48 or "Server failed to respond, please try again")
					end
				end)
				v_u_42.MouseEnter:Connect(v46)
				v_u_42.SelectionGained:Connect(v46)
				v_u_42.MouseLeave:Connect(v47)
				v_u_42.SelectionLost:Connect(v47)
			end
		end
		if p_u_26._inspected_map_info.IsHidden then
			v49(1, "N/A", Color3.fromRGB(0, 0, 0), Color3.fromRGB(255, 255, 255))
		elseif #p_u_26._inspected_map_info.PlaySources == 0 then
			v49(1, "Private Servers", Color3.fromRGB(0, 0, 0), Color3.fromRGB(255, 255, 255))
		else
			for v50, v51 in pairs(p_u_26._inspected_map_info.PlaySources) do
				v49(v50, v51)
			end
		end
		p_u_26.InspectStatisticsFrame.Visible = v_u_8:GetMapStatistic(p27, "StatisticPlaytime") > 0
		p_u_26.StatisticsList:Generate(false, "MapStatistics", p27)
		if v31 then
			local v52 = 50
			for v53, v54 in pairs(v_u_4:GetMapContracts(p_u_26._inspected_map_name)) do
				if v53 > 1 then
					local v55 = v_u_18:Clone()
					v55.LayoutOrder = v52
					v55.Parent = p_u_26.InspectContainer
					local v56 = p_u_26._inspected_map_contract_slots
					table.insert(v56, v55)
					v52 = v52 + 1
				end
				local v57 = v_u_11.new("MapStatistics", v54)
				v57.Frame.LayoutOrder = v52
				v57.Frame.Parent = p_u_26.InspectContainer
				local v58 = p_u_26._inspected_map_contract_slots
				table.insert(v58, v57)
				v52 = v52 + 1
			end
		end
		p_u_26.InspectDetailsFrameUIScale.Scale = 0.5
		p_u_26.InspectQueuesFrameUIScale.Scale = 0.5
		p_u_26.InspectStatisticsFrameUIScale.Scale = 0.5
		local v59 = v_u_2:Create(p_u_26.InspectDetailsFrameUIScale, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
			["Scale"] = 1
		})
		v59:Play()
		local v60 = p_u_26._inspect_tweens
		table.insert(v60, v59)
		local v61 = v_u_2:Create(p_u_26.InspectQueuesFrameUIScale, TweenInfo.new(0.375, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
			["Scale"] = 1
		})
		v61:Play()
		local v62 = p_u_26._inspect_tweens
		table.insert(v62, v61)
		local v63 = v_u_2:Create(p_u_26.InspectStatisticsFrameUIScale, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
			["Scale"] = 1
		})
		v63:Play()
		local v64 = p_u_26._inspect_tweens
		table.insert(v64, v63)
	else
		p_u_26:_PlayMapSlotsTween()
	end
end
function v_u_21.Open(p65, ...) -- name: Open
	-- upvalues: (copy) v_u_17
	v_u_17.Open(p65, ...)
	p65:Inspect(nil)
	p65:_UpdateMapSlots()
	p65:_PlayMapSlotsTween()
end
function v_u_21._IsMapUnlocked(_, p66) -- name: _IsMapUnlocked
	-- upvalues: (copy) v_u_5, (copy) v_u_8
	return v_u_5.Maps[p66] and #v_u_5.Maps[p66].PlaySources == 0 and true or v_u_8:GetMapStatistic(p66, "StatisticPlaytime") > 0
end
function v_u_21._PlayMapSlotsTween(p_u_67) -- name: _PlayMapSlotsTween
	-- upvalues: (copy) v_u_2
	for _, v68 in pairs(p_u_67._map_slot_tweens) do
		v68:Cancel()
	end
	p_u_67._map_slot_tweens = {}
	local function v73(p69, p70) -- name: play
		-- upvalues: (ref) v_u_2, (copy) p_u_67
		p70.Scale = 0.25
		local v71 = v_u_2:Create(p70, TweenInfo.new(math.sqrt(p69) * 0.1 + 0.1, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
			["Scale"] = 1
		})
		v71:Play()
		local v72 = p_u_67._map_slot_tweens
		table.insert(v72, v71)
	end
	for v74, v75 in pairs(p_u_67._map_slots) do
		v73(v74, v75[2].Frame.UIScale)
	end
	for v76, v77 in pairs(p_u_67._locked_map_slots) do
		v73(v76, v77[2].Frame.UIScale)
	end
	for v78, v79 in pairs(p_u_67._empty_map_slots) do
		v73(#p_u_67._map_slots + v78, v79.UIScale)
	end
end
function v_u_21._GetUsernamesString(_, p80) -- name: _GetUsernamesString
	local v81 = ""
	for v82, v83 in pairs(p80) do
		v81 = (v81 .. (v82 == 1 and "" or (v82 == #p80 and ", & " or ", "))) .. "@" .. v83
	end
	return v81
end
function v_u_21._UpdateMapSlots(p84) -- name: _UpdateMapSlots
	if p84:IsOpen() then
		for _, v85 in pairs(p84._map_slots) do
			v85[2].Frame.Visible = p84:_IsMapUnlocked(v85[1])
		end
		for _, v86 in pairs(p84._locked_map_slots) do
			v86[2].Frame.Visible = not p84:_IsMapUnlocked(v86[1])
		end
	end
end
function v_u_21._UpdateList(p87) -- name: _UpdateList
	p87.CloseButton.Position = UDim2.new(0.975, 0, 0.0225, p87.PageFrame.AbsoluteSize.Y * 0.125)
	p87.List.CanvasSize = UDim2.new(0, 0, 0, p87.Layout.AbsoluteContentSize.Y)
	p87.List.Active = p87.Layout.AbsoluteContentSize.Y >= p87.List.AbsoluteSize.Y
	p87.List.Position = UDim2.new(0.5, 9, 0, p87.PageFrame.AbsoluteSize.Y * 0.125)
	p87.List.Size = UDim2.new(0.85, 0, 0, p87.PageFrame.AbsoluteSize.Y * 0.75)
	p87.InspectList.Position = p87.List.Position
	p87.InspectList.Size = p87.List.Size
end
function v_u_21._Setup(p_u_88) -- name: _Setup
	-- upvalues: (copy) v_u_6, (copy) v_u_5, (copy) v_u_16, (copy) v_u_13, (copy) v_u_20
	local v89 = v_u_6:CloneTable(v_u_5:GetReleasedMapOrder())
	table.sort(v89, function(p90, p91)
		-- upvalues: (ref) v_u_5
		return v_u_5:SortMaps(p90, p91)
	end)
	local function v96(p92, p_u_93) -- name: create_map_slot
		-- upvalues: (ref) v_u_16, (copy) p_u_88
		local v94 = v_u_16.new(p_u_93)
		v94.Frame.LayoutOrder = p92
		v94:SetParent(p_u_88.SlotsContainer)
		local v95 = p_u_88._map_slots
		table.insert(v95, { p_u_93, v94 })
		v94.Frame.Button.MouseButton1Click:Connect(function()
			-- upvalues: (ref) p_u_88, (copy) p_u_93
			p_u_88:Inspect(p_u_93)
		end)
		Instance.new("UIScale").Parent = v94.Frame
	end
	local function v101(p97, p_u_98) -- name: create_locked_map_slot
		-- upvalues: (ref) v_u_13, (copy) p_u_88
		local v99 = v_u_13.new(p_u_98)
		v99.Frame.LayoutOrder = p97
		v99:SetParent(p_u_88.SlotsContainer)
		local v100 = p_u_88._locked_map_slots
		table.insert(v100, { p_u_98, v99 })
		v99.Frame.Button.MouseButton1Click:Connect(function()
			-- upvalues: (ref) p_u_88, (copy) p_u_98
			p_u_88:Inspect(p_u_98)
		end)
		Instance.new("UIScale").Parent = v99.Frame
	end
	for v102, v103 in pairs(v89) do
		v96(v102, v103)
		v101(v102, v103)
	end
	local v104 = 9 - #v89
	for _ = 1, math.max(0, v104) + (3 - (#v89 <= 9 and 0 or (#v89 - 1) % 3 + 1)) do
		local v105 = v_u_20:Clone()
		v105.LayoutOrder = 9999999
		v105.Parent = p_u_88.SlotsContainer
		local v106 = p_u_88._empty_map_slots
		table.insert(v106, v105)
		Instance.new("UIScale").Parent = v105
	end
end
function v_u_21._Init(p_u_107) -- name: _Init
	-- upvalues: (copy) v_u_8, (copy) v_u_15
	p_u_107.CloseButton.MouseButton1Click:Connect(function()
		-- upvalues: (copy) p_u_107
		p_u_107:CloseRequest()
	end)
	p_u_107.Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		-- upvalues: (copy) p_u_107
		p_u_107:_UpdateList()
	end)
	p_u_107.SlotsLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		-- upvalues: (copy) p_u_107
		p_u_107.SlotsFrame.Size = UDim2.new(1, 0, 0, p_u_107.SlotsLayout.AbsoluteContentSize.Y)
	end)
	p_u_107.InspectLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		-- upvalues: (copy) p_u_107
		p_u_107.InspectList.CanvasSize = UDim2.new(0, 0, 0, p_u_107.InspectLayout.AbsoluteContentSize.Y)
		p_u_107.InspectList.Active = p_u_107.InspectLayout.AbsoluteContentSize.Y >= p_u_107.InspectList.AbsoluteSize.Y
	end)
	p_u_107.InspectDetailsTextLabelsLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		-- upvalues: (copy) p_u_107
		p_u_107.InspectDetailsTextLabelsFrame.Size = UDim2.new(1, 0, 0, p_u_107.InspectDetailsTextLabelsLayout.AbsoluteContentSize.Y)
	end)
	p_u_107.InspectDetailsLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		-- upvalues: (copy) p_u_107
		p_u_107.InspectDetailsFrame.Size = UDim2.new(1, 0, 0, p_u_107.InspectDetailsLayout.AbsoluteContentSize.Y)
	end)
	p_u_107.InspectQueuesLabelsLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		-- upvalues: (copy) p_u_107
		p_u_107.InspectQueuesFrame.Size = UDim2.new(1, 0, 0.088, p_u_107.InspectQueuesLabelsLayout.AbsoluteContentSize.Y)
	end)
	p_u_107.InspectStatisticsLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		-- upvalues: (copy) p_u_107
		p_u_107.InspectStatisticsFrame.Size = UDim2.new(1, 0, 0, p_u_107.InspectStatisticsLayout.AbsoluteContentSize.Y)
	end)
	p_u_107.InspectStatisticsTextLabelsLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		-- upvalues: (copy) p_u_107
		p_u_107.InspectStatisticsTextLabelsFrame.Size = UDim2.new(1, 0, 0, p_u_107.InspectStatisticsTextLabelsLayout.AbsoluteContentSize.Y)
	end)
	p_u_107.PageFrame:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
		-- upvalues: (copy) p_u_107
		p_u_107:_UpdateList()
	end)
	v_u_8.StatisticsUpdated:Connect(function()
		-- upvalues: (copy) p_u_107
		p_u_107:_UpdateMapSlots()
	end)
	p_u_107:_Setup()
	p_u_107:_UpdateList()
	p_u_107:_UpdateMapSlots()
	p_u_107:Inspect(nil)
	v_u_15:Add(p_u_107.CloseButton)
end
return v_u_21._new()