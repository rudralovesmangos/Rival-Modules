local v_u_1 = game:GetService("ReplicatedStorage")
local v2 = game:GetService("Players")
local v_u_3 = require(v_u_1.Modules.CONSTANTS)
local v_u_4 = require(v_u_1.Modules.PermissionsLibrary)
local v_u_5 = require(v_u_1.Modules.ConceptsLibrary)
local v_u_6 = require(v_u_1.Modules.Utility)
local v_u_7 = require(v2.LocalPlayer.PlayerScripts.Controllers:WaitForChild("ComplianceController"))
local v_u_8 = require(v2.LocalPlayer.PlayerScripts.Modules:WaitForChild("ButtonEffect"))
local v_u_9 = require(v2.LocalPlayer.PlayerScripts.Modules:WaitForChild("PromptSystem"))
local v_u_10 = require(v2.LocalPlayer.PlayerScripts.Modules:WaitForChild("RewardSlot"))
local v_u_11 = require(v2.LocalPlayer.PlayerScripts.Modules:WaitForChild("Page"))
local v_u_12 = v2.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("CreditsPlayerSlot")
local v13 = Color3.fromRGB(159, 25, 255)
local v_u_14 = Color3.fromRGB(46, 204, 113)
local v_u_15 = {
	{
		20349956,
		"Nosniy",
		"Owner, 3D Artist",
		v13
	},
	{
		15941965,
		"SenseiWarrior",
		"Owner, Programmer, UI/UX, SFX",
		v13
	},
	{ 780350915, "nekoanims", "Animation" },
	{ 8034104, "GreatGuyBoom", "3D Artist, 2D Artist" },
	{ 1730213868, "Brian1KB", "Matchmaking, Technical Advisor" },
	{ 13108868, "ShadowTrojan", "3D Artist, 2D Artist, Wraps Artist" },
	{ 25056711, "PrimeVoxel", "Particles" },
	{ 42477697, "D_reamz", "Renders" },
	{ 945382833, "himochu", "2D Artist" },
	{ 113947873, "LiamGame09", "Wraps Artist" },
	{ 182316511, "BSlickMusic", "Music, SFX" },
	{ 1080973296, "xlISinner", "Anticheat" },
	{ 424377859, "Kurookku", "Technical Advisor" },
	{ 4444072910, "FluxxyBoiOfficial", "Technical Developer" },
	{ 274029164, "StaredSystemized", "Graphics" },
	{ 167445091, "SoftGB", "Graphics" }
}
local v_u_16 = setmetatable({}, v_u_11)
v_u_16.__index = v_u_16
function v_u_16._new() -- name: _new
	-- upvalues: (copy) v_u_11, (copy) v_u_16, (copy) v_u_9
	local v17 = v_u_11.new(script.Name)
	local v18 = v_u_16
	local v19 = setmetatable(v17, v18)
	v19.PromptsFrame = v19.PageFrame:WaitForChild("Prompts")
	v19.PageContainer = v19.PageFrame:WaitForChild("Container")
	v19.CloseButton = v19.PageContainer:WaitForChild("Close")
	v19.List = v19.PageContainer:WaitForChild("List")
	v19.Container = v19.List:WaitForChild("Container")
	v19.Layout = v19.Container:WaitForChild("Layout")
	v19.ConceptorsFrame = v19.Container:WaitForChild("Conceptors")
	v19.ConceptorsContainer = v19.ConceptorsFrame:WaitForChild("Container")
	v19.ConceptorsPlayersFrame = v19.ConceptorsContainer:WaitForChild("Players")
	v19.ConceptorsPlayersLayout = v19.ConceptorsPlayersFrame:WaitForChild("Layout")
	v19.ConceptorsRewardFrame = v19.ConceptorsContainer:WaitForChild("Reward")
	v19.TeamFrame = v19.Container:WaitForChild("Team")
	v19.TeamEmptyFrame = v19.TeamFrame:WaitForChild("Empty")
	v19.TeamContainer = v19.TeamFrame:WaitForChild("Container")
	v19.TeamPlayersFrame = v19.TeamContainer:WaitForChild("Players")
	v19.TeamPlayersLayout = v19.TeamPlayersFrame:WaitForChild("Layout")
	v19.ContributorsFrame = v19.Container:WaitForChild("Contributors")
	v19.ContributorsEmptyFrame = v19.ContributorsFrame:WaitForChild("Empty")
	v19.ContributorsContainer = v19.ContributorsFrame:WaitForChild("Container")
	v19.ContributorsPlayersFrame = v19.ContributorsContainer:WaitForChild("Players")
	v19.ContributorsPlayersLayout = v19.ContributorsPlayersFrame:WaitForChild("Layout")
	v19.PromptSystem = v_u_9.new(v19.PromptsFrame)
	v19:_Init()
	return v19
end
function v_u_16._Update(p20) -- name: _Update
	p20.List.Size = UDim2.new(0.85, 0, 0, p20.PageFrame.AbsoluteSize.Y * 0.75)
	p20.List.CanvasSize = UDim2.new(0, 0, 0, p20.Layout.AbsoluteContentSize.Y)
	p20.ConceptorsFrame.Size = UDim2.new(1, 0, 0.1325, p20.ConceptorsPlayersLayout.AbsoluteContentSize.Y)
	p20.TeamFrame.Size = UDim2.new(1, 0, 0.1125, p20.TeamPlayersLayout.AbsoluteContentSize.Y)
	p20.ContributorsFrame.Size = UDim2.new(1, 0, 0.1125, p20.ContributorsPlayersLayout.AbsoluteContentSize.Y)
end
function v_u_16._Generate(p_u_21) -- name: _Generate
	-- upvalues: (copy) v_u_1, (copy) v_u_15, (copy) v_u_5, (copy) v_u_7, (copy) v_u_12, (copy) v_u_3, (copy) v_u_6, (copy) v_u_14, (copy) v_u_4, (copy) v_u_8
	local v22 = v_u_1.Remotes.Misc.RequestGroupMembers:InvokeServer()
	local v23 = {}
	for _, v24 in pairs(v_u_15) do
		local v25 = v24[1]
		table.insert(v23, v25)
	end
	for _, v26 in pairs(v22) do
		for _, v27 in pairs(v26) do
			table.insert(v23, v27)
		end
	end
	for _, v28 in pairs(v_u_5.Leaderboard) do
		local v29 = v28.key
		local v30 = tonumber(v29)
		table.insert(v23, v30)
	end
	local v31 = v_u_7:GetUserInfos(v23)
	local v32 = 0
	local v33
	if v_u_6:IsAprilFools() then
		local v34 = Color3.fromRGB(255, 255, 255)
		local v35 = p_u_21.ContributorsPlayersFrame
		v32 = v32 + 1
		local v36 = v_u_12:Clone()
		v36.LayoutOrder = v32
		v36.Description.Text = "Puppetmaster"
		v36.Username.Text = "00bandoboy"
		v36.Headshot.Image = "rbxassetid://129167087849991"
		v36.Background.ImageColor3 = v34
		v36.Parent = v35
		v33 = v32
	else
		v33 = v32
	end
	local v37 = {}
	for _, v38 in pairs(v_u_15) do
		local v39, _, v40, v41 = table.unpack(v38)
		local v42 = v31[tostring(v39)]
		local v43 = v42 and (v42.Username and "@" .. v42.Username) or "\226\128\162 \226\128\162 \226\128\162"
		local v44 = v41 or v_u_14
		local v45 = p_u_21.ContributorsPlayersFrame
		v32 = v33 + 1
		local v46 = v_u_12:Clone()
		v46.LayoutOrder = v32
		v46.Description.Text = v40
		v46.Username.Text = v43
		v46.Headshot.Image = string.format(v_u_3.HEADSHOT_IMAGE, v39)
		v46.Background.ImageColor3 = v44
		v46.Parent = v45
		v37[tostring(v39)] = true
		v33 = v32
	end
	for v47, v48 in pairs(v22) do
		local v49 = v_u_4.Roles[v47]
		local v50 = v_u_4.Teams[v49.TeamName]
		for _, v51 in pairs(v48) do
			if v37[tostring(v51)] then
				continue
			end
			local v52 = v31[tostring(v51)]
			local v53 = v52 and (v52.Username and "@" .. v52.Username) or "\226\128\162 \226\128\162 \226\128\162"
			local v54 = v50.TeamValue * -10000 - v49.RoleValue
			local v55 = v50.DisplayName .. " Team"
			local v56 = v50.Color
			local v57 = p_u_21.TeamPlayersFrame
			v32 = v33 + 1
			local v58 = v_u_12:Clone()
			v58.LayoutOrder = v54 or v32
			v58.Description.Text = v55
			v58.Username.Text = v53
			v58.Headshot.Image = string.format(v_u_3.HEADSHOT_IMAGE, v51)
			v58.Background.ImageColor3 = v56
			v58.Parent = v57
			v37[tostring(v51)] = true
			v33 = v32
		end
	end
	for v59, v_u_60 in pairs(v_u_5.Leaderboard) do
		local v61 = v31[v_u_60.key]
		local v_u_62 = v61 and (v61.Username and "@" .. v61.Username) or "\226\128\162 \226\128\162 \226\128\162"
		local v63 = string.format("%.1f", v_u_60.value) .. " points"
		local v64 = v_u_60.key
		local v65 = Color3.fromRGB(0, 0, 0)
		local v66 = p_u_21.ConceptorsPlayersFrame
		v32 = v33 + 1
		local v67 = v_u_12:Clone()
		v67.LayoutOrder = v32
		v67.Description.Text = v63
		v67.Username.Text = v_u_62
		v67.Headshot.Image = string.format(v_u_3.HEADSHOT_IMAGE, v64)
		v67.Background.ImageColor3 = v65
		v67.Parent = v66
		v67.LayoutOrder = v59
		v67.Button.Visible = true
		v67.Button.MouseButton1Click:Connect(function()
			-- upvalues: (copy) p_u_21, (copy) v_u_60, (copy) v_u_62
			local v68 = p_u_21.PromptSystem
			local v69 = v_u_60.key
			v68:Open("InspectConceptor", tonumber(v69), v_u_62)
		end)
		v_u_8:Add(v67.Button)
		v33 = v32
	end
end
function v_u_16._Setup(p70) -- name: _Setup
	-- upvalues: (copy) v_u_10, (copy) v_u_5
	p70.TeamEmptyFrame.Visible = false
	p70.TeamPlayersFrame.Visible = true
	p70.ContributorsEmptyFrame.Visible = false
	p70.ContributorsPlayersFrame.Visible = true
	v_u_10.new({
		["Name"] = nil,
		["Weapon"] = "IsRandom",
		["Name"] = v_u_5.CONCEPT_REWARD_NAME
	}):SetParent(p70.ConceptorsRewardFrame)
end
function v_u_16._Init(p_u_71) -- name: _Init
	-- upvalues: (copy) v_u_8
	p_u_71.CloseButton.MouseButton1Click:Connect(function()
		-- upvalues: (copy) p_u_71
		p_u_71:CloseRequest()
	end)
	p_u_71.PageFrame:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
		-- upvalues: (copy) p_u_71
		p_u_71:_Update()
	end)
	p_u_71.Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		-- upvalues: (copy) p_u_71
		p_u_71:_Update()
	end)
	p_u_71.ContributorsPlayersLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		-- upvalues: (copy) p_u_71
		p_u_71:_Update()
	end)
	p_u_71.ConceptorsPlayersLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		-- upvalues: (copy) p_u_71
		p_u_71:_Update()
	end)
	p_u_71:_Setup()
	p_u_71:_Update()
	task.defer(p_u_71._Generate, p_u_71)
	v_u_8:Add(p_u_71.CloseButton)
end
return v_u_16._new()