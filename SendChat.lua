local v_u_1 = game:GetService("TextChatService")
local v_u_2 = game:GetService("StarterGui")
local v3 = game:GetService("Players")
local v_u_4 = require(v3.LocalPlayer.PlayerScripts.Controllers:WaitForChild("ComplianceController"))
local v_u_5
if v_u_1.ChatVersion == Enum.ChatVersion.TextChatService then
	v_u_5 = Instance.new("TextChannel")
	v_u_5.Name = "ServerMessageChannel"
	v_u_5.Parent = v_u_1:WaitForChild("TextChannels")
else
	v_u_5 = nil
end
return function(p6)
	-- upvalues: (copy) v_u_4, (copy) v_u_1, (copy) v_u_2, (ref) v_u_5
	local v7 = typeof(p6) == "table"
	local v8 = "Argument 1 invalid, expected a table, got " .. tostring(p6)
	assert(v7, v8)
	if v_u_4:IsChina() then
		return
	elseif v_u_1.ChatVersion == Enum.ChatVersion.LegacyChatService then
		p6.Text = p6.Text or string.rep("?", 16)
		p6.Color = p6.Color or Color3.fromRGB(0, 0, 0)
		p6.Font = p6.Font or Enum.Font.GothamMedium
		p6.TextSize = p6.TextSize or 14
		v_u_2:SetCore("ChatMakeSystemMessage", p6)
	elseif v_u_1.ChatVersion == Enum.ChatVersion.TextChatService then
		p6.Text = p6.Text or "NO CHAT_DATA.TEXT"
		p6.Font = p6.Font or Enum.Font.GothamBold
		p6.TextSize = p6.TextSize or 14
		local v9 = p6.Color
		local v10 = typeof(v9) == "Color3" and p6.Color
		if not v10 then
			local v11 = p6.Color
			v10 = typeof(v11) == "string" and Color3.fromHex(p6.Color) or Color3.new()
		end
		p6.Color = v10
		local v12 = "<font"
		if p6.Color then
			local v13 = p6.Color.R * 255
			local v14 = math.floor(v13)
			local v15 = p6.Color.G * 255
			local v16 = math.floor(v15)
			local v17 = p6.Color.B * 255
			v12 = v12 .. " color=\"rgb(" .. v14 .. "," .. v16 .. "," .. math.floor(v17) .. ")\""
		end
		if p6.Font then
			local v18 = p6.Font
			local v19
			if typeof(v18) == "EnumItem" then
				v19 = p6.Font.Name
			else
				local v20 = p6.Font
				v19 = tostring(v20)
			end
			v12 = v12 .. " face=\"" .. v19 .. "\""
		end
		if p6.TextSize then
			v12 = v12 .. " size=\"" .. p6.TextSize .. "\""
		end
		v_u_5:DisplaySystemMessage((v12 .. ">") .. p6.Text .. "</font>")
	end
end