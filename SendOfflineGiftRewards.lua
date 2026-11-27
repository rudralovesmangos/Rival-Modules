local v_u_1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("HttpService")
local v3 = game:GetService("Players")
local v_u_4 = require(v_u_1.Modules.Utility)
local v_u_5 = require(v3.LocalPlayer.PlayerScripts.Modules:WaitForChild("ButtonEffect"))
local v_u_6 = require(v3.LocalPlayer.PlayerScripts.Modules:WaitForChild("Prompt"))
local v_u_7 = setmetatable({}, v_u_6)
v_u_7.__index = v_u_7
function v_u_7.new() -- name: new
	-- upvalues: (copy) v_u_6, (copy) v_u_7
	local v8 = v_u_6.new(script.Name)
	local v9 = v_u_7
	local v10 = setmetatable(v8, v9)
	v10.CloseButton = v10.PromptFrame:WaitForChild("Close")
	v10.ConfirmButton = v10.PromptFrame:WaitForChild("Confirm")
	v10.List = v10.PromptFrame:WaitForChild("List")
	v10.Container = v10.List:WaitForChild("Container")
	v10.Layout = v10.Container:WaitForChild("Layout")
	v10.RecipientValueBox = v10.Container:WaitForChild("RecipientValue"):WaitForChild("Input"):WaitForChild("Box")
	v10.RecipientAddFrame = v10.Container:WaitForChild("RewardAdd")
	v10.RecipientAddInputFrame = v10.RecipientAddFrame:WaitForChild("Input")
	v10.RecipientAddInputAddButton = v10.RecipientAddInputFrame:WaitForChild("Add")
	v10.RecipientAddInputAddNetButton = v10.RecipientAddInputFrame:WaitForChild("AddNet")
	v10.RecipientAddInputAddBugNetButton = v10.RecipientAddInputFrame:WaitForChild("AddBugNet")
	v10._reward_value_template = v10.Container:WaitForChild("RewardValue")
	v10._reward_value_frames = {}
	v10:_Init()
	return v10
end
function v_u_7.Confirm(p11) -- name: Confirm
	-- upvalues: (copy) v_u_4, (copy) v_u_2, (copy) v_u_1
	if #p11._reward_value_frames == 0 then
		v_u_4:CreateSound("rbxassetid://17153811469", 2, 1, script, true, 5)
		return
	else
		local v12 = p11.RecipientValueBox.Text
		if v12 == "" then
			v_u_4:CreateSound("rbxassetid://17153811469", 2, 1, script, true, 5)
			return
		else
			local v13 = {}
			for _, v14 in pairs(p11._reward_value_frames) do
				local v15 = v14.Input.Box.Text
				if v15 == "" then
					continue
				end
				if not p11:_IsValidJSON(v15) then
					v_u_4:CreateSound("rbxassetid://17153811469", 2, 1, script, true, 5)
					return
				end
				local v16 = v_u_2
				table.insert(v13, v16:JSONDecode(v15))
			end
			local v17 = v_u_2.JSONEncode
			local v18 = v_u_2
			local v19, v20 = pcall(v17, v18, v13)
			if v19 then
				local v21 = v_u_1.Remotes.Debug.Command.InvokeServer
				local v22 = v_u_1.Remotes.Debug.Command
				local v23, v24 = pcall(v21, v22, "SendOfflineGiftRewards", { v12, v20 })
				if v23 and v24 then
					p11:CloseRequest()
				else
					warn("Failed to send rewards:", v24)
					v_u_4:CreateSound("rbxassetid://17153811469", 2, 1, script, true, 5)
				end
			else
				warn("Failed to encode reward_datas:", v20)
				v_u_4:CreateSound("rbxassetid://17153811469", 2, 1, script, true, 5)
				return
			end
		end
	end
end
function v_u_7._IsValidJSON(_, p25) -- name: _IsValidJSON
	-- upvalues: (copy) v_u_2
	local v26 = v_u_2.JSONDecode
	local v27 = v_u_2
	return pcall(v26, v27, p25)
end
function v_u_7._AddRewardValueFrame(p_u_28, p29) -- name: _AddRewardValueFrame
	-- upvalues: (copy) v_u_2, (copy) v_u_5
	local v_u_30 = p_u_28._reward_value_template:Clone()
	v_u_30.LayoutOrder = p_u_28._reward_value_template.LayoutOrder + #p_u_28._reward_value_frames
	v_u_30.Input.Box.Text = not p29 and "" or v_u_2:JSONEncode(p29)
	v_u_30.Parent = p_u_28.Container
	local v31 = p_u_28._reward_value_frames
	table.insert(v31, v_u_30)
	v_u_30.Input.Close.MouseButton1Click:Connect(function()
		-- upvalues: (copy) v_u_30, (copy) p_u_28
		v_u_30:Destroy()
		local v32 = table.find(p_u_28._reward_value_frames, v_u_30)
		if v32 then
			table.remove(p_u_28._reward_value_frames, v32)
		end
	end)
	v_u_30.Input.Box:GetPropertyChangedSignal("Text"):Connect(function()
		-- upvalues: (copy) v_u_30, (copy) p_u_28
		local v33 = v_u_30.Input.Background
		local v34
		if v_u_30.Input.Box.Text == "" or p_u_28:_IsValidJSON(v_u_30.Input.Box.Text) then
			v34 = Color3.fromRGB(255, 255, 255)
		else
			v34 = Color3.fromRGB(255, 50, 50)
		end
		v33.ImageColor3 = v34
	end)
	v_u_5:Add(v_u_30.Input.Close)
end
function v_u_7._Setup(p35) -- name: _Setup
	p35._reward_value_template.Parent = nil
end
function v_u_7._Init(p_u_36) -- name: _Init
	-- upvalues: (copy) v_u_5
	p_u_36.CloseButton.MouseButton1Click:Connect(function()
		-- upvalues: (copy) p_u_36
		p_u_36:CloseRequest()
	end)
	p_u_36.ConfirmButton.MouseButton1Click:Connect(function()
		-- upvalues: (copy) p_u_36
		p_u_36:Confirm()
	end)
	p_u_36.Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		-- upvalues: (copy) p_u_36
		p_u_36.List.CanvasSize = UDim2.new(0, 0, 0, p_u_36.Layout.AbsoluteContentSize.Y)
	end)
	p_u_36.RecipientAddInputAddButton.MouseButton1Click:Connect(function()
		-- upvalues: (copy) p_u_36
		p_u_36:_AddRewardValueFrame(nil)
	end)
	p_u_36.RecipientAddInputAddNetButton.MouseButton1Click:Connect(function()
		-- upvalues: (copy) p_u_36
		p_u_36:_AddRewardValueFrame({
			["Name"] = "Net",
			["Quantity"] = 1,
			["Weapon"] = "IsRandom"
		})
	end)
	p_u_36.RecipientAddInputAddBugNetButton.MouseButton1Click:Connect(function()
		-- upvalues: (copy) p_u_36
		p_u_36:_AddRewardValueFrame({
			["Name"] = "Bug Net",
			["Quantity"] = 1,
			["Weapon"] = "Scythe"
		})
	end)
	p_u_36:_Setup()
	v_u_5:Add(p_u_36.CloseButton)
	v_u_5:Add(p_u_36.ConfirmButton)
	v_u_5:Add(p_u_36.RecipientAddInputAddButton)
	v_u_5:Add(p_u_36.RecipientAddInputAddNetButton)
	v_u_5:Add(p_u_36.RecipientAddInputAddBugNetButton)
end
return v_u_7