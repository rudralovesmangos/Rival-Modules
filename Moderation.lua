local v_u_1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("UserService")
local v_u_3 = game:GetService("Players")
local v_u_4 = require(v_u_1.Modules.CONSTANTS)
local v_u_5 = require(v_u_1.Modules.PermissionsLibrary)
local v_u_6 = require(v_u_1.Modules.ModerationLibrary)
local v_u_7 = require(v_u_1.Modules.SeasonLibrary)
local v_u_8 = require(v_u_1.Modules.ServerOsTime)
local v_u_9 = require(v_u_1.Modules.BanLibrary)
local v_u_10 = require(v_u_1.Modules.Utility)
local v_u_11 = require(v_u_3.LocalPlayer.PlayerScripts.Controllers:WaitForChild("PlayerDataController"))
local v_u_12 = require(v_u_3.LocalPlayer.PlayerScripts.Modules:WaitForChild("ButtonEffect"))
local v_u_13 = require(v_u_3.LocalPlayer.PlayerScripts.Modules:WaitForChild("PromptSystem"))
local v_u_14 = require(v_u_3.LocalPlayer.PlayerScripts.Modules:WaitForChild("DropdownSlot"))
local v_u_15 = require(v_u_3.LocalPlayer.PlayerScripts.Modules:WaitForChild("RankIcon"))
local v_u_16 = require(v_u_3.LocalPlayer.PlayerScripts.Modules:WaitForChild("Page"))
local v_u_17 = {
	{ "permission_moderation_modpanel_access" },
	{
		"permission_moderation_modpanel_viewbanned_full",
		"permission_moderation_modpanel_viewactions_full",
		"permission_moderation_modpanel_viewdata_limited",
		"permission_moderation_modpanel_viewdata_most",
		"permission_moderation_modpanel_viewdata_full"
	},
	{ "permission_moderation_modpanel_teleport_full" },
	{ "permission_moderation_modpanel_warn_template", "permission_moderation_modpanel_warn_custom" },
	{ "permission_moderation_modpanel_evict_limited", "permission_moderation_modpanel_evict_full" },
	{
		"permission_moderation_modpanel_moderate_limited",
		"permission_moderation_modpanel_moderate_most",
		"permission_moderation_modpanel_moderate_full",
		"permission_moderation_modpanel_unban"
	},
	{ "permission_moderation_modpanel_restrict" },
	{ "permission_moderation_modpanel_removelbs_limited", "permission_moderation_modpanel_investigate_full" },
	{ "permission_moderation_modpanel_pardon_limited", "permission_moderation_modpanel_pardon_full" },
	{ "permission_moderation_modpanel_lock" }
}
local v_u_18 = setmetatable({}, v_u_16)
v_u_18.__index = v_u_18
function v_u_18._new() -- name: _new
	-- upvalues: (copy) v_u_16, (copy) v_u_18, (copy) v_u_13
	local v19 = v_u_16.new(script.Name)
	local v20 = v_u_18
	local v21 = setmetatable(v19, v20)
	v21.PromptsFrame = v21.PageFrame:WaitForChild("Prompts")
	v21.PageContainer = v21.PageFrame:WaitForChild("Container")
	v21.CloseButton = v21.PageContainer:WaitForChild("Close")
	v21.List = v21.PageContainer:WaitForChild("List")
	v21.Container = v21.List:WaitForChild("Container")
	v21.Layout = v21.Container:WaitForChild("Layout")
	v21.HeaderFrame = v21.Container:WaitForChild("Header")
	v21.InfoButton = v21.HeaderFrame:WaitForChild("Info")
	v21.InfoButtonBubble = v21.InfoButton:WaitForChild("Bubble")
	v21.InfoButtonBubbleTitle = v21.InfoButtonBubble:WaitForChild("Title")
	v21.InfoButtonBubbleBackground = v21.InfoButtonBubble:WaitForChild("Background")
	v21.PowersButton = v21.HeaderFrame:WaitForChild("Powers")
	v21.PowersButtonBubble = v21.PowersButton:WaitForChild("Bubble")
	v21.PowersButtonBubbleTitle = v21.PowersButtonBubble:WaitForChild("Container"):WaitForChild("Title")
	v21.LookupFrame = v21.Container:WaitForChild("Lookup")
	v21.LookupBox = v21.LookupFrame:WaitForChild("Box")
	v21.LookupButton = v21.LookupFrame:WaitForChild("Button")
	v21.LookupDropdownButton = v21.LookupFrame:WaitForChild("Dropdown")
	v21.DropdownReferenceFrame = v21.LookupFrame:WaitForChild("DropdownReference")
	v21.InvestigateFrame = v21.Container:WaitForChild("Investigate")
	v21.InvestigateContainer = v21.InvestigateFrame:WaitForChild("Container")
	v21.InvestigateWinStreaksFrame = v21.InvestigateContainer:WaitForChild("Top100WinStreaks")
	v21.InvestigateWinStreaksButton = v21.InvestigateWinStreaksFrame:WaitForChild("Button")
	v21.InvestigateTrueWinStreaksFrame = v21.InvestigateContainer:WaitForChild("Top100TrueWinStreaks")
	v21.InvestigateTrueWinStreaksButton = v21.InvestigateTrueWinStreaksFrame:WaitForChild("Button")
	v21.PlayerFrame = v21.Container:WaitForChild("Player")
	v21.PlayerWaitingFrame = v21.PlayerFrame:WaitForChild("Waiting")
	v21.PlayerWaitingDotsFrame = v21.PlayerWaitingFrame:WaitForChild("Dots")
	v21.PlayerLoadedFrame = v21.PlayerFrame:WaitForChild("Loaded")
	v21.PlayerLoadedActionsFrame = v21.PlayerLoadedFrame:WaitForChild("Actions")
	v21.PlayerLoadedInformationFrame = v21.PlayerLoadedFrame:WaitForChild("Information")
	v21.PlayerLoadedInformationPicture = v21.PlayerLoadedInformationFrame:WaitForChild("Picture"):WaitForChild("Picture")
	v21.PromptSystem = v_u_13.new(v21.PromptsFrame)
	v21._ban_data = nil
	v21._result_data = nil
	v21._player_data = nil
	v21._player_metadata = nil
	v21._is_this_dude_banned = false
	v21._ban_data_hash = 0
	v21._lookup_disabled = false
	v21._player_data_debounce = false
	v21._last_rank_icon = nil
	v21._dropdown_slot = nil
	v21._cached_players = {}
	v21:_Init()
	return v21
end
function v_u_18.SetBanData(p_u_22, p23, p24, p25) -- name: SetBanData
	-- upvalues: (copy) v_u_9, (copy) v_u_8, (copy) v_u_7, (copy) v_u_4, (copy) v_u_10, (copy) v_u_15, (copy) v_u_2
	local v26 = not p24 or typeof(p24) == "table"
	local v27 = "Argument 1 invalid, expected a table or nil, got " .. tostring(p24)
	assert(v26, v27)
	local v28 = not p25 or typeof(p25) == "table"
	local v29 = "Argument 2 invalid, expected a table or nil, got " .. tostring(p25)
	assert(v28, v29)
	if not p23 then
		local v30
		if p24 then
			v30 = p24.UserID
		else
			v30 = p24
		end
		local v31 = p_u_22._ban_data
		if v31 then
			v31 = p_u_22._ban_data.UserID
		end
		if v30 ~= v31 then
			return
		end
	end
	p_u_22._ban_data = p24
	p_u_22._result_data = p25
	local v32
	if p_u_22._result_data then
		v32 = p_u_22._result_data.RawData or nil
	else
		v32 = nil
	end
	p_u_22._player_data = v32
	local v33
	if p_u_22._result_data then
		v33 = p_u_22._result_data.Metadata or nil
	else
		v33 = nil
	end
	p_u_22._player_metadata = v33
	p_u_22._is_this_dude_banned = nil
	p_u_22._ban_data_hash = p_u_22._ban_data_hash + 1
	p_u_22.PlayerLoadedFrame.Visible = p_u_22._ban_data ~= nil
	if p_u_22._last_rank_icon then
		p_u_22._last_rank_icon:Destroy()
		p_u_22._last_rank_icon = nil
	end
	if p_u_22._ban_data then
		local v_u_34 = p_u_22._ban_data_hash
		local v35 = v_u_9:IsBanned(p_u_22._ban_data)
		local v36
		if v35 then
			local v37 = v35.EndTime - v_u_8:GetRounded()
			v36 = math.max(0, v37)
		else
			v36 = v35
		end
		local v38 = p_u_22._player_data and p_u_22._player_data.RedFlags
		if v38 then
			v38 = p_u_22._player_data.RedFlags[#p_u_22._player_data.RedFlags]
		end
		local v39 = p_u_22._player_data
		if v39 then
			v39 = p_u_22._player_data.SessionID ~= nil
		end
		local v40 = p_u_22._player_data
		if v40 then
			v40 = p_u_22._player_data.Level
		end
		local v41 = p_u_22._player_data
		if v41 then
			v41 = p_u_22._player_data.StatisticDuelsWinStreak
		end
		local v42 = p_u_22._player_data
		if v42 then
			v42 = p_u_22._player_data.LastKnownControls
		end
		local v43 = p_u_22._player_data and (p_u_22._player_data.Seasons and p_u_22._player_data.Seasons[v_u_7.CurrentSeason.Name])
		if v43 then
			v43 = p_u_22._player_data.Seasons[v_u_7.CurrentSeason.Name].RankedPerformances[v_u_7.UNIVERSAL_ELO_NAME]
		end
		local v44
		if v43 then
			v44 = v43.CurrentELO
		else
			v44 = v43
		end
		local v45
		if v43 then
			v45 = v_u_7:GetHighestELOLeaderboardRanking(v44, p_u_22._ban_data.UserID)
		else
			v45 = v43
		end
		local v46
		if v43 then
			v46 = v_u_7:GetRank(v44, p_u_22._ban_data.UserID, v45)
		else
			v46 = v43
		end
		if v46 then
			v46 = v_u_7.CurrentSeason.RankProfile.Ranks[v46]
		end
		local v47 = p_u_22._ban_data.BanLocked and "\240\159\148\146" or ""
		local v48 = p_u_22._ban_data.Restrictions
		if v48 then
			v48 = p_u_22._ban_data.Restrictions.RestrictedFromCasualLeaderboards
		end
		local v49 = p_u_22._ban_data.Restrictions
		if v49 then
			v49 = p_u_22._ban_data.Restrictions.RestrictedFromCompetitiveLeaderboards
		end
		local v50 = 0
		local v51 = 0
		for _, v52 in pairs(p_u_22._ban_data.BanHistory or {}) do
			if v_u_9:IsBanLogAWarning(v52) then
				v50 = v50 + 1
			end
			if not v_u_9:IsBanLogABan(v52) then
				continue
			end
			v51 = v51 + 1
		end
		p_u_22._is_this_dude_banned = v35 ~= nil
		local v53 = p_u_22.PlayerLoadedInformationPicture
		local v54 = string.format
		local v55 = v_u_4.HEADSHOT_IMAGE
		local v56 = p_u_22._ban_data.UserID
		v53.Image = v54(v55, (tostring(v56)))
		p_u_22:_SetInformationFrameVisible("ELO", v43)
		p_u_22:_SetInformationFrameText("ELO", (v44 and (v_u_10:PrettyNumber(v44) or "N/A") or "N/A") .. " " .. (v46 and v46.DisplayName or "N/A") .. " " .. (v45 and " #" .. v45 or ""))
		p_u_22:_SetInformationFrameVisible("Level", v40)
		p_u_22:_SetInformationFrameText("Level", v40 and v_u_10:PrettyNumber(v40) or "")
		local v57 = "WinStreak"
		local v58
		if v41 then
			v58 = v41 > 0
		else
			v58 = v41
		end
		p_u_22:_SetInformationFrameVisible(v57, v58)
		p_u_22:_SetInformationFrameText("WinStreak", v41 and (v41 > 0 and v_u_10:PrettyNumber(v41)) or "")
		p_u_22:_SetInformationFrameVisible("Controls", v42)
		p_u_22:_SetInformationFrameText("Controls", v42 or "")
		p_u_22:_SetInformationFrameText("Username", "@" .. p_u_22._ban_data.Name)
		p_u_22:_SetInformationFrameText("DisplayName", "\226\128\162 \226\128\162 \226\128\162")
		local v59 = p_u_22._ban_data.UserID
		p_u_22:_SetInformationFrameText("UserID", "#" .. tostring(v59))
		p_u_22:_SetInformationFrameText("Online", v39 and "\240\159\159\162 Online" or "\240\159\148\180 Offline")
		p_u_22:_SetInformationFrameText("Lock", p_u_22._ban_data.BanLocked and "Locked" or "Not locked", p_u_22._ban_data.BanLocked and Color3.fromRGB(255, 50, 50) or Color3.fromRGB(100, 255, 50))
		p_u_22:_SetInformationFrameText("Status", v47 .. (v35 and ("Banned [" .. (v35.Duration and v35.Duration >= v_u_9.PERMANENT_BAN_DURATION and "Permanent" or v_u_10:TimeFormat2(v36)) .. "]" or "Not banned") or "Not banned"), v35 and Color3.fromRGB(255, 50, 50) or Color3.fromRGB(100, 255, 50))
		p_u_22:_SetInformationFrameText("History", v47 .. (v35 and "\240\159\154\168 " .. v35.Reason or (v51 > 0 and ("Banned " .. v51 .. " time" .. (v51 == 1 and "" or "s") or "No ban history") or "No ban history")), v35 and Color3.fromRGB(255, 50, 50) or (v51 > 0 and Color3.fromRGB(255, 150, 0) or Color3.fromRGB(100, 255, 50)))
		local v60 = "Flags"
		local v61
		if v38 then
			local v62 = v38.Reason
			v61 = tostring(v62) or "Not flagged"
		else
			v61 = "Not flagged"
		end
		p_u_22:_SetInformationFrameText(v60, v47 .. v61, v38 and Color3.fromRGB(255, 50, 50) or Color3.fromRGB(100, 255, 50))
		p_u_22:_SetInformationFrameText("CasualLBs", v47 .. (v48 and "Restricted" or "Not restricted"), v48 and Color3.fromRGB(255, 50, 50) or Color3.fromRGB(100, 255, 50))
		p_u_22:_SetInformationFrameText("CompLBs", v47 .. (v49 and "Restricted" or "Not restricted"), v49 and Color3.fromRGB(255, 50, 50) or Color3.fromRGB(100, 255, 50))
		p_u_22:_SetInformationFrameText("Warnings", v47 .. (v50 > 0 and (v50 .. " warning" .. (v50 == 1 and "" or "s") or "No warnings") or "No warnings"), v50 > 0 and Color3.fromRGB(255, 150, 0) or Color3.fromRGB(100, 255, 50))
		if v43 then
			p_u_22._last_rank_icon = v_u_15.new(v44, p_u_22._ban_data.UserID)
			p_u_22._last_rank_icon:SetParent(p_u_22.PlayerRank)
		end
		task.spawn(function()
			-- upvalues: (ref) v_u_2, (copy) p_u_22, (copy) v_u_34
			local v63 = v_u_2:GetUserInfosByUserIdsAsync({ p_u_22._ban_data.UserID })
			if v_u_34 == p_u_22._ban_data_hash then
				if v63[1] and v63[1].DisplayName then
					p_u_22:_SetInformationFrameText("DisplayName", v63[1].DisplayName)
				end
			else
				return
			end
		end)
		p_u_22:_UpdatePermissions()
	end
end
function v_u_18.Open(p_u_64, ...) -- name: Open
	-- upvalues: (copy) v_u_16, (copy) v_u_1
	v_u_16.Open(p_u_64, ...)
	task.spawn(function()
		-- upvalues: (copy) p_u_64, (ref) v_u_1
		p_u_64._cached_players = v_u_1.Remotes.Moderator.RequestCachedPlayers:InvokeServer() or p_u_64._cached_players
	end)
end
function v_u_18._SetActionButtonVisible(p65, p66, p67) -- name: _SetActionButtonVisible
	p65.PlayerLoadedActionsFrame:WaitForChild(p66).Visible = p67
end
function v_u_18._SetInformationFrameText(p68, p69, p70, p71) -- name: _SetInformationFrameText
	p68.PlayerLoadedInformationFrame:WaitForChild(p69):WaitForChild("Value").Text = p70
	p68.PlayerLoadedInformationFrame:WaitForChild(p69):WaitForChild("Value").TextColor3 = p71 or Color3.fromRGB(255, 255, 255)
end
function v_u_18._SetInformationFrameVisible(p72, p73, p74) -- name: _SetInformationFrameVisible
	p72.PlayerLoadedInformationFrame:WaitForChild(p73).Visible = p74
end
function v_u_18._UpdatePowersButtonBubble(p75) -- name: _UpdatePowersButtonBubble
	-- upvalues: (copy) v_u_11, (copy) v_u_17, (copy) v_u_5
	local v76 = v_u_11:Get("PermissionsRoles")
	local v77 = ""
	for v78, v79 in pairs(v_u_17) do
		if v78 > 1 then
			v77 = v77 .. "\n\n"
		end
		for v80, v81 in pairs(v79) do
			if v80 > 1 then
				v77 = v77 .. "\n"
			end
			v77 = v77 .. string.format("%s %s", v_u_5:HasPermission(v81, v76) and "\226\156\133" or "\240\159\159\165", v_u_5.Permissions[v81].Description)
		end
	end
	p75.PowersButtonBubbleTitle.Text = v77
end
function v_u_18._UpdatePermissions(p82) -- name: _UpdatePermissions
	-- upvalues: (copy) v_u_11, (copy) v_u_6
	local v83 = v_u_11:Get("PermissionsRoles")
	local v84 = p82._ban_data
	if v84 then
		v84 = p82._ban_data.BanLocked
	end
	for _, v85 in pairs({
		"Status",
		"CasualLBs",
		"CompLBs",
		"Flags",
		"History",
		"Warnings",
		"Lock"
	}) do
		p82:_SetInformationFrameVisible(v85, v_u_6:CanViewBanStatusAndLogs(v83))
	end
	p82.InvestigateFrame.Visible = v_u_6:CanUseInvestigativeCommands(v83)
	p82:_SetActionButtonVisible("ViewLogs", v_u_6:CanViewBanStatusAndLogs(v83))
	p82:_SetActionButtonVisible("ViewData", v_u_6:CanViewData(v83))
	p82:_SetActionButtonVisible("ViewActions", v_u_6:CanViewActionHistory(v83))
	p82:_SetActionButtonVisible("Lock", v_u_6:CanManageBanLocks(v83))
	local v86 = "Kick"
	local v87 = not v84
	if v87 then
		v87 = v_u_6:CanEvict(v83)
	end
	p82:_SetActionButtonVisible(v86, v87)
	local v88 = "Moderate"
	local v89 = not v84
	if v89 then
		if p82._is_this_dude_banned then
			v89 = v_u_6:CanUnban(v83)
		else
			v89 = v_u_6:CanBan(v83)
		end
	end
	p82:_SetActionButtonVisible(v88, v89)
	local v90 = "Wipe"
	local v91 = not v84
	if v91 then
		v91 = v_u_6:CanRemoveFromLeaderboards(v83)
	end
	p82:_SetActionButtonVisible(v90, v91)
	local v92 = "Pardon"
	local v93 = not v84 and v_u_6:CanPardon(v83) and (p82._player_data and p82._player_data.RedFlags)
	if v93 then
		v93 = p82._player_data.RedFlags[#p82._player_data.RedFlags]
	end
	p82:_SetActionButtonVisible(v92, v93)
	local v94 = "Restrict"
	local v95 = not v84
	if v95 then
		v95 = v_u_6:CanRestrict(v83)
	end
	p82:_SetActionButtonVisible(v94, v95)
	local v96 = "Warn"
	local v97 = not v84
	if v97 then
		v97 = v_u_6:CanWarnCustom(v83)
	end
	p82:_SetActionButtonVisible(v96, v97)
	p82:_UpdatePowersButtonBubble()
end
function v_u_18._UpdateLayouts(p98) -- name: _UpdateLayouts
	p98.InfoButtonBubbleBackground.Size = UDim2.new(0.0375, p98.InfoButtonBubbleTitle.TextBounds.X, 1, 0)
	p98.CloseButton.Position = UDim2.new(0.9, 0, 0.0225, p98.PageFrame.AbsoluteSize.Y * 0.125)
	p98.List.Position = UDim2.new(0.5, 9, 0, p98.PageFrame.AbsoluteSize.Y * 0.125)
	p98.List.Size = UDim2.new(0.7, 0, 0, p98.PageFrame.AbsoluteSize.Y * 0.75)
	p98.List.CanvasSize = UDim2.new(0, 0, 0, p98.Layout.AbsoluteContentSize.Y)
end
function v_u_18._PlayersLookupDropdown(p_u_99) -- name: _PlayersLookupDropdown
	-- upvalues: (copy) v_u_10, (copy) v_u_3, (copy) v_u_14
	if p_u_99._dropdown_slot then
		p_u_99._dropdown_slot:Cancel()
		p_u_99._dropdown_slot = nil
	end
	local v100 = v_u_10:CloneTable(p_u_99._cached_players)
	for _, v101 in pairs(v_u_3:GetPlayers()) do
		local v102 = string.upper(v101.DisplayName) .. " (@" .. string.upper(v101.Name) .. ")"
		if table.find(v100, v102) then
			continue
		end
		table.insert(v100, v102)
	end
	table.sort(v100, function(p103, p104)
		-- upvalues: (ref) v_u_10
		return v_u_10:StringLessThan(p103, p104)
	end)
	p_u_99._dropdown_slot = v_u_14.new(p_u_99.DropdownReferenceFrame, v100)
	p_u_99._dropdown_slot.Selected:Connect(function(p105)
		-- upvalues: (copy) p_u_99
		p_u_99._dropdown_slot = nil
		if p105 then
			local v106 = p_u_99.LookupBox
			local v107 = string.find(p105, "@") + 1
			local v108 = #p105 - 1
			v106.Text = string.sub(p105, v107, v108)
			task.defer(p_u_99._FetchBanData, p_u_99)
		end
	end)
end
function v_u_18._FetchPlayerData(p_u_109) -- name: _FetchPlayerData
	-- upvalues: (copy) v_u_1
	if p_u_109._player_data_debounce then
		return
	else
		p_u_109._player_data_debounce = true
		local function v110()
			-- upvalues: (ref) v_u_1, (copy) p_u_109
			return v_u_1.Remotes.Moderator.RequestPlayerData:InvokeServer(p_u_109._ban_data.Name)
		end
		local v111, v112 = pcall(v110)
		p_u_109._player_data_debounce = false
		if v111 then
			if v112 then
				p_u_109.PromptSystem:Open("ViewPlayerData", p_u_109._ban_data.Name, v112)
			else
				p_u_109.PromptSystem:Open("ErrorMessage", "Whoops!", "This player has never played RIVALS before!")
			end
		else
			p_u_109.PromptSystem:Open("ErrorMessage", "Whoops!", "Something went wrong while fetching their data, error:", (tostring(v112)))
			return
		end
	end
end
function v_u_18._RawFetchBanData(p113, p114) -- name: _RawFetchBanData
	-- upvalues: (copy) v_u_1
	if p113._lookup_disabled then
		return
	else
		p113:SetBanData(true, nil, nil)
		if p114 and #p114 ~= 0 then
			p113._lookup_disabled = true
			p113.PlayerWaitingFrame.Visible = true
			p113.PlayerWaitingDotsFrame:AddTag("UILoadingDots")
			local v115 = v_u_1.Remotes.Moderator.RequestPlayer:InvokeServer(p114) or {}
			p113:SetBanData(true, table.unpack(v115))
			p113._lookup_disabled = false
			p113.PlayerWaitingFrame.Visible = false
			p113.PlayerWaitingDotsFrame:RemoveTag("UILoadingDots")
		end
	end
end
function v_u_18._FetchBanData(p116) -- name: _FetchBanData
	p116:_RawFetchBanData(p116.LookupBox.Text)
end
function v_u_18._SetupActionButton(p117, p118, p119) -- name: _SetupActionButton
	-- upvalues: (copy) v_u_12
	local v120 = p117.PlayerLoadedActionsFrame:WaitForChild(p118):WaitForChild("Button")
	local v_u_121 = v120:WaitForChild("Title")
	local v_u_122 = v120:WaitForChild("Description")
	local v_u_123 = v120:WaitForChild("Icon")
	local v_u_124 = v120:WaitForChild("Background")
	local v_u_125 = v_u_124:WaitForChild("UIGradient")
	local v_u_126 = v_u_124.ImageColor3
	v120.MouseEnter:Connect(function() -- name: enter
		-- upvalues: (copy) v_u_124, (copy) v_u_121, (copy) v_u_122, (copy) v_u_123, (copy) v_u_125
		v_u_124.ImageColor3 = Color3.fromRGB(255, 255, 255)
		v_u_124.ImageTransparency = 0
		v_u_124.Size = UDim2.new(0.725, 0, 1, 0)
		v_u_121.TextColor3 = Color3.fromRGB(0, 0, 0)
		v_u_122.TextColor3 = Color3.fromRGB(0, 0, 0)
		v_u_123.ImageColor3 = Color3.fromRGB(0, 0, 0)
		v_u_125.Enabled = false
	end)
	local function v127() -- name: leave
		-- upvalues: (copy) v_u_124, (copy) v_u_126, (copy) v_u_121, (copy) v_u_122, (copy) v_u_123, (copy) v_u_125
		v_u_124.ImageColor3 = v_u_126
		v_u_124.ImageTransparency = 0.5
		v_u_124.Size = UDim2.new(1, 0, 1, 0)
		v_u_121.TextColor3 = Color3.fromRGB(255, 255, 255)
		v_u_122.TextColor3 = Color3.fromRGB(255, 255, 255)
		v_u_123.ImageColor3 = Color3.fromRGB(255, 255, 255)
		v_u_125.Enabled = true
	end
	v120.MouseLeave:Connect(v127)
	v127()
	v120.MouseButton1Click:Connect(p119)
	v_u_12:Add(v120, true)
end
function v_u_18._Init(p_u_128) -- name: _Init
	-- upvalues: (copy) v_u_1, (copy) v_u_11, (copy) v_u_12
	p_u_128.Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		-- upvalues: (copy) p_u_128
		p_u_128:_UpdateLayouts()
	end)
	p_u_128.PageFrame:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
		-- upvalues: (copy) p_u_128
		p_u_128:_UpdateLayouts()
	end)
	p_u_128.InfoButtonBubbleTitle:GetPropertyChangedSignal("TextBounds"):Connect(function()
		-- upvalues: (copy) p_u_128
		p_u_128:_UpdateLayouts()
	end)
	p_u_128.CloseButton.MouseButton1Click:Connect(function()
		-- upvalues: (copy) p_u_128
		p_u_128:CloseRequest()
	end)
	p_u_128.InvestigateWinStreaksButton.MouseButton1Click:Connect(function()
		-- upvalues: (ref) v_u_1
		v_u_1.Remotes.Moderator.CheckTop100Streaks:FireServer()
	end)
	p_u_128.InvestigateTrueWinStreaksButton.MouseButton1Click:Connect(function()
		-- upvalues: (ref) v_u_1
		v_u_1.Remotes.Moderator.CheckTop100TrueStreaks:FireServer()
	end)
	p_u_128.LookupButton.MouseButton1Click:Connect(function()
		-- upvalues: (copy) p_u_128
		p_u_128:_FetchBanData()
	end)
	p_u_128.LookupDropdownButton.MouseButton1Click:Connect(function()
		-- upvalues: (copy) p_u_128
		p_u_128:_PlayersLookupDropdown()
	end)
	p_u_128.InfoButton.MouseButton1Click:Connect(function()
		-- upvalues: (copy) p_u_128
		p_u_128.InfoButtonBubble.Visible = not p_u_128.InfoButtonBubble.Visible
	end)
	p_u_128.PowersButton.MouseButton1Click:Connect(function()
		-- upvalues: (copy) p_u_128
		p_u_128.PowersButtonBubble.Visible = not p_u_128.PowersButtonBubble.Visible
	end)
	p_u_128:_SetupActionButton("Moderate", function()
		-- upvalues: (copy) p_u_128
		if p_u_128._is_this_dude_banned then
			p_u_128.PromptSystem:Open("Unban", p_u_128._ban_data)
		else
			p_u_128.PromptSystem:Open("Ban", p_u_128._ban_data)
		end
	end)
	p_u_128:_SetupActionButton("ViewLogs", function()
		-- upvalues: (copy) p_u_128
		p_u_128.PromptSystem:Open("InspectBanLogs", p_u_128._ban_data)
	end)
	p_u_128:_SetupActionButton("Join", function()
		-- upvalues: (ref) v_u_1, (copy) p_u_128
		v_u_1.Remotes.Moderator.Join:FireServer(p_u_128._ban_data.Name)
	end)
	p_u_128:_SetupActionButton("Kick", function()
		-- upvalues: (copy) p_u_128
		p_u_128.PromptSystem:Open("Kick", p_u_128._ban_data)
	end)
	p_u_128:_SetupActionButton("ViewData", function()
		-- upvalues: (copy) p_u_128
		if p_u_128._result_data then
			p_u_128.PromptSystem:Open("ViewPlayerData", p_u_128._ban_data.Name, p_u_128._result_data)
		else
			p_u_128:_FetchPlayerData()
		end
	end)
	p_u_128:_SetupActionButton("Pardon", function()
		-- upvalues: (copy) p_u_128
		p_u_128.PromptSystem:Open("Pardon", p_u_128._ban_data)
	end)
	p_u_128:_SetupActionButton("Lock", function()
		-- upvalues: (ref) v_u_1, (copy) p_u_128
		v_u_1.Remotes.Moderator.LockBans:FireServer(p_u_128._ban_data.Name)
	end)
	p_u_128:_SetupActionButton("ViewActions", function()
		-- upvalues: (copy) p_u_128
		p_u_128.PromptSystem:Open("InspectActionLogs", p_u_128._ban_data)
	end)
	p_u_128:_SetupActionButton("Wipe", function()
		-- upvalues: (ref) v_u_1, (copy) p_u_128
		v_u_1.Remotes.Moderator.RemoveFromLeaderboards:FireServer(p_u_128._ban_data.Name)
	end)
	p_u_128:_SetupActionButton("Restrict", function()
		-- upvalues: (copy) p_u_128
		p_u_128.PromptSystem:Open("Restrict", p_u_128._ban_data)
	end)
	p_u_128:_SetupActionButton("Warn", function()
		-- upvalues: (copy) p_u_128
		p_u_128.PromptSystem:Open("Warn", p_u_128._ban_data)
	end)
	v_u_11:GetDataChangedSignal("PermissionsRoles"):Connect(function()
		-- upvalues: (copy) p_u_128
		p_u_128:_UpdatePermissions()
	end)
	v_u_1.Remotes.Moderator.UpdateBanData.OnClientEvent:Connect(function(p129)
		-- upvalues: (copy) p_u_128
		p_u_128:SetBanData(false, p129, p_u_128._result_data)
	end)
	p_u_128:_UpdateLayouts()
	p_u_128:_UpdatePermissions()
	p_u_128:SetBanData(true, nil, nil)
	v_u_12:Add(p_u_128.CloseButton)
	v_u_12:Add(p_u_128.InvestigateWinStreaksButton)
	v_u_12:Add(p_u_128.InvestigateTrueWinStreaksButton)
	v_u_12:Add(p_u_128.LookupButton)
	v_u_12:Add(p_u_128.LookupDropdownButton)
	v_u_12:Add(p_u_128.InfoButton)
	v_u_12:Add(p_u_128.PowersButton)
end
return v_u_18._new()