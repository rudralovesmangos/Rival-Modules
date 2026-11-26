local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("Players")
local v_u_3 = require(v1.Modules.CONSTANTS)
local v_u_4 = require(v1.Modules.ReplicatedClass)
local v_u_5 = require(v1.Modules.DuelLibrary)
local v_u_6 = require(v1.Modules.ItemLibrary)
local v_u_7 = require(v1.Modules.Utility)
local v_u_8 = require(v1.Modules.Signal)
local v_u_9 = require(v_u_2.LocalPlayer.PlayerScripts.Controllers.PlayerDataController)
require(v_u_2.LocalPlayer.PlayerScripts.Controllers.SpectateController)
local v_u_10 = require(script:WaitForChild("HeadHoncho"))
local v_u_11 = v_u_2.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("AllyLabel")
local v_u_12 = v_u_2.LocalPlayer.PlayerScripts.Assets.Misc:WaitForChild("DefaultDueler")
local v_u_13 = v_u_3.IS_MATCHMAKING_SERVER
local v_u_14 = setmetatable({}, v_u_4)
v_u_14.__index = v_u_14
function v_u_14.new(p15, p16, p17) -- name: new
	-- upvalues: (copy) v_u_4, (copy) v_u_14, (copy) v_u_8, (copy) v_u_10
	local v18 = v_u_4.new(p15)
	local v19 = v_u_14
	local v20 = setmetatable(v18, v19)
	v20.Died = v_u_8.new()
	v20.EntityAdded = v_u_8.new()
	v20.HealthChanged = v_u_8.new()
	v20.Eliminated = v_u_8.new()
	v20.ItemAdded = v_u_8.new()
	v20.ItemRemoved = v_u_8.new()
	local v21 = p15.Player
	if not v21 then
		if p16 then
			v21 = p16.Player
		else
			v21 = p16
		end
	end
	v20.Player = v21
	v20.ClientFighter = p16
	v20.ClientDuel = p17
	v20.IsLocalPlayer = v20.ClientFighter.IsLocalPlayer
	v20.HeadHoncho = v_u_10.new(v20)
	v20._destroyed = false
	v20._connections = {}
	v20._is_ally = false
	v20._ally_highlight = nil
	v20._ally_label = nil
	v20._preloaded_character_model = nil
	v20._is_preloading_character_model = false
	v20._recorded_viewmodel_details = {}
	v20._viewmodel_detail_check = {}
	v20:_Init()
	return v20
end
function v_u_14.IsAlive(p22) -- name: IsAlive
	local v23 = p22.ClientFighter
	if v23 then
		v23 = p22.ClientFighter:IsAlive()
	end
	return v23
end
function v_u_14.IsRendered(p24) -- name: IsRendered
	return p24.ClientDuel:IsRendered()
end
function v_u_14.CanShowRankToLocalPlayer(p25) -- name: CanShowRankToLocalPlayer
	-- upvalues: (copy) v_u_13
	local v26 = (v_u_13 and not p25.IsLocalPlayer and true or false) and ((p25.ClientDuel.LocalDueler and true or false) and p25.ClientDuel.LocalDueler:Get("TeamID"))
	if v26 then
		v26 = p25.ClientDuel.LocalDueler:Get("TeamID") == p25:Get("TeamID")
	end
	return v26
end
function v_u_14.GetHealth(p27) -- name: GetHealth
	return p27.ClientFighter and p27.ClientFighter:GetHealth() or 0
end
function v_u_14.GetMaxHealth(p28) -- name: GetMaxHealth
	return p28.ClientFighter and p28.ClientFighter:GetMaxHealth() or 100
end
function v_u_14.GetCharacterModel(p29) -- name: GetCharacterModel
	-- upvalues: (copy) v_u_12
	return (p29._preloaded_character_model or v_u_12):Clone()
end
function v_u_14.GetCharacterModelForCutscene(p30) -- name: GetCharacterModelForCutscene
	-- upvalues: (copy) v_u_12
	local v31 = (p30._preloaded_character_model or v_u_12):Clone()
	for _, v32 in pairs(v31:GetDescendants()) do
		if not v32:IsA("BasePart") then
			continue
		end
		v32.CanCollide = false
		v32.CanTouch = false
		v32.CanQuery = false
	end
	if v31:FindFirstChild("HumanoidRootPart") then
		v31.HumanoidRootPart.Anchored = true
	end
	return v31
end
function v_u_14.GetRandomPlayedViewModelDetails(p33, p34) -- name: GetRandomPlayedViewModelDetails
	-- upvalues: (copy) v_u_7
	table.sort(p33._recorded_viewmodel_details, function(p35, p36)
		-- upvalues: (ref) v_u_7
		return v_u_7:StringLessThan(p35.ViewModelName, p36.ViewModelName)
	end)
	local v37
	if #p33._recorded_viewmodel_details > 0 then
		v37 = p33._recorded_viewmodel_details[(p34 or Random.new()):NextInteger(1, #p33._recorded_viewmodel_details)]
	else
		v37 = false
	end
	return v37
end
function v_u_14.GetStaggeredSpawnsTurn(p38) -- name: GetStaggeredSpawnsTurn
	return table.find(p38.ClientDuel:Get("StaggeredSpawnsOrder") and (p38.ClientDuel:Get("StaggeredSpawnsOrder")[p38:Get("TeamID")] or {}) or {}, p38.Player.UserId)
end
function v_u_14.SetAlly(p39, p40) -- name: SetAlly
	p39._is_ally = p40
	p39:_UpdateAllyVisuals()
end
function v_u_14.ReplicateFromServer(p41, p42, ...) -- name: ReplicateFromServer
	-- upvalues: (copy) v_u_4
	if p42 == "EliminationFeed" then
		if p41:IsRendered() then
			p41.ClientDuel.DuelInterface.EliminationFeed:Play(p41.Player, ...)
		end
	elseif p42 == "SummaryDetails" then
		if p41.IsLocalPlayer then
			p41.ClientDuel.DuelInterface.FinalResults.Summary:SetDetails(...)
		end
	else
		v_u_4.ReplicateFromServer(p41, p42, ...)
		return
	end
end
function v_u_14.Destroy(p43) -- name: Destroy
	-- upvalues: (copy) v_u_4
	p43._destroyed = true
	for _, v44 in pairs(p43._connections) do
		v44:Disconnect()
	end
	if p43._ally_highlight then
		p43._ally_highlight:Destroy()
	end
	if p43._ally_label then
		p43._ally_label:Destroy()
	end
	p43.HeadHoncho:Destroy()
	p43.Died:Destroy()
	p43.EntityAdded:Destroy()
	p43.HealthChanged:Destroy()
	p43.Eliminated:Destroy()
	p43.ItemAdded:Destroy()
	p43.ItemRemoved:Destroy()
	if p43._preloaded_character_model then
		p43._preloaded_character_model:Destroy()
		p43._preloaded_character_model = nil
	end
	if p43.ClientFighter then
		p43.ClientFighter:ClearInterface()
		if p43.ClientFighter.Entity then
			p43.ClientFighter.Entity:SetTranslucent(false)
		end
	end
	v_u_4.Destroy(p43)
end
function v_u_14._UpdateTranslucence(p45) -- name: _UpdateTranslucence
	if not p45.IsLocalPlayer and (p45.ClientFighter and (p45.ClientFighter.Entity and p45.ClientDuel:Get("IsSpectating"))) then
		p45.ClientFighter.Entity:SetTranslucent(p45.ClientDuel:Get("Status") == "RoundStarting")
	end
end
function v_u_14._RecordEquippedViewModelDetails(p46) -- name: _RecordEquippedViewModelDetails
	-- upvalues: (copy) v_u_6
	if p46.ClientFighter and (p46.ClientFighter.EquippedItem and not p46._viewmodel_detail_check[p46.ClientFighter.EquippedItem:Get("ObjectID")]) then
		p46._viewmodel_detail_check[p46.ClientFighter.EquippedItem:Get("ObjectID")] = true
		local v47 = p46.ClientFighter.EquippedItem:GetViewModelDetails()
		if v47 and not v_u_6.THIRD_PERSON_VIEWMODEL_BLACKLIST[v47.ViewModelName] then
			local v48 = p46._recorded_viewmodel_details
			table.insert(v48, v47)
		end
	else
		return
	end
end
function v_u_14._PreloadCharacterModel(p49) -- name: _PreloadCharacterModel
	-- upvalues: (copy) v_u_2
	if not p49._is_preloading_character_model and p49.ClientDuel:Get("IsSpectating") then
		p49._is_preloading_character_model = true
		for _ = 1, 3 do
			wait(1)
			if p49._destroyed then
				return
			end
			local v50 = v_u_2.GetHumanoidDescriptionFromUserIdAsync
			local v51 = v_u_2
			local v52 = p49.Player.UserId
			local v53, v54 = pcall(v50, v51, v52)
			if v53 then
				if p49._destroyed then
					return
				end
				v54.Torso = 15365012259
				v54.LeftArm = 15365010034
				v54.RightArm = 15365012263
				v54.LeftLeg = 15365010038
				v54.RightLeg = 15365010030
				local v55 = v_u_2.CreateHumanoidModelFromDescriptionAsync
				local v56 = v_u_2
				local v57 = Enum.HumanoidRigType.R15
				local v58, v59 = pcall(v55, v56, v54, v57)
				if v58 then
					if p49._destroyed then
						v59:Destroy()
						return
					end
					p49._preloaded_character_model = v59
				else
					warn("Failed to create humanoid model:", v59)
				end
			else
				warn("Failed to fetch humanoid description:", v54)
			end
		end
	end
end
function v_u_14._ClearAllyVisuals(p60) -- name: _ClearAllyVisuals
	if p60._ally_highlight then
		p60._ally_highlight:Destroy()
		p60._ally_highlight = nil
	end
	if p60._ally_label then
		p60._ally_label:Destroy()
		p60._ally_label = nil
	end
end
function v_u_14._UpdateAllyVisuals(p61) -- name: _UpdateAllyVisuals
	-- upvalues: (copy) v_u_9, (copy) v_u_5, (copy) v_u_11, (copy) v_u_3
	p61:_ClearAllyVisuals()
	if p61.ClientDuel.LocalDueler and not (p61._is_ally and p61:IsAlive()) then
		return
	elseif p61.ClientFighter and (p61.ClientFighter:Get("IsSpectating") or (p61.ClientFighter:Get("IsHiddenByEmotes") or p61.ClientFighter:Get("IsHiddenByCutscene"))) then
		return
	elseif not v_u_9:GetSetting("Hide Teammate Icons") then
		local v62 = v_u_5:GetTeamColor(p61.ClientFighter:Get("TeamID"))
		local v63 = p61.ClientFighter.Entity and (p61.ClientFighter.Entity:GetHealth() / p61.ClientFighter.Entity:GetMaxHealth() or 0) or 0
		local v64 = Color3.fromRGB(255, 50, 50):Lerp(Color3.fromRGB(255, 215, 0):Lerp(Color3.fromRGB(100, 255, 50), v63), v63)
		local v65 = Color3.new(v64.R / 2, v64.G / 2, v64.B / 2)
		p61._ally_label = v_u_11:Clone()
		p61._ally_label.Player.BackgroundColor3 = v62
		p61._ally_label.Player.Headshot.Image = string.format(v_u_3.HEADSHOT_IMAGE, p61.ClientFighter.Player.UserId)
		p61._ally_label.Health.Bar.Visible = v63 > 0
		p61._ally_label.Health.Bar.Size = UDim2.new(v63, 0, 1, 0)
		p61._ally_label.Health.BackgroundColor3 = v65
		p61._ally_label.Health.UIStroke.Color = Color3.new(v64.R * 0.25, v64.G * 0.25, v64.B * 0.25)
		p61._ally_label.Health.Bar.BackgroundColor3 = v64
		p61._ally_label.Health.Bar.UIStroke.Color = v64
		p61._ally_label.Parent = p61.ClientFighter and (p61.ClientFighter.Entity and p61.ClientFighter.Entity.RootPart) or nil
	end
end
function v_u_14._Setup(p_u_66) -- name: _Setup
	p_u_66:_RecordEquippedViewModelDetails()
	p_u_66:_UpdateAllyVisuals()
	if p_u_66.ClientFighter then
		local v67 = p_u_66._connections
		local v68 = p_u_66.ClientFighter.Died
		table.insert(v67, v68:Connect(function(...)
			-- upvalues: (copy) p_u_66
			p_u_66.Died:Fire(...)
		end))
		local v69 = p_u_66._connections
		local v70 = p_u_66.ClientFighter.EntityAdded
		table.insert(v69, v70:Connect(function(...)
			-- upvalues: (copy) p_u_66
			p_u_66.EntityAdded:Fire(...)
		end))
		local v71 = p_u_66._connections
		local v72 = p_u_66.ClientFighter.HealthChanged
		table.insert(v71, v72:Connect(function(...)
			-- upvalues: (copy) p_u_66
			p_u_66.HealthChanged:Fire(...)
		end))
		local v73 = p_u_66._connections
		local v74 = p_u_66.ClientFighter.Eliminated
		table.insert(v73, v74:Connect(function(...)
			-- upvalues: (copy) p_u_66
			p_u_66.Eliminated:Fire(...)
		end))
		local v75 = p_u_66._connections
		local v76 = p_u_66.ClientFighter.ItemAdded
		table.insert(v75, v76:Connect(function(...)
			-- upvalues: (copy) p_u_66
			p_u_66.ItemAdded:Fire(...)
		end))
		local v77 = p_u_66._connections
		local v78 = p_u_66.ClientFighter.ItemRemoved
		table.insert(v77, v78:Connect(function(...)
			-- upvalues: (copy) p_u_66
			p_u_66.ItemRemoved:Fire(...)
		end))
		local v79 = p_u_66._connections
		local v80 = p_u_66.ClientFighter:GetDataChangedSignal("IsSpectating")
		table.insert(v79, v80:Connect(function(...)
			-- upvalues: (copy) p_u_66
			p_u_66:_UpdateAllyVisuals()
		end))
		local v81 = p_u_66._connections
		local v82 = p_u_66.ClientFighter:GetDataChangedSignal("IsHiddenByEmotes")
		table.insert(v81, v82:Connect(function(...)
			-- upvalues: (copy) p_u_66
			p_u_66:_UpdateAllyVisuals()
		end))
		local v83 = p_u_66._connections
		local v84 = p_u_66.ClientFighter:GetDataChangedSignal("IsHiddenByCutscene")
		table.insert(v83, v84:Connect(function(...)
			-- upvalues: (copy) p_u_66
			p_u_66:_UpdateAllyVisuals()
		end))
		local v85 = p_u_66._connections
		local v86 = p_u_66.ClientFighter.EquippedItemChanged
		table.insert(v85, v86:Connect(function()
			-- upvalues: (copy) p_u_66
			p_u_66:_RecordEquippedViewModelDetails()
		end))
	end
end
function v_u_14._Init(p_u_87) -- name: _Init
	-- upvalues: (copy) v_u_9
	p_u_87.Died:Connect(function()
		-- upvalues: (copy) p_u_87
		p_u_87:_UpdateAllyVisuals()
	end)
	p_u_87.EntityAdded:Connect(function()
		-- upvalues: (copy) p_u_87
		p_u_87:SetAlly(p_u_87._is_ally)
	end)
	p_u_87.HealthChanged:Connect(function()
		-- upvalues: (copy) p_u_87
		p_u_87:_UpdateAllyVisuals()
		p_u_87:_UpdateTranslucence()
	end)
	local v88 = p_u_87._connections
	local v89 = p_u_87.ClientDuel:GetDataChangedSignal("IsSpectating")
	table.insert(v88, v89:Connect(function(...)
		-- upvalues: (copy) p_u_87
		p_u_87:_UpdateTranslucence()
		p_u_87:_PreloadCharacterModel()
	end))
	local v90 = p_u_87._connections
	local v91 = p_u_87.ClientDuel:GetDataChangedSignal("Status")
	table.insert(v90, v91:Connect(function(...)
		-- upvalues: (copy) p_u_87
		p_u_87:_UpdateTranslucence()
	end))
	local v92 = p_u_87._connections
	local v93 = v_u_9:GetSettingChangedSignal("Hide Teammate Icons")
	table.insert(v92, v93:Connect(function(...)
		-- upvalues: (copy) p_u_87
		p_u_87:_UpdateAllyVisuals()
	end))
	p_u_87:_Setup()
	task.spawn(p_u_87._PreloadCharacterModel, p_u_87)
end
return v_u_14