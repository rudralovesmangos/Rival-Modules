local v1 = game:GetService("ReplicatedStorage")
local v2 = game:GetService("Players")
local v_u_3 = require(v1.Modules.BetterDebris)
local v_u_4 = require(v1.Modules.Utility)
local v_u_5 = require(v2.LocalPlayer.PlayerScripts.Modules.Maps:WaitForChild("BaseTower"))
local v_u_6 = v2.LocalPlayer.PlayerScripts.Assets.Misc:WaitForChild("ChickenTrojanExplosionEffect")
local v_u_7 = {
	"rbxassetid://98587858115094",
	"rbxassetid://72483809453170",
	"rbxassetid://129922197154277",
	"rbxassetid://113975047764762",
	"rbxassetid://121368500414901"
}
local v_u_8 = {
	"rbxassetid://116380542394210",
	"rbxassetid://125379277208360",
	"rbxassetid://96610433230092",
	"rbxassetid://122643453923681",
	"rbxassetid://94468135009167",
	"rbxassetid://133107467882960",
	"rbxassetid://122210005572726",
	"rbxassetid://102260065267741"
}
local v_u_9 = {
	{ 0, 24 },
	{ 9.97, 24 },
	{ 10.53, 17 },
	{ 10.87, 17 },
	{ 11.62, 30 },
	{ 11.83, 30 },
	{ 12.55, 17 },
	{ 13.03, 30 },
	{ 16.52, 30 },
	{ 17.53, 10 },
	{ 19.12, 30, true },
	{ 22.9, 50 },
	{ 23.4, 20 },
	{ 24.58, 50 },
	{ 26.02, 35 }
}
local v_u_10 = setmetatable({}, v_u_5)
v_u_10.__index = v_u_10
function v_u_10.new(...) -- name: new
	-- upvalues: (copy) v_u_5, (copy) v_u_10
	local v11 = v_u_5.new(...)
	local v12 = v_u_10
	local v13 = setmetatable(v11, v12)
	v13:_Init()
	return v13
end
function v_u_10.ReplicateFromServer(p14, p15, ...) -- name: ReplicateFromServer
	-- upvalues: (copy) v_u_5
	if p15 == "ChickenTrojanEffect" then
		if p14:IsRendered() then
			p14:_ChickenTrojanEffect(...)
		end
	elseif p15 == "GiantChombieCutscene" then
		if p14:IsRendered() then
			p14:_PlayCutscene(...)
		end
	else
		v_u_5.ReplicateFromServer(p14, p15, ...)
		return
	end
end
function v_u_10._PlayCutscene(p_u_16, p_u_17, p_u_18, p19) -- name: _PlayCutscene
	-- upvalues: (copy) v_u_4, (copy) v_u_9, (copy) v_u_8
	local function v20(_) -- name: init_callback
		-- upvalues: (copy) p_u_16, (copy) p_u_17, (ref) v_u_4, (copy) p_u_18
		p_u_16.CutsceneLogic:PlayAnimation(p_u_17, p_u_16.CutsceneLogic:GetPreloadedAnimation("GiantChombieHumanoid"), function(_)
			-- upvalues: (ref) v_u_4, (ref) p_u_18, (ref) p_u_16
			task.delay(23.1, v_u_4.PlayParticles, v_u_4, p_u_18:WaitForChild("SlamParticles"))
			wait(1.25)
			p_u_16:CreateSound("rbxassetid://72483809453170", 0.35, 0.675, script, true, 10)
			wait(3.2)
			p_u_16:CreateSound("rbxassetid://72483809453170", 0.6, 0.7, script, true, 10)
			wait(2.15)
			p_u_16:CreateSound("rbxassetid://72483809453170", 0.65, 0.725, script, true, 10)
			wait(1.4)
			p_u_16:CreateSound("rbxassetid://72483809453170", 0.7, 0.75, script, true, 10)
			wait(1.5)
			p_u_16:CreateSound("rbxassetid://72483809453170", 0.75, 0.775, script, true, 10)
			wait(3.45)
			p_u_16:CreateSound("rbxassetid://72483809453170", 1.5, 0.8, script, true, 10)
			wait(2.3)
			p_u_16:CreateSound("rbxassetid://72483809453170", 0.3, 0.75, script, true, 10)
			wait(2)
			p_u_16:CreateSound("rbxassetid://72483809453170", 0.25, 1, script, true, 10)
			wait(3.85)
			p_u_16:CreateSound("rbxassetid://98587858115094", 1, 1, script, true, 10)
			wait(2)
			p_u_16:CreateSound("rbxassetid://72483809453170", 1.25 + 0.25 * math.random(), 0.9 + 0.2 * math.random(), script, true, 10)
			p_u_16:CreateSound("rbxassetid://129922197154277", 1.25 + 0.25 * math.random(), 0.9 + 0.2 * math.random(), script, true, 10)
			p_u_16:CreateSound("rbxassetid://113975047764762", 1.25 + 0.25 * math.random(), 0.9 + 0.2 * math.random(), script, true, 10)
			wait(1.8)
			p_u_16:CreateSound("rbxassetid://121368500414901", 1.5, 0.875, script, true, 10)
		end)
	end
	p_u_16.CutsceneLogic:PlayCutscene(p19, v20, function(_) -- name: renderstep_callback end, p_u_18:WaitForChild("CameraRig"):WaitForChild("AnimationController"), p_u_16.CutsceneLogic:GetPreloadedAnimation("GiantChombieCamera"), v_u_9, #v_u_8, "GiantChombiePlayer", true)
end
function v_u_10._ChickenTrojanEffect(p21, p22, p23, p24) -- name: _ChickenTrojanEffect
	-- upvalues: (copy) v_u_6, (copy) v_u_3, (copy) v_u_4
	local v25 = tick() + p23
	while tick() < v25 do
		local v26 = v_u_6:Clone()
		local v27 = CFrame.new(p22)
		local v28 = math.random() - 0.5
		local v29 = math.random() - 0.5
		local v30 = math.random() - 0.5
		v26.CFrame = v27 + Vector3.new(v28, v29, v30) * 12
		v26.Parent = workspace
		v_u_3:AddItem(v26, 5)
		v_u_4:ScaleParticleEmitter(v26, 0.5 + 0.75 * math.random())
		v_u_4:PlayParticles(v26)
		p21:CreateSound("rbxassetid://97884024654711", 0.875 + 0.25 * math.random(), 1 + 0.25 * math.random(), v26, true, 5)
		wait(p24 or 0.2)
	end
end
function v_u_10._Setup(p31) -- name: _Setup
	-- upvalues: (copy) v_u_8, (copy) v_u_7
	for v32, v33 in pairs(v_u_8) do
		p31.CutsceneLogic:PreloadAnimation("GiantChombiePlayer" .. v32, v33)
	end
	p31.CutsceneLogic:PreloadAnimation("GiantChombieHumanoid", "rbxassetid://80790358034810")
	p31.CutsceneLogic:PreloadAnimation("GiantChombieCamera", "rbxassetid://85660296117721")
	p31.CutsceneLogic:PreloadCutsceneSoundIDs(v_u_7)
end
function v_u_10._Init(p34) -- name: _Init
	p34:_Setup()
	p34.ClientDuel:SetReplicate("DuelMusic", "ZombieTower")
end
return v_u_10