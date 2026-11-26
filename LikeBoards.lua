local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("CollectionService")
local v_u_3 = game:GetService("Players")
local v_u_4 = require(v1.Modules.CONSTANTS)
local v_u_5 = require(v1.Modules.MonetizationLibrary)
local v_u_6 = require(v1.Modules.CosmeticLibrary)
local v_u_7 = require(v1.Modules.EventLibrary)
local v_u_8 = require(v1.Modules.Utility)
local v_u_9 = require(v_u_3.LocalPlayer.PlayerScripts.Controllers.MonetizationController)
local v_u_10 = require(v_u_3.LocalPlayer.PlayerScripts.Controllers.ComplianceController)
local v_u_11 = require(v_u_3.LocalPlayer.PlayerScripts.Controllers.PlayerDataController)
local v_u_12 = require(v_u_3.LocalPlayer.PlayerScripts.Modules.UserInterface.Pages)
local v_u_13 = require(v_u_3.LocalPlayer.PlayerScripts.Modules.ButtonEffect)
local v_u_14 = require(v_u_3.LocalPlayer.PlayerScripts.Modules.LobbyElement)
local v_u_15 = require(v_u_3.LocalPlayer.PlayerScripts.Modules.RewardSlot)
local v_u_16 = v_u_3.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("LobbyVisuals")
local v_u_17 = setmetatable({}, v_u_14)
v_u_17.__index = v_u_17
function v_u_17._new(...) -- name: _new
	-- upvalues: (copy) v_u_14, (copy) v_u_17
	local v18 = v_u_14.new(...)
	local v19 = v_u_17
	local v20 = setmetatable(v18, v19)
	v20:_Init()
	return v20
end
function v_u_17._BoardAdded(_, p_u_21) -- name: _BoardAdded
	-- upvalues: (copy) v_u_16, (copy) v_u_7, (copy) v_u_8, (copy) v_u_15, (copy) v_u_5, (copy) v_u_6, (copy) v_u_10, (copy) v_u_4, (copy) v_u_12, (copy) v_u_11, (copy) v_u_9, (copy) v_u_13, (copy) v_u_3
	local v_u_22 = (v_u_16:FindFirstChild(v_u_7.LOBBY_VISUALS_PROFILE) and v_u_16[v_u_7.LOBBY_VISUALS_PROFILE]:FindFirstChild("LikeBoardGui") or v_u_16.Default.LikeBoardGui):Clone()
	local v_u_23 = nil
	local function v34() -- name: update
		-- upvalues: (ref) v_u_23, (copy) p_u_21, (copy) v_u_22, (ref) v_u_8, (ref) v_u_15
		if v_u_23 then
			v_u_23:Destroy()
			v_u_23 = nil
		end
		local v24 = p_u_21:GetAttribute("Loaded")
		local v25 = p_u_21:GetAttribute("CurrentLikes") or 0
		local v26 = p_u_21:GetAttribute("GoalLikes") or 0
		local v27 = p_u_21:GetAttribute("LastGoalLikes") or 0
		local v28 = p_u_21:GetAttribute("CurrentMilestone") or 0
		local v29 = p_u_21:GetAttribute("KeyQuantity") or 0
		local v30 = p_u_21:GetAttribute("Code") or ""
		local v31 = (v25 - v27) / (v26 - v27)
		v_u_22.MainFrame.Progress.Current.Text = v_u_8:PrettyNumber(v25)
		v_u_22.MainFrame.Progress.Goal.Text = v_u_8:PrettyNumber(v26)
		v_u_22.MainFrame.Progress.Bar.Bar.Size = UDim2.new(math.clamp(v31, 0, 1), 0, 1, 0)
		local v32 = v_u_22.MainFrame.Progress.Percent
		local v33 = v31 * 100
		v32.Text = math.floor(v33) .. "%"
		v_u_22.MainFrame.Code.Text = string.upper(v30)
		v_u_22.MainFrame.Description.Visible = v28 > 0
		v_u_22.MainFrame.Visible = v24
		v_u_22.StarterBundle.Visible = not v24
		v_u_22.Waiting.Visible = false
		if v28 > 0 then
			v_u_23 = v_u_15.new({
				["Name"] = "Key",
				["Quantity"] = nil,
				["Quantity"] = v29
			})
			v_u_23:SetParent(v_u_22.MainFrame.Reward)
		end
	end
	p_u_21:GetAttributeChangedSignal("CurrentLikes"):Connect(v34)
	p_u_21:GetAttributeChangedSignal("GoalLikes"):Connect(v34)
	p_u_21:GetAttributeChangedSignal("LastGoalLikes"):Connect(v34)
	p_u_21:GetAttributeChangedSignal("CurrentMilestone"):Connect(v34)
	p_u_21:GetAttributeChangedSignal("KeyQuantity"):Connect(v34)
	p_u_21:GetAttributeChangedSignal("Code"):Connect(v34)
	v34()
	local v_u_35 = v_u_22.StarterBundle
	local v_u_36 = v_u_5.Bundles.starter_bundle
	for v37, v38 in pairs(v_u_36.Rewards) do
		local v39 = v_u_6.Rewards[v38.Name]
		if v39 and (v39.Type == "Lootbox" and (v_u_10:ArePaidRandomItemsRestricted() and not v_u_4.SHOW_LOOTBOX_CONTENTS_TO_RESTRICTED_PLAYERS)) then
			continue
		end
		local v40 = v_u_15.new(v38)
		v40.Frame.LayoutOrder = v37
		v40:SetParent(v_u_35.MainFrame.Rewards)
		v40:OnClick(function()
			-- upvalues: (ref) v_u_12
			if not v_u_12.PageSystem.CurrentPage then
				v_u_12.PageSystem:OpenPage("Shop")
				v_u_12.PageSystem:WaitForPage("Shop"):SetPage("Bundles")
				v_u_12.PageSystem:WaitForPage("Shop"):InspectBundle("starter_bundle")
			end
		end)
	end
	local function v42() -- name: update
		-- upvalues: (ref) v_u_11, (copy) v_u_36, (copy) v_u_35
		local v41 = v_u_11:Get("GamepassBundlesClaimed")[v_u_36.GamepassName]
		v_u_35.MainFrame.Button.Visible = not v41
		v_u_35.MainFrame.Owned.Visible = v41
	end
	v_u_11:GetDataChangedSignal("GamepassBundlesClaimed"):Connect(v42)
	local v43 = v_u_11:Get("GamepassBundlesClaimed")[v_u_36.GamepassName]
	v_u_35.MainFrame.Button.Visible = not v43
	v_u_35.MainFrame.Owned.Visible = v43
	v_u_35.MainFrame.Button.MouseButton1Click:Connect(function()
		-- upvalues: (ref) v_u_12, (ref) v_u_9, (ref) v_u_5, (copy) v_u_36
		if not v_u_12.PageSystem.CurrentPage then
			v_u_9:PromptGamePassPurchase(v_u_5.Gamepasses[v_u_36.GamepassName].GamepassID)
		end
	end)
	v_u_9:SetRobuxText(v_u_35.MainFrame.Button.Title, v_u_5.Gamepasses[v_u_36.GamepassName].GamepassID, Enum.InfoType.GamePass)
	v_u_13:Add(v_u_35.MainFrame.Button)
	v_u_22.Adornee = p_u_21
	v_u_22.Parent = v_u_3.LocalPlayer.PlayerGui
end
function v_u_17._Init(p_u_44) -- name: _Init
	-- upvalues: (copy) v_u_2
	v_u_2:GetInstanceAddedSignal("LobbyLikeBoard"):Connect(function(p45)
		-- upvalues: (copy) p_u_44
		p_u_44:_BoardAdded(p45)
	end)
	for _, v46 in pairs(v_u_2:GetTagged("LobbyLikeBoard")) do
		task.defer(p_u_44._BoardAdded, p_u_44, v46)
	end
end
return v_u_17._new()