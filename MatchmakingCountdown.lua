local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("TweenService")
local v_u_3 = game:GetService("RunService")
local v4 = game:GetService("Players")
local v_u_5 = require(v1.Modules.CONSTANTS)
local v_u_6 = require(v1.Modules.Utility)
local v_u_7 = require(v1.Modules.Signal)
local v_u_8 = require(v4.LocalPlayer.PlayerScripts.Controllers:WaitForChild("MatchmakingController"))
local v_u_9 = require(v4.LocalPlayer.PlayerScripts.Modules:WaitForChild("UserInterface"):WaitForChild("Notifications"))
local v_u_10 = require(v4.LocalPlayer.PlayerScripts.Modules:WaitForChild("GlowyBackground"))
local v_u_11 = require(v4.LocalPlayer.PlayerScripts.Modules:WaitForChild("ChickenFooter"))
local v_u_12 = require(v4.LocalPlayer.PlayerScripts.Modules:WaitForChild("UILibrary"))
local v_u_13 = {}
v_u_13.__index = v_u_13
function v_u_13._new() -- name: _new
	-- upvalues: (copy) v_u_13, (copy) v_u_7, (copy) v_u_12, (copy) v_u_11, (copy) v_u_10
	local v14 = v_u_13
	local v15 = setmetatable({}, v14)
	v15.VisibilityChanged = v_u_7.new()
	v15.Frame = v_u_12:GetTo("MatchmakingCountdown")
	v15.Container = v15.Frame:WaitForChild("Container")
	v15.CountdownFrame = v15.Container:WaitForChild("Countdown")
	v15.CountdownText = v15.CountdownFrame:WaitForChild("Value")
	v15.CountdownGlow = v15.CountdownFrame:WaitForChild("Glow")
	v15.WaitingFrame = v15.Container:WaitForChild("Waiting")
	v15.WaitingDotsFrame = v15.WaitingFrame:WaitForChild("Dots")
	v15._countdown_hash = 0
	v15._aborted_notification = false
	v15._cover_part = Instance.new("Part")
	v15._cover_connection = nil
	v15._chicken_footer = v_u_11.new()
	v15._glowy_background = v_u_10.new("MatchmakingCountdown")
	v15:_Init()
	return v15
end
function v_u_13.IsVisible(p16) -- name: IsVisible
	return p16.Frame.Visible
end
function v_u_13._Countdown(p17) -- name: _Countdown
	-- upvalues: (copy) v_u_8, (copy) v_u_6, (copy) v_u_2, (copy) v_u_3
	p17._countdown_hash = p17._countdown_hash + 1
	local v18 = p17._countdown_hash
	local v19 = v_u_8:Get("MatchmadeCountdown") or 0
	p17.CountdownFrame.Visible = v19 > 0
	p17.CountdownText.Text = v19
	if v19 <= 0 then
		return
	else
		v_u_6:CreateSound("rbxassetid://17259538274", 0.5, 1, script, true, 5)
		local v20 = tick()
		while tick() < v20 + 0.375 do
			if v18 ~= p17._countdown_hash then
				return
			end
			local v21 = (tick() - v20) / 0.375
			local v22 = v_u_2:GetValue(v21, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
			local v23 = v_u_2:GetValue(v21, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
			p17.CountdownText.Size = UDim2.new(1, 0, 1.25 - 0.625 * v22)
			p17.CountdownGlow.ImageTransparency = 0.875 - 0.25 * v23
			p17.CountdownGlow.Size = UDim2.new(v23, 0, v23, 0)
			v_u_3.RenderStepped:Wait()
		end
		local v24 = tick()
		while tick() < v24 + 0.625 do
			if v18 ~= p17._countdown_hash then
				return
			end
			local v25 = (tick() - v24) / 0.625
			local v26 = v_u_2:GetValue(v25, Enum.EasingStyle.Quint, Enum.EasingDirection.In)
			local v27 = v_u_2:GetValue(v25, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
			p17.CountdownText.Size = UDim2.new(1, 0, 0.625 - 0.625 * v26)
			p17.CountdownGlow.ImageTransparency = 0.625 + 0.25 * v27
			v_u_3.RenderStepped:Wait()
		end
		if v18 == p17._countdown_hash then
			p17.CountdownFrame.Visible = false
		end
	end
end
function v_u_13._Update(p_u_28) -- name: _Update
	-- upvalues: (copy) v_u_8, (copy) v_u_5, (copy) v_u_3, (copy) v_u_9
	local v29 = v_u_8:Get("MatchmadeStatus")
	local v30 = v_u_8:Get("MatchmadeExpectedPlayers")
	local v31 = v_u_5.IS_MATCHMAKING_SERVER and not v_u_8:Get("MatchmadeGameOver")
	if v31 then
		v31 = v29 == "Waiting" and true or v29 == "Starting"
	end
	local v32
	if v31 then
		v32 = v29 == "Waiting"
	else
		v32 = v31
	end
	p_u_28.Frame.Visible = v31
	p_u_28.WaitingFrame.Visible = v32
	p_u_28._glowy_background:SetEnabled(v31, v31)
	if v32 then
		p_u_28.WaitingDotsFrame:AddTag("UILoadingDots")
		p_u_28._chicken_footer:Show()
		p_u_28._chicken_footer:SetStatus("Waiting For Players")
		p_u_28._chicken_footer:EnableFunFacts()
		p_u_28._chicken_footer:SetTimer((v_u_8:Get("MatchmadeConnectedPlayers") or 0) .. " / " .. (v30 or "???"))
	else
		p_u_28.WaitingDotsFrame:RemoveTag("UILoadingDots")
		p_u_28._chicken_footer:Hide()
	end
	if v31 and not p_u_28._cover_connection then
		p_u_28._cover_part.Parent = workspace
		p_u_28._cover_connection = v_u_3.RenderStepped:Connect(function()
			-- upvalues: (copy) p_u_28
			p_u_28._cover_part.CFrame = workspace.CurrentCamera.CFrame * CFrame.new(0, 0, -1)
		end)
	elseif not v31 and p_u_28._cover_connection then
		p_u_28._cover_part.Parent = nil
		p_u_28._cover_connection:Disconnect()
		p_u_28._cover_connection = nil
	end
	if v29 == "Aborted" and not p_u_28._aborted_notification then
		p_u_28._aborted_notification = true
		v_u_9:Queue("Duel Cancelled", "Not enough players connected", "rbxassetid://18553001997", nil, 0.75)
	end
end
function v_u_13._Setup(p33) -- name: _Setup
	p33._cover_part.Size = Vector3.new(10, 10, 0)
	p33._cover_part.Anchored = true
	p33._cover_part.CanCollide = false
	p33._cover_part.CanTouch = false
	p33._cover_part.CanQuery = false
	p33._cover_part.Color = Color3.fromRGB(0, 0, 0)
	p33._cover_part.Material = Enum.Material.Neon
	local v34 = Instance.new("SurfaceGui")
	v34.AlwaysOnTop = true
	v34.Face = Enum.NormalId.Back
	v34.Parent = p33._cover_part
	local v35 = Instance.new("Frame")
	v35.Size = UDim2.new(1, 0, 1, 0)
	v35.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	v35.Parent = v34
	p33._chicken_footer:SetParent(p33.Container)
	p33._glowy_background:SetParent(p33.Container)
end
function v_u_13._Init(p_u_36) -- name: _Init
	-- upvalues: (copy) v_u_8
	p_u_36.Frame:GetPropertyChangedSignal("Visible"):Connect(function()
		-- upvalues: (copy) p_u_36
		p_u_36.VisibilityChanged:Fire()
	end)
	v_u_8:GetDataChangedSignal("MatchmadeGameOver"):Connect(function()
		-- upvalues: (copy) p_u_36
		p_u_36:_Update()
	end)
	v_u_8:GetDataChangedSignal("MatchmadeStatus"):Connect(function()
		-- upvalues: (copy) p_u_36
		p_u_36:_Update()
	end)
	v_u_8:GetDataChangedSignal("MatchmadeCountdown"):Connect(function()
		-- upvalues: (copy) p_u_36
		p_u_36:_Update()
		p_u_36:_Countdown()
	end)
	v_u_8:GetDataChangedSignal("MatchmadeConnectedPlayers"):Connect(function()
		-- upvalues: (copy) p_u_36
		p_u_36:_Update()
		p_u_36:_Countdown()
	end)
	v_u_8:GetDataChangedSignal("MatchmadeExpectedPlayers"):Connect(function()
		-- upvalues: (copy) p_u_36
		p_u_36:_Update()
		p_u_36:_Countdown()
	end)
	p_u_36:_Setup()
	task.defer(p_u_36._Update, p_u_36)
	task.defer(p_u_36._Countdown, p_u_36)
end
return v_u_13._new()