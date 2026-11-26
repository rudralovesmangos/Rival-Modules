local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("CollectionService")
local v3 = game:GetService("Players")
local v_u_4 = require(v1.Modules.Utility)
local v_u_5 = require(v3.LocalPlayer.PlayerScripts.Controllers:WaitForChild("FighterController"))
local v_u_6 = {}
v_u_6.__index = v_u_6
function v_u_6._new() -- name: _new
	-- upvalues: (copy) v_u_6
	local v7 = v_u_6
	local v8 = setmetatable({}, v7)
	v8._objects = {}
	v8:_Init()
	return v8
end
function v_u_6._ObjectAdded(p9, p_u_10) -- name: _ObjectAdded
	-- upvalues: (copy) v_u_5, (copy) v_u_4
	local v_u_11 = p_u_10:GetAttribute("SoundID")
	local v_u_12 = p_u_10:GetAttribute("Volume")
	local v_u_13 = {
		["Connections"] = {},
		["Cooldowns"] = {}
	}
	local v14 = v_u_13.Connections
	local v15 = p_u_10.Touched
	local function v19(p16)
		-- upvalues: (ref) v_u_5, (copy) v_u_13, (ref) v_u_4, (copy) v_u_11, (copy) v_u_12, (copy) p_u_10
		local v17 = p16.AssemblyRootPart or p16
		local v18
		if v17 then
			v18 = v_u_5:GetFighter(v17.Parent)
		else
			v18 = v17
		end
		if v18 and (v18:IsAlive() and tick() >= (v_u_13.Cooldowns[v17] or 0)) then
			v_u_13.Cooldowns[v17] = tick() + 1
			v_u_4:CreateSound(v_u_11, v_u_12 or 1, 0.95 + 0.1 * math.random(), p_u_10, true, 10)
		end
	end
	table.insert(v14, v15:Connect(v19))
	p9._objects[p_u_10] = v_u_13
end
function v_u_6._ObjectRemoved(p20, p21) -- name: _ObjectRemoved
	local v22 = p20._objects[p21]
	if v22 then
		for _, v23 in pairs(v22.Connections) do
			v23:Disconnect()
		end
		p20._objects[p21] = nil
	end
end
function v_u_6._Init(p_u_24) -- name: _Init
	-- upvalues: (copy) v_u_2
	v_u_2:GetInstanceAddedSignal("SoundTrigger"):Connect(function(p25)
		-- upvalues: (copy) p_u_24
		p_u_24:_ObjectAdded(p25)
	end)
	v_u_2:GetInstanceRemovedSignal("SoundTrigger"):Connect(function(p26)
		-- upvalues: (copy) p_u_24
		p_u_24:_ObjectRemoved(p26)
	end)
	for _, v27 in pairs(v_u_2:GetTagged("SoundTrigger")) do
		task.defer(p_u_24._ObjectAdded, p_u_24, v27)
	end
end
return v_u_6._new()