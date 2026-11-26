game:GetService("ReplicatedStorage")
local v_u_1 = game:GetService("TextChatService")
local v_u_2 = game:GetService("StarterGui")
local v_u_3 = game:GetService("Players")
local v_u_4 = require(v_u_3.LocalPlayer.PlayerScripts.Controllers.SpectateController)
local v_u_5 = require(v_u_3.LocalPlayer.PlayerScripts.Controllers.DuelController)
local v_u_6 = {
	{
		["Result"] = "GG \226\157\164\239\184\143",
		["Words"] = nil,
		["Messages"] = nil,
		["Words"] = { "ggez" },
		["Messages"] = {}
	},
	{
		["Result"] = "you played well",
		["Words"] = nil,
		["Messages"] = nil,
		["Words"] = {
			"ur bad",
			"ur so bad",
			"you are so bad",
			"you are bad",
			"horrible"
		},
		["Messages"] = {}
	},
	{
		["Result"] = "W update \226\157\164\239\184\143",
		["Words"] = nil,
		["Messages"] = nil,
		["Words"] = { "l update" },
		["Messages"] = {}
	},
	{
		["Result"] = "well played \240\159\145\141",
		["Words"] = nil,
		["Messages"] = nil,
		["Words"] = { "gg ez" },
		["Messages"] = { "ez" }
	},
	{
		["Result"] = "nice loadout",
		["Words"] = nil,
		["Messages"] = nil,
		["Words"] = { "p2w", "pay to win", "pay 2 win" },
		["Messages"] = {}
	}
}
local v_u_7 = {}
v_u_7.__index = v_u_7
function v_u_7._new() -- name: _new
	-- upvalues: (copy) v_u_7
	local v8 = v_u_7
	local v9 = setmetatable({}, v8)
	v9._muted_user_ids = {}
	v9:_Init()
	return v9
end
function v_u_7._UpdateChatBubblesEnabled(_) -- name: _UpdateChatBubblesEnabled
	-- upvalues: (copy) v_u_1, (copy) v_u_4
	v_u_1:WaitForChild("BubbleChatConfiguration").Enabled = not (v_u_4.CurrentDuelSubject and v_u_4.CurrentDuelSubject.IsRanked)
end
function v_u_7._DuelInterfaceBubble(p10, p11, p12) -- name: _DuelInterfaceBubble
	-- upvalues: (copy) v_u_5
	if p11 and not table.find(p10._muted_user_ids, p11.UserId) then
		local v13 = {}
		for _, v14 in pairs(v_u_5.Objects) do
			if not v14:GetDueler(p11) then
				continue
			end
			table.insert(v13, v14)
		end
		if #v13 ~= 0 then
			for _, v15 in pairs(v13) do
				v15.DuelInterface.Scores:NewChatMessage(p11, p12)
			end
		end
	else
		return
	end
end
function v_u_7._SetupOnIncomingMessage(p_u_16) -- name: _SetupOnIncomingMessage
	-- upvalues: (copy) v_u_6, (copy) v_u_1, (copy) v_u_3
	local function v_u_30(p17) -- name: get_text_chat_message_properties
		-- upvalues: (ref) v_u_6
		if p17.TextSource then
			local v18 = p17.Text
			local v19 = false
			for _, v20 in pairs(v_u_6) do
				if not table.find(v20.Messages, string.lower(v18)) then
					continue
				end
				v18 = v20.Result
				v19 = true
			end
			if not v19 then
				local v21 = false
				for _, v22 in pairs(v_u_6) do
					for _, v23 in pairs(v22.Words) do
						local v24 = string.find(string.lower(v18), v23)
						if not v24 then
							continue
						end
						local v25 = v24 - 1
						local v26 = string.sub(v18, 1, v25)
						local v27 = v22.Result
						local v28 = v24 + #v23
						v18 = v26 .. v27 .. string.sub(v18, v28)
						v21 = true
					end
				end
				if v21 then
					break
				end
			end
			if v18 ~= p17.Text then
				local v29 = Instance.new("TextChatMessageProperties")
				v29.Text = v18
				return v29
			end
		end
	end
	function v_u_1.OnIncomingMessage(p31)
		-- upvalues: (copy) v_u_30, (ref) v_u_3, (copy) p_u_16
		local v32 = v_u_30(p31)
		if p31.Status == Enum.TextChatMessageStatus.Success then
			local v33 = p31.TextSource and p31.TextSource.UserId
			if v33 then
				v33 = v_u_3:GetPlayerByUserId(p31.TextSource.UserId)
			end
			local v34 = v32 and v32.Translation ~= "" and v32.Translation
			if not v34 then
				if p31.Translation == "" then
					v34 = nil
				else
					v34 = p31.Translation or nil
				end
			end
			local v35 = v32 and v32.Text or p31.Text
			task.defer(p_u_16._DuelInterfaceBubble, p_u_16, v33, v34 or v35)
		end
		return v32
	end
end
function v_u_7._Init(p_u_36) -- name: _Init
	-- upvalues: (copy) v_u_4, (copy) v_u_2
	v_u_4.DuelSubjectChanged:Connect(function()
		-- upvalues: (copy) p_u_36
		p_u_36:_UpdateChatBubblesEnabled()
	end)
	task.spawn(function()
		-- upvalues: (ref) v_u_2, (copy) p_u_36
		v_u_2:GetCore("PlayerMutedEvent").Event:Connect(function(p37)
			-- upvalues: (ref) p_u_36
			if not table.find(p_u_36._muted_user_ids, p37.UserId) then
				local v38 = p_u_36._muted_user_ids
				local v39 = p37.UserId
				table.insert(v38, v39)
			end
		end)
		v_u_2:GetCore("PlayerUnmutedEvent").Event:Connect(function(p40)
			-- upvalues: (ref) p_u_36
			if table.find(p_u_36._muted_user_ids, p40.UserId) then
				table.remove(p_u_36._muted_user_ids, p40.UserId)
			end
		end)
	end)
	task.defer(p_u_36._SetupOnIncomingMessage, p_u_36)
	task.defer(p_u_36._UpdateChatBubblesEnabled, p_u_36)
end
return v_u_7._new()