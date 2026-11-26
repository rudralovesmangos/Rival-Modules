local v_u_1 = game:GetService("CollectionService")
local v_u_2 = game:GetService("RunService")
local v_u_3 = game:GetService("Players")
local v_u_4 = require(v_u_3.LocalPlayer.PlayerScripts.Controllers.FighterController)
local v_u_5 = require(v_u_3.LocalPlayer.PlayerScripts.Controllers.WrapController)
local v_u_6 = {}
v_u_6.__index = v_u_6
function v_u_6._new() -- name: _new
	-- upvalues: (copy) v_u_6
	local v7 = v_u_6
	local v8 = setmetatable({}, v7)
	v8:_Init()
	return v8
end
function v_u_6._GetItem(_, p9) -- name: _GetItem
	-- upvalues: (copy) v_u_4
	for _, v10 in pairs(v_u_4.Objects) do
		local v11 = v10:GetItem(p9)
		if not v11 then
			continue
		end
		return v11
	end
end
function v_u_6._SetupWrap(_, p_u_12, p_u_13) -- name: _SetupWrap
	-- upvalues: (copy) v_u_5
	local v_u_14 = nil
	p_u_12.DescendantAdded:Connect(function(p15)
		-- upvalues: (ref) v_u_5, (ref) v_u_14, (copy) p_u_12, (copy) p_u_13
		if p15:HasTag("Wrappable") then
			v_u_5:ResetWrap(v_u_14)
			v_u_14 = v_u_5:RecordOriginalWrapProperties(p_u_12)
			v_u_5:ApplyWrap(v_u_14, p_u_13:GetWrap(), true)
		end
	end)
	v_u_5:ResetWrap(v_u_14)
	v_u_14 = v_u_5:RecordOriginalWrapProperties(p_u_12)
	v_u_5:ApplyWrap(v_u_14, p_u_13:GetWrap(), true)
end
function v_u_6._ObjectAdded(p16, p17) -- name: _ObjectAdded
	-- upvalues: (copy) v_u_3, (copy) v_u_4, (copy) v_u_2
	p17:WaitForChild("Hitbox")
	local v18 = p17:GetAttribute("ObjectID")
	local v19 = p17:GetAttribute("HitboxDelay")
	local v20 = p17:GetAttribute("PlacedByUserID")
	local v21 = p17:GetAttribute("TeamID")
	local v22 = p16:_GetItem(v18)
	if v22 then
		v22.ViewModel:PlayHideMineSound(p17)
		p16:_SetupWrap(p17, v22)
	end
	local v_u_23 = v20 ~= v_u_3.LocalPlayer.UserId and (v_u_4.LocalFighter and v_u_4.LocalFighter:Get("TeamID"))
	if v_u_23 then
		v_u_23 = v_u_4.LocalFighter:Get("TeamID") == v21
	end
	local v_u_24 = v_u_23 and 0.5 or 1
	local v25 = v19 / 2
	local v_u_26 = 0
	local v_u_27 = {}
	local function v29(p28) -- name: add_object
		-- upvalues: (copy) v_u_27, (copy) v_u_23, (copy) v_u_24, (ref) v_u_26
		if p28:IsA("BasePart") or (p28:IsA("Decal") or (p28:IsA("Texture") or (p28:IsA("ParticleEmitter") or (p28:IsA("Trail") or p28:IsA("Beam"))))) then
			v_u_27[p28] = p28:HasTag("DontShowToEnemies") or false
			p28.LocalTransparencyModifier = v_u_27[p28] and not v_u_23 and 1 or v_u_24 * v_u_26
		end
	end
	p17.DescendantAdded:Connect(v29)
	for _, v30 in pairs(p17:GetDescendants()) do
		v29(v30)
	end
	v_u_26 = 0
	local v31 = v_u_26
	for v32 in pairs(v_u_27) do
		v32.LocalTransparencyModifier = v_u_27[v32] and not v_u_23 and 1 or v_u_24 * v31
	end
	wait(v19 / 2)
	local v33 = tick()
	while p17:IsDescendantOf(workspace) and tick() < v33 + v25 do
		local v34 = (tick() - v33) / v25
		v_u_26 = math.clamp(v34, 0, 1)
		local v35 = v_u_26
		for v36 in pairs(v_u_27) do
			v36.LocalTransparencyModifier = v_u_27[v36] and not v_u_23 and 1 or v_u_24 * v35
		end
		v_u_2.RenderStepped:Wait()
	end
	v_u_26 = 1
	local v37 = v_u_26
	for v38 in pairs(v_u_27) do
		v38.LocalTransparencyModifier = v_u_27[v38] and not v_u_23 and 1 or v_u_24 * v37
	end
end
function v_u_6._Init(p_u_39) -- name: _Init
	-- upvalues: (copy) v_u_1
	v_u_1:GetInstanceAddedSignal("SubspaceTripmine"):Connect(function(p40)
		-- upvalues: (copy) p_u_39
		p_u_39:_ObjectAdded(p40)
	end)
	for _, v41 in pairs(v_u_1:GetTagged("SubspaceTripmine")) do
		task.defer(p_u_39._ObjectAdded, p_u_39, v41)
	end
end
return v_u_6._new()