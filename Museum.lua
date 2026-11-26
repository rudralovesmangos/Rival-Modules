local v1 = game:GetService("Players")
local v_u_2 = require(v1.LocalPlayer.PlayerScripts.Modules.ClientReplicatedClasses.ClientDuel.ClientMap)
local v_u_3 = { "Museum - Day", "Museum - Dusk", "Museum - Night" }
local v_u_4 = setmetatable({}, v_u_2)
v_u_4.__index = v_u_4
function v_u_4.new(...) -- name: new
	-- upvalues: (copy) v_u_2, (copy) v_u_4
	local v5 = v_u_2.new(...)
	local v6 = v_u_4
	local v7 = setmetatable(v5, v6)
	v7:_Init()
	return v7
end
function v_u_4._Init(p8) -- name: _Init
	-- upvalues: (copy) v_u_3
	p8:SetReplicate("LightingProfileOverride", v_u_3[Random.new(p8._seed):NextInteger(1, #v_u_3)])
end
return v_u_4