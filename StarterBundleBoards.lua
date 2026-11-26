local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("CollectionService")
local v_u_3 = game:GetService("Players")
local v_u_4 = require(v1.Modules.CONSTANTS)
local v_u_5 = require(v1.Modules.MonetizationLibrary)
local v_u_6 = require(v1.Modules.CosmeticLibrary)
local v_u_7 = require(v_u_3.LocalPlayer.PlayerScripts.Controllers.MonetizationController)
local v_u_8 = require(v_u_3.LocalPlayer.PlayerScripts.Controllers.ComplianceController)
local v_u_9 = require(v_u_3.LocalPlayer.PlayerScripts.Controllers.PlayerDataController)
local v_u_10 = require(v_u_3.LocalPlayer.PlayerScripts.Modules.UserInterface.Pages)
local v_u_11 = require(v_u_3.LocalPlayer.PlayerScripts.Modules.VideoAdRewards)
local v_u_12 = require(v_u_3.LocalPlayer.PlayerScripts.Modules.ButtonEffect)
local v_u_13 = require(v_u_3.LocalPlayer.PlayerScripts.Modules.LobbyElement)
local v_u_14 = require(v_u_3.LocalPlayer.PlayerScripts.Modules.RewardSlot)
local v_u_15 = v_u_3.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("StarterBundleGui")
Color3.fromRGB(114, 140, 255)
local v_u_16 = setmetatable({}, v_u_13)
v_u_16.__index = v_u_16
function v_u_16._new(...) -- name: _new
	-- upvalues: (copy) v_u_13, (copy) v_u_16
	local v17 = v_u_13.new(...)
	local v18 = v_u_16
	local v19 = setmetatable(v17, v18)
	v19._boards = {}
	v19:_Init()
	return v19
end
function v_u_16._BoardAdded(p20, p21) -- name: _BoardAdded
	-- upvalues: (copy) v_u_15, (copy) v_u_11, (copy) v_u_5, (copy) v_u_6, (copy) v_u_8, (copy) v_u_4, (copy) v_u_14, (copy) v_u_10, (copy) v_u_9, (copy) v_u_7, (copy) v_u_12, (copy) v_u_3
	local v22 = {
		["Gui"] = v_u_15:Clone(),
		["VideoAdRewards"] = v_u_11.new(),
		["Connections"] = {}
	}
	local v_u_23 = v22.Gui.StarterBundle
	local v_u_24 = v_u_5.Bundles.starter_bundle
	for v25, v26 in pairs(v_u_24.Rewards) do
		local v27 = v_u_6.Rewards[v26.Name]
		if v27 and (v27.Type == "Lootbox" and (v_u_8:ArePaidRandomItemsRestricted() and not v_u_4.SHOW_LOOTBOX_CONTENTS_TO_RESTRICTED_PLAYERS)) then
			continue
		end
		local v28 = v_u_14.new(v26)
		v28.Frame.LayoutOrder = v25
		v28:SetParent(v_u_23.MainFrame.Rewards)
		v28:OnClick(function()
			-- upvalues: (ref) v_u_10
			if not v_u_10.PageSystem.CurrentPage then
				v_u_10.PageSystem:OpenPage("Shop")
				v_u_10.PageSystem:WaitForPage("Shop"):SetPage("Bundles")
				v_u_10.PageSystem:WaitForPage("Shop"):InspectBundle("starter_bundle")
			end
		end)
	end
	local function v30() -- name: update
		-- upvalues: (ref) v_u_9, (copy) v_u_24, (copy) v_u_23
		local v29 = v_u_9:Get("GamepassBundlesClaimed")[v_u_24.GamepassName]
		v_u_23.MainFrame.Button.Visible = not v29
		v_u_23.MainFrame.Owned.Visible = v29
	end
	local v31 = v22.Connections
	local v32 = v_u_9:GetDataChangedSignal("GamepassBundlesClaimed")
	table.insert(v31, v32:Connect(v30))
	local v33 = v_u_9:Get("GamepassBundlesClaimed")[v_u_24.GamepassName]
	v_u_23.MainFrame.Button.Visible = not v33
	v_u_23.MainFrame.Owned.Visible = v33
	v_u_23.MainFrame.Button.MouseButton1Click:Connect(function()
		-- upvalues: (ref) v_u_10, (ref) v_u_7, (ref) v_u_5, (copy) v_u_24
		if not v_u_10.PageSystem.CurrentPage then
			v_u_7:PromptGamePassPurchase(v_u_5.Gamepasses[v_u_24.GamepassName].GamepassID)
		end
	end)
	v_u_7:SetRobuxText(v_u_23.MainFrame.Button.Title, v_u_5.Gamepasses[v_u_24.GamepassName].GamepassID, Enum.InfoType.GamePass)
	v_u_12:Add(v_u_23.MainFrame.Button)
	local v34 = v22.Gui.VideoAdRewards
	v_u_23.Visible = true
	v34.Visible = false
	v22.Gui.Adornee = p21
	v22.Gui.Parent = v_u_3.LocalPlayer.PlayerGui
	p20._boards[p21] = v22
end
function v_u_16._BoardRemoved(p35, p36) -- name: _BoardRemoved
	local v37 = p35._boards[p36]
	if v37 then
		for _, v38 in pairs(v37.Connections) do
			v38:Disconnect()
		end
		v37.Gui:Destroy()
		v37.VideoAdRewards:Destroy()
		p35._boards[p36] = nil
	end
end
function v_u_16._Init(p_u_39) -- name: _Init
	-- upvalues: (copy) v_u_2
	v_u_2:GetInstanceAddedSignal("LobbyStarterBundleBoard"):Connect(function(p40)
		-- upvalues: (copy) p_u_39
		p_u_39:_BoardAdded(p40)
	end)
	v_u_2:GetInstanceRemovedSignal("LobbyStarterBundleBoard"):Connect(function(p41)
		-- upvalues: (copy) p_u_39
		p_u_39:_BoardRemoved(p41)
	end)
	for _, v42 in pairs(v_u_2:GetTagged("LobbyStarterBundleBoard")) do
		task.defer(p_u_39._BoardAdded, p_u_39, v42)
	end
end
return v_u_16._new()