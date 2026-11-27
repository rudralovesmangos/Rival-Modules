local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("Players")
local v_u_3 = require(v1.Modules.CONSTANTS)
local v_u_4 = require(v1.Modules.BanLibrary)
local v_u_5 = require(v_u_2.LocalPlayer.PlayerScripts.Modules:WaitForChild("ButtonEffect"))
local v_u_6 = require(v_u_2.LocalPlayer.PlayerScripts.Modules:WaitForChild("Prompt"))
local v_u_7 = v_u_2.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("BanLogSlot")
local v_u_8 = setmetatable({}, v_u_6)
v_u_8.__index = v_u_8
function v_u_8.new(p9) -- name: new
	-- upvalues: (copy) v_u_6, (copy) v_u_8
	local v10 = v_u_6.new(script.Name)
	local v11 = v_u_8
	local v12 = setmetatable(v10, v11)
	v12.CloseButton = v12.PromptFrame:WaitForChild("Close")
	v12.EmptyText = v12.PromptFrame:WaitForChild("Empty")
	v12.List = v12.PromptFrame:WaitForChild("List")
	v12.Container = v12.List:WaitForChild("Container")
	v12.Layout = v12.Container:WaitForChild("Layout")
	v12._ban_data = p9
	v12:_Init()
	return v12
end
function v_u_8._Setup(p13) -- name: _Setup
	-- upvalues: (copy) v_u_7, (copy) v_u_3, (copy) v_u_4, (copy) v_u_2
	local v14 = p13._ban_data.BanHistory or {}
	p13.EmptyText.Visible = #v14 == 0
	p13.List.Visible = not p13.EmptyText.Visible
	for _, v_u_15 in pairs(v14) do
		local v_u_16 = v_u_7:Clone()
		local v17 = v_u_16.Picture
		local v18 = string.format
		local v19 = v_u_3.HEADSHOT_IMAGE
		local v20 = v_u_15.Moderator
		v17.Image = v18(v19, (tostring(v20)))
		v_u_16.Date.Text = v_u_15.Date
		v_u_16.Duration.Text = v_u_15.Duration and v_u_15.Duration >= v_u_4.PERMANENT_BAN_DURATION and "\226\136\158" or (v_u_15.Duration and (v_u_15.Duration .. "d" or "") or "")
		v_u_16.Moderator.Text = "\226\128\162 \226\128\162 \226\128\162"
		v_u_16.Reason.Text = v_u_15.Reason
		v_u_16.Reason.TextColor3 = v_u_4:IsBanLogANote(v_u_15) and Color3.fromRGB(127, 127, 127) or (v_u_4:IsBanLogABan(v_u_15) and Color3.fromRGB(255, 50, 50) or Color3.fromRGB(100, 255, 50))
		v_u_16.Parent = p13.Container
		task.spawn(function()
			-- upvalues: (copy) v_u_16, (ref) v_u_2, (copy) v_u_15
			local v21 = v_u_16.Moderator
			local v22 = v_u_2.GetNameFromUserIdAsync
			local v23 = v_u_2
			local v24 = v_u_15.Moderator
			local v25, v26 = pcall(v22, v23, v24)
			if v25 then
				v21.Text = v26
			end
		end)
	end
end
function v_u_8._Init(p_u_27) -- name: _Init
	-- upvalues: (copy) v_u_5
	p_u_27.CloseButton.MouseButton1Click:Connect(function()
		-- upvalues: (copy) p_u_27
		p_u_27:CloseRequest()
	end)
	p_u_27.Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		-- upvalues: (copy) p_u_27
		p_u_27.List.CanvasSize = UDim2.new(0, 0, 0, p_u_27.Layout.AbsoluteContentSize.Y)
	end)
	p_u_27:_Setup()
	v_u_5:Add(p_u_27.CloseButton)
end
return v_u_8