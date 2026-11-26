local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("GuiService")
local v3 = game:GetService("Players")
local v_u_4 = require(v1.Modules.Utility)
local v_u_5 = require(v3.LocalPlayer.PlayerScripts.Modules.UserInterface.EliminatedEffect)
local v_u_6 = require(v3.LocalPlayer.PlayerScripts.Modules.UserInterface.Pages)
local v_u_7 = require(v3.LocalPlayer.PlayerScripts.Modules.UserInterface.Inset)
local v_u_8 = require(v3.LocalPlayer.PlayerScripts.Modules.UILibrary)
local v_u_9 = require(script:WaitForChild("EliminationFeed"))
local v_u_10 = require(script:WaitForChild("HardcoreParkour"))
local v_u_11 = require(script:WaitForChild("FinalResults"))
local v_u_12 = require(script:WaitForChild("RoundResult"))
local v_u_13 = require(script:WaitForChild("StoryDialog"))
local v_u_14 = require(script:WaitForChild("MatchPoint"))
local v_u_15 = require(script:WaitForChild("Scoreboard"))
local v_u_16 = require(script:WaitForChild("HeadHoncho"))
local v_u_17 = require(script:WaitForChild("Buttons"))
local v_u_18 = require(script:WaitForChild("Scores"))
local v_u_19 = require(script:WaitForChild("Voting"))
local v_u_20 = require(script:WaitForChild("UpNext"))
local v_u_21 = require(script:WaitForChild("Timer"))
local v_u_22 = v3.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("DuelInterface")
local v_u_23 = {}
v_u_23.__index = v_u_23
function v_u_23.new(p24) -- name: new
	-- upvalues: (copy) v_u_23, (copy) v_u_22, (copy) v_u_11, (copy) v_u_19, (copy) v_u_9, (copy) v_u_15, (copy) v_u_12, (copy) v_u_14, (copy) v_u_18, (copy) v_u_21, (copy) v_u_20, (copy) v_u_16, (copy) v_u_10, (copy) v_u_13, (copy) v_u_17
	local v25 = v_u_23
	local v26 = setmetatable({}, v25)
	v26.ClientDuel = p24
	v26.Frame = v_u_22:Clone()
	v26.FinalResults = v_u_11.new(v26)
	v26.Voting = v_u_19.new(v26)
	v26.EliminationFeed = v_u_9.new(v26)
	v26.Scoreboard = v_u_15.new(v26)
	v26.RoundResult = v_u_12.new(v26)
	v26.MatchPoint = v_u_14.new(v26)
	v26.Scores = v_u_18.new(v26)
	v26.Timer = v_u_21.new(v26)
	v26.UpNext = v_u_20.new(v26)
	v26.HeadHoncho = v_u_16.new(v26)
	v26.HardcoreParkour = v_u_10.new(v26)
	v26.StoryDialog = v_u_13.new(v26)
	v26.Buttons = v_u_17.new(v26)
	v26._destroyed = false
	v26._connections = {}
	v26._sounds = {}
	v26._client_duelers = {}
	v26:_Init()
	return v26
end
function v_u_23.IsActive(p27) -- name: IsActive
	return p27.Frame.Visible
end
function v_u_23.IsPageOpen(_) -- name: IsPageOpen
	-- upvalues: (copy) v_u_6
	return v_u_6.PageSystem.CurrentPage ~= nil
end
function v_u_23.GetLoggedClientDuelers(p28, p29) -- name: GetLoggedClientDuelers
	if p28.ClientDuel:Get("ArcadeMode") then
		local v30 = {}
		for v31 in pairs(p28._client_duelers) do
			if table.find(p28.ClientDuel.Duelers, v31) then
				continue
			end
			v30[v31] = true
		end
		for v32 in pairs(v30) do
			p28._client_duelers[v32] = nil
		end
	end
	if not p29 then
		return p28._client_duelers
	end
	local v33 = {}
	for v34 in pairs(p28._client_duelers) do
		local v35 = {
			["ClientDueler"] = v34
		}
		local v36
		if p28.ClientDuel:Get("ArcadeMode") then
			if p28.ClientDuel:Get("ScoresBehavior") == "Duelers" then
				v36 = p28.ClientDuel:Get("Scores")[v34:Get("DuelerID")] or -1
			else
				v36 = p28.ClientDuel:Get("ScoresBehavior") == "Teams" and (p28.ClientDuel:Get("Scores")[v34:Get("TeamID")] or -1) or false
			end
		else
			v36 = -1
		end
		v35.Score = v36
		v35.Damage = v34:Get("Damage") or -1
		v35.DamageTaken = v34:Get("DamageTaken") or -1
		table.insert(v33, v35)
	end
	table.sort(v33, function(p37, p38)
		local v39 = p37.Score or -1
		local v40 = p38.Score or -1
		local v41 = v39 - v40
		if math.abs(v41) > 0.01 then
			return v40 < v39
		else
			local v42 = p37.Damage or -1
			local v43 = p38.Damage or -1
			local v44 = v42 - v43
			if math.abs(v44) > 0.01 then
				return v43 < v42
			else
				return (p37.DamageTaken or -1) < (p38.DamageTaken or -1)
			end
		end
	end)
	local v45 = {}
	for _, v46 in pairs(v33) do
		local v47 = v46.ClientDueler
		table.insert(v45, v47)
	end
	return v45
end
function v_u_23.CreateSound(p48, ...) -- name: CreateSound
	-- upvalues: (copy) v_u_4
	if p48:IsActive() then
		local v49 = v_u_4:CreateSound(...)
		local v50 = p48._sounds
		table.insert(v50, v49)
		return v49
	end
end
function v_u_23.RawCreateSound(p51, ...) -- name: RawCreateSound
	local v52 = p51:CreateSound(...)
	local v53
	if v52 then
		v53 = table.find(p51._sounds, v52)
	else
		v53 = v52
	end
	if v53 then
		table.remove(p51._sounds, v53)
	end
	return v52
end
function v_u_23.Destroy(p54) -- name: Destroy
	p54._destroyed = true
	for _, v55 in pairs(p54._connections) do
		v55:Disconnect()
	end
	for _, v56 in pairs(p54._sounds) do
		v56:Destroy()
	end
	p54._client_duelers = {}
	p54.EliminationFeed:Destroy()
	p54.HardcoreParkour:Destroy()
	p54.FinalResults:Destroy()
	p54.StoryDialog:Destroy()
	p54.RoundResult:Destroy()
	p54.MatchPoint:Destroy()
	p54.Scoreboard:Destroy()
	p54.HeadHoncho:Destroy()
	p54.Buttons:Destroy()
	p54.Scores:Destroy()
	p54.Voting:Destroy()
	p54.UpNext:Destroy()
	p54.Timer:Destroy()
	p54.Frame:Destroy()
end
function v_u_23._UpdateSpectating(p_u_57) -- name: _UpdateSpectating
	-- upvalues: (copy) v_u_2, (copy) v_u_5, (copy) v_u_6, (copy) v_u_7
	for _, v58 in pairs(p_u_57._connections) do
		v58:Disconnect()
	end
	p_u_57._connections = {}
	p_u_57.Frame.Visible = p_u_57.ClientDuel:Get("IsSpectating")
	p_u_57.HardcoreParkour:Update()
	if p_u_57.Frame.Visible then
		local v59 = p_u_57._connections
		local v60 = p_u_57.ClientDuel.DuelerRemoved
		table.insert(v59, v60:Connect(function(p61)
			-- upvalues: (copy) p_u_57
			if p_u_57.ClientDuel:Get("ArcadeMode") then
				p_u_57._client_duelers[p61] = nil
			end
			p_u_57.Scoreboard:Generate()
		end))
		local v62 = p_u_57._connections
		local v63 = p_u_57.ClientDuel:GetDataChangedSignal("MaxMapBansPerTeam")
		table.insert(v62, v63:Connect(function()
			-- upvalues: (copy) p_u_57
			p_u_57.Voting:Generate()
		end))
		local v64 = p_u_57._connections
		local v65 = p_u_57.ClientDuel:GetDataChangedSignal("VoteBansRemaining")
		table.insert(v64, v65:Connect(function()
			-- upvalues: (copy) p_u_57
			p_u_57.Voting:Generate()
		end))
		local v66 = p_u_57._connections
		local v67 = p_u_57.ClientDuel:GetDataChangedSignal("VoteOptions")
		table.insert(v66, v67:Connect(function()
			-- upvalues: (copy) p_u_57
			p_u_57.Voting:Generate()
			p_u_57.Timer:UpdateSizeAndPosition()
			p_u_57.Scores:Generate()
		end))
		local v68 = p_u_57._connections
		local v69 = p_u_57.ClientDuel:GetDataChangedSignal("ScoreNeededToWin")
		table.insert(v68, v69:Connect(function()
			-- upvalues: (copy) p_u_57
			p_u_57.Scores:Generate()
		end))
		local v70 = p_u_57._connections
		local v71 = p_u_57.ClientDuel:GetDataChangedSignal("ScoresBehavior")
		table.insert(v70, v71:Connect(function()
			-- upvalues: (copy) p_u_57
			p_u_57.Scores:Generate()
		end))
		local v72 = p_u_57._connections
		local v73 = p_u_57.ClientDuel:GetDataChangedSignal("Status")
		table.insert(v72, v73:Connect(function()
			-- upvalues: (copy) p_u_57
			p_u_57.Buttons:Update()
			p_u_57.Scoreboard:Open()
			p_u_57.HeadHoncho:Update()
			p_u_57.HardcoreParkour:Update()
			p_u_57.StoryDialog:Update()
			p_u_57.UpNext:Update()
			if p_u_57.ClientDuel:Get("ArcadeMode") and p_u_57.ClientDuel:Get("Status") == "GameOver" then
				p_u_57:CreateSound("rbxassetid://99135525400251", 2, 1, script, true, 5)
			end
		end))
		local v74 = p_u_57._connections
		local v75 = p_u_57.ClientDuel:GetDataChangedSignal("CanSwitchItems")
		table.insert(v74, v75:Connect(function()
			-- upvalues: (copy) p_u_57
			p_u_57.Buttons:Update()
		end))
		local v76 = p_u_57._connections
		local v77 = p_u_57.ClientDuel:GetDataChangedSignal("RoundNum")
		table.insert(v76, v77:Connect(function()
			-- upvalues: (copy) p_u_57
			p_u_57.Buttons:Update()
		end))
		local v78 = p_u_57._connections
		local v79 = p_u_57.ClientDuel:GetDataChangedSignal("CanTrackStatistics")
		table.insert(v78, v79:Connect(function()
			-- upvalues: (copy) p_u_57
			p_u_57.Buttons:Update()
		end))
		local v80 = p_u_57._connections
		local v81 = p_u_57.ClientDuel:GetDataChangedSignal("RematchCount")
		table.insert(v80, v81:Connect(function()
			-- upvalues: (copy) p_u_57
			p_u_57.FinalResults.Buttons:Update()
		end))
		local v82 = p_u_57._connections
		local v83 = p_u_57.ClientDuel:GetDataChangedSignal("RematchGoal")
		table.insert(v82, v83:Connect(function()
			-- upvalues: (copy) p_u_57
			p_u_57.FinalResults.Buttons:Update()
		end))
		local v84 = p_u_57._connections
		local v85 = p_u_57.ClientDuel:GetDataChangedSignal("RematchAvailable")
		table.insert(v84, v85:Connect(function()
			-- upvalues: (copy) p_u_57
			p_u_57.FinalResults.Buttons:Update()
		end))
		local v86 = p_u_57._connections
		local v87 = p_u_57.ClientDuel:GetDataChangedSignal("RematchSuccess")
		table.insert(v86, v87:Connect(function()
			-- upvalues: (copy) p_u_57
			p_u_57.FinalResults.Buttons:Update()
		end))
		local v88 = p_u_57._connections
		local v89 = p_u_57.ClientDuel:GetDataChangedSignal("StaggeredSpawnsOrder")
		table.insert(v88, v89:Connect(function()
			-- upvalues: (copy) p_u_57
			p_u_57.Scoreboard:Generate()
			p_u_57.UpNext:Update()
			p_u_57.Buttons:Update()
		end))
		local v90 = p_u_57._connections
		local v91 = p_u_57.ClientDuel:GetDataChangedSignal("HideMostDuelInterfaceElements")
		table.insert(v90, v91:Connect(function()
			-- upvalues: (copy) p_u_57
			p_u_57.Timer:Update()
			p_u_57.Scores:UpdateVisibility()
		end))
		local v92 = p_u_57._connections
		local v93 = v_u_2:GetPropertyChangedSignal("PreferredTransparency")
		table.insert(v92, v93:Connect(function()
			-- upvalues: (copy) p_u_57
			p_u_57.Scoreboard:UpdatePreferredTransparency()
		end))
		local v94 = p_u_57._connections
		local v95 = v_u_5.VisibilityChanged
		table.insert(v94, v95:Connect(function()
			-- upvalues: (copy) p_u_57
			p_u_57.UpNext:Update()
		end))
		local v96 = p_u_57._connections
		local v97 = v_u_6.PageSystem.PagesActivity
		table.insert(v96, v97:Connect(function()
			-- upvalues: (copy) p_u_57
			p_u_57.Buttons:Update()
			p_u_57.Scores:UpdateVisibility()
			p_u_57.EliminationFeed:Update()
			p_u_57.Timer:Update()
			p_u_57.Scoreboard:Open()
			p_u_57.Voting:Generate()
			p_u_57.RoundResult:UpdateVisibility()
			p_u_57.FinalResults:UpdateVisibility()
			p_u_57.HeadHoncho:Update()
			p_u_57.HardcoreParkour:Update()
			p_u_57.StoryDialog:Update()
		end))
		local v98 = p_u_57._connections
		local v99 = v_u_7.MainFrame:GetPropertyChangedSignal("AbsoluteSize")
		table.insert(v98, v99:Connect(function()
			-- upvalues: (copy) p_u_57
			p_u_57.EliminationFeed:UpdatePosition()
		end))
		local function v107(p100, _) -- name: map_added
			-- upvalues: (copy) p_u_57
			local v101 = p_u_57._connections
			local v102 = p100:GetDataChangedSignal("ObbyStartPosition")
			local function v103()
				-- upvalues: (ref) p_u_57
				p_u_57.HardcoreParkour:Update()
			end
			table.insert(v101, v102:Connect(v103))
			local v104 = p_u_57._connections
			local v105 = p100:GetDataChangedSignal("ObbyFinishPosition")
			local function v106()
				-- upvalues: (ref) p_u_57
				p_u_57.HardcoreParkour:Update()
			end
			table.insert(v104, v105:Connect(v106))
			p_u_57.HardcoreParkour:Update()
		end
		local v108 = p_u_57._connections
		local v109 = p_u_57.ClientDuel.MapAdded
		table.insert(v108, v109:Connect(v107))
		if p_u_57.ClientDuel.Map then
			task.spawn(v107, p_u_57.ClientDuel.Map, true)
		end
		local function v166(p_u_110, p111) -- name: dueler_added
			-- upvalues: (copy) p_u_57
			local v112 = p_u_57._connections
			local v113 = p_u_110:GetDataChangedSignal("LastVote")
			local function v114()
				-- upvalues: (ref) p_u_57
				p_u_57.Voting:Generate()
			end
			table.insert(v112, v113:Connect(v114))
			local v115 = p_u_57._connections
			local v116 = p_u_110:GetDataChangedSignal("IsHeadHoncho")
			local function v117()
				-- upvalues: (ref) p_u_57
				p_u_57.HeadHoncho:Update()
			end
			table.insert(v115, v116:Connect(v117))
			local v118 = p_u_57._connections
			local v119 = p_u_110:GetDataChangedSignal("Eliminations")
			local function v120()
				-- upvalues: (ref) p_u_57
				p_u_57.Scoreboard:Generate()
			end
			table.insert(v118, v119:Connect(v120))
			local v121 = p_u_57._connections
			local v122 = p_u_110:GetDataChangedSignal("Deaths")
			local function v123()
				-- upvalues: (ref) p_u_57
				p_u_57.Scoreboard:Generate()
			end
			table.insert(v121, v122:Connect(v123))
			local v124 = p_u_57._connections
			local v125 = p_u_110:GetDataChangedSignal("Assists")
			local function v126()
				-- upvalues: (ref) p_u_57
				p_u_57.Scoreboard:Generate()
			end
			table.insert(v124, v125:Connect(v126))
			local v127 = p_u_57._connections
			local v128 = p_u_110:GetDataChangedSignal("Damage")
			local function v129()
				-- upvalues: (ref) p_u_57
				p_u_57.Scoreboard:Generate()
			end
			table.insert(v127, v128:Connect(v129))
			local v130 = p_u_57._connections
			local v131 = p_u_110.ItemAdded
			local function v132()
				-- upvalues: (ref) p_u_57
				p_u_57.Scoreboard:Generate()
			end
			table.insert(v130, v131:Connect(v132))
			local v133 = p_u_57._connections
			local v134 = p_u_110.ItemRemoved
			local function v135()
				-- upvalues: (ref) p_u_57
				p_u_57.Scoreboard:Generate()
			end
			table.insert(v133, v134:Connect(v135))
			local v136 = p_u_57._connections
			local v137 = p_u_110.Died
			local function v138()
				-- upvalues: (ref) p_u_57, (copy) p_u_110
				p_u_57.UpNext:Update()
				if p_u_110.IsLocalPlayer then
					p_u_57.Buttons:Update()
				end
			end
			table.insert(v136, v137:Connect(v138))
			local v139 = p_u_57._connections
			local v140 = p_u_110.EntityAdded
			local function v141()
				-- upvalues: (ref) p_u_57, (copy) p_u_110
				p_u_57.UpNext:Update()
				if p_u_110.IsLocalPlayer then
					p_u_57.Buttons:Update()
				end
			end
			table.insert(v139, v140:Connect(v141))
			local v142 = p_u_57._connections
			local v143 = p_u_110.HealthChanged
			local function v144()
				-- upvalues: (ref) p_u_57, (copy) p_u_110
				p_u_57.Scoreboard:Generate()
				p_u_57.UpNext:Update()
				if p_u_110.IsLocalPlayer then
					p_u_57.Buttons:Update()
				end
			end
			table.insert(v142, v143:Connect(v144))
			local v145 = p_u_57._connections
			local v146 = p_u_110.ClientFighter:GetDataChangedSignal("ConnectionLevel")
			local function v147()
				-- upvalues: (ref) p_u_57
				p_u_57.Scoreboard:Generate()
			end
			table.insert(v145, v146:Connect(v147))
			if p_u_110.IsLocalPlayer then
				local v148 = p_u_57._connections
				local v149 = p_u_110:GetDataChangedSignal("SwitchItemsCount")
				local function v150()
					-- upvalues: (ref) p_u_57
					p_u_57.Buttons:Update()
				end
				table.insert(v148, v149:Connect(v150))
				local v151 = p_u_57._connections
				local v152 = p_u_110:GetDataChangedSignal("SwitchItemsMax")
				local function v153()
					-- upvalues: (ref) p_u_57
					p_u_57.Buttons:Update()
				end
				table.insert(v151, v152:Connect(v153))
				local v154 = p_u_57._connections
				local v155 = p_u_110:GetDataChangedSignal("TeamID")
				local function v156()
					-- upvalues: (ref) p_u_57
					p_u_57.Scores:Generate()
				end
				table.insert(v154, v155:Connect(v156))
				local v157 = p_u_57._connections
				local v158 = p_u_110.ClientFighter:GetDataChangedSignal("CanPickWeapons")
				local function v159()
					-- upvalues: (ref) p_u_57
					p_u_57.Buttons:Update()
				end
				table.insert(v157, v158:Connect(v159))
				local v160 = p_u_57._connections
				local v161 = p_u_110.ClientFighter:GetDataChangedSignal("LastPickedWeapons")
				local function v162()
					-- upvalues: (ref) p_u_57
					p_u_57.Buttons:Update()
				end
				table.insert(v160, v161:Connect(v162))
				local v163 = p_u_57._connections
				local v164 = p_u_110.ClientFighter.InvincibilityChanged
				local function v165()
					-- upvalues: (ref) p_u_57
					p_u_57.Buttons:Update()
				end
				table.insert(v163, v164:Connect(v165))
			end
			p_u_57._client_duelers[p_u_110] = true
			if not p111 then
				p_u_57.Buttons:Update()
				p_u_57.Scoreboard:Generate()
				p_u_57.StoryDialog:Update()
				if p_u_110.IsLocalPlayer then
					p_u_57.Scores:Generate()
				end
			end
		end
		local v167 = p_u_57._connections
		local v168 = p_u_57.ClientDuel.DuelerAdded
		table.insert(v167, v168:Connect(v166))
		for _, v169 in pairs(p_u_57.ClientDuel.Duelers) do
			task.spawn(v166, v169, true)
		end
		p_u_57.Buttons:Update()
		p_u_57.Scores:UpdateVisibility()
		p_u_57.Scores:Generate()
		p_u_57.Voting:Generate()
		p_u_57.Timer:UpdateSizeAndPosition()
		p_u_57.Timer:Update()
		p_u_57.Scoreboard:Generate()
		p_u_57.Scoreboard:UpdatePreferredTransparency()
		p_u_57.Scoreboard:Open(false)
		p_u_57.EliminationFeed:Update()
		p_u_57.RoundResult:UpdateVisibility()
		p_u_57.FinalResults:UpdateVisibility()
		p_u_57.UpNext:Update()
		p_u_57.HeadHoncho:Update()
		p_u_57.HardcoreParkour:Update()
		p_u_57.StoryDialog:Update()
	end
end
function v_u_23._Setup(p170) -- name: _Setup
	-- upvalues: (copy) v_u_8
	p170.Frame.Visible = false
	p170.Frame.Parent = v_u_8:GetTo("MainFrame", "DuelInterfaces")
end
function v_u_23._Init(p_u_171) -- name: _Init
	p_u_171.ClientDuel:GetDataChangedSignal("IsSpectating"):Connect(function()
		-- upvalues: (copy) p_u_171
		p_u_171:_UpdateSpectating()
	end)
	p_u_171:_Setup()
	task.spawn(p_u_171._UpdateSpectating, p_u_171)
end
return v_u_23