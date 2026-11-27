local v1 = game:GetService("ReplicatedStorage")
local v2 = game:GetService("Players")
local v_u_3 = require(v1.Modules.CONSTANTS)
local v_u_4 = require(v1.Modules.CosmeticLibrary)
local v_u_5 = require(v1.Modules.LootLibrary)
local v_u_6 = require(v1.Modules.Utility)
local v_u_7 = require(v2.LocalPlayer.PlayerScripts.Controllers.ComplianceController)
local v_u_8 = require(v2.LocalPlayer.PlayerScripts.Controllers.PlayerDataController)
local v_u_9 = require(v2.LocalPlayer.PlayerScripts.Modules.ButtonEffect)
local v_u_10 = require(v2.LocalPlayer.PlayerScripts.Modules.RewardSlot)
local v_u_11 = {}
v_u_11.__index = v_u_11
function v_u_11.new(p12) -- name: new
	-- upvalues: (copy) v_u_11
	local v13 = v_u_11
	local v14 = setmetatable({}, v13)
	v14.Right = p12
	v14.Frame = v14.Right.Container:WaitForChild("Level")
	v14.Container = v14.Frame:WaitForChild("Container")
	v14.BarFrame = v14.Container:WaitForChild("Bar")
	v14.BarFrameGoal = v14.BarFrame:WaitForChild("Goal")
	v14.BarFrameLevel = v14.BarFrame:WaitForChild("Level")
	v14.BarFrameProgress = v14.BarFrame:WaitForChild("Progress")
	v14.BarFrameContainer = v14.BarFrame:WaitForChild("Container")
	v14.BarFrameContainerBar = v14.BarFrameContainer:WaitForChild("Bar")
	v14.ComponentsFrame = v14.Container:WaitForChild("Components")
	v14.ComponentsLayout = v14.ComponentsFrame:WaitForChild("Layout")
	v14.NextRewardFrame = v14.ComponentsFrame:WaitForChild("NextReward")
	v14.NextRewardTitle = v14.NextRewardFrame:WaitForChild("Title")
	v14.NextRewardContainer = v14.NextRewardFrame:WaitForChild("Container")
	v14.LevelUpFrame = v14.ComponentsFrame:WaitForChild("LevelUp")
	v14.LevelUpDescription = v14.LevelUpFrame:WaitForChild("Description")
	v14.LevelUpButton = v14.LevelUpFrame:WaitForChild("Button")
	v14.LevelUpButtonPrice = v14.LevelUpButton:WaitForChild("Price")
	v14._cleanup = {}
	v14._double_clicked = false
	v14:_Init()
	return v14
end
function v_u_11.OnStateChanged(p15) -- name: OnStateChanged
	p15:_SetDoubleClicked(false)
	p15:_UpdateInformation()
end
function v_u_11._SetDoubleClicked(p16, p17) -- name: _SetDoubleClicked
	p16._double_clicked = p17
	p16.LevelUpDescription.Text = p17 and "Are you sure?" or "Level up now!"
end
function v_u_11._GetInformation(p18) -- name: _GetInformation
	-- upvalues: (copy) v_u_8, (copy) v_u_5
	if p18.Right.Interface.Equipment:IsCareerPageOpen() then
		local v19 = v_u_8:Get("Level")
		local v20 = v_u_8:Get("XP")
		local v21 = v_u_5:GetCareerLevelsRewardData()
		local v22 = (v19 + 1) / v_u_5:GetCareerLevelsRewardMilestone()
		return v19, v20, v21, math.ceil(v22) * v_u_5:GetCareerLevelsRewardMilestone()
	end
	local v23 = v_u_8:GetWeaponData((p18.Right.Interface.Equipment:GetSelectedWeapon()))
	if v23 then
		local v24 = v23.Level
		local v25 = v23.XP
		local v26, v27 = v_u_5:GetNextWeaponLevelReward(v24, v23.Name)
		return v24, v25, v26, v27
	end
end
function v_u_11._UpdateInformation(p28) -- name: _UpdateInformation
	-- upvalues: (copy) v_u_5, (copy) v_u_4, (copy) v_u_7, (copy) v_u_3, (copy) v_u_6, (copy) v_u_10
	for _, v29 in pairs(p28._cleanup) do
		v29:Destroy()
	end
	p28._cleanup = {}
	local v30, v31, v32, v33 = p28:_GetInformation()
	local v34 = v30 ~= nil
	p28.Frame.Visible = v34
	if v34 then
		local v35 = p28.Right.Interface.Equipment:IsCareerPageOpen()
		local v36 = v_u_5:GetXPRequiredToLevelUp(v30)
		local v37 = v32 and (v33 and (v30 == v33 - 1 and (v_u_4.Rewards[v32.Name] and (v_u_4.Rewards[v32.Name].Type == "Lootbox" and v_u_7:ArePaidRandomItemsRestricted()))))
		if v37 then
			v37 = not v_u_3.SHOW_LOOTBOX_CONTENTS_TO_RESTRICTED_PLAYERS
		end
		p28.BarFrameGoal.Text = v36 <= v31 and "" or v_u_6:PrettyNumber(v36)
		p28.BarFrameProgress.Text = v36 <= v31 and "" or v_u_6:PrettyNumber(v31)
		p28.BarFrameLevel.Text = v36 <= v31 and "MAX" or v_u_6:PrettyNumber(v30)
		local v38 = p28.BarFrameContainer
		local v39 = UDim2.new
		local v40 = v31 / v36
		v38.Size = v39(math.clamp(v40, 0, 1), 0, 1, 0)
		local v41 = p28.LevelUpFrame
		local v42 = not v35
		if v42 then
			if v31 < v36 then
				v42 = not v37
			else
				v42 = false
			end
		end
		v41.Visible = v42
		p28.LevelUpButtonPrice.Text = v_u_5:GetCostToLevelUp(v30, v31)
		p28.NextRewardFrame.Visible = v32 ~= nil
		p28.NextRewardTitle.Text = not v33 and "" or "Reward at Level " .. v_u_6:PrettyNumber(v33)
		if v32 then
			local v43 = v_u_10.new(v32)
			v43:SetParent(p28.NextRewardContainer)
			local v44 = p28._cleanup
			table.insert(v44, v43)
		end
	end
end
function v_u_11._Update(p45) -- name: _Update
	local v46 = p45.ComponentsLayout.AbsoluteContentSize.Y > 0 and 1.25 or 1
	p45.Frame.Size = UDim2.new(1, 0, 0, (p45.ComponentsFrame.AbsolutePosition.Y - p45.Frame.AbsolutePosition.Y) * v46 + p45.ComponentsLayout.AbsoluteContentSize.Y)
end
function v_u_11._Init(p_u_47) -- name: _Init
	-- upvalues: (copy) v_u_8, (copy) v_u_9
	p_u_47.ComponentsLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		-- upvalues: (copy) p_u_47
		p_u_47:_Update()
	end)
	p_u_47.LevelUpButton.MouseButton1Click:Connect(function()
		-- upvalues: (copy) p_u_47
		if p_u_47._double_clicked then
			p_u_47.Right.Interface.Equipment:LevelUpWeapon()
		else
			p_u_47:_SetDoubleClicked(true)
		end
	end)
	v_u_8:GetDataChangedSignal("WeaponInventory"):Connect(function()
		-- upvalues: (copy) p_u_47
		p_u_47:_UpdateInformation()
	end)
	v_u_8:GetDataChangedSignal("Level"):Connect(function()
		-- upvalues: (copy) p_u_47
		p_u_47:_UpdateInformation()
	end)
	p_u_47:_Update()
	v_u_9:Add(p_u_47.LevelUpButton, nil, {
		["HoverRatio"] = UDim2.new(0, 10, 0, 10),
		["ReleaseRatio"] = UDim2.new(0, 10, 0, 10)
	})
end
return v_u_11