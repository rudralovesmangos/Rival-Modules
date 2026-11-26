local v_u_1 = game:GetService("ContextActionService")
game:GetService("CollectionService")
local v_u_2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("UserInputService")
local v_u_4 = game:GetService("GamepadService")
game:GetService("StarterGui")
local v_u_5 = game:GetService("RunService")
local v_u_6 = game:GetService("GuiService")
local v_u_7 = game:GetService("Players")
local v_u_8 = require(v_u_2.Modules.CONSTANTS)
local v_u_9 = require(v_u_2.Modules.SettingsLibrary)
local v_u_10 = require(v_u_2.Modules.CosmeticLibrary)
local v_u_11 = require(v_u_2.Modules.GameplayUtility)
require(v_u_2.Modules.BetterDebris)
local v_u_12 = require(v_u_2.Modules.InputLibrary)
local v_u_13 = require(v_u_2.Modules.EnumLibrary)
local v_u_14 = require(v_u_2.Modules.ItemLibrary)
require(v_u_2.Modules.TestLibrary)
local v_u_15 = require(v_u_2.Modules.Utility)
local v_u_16 = require(v_u_2.Modules.Signal)
local v_u_17 = require(v_u_7.LocalPlayer.PlayerScripts.Controllers.UserInterfaceController)
local v_u_18 = require(v_u_7.LocalPlayer.PlayerScripts.Controllers.PlayerDataController)
local v_u_19 = require(v_u_7.LocalPlayer.PlayerScripts.Controllers.SpectateController)
local v_u_20 = require(v_u_7.LocalPlayer.PlayerScripts.Controllers.ControlsController)
local v_u_21 = require(v_u_7.LocalPlayer.PlayerScripts.Controllers.CameraController)
local v_u_22 = require(v_u_7.LocalPlayer.PlayerScripts.Controllers.EmoteController)
local v_u_23 = require(v_u_7.LocalPlayer.PlayerScripts.Controllers.DebugController.DebugState)
local v_u_24 = { "Aim", "Sprint", "Crouch" }
local v_u_25 = {
	["Aim"] = false,
	["Sprint"] = false,
	["Crouch"] = false
}
local v_u_26 = {}
v_u_26.__index = v_u_26
function v_u_26._new() -- name: _new
	-- upvalues: (copy) v_u_26, (copy) v_u_16
	local v27 = v_u_26
	local v28 = setmetatable({}, v27)
	v28.StateChanged = v_u_16.new()
	v28.SlideStep = v_u_16.new()
	v28.LocalFighter = nil
	v28.IsCrouching = false
	v28.IsSprinting = false
	v28.IsSliding = false
	v28.CameraLean = 0
	v28._internal_local_fighter_added = v_u_16.new()
	v28._controls_connections = {}
	v28._crouching_start_time = 0
	v28._crouching_release_time = 0
	v28._sprinting_start_time = 0
	v28._sprinting_release_time = 0
	v28._sliding_cooldown = 0
	v28._sliding_start_time = 0
	v28._sliding_release_time = 0
	v28._sliding_velocity = nil
	v28._sliding_last_floor = nil
	v28._sliding_last_floor_physical_properties = nil
	v28._update_slide_direction = nil
	v28._is_input_spamming = {}
	v28._mobile_input_down = {}
	v28._is_leaning_right = false
	v28._is_leaning_left = false
	v28._original_jump_power = nil
	v28._jump_hash = 0
	v28._double_jumps_used = {}
	v28._auto_shoot_hash = 0
	v28._auto_shoot_connection = nil
	v28._scroll_delta = 0.5
	v28:_Init()
	return v28
end
function v_u_26.AreInputsDisabled(p29) -- name: AreInputsDisabled
	-- upvalues: (copy) v_u_4, (copy) v_u_6, (copy) v_u_20, (copy) v_u_7, (copy) v_u_19
	if v_u_4.GamepadCursorEnabled or v_u_6.SelectedObject then
		return true
	end
	if p29.LocalFighter and p29.LocalFighter:Get("IsHiddenByCutscene") then
		return true
	end
	if v_u_20.CurrentControls == "Gamepad" then
		local v30 = require(v_u_7.LocalPlayer.PlayerScripts.Modules.UserInterface.Equipment)
		if require(v_u_7.LocalPlayer.PlayerScripts.Modules.UserInterface.Pages).PageSystem.CurrentPage or (v30.IsOpen or v_u_19.CurrentDuelSubject and v_u_19.CurrentDuelSubject.DuelInterface.Voting:IsOpen()) then
			return true
		end
	end
	return false
end
function v_u_26.IsAlive(p31) -- name: IsAlive
	local v32 = p31.LocalFighter
	if v32 then
		v32 = p31.LocalFighter:IsAlive()
	end
	return v32
end
function v_u_26.IsFrozen(p33) -- name: IsFrozen
	local v34 = p33.LocalFighter and p33.LocalFighter.Entity
	if v34 then
		v34 = p33.LocalFighter.Entity:Get("IsFrozen")
	end
	return v34
end
function v_u_26.IsInputDown(p35, p36) -- name: IsInputDown
	-- upvalues: (copy) v_u_21, (copy) v_u_20, (copy) v_u_12
	local v37 = v_u_21:GetPublicState() == v_u_21.CameraState.States.ThirdPersonUnlockedMouse and { Enum.UserInputType.MouseButton2 } or nil
	if v_u_20.CurrentControls == "Touch" then
		return p35:IsMobileInputDown(p36)
	else
		return v_u_12:IsInputDown(p36, v37)
	end
end
function v_u_26.IsMobileInputDown(p38, p39) -- name: IsMobileInputDown
	return p38._mobile_input_down[p39]
end
function v_u_26.GetTimeSince(p40, p41, p42) -- name: GetTimeSince
	return tick() - p40["_" .. string.lower(p41) .. "_" .. string.lower(p42) .. "_time"]
end
function v_u_26.SetCameraLean(p43, p44) -- name: SetCameraLean
	p43.CameraLean = p44
	p43.LocalFighter.LocalCameraLean = p43.CameraLean
	p43:_UpdateServerState("CameraLean", p43.CameraLean)
end
function v_u_26.SetCrouching(p45, p46) -- name: SetCrouching
	-- upvalues: (copy) v_u_20
	if not p46 then
		v_u_20:ToggleInput("Crouch", false)
	end
	if p46 ~= p45.IsCrouching then
		p45.IsCrouching = p46
		p45.LocalFighter.IsCrouchingLocally = p45.IsCrouching
		p45[p45.IsCrouching and "_crouching_start_time" or "_crouching_release_time"] = tick()
		p45:_UpdateServerState("IsCrouching", p45.IsCrouching)
		p45.StateChanged:Fire("IsCrouching")
		p45:_UpdateWalkSpeed()
		if p45.IsCrouching then
			p45:SetSprinting(false)
			local v47 = p45.LocalFighter.Entity.RootPart
			local v48 = p45.LocalFighter.Entity.RootPart.Velocity.X
			local v49 = p45.LocalFighter.Entity.RootPart.Velocity.Y
			local v50 = math.min(0, v49)
			local v51 = p45.LocalFighter.Entity.RootPart.Velocity.Z
			v47.Velocity = Vector3.new(v48, v50, v51)
		end
	end
end
function v_u_26.SetSprinting(p52, p53) -- name: SetSprinting
	if p53 ~= p52.IsSprinting then
		if not (p52.LocalFighter and (p52.LocalFighter:CanSprint() and p53)) then
			p53 = false
		end
		p52.IsSprinting = p53
		p52.LocalFighter.IsSprintingLocally = p52.IsSprinting
		p52[p52.IsSprinting and "_sprinting_start_time" or "_sprinting_release_time"] = tick()
		p52:_UpdateServerState("IsSprinting", p52.IsSprinting)
		p52.StateChanged:Fire("IsSprinting")
		p52:_UpdateWalkSpeed()
		if p52.IsSprinting then
			p52:SetCrouching(false)
		end
	end
end
function v_u_26.PlayMechanicsSound(p54, ...) -- name: PlayMechanicsSound
	-- upvalues: (copy) v_u_2
	if p54.LocalFighter then
		v_u_2.Remotes.Replication.Fighter.PlayMechanicsSound:FireServer(...)
		return p54.LocalFighter:PlayMechanicsSound(...)
	end
end
function v_u_26.StopSliding(p55, p56) -- name: StopSliding
	-- upvalues: (copy) v_u_8
	if p55.IsSliding then
		if p55._sliding_last_floor then
			p55._sliding_last_floor.CustomPhysicalProperties = p55._sliding_last_floor_physical_properties
			p55._sliding_last_floor = nil
			p55._sliding_last_floor_physical_properties = nil
		end
		if p55._sliding_velocity then
			p55._sliding_velocity:Destroy()
			p55._sliding_velocity = nil
		end
		p55._sliding_cooldown = tick() + 0.25
		p55._update_slide_direction = nil
		p55.IsSliding = false
		p55.LocalFighter.IsSlidingLocally = false
		p55._sliding_release_time = tick()
		p55:_UpdateServerState("IsSliding", false)
		p55.StateChanged:Fire("IsSliding")
		p55:_UpdateWalkSpeed()
		if p55:IsAlive() then
			p55.LocalFighter.Entity:StopSlidingAnimation()
			p55.LocalFighter.Entity.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing, true)
			if p56 then
				local v57 = p55.LocalFighter.Entity.RootPart.Velocity * 0.6
				local v58 = v_u_8.BASE_JUMPPOWER * 0.5
				local v59 = v57 + Vector3.new(0, v58, 0)
				p55.LocalFighter.Entity:AirborneTrigger(v59, 12, true)
			end
			if p55:IsInputDown("Sprint") then
				p55:SetSprinting(true)
			end
		end
	end
end
function v_u_26.Slide(p_u_60) -- name: Slide
	-- upvalues: (copy) v_u_15, (copy) v_u_5
	if not p_u_60.IsSliding and (tick() >= p_u_60._sliding_cooldown and (p_u_60:IsAlive() and (p_u_60.LocalFighter.Entity.Humanoid:GetState() ~= Enum.HumanoidStateType.Climbing and (not p_u_60.LocalFighter:AreItemsLocked() and (p_u_60.LocalFighter:CanSlide() and not p_u_60:IsFrozen()))))) then
		p_u_60._sliding_cooldown = (1 / 0)
		p_u_60.IsSliding = true
		p_u_60.LocalFighter.IsSlidingLocally = true
		p_u_60._sliding_start_time = tick()
		p_u_60:_UpdateServerState("IsSliding", true)
		p_u_60.StateChanged:Fire("IsSliding")
		p_u_60.LocalFighter.Entity.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing, false)
		p_u_60.LocalFighter.Entity.Humanoid.AutoRotate = false
		p_u_60.LocalFighter.Entity:AirborneCancel()
		p_u_60:SetCrouching(false)
		p_u_60:SetSprinting(false)
		p_u_60:_UpdateWalkSpeed()
		p_u_60._sliding_velocity = Instance.new("BodyVelocity")
		p_u_60._sliding_velocity.Parent = p_u_60.LocalFighter.Entity.RootPart
		local v61 = tick()
		local v62 = p_u_60.LocalFighter.Entity.RootPart.Position.Y
		local v63 = nil
		local v_u_64 = nil
		local v65 = p_u_60:PlayMechanicsSound("Slide")
		local v66 = tick() + 0.25
		local v67 = p_u_60.LocalFighter.Entity.RootPart.CFrame.Rotation
		local v68 = p_u_60:_GetWalkSpeed(true)
		function p_u_60._update_slide_direction(p69)
			-- upvalues: (ref) v_u_64, (copy) p_u_60
			v_u_64 = p69 or p_u_60.LocalFighter:GetMoveVector(true, true, p_u_60.LocalFighter.Entity.RootPart.CFrame.LookVector)
			task.spawn(p_u_60.LocalFighter.Entity.PlaySlidingAnimationAsync, p_u_60.LocalFighter.Entity, v_u_64)
		end
		p_u_60._update_slide_direction()
		local v70 = v_u_64
		local v71 = 0
		while p_u_60:IsAlive() and (p_u_60.IsSliding and tick() < v61 + 1) do
			local v72 = p_u_60.LocalFighter:GetFloor()
			local v73 = p_u_60.LocalFighter.Entity.RootPart.Position.Y
			if v72 then
				v63 = nil
			else
				v63 = v63 or tick()
			end
			if v73 < v62 - 1 then
				v61 = tick()
				if v65 and v66 < tick() then
					v65.TimePosition = 0
					v65.Volume = 0
				end
				v66 = tick() + 0.25
			else
				v73 = math.max(v62, v73)
			end
			if v65 and (v65.Volume == 0 and v72) then
				v65.TimePosition = 0
				v65.Volume = 0.375
			end
			local v74 = v70.Magnitude <= 0.01 and p_u_60.LocalFighter.Entity.RootPart.CFrame.LookVector or v70.Unit
			local v75 = Vector3.new(0, 1, 0)
			if v72 ~= p_u_60._sliding_last_floor then
				if p_u_60._sliding_last_floor then
					p_u_60._sliding_last_floor.CustomPhysicalProperties = p_u_60._sliding_last_floor_physical_properties
					p_u_60._sliding_last_floor = nil
					p_u_60._sliding_last_floor_physical_properties = nil
				end
				if v72 and not v72:IsA("Terrain") then
					p_u_60._sliding_last_floor = v72
					p_u_60._sliding_last_floor_physical_properties = p_u_60._sliding_last_floor.CurrentPhysicalProperties
				end
			end
			if v72 then
				local v76 = p_u_60.LocalFighter.Entity.RootPart.Position
				local v77 = v76 + v74 * 0.1
				local v78 = v_u_15:Raycast(v76, v76 + Vector3.new(0, -1, 0), 999, { v72 }, Enum.RaycastFilterType.Include)
				local v79 = v_u_15:Raycast(v77, v77 + Vector3.new(0, -1, 0), 999, { v72 }, Enum.RaycastFilterType.Include)
				if v_u_15:AngleBetweenVectors((v79.Position - v78.Position).Unit, Vector3.new(-0, -1, -0)) > 0.7853981633974483 then
					v74 = (v79.Position - v78.Position).Unit
					v75 = v79.Normal or (v78.Normal or v75)
				end
			end
			if v75.Magnitude < 0.5 then
				p_u_60.SlideStep:Fire()
			end
			if v72 then
				v71 = (tick() - v61) / 1 or v71
			end
			local v80 = p_u_60.LocalFighter:Get("SlidingSpeedMax") or 3
			local v81 = v74 * (v80 + (1 - v80) * v71) * v68
			local v82 = not v63 and Vector3.new(0, 0, 0) or v75 * -workspace.Gravity * (tick() - v63) ^ 2
			p_u_60._sliding_velocity.Velocity = v81 + v82
			p_u_60._sliding_velocity.MaxForce = Vector3.new(1, v63 and 0.1 or 1, 1) * 100000
			if v81.Magnitude > 0.01 then
				p_u_60.LocalFighter.Entity.RootPart.CFrame = p_u_60.LocalFighter.Entity.RootPart.CFrame:Lerp(CFrame.new(p_u_60.LocalFighter.Entity.RootPart.Position, p_u_60.LocalFighter.Entity.RootPart.Position + v81), 0.25)
				v67 = p_u_60.LocalFighter.Entity.RootPart.CFrame.Rotation
			else
				p_u_60.LocalFighter.Entity.RootPart.CFrame = CFrame.new(p_u_60.LocalFighter.Entity.RootPart.Position) * v67
			end
			v_u_5.RenderStepped:Wait()
			v62 = v73
		end
		v65:Destroy()
		if p_u_60.IsSliding then
			p_u_60:StopSliding()
		end
	end
end
function v_u_26.Jump(p_u_83, p84, p85, p86) -- name: Jump
	if p_u_83:IsAlive() and (not p_u_83:IsFrozen() and (p86 or not p_u_83.LocalFighter.Entity:IsAirborne())) then
		p_u_83._original_jump_power = p_u_83._original_jump_power or p_u_83.LocalFighter.Entity.Humanoid.JumpPower
		p_u_83._jump_hash = p_u_83._jump_hash + 1
		local v_u_87 = p_u_83._jump_hash
		p_u_83.LocalFighter.Entity.Humanoid.JumpPower = (p84 or p_u_83._original_jump_power) * (p85 or 1)
		p_u_83.LocalFighter.Entity.Humanoid.Jump = true
		if p84 or p85 then
			task.defer(function()
				-- upvalues: (copy) v_u_87, (copy) p_u_83
				if v_u_87 == p_u_83._jump_hash and p_u_83:IsAlive() then
					p_u_83.LocalFighter.Entity.Humanoid.JumpPower = p_u_83._original_jump_power
					p_u_83._original_jump_power = nil
				end
			end)
		end
	end
end
function v_u_26.DoubleJump(p88) -- name: DoubleJump
	if p88:IsAlive() and not p88:IsFrozen() then
		local v89 = p88.LocalFighter:GetMoveVector(true, true)
		local v90 = p88.LocalFighter.Entity.RootPart
		local v91 = v89 * p88.LocalFighter.Entity.Humanoid.WalkSpeed * 1
		local v92 = p88.LocalFighter.Entity.Humanoid.JumpPower * 1.1
		v90.Velocity = v91 + Vector3.new(0, v92, 0)
		p88.LocalFighter.Entity:AirborneRedirect()
		p88:PlayMechanicsSound("DoubleJump")
	end
end
function v_u_26.JumpRequest(p93, ...) -- name: JumpRequest
	p93:Jump(...)
end
function v_u_26.DoubleJumpRequest(p94) -- name: DoubleJumpRequest
	local v95 = p94.LocalFighter and p94.LocalFighter.EquippedItem
	if v95 then
		v95 = p94.LocalFighter.EquippedItem:Get("ObjectID")
	end
	local v96 = p94.LocalFighter and (p94.LocalFighter.EquippedItem and not p94.LocalFighter:Get("DisableDoubleJumping"))
	if v96 then
		v96 = p94.LocalFighter.EquippedItem.Info.MaxDoubleJumps
	end
	if v95 and (v96 and ((p94._double_jumps_used[v95] or 0) < (v96 or 0) and not p94.LocalFighter:IsGrounded())) then
		p94._double_jumps_used[v95] = (p94._double_jumps_used[v95] or 0) + 1
		p94:DoubleJump()
	end
end
function v_u_26.HighJump(p97) -- name: HighJump
	if p97:IsAlive() then
		p97:StopSliding(true)
		p97:_SpamJumpRequests(nil, 1.25, true)
	end
end
function v_u_26.EquippedItemInput(p98, ...) -- name: EquippedItemInput
	if p98.LocalFighter then
		p98.LocalFighter:Input(...)
	end
end
function v_u_26.SimulateInputBegan(p_u_99, p100, p101) -- name: SimulateInputBegan
	-- upvalues: (copy) v_u_12, (copy) v_u_17, (copy) v_u_24, (copy) v_u_20, (copy) v_u_21, (copy) v_u_19, (copy) v_u_18, (copy) v_u_22, (copy) v_u_8, (copy) v_u_2
	if v_u_12:InputIs(p100, "UseEmote") then
		local v102 = v_u_17:GetPage("PickEmote")
		if v102 and v102:IsOpen() then
			v102:SetAllEmotesOpen(true)
		end
	end
	if p_u_99:AreInputsDisabled() then
		return
	else
		for _, v103 in pairs(v_u_24) do
			if v_u_12:InputIs(p100, v103) and v_u_20:IsToggled(v103) then
				v_u_20:ToggleInput(v103, false)
				return p_u_99:SimulateInputEnded(p100, p101)
			end
			if not (v_u_12:InputIs(p100, v103) and p_u_99:_IsToggleInput(v103)) then
				continue
			end
			v_u_20:ToggleInput(v103, true)
		end
		if p101 and (not v_u_17:IsPageOpen("Panels") and v_u_20.CurrentControls == "MouseKeyboard") then
			return
		elseif v_u_21:GetPublicState() == v_u_21.CameraState.States.ThirdPersonUnlockedMouse and p100.UserInputType == Enum.UserInputType.MouseButton2 then
			return
		else
			if v_u_12:InputIs(p100, "OpenPlayerList") then
				if v_u_19.CurrentDuelSubject then
					v_u_19.CurrentDuelSubject.DuelInterface.Scoreboard:Open(true)
				end
			elseif v_u_12:InputIs(p100, "Ping") then
				p_u_99.LocalFighter:Ping()
			end
			if p_u_99:IsAlive() then
				if v_u_12:InputIs(p100, "Jump") and p_u_99.LocalFighter.Entity.Humanoid:GetState() ~= Enum.HumanoidStateType.Climbing then
					if p_u_99.IsSliding then
						p_u_99:HighJump()
					else
						p_u_99:DoubleJumpRequest()
						p_u_99:_SpamJumpRequests()
					end
				elseif v_u_12:InputIs(p100, "Crouch") and not (p_u_99.IsSliding or p_u_99:IsFrozen()) then
					local v104 = p_u_99.IsSprinting or tick() - p_u_99._sprinting_release_time < 0.125
					local v105
					if v_u_20.CurrentControls == "Touch" then
						v105 = v_u_18:GetSetting("Easy Slide Mobile")
					else
						v105 = v_u_18:GetSetting("Easy Slide")
					end
					if v105 and (v104 and (p_u_99.LocalFighter:GetMoveVector(true, true).Magnitude > 0.01 and p_u_99.LocalFighter:IsGrounded())) then
						p_u_99:Slide()
					else
						p_u_99:SetCrouching(true)
					end
				elseif v_u_12:InputIs(p100, "Slide") and (not p_u_99.IsSliding and p_u_99.LocalFighter:IsGrounded()) then
					p_u_99:Slide()
					return
				elseif (v_u_12:InputIs(p100, "Sprint") or v_u_12:InputIs(p100, "AutoSprint")) and not p_u_99.IsSliding then
					p_u_99:SetSprinting(true)
				elseif v_u_12:InputIs(p100, "LeanLeft") then
					if not p_u_99._is_leaning_left then
						p_u_99._is_leaning_left = true
						p_u_99:SetCameraLean(p_u_99.CameraLean - 1)
						return
					end
				elseif v_u_12:InputIs(p100, "LeanRight") then
					if not p_u_99._is_leaning_right then
						p_u_99._is_leaning_right = true
						p_u_99:SetCameraLean(p_u_99.CameraLean + 1)
						return
					end
				else
					if v_u_22:CanEmote() then
						for v106 = 1, v_u_8.MAX_EQUIPPABLE_EMOTES do
							if not v_u_12:InputIs(p100, "UseEmote" .. v106) then
								continue
							end
							v_u_22:UseEmote((tostring(v106)))
						end
					end
					if v_u_12:InputIs(p100, "EquipPrimary") then
						p_u_99.LocalFighter:EquipItem(1)
						return
					end
					if v_u_12:InputIs(p100, "EquipSecondary") then
						p_u_99.LocalFighter:EquipItem(2)
						return
					end
					if v_u_12:InputIs(p100, "EquipMelee") then
						p_u_99.LocalFighter:EquipItem(3)
						return
					end
					if v_u_12:InputIs(p100, "EquipUtility") then
						p_u_99.LocalFighter:EquipItem(4)
						return
					end
					if v_u_12:InputIs(p100, "EquipLast") then
						p_u_99.LocalFighter:EquipIncrement(-1)
						return
					end
					if v_u_12:InputIs(p100, "EquipNext") then
						p_u_99.LocalFighter:EquipIncrement(1)
						return
					end
					if v_u_12:InputIs(p100, "QuickMelee") then
						p_u_99.LocalFighter:QuickAttackDown("Melee", p100)
						return
					end
					if v_u_12:InputIs(p100, "QuickUtility") then
						p_u_99.LocalFighter:QuickAttackDown("Utility", p100)
						return
					end
					if v_u_12:InputIs(p100, "UseEmote") and v_u_22:CanEmote() then
						local v107 = v_u_17:GetPage("PickEmote")
						if not (v107 and v107:IsOpen()) then
							v_u_17:OpenPage("PickEmote", true)
							return
						end
					else
						if p_u_99.LocalFighter.EquippedItem then
							for _, v_u_108 in pairs(v_u_12.ItemInputs) do
								if not v_u_12:InputIs(p100, v_u_108) then
									continue
								end
								task.spawn(function()
									-- upvalues: (ref) v_u_12, (copy) v_u_108, (copy) p_u_99
									local v109 = v_u_12.Inputs[v_u_108].StartName
									if p_u_99.LocalFighter.EquippedItem.Info.InputSpammingEnabled[v109] then
										p_u_99:_InputSpam(v_u_108, v109)
									else
										p_u_99:EquippedItemInput(v109)
									end
								end)
							end
							return
						end
						if v_u_12:InputIs(p100, "Shoot") and (p_u_99.LocalFighter.Entity and p_u_99.LocalFighter.Entity:Get("IsGrabbingSnowball")) then
							local v110 = p_u_99.LocalFighter:GetCameraData(nil, nil, true, true)
							local v111 = v110[utf8.char(2)]
							local v112 = v110[utf8.char(3)]
							if v111 then
								v111 = v111.CFrame * v112
							end
							if v111 then
								v_u_2.Remotes.Replication.Fighter.SnowballThrow:FireServer(v111.Position)
							end
						end
					end
				end
			else
				return
			end
		end
	end
end
function v_u_26.SimulateInputEnded(p113, p114) -- name: SimulateInputEnded
	-- upvalues: (copy) v_u_21, (copy) v_u_24, (copy) v_u_12, (copy) v_u_20, (copy) v_u_19, (copy) v_u_17
	if p113.LocalFighter then
		if v_u_21:GetPublicState() == v_u_21.CameraState.States.ThirdPersonUnlockedMouse and p114.UserInputType == Enum.UserInputType.MouseButton2 then
			return
		else
			for _, v115 in pairs(v_u_24) do
				if not (v_u_12:InputIs(p114, v115) and (p113:_IsToggleInput(v115) and v_u_20:IsToggled(v115))) then
					continue
				end
				return
			end
			if v_u_12:InputIs(p114, "Crouch") then
				if p113.IsCrouching then
					p113:SetCrouching(false)
					if p113:IsInputDown("Sprint") then
						p113:SetSprinting(true)
					end
				end
			elseif v_u_12:InputIs(p114, "Sprint") or v_u_12:InputIs(p114, "AutoSprint") then
				p113:SetSprinting(false)
			elseif v_u_12:InputIs(p114, "LeanLeft") then
				if p113._is_leaning_left then
					p113._is_leaning_left = false
					p113:SetCameraLean(p113.CameraLean + 1)
				end
			elseif v_u_12:InputIs(p114, "LeanRight") and p113._is_leaning_right then
				p113._is_leaning_right = false
				p113:SetCameraLean(p113.CameraLean - 1)
			end
			if v_u_12:InputIs(p114, "QuickMelee") then
				p113.LocalFighter:QuickAttackUp("Melee")
				return
			elseif v_u_12:InputIs(p114, "QuickUtility") then
				p113.LocalFighter:QuickAttackUp("Utility")
			elseif v_u_12:InputIs(p114, "OpenPlayerList") then
				if v_u_19.CurrentDuelSubject then
					v_u_19.CurrentDuelSubject.DuelInterface.Scoreboard:Open(false)
					return
				end
			elseif v_u_12:InputIs(p114, "UseEmote") and v_u_20.CurrentControls == "MouseKeyboard" then
				local v116 = v_u_17:GetPage("PickEmote")
				if v116 then
					v116:PickEarly()
					return
				end
			elseif p113.LocalFighter.EquippedItem then
				for _, v117 in pairs(v_u_12.ItemInputs) do
					if not v_u_12:InputIs(p114, v117) then
						continue
					end
					p113:EquippedItemInput(v_u_12.Inputs[v117].FinishName)
				end
			end
		end
	else
		return
	end
end
function v_u_26.MobileInput(p118, p119, p120) -- name: MobileInput
	-- upvalues: (copy) v_u_12
	if not (p120 and p118:AreInputsDisabled()) then
		local v121 = v_u_12.MobileButtons[p119]
		local v122 = p118._mobile_input_down
		local v123
		if v121 then
			v123 = v121.InputName or p119
		else
			v123 = p119
		end
		v122[v123] = p120
		p118[p120 and "SimulateInputBegan" or "SimulateInputEnded"](p118, p119, false)
	end
end
function v_u_26.WaitForLocalFighter(p124) -- name: WaitForLocalFighter
	if not p124.LocalFighter then
		p124._internal_local_fighter_added:Wait()
	end
	return p124.LocalFighter
end
function v_u_26._CanAutoShoot(p125) -- name: _CanAutoShoot
	-- upvalues: (copy) v_u_20, (copy) v_u_23
	if p125.LocalFighter and (p125.LocalFighter.EquippedItem and not p125.LocalFighter:Get("IsHiddenByCutscene")) then
		return (v_u_20.CurrentControls == "Touch" or v_u_20.CurrentControls == "Gamepad") and true or (p125.LocalFighter:Get("CheaterMode") or v_u_23:Get("AreHandicapsEnabled"))
	else
		return false
	end
end
function v_u_26._ToggleAutoShoot(p_u_126) -- name: _ToggleAutoShoot
	-- upvalues: (copy) v_u_18, (copy) v_u_7, (copy) v_u_15, (copy) v_u_11, (copy) v_u_5, (copy) v_u_14
	p_u_126._auto_shoot_hash = p_u_126._auto_shoot_hash + 1
	local v_u_127 = p_u_126._auto_shoot_hash
	if p_u_126._auto_shoot_connection then
		p_u_126._auto_shoot_connection:Disconnect()
		p_u_126._auto_shoot_connection = nil
	end
	if p_u_126:_CanAutoShoot() then
		local v128 = p_u_126.LocalFighter:Get("CheaterMode")
		local v_u_129 = v128 and 0 or v_u_18:GetSetting("Auto Shoot Reaction Time") / 1000
		local v130
		if v128 then
			v130 = nil
		else
			v130 = v_u_18:GetSetting("Auto Shoot")
		end
		local v131
		if v128 then
			v131 = nil
		else
			v131 = p_u_126.LocalFighter:Get("AutoShootRestriction")
		end
		local v_u_132
		if v128 then
			v_u_132 = nil
		else
			v_u_132 = v131 or v130
		end
		if v130 ~= "Disabled" and v131 ~= "Disabled" then
			local v_u_133 = nil
			local v_u_134 = 0
			local v_u_135 = true
			local function v_u_141() -- name: can_autoshoot
				-- upvalues: (copy) p_u_126, (ref) v_u_134, (ref) v_u_133, (ref) v_u_7, (ref) v_u_15, (ref) v_u_11
				local v136 = p_u_126.LocalFighter and p_u_126.LocalFighter.EquippedItem
				if v136 then
					v136 = p_u_126.LocalFighter:IsAlive()
				end
				if v136 then
					local v137 = p_u_126.LocalFighter.EquippedItem:GetAutoShootReactionTime()
					local v138 = p_u_126.LocalFighter.EquippedItem:GetAutoShootReach()
					if v137 and v138 then
						if v_u_134 < tick() then
							v_u_134 = tick() + 2
							v_u_133 = p_u_126.LocalFighter:GetRaycastWhitelist(true, { p_u_126.LocalFighter }, nil, true)
						end
						if v_u_7.LocalPlayer.PlayerGui:FindFirstChild("FlashbangGui") then
							return
						else
							local v139 = v_u_15:Raycast(workspace.CurrentCamera.CFrame.Position, workspace.CurrentCamera.CFrame.Position + workspace.CurrentCamera.CFrame.LookVector * v138, v138, v_u_133, Enum.RaycastFilterType.Include)
							if v139.Instance then
								if v_u_15:AngleBetweenVectors(workspace.CurrentCamera.CFrame.LookVector, CFrame.new(p_u_126.LocalFighter.Entity.RootPart.Position, v139.Instance.Position).LookVector) < 1.5707963267948966 then
									local v140 = v139.Instance and (v139.Instance.AssemblyRootPart and v139.Instance.AssemblyRootPart.Parent)
									if v140 then
										v140 = v139.Instance.AssemblyRootPart.Parent:HasTag("Entity")
									end
									if v140 then
										v140 = v_u_11:GetEntityFromModel(v139.Instance.AssemblyRootPart.Parent)
									end
									if v140 and (not v140.AimAssistBlacklist and v140:IsAlive()) then
										if not v_u_11:GetSmokeCloudBetweenPoints(workspace.CurrentCamera.CFrame.Position, v139.Position) then
											return p_u_126.LocalFighter.EquippedItem, v137
										end
									end
								else
									return
								end
							else
								return
							end
						end
					else
						return
					end
				else
					return
				end
			end
			local v_u_142 = false
			local function v_u_147(p143) -- name: hold
				-- upvalues: (ref) v_u_142, (copy) p_u_126, (copy) v_u_141, (ref) v_u_135, (ref) v_u_5, (copy) v_u_127
				if v_u_142 then
					return
				else
					v_u_142 = true
					local v144 = p_u_126.LocalFighter.EquippedItem
					local v145 = tick() + p143
					local _, v146 = v_u_141()
					if v146 and p_u_126.LocalFighter.EquippedItem == v144 then
						if v145 < tick() then
							v_u_135 = true
							p_u_126:EquippedItemInput("StartShooting")
							if p_u_126.LocalFighter.EquippedItem and (p_u_126.LocalFighter.EquippedItem.Name ~= "Flamethrower" and v_u_135) then
								v_u_135 = false
								task.delay(0.03, p_u_126.EquippedItemInput, p_u_126, "FinishShooting")
							end
						end
						v_u_5.RenderStepped:Wait()
						if v_u_127 == p_u_126._auto_shoot_hash then
							continue
						end
					else
						v_u_142 = false
					end
				end
			end
			p_u_126._auto_shoot_connection = v_u_5.RenderStepped:Connect(function()
				-- upvalues: (ref) v_u_142, (copy) v_u_141, (ref) v_u_135, (copy) p_u_126, (copy) v_u_132, (ref) v_u_14, (copy) v_u_129, (copy) v_u_147
				if v_u_142 then
					return
				else
					local _, v148 = v_u_141()
					if v148 then
						local v149
						if v_u_132 == "Dynamic" then
							local v150 = v_u_14.AUTO_SHOOT_REACTION_TIME_MIN
							local v151 = v_u_14.AUTO_SHOOT_REACTION_TIME_MAX
							v149 = math.clamp(v148, v150, v151)
						else
							v149 = v_u_129
						end
						task.defer(v_u_147, v149)
						return
					elseif v_u_135 then
						v_u_135 = false
						task.delay(0, p_u_126.EquippedItemInput, p_u_126, "FinishShooting")
					end
				end
			end)
		end
	else
		return
	end
end
function v_u_26._IsToggleInput(p152, p153) -- name: _IsToggleInput
	-- upvalues: (copy) v_u_20, (copy) v_u_25, (copy) v_u_9, (copy) v_u_18
	local v154
	if v_u_20.CurrentControls == "Touch" then
		v154 = v_u_25[p153]
	else
		v154 = nil
	end
	local v155 = "Toggle " .. p153
	local v156 = v154 == nil and v_u_9.Info[v155]
	if v156 then
		v156 = v_u_18:GetSetting(v155)
	end
	local v157 = p152.LocalFighter and p152.LocalFighter.EquippedItem
	if v157 then
		v157 = p152.LocalFighter.EquippedItem.ToggleAimEnabled
	end
	if v156 then
		v156 = p153 ~= "Aim" and true or v157
	end
	return v156
end
function v_u_26._AutoSprintEnabled(_) -- name: _AutoSprintEnabled
	-- upvalues: (copy) v_u_18, (copy) v_u_20
	return v_u_18:GetSetting("Auto Sprint") or v_u_20.CurrentControls == "Touch"
end
function v_u_26._UpdateServerState(_, p158, ...) -- name: _UpdateServerState
	-- upvalues: (copy) v_u_2, (copy) v_u_13
	v_u_2.Remotes.Replication.Fighter.UpdateState:FireServer(v_u_13:ToEnum(p158), ...)
end
function v_u_26._InputSpam(p159, p160, p161) -- name: _InputSpam
	-- upvalues: (copy) v_u_5
	if p159._is_input_spamming[p160] then
		return
	end
	p159._is_input_spamming[p160] = true
	while p159.LocalFighter and (p159.LocalFighter.EquippedItem and (p159.LocalFighter.EquippedItem.Info.InputSpammingEnabled[p161] and (p159:IsInputDown(p160) and not p159.LocalFighter:Get("IsHiddenByCutscene")))) do
		local v162 = p159:_IsToggleInput(p160)
		p159:EquippedItemInput(p161)
		local v163 = not v162 and p159.LocalFighter.EquippedItem.Info.InputSpammingEnabled[p161]
		if not v163 then
			break
		end
		if v163 <= 0 then
			v_u_5.RenderStepped:Wait()
		else
			wait(v163)
		end
	end
	p159._is_input_spamming[p160] = false
end
function v_u_26._SpamJumpRequests(p164, ...) -- name: _SpamJumpRequests
	-- upvalues: (copy) v_u_5
	while not p164.IsSliding and p164:IsInputDown("Jump") do
		p164:JumpRequest(...)
		v_u_5.RenderStepped:Wait()
	end
end
function v_u_26._GetWalkSpeed(p165, p166) -- name: _GetWalkSpeed
	-- upvalues: (copy) v_u_17, (copy) v_u_10, (copy) v_u_8
	if p165:IsFrozen() then
		return 0
	end
	local v167 = p165.LocalFighter.Entity:IsEmoting()
	local v168 = p165.LocalFighter.Entity:GetCurrentEmote()
	local v169 = v_u_17:IsPageOpen()
	local v170 = (p165.IsSprinting and not v167 and (p165.LocalFighter:Get("SprintingSpeedBoost") or 0.5) or 0) + (p165.LocalFighter and p165.LocalFighter.Entity and (p165.LocalFighter.Entity:GetBoost("Speed") or 0) or 0)
	local v171 = v169 and v169.Name == "PickEmote" and 0 or 1
	local v172 = v167 and v_u_10.Cosmetics[v168.Name].TraversalWalkSpeedMultiplier or 1
	local v173 = p165.LocalFighter and p165.LocalFighter.EquippedItem and (p165.LocalFighter.EquippedItem.Info.WalkSpeedMultiplier or 1) or 1
	local v174 = p165.IsCrouching and 0.5 or 1
	local v175 = p165.IsSliding and not p166 and 0 or 1
	local v176 = v171 * v172 * v173 * v174 * v175
	return v_u_8.BASE_WALKSPEED * (1 + v170) * v176
end
function v_u_26._UpdateWalkSpeed(p177) -- name: _UpdateWalkSpeed
	if not p177.IsSliding and p177:IsAlive() then
		p177.LocalFighter.Entity.Humanoid.WalkSpeed = p177:_GetWalkSpeed()
	end
end
function v_u_26._UpdateCharacterRotation(p178) -- name: _UpdateCharacterRotation
	-- upvalues: (copy) v_u_21
	if p178.IsSliding or not p178:IsAlive() then
		return
	else
		local v179 = v_u_21:GetPublicState()
		local v180 = p178.LocalFighter.Entity:IsEmoting()
		p178.LocalFighter.Entity.Humanoid.AutoRotate = not v179 or v179 == v_u_21.CameraState.States.ThirdPersonUnlockedMouse
		if v179 and (v179 ~= v_u_21.CameraState.States.CustomFreecam and (v179 ~= v_u_21.CameraState.States.ThirdPersonUnlockedMouse or not v180)) then
			local v181 = workspace.CurrentCamera.CFrame.LookVector * Vector3.new(1, 0, 1)
			if v181.Magnitude > 0.01 then
				p178.LocalFighter.Entity.RootPart.CFrame = CFrame.new(p178.LocalFighter.Entity.RootPart.Position, p178.LocalFighter.Entity.RootPart.Position + v181)
			end
		end
	end
end
function v_u_26._SetupControls(p_u_182) -- name: _SetupControls
	-- upvalues: (copy) v_u_5, (copy) v_u_20, (copy) v_u_3, (copy) v_u_21, (copy) v_u_18
	for _, v183 in pairs(p_u_182._controls_connections) do
		v183:Disconnect()
	end
	p_u_182._controls_connections = {}
	if p_u_182:IsMobileInputDown("AutoSprint") then
		task.spawn(p_u_182.MobileInput, p_u_182, "AutoSprint", false)
	end
	if p_u_182.LocalFighter then
		v_u_5.RenderStepped:Connect(function()
			-- upvalues: (copy) p_u_182
			p_u_182:_UpdateCharacterRotation()
			p_u_182:_UpdateWalkSpeed()
			if p_u_182:_AutoSprintEnabled() then
				local v184 = p_u_182.LocalFighter and not p_u_182.IsCrouching
				if v184 then
					v184 = not p_u_182.IsSliding
				end
				if v184 then
					v184 = p_u_182.LocalFighter:GetMoveVector()
				end
				if v184 then
					v184 = v184.Magnitude >= 0.9
				end
				if v184 and not p_u_182.IsSprinting then
					p_u_182:MobileInput("AutoSprint", true)
				elseif not v184 and p_u_182.IsSprinting then
					p_u_182:MobileInput("AutoSprint", false)
				end
			else
				return
			end
		end)
		if v_u_20.CurrentControls ~= "Touch" then
			local v185 = p_u_182._controls_connections
			local v186 = v_u_3.InputBegan
			table.insert(v185, v186:Connect(function(...)
				-- upvalues: (copy) p_u_182
				p_u_182:SimulateInputBegan(...)
			end))
			local v187 = p_u_182._controls_connections
			local v188 = v_u_3.InputEnded
			table.insert(v187, v188:Connect(function(...)
				-- upvalues: (copy) p_u_182
				p_u_182:SimulateInputEnded(...)
			end))
			if v_u_20.CurrentControls == "MouseKeyboard" then
				local v189 = p_u_182._controls_connections
				local v190 = v_u_3.InputChanged
				local function v198(p191, p192)
					-- upvalues: (ref) v_u_21, (copy) p_u_182, (ref) v_u_18
					if not p192 and (v_u_21:GetPublicState() ~= v_u_21.CameraState.States.ThirdPersonUnlockedMouse and (p_u_182:IsAlive() and v_u_18:GetSetting("Scroll Equip"))) then
						if p191.UserInputType == Enum.UserInputType.MouseWheel then
							local v193 = p_u_182._scroll_delta + p191.Position.Z
							local v194 = math.floor(v193)
							local v195 = p_u_182._scroll_delta
							local v196 = v194 - math.floor(v195)
							local v197 = p_u_182
							v197._scroll_delta = v197._scroll_delta + p191.Position.Z
							if math.abs(v196) > 0 then
								p_u_182.LocalFighter:EquipIncrement(-math.sign(v196))
							end
						end
					end
				end
				table.insert(v189, v190:Connect(v198))
			end
		end
	else
		return
	end
end
function v_u_26._BindMovementActionsLoop(_) -- name: _BindMovementActionsLoop
	-- upvalues: (copy) v_u_7, (copy) v_u_1, (copy) v_u_12, (copy) v_u_18
	local v_u_199 = require(v_u_7.LocalPlayer.PlayerScripts:WaitForChild("PlayerModule"):WaitForChild("ControlModule"))
	local v_u_200 = require(v_u_7.LocalPlayer.PlayerScripts:WaitForChild("PlayerModule"):WaitForChild("ControlModule"):WaitForChild("Keyboard"))
	local v_u_217 = {
		["WalkForward"] = { "moveForwardAction", function(_, p201, _)
				-- upvalues: (copy) v_u_199, (copy) v_u_200
				for v202, v204 in pairs(v_u_199.controllers) do
					if v202 ~= v_u_200 then
						continue
					end
				end
				local v204 = nil
				if v204 then
					v204.forwardValue = p201 == Enum.UserInputState.Begin and -1 or 0
					v204:UpdateMovement(p201)
					return Enum.ContextActionResult.Pass
				end
			end },
		["WalkBackward"] = { "moveBackwardAction", function(_, p205, _)
				-- upvalues: (copy) v_u_199, (copy) v_u_200
				for v206, v208 in pairs(v_u_199.controllers) do
					if v206 ~= v_u_200 then
						continue
					end
				end
				local v208 = nil
				if v208 then
					v208.backwardValue = p205 == Enum.UserInputState.Begin and 1 or 0
					v208:UpdateMovement(p205)
					return Enum.ContextActionResult.Pass
				end
			end },
		["WalkLeftward"] = { "moveLeftAction", function(_, p209, _)
				-- upvalues: (copy) v_u_199, (copy) v_u_200
				for v210, v212 in pairs(v_u_199.controllers) do
					if v210 ~= v_u_200 then
						continue
					end
				end
				local v212 = nil
				if v212 then
					v212.leftValue = p209 == Enum.UserInputState.Begin and -1 or 0
					v212:UpdateMovement(p209)
					return Enum.ContextActionResult.Pass
				end
			end },
		["WalkRightward"] = { "moveRightAction", function(_, p213, _)
				-- upvalues: (copy) v_u_199, (copy) v_u_200
				for v214, v216 in pairs(v_u_199.controllers) do
					if v214 ~= v_u_200 then
						continue
					end
				end
				local v216 = nil
				if v216 then
					v216.rightValue = p213 == Enum.UserInputState.Begin and 1 or 0
					v216:UpdateMovement(p213)
					return Enum.ContextActionResult.Pass
				end
			end }
	}
	local function v_u_223(p218) -- name: update
		-- upvalues: (copy) v_u_217, (ref) v_u_1, (ref) v_u_12
		local v219 = v_u_217[p218]
		local v220, v221 = table.unpack(v219)
		if v_u_1:GetBoundActionInfo(v220) then
			v_u_1:UnbindAction(v220)
		end
		local v222 = v_u_12:GetInputs(p218)
		if v222 and #v222 > 0 then
			v_u_1:BindActionAtPriority(v220, v221, false, 2000, table.unpack(v222))
		end
	end
	for v_u_224 in pairs(v_u_217) do
		for _, v225 in pairs(v_u_12.HOTKEY_FORMATS) do
			for _, v226 in pairs(v225) do
				v_u_18:GetSettingChangedSignal(string.format(v226, v_u_224)):Connect(function()
					-- upvalues: (copy) v_u_223, (copy) v_u_224
					v_u_223(v_u_224)
				end)
			end
		end
	end
	while true do
		for v227, v228 in pairs(v_u_217) do
			local v229, _ = table.unpack(v228)
			local v230 = v_u_1:GetBoundActionInfo(v229)
			local v231 = not (v230 and (v230.inputTypes and v230.inputTypes[1]))
			if not v231 then
				local v232 = v230.inputTypes[1]
				if typeof(v232) == "EnumItem" then
					v231 = v230.inputTypes[1].EnumType == Enum.PlayerActions
				else
					v231 = false
				end
			end
			if not v231 then
				continue
			end
			v_u_223(v227)
		end
		wait(1)
	end
end
function v_u_26._DisableRobloxJumpButton(_) -- name: _DisableRobloxJumpButton
	-- upvalues: (copy) v_u_1
	while true do
		if next(v_u_1:GetBoundActionInfo("jumpAction") or {}) then
			v_u_1:UnbindAction("jumpAction")
		end
		wait(1)
	end
end
function v_u_26._HookFighter(p_u_233) -- name: _HookFighter
	-- upvalues: (copy) v_u_7, (copy) v_u_18, (copy) v_u_8
	p_u_233.LocalFighter = require(v_u_7.LocalPlayer.PlayerScripts.Controllers.FighterController):WaitForLocalFighter()
	p_u_233.LocalFighter.StopSliding:Connect(function()
		-- upvalues: (copy) p_u_233
		p_u_233:StopSliding()
	end)
	p_u_233.LocalFighter:GetDataChangedSignal("AutoShootRestriction"):Connect(function()
		-- upvalues: (copy) p_u_233
		p_u_233:_ToggleAutoShoot()
	end)
	p_u_233.LocalFighter:GetDataChangedSignal("CheaterMode"):Connect(function()
		-- upvalues: (copy) p_u_233
		p_u_233:_ToggleAutoShoot()
	end)
	p_u_233.LocalFighter:GetDataChangedSignal("IsHiddenByCutscene"):Connect(function()
		-- upvalues: (copy) p_u_233
		p_u_233:_ToggleAutoShoot()
	end)
	local v_u_234 = {}
	p_u_233.LocalFighter.EquippedItemChanged:Connect(function(p235)
		-- upvalues: (ref) v_u_234, (copy) p_u_233
		for _, v236 in pairs(v_u_234) do
			v236:Disconnect()
		end
		v_u_234 = {}
		p_u_233:_UpdateWalkSpeed()
		p_u_233:_ToggleAutoShoot()
		if p235 then
			local v237 = v_u_234
			local v238 = p235.StopSprinting
			local function v239()
				-- upvalues: (ref) p_u_233
				p_u_233:SetSprinting(false)
			end
			table.insert(v237, v238:Connect(v239))
			local v240 = v_u_234
			local v241 = p235.AttemptToSprintAgain
			local function v242()
				-- upvalues: (ref) p_u_233
				if p_u_233:IsInputDown("Sprint") or p_u_233:IsInputDown("AutoSprint") then
					p_u_233:SetSprinting(true)
				end
			end
			table.insert(v240, v241:Connect(v242))
		end
	end)
	local function v243() -- name: update_auto_jump
		-- upvalues: (copy) p_u_233, (ref) v_u_18
		if p_u_233.LocalFighter.Entity and p_u_233.LocalFighter.Entity.Humanoid then
			p_u_233.LocalFighter.Entity.Humanoid.AutoJumpEnabled = v_u_18:GetSetting("Auto Jump") or p_u_233.LocalFighter.Entity:IsAirborne()
		end
	end
	v_u_18:GetSettingChangedSignal("Auto Jump"):Connect(v243)
	local function v266(p_u_244) -- name: entity_added
		-- upvalues: (copy) p_u_233, (ref) v_u_8, (ref) v_u_18
		p_u_233._original_humanoid_animations = {}
		p_u_233._double_jumps_used = {}
		p_u_233:SetCrouching(false)
		p_u_233:SetSprinting(false)
		p_u_233:StopSliding()
		p_u_233:_UpdateWalkSpeed()
		p_u_244.Humanoid.CameraOffset = Vector3.new(0, 1, 0)
		local v_u_245 = Instance.new("BodyForce")
		v_u_245.Name = "CustomGravity"
		v_u_245.Parent = p_u_244.RootPart
		local function v_u_250() -- name: update_gravity
			-- upvalues: (ref) p_u_233, (copy) p_u_244, (ref) v_u_8, (copy) v_u_245
			local v246 = not p_u_233.IsCrouching and p_u_244:Get("Gravity") or 1
			local v247 = v_u_8.BASE_GRAVITY * v246
			local v248 = v_u_245
			local v249 = p_u_244.RootPart.AssemblyMass * workspace.Gravity * (1 - v247)
			v248.Force = Vector3.new(0, v249, 0)
			p_u_244.Humanoid.JumpPower = v_u_8.BASE_JUMPPOWER
		end
		p_u_244:GetDataChangedSignal("Gravity"):Connect(v_u_250)
		p_u_244.EmoteStatusChanged:Connect(v_u_250)
		p_u_233.StateChanged:Connect(v_u_250)
		local v251 = p_u_233.IsCrouching and 1 or (p_u_244:Get("Gravity") or 1)
		local v252 = v_u_8.BASE_GRAVITY * v251
		local v253 = p_u_244.RootPart.AssemblyMass * workspace.Gravity * (1 - v252)
		v_u_245.Force = Vector3.new(0, v253, 0)
		p_u_244.Humanoid.JumpPower = v_u_8.BASE_JUMPPOWER
		p_u_244.Model.DescendantAdded:Connect(function(p254) -- name: descendant_added
			-- upvalues: (copy) v_u_250
			if p254:IsA("BasePart") then
				p254:GetPropertyChangedSignal("AssemblyMass"):Connect(v_u_250)
				p254:GetPropertyChangedSignal("Mass"):Connect(v_u_250)
			end
		end)
		for _, v255 in pairs(p_u_244.Model:GetDescendants()) do
			if not v255:IsA("BasePart") then
				continue
			end
			v255:GetPropertyChangedSignal("AssemblyMass"):Connect(v_u_250)
			v255:GetPropertyChangedSignal("Mass"):Connect(v_u_250)
		end
		p_u_244.Humanoid.Jumping:Connect(function()
			-- upvalues: (ref) p_u_233, (copy) p_u_244, (ref) v_u_8, (copy) v_u_245
			local v256 = not p_u_233.IsCrouching and p_u_244:Get("Gravity") or 1
			local v257 = v_u_8.BASE_GRAVITY * v256
			local v258 = v_u_245
			local v259 = p_u_244.RootPart.AssemblyMass * workspace.Gravity * (1 - v257)
			v258.Force = Vector3.new(0, v259, 0)
			p_u_244.Humanoid.JumpPower = v_u_8.BASE_JUMPPOWER
			p_u_233:StopSliding(true)
		end)
		p_u_244.Humanoid.StateChanged:Connect(function(_, p260)
			-- upvalues: (ref) p_u_233, (copy) p_u_244, (ref) v_u_8, (copy) v_u_245
			local v261 = p_u_233.IsCrouching and 1 or (p_u_244:Get("Gravity") or 1)
			local v262 = v_u_8.BASE_GRAVITY * v261
			local v263 = v_u_245
			local v264 = p_u_244.RootPart.AssemblyMass * workspace.Gravity * (1 - v262)
			v263.Force = Vector3.new(0, v264, 0)
			p_u_244.Humanoid.JumpPower = v_u_8.BASE_JUMPPOWER
			if p260 == Enum.HumanoidStateType.Climbing then
				p_u_233:StopSliding()
			elseif p260 == Enum.HumanoidStateType.Landed then
				p_u_233._double_jumps_used = {}
			end
		end)
		p_u_244.Humanoid.Died:Connect(function()
			-- upvalues: (ref) p_u_233
			p_u_233:SetSprinting(false)
			p_u_233:SetCrouching(false)
			p_u_233:StopSliding()
		end)
		p_u_244.AirborneChanged:Connect(function()
			-- upvalues: (ref) p_u_233, (copy) p_u_244, (ref) v_u_18
			p_u_233:_UpdateServerState("IsAirborne", p_u_244:IsAirborne())
			if p_u_233.LocalFighter.Entity and p_u_233.LocalFighter.Entity.Humanoid then
				p_u_233.LocalFighter.Entity.Humanoid.AutoJumpEnabled = v_u_18:GetSetting("Auto Jump") or p_u_233.LocalFighter.Entity:IsAirborne()
			end
		end)
		p_u_244.RedirectSliding:Connect(function(p265)
			-- upvalues: (ref) p_u_233
			if p_u_233._update_slide_direction then
				p_u_233._update_slide_direction(p265)
			end
		end)
		if p_u_233.LocalFighter.Entity and p_u_233.LocalFighter.Entity.Humanoid then
			p_u_233.LocalFighter.Entity.Humanoid.AutoJumpEnabled = v_u_18:GetSetting("Auto Jump") or p_u_233.LocalFighter.Entity:IsAirborne()
		end
	end
	p_u_233.LocalFighter.EntityAdded:Connect(v266)
	if p_u_233.LocalFighter.Entity then
		task.spawn(v266, p_u_233.LocalFighter.Entity)
	end
	p_u_233._internal_local_fighter_added:Fire()
	p_u_233:_SetupControls()
	p_u_233:_ToggleAutoShoot()
	task.defer(p_u_233._DisableRobloxJumpButton, p_u_233)
	task.defer(p_u_233._BindMovementActionsLoop, p_u_233)
end
function v_u_26._Init(p_u_267) -- name: _Init
	-- upvalues: (copy) v_u_20, (copy) v_u_18, (copy) v_u_23
	v_u_20.ControlsChanged:Connect(function()
		-- upvalues: (copy) p_u_267
		p_u_267:_SetupControls()
		p_u_267:_ToggleAutoShoot()
	end)
	v_u_18:GetSettingChangedSignal("Auto Shoot"):Connect(function()
		-- upvalues: (copy) p_u_267
		p_u_267:_ToggleAutoShoot()
	end)
	v_u_18:GetSettingChangedSignal("Auto Shoot Reaction Time"):Connect(function()
		-- upvalues: (copy) p_u_267
		p_u_267:_ToggleAutoShoot()
	end)
	v_u_23:GetDataChangedSignal("AreHandicapsEnabled"):Connect(function()
		-- upvalues: (copy) p_u_267
		p_u_267:_ToggleAutoShoot()
	end)
	task.defer(p_u_267._HookFighter, p_u_267)
end
return v_u_26._new()