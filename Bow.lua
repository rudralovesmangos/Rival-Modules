local v1 = game:GetService("Players")
local v_u_2 = require(v1.LocalPlayer.PlayerScripts.Modules:WaitForChild("ClientReplicatedClasses"):WaitForChild("ClientFighter"):WaitForChild("ClientItem"):WaitForChild("ItemInterface"))
local v_u_3 = require(script:WaitForChild("Charge"))
local v_u_4 = setmetatable({}, v_u_2)
v_u_4.__index = v_u_4
function v_u_4.new(...) -- name: new
	-- upvalues: (copy) v_u_2, (copy) v_u_4, (copy) v_u_3
	local v5 = v_u_2.new(...)
	local v6 = v_u_4
	local v7 = setmetatable(v5, v6)
	v7.Charge = v_u_3.new(v7)
	v7:_Init()
	return v7
end
function v_u_4.Destroy(p8) -- name: Destroy
	-- upvalues: (copy) v_u_2
	p8.Charge:Destroy()
	v_u_2.Destroy(p8)
end
function v_u_4._Init(_) -- name: _Init end
return v_u_4