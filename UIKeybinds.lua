local v_u_1 = game:GetService("CollectionService")
local v_u_2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("UserInputService")
local v_u_4 = game:GetService("Players")
local v_u_5 = require(v_u_2.Modules.SettingsLibrary)
local v_u_6 = require(v_u_2.Modules.InputLibrary)
local v_u_7 = require(v_u_4.LocalPlayer.PlayerScripts.Controllers.PlayerDataController)
local v_u_8 = require(v_u_4.LocalPlayer.PlayerScripts.Controllers.ControlsController)
local v_u_9 = v_u_4.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("KeybindSlot")
local v_u_10 = {}
v_u_10.__index = v_u_10
function v_u_10._new() -- name: _new
	-- upvalues: (copy) v_u_10
	local v11 = v_u_10
	local v12 = setmetatable({}, v11)
	v12._objects = {}
	v12._generate_hashes = {}
	v12:_Init()
	return v12
end
function v_u_10._ObjectRemoved(p13, p14) -- name: _ObjectRemoved
	p13._generate_hashes[p14] = (p13._generate_hashes[p14] or 0) + 1
	if p13._objects[p14] then
		p13._objects[p14].Slot:Destroy()
		p13._objects[p14] = nil
	end
end
function v_u_10._ObjectAdded(p15, p16) -- name: _ObjectAdded
	-- upvalues: (copy) v_u_4, (copy) v_u_2, (copy) v_u_6, (copy) v_u_9
	p15:_ObjectRemoved(p16)
	if p16:IsDescendantOf(v_u_4.LocalPlayer.PlayerGui) or p16:IsDescendantOf(workspace) or (p16:IsDescendantOf(v_u_2) or p16:IsDescendantOf(v_u_4.LocalPlayer.PlayerScripts.Assets.Temp)) then
		local v17 = p15._generate_hashes[p16]
		local v18 = p16:GetAttribute("InputName")
		local v19 = p16:GetAttribute("EnumType")
		local v20 = p16:GetAttribute("EnumName")
		local v21, v22, v23, v24
		if v19 and (v19 ~= "" and (v20 and v20 ~= "")) then
			v21, v22, v23 = v_u_6:GetInputIcons(v19, v20)
			v24 = Enum[v19][v20]
		else
			if not v18 or v18 == "" then
				return
			end
			v21, v22, v23 = v_u_6:GetInputIconsByInputName(v18)
			v24 = v_u_6:FindFirstEnum(v18)
		end
		if v24 then
			if v17 == p15._generate_hashes[p16] then
				local v25 = v_u_9:Clone()
				v25.Icon.Image = v21
				v25.Icon.Title.Text = v23
				v25.Name = v17
				v25.Parent = p16
				p15._objects[p16] = {
					["Enum"] = v24,
					["Icon"] = v21,
					["PressedIcon"] = v22,
					["InputString"] = v23,
					["Slot"] = v25
				}
			end
		else
			return
		end
	else
		return
	end
end
function v_u_10._AddAllObjects(p26) -- name: _AddAllObjects
	-- upvalues: (copy) v_u_1
	for _, v27 in pairs(v_u_1:GetTagged("UIKeybindContainer")) do
		p26:_ObjectAdded(v27)
	end
end
function v_u_10._Init(p_u_28) -- name: _Init
	-- upvalues: (copy) v_u_1, (copy) v_u_3, (copy) v_u_8, (copy) v_u_5, (copy) v_u_7
	v_u_1:GetInstanceRemovedSignal("UIKeybindContainer"):Connect(function(p29)
		-- upvalues: (copy) p_u_28
		p_u_28:_ObjectRemoved(p29)
	end)
	v_u_1:GetInstanceAddedSignal("UIKeybindContainer"):Connect(function(p30)
		-- upvalues: (copy) p_u_28
		p_u_28:_ObjectAdded(p30)
	end)
	v_u_3.InputBegan:Connect(function(p31)
		-- upvalues: (copy) p_u_28
		for _, v32 in pairs(p_u_28._objects) do
			if v32.Enum ~= p31.KeyCode and v32.Enum ~= p31.UserInputType then
				continue
			end
			v32.Slot.Icon.Image = v32.PressedIcon
			v32.Slot.Icon.Title.Position = UDim2.new(0.5, 0, 0.525, 0)
		end
	end)
	v_u_3.InputEnded:Connect(function(p33)
		-- upvalues: (copy) p_u_28
		for _, v34 in pairs(p_u_28._objects) do
			if v34.Enum ~= p33.KeyCode and v34.Enum ~= p33.UserInputType then
				continue
			end
			v34.Slot.Icon.Image = v34.Icon
			v34.Slot.Icon.Title.Position = UDim2.new(0.5, 0, 0.45, 0)
		end
	end)
	v_u_8.ControlsChanged:Connect(function()
		-- upvalues: (copy) p_u_28
		p_u_28:_AddAllObjects()
	end)
	for v35, v36 in pairs(v_u_5.Info) do
		if v36.InputType ~= "Hotkey" then
			continue
		end
		v_u_7:GetSettingChangedSignal(v35):Connect(function()
			-- upvalues: (copy) p_u_28
			p_u_28:_AddAllObjects()
		end)
	end
	task.spawn(p_u_28._AddAllObjects, p_u_28)
end
return v_u_10._new()