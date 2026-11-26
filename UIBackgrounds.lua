local v_u_1 = game:GetService("CollectionService")
local v_u_2 = game:GetService("GuiService")
local v3 = game:GetService("Players")
local v_u_4 = require(v3.LocalPlayer.PlayerScripts.Modules.UILibrary)
local v_u_5 = {}
v_u_5.__index = v_u_5
function v_u_5._new() -- name: _new
	-- upvalues: (copy) v_u_5
	local v6 = v_u_5
	local v7 = setmetatable({}, v6)
	v7:_Init()
	return v7
end
function v_u_5._UpdateCoreGuiBackground(_, p8) -- name: _UpdateCoreGuiBackground
	-- upvalues: (copy) v_u_4
	if p8:IsA("Frame") then
		p8.BackgroundColor3 = v_u_4.BUTTON_BACKGROUND_COLOR
		p8.BackgroundTransparency = v_u_4.BUTTON_BACKGROUND_TRANSPARENCY
		return
	elseif p8:IsA("ImageLabel") then
		p8.ImageColor3 = v_u_4.BUTTON_BACKGROUND_COLOR
		p8.ImageTransparency = v_u_4.BUTTON_BACKGROUND_TRANSPARENCY
	elseif p8:IsA("UIStroke") then
		p8.Color = v_u_4.BUTTON_BACKGROUND_COLOR
		p8.Transparency = v_u_4.BUTTON_BACKGROUND_TRANSPARENCY
	end
end
function v_u_5._UpdateElementSimple(_, p9) -- name: _UpdateElementSimple
	-- upvalues: (copy) v_u_2
	local v10 = v_u_2.PreferredTransparency
	local v11 = p9:GetAttribute("BaseTransparency") or 1
	p9[p9:IsA("Frame") and "BackgroundTransparency" or "ImageTransparency"] = 0 + (v11 - 0) * v10
	local v12 = p9:GetAttribute("TransparentColor")
	local v13 = p9:GetAttribute("OpaqueColor")
	if v12 and v13 then
		p9[p9:IsA("Frame") and "BackgroundColor3" or "ImageColor3"] = v13:Lerp(v12, v10)
	end
end
function v_u_5._UpdateElement(_, p14) -- name: _UpdateElement
	-- upvalues: (copy) v_u_2
	local v15 = p14:WaitForChild("UIGradient")
	local v16 = v_u_2.PreferredTransparency
	p14.ImageTransparency = 0 + 0.25 * v16
	p14.ImageColor3 = Color3.fromRGB(31, 31, 31):Lerp(Color3.fromRGB(0, 0, 0), v16)
	v15.Transparency = NumberSequence.new(0, 0 + 0.5 * v16)
	v15.Color = ColorSequence.new(Color3.fromRGB(127, 127, 127):Lerp(Color3.fromRGB(255, 255, 255), v16), Color3.fromRGB(255, 255, 255))
end
function v_u_5._UpdateAllElements(p17) -- name: _UpdateAllElements
	-- upvalues: (copy) v_u_1
	for _, v18 in pairs(v_u_1:GetTagged("UIBackground")) do
		p17:_UpdateElement(v18)
	end
	for _, v19 in pairs(v_u_1:GetTagged("UIBackgroundSimple")) do
		p17:_UpdateElementSimple(v19)
	end
end
function v_u_5._Init(p_u_20) -- name: _Init
	-- upvalues: (copy) v_u_1, (copy) v_u_2
	v_u_1:GetInstanceAddedSignal("UIBackground"):Connect(function(p21)
		-- upvalues: (copy) p_u_20
		p_u_20:_UpdateElement(p21)
	end)
	v_u_1:GetInstanceAddedSignal("UIBackgroundSimple"):Connect(function(p22)
		-- upvalues: (copy) p_u_20
		p_u_20:_UpdateElementSimple(p22)
	end)
	v_u_1:GetInstanceAddedSignal("CoreGuiBackground"):Connect(function(p23)
		-- upvalues: (copy) p_u_20
		p_u_20:_UpdateCoreGuiBackground(p23)
	end)
	v_u_2:GetPropertyChangedSignal("PreferredTransparency"):Connect(function()
		-- upvalues: (copy) p_u_20
		p_u_20:_UpdateAllElements()
	end)
	for _, v24 in pairs(v_u_1:GetTagged("CoreGuiBackground")) do
		p_u_20:_UpdateCoreGuiBackground(v24)
	end
	task.defer(p_u_20._UpdateAllElements, p_u_20)
end
return v_u_5._new()