local v_u_1 = game:GetService("CollectionService")
local v2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("RunService")
local v4 = game:GetService("Players")
local v_u_5 = require(v2.Modules.Utility)
local v_u_6 = require(v4.LocalPlayer.PlayerScripts.Controllers.FighterController)
local v_u_7 = require(v4.LocalPlayer.PlayerScripts.Controllers.WrapController)
local v_u_8 = v4.LocalPlayer.PlayerScripts.Assets:WaitForChild("Misc"):WaitForChild("JumpPads")
local v_u_9 = {
	["Default"] = { "rbxassetid://85163949920258", 1 },
	["Trampoline"] = { "rbxassetid://75001064846226", 1 },
	["Bounce House"] = { "rbxassetid://139519788113881", 1 },
	["Shady Chicken Sandwich"] = { "rbxassetid://99488347318534", 1.25 },
	["Spider Web"] = { "rbxassetid://88449856112147", 1.25 },
	["Jolly Man"] = { "rbxassetid://111488886881644", 1.5 },
	["Flamingo Floatie"] = { "rbxassetid://139519788113881", 1 }
}
local v_u_10 = {
	["Default"] = { "rbxassetid://17835965985", 1 },
	["Trampoline"] = { "rbxassetid://79142560912255", 1 },
	["Bounce House"] = { "rbxassetid://18963214636", 1 },
	["Shady Chicken Sandwich"] = { "rbxassetid://138205332923098", 1.25 },
	["Spider Web"] = { "rbxassetid://128812513158754", 1.25 },
	["Flamingo Floatie"] = { "rbxassetid://130086876465618", 1 }
}
local v_u_11 = {}
v_u_11.__index = v_u_11
function v_u_11._new() -- name: _new
	-- upvalues: (copy) v_u_11
	local v12 = v_u_11
	local v13 = setmetatable({}, v12)
	v13:_Init()
	return v13
end
function v_u_11.CreateJumpPadVisual(_, p14, p15) -- name: CreateJumpPadVisual
	-- upvalues: (copy) v_u_8
	local v16 = (v_u_8:FindFirstChild(p14 or "Default") or v_u_8.Default):Clone()
	v16:ScaleTo(v16:GetScale() * p15.X / 10)
	for _, v17 in pairs(v16:GetDescendants()) do
		if not v17:IsA("BasePart") then
			continue
		end
		v17.Anchored = true
		v17.CanCollide = false
		v17.CanTouch = false
		v17.CanQuery = false
		v17.Massless = true
	end
	return v16
end
function v_u_11._ObjectAdded(p18, p19) -- name: _ObjectAdded
	-- upvalues: (copy) v_u_10, (copy) v_u_9, (copy) v_u_5, (copy) v_u_6, (copy) v_u_7, (copy) v_u_3
	local v20 = p19:GetAttribute("ViewModelName")
	local v21 = p19:GetAttribute("ObjectID")
	local v22 = v_u_10[v20] or v_u_10.Default
	local v23 = v_u_9[v20] or v_u_9.Default
	p19:SetAttribute("SoundID", v22[1])
	p19:SetAttribute("SoundVolume", v22[2])
	v_u_5:CreateSound(v23[1], v23[2], 1.25, p19, true, 5)
	local v24 = p18:CreateJumpPadVisual(v20, p19.Size)
	v24.Parent = p19
	local v25 = v_u_6:GetWrap(v21)
	if v25 then
		v_u_7:ApplyWrap(v_u_7:RecordOriginalWrapProperties(v24), v25, true)
	end
	local v26 = v24:GetScale() * 1.25
	local v27 = v24:GetScale()
	local v28 = CFrame.Angles(0, 0, 0.17453292519943295 * (math.random() - 0.5))
	local v29 = tick()
	while tick() < v29 + 0.25 do
		local v30 = 1 - (1 - (tick() - v29) / 0.25) ^ 3
		v24:ScaleTo(v26 + (v27 - v26) * v30)
		v24:PivotTo(p19:GetPivot() * CFrame.new(0, 0, p19.Size.Z / 2) * v28:Lerp(CFrame.identity, v30))
		v_u_3.RenderStepped:Wait()
	end
	v24:ScaleTo(v27)
	v24:PivotTo(p19:GetPivot() * CFrame.new(0, 0, p19.Size.Z / 2))
	for _, v31 in pairs(v24:GetDescendants()) do
		if not v31:IsA("BasePart") then
			continue
		end
		local v32 = Instance.new("WeldConstraint")
		v32.Part0 = p19
		v32.Part1 = v31
		v32.Parent = v31
		v31.Anchored = false
	end
end
function v_u_11._Init(p_u_33) -- name: _Init
	-- upvalues: (copy) v_u_1
	v_u_1:GetInstanceAddedSignal("JumpPadHitbox"):Connect(function(p34)
		-- upvalues: (copy) p_u_33
		p_u_33:_ObjectAdded(p34)
	end)
	for _, v35 in pairs(v_u_1:GetTagged("JumpPadHitbox")) do
		task.defer(p_u_33._ObjectAdded, p_u_33, v35)
	end
end
return v_u_11._new()