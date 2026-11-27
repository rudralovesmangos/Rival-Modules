local v_u_1 = game:GetService("ReplicatedStorage")
local v2 = game:GetService("Players")
local v_u_3 = require(v2.LocalPlayer.PlayerScripts.Modules:WaitForChild("ButtonEffect"))
local v_u_4 = require(v2.LocalPlayer.PlayerScripts.Modules:WaitForChild("Prompt"))
local v_u_5 = setmetatable({}, v_u_4)
v_u_5.__index = v_u_5
function v_u_5.new(p6) -- name: new
	-- upvalues: (copy) v_u_4, (copy) v_u_5
	local v7 = v_u_4.new(script.Name)
	local v8 = v_u_5
	local v9 = setmetatable(v7, v8)
	v9.CloseButton = v9.PromptFrame:WaitForChild("Close")
	v9.ConfirmButton = v9.PromptFrame:WaitForChild("Confirm")
	v9.TitleText = v9.PromptFrame:WaitForChild("Title")
	v9.CasualLBsFrame = v9.PromptFrame:WaitForChild("CasualLBs")
	v9.CasualLBsButton = v9.CasualLBsFrame:WaitForChild("Button")
	v9.CasualLBsButtonEmpty = v9.CasualLBsButton:WaitForChild("Empty")
	v9.CasualLBsButtonFilled = v9.CasualLBsButton:WaitForChild("Filled")
	v9.CompLBsFrame = v9.PromptFrame:WaitForChild("CompLBs")
	v9.CompLBsButton = v9.CompLBsFrame:WaitForChild("Button")
	v9.CompLBsButtonEmpty = v9.CompLBsButton:WaitForChild("Empty")
	v9.CompLBsButtonFilled = v9.CompLBsButton:WaitForChild("Filled")
	v9._ban_data = p6
	v9:_Init()
	return v9
end
function v_u_5.Confirm(p10) -- name: Confirm
	-- upvalues: (copy) v_u_1
	local v11 = {
		["RestrictedFromCasualLeaderboards"] = p10.CasualLBsButtonFilled.Visible,
		["RestrictedFromCompetitiveLeaderboards"] = p10.CompLBsButtonFilled.Visible
	}
	v_u_1.Remotes.Moderator.Restrict:FireServer(p10._ban_data.Name, v11)
	task.defer(p10.CloseRequest, p10)
end
function v_u_5._Setup(p12) -- name: _Setup
	p12.TitleText.Text = "@" .. p12._ban_data.Name
	local v13 = p12.CasualLBsButtonFilled
	local v14 = p12._ban_data.Restrictions
	if v14 then
		v14 = p12._ban_data.Restrictions.RestrictedFromCasualLeaderboards
	end
	v13.Visible = v14
	p12.CasualLBsButtonEmpty.Visible = not p12.CasualLBsButtonFilled.Visible
	local v15 = p12.CompLBsButtonFilled
	local v16 = p12._ban_data.Restrictions
	if v16 then
		v16 = p12._ban_data.Restrictions.RestrictedFromCompetitiveLeaderboards
	end
	v15.Visible = v16
	p12.CompLBsButtonEmpty.Visible = not p12.CompLBsButtonFilled.Visible
end
function v_u_5._Init(p_u_17) -- name: _Init
	-- upvalues: (copy) v_u_3
	p_u_17.CloseButton.MouseButton1Click:Connect(function()
		-- upvalues: (copy) p_u_17
		p_u_17:CloseRequest()
	end)
	p_u_17.ConfirmButton.MouseButton1Click:Connect(function()
		-- upvalues: (copy) p_u_17
		p_u_17:Confirm()
	end)
	p_u_17.CasualLBsButton.MouseButton1Click:Connect(function()
		-- upvalues: (copy) p_u_17
		p_u_17.CasualLBsButtonEmpty.Visible = not p_u_17.CasualLBsButtonEmpty.Visible
		p_u_17.CasualLBsButtonFilled.Visible = not p_u_17.CasualLBsButtonEmpty.Visible
	end)
	p_u_17.CompLBsButton.MouseButton1Click:Connect(function()
		-- upvalues: (copy) p_u_17
		p_u_17.CompLBsButtonEmpty.Visible = not p_u_17.CompLBsButtonEmpty.Visible
		p_u_17.CompLBsButtonFilled.Visible = not p_u_17.CompLBsButtonEmpty.Visible
	end)
	p_u_17:_Setup()
	v_u_3:Add(p_u_17.CloseButton)
	v_u_3:Add(p_u_17.ConfirmButton)
	v_u_3:Add(p_u_17.CasualLBsButton)
	v_u_3:Add(p_u_17.CompLBsButton)
end
return v_u_5