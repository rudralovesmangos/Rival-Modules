local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("Players")
local v_u_3 = require(v1.Modules.CONSTANTS)
require(v1.Modules.ModerationLibrary)
local v_u_4 = require(v_u_2.LocalPlayer.PlayerScripts.Modules:WaitForChild("ButtonEffect"))
local v_u_5 = require(v_u_2.LocalPlayer.PlayerScripts.Modules:WaitForChild("Prompt"))
local v_u_6 = v_u_2.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("ActionLogSlot")
local v_u_7 = setmetatable({}, v_u_5)
v_u_7.__index = v_u_7
function v_u_7.new(p8) -- name: new
	-- upvalues: (copy) v_u_5, (copy) v_u_7
	local v9 = v_u_5.new(script.Name)
	local v10 = v_u_7
	local v11 = setmetatable(v9, v10)
	v11.CloseButton = v11.PromptFrame:WaitForChild("Close")
	v11.EmptyText = v11.PromptFrame:WaitForChild("Empty")
	v11.List = v11.PromptFrame:WaitForChild("List")
	v11.Container = v11.List:WaitForChild("Container")
	v11.Layout = v11.Container:WaitForChild("Layout")
	v11._ban_data = p8
	v11:_Init()
	return v11
end
function v_u_7._Setup(p12) -- name: _Setup
	-- upvalues: (copy) v_u_6, (copy) v_u_3, (copy) v_u_2
	local v13 = p12._ban_data.ActionHistory or {}
	p12.EmptyText.Visible = #v13 == 0
	p12.List.Visible = not p12.EmptyText.Visible
	for _, v_u_14 in pairs(v13) do
		local v_u_15 = v_u_6:Clone()
		local v16 = v_u_15.Picture
		local v17 = string.format
		local v18 = v_u_3.HEADSHOT_IMAGE
		local v19 = v_u_14.TargetUserID
		v16.Image = v17(v18, (tostring(v19)))
		v_u_15.Date.Text = os.date("%x", v_u_14.Timestamp) .. " " .. os.date("%X", v_u_14.Timestamp)
		v_u_15.Target.Text = "\226\128\162 \226\128\162 \226\128\162"
		v_u_15.Action.Text = v_u_14.Action
		v_u_15.Parent = p12.Container
		task.spawn(function()
			-- upvalues: (copy) v_u_15, (ref) v_u_2, (copy) v_u_14
			local v20 = v_u_15.Target
			local v21 = v_u_2.GetNameFromUserIdAsync
			local v22 = v_u_2
			local v23 = v_u_14.TargetUserID
			local v24, v25 = pcall(v21, v22, v23)
			if v24 then
				v20.Text = v25
			end
		end)
	end
end
function v_u_7._Init(p_u_26) -- name: _Init
	-- upvalues: (copy) v_u_4
	p_u_26.CloseButton.MouseButton1Click:Connect(function()
		-- upvalues: (copy) p_u_26
		p_u_26:CloseRequest()
	end)
	p_u_26.Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		-- upvalues: (copy) p_u_26
		p_u_26.List.CanvasSize = UDim2.new(0, 0, 0, p_u_26.Layout.AbsoluteContentSize.Y)
	end)
	p_u_26:_Setup()
	v_u_4:Add(p_u_26.CloseButton)
end
return v_u_7