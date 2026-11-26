local v1 = game:GetService("ReplicatedStorage")
local v2 = game:GetService("Players")
local v_u_3 = require(v1.Modules.CONSTANTS)
require(v1.Modules.PlayerDataUtility)
local v_u_4 = require(v1.Modules.SeasonLibrary)
local v_u_5 = require(v1.Modules.Utility)
require(v2.LocalPlayer.PlayerScripts.Controllers:WaitForChild("PlayerDataController"))
local v_u_6 = require(v2.LocalPlayer.PlayerScripts.Controllers:WaitForChild("SeasonController"))
local v_u_7 = require(v2.LocalPlayer.PlayerScripts.Modules:WaitForChild("ButtonEffect"))
local v_u_8 = {}
v_u_8.__index = v_u_8
function v_u_8.new(p9) -- name: new
	-- upvalues: (copy) v_u_8
	local v10 = v_u_8
	local v11 = setmetatable({}, v10)
	v11.Page = p9
	v11.UnlockedFrame = v11.Page.PageFrame:WaitForChild("Unlocked")
	v11.Frame = v11.Page.PageFrame:WaitForChild("Locked")
	v11.CloseButton = v11.Frame:WaitForChild("Close")
	v11.List = v11.Frame:WaitForChild("List")
	v11.Container = v11.List:WaitForChild("Container")
	v11.Layout = v11.Container:WaitForChild("Layout")
	v11.RequirementsFrame = v11.Container:WaitForChild("Requirements")
	v11.RequirementsContainer = v11.RequirementsFrame:WaitForChild("Container")
	v11.RequirementsLayout = v11.RequirementsContainer:WaitForChild("Layout")
	v11:_Init()
	return v11
end
function v_u_8.Open(p12) -- name: Open
	p12:_Update()
end
function v_u_8.Close(_) -- name: Close end
function v_u_8._Update(p13) -- name: _Update
	-- upvalues: (copy) v_u_6, (copy) v_u_5, (copy) v_u_3, (copy) v_u_4
	local v14, v15 = v_u_6:IsRankedUnlocked()
	for v16, v17 in pairs(v15) do
		local v18, v19 = table.unpack(v17)
		local v20 = v18 / v19
		local v21 = math.clamp(v20, 0, 1)
		local v22 = p13.RequirementsContainer[v16]
		local v23 = v22.Progress.Bar
		local v24 = v22.Goal
		local v25 = v22.Title
		local v26 = v22.Completed
		v23.Size = UDim2.new(v21, 0, 1, 2)
		v23.BackgroundColor3 = v21 >= 1 and Color3.fromRGB(100, 255, 50) or Color3.fromRGB(255, 255, 255)
		v24.Text = string.format("%s <font size=\"8\">/ %s</font>", v_u_5:PrettyNumber(v18), v_u_5:PrettyNumber(v19))
		v24.Visible = v21 < 1
		v26.Visible = v21 >= 1
		if v16 == "Wins" then
			v25.Text = string.format("Win %s duels", v_u_3.BEGINNER_QUEUE_WINS)
		elseif v16 == "Level" then
			v25.Text = string.format("Reach Level %s", v_u_4.CurrentSeason.LevelRequirement)
		elseif v16 == "AccountAge" then
			v25.Text = string.format("Have a %s day old Roblox account", v_u_4.CurrentSeason.AccountAgeRequirement)
		elseif v16 == "Tasks" then
			v25.Text = string.format("Complete %s tasks", v_u_4.CurrentSeason.TasksCompletedRequirement)
		else
			if v16 ~= "Robux" then
				continue
			end
			v25.Text = string.format("Spend %s%s to skip Roblox checks", utf8.char(57346), v_u_5:PrettyNumber(v_u_4.CurrentSeason.BypassTrustworthySpendRequirement))
		end
	end
	p13.UnlockedFrame.Visible = v14
	p13.Frame.Visible = not p13.UnlockedFrame.Visible
end
function v_u_8._UpdateLayouts(p27) -- name: _UpdateLayouts
	p27.List.CanvasSize = UDim2.new(0, 0, 0, p27.Layout.AbsoluteContentSize.Y)
	p27.RequirementsFrame.Size = UDim2.new(1, 0, 0, p27.RequirementsLayout.AbsoluteContentSize.Y)
end
function v_u_8._Init(p_u_28) -- name: _Init
	-- upvalues: (copy) v_u_7
	p_u_28.CloseButton.MouseButton1Click:Connect(function()
		-- upvalues: (copy) p_u_28
		p_u_28.Page:CloseRequest()
	end)
	p_u_28.Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		-- upvalues: (copy) p_u_28
		p_u_28:_UpdateLayouts()
	end)
	p_u_28.RequirementsLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		-- upvalues: (copy) p_u_28
		p_u_28:_UpdateLayouts()
	end)
	p_u_28:_Update()
	p_u_28:_UpdateLayouts()
	v_u_7:Add(p_u_28.CloseButton)
end
return v_u_8