local v_u_1 = game:GetService("ReplicatedStorage")
game:GetService("RunService")
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
	v9._ban_data = p6
	v9:_Init()
	return v9
end
function v_u_5.Confirm(p10) -- name: Confirm
	-- upvalues: (copy) v_u_1
	local v11 = v_u_1.Remotes.Moderator.PardonRedFlags.InvokeServer
	local v12 = v_u_1.Remotes.Moderator.PardonRedFlags
	local v13 = p10._ban_data.Name
	local v14, v15 = pcall(v11, v12, v13)
	local v16 = ""
	for v17, v18 in pairs(v14 and v15 and v15 or {}) do
		v16 = v16 .. v18 .. (v17 < #v15 and "\n" or "")
	end
	p10.OpenPrompt:Fire("ErrorMessage", v14 and v16 ~= "" and "Success!" or "Whoops!", v14 and v16 ~= "" and "Successfully pardoned this player\'s red flags:\n" .. v16 or (v14 and v16 == "" and "This player has no red flags!" or "Failed to pardon this player\'s red flags, please try again!"))
end
function v_u_5._Setup(p19) -- name: _Setup
	p19.TitleText.Text = "Pardon " .. p19._ban_data.Name
end
function v_u_5._Init(p_u_20) -- name: _Init
	-- upvalues: (copy) v_u_3
	p_u_20.CloseButton.MouseButton1Click:Connect(function()
		-- upvalues: (copy) p_u_20
		p_u_20:CloseRequest()
	end)
	p_u_20.ConfirmButton.MouseButton1Click:Connect(function()
		-- upvalues: (copy) p_u_20
		p_u_20:Confirm()
	end)
	p_u_20:_Setup()
	v_u_3:Add(p_u_20.CloseButton)
	v_u_3:Add(p_u_20.ConfirmButton)
end
return v_u_5