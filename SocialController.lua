local v_u_1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("SocialService")
local v_u_3 = game:GetService("HttpService")
local v_u_4 = game:GetService("Players")
local v_u_5 = require(v_u_1.Modules.Signal)
local v_u_6 = {}
v_u_6.__index = v_u_6
function v_u_6._new() -- name: _new
	-- upvalues: (copy) v_u_6, (copy) v_u_5
	local v7 = v_u_6
	local v8 = setmetatable({}, v7)
	v8.CanSendGameInviteChanged = v_u_5.new()
	v8.FriendsFetched = v_u_5.new()
	v8.CanSendGameInvite = nil
	v8.Friends = {}
	v8._is_friends_with = {}
	v8:_Init()
	return v8
end
function v_u_6.IsFriendsWith(p9, p10) -- name: IsFriendsWith
	-- upvalues: (copy) v_u_4
	local v11 = p9._is_friends_with[tostring(p10)]
	if v11 then
		return v11
	end
	local v12 = v_u_4.LocalPlayer.IsFriendsWithAsync
	local v13 = v_u_4.LocalPlayer
	local v14, v15 = pcall(v12, v13, p10)
	if v14 then
		return v15
	end
	warn("Failed to check IsFriendsWithAsync, error:", v15)
	return false
end
function v_u_6.PromptFriendInvite(_) -- name: PromptFriendInvite
	-- upvalues: (copy) v_u_3, (copy) v_u_1, (copy) v_u_2, (copy) v_u_4
	local v16 = Instance.new("ExperienceInviteOptions")
	v16.PromptMessage = "Challenge your friends to a duel!"
	v16.InviteMessageId = "1dc4ba3b-4978-ea4f-9c63-35babfc20045"
	v16.LaunchData = v_u_3:JSONEncode({
		["SenderHash"] = v_u_1.Remotes.Misc.RequestInviteData:InvokeServer()
	})
	v_u_2:PromptGameInvite(v_u_4.LocalPlayer, v16)
end
function v_u_6._FetchFriends(p17) -- name: _FetchFriends
	-- upvalues: (copy) v_u_4
	for _ = 1, 3 do
		local v18 = v_u_4.LocalPlayer.GetFriendsOnlineAsync
		local v19 = v_u_4.LocalPlayer
		local v20, v21 = pcall(v18, v19, 50)
		if v20 then
			p17.Friends = v21
			break
		end
		warn("Failed to fetch GetFriendsOnlineAsync, error:", v21)
		wait(1)
	end
	for _, v22 in pairs(p17.Friends) do
		local v23 = p17._is_friends_with
		local v24 = v22.VisitorId
		v23[tostring(v24)] = true
	end
	p17.FriendsFetched:Fire()
end
function v_u_6._FetchCanSendGameInvite(p25) -- name: _FetchCanSendGameInvite
	-- upvalues: (copy) v_u_2, (copy) v_u_4
	for _ = 1, 3 do
		local v26 = v_u_2.CanSendGameInviteAsync
		local v27 = v_u_2
		local v28 = v_u_4.LocalPlayer
		local v29, v30 = pcall(v26, v27, v28)
		if v29 then
			p25.CanSendGameInvite = v30
			break
		end
		warn("Failed to fetch CanSendGameInviteAsync:", v30)
		wait(1)
	end
	p25.CanSendGameInviteChanged:Fire()
end
function v_u_6._Init(p31) -- name: _Init
	task.defer(p31._FetchFriends, p31)
	task.defer(p31._FetchCanSendGameInvite, p31)
end
return v_u_6._new()