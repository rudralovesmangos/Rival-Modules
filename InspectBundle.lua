local v1 = game:GetService("ReplicatedStorage")
local v2 = game:GetService("Players")
local v_u_3 = require(v1.Modules.MonetizationLibrary)
local v_u_4 = require(v2.LocalPlayer.PlayerScripts.Controllers:WaitForChild("MonetizationController"))
local v_u_5 = require(v2.LocalPlayer.PlayerScripts.Modules:WaitForChild("ButtonEffect"))
local v_u_6 = require(v2.LocalPlayer.PlayerScripts.Modules:WaitForChild("BundleSlot"))
local v_u_7 = require(v2.LocalPlayer.PlayerScripts.Modules:WaitForChild("Prompt"))
local v_u_8 = setmetatable({}, v_u_7)
v_u_8.__index = v_u_8
function v_u_8.new(p9) -- name: new
	-- upvalues: (copy) v_u_7, (copy) v_u_8, (copy) v_u_3, (copy) v_u_6
	local v10 = v_u_7.new(script.Name)
	local v11 = v_u_8
	local v12 = setmetatable(v10, v11)
	v12.Container = v12.PromptFrame:WaitForChild("Container")
	v12.ButtonsFrame = v12.PromptFrame:WaitForChild("Buttons")
	v12.ButtonsContainer = v12.ButtonsFrame:WaitForChild("Container")
	v12.CloseButton = v12.ButtonsContainer:WaitForChild("Close")
	v12.BuyButton = v12.ButtonsContainer:WaitForChild("Buy")
	v12.BuyButtonOwnedFrame = v12.BuyButton:WaitForChild("Owned")
	v12.BuyButtonReadyFrame = v12.BuyButton:WaitForChild("Ready")
	v12.BuyButtonReadyText = v12.BuyButtonReadyFrame:WaitForChild("Title")
	v12.BuyButtonReadyBubbleFrame = v12.BuyButtonReadyFrame:WaitForChild("Bubble")
	v12.BuyButtonReadyBubbleText = v12.BuyButtonReadyBubbleFrame:WaitForChild("Title")
	v12.Name = p9
	v12.Info = v_u_3.Bundles[v12.Name]
	v12._bundle_slot = v_u_6.new(v12.Name)
	v12:_Init()
	return v12
end
function v_u_8.Destroy(p13) -- name: Destroy
	-- upvalues: (copy) v_u_7
	p13._bundle_slot:Destroy()
	v_u_7.Destroy(p13)
end
function v_u_8._Update(p14) -- name: _Update
	if p14._bundle_slot:IsAlreadyOwned() then
		p14.BuyButton.Visible = true
		p14.BuyButtonReadyFrame.Visible = false
		p14.BuyButtonOwnedFrame.Visible = true
		return
	elseif p14._bundle_slot:IsAvailableToPurchase() then
		p14.BuyButton.Visible = true
		p14.BuyButtonReadyFrame.Visible = true
		p14.BuyButtonOwnedFrame.Visible = false
	else
		p14.BuyButton.Visible = false
		p14.BuyButtonReadyFrame.Visible = false
		p14.BuyButtonOwnedFrame.Visible = false
	end
end
function v_u_8._Setup(p15) -- name: _Setup
	-- upvalues: (copy) v_u_4
	p15.BuyButtonReadyBubbleText.RichText = true
	p15.BuyButtonReadyBubbleText.Text = p15.Info.BubbleText or ""
	p15.BuyButtonReadyBubbleFrame.Visible = p15.BuyButtonReadyBubbleText.Text ~= ""
	v_u_4:SetRobuxText(p15.BuyButtonReadyText, p15._bundle_slot:GetAssetIDForRobuxText(), p15._bundle_slot:GetInfoTypeForRobuxText())
	p15._bundle_slot:HideRobuxButton()
	p15._bundle_slot:SetAlwaysSpotlighted(true)
	p15._bundle_slot:SetSpotlightingInputsEnabled(false)
	p15._bundle_slot:SetParent(p15.Container)
	p15._bundle_slot:StartLoops()
end
function v_u_8._Init(p_u_16) -- name: _Init
	-- upvalues: (copy) v_u_5
	p_u_16.CloseButton.MouseButton1Click:Connect(function()
		-- upvalues: (copy) p_u_16
		p_u_16:CloseRequest()
	end)
	p_u_16.BuyButton.MouseButton1Click:Connect(function()
		-- upvalues: (copy) p_u_16
		p_u_16._bundle_slot:PurchaseRequest()
	end)
	p_u_16._bundle_slot.Tapped:Connect(function()
		-- upvalues: (copy) p_u_16
		p_u_16._bundle_slot:PurchaseRequest()
	end)
	p_u_16._bundle_slot.AvailabilityChanged:Connect(function()
		-- upvalues: (copy) p_u_16
		p_u_16:_Update()
	end)
	p_u_16._bundle_slot.OwnedChanged:Connect(function()
		-- upvalues: (copy) p_u_16
		p_u_16:_Update()
	end)
	p_u_16:_Setup()
	p_u_16:_Update()
	v_u_5:Add(p_u_16.BuyButton)
	v_u_5:Add(p_u_16.CloseButton)
end
return v_u_8