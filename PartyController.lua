local v_u_1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("Players")
local v_u_3 = require(v_u_1.Modules.CONSTANTS)
local v_u_4 = require(v_u_1.Modules.Signal)
local v_u_5 = require(v_u_2.LocalPlayer.PlayerScripts.Controllers.DuelController)
local v_u_6 = {}
v_u_6.__index = v_u_6
function v_u_6._new() -- name: _new
	-- upvalues: (copy) v_u_6, (copy) v_u_4
	local v7 = v_u_6
	local v8 = setmetatable({}, v7)
	v8.PartyChanged = v_u_4.new()
	v8.InviteRequestCooldownChanged = v_u_4.new()
	v8.CurrentParty = nil
	v8._invite_cooldowns = {}
	v8:_Init()
	return v8
end
function v_u_6.IsPartyLeader(p9) -- name: IsPartyLeader
	-- upvalues: (copy) v_u_2
	return not p9.CurrentParty or p9.CurrentParty[1] == v_u_2.LocalPlayer
end
function v_u_6.IsInParty(p10, p11) -- name: IsInParty
	local v12 = p10.CurrentParty
	if v12 then
		v12 = table.find(p10.CurrentParty, p11)
	end
	return v12
end
function v_u_6.IsInviteRequestOnCooldown(p13, p14) -- name: IsInviteRequestOnCooldown
	return tick() < (p13._invite_cooldowns[p14] or 0)
end
function v_u_6.CanInvitePlayerToParty(p15, p16) -- name: CanInvitePlayerToParty
	-- upvalues: (copy) v_u_2, (copy) v_u_3, (copy) v_u_5
	local v17 = p16 and ((p16 ~= v_u_2.LocalPlayer or v_u_3.IS_STUDIO) and (p15:IsPartyLeader() and not p15:IsInParty(p16)))
	if v17 then
		v17 = not v_u_5:GetDuel(p16)
	end
	return v17
end
function v_u_6.SendPartyInvite(p18, p19) -- name: SendPartyInvite
	-- upvalues: (copy) v_u_1
	if p18:CanInvitePlayerToParty(p19) and not p18:IsInviteRequestOnCooldown(p19) then
		p18._invite_cooldowns[p19] = tick() + 15
		p18.InviteRequestCooldownChanged:Fire()
		task.delay(15, p18.InviteRequestCooldownChanged.Fire, p18.InviteRequestCooldownChanged)
		v_u_1.Remotes.Matchmaking.SendPartyInvite:FireServer(p19)
	end
end
function v_u_6._FetchParty(_) -- name: _FetchParty
	-- upvalues: (copy) v_u_1
	v_u_1.Remotes.Matchmaking.RequestOneTimePartyReplication:FireServer()
end
function v_u_6._Init(p_u_20) -- name: _Init
	-- upvalues: (copy) v_u_1
	v_u_1.Remotes.Matchmaking.UpdateParty.OnClientEvent:Connect(function(p21)
		-- upvalues: (copy) p_u_20
		p_u_20.CurrentParty = p21
		p_u_20.PartyChanged:Fire()
	end)
	task.defer(p_u_20._FetchParty, p_u_20)
end
return v_u_6._new()