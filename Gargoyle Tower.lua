local v_u_1 = game:GetService("CollectionService")
local v2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("Lighting")
local v4 = game:GetService("Players")
local v_u_5 = require(v2.Modules.BetterDebris)
local v_u_6 = require(v2.Modules.Utility)
local v_u_7 = require(v4.LocalPlayer.PlayerScripts.Modules.Maps:WaitForChild("BaseTower"))
local v_u_8 = {
	["CameraAnimationID"] = "rbxassetid://91304936355794",
	["PlayersAnimationIDs"] = nil,
	["MinibossAnimationID"] = "rbxassetid://110702524889355",
	["FOVMarkers"] = nil,
	["PlayersAnimationIDs"] = {
		"rbxassetid://72779372805547",
		"rbxassetid://85372225938107",
		"rbxassetid://76166033125093",
		"rbxassetid://72705430483246"
	},
	["FOVMarkers"] = {
		{ 0, 27, true }
	}
}
local v_u_9 = {
	["CameraAnimationID"] = "rbxassetid://140630537896995",
	["PlayersAnimationIDs"] = nil,
	["MinibossAnimationID"] = "rbxassetid://119161985796057",
	["FOVMarkers"] = nil,
	["PlayersAnimationIDs"] = {
		"rbxassetid://73765092682746",
		"rbxassetid://128251419280478",
		"rbxassetid://87644263623750",
		"rbxassetid://81457379942058"
	},
	["FOVMarkers"] = {
		{ 0, 30, true },
		{ 3.117, 30, true },
		{ 5.217, 60 },
		{
			9.342,
			60,
			nil,
			Enum.EasingStyle.Linear
		},
		{ 14.333, 40 }
	}
}
local v_u_10 = {
	["Solo"] = {
		["CameraAnimationID"] = "rbxassetid://76004085070158",
		["PlayersAnimationIDs"] = nil,
		["FOVMarkers"] = nil,
		["PlayersAnimationIDs"] = { "rbxassetid://128423516380583" },
		["FOVMarkers"] = {
			{ 0, 30 }
		}
	},
	["Team"] = {
		["CameraAnimationID"] = "rbxassetid://74541276024086",
		["PlayersAnimationIDs"] = nil,
		["FOVMarkers"] = nil,
		["PlayersAnimationIDs"] = {
			"rbxassetid://87817454386868",
			"rbxassetid://85214705237146",
			"rbxassetid://85463328453593",
			"rbxassetid://83557814004483"
		},
		["FOVMarkers"] = {
			{ 0, 30 }
		}
	}
}
local v_u_11 = {
	["CameraAnimationID"] = "rbxassetid://82721596198038",
	["PlayersAnimationIDs"] = nil,
	["BossAnimationID"] = "rbxassetid://82940353328327",
	["DestructionAnimationID"] = "rbxassetid://108906257884198",
	["FOVMarkers"] = nil,
	["PlayersAnimationIDs"] = {
		"rbxassetid://132478476724070",
		"rbxassetid://87448134299264",
		"rbxassetid://125622174653361",
		"rbxassetid://115710864051370"
	},
	["FOVMarkers"] = {
		{ 0, 50, true },
		{ 4.017, 65, true },
		{ 19.333, 20, true },
		{ 20.7, 20, true },
		{ 21.533, 20 },
		{ 22.367, 20, true },
		{ 23.567, 50 },
		{ 24.533, 45, true }
	}
}
local v_u_12 = {
	["CameraAnimationID"] = "rbxassetid://124109678261806",
	["PlayersAnimationIDs"] = nil,
	["BossAnimationID"] = "rbxassetid://137814878872905",
	["FOVMarkers"] = nil,
	["PlayersAnimationIDs"] = {
		"rbxassetid://73225171387600",
		"rbxassetid://93554947024541",
		"rbxassetid://124961338872440",
		"rbxassetid://106248403628647"
	},
	["FOVMarkers"] = {
		{ 0, 60 }
	}
}
local v_u_13 = {
	"rbxassetid://105037817494559",
	"rbxassetid://85895097625020",
	"rbxassetid://107999335264095",
	"rbxassetid://72483809453170",
	"rbxassetid://129922197154277",
	"rbxassetid://113975047764762",
	"rbxassetid://119857994193720",
	"rbxassetid://128361063555965",
	"rbxassetid://79367345974451",
	"rbxassetid://130623066255489",
	"rbxassetid://89602387965260",
	"rbxassetid://134885608230805",
	"rbxassetid://104718122128210",
	"rbxassetid://134852748577803",
	"rbxassetid://85095991853139"
}
local v_u_14 = setmetatable({}, v_u_7)
v_u_14.__index = v_u_14
function v_u_14.new(...) -- name: new
	-- upvalues: (copy) v_u_7, (copy) v_u_14
	local v15 = v_u_7.new(...)
	local v16 = v_u_14
	local v17 = setmetatable(v15, v16)
	v17._cutscenes_folder = v17.Model:WaitForChild("Cutscenes")
	v17._cutscene_floor10_folder = v17._cutscenes_folder:WaitForChild("Floor10")
	v17._cutscene_floor10_camera_rig_animation_controller = v17._cutscene_floor10_folder:WaitForChild("CameraRig"):WaitForChild("AnimationController")
	v17._cutscene_floor17_folder = v17._cutscenes_folder:WaitForChild("Floor17")
	v17._cutscene_floor17_camera_rig_animation_controller = v17._cutscene_floor17_folder:WaitForChild("CameraRig"):WaitForChild("AnimationController")
	v17._cutscene_floor17_destruction_rig_animation_controller = v17._cutscene_floor17_folder:WaitForChild("DestructionRig"):WaitForChild("AnimationController")
	v17._use_custom_scoreboard_display = false
	v17._triggers_found = {}
	v17:_Init()
	return v17
end
function v_u_14.GetScoreboardDisplay(p18, ...) -- name: GetScoreboardDisplay
	-- upvalues: (copy) v_u_7
	if p18._use_custom_scoreboard_display then
		return p18.Name .. "   \226\128\162   Floor 0"
	else
		return v_u_7.GetScoreboardDisplay(p18, ...)
	end
end
function v_u_14.Update(p19, _) -- name: Update
	-- upvalues: (copy) v_u_6, (copy) v_u_1
	local v20 = v_u_6:AngleBetweenVectors(workspace.CurrentCamera.CFrame.LookVector, Vector3.new(0, 1, 0)) / 1.5707963267948966
	local v21 = math.clamp(v20, 0, 1)
	for _, v22 in pairs(v_u_1:GetTagged("GargoyleTowerRain")) do
		if not v22:IsDescendantOf(p19.Model) then
			continue
		end
		local v23 = v22:FindFirstChild("Lines")
		local v24 = v22:FindFirstChild("Dots")
		if v23 then
			v23.LocalTransparencyModifier = 1 - v21
		end
		if not v24 then
			continue
		end
		v24.LocalTransparencyModifier = v21
	end
end
function v_u_14.ReplicateFromServer(p25, p26, ...) -- name: ReplicateFromServer
	-- upvalues: (copy) v_u_7
	if p26 == "GargoyleTowerPlayCutsceneFloor10MinibossReveal" then
		if p25:IsRendered() then
			p25:_PlayCutsceneFloor10MinibossReveal(...)
		end
	elseif p26 == "GargoyleTowerPlayCutsceneFloor10MinibossDeath" then
		if p25:IsRendered() then
			p25:_PlayCutsceneFloor10MinibossDeath(...)
		end
	elseif p26 == "GargoyleTowerPlayCutsceneFloor17Intro" then
		if p25:IsRendered() then
			p25:_PlayCutsceneFloor17Intro(...)
		end
	elseif p26 == "GargoyleTowerPlayCutsceneFloor17BossReveal" then
		if p25:IsRendered() then
			p25:_PlayCutsceneFloor17BossReveal(...)
		end
	elseif p26 == "GargoyleTowerPlayCutsceneFloor17Falling" then
		if p25:IsRendered() then
			p25:_PlayCutsceneFloor17Falling(...)
		end
	else
		v_u_7.ReplicateFromServer(p25, p26, ...)
		return
	end
end
function v_u_14._PlayCutsceneFloor10MinibossDeath(p_u_27, p28, p_u_29) -- name: _PlayCutsceneFloor10MinibossDeath
	-- upvalues: (copy) v_u_9
	for _, v30 in pairs(p_u_29:GetPlayingAnimationTracks()) do
		v30:Stop(0)
	end
	p_u_27.CutsceneLogic:PlayCutscene(p28, function(_) -- name: init_callback
		-- upvalues: (copy) p_u_27, (copy) p_u_29
		p_u_27.CutsceneLogic:PlayAnimation(p_u_29, p_u_27.CutsceneLogic:GetPreloadedAnimation("GargoyleTowerFloor10MinibossDeathMiniboss"), function(_)
			-- upvalues: (ref) p_u_27
			wait(2)
			p_u_27:CreateSound("rbxassetid://85095991853139", 2 + 0.25 * math.random(), 0.7 + 0.1 * math.random(), script, true)
			p_u_27:CreateSound("rbxassetid://85095991853139", 3 + 0.25 * math.random(), 1.25 + 0.1 * math.random(), script, true)
			wait(2)
			p_u_27:CreateSound("rbxassetid://104718122128210", 1 + 0.25 * math.random(), 0.9 + 0.2 * math.random(), script, true)
			wait(0.825)
			p_u_27:CreateSound("rbxassetid://104718122128210", 1.25 + 0.25 * math.random(), 1.5 + 0.2 * math.random(), script, true)
		end)
	end, function(_) -- name: renderstep_callback end, p_u_27._cutscene_floor10_camera_rig_animation_controller, p_u_27.CutsceneLogic:GetPreloadedAnimation("GargoyleTowerFloor10MinibossDeathCamera"), v_u_9.FOVMarkers, #v_u_9.PlayersAnimationIDs, "GargoyleTowerFloor10MinibossDeathPlayer", false)
end
function v_u_14._PlayCutsceneFloor10MinibossReveal(p_u_31, p32, p_u_33) -- name: _PlayCutsceneFloor10MinibossReveal
	-- upvalues: (copy) v_u_8
	task.spawn(function()
		-- upvalues: (copy) p_u_31
		p_u_31.Model.Cutscenes.Floor10["Giant Gargoyle Statue"]:Destroy()
	end)
	p_u_31.CutsceneLogic:PlayCutscene(p32, function(_) -- name: init_callback
		-- upvalues: (copy) p_u_31, (copy) p_u_33
		p_u_31.CutsceneLogic:PlayAnimation(p_u_33, p_u_31.CutsceneLogic:GetPreloadedAnimation("GargoyleTowerFloor10MinibossRevealMiniboss"), function(_)
			-- upvalues: (ref) p_u_31
			wait(6.8)
			p_u_31:CreateSound("rbxassetid://134852748577803", 3 + 0.2 * math.random(), 0.3 + 0.05 * math.random(), script, true)
			wait(8.5)
			p_u_31:CreateSound("rbxassetid://79367345974451", 0.6 + 0.2 * math.random(), 1.25 + 0.2 * math.random(), script, true)
			p_u_31:CreateSound("rbxassetid://130623066255489", 0.6 + 0.2 * math.random(), 1.25 + 0.2 * math.random(), script, true)
			p_u_31:CreateSound("rbxassetid://89602387965260", 0.6 + 0.2 * math.random(), 1.25 + 0.2 * math.random(), script, true)
			wait(3.42)
			p_u_31:CreateSound("rbxassetid://72483809453170", 1.5 + 0.25 * math.random(), 0.9 + 0.2 * math.random(), script, true)
			wait(1.4)
			p_u_31:CreateSound("rbxassetid://104718122128210", 0.5 + 0.25 * math.random(), 0.9 + 0.2 * math.random(), script, true)
			wait(1)
			p_u_31:CreateSound("rbxassetid://85095991853139", 2.5 + 0.25 * math.random(), 0.7 + 0.1 * math.random(), script, true)
		end)
	end, function(_) -- name: renderstep_callback end, p_u_31._cutscene_floor10_camera_rig_animation_controller, p_u_31.CutsceneLogic:GetPreloadedAnimation("GargoyleTowerFloor10MinibossRevealCamera"), v_u_8.FOVMarkers, #v_u_8.PlayersAnimationIDs, "GargoyleTowerFloor10MinibossRevealPlayer", false)
end
function v_u_14._ShouldUseSoloCutsceneAnimations(p34) -- name: _ShouldUseSoloCutsceneAnimations
	local v35 = 0
	for _, v36 in pairs(p34.ClientDuel:GetFighters()) do
		v35 = v35 + (v36:IsAlive() and 1 or 0)
	end
	return v35 <= 1
end
function v_u_14._PlayCutsceneFloor17Intro(p37, p_u_38) -- name: _PlayCutsceneFloor17Intro
	-- upvalues: (copy) v_u_3, (copy) v_u_5, (copy) v_u_6, (copy) v_u_10
	local v39 = p37:_ShouldUseSoloCutsceneAnimations() and "Solo" or "Team"
	local function v42(_) -- name: init_callback
		-- upvalues: (ref) v_u_3, (ref) v_u_5, (copy) p_u_38, (ref) v_u_6
		task.delay(25, function()
			-- upvalues: (ref) v_u_3, (ref) v_u_5, (ref) p_u_38, (ref) v_u_6
			local v_u_40 = Instance.new("ColorCorrectionEffect")
			v_u_40.Name = "GargoyleTowerCutsceneFloor17Intro"
			v_u_40.Parent = v_u_3
			v_u_5:AddItem(v_u_40, p_u_38 - 25)
			v_u_6:RenderstepForLoop(0, 100, 2, function(p41)
				-- upvalues: (copy) v_u_40
				v_u_40.Brightness = 0 + -1 * (p41 / 100) ^ 4
			end)
		end)
	end
	p37.CutsceneLogic:PlayCutscene(p_u_38, v42, function(_) -- name: renderstep_callback end, p37._cutscene_floor17_camera_rig_animation_controller, p37.CutsceneLogic:GetPreloadedAnimation("GargoyleTowerFloor17Intro" .. v39 .. "Camera"), v_u_10[v39].FOVMarkers, #v_u_10[v39].PlayersAnimationIDs, "GargoyleTowerFloor17Intro" .. v39 .. "Player", false)
end
function v_u_14._PlayCutsceneFloor17BossReveal(p_u_43, p_u_44, p_u_45) -- name: _PlayCutsceneFloor17BossReveal
	-- upvalues: (copy) v_u_3, (copy) v_u_5, (copy) v_u_6, (copy) v_u_11
	task.spawn(function()
		-- upvalues: (copy) p_u_43
		p_u_43.Model.Cutscenes.Floor17["Giant Acidic Gargoyle Statue"]:Destroy()
	end)
	local function v54(p_u_46) -- name: init_callback
		-- upvalues: (copy) p_u_43, (copy) p_u_45, (copy) p_u_44, (ref) v_u_3, (ref) v_u_5, (ref) v_u_6
		p_u_43.CutsceneLogic:PlayAnimation(p_u_45, p_u_43.CutsceneLogic:GetPreloadedAnimation("GargoyleTowerFloor17BossRevealBoss"), function(_)
			-- upvalues: (ref) p_u_43
			wait(8.5)
			p_u_43:CreateSound("rbxassetid://79367345974451", 0.8 + 0.2 * math.random(), 0.9 + 0.2 * math.random(), script, true)
			p_u_43:CreateSound("rbxassetid://130623066255489", 0.8 + 0.2 * math.random(), 0.9 + 0.2 * math.random(), script, true)
			p_u_43:CreateSound("rbxassetid://89602387965260", 0.8 + 0.2 * math.random(), 0.9 + 0.2 * math.random(), script, true)
			wait(9.75)
			p_u_43:CreateSound("rbxassetid://128361063555965", 1.5 + 0.25 * math.random(), 0.9 + 0.2 * math.random(), script, true)
			wait(0.75)
			p_u_43:CreateSound("rbxassetid://128361063555965", 1.5 + 0.25 * math.random(), 0.9 + 0.2 * math.random(), script, true)
			wait(0.33)
			p_u_43:CreateSound("rbxassetid://128361063555965", 1.5 + 0.25 * math.random(), 0.9 + 0.2 * math.random(), script, true)
			wait(0.42)
			p_u_43:CreateSound("rbxassetid://128361063555965", 1.5 + 0.25 * math.random(), 0.9 + 0.2 * math.random(), script, true)
			wait(0.5)
			p_u_43:CreateSound("rbxassetid://128361063555965", 1.5 + 0.25 * math.random(), 0.9 + 0.2 * math.random(), script, true)
			wait(1.25)
			p_u_43:CreateSound("rbxassetid://128361063555965", 1.5 + 0.25 * math.random(), 0.9 + 0.2 * math.random(), script, true)
			wait(0.83)
			p_u_43:CreateSound("rbxassetid://128361063555965", 1.5 + 0.25 * math.random(), 0.9 + 0.2 * math.random(), script, true)
			wait(1.33)
			p_u_43:CreateSound("rbxassetid://128361063555965", 2.25 + 0.25 * math.random(), 1.25 + 0.2 * math.random(), script, true)
		end)
		p_u_43.CutsceneLogic:PlayAnimation(p_u_43._cutscene_floor17_destruction_rig_animation_controller, p_u_43.CutsceneLogic:GetPreloadedAnimation("GargoyleTowerFloor17BossRevealDestruction"), function(_)
			-- upvalues: (ref) p_u_43
			wait(13.65)
			p_u_43:CreateSound("rbxassetid://105037817494559", 1, 1, script, true)
			p_u_43:CreateSound("rbxassetid://85895097625020", 1, 0.75, script, true)
			wait(11.35)
			p_u_43:CreateSound("rbxassetid://107999335264095", 0.75, 1, script, true)
			p_u_43:CreateSound("rbxassetid://107999335264095", 1, 0.75, script, true)
		end)
		task.delay(13.65, function()
			-- upvalues: (copy) p_u_46, (ref) p_u_43
			if p_u_46 == p_u_43.CutsceneLogic:GetCutsceneHash() then
				p_u_43._cutscene_floor17_folder.Roof.Broken.Transparency = p_u_43._cutscene_floor17_folder.Roof.Unbroken.Transparency
				p_u_43._cutscene_floor17_folder.Roof.Unbroken.Transparency = 1
				local v47 = {}
				for _, v48 in pairs(p_u_43.Model.Extra:GetDescendants()) do
					if v48:IsA("ParticleEmitter") then
						v47[v48] = { "TimeScale", v48.TimeScale }
						v48.TimeScale = v48.TimeScale * 0.1
					else
						if not v48:IsA("Beam") then
							continue
						end
						v47[v48] = { "TextureSpeed", v48.TextureSpeed }
						v48.TextureSpeed = v48.TextureSpeed * 0.1
					end
				end
				wait(4.35)
				for v49, v50 in pairs(v47) do
					v49[v50[1]] = v50[2]
				end
			end
		end)
		task.delay(p_u_44 - 2, function()
			-- upvalues: (ref) v_u_3, (ref) v_u_5, (ref) v_u_6
			local v_u_51 = Instance.new("ColorCorrectionEffect")
			v_u_51.Name = "GargoyleTowerCutsceneFloor17BossReveal"
			v_u_51.Parent = v_u_3
			v_u_5:AddItem(v_u_51, 10)
			v_u_6:RenderstepForLoop(0, 100, 2, function(p52)
				-- upvalues: (copy) v_u_51
				v_u_51.Brightness = 0 + -1 * (p52 / 100) ^ 4
			end)
			wait(2)
			v_u_6:RenderstepForLoop(0, 100, 2, function(p53)
				-- upvalues: (copy) v_u_51
				v_u_51.Brightness = -1 + 1 * (1 - (1 - p53 / 100) ^ 4)
			end)
			v_u_51:Destroy()
		end)
	end
	p_u_43.CutsceneLogic:PlayCutscene(p_u_44, v54, function(_) -- name: renderstep_callback end, p_u_43._cutscene_floor17_camera_rig_animation_controller, p_u_43.CutsceneLogic:GetPreloadedAnimation("GargoyleTowerFloor17BossRevealCamera"), v_u_11.FOVMarkers, #v_u_11.PlayersAnimationIDs, "GargoyleTowerFloor17BossRevealPlayer", false)
end
function v_u_14._PlayCutsceneFloor17Falling(p_u_55, p_u_56, p_u_57) -- name: _PlayCutsceneFloor17Falling
	-- upvalues: (copy) v_u_3, (copy) v_u_5, (copy) v_u_6, (copy) v_u_12
	p_u_55._use_custom_scoreboard_display = true
	local function v65(_) -- name: init_callback
		-- upvalues: (copy) p_u_55, (copy) p_u_57, (copy) p_u_56, (ref) v_u_3, (ref) v_u_5, (ref) v_u_6
		p_u_55.CutsceneLogic:PlayAnimation(p_u_57, p_u_55.CutsceneLogic:GetPreloadedAnimation("GargoyleTowerFloor17FallingBoss"), function(_)
			-- upvalues: (ref) p_u_55
			local v58 = {
				0.55,
				1.3,
				1.9,
				2.45,
				2.95,
				3.45,
				3.95,
				4.3,
				4.7,
				5.1,
				5.5,
				5.9,
				6.3,
				6.7,
				7.1
			}
			for v59, v60 in pairs(v58) do
				wait(v60 - (v58[v59 - 1] or 0))
				p_u_55:CreateSound("rbxassetid://72483809453170", 1.5 - 1 * v59 / 18, 0.9 + 0.2 * math.random(), script, true)
			end
		end)
		task.delay(p_u_56 - 0.75, function()
			-- upvalues: (ref) v_u_3, (ref) v_u_5, (ref) p_u_55, (ref) v_u_6
			local v_u_61 = Instance.new("ColorCorrectionEffect")
			v_u_61.Name = "GargoyleTowerCutsceneFloor17Falling"
			v_u_61.Brightness = -1
			v_u_61.Parent = v_u_3
			v_u_5:AddItem(v_u_61, 10)
			p_u_55:CreateSound("rbxassetid://72483809453170", 1.5 + 0.25 * math.random(), 0.9 + 0.2 * math.random(), script, true)
			p_u_55:CreateSound("rbxassetid://129922197154277", 1.5 + 0.25 * math.random(), 0.9 + 0.2 * math.random(), script, true)
			p_u_55:CreateSound("rbxassetid://113975047764762", 1.5 + 0.25 * math.random(), 0.9 + 0.2 * math.random(), script, true)
			wait(1)
			v_u_6:RenderstepForLoop(0, 100, 0.5, function(p62)
				-- upvalues: (copy) v_u_61
				local v63 = p62 / 100
				local v64 = 12.566370614359172 * v63
				v_u_61.Brightness = -1 + 1 * (math.sin(v64) * 0.125 + v63)
			end)
			v_u_61:Destroy()
		end)
	end
	p_u_55.CutsceneLogic:PlayCutscene(p_u_56, v65, function(_) -- name: renderstep_callback end, p_u_55._cutscene_floor17_camera_rig_animation_controller, p_u_55.CutsceneLogic:GetPreloadedAnimation("GargoyleTowerFloor17FallingCamera"), v_u_12.FOVMarkers, #v_u_12.PlayersAnimationIDs, "GargoyleTowerFloor17FallingPlayer", false)
end
function v_u_14._Floor17LeverTriggerAdded(p_u_66, p_u_67) -- name: _Floor17LeverTriggerAdded
	-- upvalues: (copy) v_u_6
	if not p_u_66._triggers_found[p_u_67] and p_u_67:IsDescendantOf(p_u_66.Model) then
		p_u_66._triggers_found[p_u_67] = true
		local v_u_68 = false
		local function v76() -- name: check
			-- upvalues: (ref) v_u_68, (copy) p_u_67, (copy) p_u_66, (ref) v_u_6
			if not v_u_68 and p_u_67:GetAttribute("Triggered") then
				v_u_68 = true
				p_u_66.Model.Cutscenes.Floor17.Lever:PivotTo(p_u_66.Model.Cutscenes.Floor17.Lever:GetPivot() * CFrame.Angles(-1.1344640137963142, 0, 0))
				p_u_66.Model.Cutscenes.Floor17.Lever.Particles:Destroy()
				p_u_66:CreateSound("rbxassetid://119857994193720", 1.25, 1, script, true)
				local v_u_69 = {}
				for _, v70 in pairs(p_u_66.Model.Cutscenes.Floor17.AcidTubes:GetChildren()) do
					local v71 = { v70, v70.Size, v70.CFrame }
					table.insert(v_u_69, v71)
				end
				v_u_6:RenderstepForLoop(0, 100, 0.1, function(p72)
					-- upvalues: (copy) v_u_69
					local v73 = 1 - p72 / 100
					for _, v74 in pairs(v_u_69) do
						v74[1].Size = v74[2] * Vector3.new(v73, 1, 1)
						v74[1].CFrame = v74[3] * CFrame.new(v74[2].X / 2 - v74[1].Size.X / 2, 0, 0)
					end
				end)
				for _, v75 in pairs(v_u_69) do
					v75[1].Transparency = 1
				end
			end
		end
		p_u_67:GetAttributeChangedSignal("Triggered"):Connect(v76)
		v76()
	end
end
function v_u_14._Floor15GateTriggerAdded(p_u_77, p_u_78) -- name: _Floor15GateTriggerAdded
	if not p_u_77._triggers_found[p_u_78] and p_u_78:IsDescendantOf(p_u_77.Model) then
		p_u_77._triggers_found[p_u_78] = true
		local v_u_79 = false
		local function v80() -- name: check
			-- upvalues: (ref) v_u_79, (copy) p_u_78, (copy) p_u_77
			if not v_u_79 and p_u_78:GetAttribute("Triggered") then
				v_u_79 = true
				p_u_77.Model.Floors["15"].Important.Gates:PivotTo(p_u_77.Model.Floors["15"].Important.Gates:GetPivot() + Vector3.new(0, 20, 0))
				p_u_77:CreateSound("rbxassetid://134885608230805", 2, 1, script, true)
			end
		end
		p_u_78:GetAttributeChangedSignal("Triggered"):Connect(v80)
		v80()
	end
end
function v_u_14._Floor11EntranceParticlesAdded(p81, p82) -- name: _Floor11EntranceParticlesAdded
	-- upvalues: (copy) v_u_6
	if p82:IsDescendantOf(p81.Model) then
		task.delay(0, v_u_6.PlayParticles, v_u_6, p82)
		p81:CreateSound("rbxassetid://72483809453170", 1.5, 0.9 + 0.2 * math.random(), script, true)
	end
end
function v_u_14._Setup(p83) -- name: _Setup
	-- upvalues: (copy) v_u_8, (copy) v_u_9, (copy) v_u_10, (copy) v_u_11, (copy) v_u_12, (copy) v_u_13
	p83.CutsceneLogic:PreloadAnimation("GargoyleTowerFloor10MinibossRevealCamera", v_u_8.CameraAnimationID)
	p83.CutsceneLogic:PreloadAnimation("GargoyleTowerFloor10MinibossRevealMiniboss", v_u_8.MinibossAnimationID)
	for v84, v85 in pairs(v_u_8.PlayersAnimationIDs) do
		p83.CutsceneLogic:PreloadAnimation("GargoyleTowerFloor10MinibossRevealPlayer" .. v84, v85)
	end
	p83.CutsceneLogic:PreloadAnimation("GargoyleTowerFloor10MinibossDeathCamera", v_u_9.CameraAnimationID)
	p83.CutsceneLogic:PreloadAnimation("GargoyleTowerFloor10MinibossDeathMiniboss", v_u_9.MinibossAnimationID)
	for v86, v87 in pairs(v_u_9.PlayersAnimationIDs) do
		p83.CutsceneLogic:PreloadAnimation("GargoyleTowerFloor10MinibossDeathPlayer" .. v86, v87)
	end
	p83.CutsceneLogic:PreloadAnimation("GargoyleTowerFloor17IntroSoloCamera", v_u_10.Solo.CameraAnimationID)
	for v88, v89 in pairs(v_u_10.Solo.PlayersAnimationIDs) do
		p83.CutsceneLogic:PreloadAnimation("GargoyleTowerFloor17IntroSoloPlayer" .. v88, v89)
	end
	p83.CutsceneLogic:PreloadAnimation("GargoyleTowerFloor17IntroTeamCamera", v_u_10.Team.CameraAnimationID)
	for v90, v91 in pairs(v_u_10.Team.PlayersAnimationIDs) do
		p83.CutsceneLogic:PreloadAnimation("GargoyleTowerFloor17IntroTeamPlayer" .. v90, v91)
	end
	p83.CutsceneLogic:PreloadAnimation("GargoyleTowerFloor17BossRevealCamera", v_u_11.CameraAnimationID)
	p83.CutsceneLogic:PreloadAnimation("GargoyleTowerFloor17BossRevealBoss", v_u_11.BossAnimationID)
	p83.CutsceneLogic:PreloadAnimation("GargoyleTowerFloor17BossRevealDestruction", v_u_11.DestructionAnimationID)
	for v92, v93 in pairs(v_u_11.PlayersAnimationIDs) do
		p83.CutsceneLogic:PreloadAnimation("GargoyleTowerFloor17BossRevealPlayer" .. v92, v93)
	end
	p83.CutsceneLogic:PreloadAnimation("GargoyleTowerFloor17FallingCamera", v_u_12.CameraAnimationID)
	p83.CutsceneLogic:PreloadAnimation("GargoyleTowerFloor17FallingBoss", v_u_12.BossAnimationID)
	for v94, v95 in pairs(v_u_12.PlayersAnimationIDs) do
		p83.CutsceneLogic:PreloadAnimation("GargoyleTowerFloor17FallingPlayer" .. v94, v95)
	end
	p83.CutsceneLogic:PreloadCutsceneSoundIDs(v_u_13)
end
function v_u_14._Init(p_u_96) -- name: _Init
	-- upvalues: (copy) v_u_1
	local v97 = p_u_96._connections
	local v98 = v_u_1:GetInstanceAddedSignal("GargoyleTowerFloor17LeverTrigger")
	table.insert(v97, v98:Connect(function(p99)
		-- upvalues: (copy) p_u_96
		p_u_96:_Floor17LeverTriggerAdded(p99)
	end))
	local v100 = p_u_96._connections
	local v101 = v_u_1:GetInstanceAddedSignal("GargoyleTowerFloor15GateTrigger")
	table.insert(v100, v101:Connect(function(p102)
		-- upvalues: (copy) p_u_96
		p_u_96:_Floor15GateTriggerAdded(p102)
	end))
	local v103 = p_u_96._connections
	local v104 = v_u_1:GetInstanceAddedSignal("GargoyleTowerFloor11EntranceParticles")
	table.insert(v103, v104:Connect(function(p105)
		-- upvalues: (copy) p_u_96
		p_u_96:_Floor11EntranceParticlesAdded(p105)
	end))
	for _, v106 in pairs(v_u_1:GetTagged("GargoyleTowerFloor17LeverTrigger")) do
		task.defer(p_u_96._Floor17LeverTriggerAdded, p_u_96, v106)
	end
	for _, v107 in pairs(v_u_1:GetTagged("GargoyleTowerFloor15GateTrigger")) do
		task.defer(p_u_96._Floor15GateTriggerAdded, p_u_96, v107)
	end
	for _, v108 in pairs(v_u_1:GetTagged("GargoyleTowerFloor11EntranceParticles")) do
		task.defer(p_u_96._Floor11EntranceParticlesAdded, p_u_96, v108)
	end
	p_u_96:_Setup()
	p_u_96.ClientDuel:SetReplicate("DuelMusic", "GargoyleTower")
end
return v_u_14