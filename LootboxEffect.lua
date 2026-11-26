local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("TweenService")
local v_u_3 = game:GetService("Players")
local v_u_4 = require(v1.Modules.CONSTANTS)
local v_u_5 = require(v1.Modules.CosmeticLibrary)
local v_u_6 = require(v1.Modules.BetterDebris)
local v_u_7 = require(v1.Modules.ItemLibrary)
local v_u_8 = require(v1.Modules.Utility)
local v_u_9 = require(v_u_3.LocalPlayer.PlayerScripts.Modules.RewardSlot)
local v_u_10 = v_u_3.LocalPlayer.PlayerScripts.Assets:WaitForChild("Misc"):WaitForChild("LootboxCollectParticles"):WaitForChild("Attachment")
local v_u_11 = v_u_3.LocalPlayer.PlayerScripts.Assets:WaitForChild("Misc"):WaitForChild("UnboxEffect")
local v_u_12 = v_u_3.LocalPlayer.PlayerScripts.Assets:WaitForChild("Lootboxes")
local v_u_13 = {
	["Common"] = { "rbxassetid://18182950485", 0.5 },
	["Rare"] = { "rbxassetid://18182950836", 0.375 },
	["Legendary"] = { "rbxassetid://18182950182", 0.375 },
	["Mythical"] = { "rbxassetid://115151712865765", 0.5 },
	["Standard"] = { "rbxassetid://18182950485", 0.5 },
	["Prime"] = { "rbxassetid://18182950182", 0.375 }
}
local v_u_14 = 0
return function(p15, p16, p17, p18, p_u_19, p20, _, p21)
	-- upvalues: (copy) v_u_5, (ref) v_u_14, (copy) v_u_12, (copy) v_u_6, (copy) v_u_8, (copy) v_u_4, (copy) v_u_11, (copy) v_u_3, (copy) v_u_9, (copy) v_u_7, (copy) v_u_13, (copy) v_u_2, (copy) v_u_10
	local v22 = p17[1]
	if v22 then
		v22 = v_u_5.Cosmetics[p17[1].RewardData.Name]
	end
	local v23 = p17[1]
	if v23 then
		v23 = v_u_5.Rewards[p17[1].RewardData.Name]
	end
	local v_u_24 = v_u_5.Rewards[p16]
	if p18 and p18 > 0 then
		wait(p18)
	end
	v_u_14 = v_u_14 + 1
	local v25 = v_u_14 * 3.141592653589793 * 2 / 8
	local v26 = (v_u_14 - 1) / 8
	local v27 = v25 + math.floor(v26) * 3.141592653589793 / 8
	local v28 = v_u_14 - 1
	local v29 = math.floor(v28) * 5
	local v30 = v27 + math.rad(v29)
	local v31 = (v_u_14 % 64 - 1) / 8
	local v32 = math.floor(v31) * 1
	local v_u_33 = v_u_12[p16]:Clone()
	local v34 = v_u_33:FindFirstChild("HumanoidRootPart") or v_u_33:FindFirstChild("RootPart")
	for _, v35 in pairs(v_u_33:GetDescendants()) do
		if not v35:IsA("BasePart") then
			continue
		end
		v35.CanCollide = false
		v35.CanTouch = false
		v35.CanQuery = false
		v35.Anchored = false
	end
	if v_u_24.SoundProfile == "PrizeWheel" then
		if not v22 or v22.Type ~= "Skin" then
			v_u_33.wheel.Slices:PivotTo(v_u_33.wheel.Slices:GetPivot() * CFrame.Angles(0, 0, 1.0471975511965976 * Random.new(p21):NextInteger(1, 5)))
		end
		for _, v36 in pairs(v_u_33.wheel.Slices:GetChildren()) do
			local v37 = Instance.new("WeldConstraint")
			v37.Part0 = v36
			v37.Part1 = v_u_33.wheel
			v37.Parent = v36
		end
	end
	v34.Anchored = true
	v_u_33.Parent = workspace
	v_u_6:AddItem(v_u_33, 15)
	v_u_8:CreateSound("rbxassetid://18183233381", 0.5, 1 + 0.25 * math.random(), v34, true)
	local v_u_38 = CFrame.new(p15) * CFrame.Angles(0, v30, 0)
	local v_u_39 = CFrame.new(p15) * CFrame.Angles(0, v30, 0) * CFrame.new(0, -3, v32 + 7)
	v_u_8:RenderstepForLoop(0, 100, 2, function(p40)
		-- upvalues: (copy) v_u_38, (copy) v_u_39, (copy) v_u_33
		local v41 = p40 / 100
		local v42 = 1 - (1 - v41) ^ 5
		local v43 = 9.42477796076938 * (v41 + 0.25)
		local v44 = math.cos(v43) * (v41 - 1) / 0.707
		local v45 = math.abs(v44)
		local v46 = v_u_38:Lerp(v_u_39, v42)
		v_u_33:PivotTo(CFrame.new(v46.X, v_u_39.Y + (v_u_38.Y - v_u_39.Y) * v45, v46.Z) * v46.Rotation)
	end)
	v_u_6:AddItem(v_u_33, v_u_33.Animation:GetAttribute("Duration"))
	task.spawn(v_u_4.IS_STUDIO and task.defer or pcall, function()
		-- upvalues: (copy) v_u_33, (copy) v_u_24
		v_u_33.AnimationController:LoadAnimation(v_u_33.Animation):Play()
		require(script[v_u_24.SoundProfile])(v_u_33)
	end)
	wait(v_u_33.Animation:GetAttribute("RevealDelay"))
	local v_u_47 = v_u_11:Clone()
	v_u_47.CFrame = v_u_39 + Vector3.new(0, 8, 0)
	v_u_47.Parent = workspace
	v_u_6:AddItem(v_u_47, 15)
	local v48 = v_u_47.BillboardGui
	v48.Adornee = v_u_47
	v48.Parent = v_u_3.LocalPlayer.PlayerGui
	v_u_6:AddItem(v48, 15)
	for _, v49 in pairs(p17) do
		local v50 = v_u_9.new(v49.RewardData, true)
		v50:SetInteractable(false)
		v50:SetParent(v48.Container)
	end
	v48.Container.Size = UDim2.new(0.25, 0, 0.25, 0)
	v48.Container.Position = UDim2.new(0.5, 0, 0.75, 0)
	v48.Container:TweenSizeAndPosition(UDim2.new(0.5, 0, 0.5, 0), UDim2.new(0.5, 0, 0.5, 0), "Out", "Quint", 0.5, true)
	local v51 = nil
	local v52 = nil
	if v22 then
		v51 = v22.Rarity
		v52 = v_u_5.Rarities[v22.Rarity].Color
	elseif v23 then
		local v53 = v_u_7.Items[v23.Name]
		v51 = v53 and v53.Status or "Standard"
		v52 = v_u_7.Statuses[v51].Color
	end
	if v51 and v52 then
		v_u_47.Trail.Color = ColorSequence.new(v52)
		local v54 = v_u_13[v51]
		if v54 then
			v_u_8:CreateSound(v54[1], v54[2] * (p20 == v_u_3.LocalPlayer and 1 or 0.5), 1, v_u_47, true)
		end
	end
	local v55 = v48.Container
	wait(4)
	if v55:IsDescendantOf(workspace) then
		v55:TweenSize(UDim2.new(0, 0, 0, 0), "In", "Back", 1, true)
	end
	if p_u_19 then
		local v_u_56 = v_u_47.CFrame
		v_u_8:RenderstepForLoop(0, 100, 1.9, function(p57)
			-- upvalues: (ref) v_u_2, (copy) v_u_47, (copy) v_u_56, (copy) p_u_19
			local v58 = v_u_2:GetValue(p57 / 100, Enum.EasingStyle.Quint, Enum.EasingDirection.In)
			v_u_47.CFrame = v_u_56:Lerp(p_u_19.CFrame, v58)
		end)
		local v59 = v_u_10:Clone()
		v59.Parent = p_u_19
		for _, v60 in pairs(v59:GetChildren()) do
			v60:SetAttribute("IgnoreVisibilityCheck", true)
			v60.Color = v52 and ColorSequence.new(v52) or v60.Color
		end
		v_u_8:PlayParticles(v59)
		v_u_8:CreateSound("rbxassetid://109954155299965", 0.75, 1 + 0.25 * math.random(), p_u_19, true)
		v_u_47:Destroy()
		v48:Destroy()
	end
end