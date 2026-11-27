local v_u_1 = game:GetService("GuiService")
local v2 = game:GetService("Players")
local v_u_3 = require(v2.LocalPlayer.PlayerScripts.Controllers:WaitForChild("SpectateController"))
local v_u_4 = require(v2.LocalPlayer.PlayerScripts.Modules.UserInterface:WaitForChild("Pages"))
local v_u_5 = require(v2.LocalPlayer.PlayerScripts.Modules:WaitForChild("GlowyBackground"))
local v_u_6 = require(v2.LocalPlayer.PlayerScripts.Modules:WaitForChild("UILibrary"))
local v_u_7 = {}
v_u_7.__index = v_u_7
function v_u_7._new() -- name: _new
	-- upvalues: (copy) v_u_7, (copy) v_u_6, (copy) v_u_5
	local v8 = v_u_7
	local v9 = setmetatable({}, v8)
	v9.Frame = v_u_6:GetTo("MainFrame", "MainGlowyBackground")
	v9._glowy_background = v_u_5.new("MainGui")
	v9._current_duel_subject = nil
	v9._current_duel_subject_connections = {}
	v9:_Init()
	return v9
end
function v_u_7._Update(p10) -- name: _Update
	-- upvalues: (copy) v_u_4, (copy) v_u_1
	local v11 = p10._current_duel_subject and p10._current_duel_subject.DuelInterface
	if v11 then
		v11 = p10._current_duel_subject.DuelInterface.Voting:IsOpen()
	end
	p10._glowy_background:SetBackdropTransparency(v11 and 0 or 1)
	p10._glowy_background:SetEnabled(v_u_4.PageSystem.CurrentPage and not v_u_4.PageSystem.CurrentPage.DisableGlowyBackground or (v_u_1.MenuIsOpen or v11))
	p10._glowy_background:SetBlurEnabled(not v_u_1.MenuIsOpen)
end
function v_u_7._UpdateClientDuelSubject(p_u_12) -- name: _UpdateClientDuelSubject
	-- upvalues: (copy) v_u_3
	for _, v13 in pairs(p_u_12._current_duel_subject_connections) do
		v13:Disconnect()
	end
	p_u_12._current_duel_subject_connections = {}
	p_u_12._current_duel_subject = nil
	if v_u_3.CurrentDuelSubject then
		p_u_12._current_duel_subject = v_u_3.CurrentDuelSubject
		local v14 = p_u_12._current_duel_subject_connections
		local v15 = p_u_12._current_duel_subject.DuelInterface.Voting.VisibilityChanged
		table.insert(v14, v15:Connect(function()
			-- upvalues: (copy) p_u_12
			p_u_12:_Update()
		end))
		p_u_12:_Update()
	else
		p_u_12:_Update()
	end
end
function v_u_7._Setup(p16) -- name: _Setup
	p16._glowy_background:SetParent(p16.Frame)
end
function v_u_7._Init(p_u_17) -- name: _Init
	-- upvalues: (copy) v_u_4, (copy) v_u_1, (copy) v_u_3
	v_u_4.PageSystem.PagesActivity:Connect(function()
		-- upvalues: (copy) p_u_17
		p_u_17:_Update()
	end)
	v_u_1:GetPropertyChangedSignal("MenuIsOpen"):Connect(function()
		-- upvalues: (copy) p_u_17
		p_u_17:_Update()
	end)
	v_u_3.DuelSubjectChanged:Connect(function()
		-- upvalues: (copy) p_u_17
		p_u_17:_UpdateClientDuelSubject()
	end)
	p_u_17:_Setup()
	task.defer(p_u_17._Update, p_u_17)
	task.defer(p_u_17._UpdateClientDuelSubject, p_u_17)
end
return v_u_7._new()