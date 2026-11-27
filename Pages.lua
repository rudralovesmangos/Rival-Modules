local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("GamepadService")
local v_u_3 = game:GetService("GuiService")
game:GetService("RunService")
local v_u_4 = game:GetService("Players")
local v_u_5 = require(v1.Modules.CONSTANTS)
require(v1.Modules.DebugLibrary)
local v_u_6 = require(v1.Modules.Utility)
local v_u_7 = require(v_u_4.LocalPlayer.PlayerScripts.Controllers:WaitForChild("PlayerDataController"))
local v_u_8 = require(v_u_4.LocalPlayer.PlayerScripts.Controllers:WaitForChild("ControlsController"))
local v_u_9 = require(v_u_4.LocalPlayer.PlayerScripts.Controllers:WaitForChild("FighterController"))
local v_u_10 = require(v_u_4.LocalPlayer.PlayerScripts.Controllers:WaitForChild("DuelController"))
local v_u_11 = require(v_u_4.LocalPlayer.PlayerScripts.Modules.UserInterface:WaitForChild("MobileInputs"))
local v_u_12 = require(v_u_4.LocalPlayer.PlayerScripts.Modules.UserInterface:WaitForChild("Teleporting"))
local v_u_13 = require(v_u_4.LocalPlayer.PlayerScripts.Modules.UserInterface:WaitForChild("Queue"))
local v_u_14 = require(v_u_4.LocalPlayer.PlayerScripts.Modules:WaitForChild("PageSystem"))
local v_u_15 = require(v_u_4.LocalPlayer.PlayerScripts.Modules:WaitForChild("UILibrary"))
local v_u_16 = {}
v_u_16.__index = v_u_16
function v_u_16._new() -- name: _new
	-- upvalues: (copy) v_u_16, (copy) v_u_15, (copy) v_u_14
	local v17 = v_u_16
	local v18 = setmetatable({}, v17)
	v18.Frame = v_u_15:GetTo("MainFrame", "Pages")
	v18.PageSystem = v_u_14.new(v18.Frame)
	v18._welcomeback_popped_up = false
	v18._patchnotes_popped_up = false
	v18._mobileduels_popped_up = false
	v18._delay_next_popup = nil
	v18:_Init()
	return v18
end
function v_u_16.GetDefaultElement(p19) -- name: GetDefaultElement
	return p19.PageSystem:GetDefaultElement()
end
function v_u_16.CloseRequest(p20) -- name: CloseRequest
	p20.PageSystem:CloseRequest()
end
function v_u_16.OpenPickWeaponsPage(p21) -- name: OpenPickWeaponsPage
	-- upvalues: (copy) v_u_7
	p21.PageSystem:OpenPage(v_u_7:GetSetting("Pick Weapons List") == "List" and "PickWeaponsList" or "PickWeapons", true)
end
function v_u_16._UpdateVisibility(p22) -- name: _UpdateVisibility
	-- upvalues: (copy) v_u_3
	p22.Frame.Visible = not v_u_3.MenuIsOpen
end
function v_u_16._CheckInterruption(p23) -- name: _CheckInterruption
	-- upvalues: (copy) v_u_13, (copy) v_u_12, (copy) v_u_11
	if p23.PageSystem.CurrentPage then
		if v_u_13:IsVisible() and p23.PageSystem.CurrentPage.Name ~= "PickEmote" or (v_u_12.Enabled or v_u_11.EditorEnabled) then
			p23.PageSystem:CloseCurrentPage()
		end
	end
end
function v_u_16._CheckPopUps(p24) -- name: _CheckPopUps
	-- upvalues: (copy) v_u_10, (copy) v_u_4, (copy) v_u_7, (copy) v_u_5, (copy) v_u_8, (copy) v_u_6
	if p24.PageSystem.CurrentPage then
		return
	else
		wait(1)
		if p24._delay_next_popup then
			local _ = p24._delay_next_popup
			p24._delay_next_popup = nil
			wait(p24._delay_next_popup)
		end
		if not v_u_10:GetDuel(v_u_4.LocalPlayer) then
			local v25 = v_u_7:GetStatistic("StatisticDuelsPlayed")
			if p24._welcomeback_popped_up or not v_u_7:Get("WelcomeBackGiftReady") then
				if p24._patchnotes_popped_up or (v_u_7:Get("LastPatchNotesVersion") == v_u_5.GAME_VERSION or v25 <= 3) then
					if p24._mobileduels_popped_up or (v_u_5.IS_MOBILE_SERVER or (v25 <= 0 or (v25 > 3 or v_u_8.CurrentControls ~= "Touch"))) then
						if v25 > 10 and v_u_5.IS_HUB_SERVER and (v_u_6:IsAprilFools() and v_u_7:Get("AprilFoolsDialogAcknowledged") == -1 or not v_u_6:IsAprilFools() and v_u_7:Get("AprilFoolsDialogAcknowledged") ~= -1) then
							p24.PageSystem:OpenPage("DialogAprilFools", true)
						end
					else
						p24._mobileduels_popped_up = true
						p24.PageSystem:OpenPage("MobileDuels", true)
					end
				else
					p24._patchnotes_popped_up = true
					p24.PageSystem:OpenPage("PatchNotes", true)
				end
			else
				p24._welcomeback_popped_up = true
				p24._delay_next_popup = 9
				p24.PageSystem:OpenPage("WelcomeBack", true)
			end
			p24._patchnotes_popped_up = true
		end
	end
end
function v_u_16._PickWeapons(p26) -- name: _PickWeapons
	-- upvalues: (copy) v_u_9, (copy) v_u_4, (copy) v_u_10
	local v27 = v_u_9:GetFighter(v_u_4.LocalPlayer)
	if v27 then
		local v28 = v_u_10:GetDuel(v_u_4.LocalPlayer)
		local v29 = #v27.Items == 0 and v27:Get("CanPickWeapons")
		if v29 then
			v29 = v27:IsAlive()
		end
		local v30 = v28 and v28.LocalDueler
		if v30 then
			v30 = v28.LocalDueler:GetStaggeredSpawnsTurn()
		end
		if v29 then
			if not p26.PageSystem.CurrentPage then
				p26:OpenPickWeaponsPage()
				return
			end
		elseif not v30 then
			for _, v31 in pairs({ "PickWeapons", "PickWeaponsList" }) do
				local v32 = p26.PageSystem:GetPage(v31)
				if not (v32 and v32:IsOpen()) then
					continue
				end
				p26.PageSystem:CloseCurrentPage()
			end
		end
	end
end
function v_u_16._DuelAdded(p_u_33, p34) -- name: _DuelAdded
	-- upvalues: (copy) v_u_4
	if p34:GetDueler(v_u_4.LocalPlayer) then
		p34:GetDataChangedSignal("StaggeredSpawnsOrder"):Connect(function()
			-- upvalues: (copy) p_u_33
			p_u_33:_PickWeapons()
		end)
		p_u_33:_PickWeapons()
	end
end
function v_u_16._HookLocalFighter(p_u_35) -- name: _HookLocalFighter
	-- upvalues: (copy) v_u_9
	local v_u_36 = v_u_9:WaitForLocalFighter()
	v_u_36:GetDataChangedSignal("IsInDuel"):Connect(function()
		-- upvalues: (copy) v_u_36, (copy) p_u_35
		if v_u_36:Get("IsInDuel") and p_u_35.PageSystem.CurrentPage then
			p_u_35.PageSystem:CloseCurrentPage()
		end
	end)
	v_u_36:GetDataChangedSignal("CanPickWeapons"):Connect(function()
		-- upvalues: (copy) p_u_35
		p_u_35:_PickWeapons()
	end)
	v_u_36.EntityRemoved:Connect(function()
		-- upvalues: (copy) p_u_35
		p_u_35:_PickWeapons()
	end)
	v_u_36.ItemRemoved:Connect(function()
		-- upvalues: (copy) p_u_35
		p_u_35:_PickWeapons()
	end)
	v_u_36.ItemAdded:Connect(function()
		-- upvalues: (copy) p_u_35
		p_u_35:_PickWeapons()
	end)
	local function v38(p37) -- name: entity_added
		-- upvalues: (copy) p_u_35
		p37.Died:Connect(function()
			-- upvalues: (ref) p_u_35
			p_u_35:_PickWeapons()
		end)
		p_u_35:_PickWeapons()
	end
	v_u_36.EntityAdded:Connect(v38)
	if v_u_36.Entity then
		task.defer(v38, v_u_36.Entity)
	end
end
function v_u_16._SweepFromFolder(_) -- name: _SweepFromFolder
	-- upvalues: (copy) v_u_4
	local function v_u_43(p_u_39) -- name: folder_added
		-- upvalues: (ref) v_u_4
		if p_u_39:IsA("SurfaceGui") and p_u_39.Name == "PagesFromServer" then
			local function v41() -- name: sweep
				-- upvalues: (copy) p_u_39, (ref) v_u_4
				task.defer(function()
					-- upvalues: (ref) p_u_39, (ref) v_u_4
					for _, v40 in pairs(p_u_39:GetChildren()) do
						v40.Parent = v_u_4.LocalPlayer.PlayerScripts.UserInterface.Pages
					end
				end)
			end
			p_u_39.ChildAdded:Connect(v41)
			task.defer(function()
				-- upvalues: (copy) p_u_39, (ref) v_u_4
				for _, v42 in pairs(p_u_39:GetChildren()) do
					v42.Parent = v_u_4.LocalPlayer.PlayerScripts.UserInterface.Pages
				end
			end)
		end
	end
	v_u_4.LocalPlayer.PlayerGui.ChildAdded:Connect(function(p44)
		-- upvalues: (copy) v_u_43
		v_u_43(p44)
	end)
	for _, v45 in pairs(v_u_4.LocalPlayer.PlayerGui:GetChildren()) do
		v_u_43(v45)
	end
end
function v_u_16._Init(p_u_46) -- name: _Init
	-- upvalues: (copy) v_u_2, (copy) v_u_13, (copy) v_u_12, (copy) v_u_11, (copy) v_u_8, (copy) v_u_7, (copy) v_u_10, (copy) v_u_3
	p_u_46.PageSystem.PageOpened:Connect(function()
		-- upvalues: (ref) v_u_2, (copy) p_u_46
		v_u_2:EnableGamepadCursor(p_u_46:GetDefaultElement())
	end)
	p_u_46.PageSystem.PageClosed:Connect(function(p47)
		-- upvalues: (ref) v_u_2, (copy) p_u_46
		v_u_2:DisableGamepadCursor()
		task.defer(p_u_46._CheckPopUps, p_u_46)
		if p47 ~= p_u_46.PageSystem:GetPage("PickWeapons") and p47 ~= p_u_46.PageSystem:GetPage("PickWeaponsList") then
			task.defer(p_u_46._PickWeapons, p_u_46)
		end
	end)
	v_u_13.VisibilityChanged:Connect(function()
		-- upvalues: (copy) p_u_46
		p_u_46:_CheckInterruption()
	end)
	v_u_12.EnabledChanged:Connect(function()
		-- upvalues: (copy) p_u_46
		p_u_46:_CheckInterruption()
	end)
	v_u_11.EditorEnabledChanged:Connect(function()
		-- upvalues: (copy) p_u_46
		p_u_46:_CheckInterruption()
	end)
	v_u_8.ControlsChanged:Connect(function()
		-- upvalues: (copy) p_u_46
		p_u_46:_CheckPopUps()
	end)
	v_u_7:GetDataChangedSignal("StatisticDuelsPlayed"):Connect(function()
		-- upvalues: (copy) p_u_46
		p_u_46:_CheckPopUps()
	end)
	v_u_7:GetDataChangedSignal("AprilFoolsDialogAcknowledged"):Connect(function()
		-- upvalues: (copy) p_u_46
		p_u_46:_CheckPopUps()
	end)
	v_u_10.LocalPlayerLeftDuel:Connect(function()
		-- upvalues: (copy) p_u_46
		p_u_46:_CheckPopUps()
	end)
	v_u_3:GetPropertyChangedSignal("MenuIsOpen"):Connect(function()
		-- upvalues: (copy) p_u_46
		p_u_46:_UpdateVisibility()
	end)
	p_u_46:_UpdateVisibility()
	task.defer(p_u_46._CheckPopUps, p_u_46)
	task.defer(p_u_46._SweepFromFolder, p_u_46)
	task.defer(p_u_46._HookLocalFighter, p_u_46)
end
return v_u_16._new()