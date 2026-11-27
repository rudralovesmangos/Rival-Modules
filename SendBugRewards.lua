local v_u_1 = game:GetService("ReplicatedStorage")
local v2 = game:GetService("Players")
local v_u_3 = require(v_u_1.Modules.ServerOsTime)
local v_u_4 = require(v_u_1.Modules.DebugLibrary)
local v_u_5 = require(v_u_1.Modules.Utility)
local v_u_6 = require(v2.LocalPlayer.PlayerScripts.Controllers:WaitForChild("PlayerDataController"))
local v_u_7 = require(v2.LocalPlayer.PlayerScripts.Modules:WaitForChild("ButtonEffect"))
local v_u_8 = require(v2.LocalPlayer.PlayerScripts.Modules:WaitForChild("RewardSlot"))
local v_u_9 = require(v2.LocalPlayer.PlayerScripts.Modules:WaitForChild("Prompt"))
local v_u_10 = setmetatable({}, v_u_9)
v_u_10.__index = v_u_10
function v_u_10.new() -- name: new
	-- upvalues: (copy) v_u_9, (copy) v_u_10
	local v11 = v_u_9.new(script.Name)
	local v12 = v_u_10
	local v13 = setmetatable(v11, v12)
	v13.CloseButton = v13.PromptFrame:WaitForChild("Close")
	v13.ConfirmButton = v13.PromptFrame:WaitForChild("Confirm")
	v13.BudgetText = v13.PromptFrame:WaitForChild("Budget")
	v13.BudgetTimerText = v13.PromptFrame:WaitForChild("BudgetTimer")
	v13.HeaderFrame = v13.PromptFrame:WaitForChild("Header")
	v13.HeaderWrapFrame = v13.HeaderFrame:WaitForChild("Wrap")
	v13.HeaderSkinFrame = v13.HeaderFrame:WaitForChild("Skin")
	v13.List = v13.PromptFrame:WaitForChild("List")
	v13.Container = v13.List:WaitForChild("Container")
	v13.Layout = v13.Container:WaitForChild("Layout")
	v13.RecipientAddButton = v13.Container:WaitForChild("RewardAdd"):WaitForChild("Add")
	v13._reward_value_template = v13.Container:WaitForChild("BugRewardRecepientSlot")
	v13._reward_value_frames = {}
	v13:_Init()
	return v13
end
function v_u_10.Confirm(p14) -- name: Confirm
	-- upvalues: (copy) v_u_5, (copy) v_u_1
	if #p14._reward_value_frames == 0 then
		v_u_5:CreateSound("rbxassetid://17153811469", 2, 1, script, true, 5)
		return
	else
		local v15 = v_u_1.Remotes.Debug.Command.InvokeServer
		local v16 = v_u_1.Remotes.Debug.Command
		local v17, v18 = pcall(v15, v16, "SendBugRewards", p14:_GetBatch(true))
		if v17 and v18 then
			p14:CloseRequest()
		else
			warn("Failed to send rewards:", v18)
			v_u_5:CreateSound("rbxassetid://17153811469", 2, 1, script, true, 5)
		end
	end
end
function v_u_10._GetBatch(p19, p20) -- name: _GetBatch
	-- upvalues: (copy) v_u_5
	local v21 = {}
	for _, v22 in pairs(p19._reward_value_frames) do
		local v23 = v22.Player.Box.Text
		if v23 == "" and p20 then
			v_u_5:CreateSound("rbxassetid://17153811469", 2, 1, script, true, 5)
			return
		end
		local v24 = v22.Wraps.Box.Text
		local v25 = tonumber(v24) or 0
		local v26 = v22.Skins.Box.Text
		local v27 = { v23, v25, tonumber(v26) or 0 }
		table.insert(v21, v27)
	end
	return v21
end
function v_u_10._UpdateBudgetText(p28) -- name: _UpdateBudgetText
	-- upvalues: (copy) v_u_6, (copy) v_u_3, (copy) v_u_4, (copy) v_u_5
	local v29 = 0
	local v30 = 0
	for _, v31 in pairs(p28:_GetBatch()) do
		v29 = v29 + v31[2]
		v30 = v30 + v31[3]
	end
	local v32 = v_u_6:Get("SendBugRewardsCooldown")
	if v32 then
		v32 = v_u_3:Get() < v_u_6:Get("SendBugRewardsCooldown")
	end
	local v33 = p28.BudgetText
	local v34 = string.format
	local v35 = "\195\151%s Net Wraps   \195\151%s Bug Net Skins"
	local v36
	if v32 then
		v36 = 0
	else
		local v37 = v_u_4.MAX_NET_WRAPS_PER_CYCLE - v29
		v36 = math.max(0, v37)
	end
	local v38
	if v32 then
		v38 = 0
	else
		local v39 = v_u_4.MAX_BUG_NET_SKINS_PER_CYCLE - v30
		v38 = math.max(0, v39)
	end
	v33.Text = v34(v35, v36, v38)
	local v40 = p28.BudgetText
	local v41
	if v32 or (v_u_4.MAX_NET_WRAPS_PER_CYCLE < v29 or v_u_4.MAX_BUG_NET_SKINS_PER_CYCLE < v30) then
		v41 = Color3.fromRGB(255, 50, 50)
	else
		v41 = Color3.fromRGB(255, 255, 255)
	end
	v40.TextColor3 = v41
	local v42 = p28.BudgetTimerText
	local v43
	if v32 then
		local v44 = string.format
		local v45 = v_u_5
		local v46 = v_u_6:Get("SendBugRewardsCooldown") - v_u_3:Get()
		v43 = v44("Budget refreshes in %s", v45:TimeFormat2((math.ceil(v46))))
	else
		v43 = "Bug rewards ready to be handed out!"
	end
	v42.Text = v43
end
function v_u_10._UpdateBudgetTextLoop(p47) -- name: _UpdateBudgetTextLoop
	while not p47._destroyed do
		p47:_UpdateBudgetText()
		wait(1)
	end
end
function v_u_10._AddRewardValueFrame(p_u_48) -- name: _AddRewardValueFrame
	-- upvalues: (copy) v_u_7, (copy) v_u_4
	local v_u_49 = p_u_48._reward_value_template:Clone()
	v_u_49.Wraps.Box.Text = "1"
	v_u_49.LayoutOrder = p_u_48._reward_value_template.LayoutOrder + #p_u_48._reward_value_frames
	v_u_49.Close.Visible = #p_u_48._reward_value_frames > 0
	v_u_49.Parent = p_u_48.Container
	local v50 = p_u_48._reward_value_frames
	table.insert(v50, v_u_49)
	v_u_7:Add(v_u_49.Close)
	v_u_49.Close.MouseButton1Click:Connect(function()
		-- upvalues: (copy) v_u_49, (copy) p_u_48
		v_u_49:Destroy()
		local v51 = table.find(p_u_48._reward_value_frames, v_u_49)
		if v51 then
			table.remove(p_u_48._reward_value_frames, v51)
			p_u_48:_UpdateBudgetText()
		end
	end)
	local function v64() -- name: update
		-- upvalues: (copy) v_u_49, (ref) v_u_4, (copy) p_u_48
		local v52 = v_u_49.Wraps.Box
		local v53
		if v_u_49.Wraps.Box.Text == "" then
			v53 = ""
		else
			local v54 = v_u_49.Wraps.Box.Text
			local v55 = tonumber(v54) or 0
			local v56 = math.floor(v55)
			local v57 = v_u_4.MAX_NET_WRAPS_PER_PLAYER
			v53 = math.clamp(v56, 0, v57)
		end
		v52.Text = v53
		local v58 = v_u_49.Skins.Box
		local v59
		if v_u_49.Skins.Box.Text == "" then
			v59 = ""
		else
			local v60 = v_u_49.Skins.Box.Text
			local v61 = tonumber(v60) or 0
			local v62 = math.floor(v61)
			local v63 = v_u_4.MAX_BUG_NET_SKINS_PER_PLAYER
			v59 = math.clamp(v62, 0, v63)
		end
		v58.Text = v59
		p_u_48:_UpdateBudgetText()
	end
	v_u_49.Wraps.Box:GetPropertyChangedSignal("Text"):Connect(v64)
	v_u_49.Skins.Box:GetPropertyChangedSignal("Text"):Connect(v64)
	v64()
	p_u_48:_UpdateBudgetText()
end
function v_u_10._Setup(p65) -- name: _Setup
	-- upvalues: (copy) v_u_8
	v_u_8.new({
		["Name"] = "Net",
		["Quantity"] = 1,
		["Weapon"] = "IsRandom"
	}):SetParent(p65.HeaderWrapFrame)
	v_u_8.new({
		["Name"] = "Bug Net",
		["Quantity"] = 1,
		["Weapon"] = "Scythe"
	}):SetParent(p65.HeaderSkinFrame)
	p65._reward_value_template.Parent = nil
end
function v_u_10._Init(p_u_66) -- name: _Init
	-- upvalues: (copy) v_u_7
	p_u_66.CloseButton.MouseButton1Click:Connect(function()
		-- upvalues: (copy) p_u_66
		p_u_66:CloseRequest()
	end)
	p_u_66.ConfirmButton.MouseButton1Click:Connect(function()
		-- upvalues: (copy) p_u_66
		p_u_66:Confirm()
	end)
	p_u_66.Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		-- upvalues: (copy) p_u_66
		p_u_66.List.CanvasSize = UDim2.new(0, 0, 0, p_u_66.Layout.AbsoluteContentSize.Y)
	end)
	p_u_66.RecipientAddButton.MouseButton1Click:Connect(function()
		-- upvalues: (copy) p_u_66
		p_u_66:_AddRewardValueFrame(nil)
	end)
	p_u_66:_Setup()
	p_u_66:_UpdateBudgetText()
	p_u_66:_AddRewardValueFrame()
	task.spawn(p_u_66._UpdateBudgetTextLoop, p_u_66)
	v_u_7:Add(p_u_66.CloseButton)
	v_u_7:Add(p_u_66.ConfirmButton)
	v_u_7:Add(p_u_66.RecipientAddButton)
end
return v_u_10