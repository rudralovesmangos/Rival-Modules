local v_u_1 = game:GetService("ReplicatedStorage")
local v2 = game:GetService("Players")
local v_u_3 = require(v_u_1.Modules.CONSTANTS)
local v_u_4 = require(v_u_1.Modules.PermissionsLibrary)
local v_u_5 = require(v_u_1.Modules.Utility)
local v_u_6 = require(v2.LocalPlayer.PlayerScripts.Controllers:WaitForChild("ComplianceController"))
local v_u_7 = require(v2.LocalPlayer.PlayerScripts.Controllers:WaitForChild("PlayerDataController"))
local v_u_8 = require(v2.LocalPlayer.PlayerScripts.Modules:WaitForChild("ButtonEffect"))
local v_u_9 = require(v2.LocalPlayer.PlayerScripts.Modules:WaitForChild("DropdownSlot"))
local v_u_10 = require(v2.LocalPlayer.PlayerScripts.Modules:WaitForChild("PromptSystem"))
local v_u_11 = require(v2.LocalPlayer.PlayerScripts.Modules:WaitForChild("Page"))
local v_u_12 = v2.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("PermissionsPlayersCard")
local v_u_13 = v2.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("PermissionsPlayerSlot")
local v_u_14 = v2.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("PermissionsRoleLabel")
local v_u_15 = setmetatable({}, v_u_11)
v_u_15.__index = v_u_15
function v_u_15._new() -- name: _new
	-- upvalues: (copy) v_u_11, (copy) v_u_15, (copy) v_u_10
	local v16 = v_u_11.new(script.Name)
	local v17 = v_u_15
	local v18 = setmetatable(v16, v17)
	v18.PromptsFrame = v18.PageFrame:WaitForChild("Prompts")
	v18.PageContainer = v18.PageFrame:WaitForChild("Container")
	v18.CloseButton = v18.PageContainer:WaitForChild("Close")
	v18.WaitingFrame = v18.PageContainer:WaitForChild("Waiting")
	v18.WaitingDotsFrame = v18.WaitingFrame:WaitForChild("Dots")
	v18.List = v18.PageContainer:WaitForChild("List")
	v18.Container = v18.List:WaitForChild("Container")
	v18.Layout = v18.Container:WaitForChild("Layout")
	v18.InfoButton = v18.Container:WaitForChild("Header"):WaitForChild("Info")
	v18.PromptSystem = v_u_10.new(v18.PromptsFrame)
	v18._permissions_datas = {}
	v18._add_role_dropdown_slot = nil
	v18._players_cards = {}
	v18._player_slots = {}
	v18._generate_hash = 0
	v18:_Init()
	return v18
end
function v_u_15.Open(p19, ...) -- name: Open
	-- upvalues: (copy) v_u_11
	v_u_11.Open(p19, ...)
	p19:_ClearNewPlayerBox()
	p19:_CloseAddRoleDropdown()
	task.spawn(p19._FetchPermissionsDatas, p19)
end
function v_u_15.Close(p20, ...) -- name: Close
	-- upvalues: (copy) v_u_11
	p20:_CloseAddRoleDropdown()
	v_u_11.Close(p20, ...)
end
function v_u_15._CloseAddRoleDropdown(p21) -- name: _CloseAddRoleDropdown
	if p21._add_role_dropdown_slot then
		p21._add_role_dropdown_slot:Destroy()
		p21._add_role_dropdown_slot = nil
	end
end
function v_u_15._ClearNewPlayerBox(p22) -- name: _ClearNewPlayerBox
	for _, v23 in pairs(p22._players_cards) do
		v23.Container.PermissionsNewPlayerSlot.Container.Lookup.Box.Text = ""
	end
end
function v_u_15._GetHighestValueTeam(_, p24) -- name: _GetHighestValueTeam
	-- upvalues: (copy) v_u_4
	local v25 = (-1 / 0)
	local v26 = nil
	for _, v27 in pairs(p24) do
		local v28 = v_u_4.Roles[v27].TeamName
		local v29 = v_u_4.Teams[v28].TeamValue
		if v25 >= v29 then
			continue
		end
		v26 = v28
		v25 = v29
	end
	return v26
end
function v_u_15._GetManageableRoles(_, p30) -- name: _GetManageableRoles
	-- upvalues: (copy) v_u_4, (copy) v_u_7, (copy) v_u_5
	local v31 = v_u_4:GetManageableRoles(v_u_7:Get("PermissionsRoles"))
	if p30 then
		for v32 = #v31, 1, -1 do
			if not table.find(p30, v31[v32]) then
				continue
			end
			table.remove(v31, v32)
		end
	end
	table.sort(v31, function(p33, p34)
		-- upvalues: (ref) v_u_4, (ref) v_u_5
		local v35 = v_u_4.Teams[v_u_4.Roles[p33].TeamName].TeamValue
		local v36 = v_u_4.Teams[v_u_4.Roles[p34].TeamName].TeamValue
		if v35 == v36 then
			local v37 = v_u_4.Roles[p33].RoleValue
			local v38 = v_u_4.Roles[p34].RoleValue
			if v37 == v38 then
				return v_u_5:StringLessThan(v_u_4.Roles[p33].DisplayName, v_u_4.Roles[p34].DisplayName)
			else
				return v38 < v37
			end
		else
			return v36 < v35
		end
	end)
	local v39 = {}
	for v40, v41 in pairs(v31) do
		v39[v40] = v_u_4.Roles[v41].DisplayName
	end
	return v39
end
function v_u_15._RoleManagement(p42, p_u_43, p_u_44) -- name: _RoleManagement
	-- upvalues: (copy) v_u_1
	if p_u_43 and p_u_44 then
		p42:_SetWaitingFrameVisible(true)
		local function v45()
			-- upvalues: (ref) v_u_1, (copy) p_u_43, (copy) p_u_44
			return v_u_1.Remotes.Permissions.RoleManagement:InvokeServer(p_u_43, p_u_44)
		end
		local v46, v47 = pcall(v45)
		if not v46 then
			warn("Failed to manage role, error:", v47)
		end
		p42:_SetWaitingFrameVisible(false)
	end
end
function v_u_15._GetNewUserID(p48, p49) -- name: _GetNewUserID
	local v50 = p48._players_cards[p49].Container.PermissionsNewPlayerSlot.Container.Lookup.Box.Text
	local v51 = string.sub(v50, 2)
	return tonumber(v51)
end
function v_u_15._AddRoleDropdown(p_u_52, p53, p_u_54, p55) -- name: _AddRoleDropdown
	-- upvalues: (copy) v_u_9, (copy) v_u_4
	p_u_52:_CloseAddRoleDropdown()
	p_u_52._add_role_dropdown_slot = v_u_9.new(p53, p_u_52:_GetManageableRoles(p55))
	p_u_52._add_role_dropdown_slot.Selected:Connect(function(p56)
		-- upvalues: (ref) v_u_4, (copy) p_u_54, (copy) p_u_52
		local v57 = v_u_4:GetPermissionsRoleNameFromDisplayName(p56)
		local v58 = p_u_54
		p_u_52:_RoleManagement(tonumber(v58) or p_u_52:_GetNewUserID(p_u_54), v57)
	end)
end
function v_u_15._Generate(p_u_59) -- name: _Generate
	-- upvalues: (copy) v_u_4, (copy) v_u_6, (copy) v_u_13, (copy) v_u_3, (copy) v_u_8, (copy) v_u_5, (copy) v_u_14, (copy) v_u_7
	p_u_59:_CloseAddRoleDropdown()
	p_u_59:_ClearNewPlayerBox()
	for _, v60 in pairs(p_u_59._player_slots) do
		v60:Destroy()
	end
	p_u_59._player_slots = {}
	p_u_59._generate_hash = p_u_59._generate_hash + 1
	local v61 = p_u_59._generate_hash
	local function v68(p62) -- name: get_highest_team_name
		-- upvalues: (ref) v_u_4
		local v63 = (-1 / 0)
		local v64 = nil
		for _, v65 in pairs(p62) do
			local v66 = v_u_4.Roles[v65].TeamName
			local v67 = v_u_4.Teams[v66].TeamValue
			if v63 >= v67 then
				continue
			end
			v64 = v66
			v63 = v67
		end
		return v64
	end
	local function v74(p69) -- name: get_highest_role_name
		-- upvalues: (ref) v_u_4
		local v70 = (-1 / 0)
		local v71 = nil
		for _, v72 in pairs(p69) do
			local v73 = v_u_4.Roles[v72]
			if v70 >= v73.RoleValue then
				continue
			end
			v70 = v73.RoleValue
			v71 = v72
		end
		return v71
	end
	local v75 = {}
	local v76 = {}
	for v77, v78 in pairs(p_u_59._permissions_datas and (p_u_59._permissions_datas.Players or {}) or {}) do
		local v79 = tonumber(v77)
		local v80 = {
			v79,
			v68(v78.Roles),
			v74(v78.Roles),
			v78
		}
		table.insert(v75, v80)
		table.insert(v76, v79)
	end
	local v81 = v_u_6:GetUserInfos(v76)
	if p_u_59._generate_hash == v61 then
		table.sort(v75, function(p82, p83)
			-- upvalues: (ref) v_u_4
			local v84 = p82[2] and (v_u_4.Teams[p82[2]].TeamValue or -1) or -1
			local v85 = p83[2] and (v_u_4.Teams[p83[2]].TeamValue or -1) or -1
			if v84 == v85 then
				local v86 = p82[3] and (v_u_4.Roles[p82[3]].RoleValue or -1) or -1
				local v87 = p83[3] and (v_u_4.Roles[p83[3]].RoleValue or -1) or -1
				if v86 == v87 then
					return (p82[4].AddedTimestamp or (1 / 0)) < (p83[4].AddedTimestamp or (1 / 0))
				else
					return v87 < v86
				end
			else
				return v85 < v84
			end
		end)
		for _, v88 in pairs(v75) do
			local v_u_89, v90, _, v_u_91 = table.unpack(v88)
			if #v_u_91.Roles == 0 then
				continue
			end
			local v92 = v81[tostring(v_u_89)]
			local v93 = v92 and v92.DisplayName and (v92.DisplayName or "\226\128\162 \226\128\162 \226\128\162") or "\226\128\162 \226\128\162 \226\128\162"
			local v94 = v92 and (v92.Username and "@" .. v92.Username) or "\226\128\162 \226\128\162 \226\128\162"
			local v_u_95 = v_u_13:Clone()
			v_u_95.Container.DisplayName.Text = v93
			v_u_95.Container.Username.Text = v94
			v_u_95.Container.UserId.Text = "#" .. v_u_89
			v_u_95.Container.Headshot.Image = string.format(v_u_3.HEADSHOT_IMAGE, v_u_89)
			v_u_95.Parent = p_u_59._players_cards[v90].Container
			local v96 = p_u_59._player_slots
			table.insert(v96, v_u_95)
			v_u_8:Add(v_u_95.Container.Roles.Add, true)
			v_u_95.Container.Roles.Add.MouseButton1Click:Connect(function()
				-- upvalues: (copy) p_u_59, (copy) v_u_91, (ref) v_u_5, (copy) v_u_95, (copy) v_u_89
				if #p_u_59:_GetManageableRoles(v_u_91.Roles) == 0 then
					v_u_5:CreateSound("rbxassetid://17153811469", 2, 1, script, true, 5)
				else
					p_u_59:_AddRoleDropdown(v_u_95.Container.Roles.Add.DropdownContainer, v_u_89, v_u_91.Roles)
				end
			end)
			for _, v_u_97 in pairs(v_u_91.Roles) do
				local v98 = v_u_4.Roles[v_u_97]
				local v_u_99 = v_u_14:Clone()
				v_u_99.Display.Title.Text = v98.DisplayName
				v_u_99.Background.ImageColor3 = v98.Color or Color3.fromRGB(255, 255, 255)
				v_u_99.LayoutOrder = -(v_u_4.Teams[v98.TeamName].TeamValue * 10000 + v98.RoleValue)
				v_u_99.Parent = v_u_95.Container.Roles
				v_u_8:Add(v_u_99, true)
				v_u_99.MouseButton1Click:Connect(function()
					-- upvalues: (ref) v_u_4, (copy) v_u_97, (ref) v_u_7, (ref) v_u_5, (copy) p_u_59, (copy) v_u_89
					if v_u_4:CanManageRole(v_u_97, v_u_7:Get("PermissionsRoles")) then
						p_u_59:_RoleManagement(v_u_89, v_u_97)
					else
						v_u_5:CreateSound("rbxassetid://17153811469", 2, 1, script, true, 5)
					end
				end)
				local v_u_100 = v_u_99.Display.Title
				v_u_100:GetPropertyChangedSignal("TextBounds"):Connect(function() -- name: update
					-- upvalues: (copy) v_u_99, (copy) v_u_100
					v_u_99.Size = UDim2.new(0.1, v_u_100.TextBounds.X, 0.1, 0)
				end)
				v_u_99.Size = UDim2.new(0.1, v_u_100.TextBounds.X, 0.1, 0)
			end
			local v_u_101 = v_u_95.Container.Roles.Layout
			v_u_101:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() -- name: update
				-- upvalues: (copy) v_u_95, (copy) v_u_101
				v_u_95.Size = UDim2.new(0.24, 0, 0.085, v_u_101.AbsoluteContentSize.Y)
			end)
			v_u_95.Size = UDim2.new(0.24, 0, 0.085, v_u_101.AbsoluteContentSize.Y)
		end
	end
end
function v_u_15._SetWaitingFrameVisible(p102, p103) -- name: _SetWaitingFrameVisible
	p102.WaitingFrame.Visible = p103
	if p102.WaitingFrame then
		p102.WaitingDotsFrame:AddTag("UILoadingDots")
	else
		p102.WaitingDotsFrame:RemoveTag("UILoadingDots")
	end
end
function v_u_15._SetPermissionsDatas(p104, p105) -- name: _SetPermissionsDatas
	p104._permissions_datas = p105 or {}
	p104:_Generate()
end
function v_u_15._FetchPermissionsDatas(p106) -- name: _FetchPermissionsDatas
	-- upvalues: (copy) v_u_1
	p106:_CloseAddRoleDropdown()
	p106:_ClearNewPlayerBox()
	p106:_SetWaitingFrameVisible(true)
	local function v107()
		-- upvalues: (ref) v_u_1
		return v_u_1.Remotes.Permissions.FetchPermissions:InvokeServer()
	end
	local v108, v109 = pcall(v107)
	if v108 then
		if not v109 then
			warn("Fetching permissions returned nothing!")
		end
	else
		warn("Failed to fetch permissions, error:", v109)
	end
	p106:_SetPermissionsDatas(v108 and v109)
	p106:_SetWaitingFrameVisible(false)
end
function v_u_15._UpdateLayouts(p110) -- name: _UpdateLayouts
	p110.CloseButton.Position = UDim2.new(0.975, 0, 0.0225, p110.PageFrame.AbsoluteSize.Y * 0.125)
	p110.List.Position = UDim2.new(0.5, 9, 0, p110.PageFrame.AbsoluteSize.Y * 0.125)
	p110.List.Size = UDim2.new(0.85, 0, 0, p110.PageFrame.AbsoluteSize.Y * 0.75)
	p110.List.CanvasSize = UDim2.new(0, 0, 0, p110.Layout.AbsoluteContentSize.Y)
end
function v_u_15._VerifyOpen(p_u_111) -- name: _VerifyOpen
	-- upvalues: (copy) v_u_4, (copy) v_u_7
	if not v_u_4:CanViewPermissionsPage(v_u_7:Get("PermissionsRoles")) then
		task.defer(function()
			-- upvalues: (copy) p_u_111
			p_u_111.Closed:Fire()
		end)
	end
end
function v_u_15._Setup(p_u_112) -- name: _Setup
	-- upvalues: (copy) v_u_4, (copy) v_u_12, (copy) v_u_3, (copy) v_u_5, (copy) v_u_8
	for v_u_113, v114 in pairs(v_u_4.Teams) do
		local v_u_115 = v_u_12:Clone()
		v_u_115.Container.Header.Title.Text = v114.DisplayName
		v_u_115.Container.Header.Background.ImageColor3 = v114.Color
		v_u_115.Container.Header.Icon.Image = v114.Icon
		v_u_115.LayoutOrder = -v114.TeamValue
		v_u_115.Parent = p_u_112.Container
		p_u_112._players_cards[v_u_113] = v_u_115
		local v_u_116 = v_u_115.Container.Layout
		v_u_116:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() -- name: update
			-- upvalues: (copy) v_u_115, (copy) v_u_116
			v_u_115.Size = UDim2.new(1, 0, 0, v_u_116.AbsoluteContentSize.Y)
		end)
		v_u_115.Size = UDim2.new(1, 0, 0, v_u_116.AbsoluteContentSize.Y)
		local function v_u_118() -- name: update_headshot
			-- upvalues: (copy) p_u_112, (copy) v_u_113, (copy) v_u_115, (ref) v_u_3
			local v117 = p_u_112:_GetNewUserID(v_u_113)
			v_u_115.Container.PermissionsNewPlayerSlot.Container.Headshot.ImageColor3 = Color3.fromRGB(255, 255, 255)
			v_u_115.Container.PermissionsNewPlayerSlot.Container.Headshot.ImageTransparency = v117 and 0 or 0.75
			v_u_115.Container.PermissionsNewPlayerSlot.Container.Headshot.Image = not v117 and "rbxassetid://93178222051105" or string.format(v_u_3.HEADSHOT_IMAGE, v117)
		end
		v_u_115.Container.PermissionsNewPlayerSlot.Container.Lookup.Box.FocusLost:Connect(v_u_118)
		v_u_118()
		v_u_115.Container.PermissionsNewPlayerSlot.Container.Lookup.Box:GetPropertyChangedSignal("Text"):Connect(function()
			-- upvalues: (copy) v_u_115, (copy) v_u_118
			if not v_u_115.Container.PermissionsNewPlayerSlot.Container.Lookup.Box:IsFocused() then
				v_u_118()
			end
		end)
		v_u_115.Container.PermissionsNewPlayerSlot.Container.Roles.Add.MouseButton1Click:Connect(function()
			-- upvalues: (copy) p_u_112, (copy) v_u_113, (ref) v_u_5, (copy) v_u_115
			if p_u_112:_GetNewUserID(v_u_113) and #p_u_112:_GetManageableRoles() ~= 0 then
				p_u_112:_AddRoleDropdown(v_u_115.Container.PermissionsNewPlayerSlot.Container.Roles.Add.DropdownContainer, v_u_113)
			else
				v_u_5:CreateSound("rbxassetid://17153811469", 2, 1, script, true, 5)
			end
		end)
		v_u_8:Add(v_u_115.Container.PermissionsNewPlayerSlot.Container.Roles.Add, true)
	end
end
function v_u_15._Init(p_u_119) -- name: _Init
	-- upvalues: (copy) v_u_7, (copy) v_u_1, (copy) v_u_8
	p_u_119.CloseButton.MouseButton1Click:Connect(function()
		-- upvalues: (copy) p_u_119
		p_u_119:CloseRequest()
	end)
	p_u_119.PageFrame:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
		-- upvalues: (copy) p_u_119
		p_u_119:_UpdateLayouts()
	end)
	p_u_119.Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		-- upvalues: (copy) p_u_119
		p_u_119:_UpdateLayouts()
	end)
	p_u_119.InfoButton.MouseButton1Click:Connect(function()
		-- upvalues: (copy) p_u_119
		p_u_119.PromptSystem:Open("ViewPermissionsRoles")
	end)
	v_u_7:GetDataChangedSignal("PermissionsRoles"):Connect(function()
		-- upvalues: (copy) p_u_119
		p_u_119:_VerifyOpen()
	end)
	v_u_1.Remotes.Permissions.UpdatePermissions.OnClientEvent:Connect(function(p120)
		-- upvalues: (copy) p_u_119
		p_u_119:_SetPermissionsDatas(p120)
	end)
	p_u_119:_Setup()
	p_u_119:_Generate()
	p_u_119:_UpdateLayouts()
	p_u_119:_VerifyOpen()
	v_u_8:Add(p_u_119.InfoButton)
	v_u_8:Add(p_u_119.CloseButton)
end
return v_u_15._new()