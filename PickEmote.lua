local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("UserInputService")
local v_u_3 = game:GetService("GamepadService")
local v4 = game:GetService("Players")
local v_u_5 = require(v1.Modules.CosmeticLibrary)
local v_u_6 = require(v4.LocalPlayer.PlayerScripts.Controllers:WaitForChild("PlayerDataController"))
local v_u_7 = require(v4.LocalPlayer.PlayerScripts.Controllers:WaitForChild("ControlsController"))
local v_u_8 = require(v4.LocalPlayer.PlayerScripts.Controllers:WaitForChild("EmoteController"))
local v_u_9 = require(v4.LocalPlayer.PlayerScripts.Modules:WaitForChild("ButtonEffect"))
local v_u_10 = require(v4.LocalPlayer.PlayerScripts.Modules:WaitForChild("CosmeticSlot"))
local v_u_11 = require(v4.LocalPlayer.PlayerScripts.Modules:WaitForChild("EmoteWheel"))
local v_u_12 = require(v4.LocalPlayer.PlayerScripts.Modules:WaitForChild("UILibrary"))
local v_u_13 = require(v4.LocalPlayer.PlayerScripts.Modules:WaitForChild("Page"))
local v_u_14 = setmetatable({}, v_u_13)
v_u_14.__index = v_u_14
function v_u_14._new() -- name: _new
	-- upvalues: (copy) v_u_13, (copy) v_u_14, (copy) v_u_11
	local v15 = v_u_13.new(script.Name)
	local v16 = v_u_14
	local v17 = setmetatable(v15, v16)
	v17.EmoteWheelSlotsFrame = v17.PageFrame:WaitForChild("EmoteWheelSlots")
	v17.EmoteWheelSlotsButton = v17.EmoteWheelSlotsFrame:WaitForChild("AllEmotes")
	v17.EmoteWheelSlotsButtonMouseKeyboardKeybindFrame = v17.EmoteWheelSlotsButton:WaitForChild("Inputs"):WaitForChild("MouseKeyboard"):WaitForChild("Keybind")
	v17.EmoteWheelSlotsButtonGamepadKeybindFrame = v17.EmoteWheelSlotsButton:WaitForChild("Inputs"):WaitForChild("Gamepad"):WaitForChild("Keybind")
	v17.AllEmotesFrame = v17.PageFrame:WaitForChild("AllEmotes")
	v17.AllEmotesList = v17.AllEmotesFrame:WaitForChild("List")
	v17.AllEmotesContainer = v17.AllEmotesList:WaitForChild("Container")
	v17.AllEmotesLayout = v17.AllEmotesContainer:WaitForChild("Layout")
	v17.AllEmotesCentererFrame = v17.AllEmotesContainer:WaitForChild("Centerer")
	v17.AllEmotesHeaderFrame = v17.AllEmotesContainer:WaitForChild("Header")
	v17.AllEmotesHeaderIcon = v17.AllEmotesHeaderFrame:WaitForChild("Icon")
	v17.AllEmotesHeaderCloseButton = v17.AllEmotesHeaderFrame:WaitForChild("Close")
	v17.AllEmotesSlotsFrame = v17.AllEmotesContainer:WaitForChild("Slots")
	v17.AllEmotesSlotsContainer = v17.AllEmotesSlotsFrame:WaitForChild("Container")
	v17.AllEmotesSlotsLayout = v17.AllEmotesSlotsContainer:WaitForChild("Layout")
	v17.HidePartyDisplay = true
	v17.EmoteWheel = v_u_11.new()
	v17._all_emotes_open = false
	v17._cosmetic_slots = {}
	v17:_Init()
	return v17
end
function v_u_14.GetDefaultElement(_) -- name: GetDefaultElement
	return nil
end
function v_u_14.SetAllEmotesOpen(p18, p19) -- name: SetAllEmotesOpen
	-- upvalues: (copy) v_u_7, (copy) v_u_3
	p18._all_emotes_open = p18._is_open and p19
	p18.AllEmotesFrame.Visible = p18._all_emotes_open
	p18.EmoteWheelSlotsFrame.Visible = not p18._all_emotes_open
	p18:_VerifyEmoteWheel()
	p18:_VerifyAllEmotes()
	if p18._all_emotes_open and v_u_7.CurrentControls == "Gamepad" then
		v_u_3:EnableGamepadCursor(p18.AllEmotesSlotsFrame)
	end
end
function v_u_14.PickEarly(p20) -- name: PickEarly
	-- upvalues: (copy) v_u_7
	if p20._all_emotes_open then
		if v_u_7.CurrentControls == "MouseKeyboard" then
			p20:_PickHoveredCosmeticSlot()
			return
		end
	else
		p20.EmoteWheel:FinishInputs()
	end
end
function v_u_14.Open(p_u_21, ...) -- name: Open
	-- upvalues: (copy) v_u_13, (copy) v_u_2, (copy) v_u_7
	v_u_13.Open(p_u_21, ...)
	p_u_21.EmoteWheelSlotsButtonMouseKeyboardKeybindFrame:AddTag("UIKeybindContainer")
	p_u_21.EmoteWheelSlotsButtonGamepadKeybindFrame:AddTag("UIKeybindContainer")
	p_u_21:SetAllEmotesOpen(false)
	local v_u_22 = 0
	local v23 = p_u_21._open_connections
	local v24 = v_u_2.InputChanged
	local function v27(p25, _)
		-- upvalues: (copy) p_u_21, (ref) v_u_7, (ref) v_u_22
		if not p_u_21._all_emotes_open and v_u_7.CurrentControls == "MouseKeyboard" then
			v_u_22 = v_u_22 + p25.Position.Z
			local v26 = v_u_22
			if math.abs(v26) >= 1 then
				p_u_21:SetAllEmotesOpen(true)
			end
		end
	end
	table.insert(v23, v24:Connect(v27))
end
function v_u_14._UpdateCenterer(_) -- name: _UpdateCenterer end
function v_u_14._Update(p28) -- name: _Update
	p28.AllEmotesList.CanvasSize = UDim2.new(0, 0, 0, p28.AllEmotesLayout.AbsoluteContentSize.Y)
	p28.AllEmotesSlotsFrame.Size = UDim2.new(1, 0, 0, p28.AllEmotesSlotsLayout.AbsoluteContentSize.Y)
end
function v_u_14._PickByKey(p29, p30) -- name: _PickByKey
	-- upvalues: (copy) v_u_8
	if p29._is_open then
		v_u_8:UseEmote(p30)
		p29:CloseRequest()
	end
end
function v_u_14._PickByName(p31, p32) -- name: _PickByName
	-- upvalues: (copy) v_u_8
	if p31._is_open then
		v_u_8:UseEmoteByName(p32)
		p31:CloseRequest()
	end
end
function v_u_14._PickHoveredCosmeticSlot(p33) -- name: _PickHoveredCosmeticSlot
	-- upvalues: (copy) v_u_12
	for _, v34 in pairs(p33._cosmetic_slots) do
		if not v_u_12:IsMouseWithinBounds(v34.Frame.AbsolutePosition, v34.Frame.AbsoluteSize) then
			continue
		end
		p33:_PickByName(v34.Name)
		return
	end
end
function v_u_14._VerifyAllEmotes(p_u_35) -- name: _VerifyAllEmotes
	-- upvalues: (copy) v_u_5, (copy) v_u_6, (copy) v_u_10
	for _, v36 in pairs(p_u_35._cosmetic_slots) do
		v36:Destroy()
	end
	p_u_35._cosmetic_slots = {}
	local v37 = p_u_35._is_open
	if v37 then
		v37 = p_u_35._all_emotes_open
	end
	if v37 then
		local v38 = {}
		for v39, v40 in pairs(v_u_5.CosmeticsAlphabetized) do
			table.insert(v38, {
				["Name"] = v40,
				["AlphabeticalValue"] = v39
			})
		end
		table.sort(v38, function(p41, p42)
			-- upvalues: (ref) v_u_5
			local v43 = v_u_5.Rarities[v_u_5.Cosmetics[p41.Name].Rarity].Value
			local v44 = v_u_5.Rarities[v_u_5.Cosmetics[p42.Name].Rarity].Value
			if v43 == v44 then
				return p41.AlphabeticalValue < p42.AlphabeticalValue
			else
				return v44 < v43
			end
		end)
		for v45, v46 in pairs(v38) do
			local v_u_47 = v46.Name
			if v_u_5.Cosmetics[v_u_47].Type ~= "Emote" or not v_u_5:OwnsCosmetic(v_u_6:Get("CosmeticInventory"), v_u_47) then
				continue
			end
			local v48 = v_u_10.new(v_u_47)
			v48.Frame.LayoutOrder = v45
			v48.Frame.Parent = p_u_35.AllEmotesSlotsContainer
			local v49 = p_u_35._cosmetic_slots
			table.insert(v49, v48)
			v48.Frame.Button.MouseButton1Click:Connect(function()
				-- upvalues: (copy) p_u_35, (copy) v_u_47
				p_u_35:_PickByName(v_u_47)
			end)
		end
	end
end
function v_u_14._VerifyEmoteWheel(p50) -- name: _VerifyEmoteWheel
	local v51 = p50._is_open
	if v51 then
		v51 = not p50._all_emotes_open
	end
	p50.EmoteWheel:SetEnabled(v51)
	if v51 then
		p50.EmoteWheel:StartInputs()
	else
		p50.EmoteWheel:StopInputs()
	end
end
function v_u_14._Setup(p52) -- name: _Setup
	-- upvalues: (copy) v_u_5
	p52.AllEmotesHeaderIcon.Image = v_u_5.Types.Emote.Image
	p52.EmoteWheel.Frame.Parent = p52.EmoteWheelSlotsFrame
end
function v_u_14._Init(p_u_53) -- name: _Init
	-- upvalues: (copy) v_u_8, (copy) v_u_9
	p_u_53.AllEmotesHeaderCloseButton.MouseButton1Click:Connect(function()
		-- upvalues: (copy) p_u_53
		p_u_53:CloseRequest()
	end)
	p_u_53.EmoteWheelSlotsButton.MouseButton1Click:Connect(function()
		-- upvalues: (copy) p_u_53
		p_u_53:SetAllEmotesOpen(true)
	end)
	p_u_53.AllEmotesList:GetPropertyChangedSignal("AbsolutePosition"):Connect(function()
		-- upvalues: (copy) p_u_53
		p_u_53:_Update()
	end)
	p_u_53.AllEmotesSlotsLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		-- upvalues: (copy) p_u_53
		p_u_53:_Update()
	end)
	p_u_53.AllEmotesLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		-- upvalues: (copy) p_u_53
		p_u_53:_Update()
	end)
	p_u_53.AllEmotesList:GetPropertyChangedSignal("AbsoluteWindowSize"):Connect(function()
		-- upvalues: (copy) p_u_53
		p_u_53:_UpdateCenterer()
	end)
	p_u_53.AllEmotesList:GetPropertyChangedSignal("CanvasSize"):Connect(function()
		-- upvalues: (copy) p_u_53
		p_u_53:_UpdateCenterer()
	end)
	p_u_53.OpenChanged:Connect(function()
		-- upvalues: (copy) p_u_53
		p_u_53:_VerifyEmoteWheel()
	end)
	p_u_53.EmoteWheel.EmoteKeyPicked:Connect(function(p54)
		-- upvalues: (copy) p_u_53
		p_u_53:_PickByKey(p54)
	end)
	v_u_8.CanEmoteChanged:Connect(function()
		-- upvalues: (ref) v_u_8, (copy) p_u_53
		if not v_u_8:CanEmote(true) then
			p_u_53:CloseRequest()
		end
	end)
	p_u_53:_Setup()
	p_u_53:_Update()
	v_u_9:Add(p_u_53.EmoteWheelSlotsButton)
	v_u_9:Add(p_u_53.AllEmotesHeaderCloseButton)
end
return v_u_14._new()