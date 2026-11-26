local v1 = game:GetService("Players")
local v_u_2 = require(v1.LocalPlayer.PlayerScripts.Modules.ClientReplicatedClasses.ClientEntity)
local v_u_3 = setmetatable({}, v_u_2)
v_u_3.__index = v_u_3
function v_u_3.new(...) -- name: new
	-- upvalues: (copy) v_u_2, (copy) v_u_3
	local v4 = v_u_2.new(...)
	local v5 = v_u_3
	local v6 = setmetatable(v4, v5)
	v6:_Init()
	return v6
end
function v_u_3.GetHealth(p7) -- name: GetHealth
	return p7.Model:GetAttribute("Health")
end
function v_u_3.GetMaxHealth(p8) -- name: GetMaxHealth
	return p8.Model:GetAttribute("MaxHealth")
end
function v_u_3._Init(p_u_9) -- name: _Init
	p_u_9.Model:GetAttributeChangedSignal("MaxHealth"):Connect(function()
		-- upvalues: (copy) p_u_9
		p_u_9.HealthChanged:Fire()
	end)
	p_u_9.Model:GetAttributeChangedSignal("Health"):Connect(function()
		-- upvalues: (copy) p_u_9
		p_u_9.HealthChanged:Fire()
	end)
end
return v_u_3