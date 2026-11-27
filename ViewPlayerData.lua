local v1 = game:GetService("ReplicatedStorage")
local v2 = game:GetService("Players")
local v_u_3 = require(v1.Modules.CONSTANTS)
local v_u_4 = require(v1.Modules.ServerOsTime)
local v_u_5 = require(v1.Modules.Utility)
require(v2.LocalPlayer.PlayerScripts.Controllers:WaitForChild("PlayerDataController"))
local v_u_6 = require(v2.LocalPlayer.PlayerScripts.Controllers:WaitForChild("ComplianceController"))
local v_u_7 = require(v2.LocalPlayer.PlayerScripts.Modules:WaitForChild("ButtonEffect"))
local v_u_8 = require(v2.LocalPlayer.PlayerScripts.Modules:WaitForChild("Prompt"))
local v_u_9 = v2.LocalPlayer.PlayerScripts.UserInterface.WinAffiliationSlot
local v_u_10 = v2.LocalPlayer.PlayerScripts.UserInterface.RawDataText
local v_u_11 = setmetatable({}, v_u_8)
v_u_11.__index = v_u_11
function v_u_11.new(p12, p13) -- name: new
	-- upvalues: (copy) v_u_8, (copy) v_u_11
	local v14 = typeof(p12) == "string"
	local v15 = "Argument 1 invalid, expected a string, got " .. tostring(p12)
	assert(v14, v15)
	local v16 = typeof(p13) == "table"
	local v17 = "Argument 2 invalid, expected a table, got " .. tostring(p13)
	assert(v16, v17)
	local v18 = v_u_8.new(script.Name)
	local v19 = v_u_11
	local v20 = setmetatable(v18, v19)
	v20.CloseButton = v20.PromptFrame:WaitForChild("Close")
	v20.UsernameText = v20.PromptFrame:WaitForChild("Username")
	v20.TabsFrame = v20.PromptFrame:WaitForChild("Tabs")
	v20.RawDataButton = v20.TabsFrame:WaitForChild("RawData")
	v20.HaveWonAgainstButton = v20.TabsFrame:WaitForChild("HaveWonAgainst")
	v20.HaveWonWithButton = v20.TabsFrame:WaitForChild("HaveWonWith")
	v20.PagesFrame = v20.PromptFrame:WaitForChild("Pages")
	v20.RawDataFrame = v20.PagesFrame:WaitForChild("RawData")
	v20.RawDataSearchFrame = v20.RawDataFrame:WaitForChild("Search")
	v20.RawDataSearchBox = v20.RawDataSearchFrame:WaitForChild("Box")
	v20.RawDataLoadButton = v20.RawDataFrame:WaitForChild("Load")
	v20.RawDataList = v20.RawDataFrame:WaitForChild("List")
	v20.RawDataContainer = v20.RawDataList:WaitForChild("Container")
	v20.RawDataLayout = v20.RawDataContainer:WaitForChild("Layout")
	v20.HaveWonAgainstFrame = v20.PagesFrame:WaitForChild("HaveWonAgainst")
	v20.HaveWonAgainstList = v20.HaveWonAgainstFrame:WaitForChild("List")
	v20.HaveWonAgainstContainer = v20.HaveWonAgainstList:WaitForChild("Container")
	v20.HaveWonAgainstLayout = v20.HaveWonAgainstContainer:WaitForChild("Layout")
	v20.HaveWonAgainstEmptyText = v20.HaveWonAgainstContainer:WaitForChild("Empty")
	v20.HaveWonWithFrame = v20.PagesFrame:WaitForChild("HaveWonWith")
	v20.HaveWonWithList = v20.HaveWonWithFrame:WaitForChild("List")
	v20.HaveWonWithContainer = v20.HaveWonWithList:WaitForChild("Container")
	v20.HaveWonWithLayout = v20.HaveWonWithContainer:WaitForChild("Layout")
	v20.HaveWonWithEmptyText = v20.HaveWonWithContainer:WaitForChild("Empty")
	v20._name = p12
	v20._data = p13 and (p13.RawData or {}) or {}
	v20._metadata = p13 and p13.Metadata or {}
	v20._raw_data_texts = {}
	v20:_Init()
	return v20
end
function v_u_11.SetPage(p21, p22) -- name: SetPage
	for _, v23 in pairs(p21.PagesFrame:GetChildren()) do
		v23.Visible = v23.Name == p22
	end
end
function v_u_11._UpdateRawDataSearch(p_u_24) -- name: _UpdateRawDataSearch
	local v25 = string.lower(p_u_24.RawDataSearchBox.Text)
	local v26 = {}
	for v27 in pairs(p_u_24._raw_data_texts) do
		v27.Visible = false
		v26[v27] = string.find(string.lower(v27.Text), v25) or nil
	end
	local function v_u_31(p28) -- name: make_children_visible
		-- upvalues: (copy) p_u_24, (copy) v_u_31
		for v29, v30 in pairs(p_u_24._raw_data_texts) do
			if v30 ~= p28 then
				continue
			end
			v29.Visible = true
			v_u_31(v29)
		end
	end
	for v33 in pairs(v26) do
		v33.Visible = true
		v_u_31(v33)
		while p_u_24._raw_data_texts[v33] ~= true do
			local v33 = p_u_24._raw_data_texts[v33]
			v33.Visible = true
		end
	end
end
function v_u_11._GenerateWinHistory(p_u_34) -- name: _GenerateWinHistory
	-- upvalues: (copy) v_u_7, (copy) v_u_6, (copy) v_u_9, (copy) v_u_3, (copy) v_u_5, (copy) v_u_4
	for _, v_u_35 in pairs({ "HaveWonAgainst", "HaveWonWith" }) do
		local v36 = p_u_34[v_u_35 .. "EmptyText"]
		local v37 = p_u_34[v_u_35 .. "Container"]
		local v38 = p_u_34[v_u_35 .. "Button"]
		local v_u_39 = p_u_34[v_u_35 .. "Layout"]
		local v_u_40 = p_u_34[v_u_35 .. "List"]
		v38.MouseButton1Click:Connect(function()
			-- upvalues: (copy) p_u_34, (copy) v_u_35
			p_u_34:SetPage(v_u_35)
		end)
		v_u_39:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
			-- upvalues: (copy) v_u_40, (copy) v_u_39
			v_u_40.CanvasSize = UDim2.new(0, 0, 0, v_u_39.AbsoluteContentSize.Y)
		end)
		v_u_7:Add(v38)
		v36.Visible = true
		v36.Text = "Loading..."
		local v41 = p_u_34._data[v_u_35] or {}
		local v42 = {}
		for _, v43 in pairs(v41) do
			local v44 = v43[1]
			table.insert(v42, v44)
		end
		local v45 = v_u_6:GetUserInfos(v42)
		local v46 = true
		for v47, v48 in pairs(v41) do
			local v49, v50, v51 = table.unpack(v48)
			local v52 = v45[tostring(v49)]
			local v53 = not v52 or v_u_6:UseDisplayNames() and v52.DisplayName or (v52.Username or "[Failed to load user info]")
			local v54 = "#" .. tostring(v49)
			local v55
			if v52 and (v52.Username and (v_u_6:UsernamesAllowed() and v52.Username ~= v53)) then
				local v56 = v52.Username
				v55 = " @" .. tostring(v56) or ""
			else
				v55 = ""
			end
			local v57 = v54 .. v55
			local v58 = v_u_9:Clone()
			v58.Picture.Image = string.format(v_u_3.HEADSHOT_IMAGE, v49)
			v58.DisplayName.Text = v53
			v58.DisplayName.Position = v57 == "" and UDim2.new(0.15, 0, 0.5, 0) or UDim2.new(0.15, 0, 0.4, 0)
			v58.Username.Text = v57
			v58.Username.Visible = v57 ~= ""
			v58.Quantity.Text = v_u_5:PrettyNumber(v50)
			local v59 = v58.QuantityLabel
			local v60
			if v_u_35 == "HaveWonWith" then
				v60 = v50 == 1 and "win with them" or "wins with them"
			else
				v60 = v50 == 1 and "win against them" or "wins against them"
			end
			v59.Text = v60
			local v61 = v58.LastLogged
			local v62
			if v51 then
				local v63 = v_u_5
				local v64 = v_u_4:Get() - v51
				v62 = "last logged " .. v63:TimeFormat2((math.floor(v64))) .. " ago"
			else
				v62 = ""
			end
			v61.Text = v62
			v58.LayoutOrder = v47
			v58.Parent = v37
			v46 = false
		end
		v36.Text = "Empty"
		v36.Visible = v46
	end
end
function v_u_11._GenerateRawData(p_u_65) -- name: _GenerateRawData
	-- upvalues: (copy) v_u_10, (copy) v_u_5
	p_u_65.RawDataLoadButton.Visible = false
	p_u_65.RawDataSearchFrame.Visible = true
	local v66 = p_u_65._data.RedFlags
	if v66 then
		v66 = p_u_65._data.RedFlags[#p_u_65._data.RedFlags]
	end
	if v66 then
		local v67 = string.format
		local v68 = v66.Reason
		local v69 = v67("-- red flag:    %s", (tostring(v68)))
		local v70 = v_u_10:Clone()
		v70.Text = v69
		v70.LayoutOrder = -999
		v70.Parent = p_u_65.RawDataContainer
	end
	if p_u_65._metadata.DataSize then
		local v71 = string.format
		local v72 = v_u_5:PrettyNumber(p_u_65._metadata.DataSize)
		local v73 = p_u_65._metadata.DataSize / 4194304 * 1000
		local v74 = v71("-- data size:    %s bytes    (%s%%)", v72, math.floor(v73) / 10)
		local v75 = v_u_10:Clone()
		v75.Text = v74
		v75.LayoutOrder = -998
		v75.Parent = p_u_65.RawDataContainer
	end
	if p_u_65._metadata.RobuxSpent then
		local v76 = string.format("-- robux spent:    %s%s %s", p_u_65._metadata.TrueRobuxSpentHidden and ">" or "", v_u_5:PrettyNumber(p_u_65._metadata.RobuxSpent), utf8.char(57346))
		local v77 = v_u_10:Clone()
		v77.Text = v76
		v77.LayoutOrder = -997
		v77.Parent = p_u_65.RawDataContainer
	end
	local v78 = v_u_10:Clone()
	v78.Text = ""
	v78.LayoutOrder = -1
	v78.Parent = p_u_65.RawDataContainer
	local v_u_79 = 0
	local function v_u_86(p80, p81, p82, p83) -- name: generate_text
		-- upvalues: (ref) v_u_10, (ref) v_u_79, (copy) p_u_65
		local v84 = string.format(typeof(p81) == "string" and "\"%s\"" or "%s", (tostring(p81)))
		local v85 = v_u_10:Clone()
		v85.Text = string.format("%s[\"%s\"] = %s", p82, p80, v84) .. ";"
		v85.LayoutOrder = v_u_79
		v85.Parent = p_u_65.RawDataContainer
		p_u_65._raw_data_texts[v85] = p83 or true
		v_u_79 = v_u_79 + 1
	end
	local function v_u_99(p87, p88, p89, p90) -- name: generate_table
		-- upvalues: (ref) v_u_10, (ref) v_u_79, (copy) p_u_65, (copy) v_u_99, (copy) v_u_86
		local v91 = string.rep(" ", 8 * (p88 - 1))
		local v92 = string.rep(" ", 8 * p88)
		local v93
		if p89 then
			v93 = v_u_10:Clone()
			v93.Text = string.format("%s[\"%s\"] = %s", v91, p89, "{")
			v93.LayoutOrder = v_u_79
			v93.Parent = p_u_65.RawDataContainer
			p_u_65._raw_data_texts[v93] = p90 or true
			v_u_79 = v_u_79 + 1
		else
			v93 = nil
		end
		local v94 = true
		for v95, v96 in pairs(p87) do
			v94 = false
			if typeof(v96) == "table" then
				v_u_99(v96, p88 + 1, v95, v93)
			else
				v_u_86(v95, v96, v92, v93)
			end
		end
		if v94 then
			local v97 = v_u_10:Clone()
			v97.Text = v92 .. "-- empty"
			v97.LayoutOrder = v_u_79
			v97.Parent = p_u_65.RawDataContainer
			p_u_65._raw_data_texts[v97] = p90 or true
			v_u_79 = v_u_79 + 1
		end
		if p89 then
			local v98 = v_u_10:Clone()
			v98.Text = v91 .. "};"
			v98.LayoutOrder = v_u_79
			v98.Parent = p_u_65.RawDataContainer
			p_u_65._raw_data_texts[v98] = p90 or true
			v_u_79 = v_u_79 + 1
		end
	end
	local v100 = {}
	for v101 in pairs(p_u_65._data) do
		table.insert(v100, v101)
	end
	table.sort(v100, function(p102, p103)
		-- upvalues: (ref) v_u_5
		return v_u_5:StringLessThan(p102, p103)
	end)
	for _, v104 in pairs(v100) do
		local v105 = p_u_65._data[v104]
		if typeof(v105) == "table" then
			v_u_99(v105, 1, v104)
		else
			v_u_86(v104, v105, "")
		end
	end
	p_u_65.RawDataList.Visible = true
end
function v_u_11._Setup(p106) -- name: _Setup
	p106.UsernameText.Text = "@" .. p106._name
end
function v_u_11._Init(p_u_107) -- name: _Init
	-- upvalues: (copy) v_u_7
	p_u_107.CloseButton.MouseButton1Click:Connect(function()
		-- upvalues: (copy) p_u_107
		p_u_107:CloseRequest()
	end)
	p_u_107.RawDataLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		-- upvalues: (copy) p_u_107
		p_u_107.RawDataList.CanvasSize = UDim2.new(0, 0, 0, p_u_107.RawDataLayout.AbsoluteContentSize.Y)
	end)
	p_u_107.RawDataButton.MouseButton1Click:Connect(function()
		-- upvalues: (copy) p_u_107
		p_u_107:SetPage("RawData")
	end)
	p_u_107.RawDataLoadButton.MouseButton1Click:Connect(function()
		-- upvalues: (copy) p_u_107
		p_u_107:_GenerateRawData()
	end)
	p_u_107.RawDataSearchBox.FocusLost:Connect(function()
		-- upvalues: (copy) p_u_107
		p_u_107:_UpdateRawDataSearch()
	end)
	p_u_107:_Setup()
	task.spawn(p_u_107._GenerateWinHistory, p_u_107)
	p_u_107:SetPage("RawData")
	v_u_7:Add(p_u_107.CloseButton)
	v_u_7:Add(p_u_107.RawDataButton)
	v_u_7:Add(p_u_107.RawDataLoadButton)
end
return v_u_11