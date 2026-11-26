local v_u_1 = game:GetService("CollectionService")
local v2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("RunService")
local v_u_4 = game:GetService("Players")
local v_u_5 = require(v2.Modules.CONSTANTS)
local v_u_6 = require(v2.Modules.CosmeticLibrary)
local v_u_7 = v_u_5.IS_CLIENT and v_u_5.IS_RUNNING
if v_u_7 then
	v_u_7 = v_u_4.LocalPlayer.PlayerScripts.Assets:WaitForChild("WrapTextures")
end
local v_u_8 = v_u_4.LocalPlayer.PlayerScripts.Modules:WaitForChild("WrapGroupObjects")
local v_u_9 = {}
v_u_9.__index = v_u_9
function v_u_9._new() -- name: _new
	-- upvalues: (copy) v_u_9
	local v10 = v_u_9
	local v11 = setmetatable({}, v10)
	v11._wrap_group_callbacks = {}
	v11._wrap_group_classes = {}
	v11._wrap_group_objects = {}
	v11._wrap_group_objects_count = {}
	v11._preloaded_wrap_group_objects = {}
	v11._preload_screen_gui = Instance.new("ScreenGui")
	v11:_Init()
	return v11
end
function v_u_9.RecordOriginalWrapProperties(_, p12) -- name: RecordOriginalWrapProperties
	local v13 = {}
	local v14
	if typeof(p12) == "table" then
		v14 = p12
	else
		v14 = p12:GetDescendants()
		table.insert(v14, p12)
	end
	for _, v15 in pairs(v14) do
		if not v15:HasTag("Wrappable") then
			continue
		end
		local v16 = nil
		local v17
		if v15:IsA("BasePart") then
			v17 = {
				["Material"] = v15.Material,
				["MaterialVariant"] = v15.MaterialVariant,
				["Color"] = v15.Color,
				["Transparency"] = v15.Transparency,
				["Reflectance"] = v15.Reflectance
			}
			if v15:IsA("MeshPart") then
				v17.TextureID = v15.TextureID
			end
		elseif v15:IsA("Decal") or v15:IsA("Texture") then
			v17 = {
				["Color3"] = v15.Color3,
				["Transparency"] = v15.Transparency
			}
		elseif v15:IsA("Beam") or (v15:IsA("Trail") or v15:IsA("ParticleEmitter")) then
			v17 = {
				["Color"] = v15.Color,
				["Transparency"] = v15.Transparency,
				["LightEmission"] = v15.LightEmission
			}
		elseif v15:IsA("Frame") then
			v17 = {
				["BackgroundColor3"] = v15.BackgroundColor3,
				["BackgroundTransparency"] = v15.BackgroundTransparency
			}
		elseif v15:IsA("ImageLabel") then
			v17 = {
				["ImageColor3"] = v15.ImageColor3,
				["ImageTransparency"] = v15.ImageTransparency
			}
		elseif v15:IsA("Light") then
			v17 = {
				["Color"] = v15.Color,
				["Brightness"] = v15.Brightness
			}
		elseif v15:IsA("RopeConstraint") or v15:IsA("SpringConstraint") then
			v17 = {
				["Color"] = v15.Color
			}
		else
			v17 = v15:IsA("SurfaceAppearance") and {
				["Color"] = v15.Color
			} or v16
		end
		if not v17 then
			continue
		end
		v13[v15] = {
			["WrapGroup"] = v15:GetAttribute("WrapGroup"),
			["IgnoreTransparency"] = v15:GetAttribute("IgnoreTransparency"),
			["IgnoreMaterial"] = v15:GetAttribute("IgnoreMaterial"),
			["IgnoreObject"] = v15:GetAttribute("IgnoreObject"),
			["OriginalProperties"] = v17,
			["OriginalChildren"] = {},
			["Cleanup"] = {}
		}
		for _, v18 in pairs(v15:GetChildren()) do
			if not v18:IsA("SurfaceAppearance") or v15:HasTag("Wrappable") then
				continue
			end
			local v19 = v13[v15].OriginalChildren
			table.insert(v19, v18)
		end
		local v20 = v13[v15].WrapGroup
		if v20 then
			local v21 = v13[v15].WrapGroup
			v20 = typeof(v21) == "number"
		end
		assert(v20, v15:GetFullName())
	end
	return v13
end
function v_u_9.ResetWrap(_, p22) -- name: ResetWrap
	if p22 then
		for v_u_23, v24 in pairs(p22) do
			for v25, v26 in pairs(v24.OriginalProperties) do
				v_u_23[v25] = v26
			end
			for _, v_u_27 in pairs(v24.OriginalChildren) do
				pcall(function()
					-- upvalues: (copy) v_u_27, (copy) v_u_23
					v_u_27.Parent = v_u_23
				end)
			end
			for _, v28 in pairs(v24.Cleanup) do
				v28:Destroy()
			end
			v24.Cleanup = {}
		end
	end
end
function v_u_9.ApplyWrap(p29, p30, p31, p32, p33) -- name: ApplyWrap
	-- upvalues: (copy) v_u_6, (copy) v_u_7
	p29:ResetWrap(p30)
	if p31 and p31.Name ~= "RANDOM_COSMETIC" then
		local v34 = v_u_6.Cosmetics[p31.Name]
		local v35 = p31.Inverted
		for v36, v37 in pairs(p30) do
			if p33 and p33[v36] then
				continue
			end
			local v38
			if v35 then
				v38 = v37.WrapGroup == 1 and 2 or (v37.WrapGroup == 2 and 1 or v37.WrapGroup)
			else
				v38 = v37.WrapGroup
			end
			local v39 = v34.WrapGroups[v38] or {}
			local v40 = p32 or v37.IgnoreTransparency
			local v41 = v37.IgnoreMaterial
			local v42 = v37.IgnoreObject
			local v43 = {}
			if v36:IsA("BasePart") then
				v36.Color = v39.Color or v36.Color
				v36.Transparency = not v40 and v39.Transparency or v36.Transparency
				v36.Reflectance = v39.Reflectance or v36.Reflectance
				v36.Material = (not v41 and (not v40 or v39.Material ~= Enum.Material.ForceField) and true or false) and v39.Material or v36.Material
				v36.MaterialVariant = not v41 and v39.MaterialVariant or v36.MaterialVariant
				if v36:IsA("MeshPart") then
					v36.TextureID = ""
				end
				if not v41 then
					for _, v44 in pairs(v39.Textures and (v_u_7[v39.Textures]:GetChildren() or {}) or {}) do
						local v45 = v44:Clone()
						v45.LocalTransparencyModifier = v36.LocalTransparencyModifier
						v45.Parent = v36
						local v46 = v37.Cleanup
						table.insert(v46, v45)
						table.insert(v43, v45)
					end
				end
			elseif v36:IsA("Decal") or v36:IsA("Texture") then
				v36.Color3 = v39.Color or v36.Color3
				v36.Transparency = not v40 and v39.Transparency or v36.Transparency
			elseif v36:IsA("Beam") or (v36:IsA("Trail") or v36:IsA("ParticleEmitter")) then
				v36.Color = v39.Color and ColorSequence.new(v39.Color) or v36.Color
			elseif v36:IsA("Frame") then
				v36.BackgroundColor3 = v39.Color or v36.BackgroundColor3
				v36.BackgroundTransparency = not v40 and v39.Transparency or v36.BackgroundTransparency
			elseif v36:IsA("ImageLabel") then
				v36.ImageColor3 = v39.Color or v36.ImageColor3
				v36.ImageTransparency = not v40 and v39.Transparency or v36.ImageTransparency
			elseif v36:IsA("Light") then
				v36.Color = v39.Color or v36.Color
				v36.Brightness = v36.Brightness + (0 - v36.Brightness) * (v40 and 0 or (v39.Transparency or 0))
			elseif v36:IsA("RopeConstraint") or v36:IsA("SpringConstraint") then
				v36.Color = v39.Color and BrickColor.new(v39.Color) or v36.Color
			elseif v36:IsA("SurfaceAppearance") then
				v36.Color = v39.Color or v36.Color
			end
			for _, v_u_47 in pairs(v37.OriginalChildren) do
				pcall(function()
					-- upvalues: (copy) v_u_47
					v_u_47.Parent = nil
				end)
			end
			if v42 then
				break
			end
			local v48 = p29:_GetWrapGroupObject(v39)
			if not v48 then
				break
			end
			local v49 = v48.new(v39.ObjectName, v36, v43)
			local v50 = p29._wrap_group_objects
			table.insert(v50, v49)
			local v51 = v37.Cleanup
			table.insert(v51, v49)
			p29:_IncrementWrapGroupObjectsCount(v49.Name, 1, v49)
		end
	end
end
function v_u_9.Update(p52, p53) -- name: Update
	-- upvalues: (copy) v_u_5
	for v54 = #p52._wrap_group_objects, 1, -1 do
		local v55 = p52._wrap_group_objects[v54]
		if v55.IsDestroyed then
			table.remove(p52._wrap_group_objects, v54)
			p52:_IncrementWrapGroupObjectsCount(v55.Name, -1, v55)
		else
			if not (v55.Update and v55:IsActive()) then
				continue
			end
			if v_u_5.IS_STUDIO then
				v55:Update(p53)
			else
				local v56 = v55.Update
				pcall(v56, v55, p53)
			end
		end
	end
end
function v_u_9._IncrementWrapGroupObjectsCount(p57, p58, p59, p60) -- name: _IncrementWrapGroupObjectsCount
	local v61 = (p57._wrap_group_objects_count[p58] or 0) + p59
	local v62 = p57._wrap_group_objects_count
	local v63
	if v61 <= 0 then
		v63 = nil
	else
		v63 = v61
	end
	v62[p58] = v63
	if v61 == 1 then
		local v64 = p60.GetPreloadedImageIDs
		if v64 then
			v64 = p60:GetPreloadedImageIDs()
		end
		if v64 and #v64 ~= 0 then
			p57._preloaded_wrap_group_objects[p58] = p57._preloaded_wrap_group_objects[p58] or {}
			p57._preloaded_wrap_group_objects[p58].Textures = p57._preloaded_wrap_group_objects[p58].Textures or {}
			for v65, v66 in pairs(v64) do
				local v67 = Instance.new("ImageLabel")
				v67.BackgroundTransparency = 1
				v67.Active = false
				v67.Size = UDim2.new(0, 1, 0, 1)
				v67.ImageTransparency = 0.99
				v67.Image = v66
				v67.Name = p58 .. " - " .. v65
				v67.Parent = p57._preload_screen_gui
				local v68 = p57._preloaded_wrap_group_objects[p58].Textures
				table.insert(v68, v67)
			end
		end
	else
		if not v61 then
			for _, v69 in pairs(p57._preloaded_wrap_group_objects[p58] and (p57._preloaded_wrap_group_objects[p58].Textures or {}) or {}) do
				task.defer(v69.Destroy, v69)
			end
			p57._preloaded_wrap_group_objects[p58] = nil
		end
		return
	end
end
function v_u_9._GetWrapGroupObject(p70, p71) -- name: _GetWrapGroupObject
	-- upvalues: (copy) v_u_8
	if p71.ObjectName then
		if not p70._wrap_group_classes[p71.ObjectName] then
			p70._wrap_group_classes[p71.ObjectName] = require(v_u_8:WaitForChild(p71.ObjectName))
		end
		return p70._wrap_group_classes[p71.ObjectName]
	end
end
function v_u_9._WrapThis(p72, p73) -- name: _WrapThis
	p72:ApplyWrap(p72:RecordOriginalWrapProperties(p73), {
		["Name"] = p73:GetAttribute("WrapName")
	})
end
function v_u_9._Setup(p74) -- name: _Setup
	-- upvalues: (copy) v_u_4
	p74._preload_screen_gui.Name = "PreloadedWrapTextures"
	p74._preload_screen_gui.ResetOnSpawn = false
	p74._preload_screen_gui.Parent = v_u_4.LocalPlayer.PlayerGui
end
function v_u_9._Init(p_u_75) -- name: _Init
	-- upvalues: (copy) v_u_3, (copy) v_u_1
	v_u_3:BindToRenderStep("WrapController", Enum.RenderPriority.Camera.Value + 1, function(p76)
		-- upvalues: (copy) p_u_75
		p_u_75:Update(p76)
	end)
	v_u_1:GetInstanceAddedSignal("WrapThis"):Connect(function(p77)
		-- upvalues: (copy) p_u_75
		p_u_75:_WrapThis(p77)
	end)
	for _, v78 in pairs(v_u_1:GetTagged("WrapThis")) do
		task.defer(p_u_75._WrapThis, p_u_75, v78)
	end
	p_u_75:_Setup()
end
return v_u_9._new()