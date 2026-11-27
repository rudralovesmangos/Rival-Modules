local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("UserInputService")
local v_u_3 = game:GetService("GuiService")
local v_u_4 = game:GetService("StarterGui")
local v_u_5 = game:GetService("Players")
local v_u_6 = require(v1.Modules.CONSTANTS)
local v_u_7 = require(v1.Modules.Utility)
local v_u_8 = require(v_u_5.LocalPlayer.PlayerScripts.Controllers:WaitForChild("PrivateServerController"))
local v_u_9 = require(v_u_5.LocalPlayer.PlayerScripts.Controllers:WaitForChild("SpectateController"))
local v_u_10 = require(v_u_5.LocalPlayer.PlayerScripts.Controllers:WaitForChild("QueuePadController"))
local v_u_11 = require(v_u_5.LocalPlayer.PlayerScripts.Controllers:WaitForChild("PartyController"))
local v_u_12 = require(v_u_5.LocalPlayer.PlayerScripts.Controllers:WaitForChild("DuelController"))
local v_u_13 = require(v_u_5.LocalPlayer.PlayerScripts.Modules:WaitForChild("UserInterface"):WaitForChild("Pages"))
local v_u_14 = require(v_u_5.LocalPlayer.PlayerScripts.Modules:WaitForChild("WeaponStatusHandler"))
local v_u_15 = require(v_u_5.LocalPlayer.PlayerScripts.Modules:WaitForChild("ButtonEffect"))
local v_u_16 = require(v_u_5.LocalPlayer.PlayerScripts.Modules:WaitForChild("UILibrary"))
local v_u_17 = UDim2.new(1.25, 0, 0.5, 0)
local v_u_18 = UDim2.new(0, 0, 0.5, 0)
local v_u_19 = v_u_5.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("PlayerListInspectActionSlot")
local v_u_20 = {
	["HoverRatio"] = 1,
	["ReleaseRatio"] = 1
}
local v_u_21 = {
	{
		"Invite",
		"Party Invite",
		Color3.fromRGB(100, 255, 0),
		"rbxassetid://89570813431745",
		0.55
	},
	{
		"Friend",
		"Add Friend",
		Color3.fromRGB(100, 255, 0),
		"rbxassetid://95245645462537"
	},
	{
		"Challenge",
		"Challenge",
		Color3.fromRGB(255, 150, 0),
		"rbxassetid://18525954682"
	},
	{
		"Spectate",
		"Spectate",
		Color3.fromRGB(255, 150, 0),
		"rbxassetid://77908042044589"
	},
	{
		"ViewProfile",
		"View Profile",
		Color3.fromRGB(0, 150, 255),
		"rbxassetid://113844621753627",
		0.65
	},
	{
		"ViewAvatar",
		"View Avatar",
		Color3.fromRGB(0, 150, 255),
		"rbxassetid://113844621753627",
		0.65
	},
	{
		"Gift",
		"Send Gift",
		Color3.fromRGB(255, 149, 253),
		"rbxassetid://127400882945494",
		0.65
	},
	{
		"Unfriend",
		"Remove Friend",
		Color3.fromRGB(255, 50, 50),
		"rbxassetid://99528569460280"
	},
	{
		"Block",
		"Block",
		Color3.fromRGB(255, 50, 50),
		"rbxassetid://71490041005019"
	},
	{
		"Unblock",
		"Unblock",
		Color3.fromRGB(255, 50, 50),
		"rbxassetid://71490041005019"
	},
	{
		"Kick",
		"Server Kick",
		Color3.fromRGB(255, 50, 50),
		"rbxassetid://76417427319315",
		0.65
	},
	{
		"Ban",
		"Server Ban",
		Color3.fromRGB(255, 50, 50),
		"rbxassetid://76417427319315"
	}
}
local v_u_22 = {}
v_u_22.__index = v_u_22
function v_u_22.new(p23) -- name: new
	-- upvalues: (copy) v_u_22
	local v24 = v_u_22
	local v25 = setmetatable({}, v24)
	v25.PlayerList = p23
	v25.Frame = v25.PlayerList.Container:WaitForChild("Inspect")
	v25.Background = v25.Frame:WaitForChild("Background")
	v25.Container = v25.Frame:WaitForChild("Container")
	v25.Layout = v25.Container:WaitForChild("Layout")
	v25.PlayerFrame = v25.Container:WaitForChild("Player")
	v25.PlayerHeadshot = v25.PlayerFrame:WaitForChild("Headshot")
	v25.PlayerUsername = v25.PlayerFrame:WaitForChild("Username")
	v25.PlayerDisplayName = v25.PlayerFrame:WaitForChild("DisplayName")
	v25._selected_player_list_slot = false
	v25._action_slots = {}
	v25:_Init()
	return v25
end
function v_u_22.SetScale(p26, p27) -- name: SetScale
	p26.Frame.Size = UDim2.new(0.95 * p27, 0, 5, 0)
end
function v_u_22.SelectPlayer(p28, p29) -- name: SelectPlayer
	-- upvalues: (copy) v_u_18, (copy) v_u_17, (copy) v_u_5, (copy) v_u_6, (copy) v_u_11, (copy) v_u_10, (copy) v_u_12, (copy) v_u_7, (copy) v_u_14
	if p29 == p28._selected_player_list_slot then
		return
	elseif p29 and not p28.PlayerList.IsOpen then
		return
	else
		p28._selected_player_list_slot = p29
		for _, v30 in pairs(p28.PlayerList.Elements.PlayerListSlots) do
			v30:SetHighlighted(p28._selected_player_list_slot == v30)
		end
		local v31
		if p28._selected_player_list_slot then
			v31 = UDim2.new(0, -4, 0, p28._selected_player_list_slot.Frame.AbsolutePosition.Y - p28.PlayerList.Container.AbsolutePosition.Y)
		else
			v31 = p28.Frame.Position
		end
		local v32
		if p28._selected_player_list_slot then
			v32 = v_u_18
		else
			v32 = v_u_17
		end
		p28.Frame.Position = v31
		local v33 = p28.Container
		local v34
		if p28._selected_player_list_slot then
			v34 = v_u_17
		else
			v34 = p28.Container.Position
		end
		v33.Position = v34
		if p28.Container:IsDescendantOf(v_u_5.LocalPlayer.PlayerGui) then
			p28.Container:TweenPosition(v32, "Out", "Quint", 0.25, true)
		else
			p28.Container.Position = v32
		end
		if p28._selected_player_list_slot then
			local v35 = p28._selected_player_list_slot.ClientFighter.Player
			local v36 = p28._selected_player_list_slot.ClientFighter.IsLocalPlayer
			local v37 = p28._selected_player_list_slot:IsBlocked()
			local v38 = not v37
			if v38 then
				v38 = p28._selected_player_list_slot:IsFriend()
			end
			local v39 = v_u_6.IS_PRIVATE_SERVER_OWNER(v_u_5.LocalPlayer.UserId)
			local v40 = p28._action_slots.Invite
			local v41 = not v37
			if v41 then
				v41 = v_u_11:CanInvitePlayerToParty(v35)
			end
			v40.Visible = v41
			local v42 = p28._action_slots.Friend
			local v43 = not (v37 or v38)
			if v43 then
				local v44 = not v36
				v43 = v44 and true or v44
			end
			v42.Visible = v43
			local v45 = p28._action_slots.Challenge
			local v46 = not v37
			if v46 then
				v46 = v_u_10:CanChallenge(v35)
			end
			v45.Visible = v46
			local v47 = p28._action_slots.Spectate
			local v48 = not v37
			if v48 then
				v48 = v_u_12:GetDuel(v35) ~= nil
			end
			v47.Visible = v48
			p28._action_slots.ViewProfile.Visible = not v37
			p28._action_slots.ViewAvatar.Visible = not v37
			local v49 = p28._action_slots.Unfriend
			local v50 = not v37
			if v50 then
				if v38 then
					local v51 = not v36
					v38 = v51 and true or v51
				end
			else
				v38 = v50
			end
			v49.Visible = v38
			local v52 = p28._action_slots.Block
			local v53 = not v37
			if v53 then
				v53 = not v36
			end
			v52.Visible = v53
			local v54 = p28._action_slots.Unblock
			local v55
			if v37 then
				v55 = not v36
			else
				v55 = v37
			end
			v54.Visible = v55
			local v56 = p28._action_slots.Gift
			local v57 = not v37
			if v57 then
				v57 = not v36
			end
			v56.Visible = v57
			p28._action_slots.Kick.Visible = not v36 and v39
			p28._action_slots.Ban.Visible = not v36 and v39
			p28.PlayerHeadshot.Image = string.format(v_u_6.HEADSHOT_IMAGE, v35.UserId)
			p28.PlayerDisplayName.Text = v_u_7:GetName(p28._selected_player_list_slot.ClientFighter.Player, v35.DisplayName, true)
			p28.PlayerUsername.Text = "@" .. v35.Name
			v_u_14:ClearStatusElements(p28.PlayerDisplayName)
			v_u_14:ApplyItemStatusToText(p28.PlayerDisplayName, v35:GetAttribute("PlayerStatus"))
			p28:_UpdateCooldowns()
			p28:_UpdateBackground()
		end
	end
end
function v_u_22.OnOpened(p_u_58) -- name: OnOpened
	-- upvalues: (copy) v_u_10, (copy) v_u_11, (copy) v_u_2, (copy) v_u_16
	p_u_58.PlayerList:AddOpenedConnection(v_u_10.ChallengeRequestCooldownChanged:Connect(function()
		-- upvalues: (copy) p_u_58
		p_u_58:_UpdateCooldowns()
	end))
	p_u_58.PlayerList:AddOpenedConnection(v_u_11.InviteRequestCooldownChanged:Connect(function()
		-- upvalues: (copy) p_u_58
		p_u_58:_UpdateCooldowns()
	end))
	p_u_58.PlayerList:AddOpenedConnection(v_u_2.InputBegan:Connect(function(p59)
		-- upvalues: (ref) v_u_16, (copy) p_u_58
		if v_u_16:IsMouseWithinBounds(p_u_58.Container.AbsolutePosition, p_u_58.Layout.AbsoluteContentSize) then
			return
		elseif not v_u_16:IsMouseWithinBounds(p_u_58.PlayerList.Elements.Frame.AbsolutePosition, p_u_58.PlayerList.Elements.Frame.AbsoluteSize) then
			if p59.UserInputType == Enum.UserInputType.MouseButton1 or p59.UserInputType == Enum.UserInputType.Touch then
				p_u_58:SelectPlayer(nil)
			end
		end
	end))
	p_u_58:_UpdateCooldowns()
	p_u_58:_UpdateBackground()
end
function v_u_22._UpdateBackground(p60) -- name: _UpdateBackground
	p60.Background.Size = UDim2.new(1, 0, 0, p60.Layout.AbsoluteContentSize.Y)
	p60.Background.Position = p60.Container.Position
end
function v_u_22._UpdateCooldowns(p61) -- name: _UpdateCooldowns
	-- upvalues: (copy) v_u_10, (copy) v_u_11
	local v62 = p61._selected_player_list_slot
	if v62 then
		v62 = p61._selected_player_list_slot.ClientFighter.Player
	end
	local v63 = p61._action_slots.Challenge.Button.Cooldown
	local v64
	if v62 then
		v64 = v_u_10:IsChallengeRequestOnCooldown(v62)
	else
		v64 = v62
	end
	v63.Visible = v64
	p61._action_slots.Challenge.Button.Icon.Visible = not p61._action_slots.Challenge.Button.Cooldown.Visible
	local v65 = p61._action_slots.Invite.Button.Cooldown
	if v62 then
		v62 = v_u_11:IsInviteRequestOnCooldown(v62)
	end
	v65.Visible = v62
	p61._action_slots.Invite.Button.Icon.Visible = not p61._action_slots.Invite.Button.Cooldown.Visible
end
function v_u_22._SlotAdded(p_u_66, p_u_67) -- name: _SlotAdded
	p_u_67.Clicked:Connect(function()
		-- upvalues: (copy) p_u_66, (copy) p_u_67
		local v68 = p_u_66
		local v69
		if p_u_66._selected_player_list_slot == p_u_67 then
			v69 = nil
		else
			v69 = p_u_67
		end
		v68:SelectPlayer(v69)
	end)
	p_u_67:SetHighlighted(p_u_66._selected_player_list_slot == p_u_67)
end
function v_u_22._HookButton(p_u_70, p71, p_u_72) -- name: _HookButton
	p_u_70._action_slots[p71].Button.MouseButton1Click:Connect(function()
		-- upvalues: (copy) p_u_70, (copy) p_u_72
		if p_u_70._selected_player_list_slot then
			p_u_72()
		end
	end)
end
function v_u_22._Setup(p_u_73) -- name: _Setup
	-- upvalues: (copy) v_u_21, (copy) v_u_19, (copy) v_u_15, (copy) v_u_20, (copy) v_u_11, (copy) v_u_4, (copy) v_u_10, (copy) v_u_12, (copy) v_u_9, (copy) v_u_13, (copy) v_u_3, (copy) v_u_8
	for _, v74 in pairs(v_u_21) do
		local v75, v76, v_u_77, v78, v79 = table.unpack(v74)
		local v_u_80 = v_u_19:Clone()
		v_u_80.Button.Background.ImageColor3 = v_u_77
		v_u_80.Button.Icon.Image = v78
		v_u_80.Button.Icon.Size = UDim2.new(0.2, 0, v79 or 0.75, 0)
		v_u_80.Button.Title.Text = v76
		v_u_80.Parent = p_u_73.Container
		p_u_73._action_slots[v75] = v_u_80
		v_u_15:Add(v_u_80.Button, nil, v_u_20)
		v_u_80.Button.MouseLeave:Connect(function() -- name: unhover
			-- upvalues: (copy) v_u_80, (copy) v_u_77
			v_u_80.Button.Background.ImageColor3 = v_u_77
			v_u_80.Button.Background.ImageTransparency = 0.5
			v_u_80.Button.Background.UIGradient.Enabled = true
			v_u_80.Button.Icon.ImageColor3 = Color3.fromRGB(255, 255, 255)
			v_u_80.Button.Title.TextColor3 = Color3.fromRGB(255, 255, 255)
		end)
		v_u_80.Button.MouseEnter:Connect(function() -- name: hover
			-- upvalues: (copy) v_u_80
			v_u_80.Button.Background.ImageColor3 = Color3.fromRGB(255, 255, 255)
			v_u_80.Button.Background.ImageTransparency = 0
			v_u_80.Button.Background.UIGradient.Enabled = false
			v_u_80.Button.Icon.ImageColor3 = Color3.fromRGB(0, 0, 0)
			v_u_80.Button.Title.TextColor3 = Color3.fromRGB(0, 0, 0)
		end)
	end
	p_u_73:_HookButton("Invite", function()
		-- upvalues: (ref) v_u_11, (copy) p_u_73
		v_u_11:SendPartyInvite(p_u_73._selected_player_list_slot.ClientFighter.Player)
	end)
	p_u_73:_HookButton("Friend", function()
		-- upvalues: (ref) v_u_4, (copy) p_u_73
		v_u_4:SetCore("PromptSendFriendRequest", p_u_73._selected_player_list_slot.ClientFighter.Player)
	end)
	p_u_73:_HookButton("Challenge", function()
		-- upvalues: (ref) v_u_10, (copy) p_u_73
		v_u_10:SendChallengeRequest(p_u_73._selected_player_list_slot.ClientFighter.Player)
	end)
	p_u_73:_HookButton("Spectate", function()
		-- upvalues: (copy) p_u_73, (ref) v_u_12, (ref) v_u_9
		p_u_73._action_slots.Spectate.Visible = false
		local v81 = v_u_12:GetDuel(p_u_73._selected_player_list_slot.ClientFighter.Player)
		if v81 then
			v_u_9:SpectateDuelRequest(v81)
		end
	end)
	p_u_73:_HookButton("ViewProfile", function()
		-- upvalues: (copy) p_u_73, (ref) v_u_13
		local v82 = p_u_73._selected_player_list_slot.ClientFighter.Player
		v_u_13.PageSystem:OpenPage("ViewProfile")
		v_u_13.PageSystem:WaitForPage("ViewProfile"):Fetch(v82)
	end)
	p_u_73:_HookButton("ViewAvatar", function()
		-- upvalues: (ref) v_u_3, (copy) p_u_73
		v_u_3:InspectPlayerFromUserId(p_u_73._selected_player_list_slot.ClientFighter.Player.UserId)
	end)
	p_u_73:_HookButton("Unfriend", function()
		-- upvalues: (ref) v_u_4, (copy) p_u_73
		v_u_4:SetCore("PromptUnfriend", p_u_73._selected_player_list_slot.ClientFighter.Player)
	end)
	p_u_73:_HookButton("Block", function()
		-- upvalues: (ref) v_u_4, (copy) p_u_73
		v_u_4:SetCore("PromptBlockPlayer", p_u_73._selected_player_list_slot.ClientFighter.Player)
	end)
	p_u_73:_HookButton("Unblock", function()
		-- upvalues: (ref) v_u_4, (copy) p_u_73
		v_u_4:SetCore("PromptUnblockPlayer", p_u_73._selected_player_list_slot.ClientFighter.Player)
	end)
	p_u_73:_HookButton("Gift", function()
		-- upvalues: (copy) p_u_73, (ref) v_u_13
		local v83 = p_u_73._selected_player_list_slot.ClientFighter.Player
		v_u_13.PageSystem:OpenPage("Gifting")
		v_u_13.PageSystem:WaitForPage("Gifting"):SelectPlayer(v83)
		v_u_13.PageSystem:WaitForPage("Gifting"):DontRedirect()
	end)
	p_u_73:_HookButton("Kick", function()
		-- upvalues: (ref) v_u_8, (copy) p_u_73
		v_u_8:ServerKick(p_u_73._selected_player_list_slot.ClientFighter.Player)
	end)
	p_u_73:_HookButton("Ban", function()
		-- upvalues: (ref) v_u_8, (copy) p_u_73
		v_u_8:ServerBan(p_u_73._selected_player_list_slot.ClientFighter.Player)
	end)
end
function v_u_22._Init(p_u_84) -- name: _Init
	p_u_84.Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		-- upvalues: (copy) p_u_84
		p_u_84:_UpdateBackground()
	end)
	p_u_84.Container:GetPropertyChangedSignal("AbsolutePosition"):Connect(function()
		-- upvalues: (copy) p_u_84
		p_u_84:_UpdateBackground()
	end)
	p_u_84.PlayerList.OpenedChanged:Connect(function()
		-- upvalues: (copy) p_u_84
		if not p_u_84.PlayerList.IsOpen then
			p_u_84:SelectPlayer(nil)
		end
	end)
	p_u_84.PlayerList.Elements.PlayerListSlotRemoved:Connect(function(p85)
		-- upvalues: (copy) p_u_84
		if p85 == p_u_84._selected_player_list_slot then
			p_u_84:SelectPlayer(nil)
		end
	end)
	p_u_84.PlayerList.Elements.PlayerListSlotAdded:Connect(function(p86)
		-- upvalues: (copy) p_u_84
		p_u_84:_SlotAdded(p86)
	end)
	for _, v87 in pairs(p_u_84.PlayerList.Elements.PlayerListSlots) do
		task.defer(p_u_84._SlotAdded, p_u_84, v87)
	end
	p_u_84:_Setup()
	p_u_84:SelectPlayer(nil)
	p_u_84:_UpdateBackground()
end
return v_u_22