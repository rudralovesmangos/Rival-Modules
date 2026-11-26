local v_u_1 = game:GetService("CollectionService")
local v_u_2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("Players")
local v_u_4 = require(v_u_2.Modules.CONSTANTS)
local v_u_5 = require(v_u_2.Modules.ReplicatedClass)
local v_u_6 = require(v_u_2.Modules.Signal)
local v_u_7 = require(v_u_3.LocalPlayer.PlayerScripts.Controllers.PlayerDataController)
local v_u_8 = { "FreecamEnabled", "ArcadeCanPlayAllMaps" }
local v_u_9 = setmetatable({}, v_u_5)
v_u_9.__index = v_u_9
function v_u_9._new() -- name: _new
	-- upvalues: (copy) v_u_5, (copy) v_u_9, (copy) v_u_6
	local v10 = v_u_5.new()
	local v11 = v_u_9
	local v12 = setmetatable(v10, v11)
	v12.BannedPlayersChanged = v_u_6.new()
	v12.BannedPlayers = {}
	v12._private_server_assets = {}
	v12:_Init()
	return v12
end
function v_u_9.ServerKick(_, p13) -- name: ServerKick
	-- upvalues: (copy) v_u_2
	v_u_2.Remotes.PrivateServer.KickPlayer:FireServer(p13)
end
function v_u_9.ServerBan(_, p14) -- name: ServerBan
	-- upvalues: (copy) v_u_2
	v_u_2.Remotes.PrivateServer.BanPlayer:FireServer(p14)
end
function v_u_9._UpdatePrivateServerAssets(p15) -- name: _UpdatePrivateServerAssets
	-- upvalues: (copy) v_u_4, (copy) v_u_7
	for v_u_16, v_u_17 in pairs(p15._private_server_assets) do
		local function v20()
			-- upvalues: (copy) v_u_16, (ref) v_u_4, (ref) v_u_7, (copy) v_u_17
			local v18 = v_u_16
			local v19
			if v_u_4.IS_PRIVATE_HUB_SERVER and not v_u_7:GetSetting("Hide Intrusive Lobby Elements") then
				v19 = v_u_17 or nil
			else
				v19 = nil
			end
			v18.Parent = v19
		end
		pcall(v20)
	end
end
function v_u_9._ObjectAdded(p21, p22) -- name: _ObjectAdded
	if not p21._private_server_assets[p22] then
		p21._private_server_assets[p22] = p22.Parent
		p21:_UpdatePrivateServerAssets()
	end
end
function v_u_9._SetBannedPlayers(p23, p24) -- name: _SetBannedPlayers
	p23.BannedPlayers = p24
	p23.BannedPlayersChanged:Fire()
end
function v_u_9._FetchBannedPlayers(p25) -- name: _FetchBannedPlayers
	-- upvalues: (copy) v_u_4, (copy) v_u_3, (copy) v_u_2
	if v_u_4.IS_PRIVATE_SERVER_OWNER(v_u_3.LocalPlayer.UserId) then
		local v26 = v_u_2.Remotes.PrivateServer.FetchBannedPlayers.InvokeServer
		local v27 = v_u_2.Remotes.PrivateServer.FetchBannedPlayers
		local v28, v29 = pcall(v26, v27)
		if v28 then
			p25:_SetBannedPlayers(v29)
		end
	else
		return
	end
end
function v_u_9._Setup(p_u_30) -- name: _Setup
	-- upvalues: (copy) v_u_8
	for _, v_u_31 in pairs(v_u_8) do
		workspace:GetAttributeChangedSignal(v_u_31):Connect(function() -- name: update
			-- upvalues: (copy) p_u_30, (copy) v_u_31
			p_u_30:SetReplicate(v_u_31, workspace:GetAttribute(v_u_31))
		end)
		p_u_30:SetReplicate(v_u_31, workspace:GetAttribute(v_u_31))
	end
end
function v_u_9._Init(p_u_32) -- name: _Init
	-- upvalues: (copy) v_u_2, (copy) v_u_7, (copy) v_u_1
	v_u_2.Remotes.PrivateServer.ReplicateBannedPlayers.OnClientEvent:Connect(function(p33)
		-- upvalues: (copy) p_u_32
		p_u_32:_SetBannedPlayers(p33)
	end)
	v_u_7:GetSettingChangedSignal("Hide Intrusive Lobby Elements"):Connect(function()
		-- upvalues: (copy) p_u_32
		p_u_32:_UpdatePrivateServerAssets()
	end)
	v_u_1:GetInstanceAddedSignal("LobbyPrivateServerOnly"):Connect(function(p34)
		-- upvalues: (copy) p_u_32
		p_u_32:_ObjectAdded(p34)
	end)
	for _, v35 in pairs(v_u_1:GetTagged("LobbyPrivateServerOnly")) do
		task.defer(p_u_32._ObjectAdded, p_u_32, v35)
	end
	p_u_32:_Setup()
	task.defer(p_u_32._FetchBannedPlayers, p_u_32)
end
return v_u_9._new()