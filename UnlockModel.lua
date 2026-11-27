local v1 = game:GetService("ReplicatedStorage")
local v2 = game:GetService("Players")
local v_u_3 = require(v1.Modules.BetterDebris)
local v_u_4 = require(v1.Modules.Utility)
local v_u_5 = require(v1.Modules.Signal)
local v_u_6 = require(v2.LocalPlayer.PlayerScripts.Controllers.PlayerDataController)
local v_u_7 = require(v2.LocalPlayer.PlayerScripts.Controllers.PreloadController)
local v_u_8 = require(v2.LocalPlayer.PlayerScripts.Modules.UserInterface.Pages)
local v_u_9 = v2.LocalPlayer.PlayerScripts.Assets.Misc.UnlockParticles
local v_u_10 = {}
v_u_10.__index = v_u_10
function v_u_10.new(p11) -- name: new
	-- upvalues: (copy) v_u_10, (copy) v_u_5
	local v12 = v_u_10
	local v13 = setmetatable({}, v12)
	v13.UnlockingChanged = v_u_5.new()
	v13.Scene = p11
	v13.Model = v13.Scene.Model:WaitForChild("UnlockEffect")
	v13.IsUnlocking = false
	v13._animation_controller = v13.Model:WaitForChild("AnimationController")
	v13._original_cframe = v13.Model:GetPivot()
	v13._idle_animation_loaded = false
	v13._animation_track = nil
	v13._animation_hash = 0
	v13:_Init()
	return v13
end
function v_u_10.StopAnimation(p14, _) -- name: StopAnimation
	p14:_SetIsUnlocking(false)
	p14._animation_hash = p14._animation_hash + 1
	if p14._animation_track then
		p14._animation_track:Stop(0)
	end
end
function v_u_10.PlayAnimation(p15) -- name: PlayAnimation
	p15:StopAnimation(true)
	p15:_SetIsUnlocking(true)
	local v16 = p15._PlayAnimationAsync
	local v17, v18 = pcall(v16, p15)
	if not v17 then
		warn("Unlock animation failed, error:", v18)
	end
	p15:_SetIsUnlocking(false)
end
function v_u_10.OnStateChanged(p19) -- name: OnStateChanged
	p19:_PlayIdleAnimation()
	p19:_UpdateCFrame()
	p19:StopAnimation()
end
function v_u_10.OnOpen(p20) -- name: OnOpen
	p20:_PlayIdleAnimation()
end
function v_u_10._PlayAnimationAsync(p21) -- name: _PlayAnimationAsync
	-- upvalues: (copy) v_u_4, (copy) v_u_7, (copy) v_u_3, (copy) v_u_9
	p21._animation_hash = p21._animation_hash + 1
	local v22 = p21._animation_hash
	p21.Model.Key.a1.Trail.Enabled = true
	v_u_4:CreateSound("rbxassetid://17662575024", 1.5, 1, script, true, 5)
	if not p21._animation_track then
		p21._animation_track = p21._animation_controller:LoadAnimation(v_u_7:GetPreloadedAnimation("WeaponUnlockPlay"))
	end
	p21._animation_track:Play(0)
	wait(2.25)
	if v22 == p21._animation_hash then
		v_u_4:CreateSound("rbxassetid://17662574898", 1.5, 1, script, true, 5)
		wait(0.25)
		if v22 == p21._animation_hash then
			p21.Model.Key.a1.Trail.Enabled = false
			v_u_4:CreateSound("rbxassetid://17662575175", 1, 1, script, true, 5)
			v_u_4:PlayParticles(p21.Model.ChainsHolder.Attachment)
			wait(1)
			if v22 == p21._animation_hash then
				v_u_4:CreateSound("rbxassetid://17662623697", 1.5, 1, script, true, 5)
				local v23, v24 = p21.Scene.Equipment.FloatingModel:GetBoundingBox()
				local v25 = Instance.new("Part")
				v25.CFrame = v23
				v25.Size = v24
				v25.Transparency = 1
				v25.Anchored = true
				v25.CanCollide = false
				v25.CanTouch = false
				v25.CanQuery = false
				v25.Parent = workspace
				v_u_3:AddItem(v25, 10)
				for _, v26 in pairs(v_u_9:GetChildren()) do
					local v27 = v26:Clone()
					v27.Parent = v25
					task.delay(v26:GetAttribute("EmitDelay") or 0, v27.Emit, v27, v26:GetAttribute("EmitCount"))
				end
			end
		else
			return
		end
	else
		return
	end
end
function v_u_10._PlayIdleAnimation(p_u_28) -- name: _PlayIdleAnimation
	-- upvalues: (copy) v_u_7
	p_u_28._idle_animation_loaded = false
	for _ = 1, 3 do
		local function v29()
			-- upvalues: (copy) p_u_28, (ref) v_u_7
			p_u_28._animation_controller:LoadAnimation(v_u_7:GetPreloadedAnimation("WeaponUnlockIdle")):Play(0)
		end
		local v30, v31 = pcall(v29)
		if v30 then
			p_u_28._idle_animation_loaded = true
			return
		end
		warn("Failed to load unlock model idle, error", v31)
	end
end
function v_u_10._UpdateCFrame(p32) -- name: _UpdateCFrame
	-- upvalues: (copy) v_u_6, (copy) v_u_8
	local v33 = p32.Scene.Equipment:GetSelectedWeapon()
	if v33 then
		v33 = not v_u_6:GetWeaponData(v33)
	end
	local v34 = v33 and (not v_u_8.PageSystem.CurrentPage and p32._idle_animation_loaded) and p32._original_cframe or CFrame.identity
	p32.Model:PivotTo(v34)
end
function v_u_10._UpdateKey(p35) -- name: _UpdateKey
	local v36 = p35.IsUnlocking and 0 or 1
	p35.Model.Key.LocalTransparencyModifier = v36
	p35.Model.Key.a1.Trail.LocalTransparencyModifier = v36
	p35.Model.Key.sparkle.LocalTransparencyModifier = v36
end
function v_u_10._SetIsUnlocking(p37, p38) -- name: _SetIsUnlocking
	if p37.IsUnlocking ~= p38 then
		p37.IsUnlocking = p38
		p37.UnlockingChanged:Fire()
	end
end
function v_u_10._Init(p_u_39) -- name: _Init
	-- upvalues: (copy) v_u_6, (copy) v_u_8
	p_u_39.UnlockingChanged:Connect(function()
		-- upvalues: (copy) p_u_39
		p_u_39:_UpdateKey()
	end)
	v_u_6:GetDataChangedSignal("WeaponInventory"):Connect(function()
		-- upvalues: (copy) p_u_39
		p_u_39:_UpdateCFrame()
	end)
	v_u_8.PageSystem.PagesActivity:Connect(function()
		-- upvalues: (copy) p_u_39
		p_u_39:_UpdateCFrame()
	end)
	p_u_39:_UpdateKey()
end
return v_u_10