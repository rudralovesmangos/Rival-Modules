local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("SoundService")
local v3 = game:GetService("Players")
local v_u_4 = require(v1.Modules.CosmeticLibrary)
local v5 = require(v1.Modules.EventLibrary)
local v_u_6 = require(v1.Modules.Utility)
local v_u_7 = require(v3.LocalPlayer.PlayerScripts.Controllers:WaitForChild("PlayerDataController"))
local v_u_8 = require(v3.LocalPlayer.PlayerScripts.Controllers:WaitForChild("SpectateController"))
local v_u_9 = require(v3.LocalPlayer.PlayerScripts.Controllers:WaitForChild("FighterController"))
local v_u_10 = require(v3.LocalPlayer.PlayerScripts.Modules:WaitForChild("UserInterface"):WaitForChild("Equipment"))
local v_u_11 = require(v3.LocalPlayer.PlayerScripts.Modules:WaitForChild("UserInterface"):WaitForChild("Pages"))
local v_u_12 = v5.IS_ACTIVE and (v5.EVENT_DETAILS.LOBBY_MUSIC or "Default") or "Default"
local v_u_13 = v5.IS_ACTIVE and v5.EVENT_DETAILS.LOBBY_MUSIC_MUFFLED or "DefaultMuffled"
local v_u_14 = {
	[""] = { "", 1 },
	["Default"] = { "rbxassetid://17697682466", 1 },
	["DefaultMuffled"] = { "rbxassetid://17733314783", 1 },
	["Spooky"] = { "rbxassetid://100081814360953", 1 },
	["SpookyMuffled"] = { "rbxassetid://86062306109271", 0.5 },
	["Festive"] = { "rbxassetid://82135261819112", 1 },
	["FestiveMuffled"] = { "rbxassetid://96771526359691", 1 },
	["Tropical"] = { "rbxassetid://120824068504773", 1 },
	["TropicalMuffled"] = { "rbxassetid://114306049661290", 1 },
	["Obby"] = { "rbxassetid://91718252417630", 1 },
	["Spleef"] = { "rbxassetid://91718252417630", 1 },
	["ZombieTower"] = { "rbxassetid://120087790552326", 1 },
	["GargoyleTower"] = { "rbxassetid://74833315667579", 1 }
}
local v_u_15 = {}
v_u_15.__index = v_u_15
function v_u_15._new() -- name: _new
	-- upvalues: (copy) v_u_15, (copy) v_u_14
	local v16 = v_u_15
	local v17 = setmetatable({}, v16)
	v17.LocalFighter = nil
	v17._volume = 0.5
	v17._sound_name = ""
	v17._sound_info = v_u_14.
	v17._is_tweening = false
	v17._sound = Instance.new("Sound")
	v17._next_sound = Instance.new("Sound")
	v17._volume_multiplier = 1
	v17._duel_subject_connections = {}
	v17:_Init()
	return v17
end
function v_u_15.SetSoundID(p18, p19, p20) -- name: SetSoundID
	-- upvalues: (copy) v_u_14
	local v21 = not p19 or v_u_14[p19]
	assert(v21, "Argument 1 invalid, expected a string or nil")
	local v22 = not p20 or typeof(p20) == "number"
	assert(v22, "Argument 2 invalid, expected a number or nil")
	if p19 ~= p18._sound_name then
		p18._sound_name = p19 or ""
		p18._sound_info = v_u_14[p18._sound_name]
		p18._volume_multiplier = p20 or 1
		task.spawn(p18._TweenSoundID, p18)
	end
end
function v_u_15.SetVolume(p23, p24) -- name: SetVolume
	local v25 = typeof(p24) == "number"
	assert(v25, "Argument 1 invalid, expected a number")
	p23._volume = p24
	p23:_UpdateVolume()
end
function v_u_15._UpdateSoundGroups(_, p26, p27) -- name: _UpdateSoundGroups
	-- upvalues: (copy) v_u_7, (copy) v_u_2
	local v28 = v_u_2.Master
	local v29
	if p26 == "Master Volume" then
		v29 = p27
	else
		v29 = v_u_7:GetSetting("Master Volume")
	end
	v28.Volume = v29
	local v30 = v_u_2.Master.Music
	local v31
	if p26 == "Music Volume" then
		v31 = p27
	else
		v31 = v_u_7:GetSetting("Music Volume")
	end
	v30.Volume = v31
	local v32 = v_u_2.Master.Other
	local v33
	if p26 == "Other Volume" then
		v33 = p27
	else
		v33 = v_u_7:GetSetting("Other Volume")
	end
	v32.Volume = v33
	local v34 = v_u_2.Master.Finisher
	local v35
	if p26 == "Finisher Volume" then
		v35 = p27
	else
		v35 = v_u_7:GetSetting("Finisher Volume")
	end
	v34.Volume = v35
	local v36 = v_u_2.Master.Emote
	local v37
	if p26 == "Emote Volume" then
		v37 = p27
	else
		v37 = v_u_7:GetSetting("Emote Volume")
	end
	v36.Volume = v37
	local v38 = v_u_2.Master.Finisher.FinisherFromOthers
	local v39
	if p26 == "Mute Finishers From Others" then
		v39 = p27
	else
		v39 = v_u_7:GetSetting("Mute Finishers From Others")
	end
	v38.Volume = v39 and 0 or 1
	local v40 = v_u_2.Master.Emote.EmoteFromOthers
	if p26 ~= "Mute Emotes From Others" then
		p27 = v_u_7:GetSetting("Mute Emotes From Others")
	end
	v40.Volume = p27 and 0 or 1
end
function v_u_15._GetCurrentEmoteInfo(_) -- name: _GetCurrentEmoteInfo
	-- upvalues: (copy) v_u_8, (copy) v_u_10, (copy) v_u_4
	local v41 = v_u_8.CurrentSubject and v_u_8.CurrentSubject.Entity
	if v41 then
		v41 = v_u_8.CurrentSubject.Entity:GetCurrentEmote()
	end
	if v41 then
		return v41.Info
	end
	local v42 = v_u_10.IsOpen
	if v42 then
		v42 = v_u_10.EquipmentState.SelectedCosmetic
	end
	local v43 = v_u_4.Cosmetics[v42]
	if v43 and v43.Type == "Emote" then
		return v43
	end
end
function v_u_15._GetVolume(p44) -- name: _GetVolume
	local v45 = p44._sound_info[2]
	local v46 = p44:_GetCurrentEmoteInfo()
	local v47 = v46 and v46.IsAudioIntrusive and 0 or 1
	return v45 * p44._volume_multiplier * p44._volume * v47
end
function v_u_15._TweenSoundID(p_u_48) -- name: _TweenSoundID
	-- upvalues: (copy) v_u_6
	if not p_u_48._is_tweening then
		p_u_48._is_tweening = true
		while p_u_48._sound.SoundId ~= p_u_48._sound_info[1] do
			local v49 = (p_u_48._sound_name == "" or p_u_48._sound.SoundId == "") and 0.25 or 2
			p_u_48._next_sound.SoundId = p_u_48._sound_info[1]
			if p_u_48._sound_name ~= "" then
				p_u_48._next_sound:Play()
				p_u_48._next_sound.TimePosition = p_u_48._sound.TimePosition
			end
			local v_u_50 = p_u_48._sound.Volume
			v_u_6:RenderstepForLoop(0, 100, v49, function(p51)
				-- upvalues: (copy) p_u_48, (copy) v_u_50
				local v52 = p51 / 100
				p_u_48._sound.Volume = (1 - v52) * v_u_50
				p_u_48._next_sound.Volume = v52 * p_u_48:_GetVolume()
			end)
			p_u_48._sound:Stop()
			local v53 = p_u_48._next_sound
			p_u_48._next_sound = p_u_48._sound
			p_u_48._sound = v53
		end
		p_u_48._is_tweening = false
	end
end
function v_u_15._UpdateVolume(p54) -- name: _UpdateVolume
	if not p54._is_tweening then
		p54._sound.Volume = p54:_GetVolume()
	end
end
function v_u_15._UpdateSoundID(p55) -- name: _UpdateSoundID
	-- upvalues: (copy) v_u_10, (copy) v_u_8, (copy) v_u_13, (copy) v_u_11, (copy) v_u_12
	p55:SetSoundID((v_u_10.IsOpen or v_u_8.CurrentDuelSubject and v_u_8.CurrentDuelSubject:Get("Status") == "GameOver") and v_u_13 or ((not v_u_8.CurrentDuelSubject and (p55.LocalFighter and not p55.LocalFighter:Get("IsInShootingRange")) and true or false) and (v_u_11.PageSystem.CurrentPage and v_u_13 or v_u_12) or (v_u_8.CurrentDuelSubject and v_u_8.CurrentDuelSubject:Get("DuelMusic") or nil)))
end
function v_u_15._DuelSubjectChanged(p_u_56) -- name: _DuelSubjectChanged
	-- upvalues: (copy) v_u_8
	p_u_56:_UpdateSoundID()
	if v_u_8.CurrentDuelSubject then
		local v57 = p_u_56._duel_subject_connections
		local v58 = v_u_8.CurrentDuelSubject:GetDataChangedSignal("DuelMusic")
		table.insert(v57, v58:Connect(function()
			-- upvalues: (copy) p_u_56
			p_u_56:_UpdateSoundID()
		end))
	end
end
function v_u_15._HookLocalFighter(p_u_59) -- name: _HookLocalFighter
	-- upvalues: (copy) v_u_9
	p_u_59.LocalFighter = v_u_9:WaitForLocalFighter()
	p_u_59.LocalFighter:GetDataChangedSignal("IsInShootingRange"):Connect(function()
		-- upvalues: (copy) p_u_59
		p_u_59:_UpdateSoundID()
	end)
	p_u_59.LocalFighter:GetDataChangedSignal("IsInDuel"):Connect(function()
		-- upvalues: (copy) p_u_59
		p_u_59:_UpdateSoundID()
	end)
	p_u_59:_UpdateSoundID()
end
function v_u_15._Setup(p60) -- name: _Setup
	-- upvalues: (copy) v_u_2
	p60._sound.Name = "Music"
	p60._sound.Looped = true
	p60._sound.SoundGroup = v_u_2.Master.Music
	p60._sound.Parent = script
	p60._next_sound.Name = "NextMusic"
	p60._next_sound.Looped = true
	p60._next_sound.SoundGroup = v_u_2.Master.Music
	p60._next_sound.Parent = script
end
function v_u_15._Init(p_u_61) -- name: _Init
	-- upvalues: (copy) v_u_8, (copy) v_u_10, (copy) v_u_11, (copy) v_u_7
	v_u_8.DuelSubjectChanged:Connect(function()
		-- upvalues: (copy) p_u_61
		p_u_61:_DuelSubjectChanged()
	end)
	v_u_8.DuelSubjectStatusChanged:Connect(function()
		-- upvalues: (copy) p_u_61
		p_u_61:_UpdateSoundID()
	end)
	v_u_8.SubjectEmoteStatusChanged:Connect(function()
		-- upvalues: (copy) p_u_61
		p_u_61:_UpdateVolume()
	end)
	v_u_10.Opened:Connect(function()
		-- upvalues: (copy) p_u_61
		p_u_61:_UpdateSoundID()
		p_u_61:_UpdateVolume()
	end)
	v_u_10.CustomizingStateChanged:Connect(function()
		-- upvalues: (copy) p_u_61
		p_u_61:_UpdateVolume()
	end)
	v_u_11.PageSystem.PagesActivity:Connect(function()
		-- upvalues: (copy) p_u_61
		p_u_61:_UpdateSoundID()
		p_u_61:_UpdateVolume()
	end)
	v_u_7:GetSettingChangedSignal("Master Volume"):Connect(function()
		-- upvalues: (copy) p_u_61
		p_u_61:_UpdateSoundGroups()
	end)
	v_u_7:GetSettingChangedSignal("Music Volume"):Connect(function()
		-- upvalues: (copy) p_u_61
		p_u_61:_UpdateSoundGroups()
	end)
	v_u_7:GetSettingChangedSignal("Other Volume"):Connect(function()
		-- upvalues: (copy) p_u_61
		p_u_61:_UpdateSoundGroups()
	end)
	v_u_7:GetSettingChangedSignal("Finisher Volume"):Connect(function()
		-- upvalues: (copy) p_u_61
		p_u_61:_UpdateSoundGroups()
	end)
	v_u_7:GetSettingChangedSignal("Emote Volume"):Connect(function()
		-- upvalues: (copy) p_u_61
		p_u_61:_UpdateSoundGroups()
	end)
	v_u_7:GetSettingChangedSignal("Mute Finishers From Others"):Connect(function()
		-- upvalues: (copy) p_u_61
		p_u_61:_UpdateSoundGroups()
	end)
	v_u_7:GetSettingChangedSignal("Mute Emotes From Others"):Connect(function()
		-- upvalues: (copy) p_u_61
		p_u_61:_UpdateSoundGroups()
	end)
	v_u_7.SettingsSliderChanged:Connect(function(p62, p63)
		-- upvalues: (copy) p_u_61
		if p62 == "Master Volume" or p62 == "Music Volume" then
			p_u_61:_UpdateSoundGroups(p62, p63)
		end
	end)
	p_u_61:_Setup()
	p_u_61:_UpdateVolume()
	p_u_61:_DuelSubjectChanged()
	task.spawn(p_u_61._HookLocalFighter, p_u_61)
	task.defer(p_u_61._UpdateSoundGroups, p_u_61)
end
return v_u_15._new()