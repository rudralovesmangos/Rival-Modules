local v_u_1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("HttpService")
local v_u_3 = game:GetService("Players")
require(v_u_1.Modules.CONSTANTS)
local v_u_4 = require(v_u_1.Modules.PermissionsLibrary)
local v_u_5 = require(v_u_1.Modules.BetterDebris)
local v_u_6 = require(v_u_1.Modules.Signal)
local v_u_7 = require(v_u_3.LocalPlayer.PlayerScripts.Controllers:WaitForChild("PlayerDataController"))
require(v_u_3.LocalPlayer.PlayerScripts.Controllers:WaitForChild("MechanicsController"))
local v_u_8 = require(v_u_3.LocalPlayer.PlayerScripts.Controllers:WaitForChild("ControlsController"))
local v_u_9 = require(v_u_3.LocalPlayer.PlayerScripts.Controllers:WaitForChild("SpectateController"))
local v_u_10 = require(v_u_3.LocalPlayer.PlayerScripts.Controllers:WaitForChild("FighterController"))
require(v_u_3.LocalPlayer.PlayerScripts.Controllers:WaitForChild("ArcadeController"))
local v_u_11 = require(v_u_3.LocalPlayer.PlayerScripts.Controllers:WaitForChild("DuelController"))
local v_u_12 = require(v_u_3.LocalPlayer.PlayerScripts.Modules:WaitForChild("GameComponents"):WaitForChild("OutOfBoundsParts"))
local v_u_13 = require(v_u_3.LocalPlayer.PlayerScripts.Modules:WaitForChild("UserInterface"):WaitForChild("Pages"))
local v_u_14 = require(v_u_3.LocalPlayer.PlayerScripts.Modules:WaitForChild("TableViewer"))
local v_u_15 = require(script:WaitForChild("DebugState"))
local v_u_16 = {}
v_u_16.__index = v_u_16
function v_u_16._new() -- name: _new
	-- upvalues: (copy) v_u_16, (copy) v_u_6
	local v17 = v_u_16
	local v18 = setmetatable({}, v17)
	v18._are_hitboxes_visible = false
	v18._are_map_barriers_visible = false
	v18._are_map_barriers_visible_changed_internal = v_u_6.new()
	v18:_Init()
	return v18
end
function v_u_16.Command(p19, p20, p21) -- name: Command
	if p19[p20] then
		p19[p20](p19, p21)
	else
		p19:_Command(p20, p21)
	end
end
function v_u_16.SetHandicapsEnabled(_, p22) -- name: SetHandicapsEnabled
	-- upvalues: (copy) v_u_15
	v_u_15:SetReplicate("AreHandicapsEnabled", p22)
end
function v_u_16.DisableTransparentHats(_, p23) -- name: DisableTransparentHats
	-- upvalues: (copy) v_u_15
	v_u_15:SetReplicate("DisableTransparentHats", p23)
end
function v_u_16.SpectateNilDuel(_) -- name: SpectateNilDuel
	-- upvalues: (copy) v_u_9
	v_u_9:SpectateDuelRequest(nil)
end
function v_u_16.ShowClientEnvironment(_) -- name: ShowClientEnvironment
	-- upvalues: (copy) v_u_14, (copy) v_u_3
	v_u_14.new(require(v_u_3.LocalPlayer.PlayerScripts.Client)).ScreenGui.Parent = v_u_3.LocalPlayer.PlayerGui
end
function v_u_16.GetMatchmakingData(p24) -- name: GetMatchmakingData
	p24:_JSONDump(p24:_Command("GetMatchmakingData", true))
end
function v_u_16.SetMapBarriersVisible(p25, p26) -- name: SetMapBarriersVisible
	p25._are_map_barriers_visible = p26
	p25._are_map_barriers_visible_changed_internal:Fire()
	p25:_SetupMapBarriersLogic()
end
function v_u_16.SetOOBVisible(_, p27) -- name: SetOOBVisible
	-- upvalues: (copy) v_u_12
	v_u_12:SetVisible(p27)
end
function v_u_16.DisableDeviceAutoSwitch(_, p28) -- name: DisableDeviceAutoSwitch
	-- upvalues: (copy) v_u_8
	v_u_8:DisableVerification(p28)
end
function v_u_16.SetHitboxesVisible(p29, p30) -- name: SetHitboxesVisible
	p29._are_hitboxes_visible = p30
	p29:_UpdateAllClientFighterCharacterHitboxes()
end
function v_u_16.InternalViewRewardSlot(_) -- name: InternalViewRewardSlot
	-- upvalues: (copy) v_u_13
	v_u_13.PageSystem:OpenPage("Debug", true)
	v_u_13.PageSystem:WaitForPage("Debug").PromptSystem:Open("InternalViewRewardSlot")
end
function v_u_16.SendOfflineGiftRewards(_) -- name: SendOfflineGiftRewards
	-- upvalues: (copy) v_u_4, (copy) v_u_7, (copy) v_u_13
	if v_u_4:IsAdministrator(v_u_7:Get("PermissionsRoles")) then
		v_u_13.PageSystem:OpenPage("Debug", true)
		v_u_13.PageSystem:WaitForPage("Debug").PromptSystem:Open("SendOfflineGiftRewards")
	end
end
function v_u_16.SendBugRewards(_) -- name: SendBugRewards
	-- upvalues: (copy) v_u_4, (copy) v_u_7, (copy) v_u_13
	if v_u_4:HasPermission("permission_testing_publiccommands_bugrewards", v_u_7:Get("PermissionsRoles")) then
		v_u_13.PageSystem:OpenPage("Debug", true)
		v_u_13.PageSystem:WaitForPage("Debug").PromptSystem:Open("SendBugRewards")
	end
end
function v_u_16._SetupMapBarriersLogic(p_u_31) -- name: _SetupMapBarriersLogic
	-- upvalues: (copy) v_u_11
	if not p_u_31._map_barrier_logic_setup then
		p_u_31._map_barrier_logic_setup = true
		v_u_11.ObjectAdded:Connect(function(p_u_32) -- name: duel_added
			-- upvalues: (copy) p_u_31
			local function v34() -- name: update_map
				-- upvalues: (copy) p_u_32, (ref) p_u_31
				if p_u_32.Map then
					for _, v33 in pairs(p_u_32.Map.Model.Barriers:GetDescendants()) do
						if not v33:IsA("BasePart") or v33:HasTag("OutOfBoundsPart") then
							continue
						end
						v33.Transparency = p_u_31._are_map_barriers_visible and 0.5 or 1
						v33.Material = Enum.Material.SmoothPlastic
						v33.Color = v33:HasTag("KillBrick") and Color3.fromRGB(255, 0, 0) or Color3.fromRGB(127, 127, 127)
						v33.CastShadow = false
					end
				end
			end
			p_u_31._are_map_barriers_visible_changed_internal:Connect(v34)
			p_u_32.MapAdded:Connect(v34)
			v34()
		end)
		for _, v_u_35 in pairs(v_u_11.Objects) do
			local function v37() -- name: update_map
				-- upvalues: (copy) v_u_35, (copy) p_u_31
				if v_u_35.Map then
					for _, v36 in pairs(v_u_35.Map.Model.Barriers:GetDescendants()) do
						if not v36:IsA("BasePart") or v36:HasTag("OutOfBoundsPart") then
							continue
						end
						v36.Transparency = p_u_31._are_map_barriers_visible and 0.5 or 1
						v36.Material = Enum.Material.SmoothPlastic
						v36.Color = v36:HasTag("KillBrick") and Color3.fromRGB(255, 0, 0) or Color3.fromRGB(127, 127, 127)
						v36.CastShadow = false
					end
				end
			end
			p_u_31._are_map_barriers_visible_changed_internal:Connect(v37)
			v_u_35.MapAdded:Connect(v37)
			v37()
		end
	end
end
function v_u_16._JSONDump(_, ...) -- name: _JSONDump
	-- upvalues: (copy) v_u_3, (copy) v_u_5
	local v38 = Instance.new("ScreenGui")
	v38.Parent = v_u_3.LocalPlayer.PlayerGui
	v_u_5:AddItem(v38, 60)
	local v39 = Instance.new("UIListLayout")
	v39.HorizontalAlignment = Enum.HorizontalAlignment.Center
	v39.VerticalAlignment = Enum.VerticalAlignment.Center
	v39.FillDirection = Enum.FillDirection.Horizontal
	v39.Parent = v38
	local v40 = { ... }
	for v41, v42 in pairs(v40) do
		local v43 = #v42 / 199999
		for v44 = 1, math.ceil(v43) do
			local v45 = (v44 - 1) * 199999
			local v46 = v45 + 1
			local v47 = v45 + 199999
			local v48 = string.sub(v42, v46, v47)
			local v49 = Instance.new("TextBox")
			v49.BackgroundColor3 = Color3.fromHSV(v41 / #v40, 0.75, 1)
			v49.Size = UDim2.new(0, 200, 0, 200)
			v49.ClearTextOnFocus = false
			v49.TextEditable = false
			v49.Text = v48
			v49.TextWrapped = true
			v49.Parent = v38
		end
	end
end
function v_u_16._Encode(_, p50) -- name: _Encode
	-- upvalues: (copy) v_u_2
	local v_u_51 = {}
	local function v_u_56(p52) -- name: clone
		-- upvalues: (copy) v_u_51, (copy) v_u_56
		local v53 = {}
		for v54, v55 in pairs(p52) do
			if v_u_51[v55] then
				v53[v54] = "*** cyclic table detected ***"
			elseif typeof(v55) == "table" then
				v_u_51[v55] = true
				v53[v54] = v_u_56(v55)
			else
				v53[v54] = v55
			end
		end
		return v53
	end
	return v_u_2:JSONEncode((v_u_56(p50)))
end
function v_u_16._Command(_, ...) -- name: _Command
	-- upvalues: (copy) v_u_1
	return v_u_1.Remotes.Debug.Command:InvokeServer(...)
end
function v_u_16._UpdateClientFighterCharacterHitboxes(p57, p58) -- name: _UpdateClientFighterCharacterHitboxes
	p58:SetHitboxesVisible(p57._are_hitboxes_visible)
end
function v_u_16._UpdateAllClientFighterCharacterHitboxes(p59) -- name: _UpdateAllClientFighterCharacterHitboxes
	-- upvalues: (copy) v_u_10
	for _, v60 in pairs(v_u_10.Objects) do
		if not v60.Entity then
			continue
		end
		p59:_UpdateClientFighterCharacterHitboxes(v60.Entity)
	end
end
function v_u_16._SetupHitboxesVisualizer(p_u_61) -- name: _SetupHitboxesVisualizer
	-- upvalues: (copy) v_u_10
	local function v64(p62) -- name: client_fighter_added
		-- upvalues: (copy) p_u_61
		p62.EntityAdded:Connect(function(p63)
			-- upvalues: (ref) p_u_61
			p_u_61:_UpdateClientFighterCharacterHitboxes(p63)
		end)
		if p62.Entity then
			p_u_61:_UpdateClientFighterCharacterHitboxes(p62.Entity)
		end
	end
	v_u_10.ObjectAdded:Connect(v64)
	for _, v65 in pairs(v_u_10.Objects) do
		task.defer(v64, v65)
	end
end
function v_u_16._Init(p66) -- name: _Init
	task.defer(p66._SetupHitboxesVisualizer, p66)
end
return v_u_16._new()