local v1 = game:GetService("ReplicatedStorage")
local v2 = game:GetService("Players")
require(v1.Modules.CONSTANTS)
local v_u_3 = require(v2.LocalPlayer.PlayerScripts.Modules.ClientReplicatedClasses.ClientEntity.ClientHumanoidEntity)
local v_u_4 = {}
v_u_4.__index = v_u_4
function v_u_4.new(p5) -- name: new
	-- upvalues: (copy) v_u_4
	local v6 = v_u_4
	local v7 = setmetatable({}, v6)
	v7.ClientFighterCharacter = p5
	v7._last_is_alive_check = nil
	v7._last_is_grounded_check = nil
	v7._is_grounded_time = nil
	v7:_Init()
	return v7
end
function v_u_4.IsAliveCached(p8) -- name: IsAliveCached
	-- upvalues: (copy) v_u_3
	local _ = p8._last_is_alive_check == nil
	local v9 = p8.ClientFighterCharacter.Head
	if v9 then
		v9 = v_u_3.IsAlive(p8.ClientFighterCharacter)
	end
	p8._last_is_alive_check = v9
	return v9
end
function v_u_4.IsGroundedCached(p10) -- name: IsGroundedCached
	if p10._last_is_grounded_check ~= nil then
		return p10._last_is_grounded_check
	end
	if not p10.ClientFighterCharacter:IsAlive() then
		p10._last_is_grounded_check = false
		return false
	end
	local v11 = not p10.ClientFighterCharacter:IsHumanoidStateAirborne()
	p10._last_is_grounded_check = v11
	return v11
end
function v_u_4.Update(p12, _, _) -- name: Update
	p12._last_is_alive_check = nil
	p12._last_is_grounded_check = nil
end
function v_u_4.Destroy(_) -- name: Destroy end
function v_u_4._UpdateHumanoidStates(p13) -- name: _UpdateHumanoidStates
	if p13.ClientFighterCharacter.Humanoid then
		local v14 = p13.ClientFighterCharacter:Get("IsFrozen") and true or false
		p13.ClientFighterCharacter.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
		p13.ClientFighterCharacter.Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
		p13.ClientFighterCharacter.Humanoid:SetStateEnabled(Enum.HumanoidStateType.PlatformStanding, v14)
		p13.ClientFighterCharacter.Humanoid.PlatformStand = v14
	end
end
function v_u_4._Init(p_u_15) -- name: _Init
	p_u_15.ClientFighterCharacter:GetDataChangedSignal("IsFrozen"):Connect(function()
		-- upvalues: (copy) p_u_15
		p_u_15:_UpdateHumanoidStates()
	end)
	p_u_15:_UpdateHumanoidStates()
end
return v_u_4