local v_u_1 = game:GetService("GuiService")
local v2 = game:GetService("Players")
local v_u_3 = require(v2.LocalPlayer.PlayerScripts.Modules.UserInterface.Pages)
local v_u_4 = require(v2.LocalPlayer.PlayerScripts.Modules.UILibrary)
local v_u_5 = require(script:WaitForChild("Customize"))
local v_u_6 = require(script:WaitForChild("Right"))
local v_u_7 = require(script:WaitForChild("Left"))
local v_u_8 = {}
v_u_8.__index = v_u_8
function v_u_8.new(p9) -- name: new
	-- upvalues: (copy) v_u_8, (copy) v_u_4, (copy) v_u_5, (copy) v_u_6, (copy) v_u_7
	local v10 = v_u_8
	local v11 = setmetatable({}, v10)
	v11.Equipment = p9
	v11.Frame = v_u_4:GetTo("MainFrame", "Equipment")
	v11.Customize = v_u_5.new(v11)
	v11.Right = v_u_6.new(v11)
	v11.Left = v_u_7.new(v11)
	v11:_Init()
	return v11
end
function v_u_8.OnCustomizingStateChanged(p12, ...) -- name: OnCustomizingStateChanged
	p12.Customize:OnCustomizingStateChanged(...)
end
function v_u_8.OnStateChanged(p13, ...) -- name: OnStateChanged
	p13.Right:OnStateChanged(...)
	p13.Left:OnStateChanged(...)
	p13.Customize:OnStateChanged(...)
end
function v_u_8.OnOpen(p14, ...) -- name: OnOpen
	p14.Right:OnOpen(...)
	p14.Left:OnOpen(...)
	p14:_UpdateComponentsVisibility()
end
function v_u_8.Update(p15, ...) -- name: Update
	p15.Left:Update(...)
end
function v_u_8._UpdateComponentsVisibility(p16) -- name: _UpdateComponentsVisibility
	-- upvalues: (copy) v_u_3, (copy) v_u_1
	local v17 = p16.Equipment.IsOpen and (p16.Equipment:IsOpenEffectDone() and not (p16.Equipment:IsUnlocking() or v_u_3.PageSystem.CurrentPage))
	if v17 then
		v17 = not v_u_1.MenuIsOpen
	end
	local v18 = p16.Equipment:IsCustomizing()
	local v19 = p16.Right
	local v20
	if v17 then
		local v21 = not v18
		v20 = v21 and true or v21
	else
		v20 = v17
	end
	v19:SetVisible(v20)
	local v22 = p16.Left
	local v23
	if v17 then
		local v24 = not v18
		v23 = v24 and true or v24
	else
		v23 = v17
	end
	v22:SetVisible(v23)
	local v25 = p16.Customize
	if v17 then
		v17 = v18 and true or v18
	end
	v25:SetVisible(v17)
end
function v_u_8._Init(p_u_26) -- name: _Init
	-- upvalues: (copy) v_u_3, (copy) v_u_1
	p_u_26.Equipment.CustomizingChanged:Connect(function()
		-- upvalues: (copy) p_u_26
		p_u_26:_UpdateComponentsVisibility()
	end)
	p_u_26.Equipment.UnlockingChanged:Connect(function()
		-- upvalues: (copy) p_u_26
		p_u_26:_UpdateComponentsVisibility()
	end)
	p_u_26.Equipment.FinishedOpenEffect:Connect(function()
		-- upvalues: (copy) p_u_26
		p_u_26:_UpdateComponentsVisibility()
	end)
	p_u_26.Equipment.SpinControls.MouseDownChanged:Connect(function()
		-- upvalues: (copy) p_u_26
		p_u_26:_UpdateComponentsVisibility()
	end)
	v_u_3.PageSystem.PagesActivity:Connect(function()
		-- upvalues: (copy) p_u_26
		p_u_26:_UpdateComponentsVisibility()
	end)
	v_u_1:GetPropertyChangedSignal("MenuIsOpen"):Connect(function()
		-- upvalues: (copy) p_u_26
		p_u_26:_UpdateComponentsVisibility()
	end)
	p_u_26:_UpdateComponentsVisibility()
end
return v_u_8