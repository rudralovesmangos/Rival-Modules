local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("RunService")
local v3 = game:GetService("Players")
local v_u_4 = require(v1.Modules.Utility)
local v_u_5 = require(v3.LocalPlayer.PlayerScripts.Modules.ClientReplicatedClasses.ClientDuel.ClientMap)
local v_u_6 = require(script:WaitForChild("CutsceneLogic"))
local v_u_7 = v3.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("ZombieTowerLadderGui")
local v_u_8 = setmetatable({}, v_u_5)
v_u_8.__index = v_u_8
function v_u_8.new(...) -- name: new
	-- upvalues: (copy) v_u_5, (copy) v_u_8, (copy) v_u_6, (copy) v_u_7
	local v9 = v_u_5.new(...)
	local v10 = v_u_8
	local v11 = setmetatable(v9, v10)
	v11.CutsceneLogic = v_u_6.new(v11)
	v11._floors_folder = v11.Model:WaitForChild("Floors")
	v11._spectating_thread = nil
	v11._flashing_red_enemies_connection = nil
	v11._ladder_guide_bbg = v_u_7:Clone()
	v11._active_enemy_humanoids = {}
	v11:_Init()
	return v11
end
function v_u_8.GetFloorNumberFromPosition(p12, p13) -- name: GetFloorNumberFromPosition
	-- upvalues: (copy) v_u_4
	local v14 = p13 or workspace.CurrentCamera.CFrame.Position
	for _, v15 in pairs(p12._floors_folder:GetChildren()) do
		for _, v16 in pairs(v15:FindFirstChild("Important") and (v15.Important:GetChildren() or {}) or {}) do
			if v16.Name ~= "Volume" or not v_u_4:IsWithinPart(v16, v14) then
				continue
			end
			local v17 = v15.Name
			return tonumber(v17)
		end
	end
end
function v_u_8.GetScoreboardDisplay(p18) -- name: GetScoreboardDisplay
	local v19 = p18:GetFloorNumberFromPosition()
	local v20 = not v19 and "" or "   \226\128\162   Floor " .. v19
	return p18.Name .. v20
end
function v_u_8.ReplicateFromServer(p21, p22, ...) -- name: ReplicateFromServer
	-- upvalues: (copy) v_u_5
	if p22 == "StopCutsceneNow" then
		if p21:IsRendered() then
			p21.CutsceneLogic:StopCutscene()
		end
	else
		v_u_5.ReplicateFromServer(p21, p22, ...)
		return
	end
end
function v_u_8.Destroy(p23) -- name: Destroy
	-- upvalues: (copy) v_u_5
	if p23._spectating_thread then
		task.cancel(p23._spectating_thread)
		p23._spectating_thread = nil
	end
	if p23._flashing_red_enemies_connection then
		p23._flashing_red_enemies_connection:Disconnect()
		p23._flashing_red_enemies_connection = nil
	end
	p23.CutsceneLogic:Destroy()
	v_u_5.Destroy(p23)
end
function v_u_8._FloorAdded(p_u_24, p25) -- name: _FloorAdded
	local v26 = p25:WaitForChild("MobGroups")
	local function v_u_29(p_u_27) -- name: humanoid_added
		-- upvalues: (copy) p_u_24
		local v_u_28 = {
			["StartFlashingRed"] = 0,
			["Highlight"] = nil
		}
		p_u_27.HealthChanged:Connect(function() -- name: reset
			-- upvalues: (copy) v_u_28
			v_u_28.StartFlashingRed = tick() + 60
			if v_u_28.Highlight then
				v_u_28.Highlight:Destroy()
				v_u_28.Highlight = nil
			end
		end)
		v_u_28.StartFlashingRed = tick() + 60
		if v_u_28.Highlight then
			v_u_28.Highlight:Destroy()
			v_u_28.Highlight = nil
		end
		p_u_24._active_enemy_humanoids[p_u_27] = v_u_28
		p_u_27.Destroying:Connect(function()
			-- upvalues: (ref) p_u_24, (copy) p_u_27
			p_u_24._active_enemy_humanoids[p_u_27] = nil
		end)
	end
	local function v_u_33(p_u_30) -- name: object_value_added
		-- upvalues: (copy) v_u_29
		local v_u_31 = false
		local function v32() -- name: check
			-- upvalues: (ref) v_u_31, (copy) p_u_30, (ref) v_u_29
			if v_u_31 then
				return
			elseif p_u_30.Value then
				v_u_31 = true
				task.spawn(v_u_29, p_u_30.Value)
			end
		end
		p_u_30:GetPropertyChangedSignal("Value"):Connect(v32)
		if not v_u_31 and p_u_30.Value then
			v_u_31 = true
			task.spawn(v_u_29, p_u_30.Value)
		end
	end
	local function v37(p34) -- name: mob_group_added
		-- upvalues: (copy) v_u_33
		local v35 = p34:WaitForChild("EntityHumanoidObjectValues", 3)
		if v35 then
			v35.ChildAdded:Connect(v_u_33)
			for _, v36 in pairs(v35:GetChildren()) do
				task.spawn(v_u_33, v36)
			end
		end
	end
	v26.ChildAdded:Connect(v37)
	for _, v38 in pairs(v26:GetChildren()) do
		task.spawn(v37, v38)
	end
	local v39 = p25.Name
	if (tonumber(v39) or 0) > 2 then
		task.delay(1, p_u_24.CreateSound, p_u_24, "rbxassetid://1843115730", 2, 1, p25:WaitForChild("Important"):WaitForChild("Entrance"), true, 10, 400, 400)
	end
end
function v_u_8._UpdateLadderGuide(_) -- name: _UpdateLadderGuide end
function v_u_8._UpdateLightingChange(p40) -- name: _UpdateLightingChange
	-- upvalues: (copy) v_u_4
	local v41 = p40.Model:FindFirstChild("LightingParts")
	local v42 = nil
	for _, v43 in pairs(v41 and v41:GetChildren() or {}) do
		if not v_u_4:IsWithinPart(v43, workspace.CurrentCamera.CFrame.Position) then
			continue
		end
		v42 = v43
	end
	local v44 = v42 and v42:GetAttribute("LightingProfileOverride") or nil
	if v44 ~= p40:Get("LightingProfileOverride") then
		p40:SetReplicate("LightingProfileOverride", v44)
	end
end
function v_u_8._VerifySpectatingThread(p_u_45) -- name: _VerifySpectatingThread
	if p_u_45._spectating_thread then
		task.cancel(p_u_45._spectating_thread)
		p_u_45._spectating_thread = nil
	end
	if p_u_45.ClientDuel:Get("IsSpectating") then
		p_u_45._spectating_thread = task.spawn(function()
			-- upvalues: (copy) p_u_45
			while true do
				p_u_45:_UpdateLightingChange()
				p_u_45:_UpdateLadderGuide()
				wait(1)
			end
		end)
	end
end
function v_u_8._VerifyFlashingRedEnemiesConnection(p_u_46) -- name: _VerifyFlashingRedEnemiesConnection
	-- upvalues: (copy) v_u_2
	if p_u_46._flashing_red_enemies_connection then
		p_u_46._flashing_red_enemies_connection:Disconnect()
		p_u_46._flashing_red_enemies_connection = nil
	end
	if not p_u_46._destroyed and p_u_46.ClientDuel:Get("IsSpectating") then
		p_u_46._flashing_red_enemies_connection = v_u_2.RenderStepped:Connect(function()
			-- upvalues: (copy) p_u_46
			local v47 = 3.141592653589793 * tick()
			local v48 = math.sin(v47)
			local v49 = math.max(0, v48)
			for v50, v51 in pairs(p_u_46._active_enemy_humanoids) do
				if tick() < v51.StartFlashingRed then
					continue
				end
				if not v51.Highlight then
					v51.Highlight = Instance.new("Highlight")
					v51.Highlight.FillColor = Color3.fromRGB(255, 0, 0)
					v51.Highlight.OutlineColor = Color3.fromRGB(255, 0, 0)
					v51.Highlight.Adornee = v50.Parent
					v51.Highlight.Name = "FlashingRed"
					v51.Highlight.Parent = v50
				end
				v51.Highlight.OutlineTransparency = v49 * 1 + 0
				v51.Highlight.FillTransparency = v49 * 0.125 + 0.875
			end
		end)
	end
end
function v_u_8._Init(p_u_52) -- name: _Init
	p_u_52._floors_folder.ChildAdded:Connect(function(p53)
		-- upvalues: (copy) p_u_52
		p_u_52:_FloorAdded(p53)
	end)
	local v54 = p_u_52._connections
	local v55 = p_u_52.ClientDuel:GetDataChangedSignal("IsSpectating")
	table.insert(v54, v55:Connect(function()
		-- upvalues: (copy) p_u_52
		task.spawn(p_u_52._VerifySpectatingThread, p_u_52)
		p_u_52:_VerifyFlashingRedEnemiesConnection()
	end))
	for _, v56 in pairs(p_u_52._floors_folder:GetChildren()) do
		task.spawn(p_u_52._FloorAdded, p_u_52, v56)
	end
	p_u_52:_Setup()
	p_u_52:_VerifyFlashingRedEnemiesConnection()
	task.spawn(p_u_52._VerifySpectatingThread, p_u_52)
end
return v_u_8