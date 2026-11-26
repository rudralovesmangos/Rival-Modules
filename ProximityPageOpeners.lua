local v_u_1 = game:GetService("CollectionService")
local v2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("Players")
local v_u_4 = require(v2.Modules.Utility)
local v_u_5 = require(v_u_3.LocalPlayer.PlayerScripts.Modules.LobbyElement)
local v_u_6 = require(v_u_3.LocalPlayer.PlayerScripts.Modules.UserInterface.Pages)
local v_u_7 = setmetatable({}, v_u_5)
v_u_7.__index = v_u_7
function v_u_7._new(...) -- name: _new
	-- upvalues: (copy) v_u_5, (copy) v_u_7
	local v8 = v_u_5.new(...)
	local v9 = v_u_7
	local v10 = setmetatable(v8, v9)
	v10:_Init()
	return v10
end
function v_u_7._PartAdded(_, p_u_11) -- name: _PartAdded
	-- upvalues: (copy) v_u_6, (copy) v_u_3, (copy) v_u_4
	local v_u_12 = p_u_11:GetAttribute("PageName")
	local v_u_13 = false
	p_u_11.Touched:Connect(function(p14)
		-- upvalues: (ref) v_u_13, (ref) v_u_6, (ref) v_u_3, (copy) v_u_12, (ref) v_u_4, (copy) p_u_11
		if v_u_13 or (v_u_6.PageSystem.CurrentPage or (not p14.AssemblyRootPart or (not p14.AssemblyRootPart.Parent or v_u_3:GetPlayerFromCharacter(p14.AssemblyRootPart.Parent) ~= v_u_3.LocalPlayer))) then
			return
		end
		v_u_13 = true
		v_u_6.PageSystem:OpenPage(v_u_12, true)
		while p14:IsDescendantOf(workspace) do
			local v15 = v_u_4
			local v16 = p_u_11
			local v17 = p14.Position
			local v18 = p14.Size.X
			local v19 = p14.Size.Y
			local v20 = p14.Size.Z
			if not v15:IsWithinPart(v16, v17, Vector3.new(1, 1, 1) * math.max(v18, v19, v20) * 5) then
				break
			end
			wait(0.1)
		end
		v_u_13 = false
		if v_u_6.PageSystem.CurrentPage and v_u_6.PageSystem.CurrentPage.Name == v_u_12 then
			v_u_6.PageSystem:CloseCurrentPage()
		end
	end)
end
function v_u_7._Init(p_u_21) -- name: _Init
	-- upvalues: (copy) v_u_1
	v_u_1:GetInstanceAddedSignal("ProximityPageOpener"):Connect(function(p22)
		-- upvalues: (copy) p_u_21
		p_u_21:_PartAdded(p22)
	end)
	for _, v23 in pairs(v_u_1:GetTagged("ProximityPageOpener")) do
		task.defer(p_u_21._PartAdded, p_u_21, v23)
	end
end
return v_u_7._new()