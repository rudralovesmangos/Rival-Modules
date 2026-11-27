local v_u_1 = game:GetService("ReplicatedStorage")
local v2 = game:GetService("Players")
require(v_u_1.Modules.BetterDebris)
local v_u_3 = require(v2.LocalPlayer.PlayerScripts.Controllers:WaitForChild("PlayerDataController"))
local v_u_4 = require(v2.LocalPlayer.PlayerScripts.Modules:WaitForChild("GlowyBackground"))
local v_u_5 = require(v2.LocalPlayer.PlayerScripts.Modules:WaitForChild("ButtonEffect"))
local v_u_6 = require(v2.LocalPlayer.PlayerScripts.Modules:WaitForChild("UILibrary"))
local v_u_7 = v2.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("WarningCard")
local v_u_8 = {}
v_u_8.__index = v_u_8
function v_u_8._new() -- name: _new
	-- upvalues: (copy) v_u_8, (copy) v_u_6, (copy) v_u_4
	local v9 = v_u_8
	local v10 = setmetatable({}, v9)
	v10.Frame = v_u_6:GetTo("WarningMessages")
	v10._glowy_background = v_u_4.new("WarningCard")
	v10._message_queue = {}
	v10._queue_started = false
	v10:_Init()
	return v10
end
function v_u_8.AddToQueue(p11, p12) -- name: AddToQueue
	if not p12.HasUnderstood then
		for _, v13 in pairs(p11._message_queue) do
			if v13.WarnID ~= p12.WarnID then
				continue
			end
			return
		end
		local v14 = p11._message_queue
		table.insert(v14, p12)
		task.defer(p11._StartQueue, p11)
	end
end
function v_u_8._StartQueue(p15) -- name: _StartQueue
	-- upvalues: (copy) v_u_7, (copy) v_u_5, (copy) v_u_1
	if not p15._queue_started then
		p15._queue_started = true
		p15._glowy_background:SetEnabled(true)
		while #p15._message_queue > 0 do
			local v16 = p15._message_queue[1]
			local v17 = v_u_7:Clone()
			v17.Container.Message.Description.Text = v16.WarnMessage
			v17.Container.Message.InvisibleDescription.Text = v16.WarnMessage
			v17.ZIndex = 9999999
			v17.Parent = p15.Frame
			v17.Container.Position = UDim2.new(0.5, 0, 0.6, 0)
			v17.Container:TweenPosition(UDim2.new(0.5, 0, 0.5, 0), "Out", "Back", 0.25, true)
			local v18 = v17.Container.Message
			local v_u_19 = v18.Description
			local v_u_20 = v18.InvisibleDescription
			local function v25() -- name: update_text
				-- upvalues: (copy) v_u_19, (copy) v_u_20
				v_u_19.Text = v_u_20.Text
				local v21 = v_u_19
				local v22 = UDim2.new
				local v23 = v_u_20.Size.Y.Scale
				local v24 = v_u_20.TextBounds.X / v_u_19.AbsoluteSize.X
				v21.Size = v22(0.9, 0, v23 * math.ceil(v24), 0)
			end
			v_u_20:GetPropertyChangedSignal("AbsolutePosition"):Connect(v25)
			v_u_20:GetPropertyChangedSignal("AbsoluteSize"):Connect(v25)
			v_u_20:GetPropertyChangedSignal("TextBounds"):Connect(v25)
			v_u_20:GetPropertyChangedSignal("Text"):Connect(v25)
			v_u_19:GetPropertyChangedSignal("AbsoluteSize"):Connect(v25)
			v_u_19.Text = v_u_20.Text
			local v26 = UDim2.new
			local v27 = v_u_20.Size.Y.Scale
			local v28 = v_u_20.TextBounds.X / v_u_19.AbsoluteSize.X
			v_u_19.Size = v26(0.9, 0, v27 * math.ceil(v28), 0)
			local v_u_29 = v17.Container.Button
			local v_u_30 = v17.Container.FakeButton
			v_u_30.ResizeEffect.Size = UDim2.new(0, 0, 1, 0)
			v_u_30.ResizeEffect:TweenSize(UDim2.new(1, 0, 1, 0), "Out", "Linear", 15, true)
			task.delay(15, function()
				-- upvalues: (copy) v_u_29, (copy) v_u_30
				v_u_29.Visible = true
				v_u_30.Visible = false
			end)
			v_u_5:Add(v_u_29, true)
			v_u_29.MouseButton1Click:Wait()
			table.remove(p15._message_queue, 1)
			v17:Destroy()
			v_u_1.Remotes.Misc.UnderstoodWarning:FireServer(v16.WarnID)
		end
		p15._glowy_background:SetEnabled(false)
		p15._queue_started = false
	end
end
function v_u_8._UpdateQueue(p31) -- name: _UpdateQueue
	-- upvalues: (copy) v_u_3
	for _, v32 in pairs(v_u_3:Get("ModerationWarningMessages")) do
		p31:AddToQueue(v32)
	end
end
function v_u_8._Setup(p33) -- name: _Setup
	p33._glowy_background:SetColor("Purple", Color3.fromRGB(80, 67, 0))
	p33._glowy_background:SetColor("Purple2", Color3.fromRGB(0, 0, 0))
	p33._glowy_background:SetColor("Yellow", Color3.fromRGB(255, 215, 0))
	p33._glowy_background:SetParent(p33.Frame)
end
function v_u_8._Init(p_u_34) -- name: _Init
	-- upvalues: (copy) v_u_3
	v_u_3:GetDataChangedSignal("ModerationWarningMessages"):Connect(function()
		-- upvalues: (copy) p_u_34
		p_u_34:_UpdateQueue()
	end)
	p_u_34:_Setup()
	p_u_34:_UpdateQueue()
end
return v_u_8._new()