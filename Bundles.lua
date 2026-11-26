local v1 = game:GetService("ReplicatedStorage")
local v2 = game:GetService("Players")
require(v1.Modules.Utility)
require(v2.LocalPlayer.PlayerScripts.Controllers.PlayerDataController)
local v_u_3 = {}
v_u_3.__index = v_u_3
function v_u_3.new(p4) -- name: new
	-- upvalues: (copy) v_u_3
	local v5 = v_u_3
	local v6 = setmetatable({}, v5)
	v6.Pages = p4
	v6.Frame = v6.Pages.Frame:WaitForChild("Bundles")
	v6.Container = v6.Frame:WaitForChild("Container")
	v6.PermanentFrame = v6.Container:WaitForChild("Permanent")
	v6.TimedFrame = v6.Container:WaitForChild("Timed")
	v6._is_open_hash = 0
	v6._superstarterbundle_slot = nil
	v6:_Init()
	return v6
end
function v_u_3.Open(p7) -- name: Open
	if p7._superstarterbundle_slot then
		p7._superstarterbundle_slot:StartLoops()
	end
end
function v_u_3.Close(p8) -- name: Close
	if p8._superstarterbundle_slot then
		p8._superstarterbundle_slot:StopLoops()
	end
end
function v_u_3.Setup(p9) -- name: Setup
	for _, v10 in pairs(p9.Pages.Shop.BUNDLE_NAMES) do
		p9.Pages.Shop:CreateBundleSlot(v10):SetParent(p9.PermanentFrame:WaitForChild(v10))
	end
	p9:_SetupSuperStarterBundleSlot()
end
function v_u_3._SetupSuperStarterBundleSlot(p_u_11) -- name: _SetupSuperStarterBundleSlot
	p_u_11._superstarterbundle_slot = p_u_11.Pages.Shop:CreateBundleSlot("superstarter_bundle")
	p_u_11._superstarterbundle_slot:SetParent(p_u_11.TimedFrame:WaitForChild("superstarter_bundle"))
	p_u_11._superstarterbundle_slot.AvailabilityChanged:Connect(function() -- name: update
		-- upvalues: (copy) p_u_11
		p_u_11.TimedFrame.Visible = p_u_11._superstarterbundle_slot:IsAvailableToPurchase()
	end)
	p_u_11.TimedFrame.Visible = p_u_11._superstarterbundle_slot:IsAvailableToPurchase()
	if p_u_11.Pages.Shop:IsOpen() then
		p_u_11._superstarterbundle_slot:StartLoops()
	end
end
function v_u_3._Init(_) -- name: _Init end
return v_u_3