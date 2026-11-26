local v1 = game:GetService("ReplicatedStorage")
local v2 = game:GetService("Players")
local v_u_3 = require(v1.Modules.SeasonLibrary)
local v_u_4 = require(v1.Modules.Utility)
local v_u_5 = require(v2.LocalPlayer.PlayerScripts.Controllers.PlayerDataController)
local v_u_6 = require(v2.LocalPlayer.PlayerScripts.Modules.BaseMatchmakingQueueSlot.MatchmakingQueueSlot)
local v_u_7 = {}
v_u_7.__index = v_u_7
function v_u_7.new(p8) -- name: new
	-- upvalues: (copy) v_u_7
	local v9 = v_u_7
	local v10 = setmetatable({}, v9)
	v10.Page = p8
	v10.Frame = v10.Page.Container:WaitForChild("Queues")
	v10._slots = {}
	v10:_Init()
	return v10
end
function v_u_7.Open(_) -- name: Open end
function v_u_7.Close(_) -- name: Close end
function v_u_7._UpdateVisibility(p11) -- name: _UpdateVisibility
	local v12 = 0
	for _, v13 in pairs(p11._slots) do
		v12 = v12 + (v13.Visible and 1 or 0)
	end
	for _, v14 in pairs(p11._slots) do
		v14.Size = UDim2.new(1 / v12 - (v12 - 1) * 0.01 / v12, 0, v14.Size.Y.Scale, v14.Size.Y.Offset)
	end
end
function v_u_7._Generate(p_u_15, p16, _, p_u_17) -- name: _Generate
	-- upvalues: (copy) v_u_4, (copy) v_u_6, (copy) v_u_5, (copy) v_u_3
	local v_u_18 = v_u_4:WaitForChildRecursive(p_u_15.Frame, p16, 3)
	if v_u_18 then
		local v_u_19 = v_u_6.new(p16, v_u_18)
		p_u_15._slots[v_u_19] = v_u_18
		v_u_19.QueueStatus:Connect(function(p20)
			-- upvalues: (copy) p_u_15
			if p20 == "Success" then
				p_u_15.Page.Closed:Fire()
			else
				p_u_15.Page.PromptSystem:Open("ErrorMessage", "Whoops!", p20 or "Server failed to respond, please try again")
			end
		end)
		local function v23() -- name: update_locked
			-- upvalues: (ref) v_u_5, (ref) v_u_3, (copy) p_u_17, (copy) v_u_19, (copy) v_u_18, (copy) p_u_15
			local v21 = v_u_5:Get("Seasons")[v_u_3.CurrentSeason.Name]
			if v21 then
				v21 = v21.RankedPerformances[v_u_3.UNIVERSAL_ELO_NAME]
			end
			if v21 then
				v21 = v21.CurrentELO
			end
			local v22 = v21 and p_u_17
			if v22 then
				v22 = p_u_17 <= v21
			end
			v_u_19:SetLocked(v22)
			v_u_18.Visible = not v22
			p_u_15:_UpdateVisibility()
		end
		v_u_5:GetDataChangedSignal("Seasons"):Connect(v23)
		v23()
	end
end
function v_u_7._Setup(p24) -- name: _Setup
	-- upvalues: (copy) v_u_3
	for _, v25 in pairs(v_u_3.CurrentSeason.RankedQueues) do
		task.defer(p24._Generate, p24, table.unpack(v25))
	end
end
function v_u_7._Init(p26) -- name: _Init
	p26:_Setup()
	p26:_UpdateVisibility()
end
return v_u_7