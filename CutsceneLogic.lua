local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("UserInputService")
local v_u_3 = game:GetService("ContentProvider")
local v_u_4 = game:GetService("TweenService")
local v_u_5 = game:GetService("HttpService")
local v_u_6 = game:GetService("RunService")
local v7 = game:GetService("Players")
local v_u_8 = require(v1.Modules.SoundLibrary)
local v_u_9 = require(v7.LocalPlayer.PlayerScripts.Controllers.CameraController)
local v_u_10 = require(v7.LocalPlayer.PlayerScripts.Modules.StaticModel.StaticViewModel)
local v_u_11 = {}
v_u_11.__index = v_u_11
function v_u_11.new(p12) -- name: new
	-- upvalues: (copy) v_u_11
	local v13 = v_u_11
	local v14 = setmetatable({}, v13)
	v14.BaseTower = p12
	v14._preloaded_sounds = {}
	v14._preloaded_animations = {}
	v14._cutscene_hash = 0
	v14._cutscene_renderstep_id = nil
	v14._cutscene_animation_tracks = {}
	v14._cutscene_cleanup = {}
	v14._cutscene_threads = {}
	v14._cutscene_hidden_duelers = {}
	v14:_Init()
	return v14
end
function v_u_11.GetCutsceneHash(p15) -- name: GetCutsceneHash
	return p15._cutscene_hash
end
function v_u_11.GetPreloadedAnimation(p16, p17) -- name: GetPreloadedAnimation
	return p16._preloaded_animations[p17]
end
function v_u_11.PreloadAnimation(p18, p19, p20) -- name: PreloadAnimation
	-- upvalues: (copy) v_u_3
	local v21 = Instance.new("Animation")
	v21.AnimationId = p20
	p18._preloaded_animations[p19] = v21
	task.spawn(pcall, v_u_3.PreloadAsync, v_u_3, { v21 })
end
function v_u_11.PlayAnimation(p22, p23, p24, p25) -- name: PlayAnimation
	if p23 then
		local v26 = p23.LoadAnimation
		local v27, v28 = pcall(v26, p23, p24)
		if v27 then
			v28:Play(0)
			local v29 = p22._cutscene_animation_tracks
			table.insert(v29, v28)
			local v30 = p22._cutscene_threads
			local v31 = task.spawn
			table.insert(v30, v31(p25, v28))
		else
			warn("Animation " .. p24.AnimationId .. " failed to animate, error:", v28)
		end
	else
		return
	end
end
function v_u_11.StopCutscene(p32) -- name: StopCutscene
	-- upvalues: (copy) v_u_6
	p32._cutscene_hash = p32._cutscene_hash + 1
	for _, v33 in pairs(p32._cutscene_animation_tracks) do
		v33:Stop(0)
		v33:Destroy()
	end
	for _, v34 in pairs(p32._cutscene_cleanup) do
		v34:Destroy()
	end
	for _, v35 in pairs(p32._cutscene_threads) do
		local v36 = task.cancel
		pcall(v36, v35)
	end
	for v37 in pairs(p32._cutscene_hidden_duelers) do
		v37:SetReplicate("IsHiddenByCutscene", nil)
	end
	p32._cutscene_animation_tracks = {}
	p32._cutscene_cleanup = {}
	p32._cutscene_threads = {}
	p32._cutscene_hidden_duelers = {}
	if p32._cutscene_renderstep_id then
		v_u_6:UnbindFromRenderStep(p32._cutscene_renderstep_id)
		p32._cutscene_renderstep_id = nil
	end
end
function v_u_11.PlayCutscene(p_u_38, p39, p40, p41, p42, p43, p_u_44, p45, p_u_46, p47) -- name: PlayCutscene
	-- upvalues: (copy) v_u_5, (copy) v_u_10, (copy) v_u_2, (copy) v_u_4, (copy) v_u_6, (copy) v_u_9
	p_u_38:StopCutscene()
	p_u_38._cutscene_renderstep_id = "ZombieTowerCutscene" .. v_u_5:GenerateGUID(false)
	p_u_38._cutscene_hash = p_u_38._cutscene_hash + 1
	local v_u_48 = p_u_38._cutscene_hash
	if p40 then
		local v49 = p_u_38._cutscene_threads
		local v50 = task.spawn
		local v51 = p_u_38._cutscene_cleanup
		local v52 = p_u_38._cutscene_animation_tracks
		table.insert(v49, v50(p40, v_u_48, v51, v52))
	end
	local v_u_53 = p42.Parent.HumanoidRootPart
	local v54 = {}
	local v_u_55 = {}
	local v_u_56 = {}
	local v_u_57 = { p41 }
	for _, v58 in pairs(p_u_38.BaseTower.ClientDuel.Duelers) do
		if not v58.ClientFighter then
			continue
		end
		v58.ClientFighter:SetReplicate("IsHiddenByCutscene", true)
		p_u_38._cutscene_hidden_duelers[v58.ClientFighter] = true
		if not v58.ClientFighter:IsAlive() or #v54 >= p45 then
			continue
		end
		table.insert(v54, v58)
	end
	if #v54 == 0 then
		return
	else
		table.sort(v54, function(p59, p60)
			return p59.Player.UserId < p60.Player.UserId
		end)
		for v_u_61, v62 in pairs(v54) do
			local v_u_63 = v62:GetCharacterModelForCutscene()
			v_u_63.Name = "CutscenePlayer" .. v_u_61
			v_u_63:SetPrimaryPartCFrame(v_u_53.CFrame)
			v_u_63.Parent = p42.Parent.Parent
			table.insert(v_u_55, v_u_63)
			local v64 = p_u_38._cutscene_cleanup
			table.insert(v64, v_u_63)
			if p47 then
				local v65 = v62.ClientFighter.EquippedItem
				if v65 then
					v65 = v62.ClientFighter.EquippedItem:GetViewModelDetails()
				end
				local v66
				if v65 then
					v66 = v_u_10.new(v65.ViewModelName)
				else
					v66 = v65
				end
				if v66 then
					if v66:HasGripAttachment() then
						v66:DeleteAnimationContextSubModels()
						v66:SetWrap(v65.Wrap)
						v66:SetCharm(v65.Charm)
						v66:ScaleTo(v_u_61 == 1 and 1.5 or 1.25)
						v66:InitializeGrip()
						v66:SetParent(v_u_63)
						local v67 = p_u_38._cutscene_cleanup
						table.insert(v67, v66)
						v_u_56[v66] = v_u_63
					else
						task.defer(v66.Destroy, v66)
					end
				end
			end
			local v70, v71 = pcall(function()
				-- upvalues: (copy) v_u_63, (copy) p_u_38, (copy) p_u_46, (copy) v_u_61
				local v68 = v_u_63.Humanoid:LoadAnimation(p_u_38:GetPreloadedAnimation(p_u_46 .. v_u_61))
				v68:Play(0)
				local v69 = p_u_38._cutscene_animation_tracks
				table.insert(v69, v68)
			end)
			if v70 then
				continue
			end
			warn("Player " .. v_u_61 .. " failed to animate, error:", v71)
			v_u_63.Parent = nil
		end
		table.insert(v_u_57, function(_)
			-- upvalues: (copy) v_u_55, (copy) v_u_53, (copy) v_u_56
			for _, v72 in pairs(v_u_55) do
				v72:SetPrimaryPartCFrame(v_u_53.CFrame)
			end
			for v73, v74 in pairs(v_u_56) do
				v73:GripPivotTo(v74)
			end
		end)
		local v_u_75 = p42.Parent:FindFirstChild("Cam")
		if v_u_75 then
			p_u_38:PlayAnimation(p42, p43, function(_)
				-- upvalues: (copy) p_u_44, (copy) v_u_57, (ref) v_u_2, (copy) v_u_75, (ref) v_u_4, (ref) v_u_6, (copy) v_u_48, (copy) p_u_38
				local v_u_76 = p_u_44[1][2]
				local v77 = v_u_57
				local function v78(_)
					-- upvalues: (ref) v_u_2, (ref) v_u_76, (ref) v_u_75
					v_u_2.MouseIconEnabled = true
					v_u_2.MouseBehavior = Enum.MouseBehavior.Default
					workspace.CurrentCamera.FieldOfView = v_u_76
					workspace.CurrentCamera.CFrame = v_u_75.CFrame
				end
				table.insert(v77, v78)
				local v79 = 0
				for v80, v81 in pairs(p_u_44) do
					local v82 = p_u_44
					local v83 = v80 - 1
					local v84 = v82[math.max(1, v83)][2]
					local _, v85, v86, v87, v88 = table.unpack(v81)
					local v89 = v81[1] - v79
					if not v86 then
						local v90 = tick()
						if tick() >= v90 + v89 then
							continue
						end
						if v89 == 0 then
							v_u_76 = v85
						else
							v_u_76 = v84 + (v85 - v84) * v_u_4:GetValue((tick() - v90) / v89, v87 or Enum.EasingStyle.Quad, v88 or Enum.EasingDirection.InOut)
						end
						v79 = v79 + v_u_6.RenderStepped:Wait()
						if v_u_48 == p_u_38._cutscene_hash then
							continue
						end
						return
					end
					v79 = v79 + wait(v89)
					v_u_76 = v85
				end
			end)
			v_u_6:BindToRenderStep(p_u_38._cutscene_renderstep_id, v_u_9:GetRenderstepPriority() + 1, function(p91)
				-- upvalues: (copy) p_u_38, (copy) v_u_57
				if p_u_38.BaseTower.ClientDuel:Get("IsSpectating") then
					for _, v92 in pairs(v_u_57) do
						v92(p91)
					end
				end
			end)
			wait(p39)
			if v_u_48 == p_u_38._cutscene_hash then
				p_u_38:StopCutscene()
			end
		else
			return
		end
	end
end
function v_u_11.PreloadCutsceneSoundIDs(p93, p94) -- name: PreloadCutsceneSoundIDs
	-- upvalues: (copy) v_u_8
	for _, v95 in pairs(v_u_8:PreloadSounds(p94)) do
		local v96 = p93._preloaded_sounds
		table.insert(v96, v95)
	end
end
function v_u_11.Destroy(p97) -- name: Destroy
	for _, v98 in pairs(p97._preloaded_sounds) do
		v98:Destroy()
	end
	for _, v99 in pairs(p97._preloaded_animations) do
		v99:Destroy()
	end
	p97:StopCutscene()
end
function v_u_11._Init(_) -- name: _Init end
return v_u_11