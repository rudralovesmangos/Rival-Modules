local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("CollectionService")
local v3 = game:GetService("Players")
local v_u_4 = require(v1.Modules.CONSTANTS)
local v_u_5 = require(v3.LocalPlayer.PlayerScripts.Modules.LobbyElement)
local v_u_6 = setmetatable({}, v_u_5)
v_u_6.__index = v_u_6
function v_u_6._new(...) -- name: _new
	-- upvalues: (copy) v_u_5, (copy) v_u_6
	local v7 = v_u_5.new(...)
	local v8 = v_u_6
	local v9 = setmetatable(v7, v8)
	v9:_Init()
	return v9
end
function v_u_6.Update(p10, _) -- name: Update
	-- upvalues: (copy) v_u_2
	local v11 = tick()
	local v12 = math.cos(v11) ^ 3 - math.sin(v11) ^ 3
	local v13 = Vector3.new(0, v12, 0) * 0.5
	local v14 = v11 - 3.141592653589793
	local v15 = math.cos(v14) ^ 3
	local v16 = v11 - 3.141592653589793
	local v17 = v15 - math.sin(v16) ^ 3
	local v18 = Vector3.new(0, v17, 0) * 0.5
	for _, v19 in pairs(v_u_2:GetTagged("LobbyDuelsSign")) do
		v19.Yellow:PivotTo(p10:_GetOriginalPivot(v19.Yellow) + v13)
		v19.Purple:PivotTo(p10:_GetOriginalPivot(v19.Purple) + v18)
	end
end
function v_u_6._Setup(_) -- name: _Setup
	-- upvalues: (copy) v_u_4, (copy) v_u_2
	local function v21(p20) -- name: object_added
		-- upvalues: (ref) v_u_4
		p20:WaitForChild("Screen"):WaitForChild("Duels").Enabled = v_u_4.QUEUES_ACTIVE
		p20:WaitForChild("Screen"):WaitForChild("Play").Enabled = not v_u_4.QUEUES_ACTIVE
	end
	v_u_2:GetInstanceAddedSignal("LobbyDuelsSign"):Connect(v21)
	for _, v22 in pairs(v_u_2:GetTagged("LobbyDuelsSign")) do
		v22:WaitForChild("Screen"):WaitForChild("Duels").Enabled = v_u_4.QUEUES_ACTIVE
		v22:WaitForChild("Screen"):WaitForChild("Play").Enabled = not v_u_4.QUEUES_ACTIVE
	end
end
function v_u_6._Init(p23) -- name: _Init
	p23:_Setup()
end
return v_u_6._new()