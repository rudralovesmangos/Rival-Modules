local v_u_1 = game:GetService("CollectionService")
local v2 = game:GetService("Players")
local v_u_3 = require(v2.LocalPlayer.PlayerScripts.Modules.LeaderboardDisplay)
local v_u_4 = require(v2.LocalPlayer.PlayerScripts.Modules.LobbyElement)
local v_u_5 = setmetatable({}, v_u_4)
v_u_5.__index = v_u_5
function v_u_5._new(...) -- name: _new
	-- upvalues: (copy) v_u_4, (copy) v_u_5
	local v6 = v_u_4.new(...)
	local v7 = v_u_5
	local v8 = setmetatable(v6, v7)
	v8.Displays = {}
	v8:_Init()
	return v8
end
function v_u_5._DisplayAdded(p9, p10) -- name: _DisplayAdded
	-- upvalues: (copy) v_u_3
	local v11 = v_u_3.new(p10)
	local v12 = p9.Displays
	table.insert(v12, v11)
end
function v_u_5._Init(p_u_13) -- name: _Init
	-- upvalues: (copy) v_u_1
	v_u_1:GetInstanceAddedSignal("LeaderboardDisplay"):Connect(function(p14)
		-- upvalues: (copy) p_u_13
		p_u_13:_DisplayAdded(p14)
	end)
	for _, v15 in pairs(v_u_1:GetTagged("LeaderboardDisplay")) do
		task.defer(p_u_13._DisplayAdded, p_u_13, v15)
	end
end
return v_u_5._new()