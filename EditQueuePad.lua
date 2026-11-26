local v_u_1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("Players")
local v_u_3 = require(v_u_1.Modules.SettingsInfo)
local v_u_4 = require(v_u_1.Modules.DuelLibrary)
local v_u_5 = require(v_u_2.LocalPlayer.PlayerScripts.Modules:WaitForChild("ButtonEffect"))
local v_u_6 = require(v_u_2.LocalPlayer.PlayerScripts.Modules:WaitForChild("Page"))
local v_u_7 = v_u_2.LocalPlayer.PlayerScripts.Modules:WaitForChild("Settings")
local v_u_8 = {
	{
		"QueueName",
		"Dropdown",
		"Gamemode",
		"rbxassetid://77802568386086",
		"Changes the gameplay, map pool, & more"
	},
	{
		"MapPool",
		"Dropdown",
		"Map Pool",
		"rbxassetid://83261934303870",
		"Change how the map pool is determined"
	},
	{
		"MapPoolGamemode",
		"Dropdown",
		"By Gamemode",
		"rbxassetid://14641612286",
		"You probably don\'t need to edit this"
	},
	{
		"MapPoolSpecific",
		"Dropdown",
		"Specific Map",
		"rbxassetid://14641612286",
		"Choose the specific map you want"
	},
	{
		"InfinitePlayersPerTeam",
		"Toggle",
		"Infinite Players",
		"rbxassetid://16782323002",
		"The private server owner has to manually start this duel"
	},
	{
		"PlayersPerTeam",
		"Slider",
		"Players Per Team",
		"rbxassetid://105821004981978",
		"Turn on Infinite Players if you have a big party"
	},
	{
		"UnlimitedTime",
		"Toggle",
		"Unlimited Time",
		"rbxassetid://18195730712",
		"The timer won\'t end while playing this duel"
	},
	{
		"CanSelfQueue",
		"Toggle",
		"Play Solo",
		"rbxassetid://17738769051",
		"Allows you to play this duel by yourself"
	},
	{
		"DisableOOB",
		"Toggle",
		"Out of Bounds",
		"rbxassetid://89987125943326",
		"Go out of bounds in any map"
	}
}
local v_u_9 = setmetatable({}, v_u_6)
v_u_9.__index = v_u_9
function v_u_9._new() -- name: _new
	-- upvalues: (copy) v_u_6, (copy) v_u_9
	local v10 = v_u_6.new(script.Name)
	local v11 = v_u_9
	local v12 = setmetatable(v10, v11)
	v12.CloseButton = v12.PageFrame:WaitForChild("Close")
	v12.List = v12.PageFrame:WaitForChild("List")
	v12.Container = v12.List:WaitForChild("Container")
	v12.Layout = v12.Container:WaitForChild("Layout")
	v12.HeaderFrame = v12.Container:WaitForChild("Header")
	v12.HeaderTitle = v12.HeaderFrame:WaitForChild("Title")
	v12._client_queue_pad = nil
	v12._setting_objects = {}
	v12._connections = {}
	v12:_Init()
	return v12
end
function v_u_9.SetQueuePad(p_u_13, p14) -- name: SetQueuePad
	for _, v15 in pairs(p_u_13._connections) do
		v15:Disconnect()
	end
	p_u_13._connections = {}
	p_u_13._client_queue_pad = p14
	if p_u_13._client_queue_pad then
		p_u_13.HeaderTitle.Text = p14:Get("Model").Name
		for _, v16 in pairs(p_u_13._setting_objects) do
			v16.RegenerateSettingsInfo()
		end
		local function v20() -- name: update
			-- upvalues: (copy) p_u_13
			for v17, v18 in pairs(p_u_13._setting_objects) do
				local v19 = p_u_13._client_queue_pad:Get(v17)
				if v19 == nil then
					v19 = v18.SettingObject.SettingsInfo.DefaultValue
				end
				v18.SettingObject:SetValue(v19, true, true)
			end
		end
		local v21 = p_u_13._connections
		local v22 = p_u_13._client_queue_pad.Activity
		table.insert(v21, v22:Connect(v20))
		v20()
	end
end
function v_u_9.Close(p23, ...) -- name: Close
	-- upvalues: (copy) v_u_6
	p23:SetQueuePad(nil)
	v_u_6.Close(p23, ...)
end
function v_u_9._GetSettingsInfoValueParams(p24, p25) -- name: _GetSettingsInfoValueParams
	-- upvalues: (copy) v_u_2, (copy) v_u_4
	if p25 == "InfinitePlayersPerTeam" or (p25 == "UnlimitedTime" or (p25 == "CanSelfQueue" or p25 == "DisableOOB")) then
		return false, nil
	end
	if p25 == "PlayersPerTeam" then
		local v26 = p24._client_queue_pad
		if v26 then
			v26 = p24._client_queue_pad:Get("QueueName")
		end
		if v26 then
			v26 = p24._client_queue_pad:GetMatchmakingQueueInfoFromQueueName(v26)
		end
		return v26 and v26.PlayersPerTeam or 1, 1, p24._client_queue_pad and p24._client_queue_pad:GetMaxPlayersPerTeam() or 1, 1
	end
	if p25 == "QueueName" then
		local v27 = p24._client_queue_pad and (p24._client_queue_pad:GetDuelLogics(v_u_2.LocalPlayer) or { "???" }) or { "???" }
		local v28 = p24._client_queue_pad
		if v28 then
			v28 = p24._client_queue_pad:Get("OriginalQueueName")
		end
		if v28 then
			v28 = v_u_4.MatchmakingQueues[v28]
		end
		if v28 then
			v28 = v28.TitleName or v28.DisplayName
		end
		if not (v28 and (table.find(v27, v28) and v28)) then
			v28 = v27[1]
		end
		return v28, v27
	end
	if p25 == "MapPool" then
		return "By Gamemode", { "Unrestricted", "By Gamemode", "Specific Map" }
	end
	if p25 == "MapPoolGamemode" then
		local v29 = p24._client_queue_pad and (p24._client_queue_pad:GetMapPools(v_u_2.LocalPlayer) or { "???" }) or { "???" }
		local v30 = p24._client_queue_pad
		if v30 then
			v30 = p24._client_queue_pad:Get("QueueName")
		end
		if v30 then
			v30 = p24._client_queue_pad:GetMatchmakingQueueInfoFromQueueName(v30)
		end
		return v30 and (v30.DisplayName and table.find(v29, v30.DisplayName)) and v30.DisplayName or v29[1], v29
	end
	if p25 == "MapPoolSpecific" then
		local v31 = p24._client_queue_pad and p24._client_queue_pad:GetSortedMapNames() or { "???" }
		return v31[1], v31
	end
	assert(false, p25)
end
function v_u_9._Setup(p_u_32) -- name: _Setup
	-- upvalues: (copy) v_u_8, (copy) v_u_7, (copy) v_u_3, (copy) v_u_1
	for v33, v34 in pairs(v_u_8) do
		local v_u_35, v_u_36, v_u_37, v_u_38, v_u_39 = table.unpack(v34)
		local function v_u_40() -- name: regenerate_settings_info
			-- upvalues: (ref) v_u_3, (copy) v_u_37, (copy) v_u_38, (copy) v_u_39, (copy) v_u_36, (copy) p_u_32, (copy) v_u_35
			return v_u_3.new("", "", v_u_37, v_u_38, v_u_39, v_u_36, p_u_32:_GetSettingsInfoValueParams(v_u_35))
		end
		local v_u_41 = require(v_u_7[v_u_36]).new(v_u_40())
		v_u_41.SettingFrame.LayoutOrder = v33
		v_u_41.SettingFrame.Parent = p_u_32.Container
		v_u_41.Replicate:Connect(function()
			-- upvalues: (copy) p_u_32, (ref) v_u_1, (copy) v_u_35, (copy) v_u_41
			if p_u_32._client_queue_pad then
				v_u_1.Remotes.PrivateServer.EditQueuePad:FireServer(p_u_32._client_queue_pad:Get("ObjectID"), v_u_35, v_u_41.Value)
			end
		end)
		p_u_32._setting_objects[v_u_35] = {
			["SettingObject"] = v_u_41,
			["RegenerateSettingsInfo"] = function() -- name: RegenerateSettingsInfo
				-- upvalues: (copy) v_u_41, (copy) v_u_40
				v_u_41:SetSettingsInfo(v_u_40())
			end
		}
	end
	p_u_32._setting_objects.MapPool.SettingObject:Scale(0.95)
	p_u_32._setting_objects.MapPoolGamemode.SettingObject:Scale(0.9)
	p_u_32._setting_objects.MapPoolSpecific.SettingObject:Scale(0.9)
	p_u_32._setting_objects.InfinitePlayersPerTeam.SettingObject:Scale(0.95)
	p_u_32._setting_objects.PlayersPerTeam.SettingObject:Scale(0.9)
	local function v42() -- name: update_dependencies
		-- upvalues: (copy) p_u_32
		p_u_32._setting_objects.PlayersPerTeam.SettingObject.SettingFrame.Visible = not p_u_32._setting_objects.InfinitePlayersPerTeam.SettingObject.Value
		p_u_32._setting_objects.MapPoolGamemode.SettingObject.SettingFrame.Visible = p_u_32._setting_objects.MapPool.SettingObject.Value == "By Gamemode"
		p_u_32._setting_objects.MapPoolSpecific.SettingObject.SettingFrame.Visible = p_u_32._setting_objects.MapPool.SettingObject.Value == "Specific Map"
	end
	p_u_32._setting_objects.InfinitePlayersPerTeam.SettingObject.Changed:Connect(v42)
	p_u_32._setting_objects.MapPool.SettingObject.Changed:Connect(v42)
	v42()
	p_u_32._setting_objects.QueueName.SettingObject.Changed:Connect(function()
		-- upvalues: (copy) p_u_32
		p_u_32._setting_objects.PlayersPerTeam.RegenerateSettingsInfo()
		p_u_32._setting_objects.MapPoolGamemode.RegenerateSettingsInfo()
	end)
end
function v_u_9._Init(p_u_43) -- name: _Init
	-- upvalues: (copy) v_u_5
	p_u_43.CloseButton.MouseButton1Click:Connect(function()
		-- upvalues: (copy) p_u_43
		p_u_43:CloseRequest()
	end)
	p_u_43.Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		-- upvalues: (copy) p_u_43
		p_u_43.List.CanvasSize = UDim2.new(0, 0, 0, p_u_43.Layout.AbsoluteContentSize.Y)
		p_u_43.List.Active = p_u_43.Layout.AbsoluteContentSize.Y >= p_u_43.List.AbsoluteSize.Y
	end)
	p_u_43:_Setup()
	v_u_5:Add(p_u_43.CloseButton)
end
return v_u_9._new()