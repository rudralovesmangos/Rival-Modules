local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("Lighting")
local v3 = game:GetService("Players")
local v_u_4 = require(v1.Modules.Utility)
local v_u_5 = require(v3.LocalPlayer.PlayerScripts.Controllers.SpectateController)
local v_u_6 = require(v3.LocalPlayer.PlayerScripts.Modules.UserInterface.MobileInputs)
local v_u_7 = require(v3.LocalPlayer.PlayerScripts.Modules.UserInterface.Pages)
local v_u_8 = Color3.fromRGB(255, 255, 255)
local v_u_9 = Color3.fromRGB(220, 220, 220)
local v_u_10 = {}
v_u_10.__index = v_u_10
function v_u_10._new() -- name: _new
	-- upvalues: (copy) v_u_10
	local v11 = v_u_10
	local v12 = setmetatable({}, v11)
	v12._blur = Instance.new("BlurEffect")
	v12._colorcorrection = Instance.new("ColorCorrectionEffect")
	v12._last_blur_enabled = nil
	v12._last_cc_enabled = nil
	v12._tween_hash = 0
	v12._current_duel = nil
	v12._current_duel_connections = {}
	v12:_Init()
	return v12
end
function v_u_10._Tween(p_u_13, p14, p15, p16, p17) -- name: _Tween
	-- upvalues: (copy) v_u_8, (copy) v_u_9, (copy) v_u_4
	local v18 = p14 or false
	local v19 = p14 or false
	if v18 == p_u_13._last_blur_enabled and v19 == p_u_13._last_cc_enabled then
		return
	end
	p_u_13._last_blur_enabled = v18
	p_u_13._last_cc_enabled = v19
	p_u_13._tween_last = p14
	p_u_13._tween_hash = p_u_13._tween_hash + 1
	local v_u_20 = p_u_13._tween_hash
	local v_u_21 = p_u_13._blur.Size
	local v_u_22 = p_u_13._colorcorrection.Brightness
	local v_u_23 = p_u_13._colorcorrection.TintColor
	local v_u_24 = v18 and (p15 and 60 or 24 or 0) or 0
	local v_u_25 = v19 and (p16 and 0 or -0.1 or 0) or 0
	local v_u_26
	if v19 then
		if p16 then
			v_u_26 = v_u_8
		else
			v_u_26 = v_u_9
		end
		if not v_u_26 then
			v_u_26 = v_u_8
		end
	else
		v_u_26 = v_u_8
	end
	task.spawn(v_u_4.RenderstepForLoop, v_u_4, 0, 100, p17 and 100 or 4, function(p27)
		-- upvalues: (copy) v_u_20, (copy) p_u_13, (copy) v_u_21, (copy) v_u_24, (copy) v_u_22, (copy) v_u_25, (copy) v_u_23, (copy) v_u_26
		if v_u_20 ~= p_u_13._tween_hash then
			return true
		end
		local v28 = 1 - (1 - p27 / 100) ^ 3
		p_u_13._blur.Size = v_u_21 + (v_u_24 - v_u_21) * v28
		p_u_13._colorcorrection.Brightness = v_u_22 + (v_u_25 - v_u_22) * v28
		p_u_13._colorcorrection.TintColor = v_u_23:Lerp(v_u_26, v28)
	end)
end
function v_u_10._Update(p29) -- name: _Update
	-- upvalues: (copy) v_u_7, (copy) v_u_6
	local v30 = v_u_7.PageSystem.CurrentPage
	if v30 then
		v30 = v_u_7.PageSystem.CurrentPage.UseDarkBlurryBackground
	end
	local v31 = p29._current_duel
	if v31 then
		v31 = p29._current_duel.DuelInterface.Scoreboard:IsOpen() or (p29._current_duel.DuelInterface.FinalResults.CurrentPage == "Summary" and true or p29._current_duel.DuelInterface.Voting:IsOpen())
	end
	p29:_Tween(v30 or (v31 or v_u_6.EditorEnabled), v_u_6.EditorEnabled, v_u_6.EditorEnabled)
end
function v_u_10._VerifyClientDuel(p_u_32) -- name: _VerifyClientDuel
	-- upvalues: (copy) v_u_5
	for _, v33 in pairs(p_u_32._current_duel_connections) do
		v33:Disconnect()
	end
	p_u_32._current_duel_connections = {}
	p_u_32._current_duel = v_u_5.CurrentDuelSubject
	p_u_32:_Update()
	if p_u_32._current_duel then
		local v34 = p_u_32._current_duel_connections
		local v35 = p_u_32._current_duel.DuelInterface.Frame:GetPropertyChangedSignal("Visible")
		table.insert(v34, v35:Connect(function()
			-- upvalues: (copy) p_u_32
			p_u_32:_Update()
		end))
		local v36 = p_u_32._current_duel_connections
		local v37 = p_u_32._current_duel.DuelInterface.Scoreboard.VisibilityChanged
		table.insert(v36, v37:Connect(function()
			-- upvalues: (copy) p_u_32
			p_u_32:_Update()
		end))
		local v38 = p_u_32._current_duel_connections
		local v39 = p_u_32._current_duel.DuelInterface.FinalResults.PageChanged
		table.insert(v38, v39:Connect(function()
			-- upvalues: (copy) p_u_32
			p_u_32:_Update()
		end))
		local v40 = p_u_32._current_duel_connections
		local v41 = p_u_32._current_duel.DuelInterface.Voting.VisibilityChanged
		table.insert(v40, v41:Connect(function()
			-- upvalues: (copy) p_u_32
			p_u_32:_Update()
		end))
	end
end
function v_u_10._Setup(p42) -- name: _Setup
	-- upvalues: (copy) v_u_2
	p42._blur.Name = "DarkBlurryBackground"
	p42._blur.Parent = v_u_2
	p42._colorcorrection.Name = "DarkBlurryBackground"
	p42._colorcorrection.Parent = v_u_2
end
function v_u_10._Init(p_u_43) -- name: _Init
	-- upvalues: (copy) v_u_5, (copy) v_u_7, (copy) v_u_6
	v_u_5.DuelSubjectChanged:Connect(function()
		-- upvalues: (copy) p_u_43
		p_u_43:_VerifyClientDuel()
	end)
	v_u_7.PageSystem.PagesActivity:Connect(function()
		-- upvalues: (copy) p_u_43
		p_u_43:_Update()
	end)
	v_u_6.EditorEnabledChanged:Connect(function()
		-- upvalues: (copy) p_u_43
		p_u_43:_Update()
	end)
	p_u_43:_Setup()
	task.defer(p_u_43._Tween, p_u_43, false, nil, nil, true)
	task.defer(p_u_43._Update, p_u_43)
	task.defer(p_u_43._VerifyClientDuel, p_u_43)
end
return v_u_10._new()