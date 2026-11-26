local v_u_1 = game:GetService("CollectionService")
local v2 = game:GetService("ReplicatedStorage")
local v3 = game:GetService("Players")
local v_u_4 = require(v2.Modules.BetterDebris)
local v_u_5 = require(v2.Modules.Utility)
local v_u_6 = v3.LocalPlayer.PlayerScripts.Assets.Misc:WaitForChild("HolodomeImpactMarkers")
local v_u_7 = {}
v_u_7.__index = v_u_7
function v_u_7._new() -- name: _new
	-- upvalues: (copy) v_u_7
	local v8 = v_u_7
	local v9 = setmetatable({}, v8)
	v9._hitboxes = {}
	v9:_Init()
	return v9
end
function v_u_7.PlayImpactMarker(_, p10, p11, p12) -- name: PlayImpactMarker
	-- upvalues: (copy) v_u_6, (copy) v_u_4, (copy) v_u_5
	local v13 = (v_u_6:FindFirstChild(p10:GetAttribute("ViewModelName")) or v_u_6.Holodome):Clone()
	v13.CFrame = CFrame.new(p11, p11 + p12)
	v13.Parent = workspace
	v_u_4:AddItem(v13, 5)
	v_u_5:PlayParticles(v13)
	v_u_5:CreateSound("rbxassetid://129081197550702", 0.5, 1 + 0.5 * math.random(), v13, true, 5)
end
function v_u_7._ObjectAdded(p14, p15) -- name: _ObjectAdded
	p14:_ObjectRemoved(p15)
	p14._hitboxes[p15] = {}
end
function v_u_7._ObjectRemoved(p16, p17) -- name: _ObjectRemoved
	p16._hitboxes[p17] = nil
end
function v_u_7._Init(p_u_18) -- name: _Init
	-- upvalues: (copy) v_u_1
	v_u_1:GetInstanceAddedSignal("HolodomeHitbox"):Connect(function(p19)
		-- upvalues: (copy) p_u_18
		p_u_18:_ObjectAdded(p19)
	end)
	v_u_1:GetInstanceRemovedSignal("HolodomeHitbox"):Connect(function(p20)
		-- upvalues: (copy) p_u_18
		p_u_18:_ObjectRemoved(p20)
	end)
	for _, v21 in pairs(v_u_1:GetTagged("HolodomeHitbox")) do
		task.defer(p_u_18._ObjectAdded, p_u_18, v21)
	end
end
return v_u_7._new()