local v_u_1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("CollectionService")
local v_u_3 = {}
v_u_3.__index = v_u_3
function v_u_3._new() -- name: _new
	-- upvalues: (copy) v_u_3
	local v4 = v_u_3
	local v5 = setmetatable({}, v4)
	v5._connections = {}
	v5:_Init()
	return v5
end
function v_u_3._ObjectRemoved(p6, p7) -- name: _ObjectRemoved
	if p6._connections[p7] then
		p6._connections[p7]:Disconnect()
		p6._connections[p7] = nil
	end
end
function v_u_3._ObjectAdded(p8, p_u_9) -- name: _ObjectAdded
	-- upvalues: (copy) v_u_1
	p8:_ObjectRemoved(p_u_9)
	p8._connections[p_u_9] = p_u_9.Triggered:Connect(function()
		-- upvalues: (ref) v_u_1, (copy) p_u_9
		v_u_1.Remotes.Replication.Fighter.SnowballGrab:FireServer(p_u_9)
	end)
end
function v_u_3._Init(p_u_10) -- name: _Init
	-- upvalues: (copy) v_u_2
	v_u_2:GetInstanceAddedSignal("LobbySnowballSource"):Connect(function(p11)
		-- upvalues: (copy) p_u_10
		p_u_10:_ObjectAdded(p11)
	end)
	v_u_2:GetInstanceRemovedSignal("LobbySnowballSource"):Connect(function(p12)
		-- upvalues: (copy) p_u_10
		p_u_10:_ObjectRemoved(p12)
	end)
	for _, v13 in pairs(v_u_2:GetTagged("LobbySnowballSource")) do
		task.spawn(p_u_10._ObjectAdded, p_u_10, v13)
	end
end
return v_u_3._new()