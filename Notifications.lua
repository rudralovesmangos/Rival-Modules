local v_u_1 = game:GetService("ReplicatedStorage")
local v2 = game:GetService("Players")
local v_u_3 = require(v_u_1.Modules.BetterDebris)
local v_u_4 = require(v_u_1.Modules.Signal)
local v_u_5 = require(v2.LocalPlayer.PlayerScripts.Controllers:WaitForChild("PlayerDataController"))
local v_u_6 = require(v2.LocalPlayer.PlayerScripts.Controllers:WaitForChild("FighterController"))
local v_u_7 = require(v2.LocalPlayer.PlayerScripts.Modules:WaitForChild("NotificationSlot"))
local v_u_8 = require(v2.LocalPlayer.PlayerScripts.Modules:WaitForChild("UILibrary"))
local v_u_9 = {}
v_u_9.__index = v_u_9
function v_u_9._new() -- name: _new
	-- upvalues: (copy) v_u_9, (copy) v_u_4, (copy) v_u_8
	local v10 = v_u_9
	local v11 = setmetatable({}, v10)
	v11.NotificationSent = v_u_4.new()
	v11.Frame = v_u_8:GetTo("MainFrame", "Notifications")
	v11._queue = {}
	v11._is_playing_queue = false
	v11:_Init()
	return v11
end
function v_u_9.Play(p12, p13, p14, p15, p16, p17, p18, p19) -- name: Play
	-- upvalues: (copy) v_u_5, (copy) v_u_7, (copy) v_u_3
	p12.NotificationSent:Fire(p13, p14, p15, p16)
	if not p19 and v_u_5:GetSetting("Notifications Delivery") ~= "Muted" then
		local v20 = v_u_7.new(p13, p14, p15, p16)
		v20:SetParent(p12.Frame.Container)
		v20:PlaySize(p17, 5)
		v20:PlaySound(p18)
		v20:PlayGlow()
		v_u_3:AddItem(v20, 10)
	end
end
function v_u_9.Queue(p21, ...) -- name: Queue
	local v22 = p21._queue
	table.insert(v22, { ... })
	p21:_PlayQueue()
end
function v_u_9._PlayQueue(p23) -- name: _PlayQueue
	-- upvalues: (copy) v_u_5
	if p23._is_playing_queue then
		return
	elseif v_u_5:GetSetting("Notifications Delivery") ~= "Lobby" or not (p23._local_fighter and p23._local_fighter:Get("IsInDuel")) then
		p23._is_playing_queue = true
		local v24 = true
		while #p23._queue > 0 do
			if v24 then
				wait(0.25)
				v24 = false
			end
			local v25 = #p23._queue
			local v26 = 1 - (math.min(5, v25) - 1) * 0.1
			local v27 = 1
			while true do
				local v28 = v27 <= 5 and table.remove(p23._queue, 1)
				if not v28 then
					break
				end
				local v29, v30, v31, v32, v33, v34 = table.unpack(v28)
				task.spawn(p23.Play, p23, v29, v30, v31, v32, (v33 or 1) * v26, nil, v34)
				if v34 then
					continue
				end
				wait(0.1)
				v27 = v27 + 1
			end
			wait(5)
		end
		p23._is_playing_queue = false
	end
end
function v_u_9._HookFighter(p_u_35) -- name: _HookFighter
	-- upvalues: (copy) v_u_6
	p_u_35._local_fighter = v_u_6:WaitForLocalFighter()
	p_u_35._local_fighter:GetDataChangedSignal("IsInDuel"):Connect(function()
		-- upvalues: (copy) p_u_35
		p_u_35:_PlayQueue()
	end)
	p_u_35:_PlayQueue()
end
function v_u_9._Init(p_u_36) -- name: _Init
	-- upvalues: (copy) v_u_1
	v_u_1.Remotes.Data.PlayNotification.OnClientEvent:Connect(function(...)
		-- upvalues: (copy) p_u_36
		p_u_36:Queue(...)
	end)
	task.defer(p_u_36._HookFighter, p_u_36)
end
return v_u_9._new()