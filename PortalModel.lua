local v_u_1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("Players")
local v_u_3 = require(v_u_1.Modules.GameplayUtility)
local v_u_4 = require(v_u_1.Modules.Utility)
local v_u_5 = require(v_u_2.LocalPlayer.PlayerScripts.Controllers.FighterController)
local v_u_6 = require(script:WaitForChild("Portal"))
local v_u_7 = {}
v_u_7.__index = v_u_7
function v_u_7.new(p8) -- name: new
	-- upvalues: (copy) v_u_7
	local v9 = v_u_7
	local v10 = setmetatable({}, v9)
	v10.Model = p8
	v10.Portals = {}
	v10._item_id = v10.Model:GetAttribute("ItemID")
	v10._user_id = v10.Model:GetAttribute("UserID")
	v10._teleport_cooldowns = {}
	v10:_Init()
	return v10
end
function v_u_7.GetPortal(p11, p12) -- name: GetPortal
	for v13, v14 in pairs(p11.Portals) do
		if v14.Model ~= p12 then
			continue
		end
		return v14, v13
	end
end
function v_u_7.GetOtherPortal(p15, p16) -- name: GetOtherPortal
	return p15.Portals[3 - p16.PortalNum]
end
function v_u_7.ArePortalsGrown(p17) -- name: ArePortalsGrown
	local v18 = p17.Portals[1] and (p17.Portals[1]:IsGrown() and p17.Portals[2])
	if v18 then
		v18 = p17.Portals[2]:IsGrown()
	end
	return v18
end
function v_u_7.CanWarp(p19) -- name: CanWarp
	-- upvalues: (copy) v_u_2
	local v20 = p19.Portals[1]
	if v20 then
		v20 = not (p19.Portals[2] and p19._user_id) or p19._user_id == v_u_2.LocalPlayer.UserId
	end
	return v20
end
function v_u_7.Update(p21, p22) -- name: Update
	for _, v23 in pairs(p21.Portals) do
		v23:Update(p22)
	end
end
function v_u_7.Destroy(p_u_24) -- name: Destroy
	for _, v25 in pairs(p_u_24.Portals) do
		v25:Destroy()
	end
	pcall(function()
		-- upvalues: (copy) p_u_24
		p_u_24.Model:Destroy()
	end)
end
function v_u_7._Touched(p26, p27, p28) -- name: _Touched
	-- upvalues: (copy) v_u_2, (copy) v_u_5, (copy) v_u_3, (copy) v_u_4, (copy) v_u_1
	if p26:CanWarp() and p26:ArePortalsGrown() then
		local v29 = p26:GetOtherPortal(p27)
		if v29 then
			local v30 = p28.AssemblyRootPart or p28
			if p28.Parent == v_u_2.LocalPlayer.Character and (tick() >= (p26._teleport_cooldowns[p27.PortalNum][v30] or 0) and (v_u_5.LocalFighter and v_u_5.LocalFighter:IsAlive())) then
				local v31 = v_u_3:GetRaycastWhitelist(v_u_2.LocalPlayer:GetAttribute("EnvironmentID"))
				local v32 = v_u_4:Raycast(p27.Hitbox.Position, v30.Position, (p27.Hitbox.Position - v30.Position).Magnitude, v31, Enum.RaycastFilterType.Include)
				if not v32.Instance or v32.Instance:IsDescendantOf(v30.Parent) then
					p26._teleport_cooldowns[p27.PortalNum][v30] = tick() + 0.25
					p26._teleport_cooldowns[v29.PortalNum][v30] = tick() + 1
					v_u_5.LocalFighter.Entity:WarpTo(v29:GetTeleportCFrame())
					v_u_4:CreateSound("rbxassetid://86785771664692", 0.5, 1 + 0.1 * math.random(), p27.Hitbox.Position, true, 10)
					v_u_4:CreateSound("rbxassetid://81610952487049", 1, 1 + 0.1 * math.random(), v29.Hitbox.Position, true, 10)
					v_u_1.Remotes.Replication.Fighter.PlayMechanicsSound:FireServer("Warp")
					v_u_1.Remotes.Replication.Fighter.JustWarped:FireServer(p26._item_id, p27.PortalNum)
				end
			else
				return
			end
		else
			return
		end
	else
		return
	end
end
function v_u_7._UpdateVisuals(p33) -- name: _UpdateVisuals
	local v34 = p33:CanWarp()
	for _, v35 in pairs(p33.Portals) do
		v35:UpdateVisuals(v34)
	end
end
function v_u_7._ChildRemoved(p36, p37) -- name: _ChildRemoved
	local v38, v39 = p36:GetPortal(p37)
	if v38 then
		v38:Destroy()
		p36.Portals[v39] = nil
		p36:_UpdateVisuals()
	end
end
function v_u_7._ChildAdded(p_u_40, p41) -- name: _ChildAdded
	-- upvalues: (copy) v_u_6, (copy) v_u_2, (copy) v_u_4
	if p41:IsA("Model") then
		p_u_40:_ChildRemoved(p41)
		local v_u_42 = v_u_6.new(p41)
		p_u_40.Portals[v_u_42.PortalNum] = v_u_42
		p_u_40:_UpdateVisuals()
		p_u_40._teleport_cooldowns[v_u_42.PortalNum] = {}
		v_u_42.Hitbox.Touched:Connect(function(p43)
			-- upvalues: (copy) p_u_40, (copy) v_u_42
			p_u_40:_Touched(v_u_42, p43)
		end)
		local function v51() -- name: check_now
			-- upvalues: (ref) v_u_2, (ref) v_u_4, (copy) v_u_42, (copy) p_u_40
			for _, v44 in pairs(v_u_2.LocalPlayer.Character and v_u_2.LocalPlayer.Character:GetChildren() or {}) do
				if not v44:IsA("BasePart") then
					continue
				end
				local v45 = v_u_4
				local v46 = v_u_42.Hitbox
				local v47 = v44.Position
				local v48 = v44.Size.X
				local v49 = v44.Size.Y
				local v50 = v44.Size.Z
				if not v45:IsWithinPart(v46, v47, Vector3.new(1, 1, 1) * math.max(v48, v49, v50) * 1.4142135623730951) then
					continue
				end
				p_u_40:_Touched(v_u_42, v44)
				return
			end
		end
		v_u_42.FinishedGrowing:Connect(v51)
		v51()
	end
end
function v_u_7._Init(p_u_52) -- name: _Init
	p_u_52.Model.ChildAdded:Connect(function(p53)
		-- upvalues: (copy) p_u_52
		p_u_52:_ChildAdded(p53)
	end)
	p_u_52.Model.ChildRemoved:Connect(function(p54)
		-- upvalues: (copy) p_u_52
		p_u_52:_ChildRemoved(p54)
	end)
end
return v_u_7