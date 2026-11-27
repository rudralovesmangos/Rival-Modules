local v_u_1 = game:GetService("HttpService")
local v2 = game:GetService("Players")
local v_u_3 = require(v2.LocalPlayer.PlayerScripts.Modules:WaitForChild("ButtonEffect"))
local v_u_4 = require(v2.LocalPlayer.PlayerScripts.Modules:WaitForChild("RewardSlot"))
local v_u_5 = require(v2.LocalPlayer.PlayerScripts.Modules:WaitForChild("Prompt"))
local v_u_6 = setmetatable({}, v_u_5)
v_u_6.__index = v_u_6
function v_u_6.new() -- name: new
	-- upvalues: (copy) v_u_5, (copy) v_u_6
	local v7 = v_u_5.new(script.Name)
	local v8 = v_u_6
	local v9 = setmetatable(v7, v8)
	v9.CloseButton = v9.PromptFrame:WaitForChild("Close")
	v9.Container = v9.PromptFrame:WaitForChild("Container")
	v9.TextFrame = v9.PromptFrame:WaitForChild("TextFrame")
	v9.TextFrameBox = v9.TextFrame:WaitForChild("Box")
	v9.TextFrameBackground = v9.TextFrame:WaitForChild("Background")
	v9._reward_slot = nil
	v9:_Init()
	return v9
end
function v_u_6._Update(p_u_10) -- name: _Update
	-- upvalues: (copy) v_u_1, (copy) v_u_4
	if p_u_10._reward_slot then
		p_u_10._reward_slot:Destroy()
		p_u_10._reward_slot = nil
	end
	local v11 = v_u_1.JSONDecode
	local v12 = v_u_1
	local v13 = p_u_10.TextFrameBox.Text
	local v14, v_u_15 = pcall(v11, v12, v13)
	if v14 then
		local function v17()
			-- upvalues: (ref) v_u_4, (copy) v_u_15, (copy) p_u_10
			local v16 = v_u_4.new(v_u_15)
			v16:UseHighResolutionImage()
			v16:SetInteractable(false)
			v16:SetParent(p_u_10.Container)
			return v16
		end
		local v18, v19 = pcall(v17)
		if v18 then
			p_u_10._reward_slot = v19
		end
	end
	local v20 = p_u_10.TextFrameBackground
	local v21
	if p_u_10.TextFrameBox.Text == "" or p_u_10._reward_slot then
		v21 = Color3.fromRGB(255, 255, 255)
	else
		v21 = Color3.fromRGB(255, 50, 50)
	end
	v20.ImageColor3 = v21
end
function v_u_6._Init(p_u_22) -- name: _Init
	-- upvalues: (copy) v_u_3
	p_u_22.CloseButton.MouseButton1Click:Connect(function()
		-- upvalues: (copy) p_u_22
		p_u_22:CloseRequest()
	end)
	p_u_22.TextFrameBox:GetPropertyChangedSignal("Text"):Connect(function()
		-- upvalues: (copy) p_u_22
		p_u_22:_Update()
	end)
	p_u_22:_Update()
	v_u_3:Add(p_u_22.CloseButton)
end
return v_u_6