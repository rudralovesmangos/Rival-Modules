local v_u_1 = game:GetService("CollectionService")
local v2 = game:GetService("Players")
local v_u_3 = require(v2.LocalPlayer.PlayerScripts.Modules.LobbyElement)
local v_u_4 = setmetatable({}, v_u_3)
v_u_4.__index = v_u_4
function v_u_4._new(...) -- name: _new
	-- upvalues: (copy) v_u_3, (copy) v_u_4
	local v5 = v_u_3.new(...)
	local v6 = v_u_4
	local v7 = setmetatable(v5, v6)
	v7:_Init()
	return v7
end
function v_u_4._ObjectAdded(_, p8) -- name: _ObjectAdded
	while true do
		local v9 = Instance.new("Animation")
		v9.AnimationId = p8:GetAttribute("IdleAnimation")
		local v10 = p8.LoadAnimation
		local v11, v12 = pcall(v10, p8, v9)
		if v11 then
			local v13 = v12.Play
			if pcall(v13, v12) then
				return
			end
		end
		wait(1)
	end
end
function v_u_4._Init(p_u_14) -- name: _Init
	-- upvalues: (copy) v_u_1
	v_u_1:GetInstanceAddedSignal("LobbyAnimation"):Connect(function(p15)
		-- upvalues: (copy) p_u_14
		p_u_14:_ObjectAdded(p15)
	end)
	for _, v16 in pairs(v_u_1:GetTagged("LobbyAnimation")) do
		task.defer(p_u_14._ObjectAdded, p_u_14, v16)
	end
end
return v_u_4._new()