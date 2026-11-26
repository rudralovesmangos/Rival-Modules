local v_u_1 = game:GetService("ReplicatedStorage")
local v2 = game:GetService("Players")
local v_u_3 = require(v2.LocalPlayer.PlayerScripts.Modules:WaitForChild("Page"):WaitForChild("DialogPage"))
local v_u_4 = setmetatable({}, v_u_3)
v_u_4.__index = v_u_4
function v_u_4._new() -- name: _new
	-- upvalues: (copy) v_u_3, (copy) v_u_4
	local v5 = v_u_3.new(script.Name)
	local v6 = v_u_4
	local v7 = setmetatable(v5, v6)
	v7._npc_name = nil
	v7:_Init()
	return v7
end
function v_u_4.SetNPCName(p8, p9) -- name: SetNPCName
	p8._npc_name = p9
	p8:_UpdateFetch()
end
function v_u_4._UpdateFetch(p10) -- name: _UpdateFetch
	-- upvalues: (copy) v_u_1
	if p10._npc_name then
		task.defer(p10._FetchDialog, p10, v_u_1.Remotes.Misc.FetchDialogLobby, p10._npc_name)
	end
end
function v_u_4._Init(p_u_11) -- name: _Init
	p_u_11:HookDialogActionKey("OpenCreditsPage", function()
		-- upvalues: (copy) p_u_11
		p_u_11.OpenPage:Fire("Credits")
	end)
end
return v_u_4._new()