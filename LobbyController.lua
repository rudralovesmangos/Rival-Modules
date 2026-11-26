local v_u_1 = game:GetService("ExperienceNotificationService")
local v_u_2 = game:GetService("AvatarEditorService")
local v_u_3 = game:GetService("ReplicatedStorage")
local v_u_4 = game:GetService("CollectionService")
local v_u_5 = game:GetService("RunService")
local v_u_6 = game:GetService("Lighting")
local v_u_7 = game:GetService("Players")
local v_u_8 = require(v_u_3.Modules.CONSTANTS)
local v_u_9 = require(v_u_3.Modules.MonetizationLibrary)
local v_u_10 = require(v_u_3.Modules.ServerOsTime)
local v11 = require(v_u_3.Modules.TestLibrary)
local v_u_12 = require(v_u_3.Modules.Utility)
local v_u_13 = require(v_u_7.LocalPlayer.PlayerScripts.Controllers.ShootingRangeController)
local v_u_14 = require(v_u_7.LocalPlayer.PlayerScripts.Controllers.PlayerDataController)
local v_u_15 = require(v_u_7.LocalPlayer.PlayerScripts.Controllers.FighterController)
local v_u_16 = require(v_u_7.LocalPlayer.PlayerScripts.Controllers.DuelController)
local v_u_17 = v11:GetTestAttribute("StudioSkipOnboarding")
local v_u_18 = v_u_7.LocalPlayer.PlayerScripts.Modules.LobbyElements
local v_u_19 = {
	"StarterBundleBoards",
	"LeaderboardDisplays",
	"EliminationsDisplays",
	"DuelsDisplays",
	"DuelsGarageDoor",
	"LikeBoards",
	"LooseWeaponDisplays",
	"Miscellaneous",
	"DuelsSign",
	"RotatingBundleDisplay",
	"WeaponReleaseSchedule",
	"ToyTrainPaths",
	"Teleporters",
	"DailyShopSkinHolograms",
	"LobbyPortals",
	"LobbyAnimations",
	"UpdateCountdowns",
	"TopPlayerRewards",
	"ProximityPageOpeners",
	"BillboardVideoAdBoards",
	"OnlyAppearWhens"
}
local v_u_20 = {}
v_u_20.__index = v_u_20
function v_u_20._new() -- name: _new
	-- upvalues: (copy) v_u_20
	local v21 = v_u_20
	local v22 = setmetatable({}, v21)
	v22.LocalFighter = nil
	v22.Elements = {}
	v22._renderstep_connection = nil
	v22._textures_deleted = false
	v22._attempted_to_favorite = false
	v22:_Init()
	return v22
end
function v_u_20.ToDuels(_) -- name: ToDuels
	-- upvalues: (copy) v_u_15, (copy) v_u_13, (copy) v_u_4
	if v_u_15.LocalFighter and v_u_15.LocalFighter:Get("IsInShootingRange") then
		v_u_13:Leave(true)
	elseif v_u_15.LocalFighter and (not v_u_15.LocalFighter:Get("IsInDuel") and v_u_15.LocalFighter:IsAlive()) then
		v_u_15.LocalFighter.Entity.Model:PivotTo(v_u_4:GetTagged("LobbyDuels")[1].CFrame)
	end
end
function v_u_20._RemoveSuperStarterBundleHolograms(_) -- name: _RemoveSuperStarterBundleHolograms
	-- upvalues: (copy) v_u_10, (copy) v_u_14, (copy) v_u_9, (copy) v_u_4
	local v23
	if v_u_10:Get() < v_u_14:Get("SuperStarterBundleStartTime") + v_u_9.SUPER_STARTER_BUNDLE_OFFER_DURATION then
		v23 = not v_u_14:Get("SuperStarterBundlePurchased")
	else
		v23 = false
	end
	if not v23 then
		for _, v24 in pairs(v_u_4:GetTagged("LobbySuperStarterBundleHologram")) do
			task.defer(v24.Destroy, v24)
		end
	end
end
function v_u_20._RemoveGiftHolograms(_) -- name: _RemoveGiftHolograms
	-- upvalues: (copy) v_u_14, (copy) v_u_4
	if v_u_14:Get("ClaimedGroupReward") then
		for _, v25 in pairs(v_u_4:GetTagged("LobbyFreeRewardsHologram")) do
			task.defer(v25.Destroy, v25)
		end
	end
end
function v_u_20._PromptStuff(p26) -- name: _PromptStuff
	-- upvalues: (copy) v_u_17, (copy) v_u_16, (copy) v_u_7, (copy) v_u_14, (copy) v_u_2, (copy) v_u_8, (copy) v_u_1, (copy) v_u_3
	if v_u_17 then
		return
	else
		wait(1)
		if v_u_16:GetDuel(v_u_7.LocalPlayer) then
			return
		else
			local v27 = v_u_14:GetStatistic("StatisticDuelsPlayed")
			local v28 = v_u_14:GetStatistic("StatisticDuelsWon")
			if p26._attempted_to_favorite or v27 ~= 5 and v28 ~= 1 then
				if not v_u_14:Get("PromptedNotificationPrompt") and (v27 >= 8 or v28 == 2) then
					local v29 = v_u_1.CanPromptOptInAsync
					local v30 = v_u_1
					local v31, v32 = pcall(v29, v30)
					if not v31 then
						warn("Failed to check if user can prompt notifications:", v32)
						return
					end
					if v32 then
						v_u_3.Remotes.Data.PromptedNotificationPrompt:FireServer()
						v_u_1:PromptOptIn()
					end
				end
			else
				p26._attempted_to_favorite = true
				v_u_2:PromptSetFavorite(v_u_8.HUB_PLACE_ID, Enum.AvatarItemType.Asset, true)
			end
		end
	end
end
function v_u_20._UpdateEnabled(p_u_33) -- name: _UpdateEnabled
	-- upvalues: (copy) v_u_5
	if p_u_33._renderstep_connection then
		p_u_33._renderstep_connection:Disconnect()
		p_u_33._renderstep_connection = nil
	end
	local v34 = p_u_33.LocalFighter and not p_u_33.LocalFighter:Get("IsInDuel")
	if v34 then
		v34 = not p_u_33.LocalFighter:Get("IsInShootingRange")
	end
	for _, v35 in pairs(p_u_33.Elements) do
		v35:SetEnabled(v34)
	end
	if v34 then
		p_u_33._renderstep_connection = v_u_5.RenderStepped:Connect(function(p36)
			-- upvalues: (copy) p_u_33
			for v37, v38 in pairs(p_u_33.Elements) do
				debug.profilebegin(v37)
				v38:Update(p36)
				debug.profileend()
			end
		end)
	end
	if v34 then
		task.defer(p_u_33._PromptStuff, p_u_33)
	end
end
function v_u_20._UpdateShadows(p39) -- name: _UpdateShadows
	-- upvalues: (copy) v_u_6, (copy) v_u_14, (copy) v_u_4, (copy) v_u_12
	v_u_6.GlobalShadows = not v_u_14:GetSetting("Shadows Disabled")
	if not p39._shadows_deleted and v_u_14:GetSetting("Shadows Disabled") then
		p39._shadows_deleted = true
		for _, v40 in pairs(v_u_4:GetTagged("LobbyFolder")) do
			v_u_12:DisableShadows(v40)
		end
	end
end
function v_u_20._UpdateTextures(p41) -- name: _UpdateTextures
	-- upvalues: (copy) v_u_14, (copy) v_u_4, (copy) v_u_12
	if not p41._textures_deleted and v_u_14:GetSetting("Textures Disabled") then
		p41._textures_deleted = true
		for _, v42 in pairs(v_u_4:GetTagged("LobbyFolder")) do
			v_u_12:DisableTextures(v42)
		end
	end
end
function v_u_20._Setup(p_u_43) -- name: _Setup
	-- upvalues: (copy) v_u_15, (copy) v_u_19, (copy) v_u_18
	p_u_43.LocalFighter = v_u_15:WaitForLocalFighter()
	p_u_43.LocalFighter:GetDataChangedSignal("IsInDuel"):Connect(function()
		-- upvalues: (copy) p_u_43
		p_u_43:_UpdateEnabled()
	end)
	p_u_43.LocalFighter:GetDataChangedSignal("IsInShootingRange"):Connect(function()
		-- upvalues: (copy) p_u_43
		p_u_43:_UpdateEnabled()
	end)
	for _, v_u_44 in pairs(v_u_19) do
		task.defer(function()
			-- upvalues: (copy) p_u_43, (copy) v_u_44, (ref) v_u_18
			p_u_43.Elements[v_u_44] = require(v_u_18[v_u_44])
		end)
	end
	task.defer(p_u_43._UpdateEnabled, p_u_43)
end
function v_u_20._Init(p_u_45) -- name: _Init
	-- upvalues: (copy) v_u_14, (copy) v_u_4, (copy) v_u_16
	v_u_14:GetDataChangedSignal("StatisticDuelsPlayed"):Connect(function()
		-- upvalues: (copy) p_u_45
		p_u_45:_PromptStuff()
	end)
	v_u_14:GetSettingChangedSignal("Textures Disabled"):Connect(function()
		-- upvalues: (copy) p_u_45
		p_u_45:_UpdateTextures()
	end)
	v_u_14:GetSettingChangedSignal("Shadows Disabled"):Connect(function()
		-- upvalues: (copy) p_u_45
		p_u_45:_UpdateShadows()
	end)
	v_u_14:GetDataChangedSignal("SuperStarterBundlePurchased"):Connect(function()
		-- upvalues: (copy) p_u_45
		p_u_45:_RemoveSuperStarterBundleHolograms()
	end)
	v_u_14:GetDataChangedSignal("ClaimedGroupReward"):Connect(function()
		-- upvalues: (copy) p_u_45
		p_u_45:_RemoveGiftHolograms()
	end)
	v_u_4:GetInstanceAddedSignal("LobbyFreeRewardsHologram"):Connect(function()
		-- upvalues: (copy) p_u_45
		p_u_45:_RemoveGiftHolograms()
	end)
	v_u_16.LocalPlayerLeftDuel:Connect(function()
		-- upvalues: (copy) p_u_45
		p_u_45:_PromptStuff()
	end)
	p_u_45:_UpdateTextures()
	task.spawn(p_u_45._Setup, p_u_45)
	task.defer(p_u_45._UpdateShadows, p_u_45)
	task.defer(p_u_45._RemoveGiftHolograms, p_u_45)
	task.defer(p_u_45._RemoveSuperStarterBundleHolograms, p_u_45)
end
return v_u_20._new()