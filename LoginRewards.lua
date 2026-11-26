local v_u_1 = game:GetService("ReplicatedStorage")
local v2 = game:GetService("Players")
local v_u_3 = require(v_u_1.Modules.LoginRewardLibrary)
local v_u_4 = require(v2.LocalPlayer.PlayerScripts.Controllers.PlayerDataController)
local v_u_5 = require(v2.LocalPlayer.PlayerScripts.Modules.ButtonEffect)
local v_u_6 = require(v2.LocalPlayer.PlayerScripts.Modules.RewardSlot)
local v_u_7 = v2.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("LoginRewardSlot")
local v_u_8 = {}
v_u_8.__index = v_u_8
function v_u_8.new(p9) -- name: new
	-- upvalues: (copy) v_u_8
	local v10 = v_u_8
	local v11 = setmetatable({}, v10)
	v11.Daily = p9
	v11.Frame = v11.Daily.Container:WaitForChild("LoginRewards")
	v11.Container = v11.Frame:WaitForChild("Container")
	v11.SlotsFrame = v11.Container:WaitForChild("Slots")
	v11._cleanup = {}
	v11:_Init()
	return v11
end
function v_u_8.Generate(p12) -- name: Generate
	-- upvalues: (copy) v_u_4, (copy) v_u_3, (copy) v_u_7, (copy) v_u_6, (copy) v_u_1, (copy) v_u_5
	for _, v13 in pairs(p12._cleanup) do
		v13:Destroy()
	end
	p12._cleanup = {}
	local v14 = v_u_4:Get("ClaimedLoginRewardToday")
	local v15 = v_u_4:Get("LoginRewardsClaimed")
	local v16 = (v15 + (v14 and 0 or 1)) / 7 - 1
	local v17 = math.ceil(v16)
	local v18 = math.max(0, v17) * 7 + 1
	for v19 = v18, v18 + 7 - 1 do
		local v20 = v_u_3:GetLoginRewardInfoFromDay(v19)
		local v21 = v19 <= v15
		local v22 = v19 == v15 + 1
		local v23
		if v22 and not v14 then
			v23 = Color3.fromRGB(255, 255, 255)
		else
			v23 = Color3.fromRGB(0, 0, 0)
		end
		local v24 = v_u_7:Clone()
		v24.Button.Title.Text = v20.Title
		v24.Button.Description.Text = v21 and "" or (v20.Description ~= "" and v20.Description or (v22 and not v14 and "Claim now!" or ""))
		v24.Button.Background.BackgroundColor3 = v23
		v24.Button.Background.UIStroke.Color = v23
		v24.Button.Claimed.Visible = v21
		v24.Parent = p12.SlotsFrame:WaitForChild(v19 - v18 + 1)
		local v25 = p12._cleanup
		table.insert(v25, v24)
		for _, v26 in pairs(v20.Rewards) do
			local v27 = v_u_6.new(v26)
			v27:SetInteractable(false)
			v27:SetParent(v24.Button.Reward)
			local v28 = p12._cleanup
			table.insert(v28, v27)
		end
		if not v22 or v14 then
			break
		end
		v24.Button.MouseButton1Click:Connect(function()
			-- upvalues: (ref) v_u_1
			v_u_1.Remotes.Data.ClaimLoginReward:FireServer()
		end)
		v_u_5:Add(v24.Button, nil, {
			["HoverRatio"] = 1.05,
			["ReleaseRatio"] = 1.05
		})
	end
end
function v_u_8.Open(p29) -- name: Open
	p29:Generate()
end
function v_u_8.Close(p30) -- name: Close
	p30:Generate()
end
function v_u_8.Setup(p31) -- name: Setup
	p31:Generate()
end
function v_u_8._Init(p_u_32) -- name: _Init
	-- upvalues: (copy) v_u_4
	v_u_4:GetDataChangedSignal("ClaimedLoginRewardToday"):Connect(function()
		-- upvalues: (copy) p_u_32
		p_u_32:Generate()
	end)
	v_u_4:GetDataChangedSignal("LoginRewardsClaimed"):Connect(function()
		-- upvalues: (copy) p_u_32
		p_u_32:Generate()
	end)
end
return v_u_8