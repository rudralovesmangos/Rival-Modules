local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("ContentProvider")
local v3 = game:GetService("Players")
local v_u_4 = require(v1.Modules.BetterDebris)
local v_u_5 = require(v1.Modules.SoundLibrary)
local v_u_6 = require(v1.Modules.Utility)
local v_u_7 = require(v3.LocalPlayer.PlayerScripts.Controllers.CameraController)
local v_u_8 = require(v3.LocalPlayer.PlayerScripts.Modules.ClientReplicatedClasses.ClientEntity.ClientHumanoidEntity.ClientEnemy)
local v_u_9 = v3.LocalPlayer.PlayerScripts.Assets.Misc.SlamParticles
local v_u_10 = { "rbxassetid://72483809453170", "rbxassetid://129922197154277", "rbxassetid://113975047764762" }
local v_u_11 = setmetatable({}, v_u_8)
v_u_11.__index = v_u_11
function v_u_11.new(...) -- name: new
	-- upvalues: (copy) v_u_8, (copy) v_u_11, (copy) v_u_5, (copy) v_u_10
	local v12 = v_u_8.new(...)
	local v13 = v_u_11
	local v14 = setmetatable(v12, v13)
	v14._slam_vulnerable_animation = v14:_CreateAnimation("rbxassetid://129758877701887")
	v14._slam_animation = v14:_CreateAnimation("rbxassetid://97481875605208")
	v14._preloaded_sounds = v_u_5:PreloadSounds(v_u_10, nil, "rbxassetid://98587858115094")
	v14:_Init()
	return v14
end
function v_u_11.ReplicateFromServer(p15, p16, ...) -- name: ReplicateFromServer
	-- upvalues: (copy) v_u_6, (copy) v_u_7, (copy) v_u_9, (copy) v_u_4, (copy) v_u_10, (copy) v_u_8
	if p16 == "SlamEffect" then
		if p15:IsRendered() then
			local v17, v18, v19, v20, v21 = ...
			local v22
			if v21 then
				v22 = p15._slam_vulnerable_animation
			else
				v22 = p15._slam_animation
			end
			local v23 = p15.Humanoid.LoadAnimation
			local v24 = p15.Humanoid
			local v25, v26 = pcall(v23, v24, v22)
			if v25 then
				local v27 = p15._animation_cleanup
				table.insert(v27, v26)
				v26:Play()
			end
			wait(v19)
			v_u_6:CreateSound("rbxassetid://98587858115094", 0.875 + 0.25 * math.random(), 0.9 + 0.2 * math.random(), p15.RootPart, true, 10, 400, 400)
			wait(v20)
			if p15:IsAlive() then
				local v28 = 1 - (p15.RootPart.Position - workspace.CurrentCamera.CFrame.Position).Magnitude / 400
				local v29 = math.max(0, v28)
				v_u_7:ShakeOnce(v29 * 50, v29 * 10, 0.1, 0.4, Vector3.new(1, 1, 0), Vector3.new(0, 0, 0))
				local v30 = v_u_9:Clone()
				v30.CFrame = CFrame.new(v17) + Vector3.new(0, 0.1, 0)
				v30.Parent = workspace
				v_u_4:AddItem(v30, 10)
				v_u_6:ScaleParticleEmitter(v30, v18 / 32)
				v_u_6:PlayParticles(v30)
				for _, v31 in pairs(v_u_10) do
					v_u_6:CreateSound(v31, 0.875 + 0.25 * math.random(), 0.9 + 0.2 * math.random(), p15.RootPart, true, 10, 400, 400)
				end
			end
		else
			return
		end
	else
		v_u_8.ReplicateFromServer(p15, p16, ...)
		return
	end
end
function v_u_11.Destroy(p32) -- name: Destroy
	-- upvalues: (copy) v_u_8
	for _, v33 in pairs(p32._preloaded_sounds) do
		v33:Destroy()
	end
	v_u_8.Destroy(p32)
end
function v_u_11._Setup(p34) -- name: _Setup
	-- upvalues: (copy) v_u_2
	task.spawn(pcall, v_u_2.PreloadAsync, v_u_2, { p34._slam_animation, p34._slam_vulnerable_animation })
end
function v_u_11._Init(p35) -- name: _Init
	p35:_Setup()
end
return v_u_11