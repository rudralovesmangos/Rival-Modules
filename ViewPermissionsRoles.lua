local v1 = game:GetService("ReplicatedStorage")
local v2 = game:GetService("Players")
local v_u_3 = require(v1.Modules.PermissionsLibrary)
local v_u_4 = require(v1.Modules.Utility)
local v_u_5 = require(v2.LocalPlayer.PlayerScripts.Modules:WaitForChild("ButtonEffect"))
local v_u_6 = require(v2.LocalPlayer.PlayerScripts.Modules:WaitForChild("Prompt"))
local v_u_7 = setmetatable({}, v_u_6)
v_u_7.__index = v_u_7
function v_u_7.new(_, _) -- name: new
	-- upvalues: (copy) v_u_6, (copy) v_u_7
	local v8 = v_u_6.new(script.Name)
	local v9 = v_u_7
	local v10 = setmetatable(v8, v9)
	v10.CloseButton = v10.PromptFrame:WaitForChild("Close")
	v10.List = v10.PromptFrame:WaitForChild("List")
	v10.Container = v10.List:WaitForChild("Container")
	v10.Layout = v10.Container:WaitForChild("Layout")
	v10._description_template = v10.Container:WaitForChild("Description")
	v10._title_template = v10.Container:WaitForChild("Title")
	v10:_Init()
	return v10
end
function v_u_7._Update(p11) -- name: _Update
	p11.List.CanvasSize = UDim2.new(0, 0, 0, p11.Layout.AbsoluteContentSize.Y)
end
function v_u_7._Setup(p12) -- name: _Setup
	-- upvalues: (copy) v_u_3, (copy) v_u_4
	p12._description_template.Parent = nil
	p12._title_template.Parent = nil
	local v13 = {}
	for v14 in pairs(v_u_3.Roles) do
		table.insert(v13, v14)
	end
	table.sort(v13, function(p15, p16)
		-- upvalues: (ref) v_u_3, (ref) v_u_4
		local v17 = v_u_3.Teams[v_u_3.Roles[p15].TeamName].TeamValue
		local v18 = v_u_3.Teams[v_u_3.Roles[p16].TeamName].TeamValue
		if v17 == v18 then
			local v19 = v_u_3.Roles[p15].RoleValue
			local v20 = v_u_3.Roles[p16].RoleValue
			if v19 == v20 then
				return v_u_4:StringLessThan(v_u_3.Roles[p15].DisplayName, v_u_3.Roles[p16].DisplayName)
			else
				return v20 < v19
			end
		else
			return v18 < v17
		end
	end)
	local v_u_21 = tick() + 3
	local v22 = 0
	for _, v23 in pairs(v13) do
		v22 = v22 + 1
		local v24 = v_u_3.Roles[v23]
		local v25 = p12._title_template:Clone()
		v25.Text = v24.DisplayName
		v25.TextColor3 = v24.Color
		v25.LayoutOrder = v22
		v25.Parent = p12.Container
		for _, v26 in pairs(v24.PermissionNames) do
			v22 = v22 + 1
			local v27 = v_u_3.Permissions[v26]
			local v_u_28 = p12._description_template:Clone()
			v_u_28.Container.Guide.Text = " \226\128\162 " .. v27.DisplayName .. " \226\128\148 " .. v27.Description
			v_u_28.Description.Text = v_u_28.Container.Guide.Text
			v_u_28.LayoutOrder = v22
			v_u_28.Parent = p12.Container
			local function v32() -- name: update
				-- upvalues: (copy) v_u_28, (copy) v_u_21
				local v29 = v_u_28.Container.Guide.TextBounds.X / v_u_28.Description.AbsoluteSize.X
				local v30 = math.ceil(v29)
				local v31 = v30 > 5 and tick() < v_u_21 and 1 or v30
				v_u_28.Size = UDim2.new(0.975, 0, v31 * 0.04, 0)
			end
			v_u_28.Container.Guide:GetPropertyChangedSignal("TextBounds"):Connect(v32)
			v_u_28.Description:GetPropertyChangedSignal("AbsoluteSize"):Connect(v32)
			v32()
		end
	end
end
function v_u_7._Init(p_u_33) -- name: _Init
	-- upvalues: (copy) v_u_5
	p_u_33.CloseButton.MouseButton1Click:Connect(function()
		-- upvalues: (copy) p_u_33
		p_u_33:CloseRequest()
	end)
	p_u_33.Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		-- upvalues: (copy) p_u_33
		p_u_33:_Update()
	end)
	p_u_33:_Setup()
	p_u_33:_Update()
	v_u_5:Add(p_u_33.CloseButton)
end
return v_u_7