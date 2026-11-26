local v_u_1 = game:GetService("CollectionService")
local v2 = game:GetService("ReplicatedStorage")
local v3 = game:GetService("Players")
local v_u_4 = require(v2.Modules.ServerOsTime)
local v_u_5 = require(v3.LocalPlayer.PlayerScripts.Modules.LobbyElement)
local v_u_6 = setmetatable({}, v_u_5)
v_u_6.__index = v_u_6
function v_u_6._new(...) -- name: _new
	-- upvalues: (copy) v_u_5, (copy) v_u_6
	local v7 = v_u_5.new(...)
	local v8 = v_u_6
	local v9 = setmetatable(v7, v8)
	v9._stored_objects = {}
	v9:_Init()
	return v9
end
function v_u_6._CheckParent(p_u_10, p_u_11) -- name: _CheckParent
	-- upvalues: (copy) v_u_4
	task.defer(function()
		-- upvalues: (ref) v_u_4, (copy) p_u_10, (copy) p_u_11
		local v12 = v_u_4:Get()
		local v13 = p_u_10._stored_objects[p_u_11]
		local v14
		if v13.StartTime <= v12 then
			v14 = v12 < v13.EndTime
		else
			v14 = false
		end
		if v13.Inverse then
			v14 = not v14
		end
		local v15
		if v14 then
			v15 = v13.OriginalParent
		else
			v15 = nil
		end
		p_u_11.Parent = v15
	end)
end
function v_u_6._DelayedCheck(p16, p17, p18) -- name: _DelayedCheck
	if p18 > 0 and p18 < (1 / 0) then
		task.delay(p18, p16._CheckParent, p16, p17)
	end
end
function v_u_6._ObjectAdded(p19, p20) -- name: _ObjectAdded
	-- upvalues: (copy) v_u_4
	if not p19._stored_objects[p20] then
		local v21 = {
			["OriginalParent"] = p20.Parent,
			["StartTime"] = p20:GetAttribute("StartTime") or 0,
			["EndTime"] = p20:GetAttribute("EndTime") or (1 / 0),
			["Inverse"] = p20:GetAttribute("Inverse") or false
		}
		p19._stored_objects[p20] = v21
		p19:_DelayedCheck(p20, v21.StartTime - v_u_4:Get())
		p19:_DelayedCheck(p20, v21.EndTime - v_u_4:Get())
		p19:_CheckParent(p20)
	end
end
function v_u_6._Init(p_u_22) -- name: _Init
	-- upvalues: (copy) v_u_1
	v_u_1:GetInstanceAddedSignal("LobbyOnlyAppearWhen"):Connect(function(p23)
		-- upvalues: (copy) p_u_22
		p_u_22:_ObjectAdded(p23)
	end)
	for _, v24 in pairs(v_u_1:GetTagged("LobbyOnlyAppearWhen")) do
		task.spawn(p_u_22._ObjectAdded, p_u_22, v24)
	end
end
return v_u_6._new()