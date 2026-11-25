local v1 = game:GetService("ReplicatedStorage")
local v2 = game:GetService("Players")
local v_u_3 = require(v1.Modules.CONSTANTS)
local v_u_4 = require(v1.Modules.Signal)
local v_u_5 = require(v2.LocalPlayer.PlayerScripts.Controllers.PreloadController)
local v_u_6 = require(v2.LocalPlayer.PlayerScripts.Modules.ClientReplicatedClasses.ClientEntity)
local v_u_7 = v2.LocalPlayer.PlayerScripts.Assets.Misc.HeadshotParticles.Attachment
local v_u_8 = v1.Modules.Emotes
local v_u_9 = setmetatable({}, v_u_6)
v_u_9.__index = v_u_9
function v_u_9.new(p10) -- name: new
	-- upvalues: (copy) v_u_6, (copy) v_u_9, (copy) v_u_4, (copy) v_u_7
	local v11 = v_u_6.new(p10)
	local v12 = v_u_9
	local v13 = setmetatable(v11, v12)
	v13.EmoteStatusChanged = v_u_4.new()
	v13.Humanoid = p10.Humanoid
	v13._headshot_particles = v_u_7:Clone()
	v13._animation_cleanup = {}
	v13._current_emote = nil
	v13:_Init()
	return v13
end
function v_u_9.IsEmoting(p14) -- name: IsEmoting
	return p14._current_emote ~= nil
end
function v_u_9.IsHumanoidStateAirborne(p15, p16) -- name: IsHumanoidStateAirborne
	-- upvalues: (copy) v_u_3
	return v_u_3.AIRBORNE_HUMANOID_STATES[p16 or p15.Humanoid:GetState()]
end
function v_u_9.GetCurrentEmote(p17) -- name: GetCurrentEmote
	return p17._current_emote
end
function v_u_9.GetHealth(p18) -- name: GetHealth
	return p18.Humanoid and p18.Humanoid.Health or 0
end
function v_u_9.GetMaxHealth(p19) -- name: GetMaxHealth
	return p19.Humanoid and p19.Humanoid.MaxHealth or 100
end
function v_u_9.GetShield(p20) -- name: GetShield
	return p20.Humanoid and p20.Humanoid:GetAttribute("Shield") or 0
end
function v_u_9.GetMaxShield(p21) -- name: GetMaxShield
	return p21.Humanoid and p21.Humanoid:GetAttribute("MaxShield") or 0
end
function v_u_9.CancelEmote(p22, p23) -- name: CancelEmote
	local v24 = p22._current_emote
	if v24 then
		if not p23 or p22._current_emote.ObjectID == p23 then
			v24:Destroy()
			p22._current_emote = nil
			p22.EmoteStatusChanged:Fire()
		end
	else
		return
	end
end
function v_u_9.PlayEmote(p25, p26) -- name: PlayEmote
	-- upvalues: (copy) v_u_8
	p25:CancelEmote()
	if p25:IsAlive() then
		local v27 = require(v_u_8[p26.Name]).new(p25.Humanoid)
		v27:SetSerial(p26)
		p25._current_emote = v27
		p25.EmoteStatusChanged:Fire()
		v27:PlayClient()
	end
end
function v_u_9.ReplicateFromServer(p28, p29, ...) -- name: ReplicateFromServer
	-- upvalues: (copy) v_u_6
	if p29 == "PlayAnimation" then
		if p28:IsRendered() then
			p28:_PlayAnimation(...)
		end
	elseif p29 == "EmotePlayed" then
		if p28:IsRendered() then
			p28:PlayEmote(...)
		end
	elseif p29 == "EmoteStopped" then
		p28:CancelEmote(...)
	else
		v_u_6.ReplicateFromServer(p28, p29, ...)
	end
end
function v_u_9.Destroy(p30) -- name: Destroy
	-- upvalues: (copy) v_u_6
	for _, v31 in pairs(p30._animation_cleanup) do
		v31:Destroy()
	end
	p30._animation_cleanup = {}
	p30.EmoteStatusChanged:Destroy()
	p30:CancelEmote()
	v_u_6.Destroy(p30)
end
function v_u_9._PlayAnimation(p32, p33, ...) -- name: _PlayAnimation
	-- upvalues: (copy) v_u_5
	local v34 = v_u_5:GetPreloadedAnimationID(p33) or p33
	local v35 = v_u_5:GetPreloadedAnimation(p33) or p32:_CreateAnimation(v34)
	local v36 = p32.Humanoid:LoadAnimation(v35)
	local v37 = p32._animation_cleanup
	table.insert(v37, v36)
	v36:Play(...)
	return v36
end
function v_u_9._CreateAnimation(p38, p39) -- name: _CreateAnimation
	local v40 = typeof(p39) == "string"
	assert(v40, "Argument 1 invalid, expected a string")
	local v41 = Instance.new("Animation")
	v41.AnimationId = p39
	local v42 = p38._animation_cleanup
	table.insert(v42, v41)
	return v41
end
function v_u_9._Setup(p_u_43) -- name: _Setup
	local v44 = p_u_43._headshot_particles
	local v45 = p_u_43.Model
	if v45 then
		v45 = p_u_43.Model:FindFirstChild("Head")
	end
	v44.Parent = v45
	if p_u_43.Humanoid then
		p_u_43.Humanoid:GetPropertyChangedSignal("MaxHealth"):Connect(function()
			-- upvalues: (copy) p_u_43
			p_u_43.HealthChanged:Fire()
		end)
		p_u_43.Humanoid:GetPropertyChangedSignal("Health"):Connect(function()
			-- upvalues: (copy) p_u_43
			p_u_43.HealthChanged:Fire()
		end)
		p_u_43.Humanoid:GetAttributeChangedSignal("MaxShield"):Connect(function()
			-- upvalues: (copy) p_u_43
			p_u_43.ShieldChanged:Fire()
		end)
		p_u_43.Humanoid:GetAttributeChangedSignal("Shield"):Connect(function()
			-- upvalues: (copy) p_u_43
			p_u_43.ShieldChanged:Fire()
		end)
	end
end
function v_u_9._Init(p46) -- name: _Init
	p46:_Setup()
end
return v_u_9