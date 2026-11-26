local v_u_1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("TweenService")
local v_u_3 = game:GetService("RunService")
local v4 = game:GetService("Players")
local v_u_5 = require(v_u_1.Modules.CONSTANTS)
require(v_u_1.Modules.CosmeticLibrary)
local v_u_6 = require(v_u_1.Modules.BetterDebris)
local v_u_7 = require(v_u_1.Modules.ItemLibrary)
local v_u_8 = require(v_u_1.Modules.Utility)
local v_u_9 = require(v_u_1.Modules.Signal)
local v_u_10 = require(v4.LocalPlayer.PlayerScripts.Controllers:WaitForChild("PlayerDataController"))
local v_u_11 = require(v4.LocalPlayer.PlayerScripts.Modules:WaitForChild("WeaponStatusHandler"))
local v_u_12 = require(v4.LocalPlayer.PlayerScripts.Modules:WaitForChild("ButtonEffect"))
local v_u_13 = require(v4.LocalPlayer.PlayerScripts.Modules:WaitForChild("RewardSlot"))
local v_u_14 = require(v4.LocalPlayer.PlayerScripts.Modules:WaitForChild("UILibrary"))
local v_u_15 = require(v4.LocalPlayer.PlayerScripts.Modules:WaitForChild("Page"))
local v_u_16 = v4.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("PatchNoteBalancingOverviewSlot")
local v_u_17 = v4.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("PatchNoteContentSummarySlot")
local v_u_18 = v4.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("PatchNoteBalanceChangeSlot")
local v_u_19 = v4.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("PatchNoteViewMoreButton")
local v_u_20 = v4.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("PatchNoteThumbnailSlot")
local v_u_21 = v4.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("ViewPatchNotesSlot")
local v_u_22 = v4.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("PatchNoteChangeSlot")
local v_u_23 = v4.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("PatchNotesSlot")
local v_u_24 = v4.LocalPlayer.PlayerScripts.Modules:WaitForChild("PatchNotes")
local v_u_25 = {
	"Release",
	"FreezeRay",
	"Matchmaking",
	"Cosmetics",
	"NewMaps",
	"Gamemodes",
	"2024SpookyEvent",
	"Weapons",
	"2024FestiveEvent",
	"BridgeMap",
	"Ranked",
	"TheHunt",
	"Cosmetics2",
	"Gamemodes2",
	"Emotes",
	"Season1",
	"2025SpookyEvent",
	"2025FestiveEvent",
	"LaborOfLove",
	"Lucky",
	"Season3",
	"2026SummerEvent",
	"WildcatRelease",
	"RIA26",
	"2026SpookyEvent",
	"Season4"
}
local v_u_26 = {
	{ Color3.fromRGB(100, 255, 50), "rbxassetid://72868042131575" },
	{ Color3.fromRGB(255, 50, 50), "rbxassetid://129990470163489" },
	{ Color3.fromRGB(166, 166, 166), "rbxassetid://125168324521437" }
}
local v_u_27 = {
	["Title"] = {
		["Weight"] = 600,
		["Transparency"] = 0,
		["Size"] = 1.5,
		["Spaces"] = 3,
		["Prefix"] = "",
		["NewLine"] = 2
	},
	["Header"] = {
		["Weight"] = 500,
		["Transparency"] = 0.125,
		["Size"] = 0.875,
		["Spaces"] = 9,
		["Prefix"] = "",
		["NewLine"] = 0.5
	},
	["Description"] = {
		["Weight"] = 400,
		["Transparency"] = 0.25,
		["Size"] = 0.75,
		["Spaces"] = 12,
		["Prefix"] = "\226\128\162 ",
		["NewLine"] = nil
	},
	["Description2"] = {
		["Weight"] = 400,
		["Transparency"] = 0.5,
		["Size"] = 0.75,
		["Spaces"] = 18,
		["Prefix"] = "\226\150\170  ",
		["NewLine"] = nil
	}
}
local v_u_28 = setmetatable({}, v_u_15)
v_u_28.__index = v_u_28
function v_u_28._new() -- name: _new
	-- upvalues: (copy) v_u_15, (copy) v_u_28
	local v29 = v_u_15.new(script.Name)
	local v30 = v_u_28
	local v31 = setmetatable(v29, v30)
	v31.PageContainer = v31.PageFrame:WaitForChild("Container")
	v31.CloseButton = v31.PageContainer:WaitForChild("Close")
	v31.List = v31.PageContainer:WaitForChild("List")
	v31.Container = v31.List:WaitForChild("Container")
	v31.Layout = v31.Container:WaitForChild("Layout")
	v31.ViewMoreButton = v31.PageContainer:WaitForChild("ViewMore")
	v31.ViewMoreList = v31.PageContainer:WaitForChild("ViewMoreList")
	v31.ViewMoreContainer = v31.ViewMoreList:WaitForChild("Container")
	v31.ViewMoreLayout = v31.ViewMoreContainer:WaitForChild("Layout")
	v31._current_patch_notes_slot = nil
	v31._elements = {}
	v31:_Init()
	return v31
end
function v_u_28.SetViewMoreListVisible(p32, p33) -- name: SetViewMoreListVisible
	p32.ViewMoreList.Visible = p33
	p32.ViewMoreList.CanvasPosition = Vector2.zero
	p32.List.Visible = not p33
	p32.List.CanvasPosition = Vector2.zero
	p32.ViewMoreButton.Visible = not p33
end
function v_u_28.ScrollTo(p34, p35, p36) -- name: ScrollTo
	-- upvalues: (copy) v_u_2, (copy) v_u_6, (copy) v_u_8
	if p35 then
		v_u_2:Create(p34.List, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
			["CanvasPosition"] = Vector2.new(0, p35.AbsolutePosition.Y - p34.Container.AbsolutePosition.Y)
		}):Play()
		local v_u_37 = Instance.new("Frame")
		v_u_37.BackgroundColor3 = p36 or Color3.fromRGB(255, 255, 255)
		v_u_37.AnchorPoint = Vector2.new(0.5, 0.5)
		v_u_37.Position = UDim2.new(0.5, 0, 0.5, 0)
		v_u_37.Size = UDim2.new(1, 0, 20, 0)
		v_u_37.Parent = p35
		v_u_37:TweenSize(UDim2.new(1, 0, 1, 0), "Out", "Quint", 0.5, true)
		v_u_6:AddItem(v_u_37, 3)
		local v38 = Instance.new("UIGradient")
		v38.Transparency = NumberSequence.new({
			NumberSequenceKeypoint.new(0, 1),
			NumberSequenceKeypoint.new(0.125, 0),
			NumberSequenceKeypoint.new(0.875, 0),
			NumberSequenceKeypoint.new(1, 1)
		})
		v38.Parent = v_u_37
		task.spawn(v_u_8.RenderstepForLoop, v_u_8, 0, 100, 1, function(p39)
			-- upvalues: (copy) v_u_37
			v_u_37.BackgroundTransparency = 0 + 1 * (p39 / 100) ^ 4
		end)
	end
end
function v_u_28.Open(p_u_40, ...) -- name: Open
	-- upvalues: (copy) v_u_15, (copy) v_u_25, (copy) v_u_3
	v_u_15.Open(p_u_40, ...)
	p_u_40:_UpdateSize()
	p_u_40:SetViewMoreListVisible(false)
	task.defer(p_u_40._Generate, p_u_40, v_u_25[#v_u_25])
	local v_u_41 = p_u_40._is_open_hash
	task.delay(0.5, function()
		-- upvalues: (copy) p_u_40, (copy) v_u_41, (ref) v_u_3
		for _, v_u_42 in pairs(p_u_40._elements) do
			if v_u_41 ~= p_u_40._is_open_hash then
				return
			end
			pcall(function()
				-- upvalues: (copy) v_u_42
				v_u_42[1].Parent = v_u_42[2]
			end)
			v_u_3.RenderStepped:Wait()
		end
	end)
end
function v_u_28.Close(p43, ...) -- name: Close
	-- upvalues: (copy) v_u_15
	for _, v44 in pairs(p43._elements) do
		v44[1].Parent = nil
	end
	v_u_15.Close(p43, ...)
end
function v_u_28._Generate(p_u_45, p46) -- name: _Generate
	-- upvalues: (copy) v_u_24, (copy) v_u_23, (copy) v_u_1, (copy) v_u_12, (copy) v_u_25, (copy) v_u_10, (copy) v_u_9, (copy) v_u_19, (copy) v_u_3, (copy) v_u_16, (copy) v_u_26, (copy) v_u_7, (copy) v_u_18, (copy) v_u_17, (copy) v_u_13, (copy) v_u_20, (copy) v_u_27, (copy) v_u_22, (copy) v_u_11
	if p_u_45._current_patch_notes_slot then
		p_u_45._current_patch_notes_slot:Destroy()
		p_u_45._current_patch_notes_slot = nil
	end
	p_u_45._elements = {}
	local v_u_47 = require(v_u_24:WaitForChild(p46))
	local v_u_48 = v_u_23:Clone()
	v_u_48.LayoutOrder = 1
	v_u_48.Container.Thumbnail.Image = v_u_47.Image or ""
	v_u_48.Container.Thumbnail.Visible = v_u_48.Container.Thumbnail.Image ~= ""
	v_u_48.Container.Details.Title.Text = v_u_47.Title
	v_u_48.Container.Details.Changes.Date.Text = v_u_47.Date
	v_u_48.Parent = p_u_45.Container
	p_u_45._current_patch_notes_slot = v_u_48
	v_u_48.Container.Details.Changes.CodeButton.Button.MouseButton1Click:Connect(function()
		-- upvalues: (copy) v_u_48, (ref) v_u_1, (copy) v_u_47
		v_u_48.Container.Details.Changes.CodeButton.Visible = false
		v_u_1.Remotes.Data.RedeemCode:InvokeServer(string.lower(v_u_47.Code))
	end)
	v_u_48.Container.Details.Changes.Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		-- upvalues: (copy) v_u_48
		v_u_48.Size = UDim2.new(1, 0, 0, v_u_48.Container.Details.Changes.AbsolutePosition.Y - v_u_48.AbsolutePosition.Y + v_u_48.Container.Details.Changes.Layout.AbsoluteContentSize.Y)
	end)
	v_u_12:Add(v_u_48.Container.Details.Changes.CodeButton.Button)
	if v_u_47.Code and p46 == v_u_25[#v_u_25] then
		local v_u_49 = v_u_48.Container.Details.Changes.CodeButton
		task.delay(20, function()
			-- upvalues: (copy) v_u_49, (ref) v_u_10, (copy) v_u_47
			v_u_49.Visible = not v_u_10:Get("RedeemedCodes")[string.lower(v_u_47.Code)]
		end)
	end
	local v_u_50 = v_u_9.new()
	local v_u_51 = true
	local v_u_52 = nil
	local v_u_53 = 0
	local v_u_54 = {}
	local v_u_55 = false
	local v_u_56 = {}
	local v_u_57 = 0
	local function v_u_68(p58, p59, p60) -- name: add_to_collapsed_list
		-- upvalues: (ref) v_u_54, (ref) v_u_53, (ref) v_u_19, (ref) v_u_51, (copy) v_u_50, (ref) v_u_12, (ref) v_u_3
		if v_u_54 then
			p58.Visible = false
			local v61 = v_u_54
			table.insert(v61, p58)
			if p59 then
				p59.Visible = false
				local v62 = v_u_54
				table.insert(v62, p59)
				return
			end
		else
			if v_u_53 == 10 then
				local v_u_63 = Instance.new("UIGradient")
				v_u_63.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.5), NumberSequenceKeypoint.new(1, 1) })
				v_u_63.Rotation = 90
				v_u_63.Parent = p58
				local v_u_64 = {}
				v_u_54 = v_u_64
				local v_u_65 = v_u_19:Clone()
				v_u_65.Parent = p58
				local function v67() -- name: expand
					-- upvalues: (ref) v_u_51, (copy) v_u_64, (copy) v_u_63, (copy) v_u_65
					if not v_u_51 then
						for _, v66 in pairs(v_u_64) do
							v66.Visible = true
						end
						v_u_63:Destroy()
						v_u_65:Destroy()
					end
				end
				v_u_65.MouseButton1Click:Connect(v67)
				v_u_50:Connect(v67)
				v_u_12:Add(v_u_65)
				v_u_3.RenderStepped:Wait()
				return
			end
			v_u_53 = v_u_53 + (p60 or 1)
		end
	end
	local function v80(p69) -- name: generate_balancing_overview
		-- upvalues: (ref) v_u_55, (ref) v_u_16, (ref) v_u_57, (ref) v_u_26, (ref) v_u_7, (ref) v_u_18, (copy) v_u_50, (copy) p_u_45, (copy) v_u_56, (ref) v_u_12, (copy) v_u_48
		v_u_55 = true
		local v_u_70 = v_u_16:Clone()
		v_u_57 = v_u_57 + 1
		v_u_70.LayoutOrder = v_u_57
		for v71 = 1, 3 do
			local v_u_72 = v_u_26[v71]
			local v73 = p69[v71 + 1] or {}
			for _, v_u_74 in pairs(v73) do
				local v75 = v_u_7.ViewModels[v_u_74]
				assert(v75, v_u_74)
				local v76 = v_u_18:Clone()
				v76.Button.Label.Icon.Image = v_u_72[2]
				v76.Button.Label.Icon.ImageColor3 = v_u_72[1]
				v76.Button.Background.BackgroundColor3 = v_u_72[1]
				v76.Button.Background.UIStroke.Color = v_u_72[1]
				v76.Button.Graphic.Picture.Image = v_u_7.ViewModels[v_u_74].ImageCentered or v_u_7.Items[v_u_74].Image
				v76.Parent = v_u_70.Slots
				v76.Button.MouseButton1Click:Connect(function()
					-- upvalues: (ref) v_u_50, (ref) p_u_45, (ref) v_u_56, (copy) v_u_74, (copy) v_u_72
					v_u_50:Fire()
					task.defer(p_u_45.ScrollTo, p_u_45, v_u_56[v_u_74], v_u_72[1])
				end)
				v_u_12:Add(v76.Button)
			end
		end
		v_u_70.Parent = p_u_45._is_open and v_u_48.Container.Details.Changes or nil
		local v77 = p_u_45._elements
		local v78 = { v_u_70, v_u_48.Container.Details.Changes }
		table.insert(v77, v78)
		local v_u_79 = v_u_70.Slots.Layout
		v_u_79:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() -- name: update
			-- upvalues: (copy) v_u_70, (copy) v_u_79
			v_u_70.Size = UDim2.new(1, 0, 0, v_u_79.AbsoluteContentSize.Y)
		end)
		v_u_70.Size = UDim2.new(1, 0, 0, v_u_79.AbsoluteContentSize.Y)
	end
	local function v93(p81) -- name: generate_content_summary
		-- upvalues: (ref) v_u_17, (ref) v_u_57, (ref) v_u_13, (ref) v_u_55, (ref) v_u_7, (copy) v_u_56, (copy) v_u_68, (copy) p_u_45, (copy) v_u_48
		local v82 = p81[3]
		local v83 = #v82 / 7
		for v84 = 1, math.ceil(v83) do
			local v_u_85 = v_u_17:Clone()
			v_u_57 = v_u_57 + 1
			v_u_85.LayoutOrder = v_u_57
			v_u_85.Slots.Layout.HorizontalAlignment = Enum.HorizontalAlignment[p81[2] or "Center"]
			for v86 = (v84 - 1) * 7 + 1, v84 * 7 do
				local v87 = v82[v86]
				if not v87 then
					continue
				end
				local v88 = typeof(v87) ~= "table" and {
					["Name"] = v87
				} or v87
				local v89 = v_u_13.new(v88)
				v89.Frame.LayoutOrder = v86
				v89:SetParent(v_u_85.Slots)
				if not (v_u_55 and v_u_7.Items[v88.Name]) then
					continue
				end
				v_u_56[v88.Name] = v_u_85
			end
			v_u_68(v_u_85, nil, 3)
			v_u_85.Parent = p_u_45._is_open and v_u_48.Container.Details.Changes or nil
			local v90 = p_u_45._elements
			local v91 = { v_u_85, v_u_48.Container.Details.Changes }
			table.insert(v90, v91)
			local v_u_92 = v_u_85.Slots.Layout
			v_u_92:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() -- name: update
				-- upvalues: (copy) v_u_85, (copy) v_u_92
				v_u_85.Size = UDim2.new(1, 0, 0, v_u_92.AbsoluteContentSize.Y)
			end)
			v_u_85.Size = UDim2.new(1, 0, 0, v_u_92.AbsoluteContentSize.Y)
		end
	end
	local function v109(p94) -- name: generate_text
		-- upvalues: (ref) v_u_27, (ref) v_u_52, (ref) v_u_53, (ref) v_u_54, (ref) v_u_22, (ref) v_u_57, (copy) p_u_45, (copy) v_u_48, (ref) v_u_55, (ref) v_u_7, (ref) v_u_11, (copy) v_u_56, (copy) v_u_68
		local v95 = p94[1]
		local v96 = p94[2]
		local v97 = v_u_27[v95]
		local v98 = v97 ~= nil
		assert(v98, v95, p94)
		if v95 == "Title" then
			v_u_52 = p94
			v_u_53 = 0
			v_u_54 = nil
		end
		local v99
		if v97.NewLine then
			v99 = v_u_22:Clone()
			v_u_57 = v_u_57 + 1
			v99.LayoutOrder = v_u_57
			v99.Text = ""
			v99.Size = UDim2.new(v99.Size.X.Scale, 0, v99.Size.Y.Scale * v97.NewLine, 0)
			v99.AutoLocalize = false
			v99.Parent = p_u_45._is_open and v_u_48.Container.Details.Changes or nil
			local v100 = p_u_45._elements
			local v101 = { v99, v_u_48.Container.Details.Changes }
			table.insert(v100, v101)
		else
			v99 = nil
		end
		local v102 = v_u_22:Clone()
		v_u_57 = v_u_57 + 1
		v102.LayoutOrder = v_u_57
		v102.Text = string.format("%s%s<font weight=\"%s\">%s</font>", string.rep(" ", v97.Spaces), v97.Prefix, v97.Weight, v96)
		v102.TextTransparency = v97.Transparency
		local v103 = UDim2.new
		local v104 = v102.Size.X.Scale
		local v105 = v102.Size.Y.Scale
		local v106 = #v96 / 80
		v102.Size = v103(v104, 0, v105 * math.ceil(v106) * v97.Size, 0)
		v102.AutoLocalize = false
		v102.Parent = p_u_45._is_open and v_u_48.Container.Details.Changes or nil
		local v107 = p_u_45._elements
		local v108 = { v102, v_u_48.Container.Details.Changes }
		table.insert(v107, v108)
		if v_u_55 and (v95 == "Header" and v_u_7.Items[v96]) then
			v_u_11:ApplyItemStatusToText(v102, v_u_7.Items[v96].Status)
			v_u_56[v96] = v102
		end
		v_u_68(v102, v99)
	end
	local v110 = v_u_57
	for _, v111 in pairs(v_u_47.Changes) do
		local v112 = v111[1]
		if typeof(v112) == "function" then
			for _, v113 in pairs(v111[1](select(2, table.unpack(v111)))) do
				local v114 = v113[1]
				if v114 == "Thumbnail" then
					local v115 = v113[2]
					local v116 = v113[3]
					local v117 = v_u_20:Clone()
					v_u_57 = v110 + 1
					v117.LayoutOrder = v_u_57
					v117.Thumbnail.Image = v115
					v117.Title.Text = v116
					v117.Title.AutoLocalize = false
					v_u_68(v117)
					local v118
					if p_u_45._is_open then
						v118 = v_u_48.Container.Details.Changes or nil
					else
						v118 = nil
					end
					v117.Parent = v118
					local v119 = p_u_45._elements
					local v120 = { v117, v_u_48.Container.Details.Changes }
					table.insert(v119, v120)
					v110 = v_u_57
				elseif v114 == "BalancingOverview" then
					v80(v113)
				elseif v114 == "ContentSummary" then
					v93(v113)
				else
					v109(v113)
				end
			end
		else
			local v121 = v111[1]
			if v121 == "Thumbnail" then
				local v122 = v111[2]
				local v123 = v111[3]
				local v124 = v_u_20:Clone()
				v_u_57 = v110 + 1
				v124.LayoutOrder = v_u_57
				v124.Thumbnail.Image = v122
				v124.Title.Text = v123
				v124.Title.AutoLocalize = false
				v_u_68(v124)
				local v125
				if p_u_45._is_open then
					v125 = v_u_48.Container.Details.Changes or nil
				else
					v125 = nil
				end
				v124.Parent = v125
				local v126 = p_u_45._elements
				local v127 = { v124, v_u_48.Container.Details.Changes }
				table.insert(v126, v127)
				v110 = v_u_57
			elseif v121 == "BalancingOverview" then
				v80(v111)
			elseif v121 == "ContentSummary" then
				v93(v111)
			else
				v109(v111)
			end
		end
	end
	v_u_51 = false
	p_u_45.ViewMoreButton.Visible = true
end
function v_u_28._UpdateList(p128) -- name: _UpdateList
	p128.CloseButton.Position = UDim2.new(0.975, 0, 0.0225, p128.PageFrame.AbsoluteSize.Y * 0.125)
	p128.ViewMoreButton.Position = p128.CloseButton.Position + UDim2.new(0, 0, 0.05, 0)
	p128.List.Position = UDim2.new(0.5, 9, 0, p128.PageFrame.AbsoluteSize.Y * 0.125)
	p128.List.Size = UDim2.new(0.85, 0, 0, p128.PageFrame.AbsoluteSize.Y * 0.75)
	p128.List.CanvasSize = UDim2.new(0, 0, 0, p128.Layout.AbsoluteContentSize.Y)
	p128.ViewMoreList.Position = UDim2.new(0.5, 9, 0, p128.PageFrame.AbsoluteSize.Y * 0.125)
	p128.ViewMoreList.Size = UDim2.new(0.85, 0, 0, p128.PageFrame.AbsoluteSize.Y * 0.75)
	p128.ViewMoreList.CanvasSize = UDim2.new(0, 0, 0, p128.ViewMoreLayout.AbsoluteContentSize.Y)
end
function v_u_28._UpdateSize(p129) -- name: _UpdateSize
	-- upvalues: (copy) v_u_14
	local v130 = p129.PageContainer
	local v131 = UDim2.new
	local v132 = v_u_14.MainGui.AbsoluteSize.X * 0.875
	v130.Size = v131(0, math.min(1000, v132), 1, 0)
end
function v_u_28._SetupViewMoreSlots(p_u_133) -- name: _SetupViewMoreSlots
	-- upvalues: (copy) v_u_25, (copy) v_u_24, (copy) v_u_21, (copy) v_u_8, (copy) v_u_12
	for v134, v_u_135 in pairs(v_u_25) do
		local v136 = require(v_u_24:WaitForChild(v_u_135))
		local v_u_137 = v_u_21:Clone()
		v_u_137.Button.Title.Text = v136.Title
		v_u_137.Button.Subtitle.Text = v136.Subtitle or v136.Date
		v_u_137.Button.Thumbnail.Image = v136.Image
		v_u_137.LayoutOrder = -v134
		v_u_137.Parent = p_u_133.ViewMoreContainer
		v_u_137.Button.MouseButton1Click:Connect(function()
			-- upvalues: (copy) p_u_133, (copy) v_u_135
			p_u_133:SetViewMoreListVisible(false)
			task.defer(p_u_133._Generate, p_u_133, v_u_135)
		end)
		local v_u_138 = Color3.fromRGB(64, 64, 64)
		local v_u_139 = Color3.fromRGB(255, 255, 255)
		local function v_u_141(p140) -- name: set
			-- upvalues: (copy) v_u_137, (copy) v_u_138, (copy) v_u_139
			v_u_137.Button.Thumbnail.ImageTransparency = 0.375 - 0.375 * p140
			v_u_137.Button.Thumbnail.ImageColor3 = v_u_138:Lerp(v_u_139, p140)
			v_u_137.Button.Stroke.Size = UDim2.new(1, 2 - 8 * p140, 1, 2 - 8 * p140)
			v_u_137.Button.Stroke.UIStroke.Thickness = 4 * p140
		end
		v_u_137.Button.Thumbnail.ImageTransparency = 0.375
		v_u_137.Button.Thumbnail.ImageColor3 = v_u_138:Lerp(v_u_139, 0)
		v_u_137.Button.Stroke.Size = UDim2.new(1, 2, 1, 2)
		v_u_137.Button.Stroke.UIStroke.Thickness = 0
		local v_u_142 = 0
		local v_u_143 = 0
		v_u_137.Button.MouseLeave:Connect(function()
			-- upvalues: (ref) v_u_142, (ref) v_u_8, (ref) v_u_143, (copy) v_u_141
			v_u_142 = v_u_142 + 1
			local v_u_144 = v_u_142
			v_u_8:RenderstepForLoop(v_u_143, 0, 0.15 * (v_u_143 > 0 and -1 or 1), function(p145)
				-- upvalues: (copy) v_u_144, (ref) v_u_142, (ref) v_u_143, (ref) v_u_141
				if v_u_144 ~= v_u_142 then
					return true
				end
				v_u_143 = p145
				v_u_141(1 - (1 - v_u_143) ^ 3)
			end)
		end)
		v_u_137.Button.SelectionLost:Connect(function()
			-- upvalues: (ref) v_u_142, (ref) v_u_8, (ref) v_u_143, (copy) v_u_141
			v_u_142 = v_u_142 + 1
			local v_u_146 = v_u_142
			v_u_8:RenderstepForLoop(v_u_143, 0, 0.15 * (v_u_143 > 0 and -1 or 1), function(p147)
				-- upvalues: (copy) v_u_146, (ref) v_u_142, (ref) v_u_143, (ref) v_u_141
				if v_u_146 ~= v_u_142 then
					return true
				end
				v_u_143 = p147
				v_u_141(1 - (1 - v_u_143) ^ 3)
			end)
		end)
		v_u_137.Button.MouseEnter:Connect(function()
			-- upvalues: (ref) v_u_142, (ref) v_u_8, (ref) v_u_143, (copy) v_u_141
			v_u_142 = v_u_142 + 1
			local v_u_148 = v_u_142
			v_u_8:RenderstepForLoop(v_u_143, 1, 0.15 * (v_u_143 > 1 and -1 or 1), function(p149)
				-- upvalues: (copy) v_u_148, (ref) v_u_142, (ref) v_u_143, (ref) v_u_141
				if v_u_148 ~= v_u_142 then
					return true
				end
				v_u_143 = p149
				v_u_141(1 - (1 - v_u_143) ^ 3)
			end)
		end)
		v_u_137.Button.SelectionGained:Connect(function()
			-- upvalues: (ref) v_u_142, (ref) v_u_8, (ref) v_u_143, (copy) v_u_141
			v_u_142 = v_u_142 + 1
			local v_u_150 = v_u_142
			v_u_8:RenderstepForLoop(v_u_143, 1, 0.15 * (v_u_143 > 1 and -1 or 1), function(p151)
				-- upvalues: (copy) v_u_150, (ref) v_u_142, (ref) v_u_143, (ref) v_u_141
				if v_u_150 ~= v_u_142 then
					return true
				end
				v_u_143 = p151
				v_u_141(1 - (1 - v_u_143) ^ 3)
			end)
		end)
		v_u_12:Add(v_u_137.Button, nil, {
			["ReleaseRatio"] = 0.975,
			["HoverRatio"] = 0.975
		})
	end
end
function v_u_28._Init(p_u_152) -- name: _Init
	-- upvalues: (copy) v_u_10, (copy) v_u_5, (copy) v_u_1, (copy) v_u_14, (copy) v_u_12
	p_u_152.CloseButton.MouseButton1Click:Connect(function()
		-- upvalues: (ref) v_u_10, (ref) v_u_5, (ref) v_u_1, (copy) p_u_152
		if v_u_10:Get("LastPatchNotesVersion") ~= v_u_5.GAME_VERSION then
			v_u_1.Remotes.Misc.ViewedPatchNotes:FireServer()
		end
		p_u_152:CloseRequest()
	end)
	p_u_152.Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		-- upvalues: (copy) p_u_152
		p_u_152:_UpdateList()
	end)
	p_u_152.ViewMoreLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		-- upvalues: (copy) p_u_152
		p_u_152:_UpdateList()
	end)
	p_u_152.PageFrame:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
		-- upvalues: (copy) p_u_152
		p_u_152:_UpdateList()
	end)
	p_u_152.ViewMoreButton.MouseButton1Click:Connect(function()
		-- upvalues: (copy) p_u_152
		p_u_152:SetViewMoreListVisible(true)
	end)
	v_u_14.MainGui:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
		-- upvalues: (copy) p_u_152
		p_u_152:_UpdateSize()
	end)
	p_u_152:_SetupViewMoreSlots()
	p_u_152:_UpdateSize()
	p_u_152:_UpdateList()
	p_u_152:SetViewMoreListVisible(false)
	v_u_12:Add(p_u_152.CloseButton)
	v_u_12:Add(p_u_152.ViewMoreButton)
end
return v_u_28._new()