local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("TweenService")
local v_u_3 = game:GetService("GuiService")
local v4 = game:GetService("Players")
local v_u_5 = require(v1.Modules.CONSTANTS)
local v_u_6 = require(v1.Modules.CosmeticLibrary)
require(v1.Modules.EventLibrary)
local v_u_7 = require(v1.Modules.Utility)
local v_u_8 = require(v1.Modules.Signal)
local v_u_9 = require(v4.LocalPlayer.PlayerScripts.Controllers:WaitForChild("ComplianceController"))
local v_u_10 = require(v4.LocalPlayer.PlayerScripts.Controllers:WaitForChild("PlayerDataController"))
local v_u_11 = require(v4.LocalPlayer.PlayerScripts.Controllers:WaitForChild("ControlsController"))
local v_u_12 = require(v4.LocalPlayer.PlayerScripts.Controllers:WaitForChild("ShopController"))
local v_u_13 = require(v4.LocalPlayer.PlayerScripts.Modules.UserInterface:WaitForChild("Equipment"))
local v_u_14 = require(v4.LocalPlayer.PlayerScripts.Modules.UserInterface:WaitForChild("Spotlight"))
local v_u_15 = require(v4.LocalPlayer.PlayerScripts.Modules:WaitForChild("BaseShopSlot"):WaitForChild("ShopSlot"))
local v_u_16 = require(v4.LocalPlayer.PlayerScripts.Modules:WaitForChild("PromptSystem"))
local v_u_17 = require(v4.LocalPlayer.PlayerScripts.Modules:WaitForChild("BundleSlot"))
local v_u_18 = require(v4.LocalPlayer.PlayerScripts.Modules:WaitForChild("UILibrary"))
local v_u_19 = require(v4.LocalPlayer.PlayerScripts.Modules:WaitForChild("Page"))
local v_u_20 = require(script:WaitForChild("BottomTabs"))
local v_u_21 = require(script:WaitForChild("Pages"))
local v_u_22 = require(script:WaitForChild("Tabs"))
local v_u_23 = {
	"rpg_bundle",
	"energy_bundle",
	"starter_bundle",
	"medkit_bundle",
	"exogun_bundle",
	"heavyduty_bundle",
	"classic_bundle",
	"standardweapons_bundle"
}
local v_u_24 = {
	"Home",
	"Bundles",
	"Skins",
	"Daily",
	"Currency",
	"Ranked",
	"Rewards",
	"Gifting",
	"Weapons"
}
local v_u_25 = setmetatable({}, v_u_19)
v_u_25.__index = v_u_25
function v_u_25._new() -- name: _new
	-- upvalues: (copy) v_u_19, (copy) v_u_25, (copy) v_u_8, (copy) v_u_23, (copy) v_u_24, (copy) v_u_16, (copy) v_u_22, (copy) v_u_21, (copy) v_u_20
	local v26 = v_u_19.new(script.Name)
	local v27 = v_u_25
	local v28 = setmetatable(v26, v27)
	v28.CurrentPageChanged = v_u_8.new()
	v28.PageContainer = v28.PageFrame:WaitForChild("Container")
	v28.PromptsFrame = v28.PageContainer:WaitForChild("Prompts")
	v28.WaitingFrame = v28.PageContainer:WaitForChild("Waiting")
	v28.DotsFrame = v28.WaitingFrame:WaitForChild("Dots")
	v28.List = v28.PageContainer:WaitForChild("List")
	v28.Container = v28.List:WaitForChild("Container")
	v28.BUNDLE_NAMES = v_u_23
	v28.PAGE_NAMES = v_u_24
	v28.HidePartyDisplay = true
	v28.CurrentPage = nil
	v28.PromptSystem = v_u_16.new(v28.PromptsFrame)
	v28.Tabs = v_u_22.new(v28)
	v28.Pages = v_u_21.new(v28)
	v28.BottomTabs = v_u_20.new(v28)
	v28._open_animation_disabled = true
	v28._setup_finished = false
	v28._setup_finished_event_internal = v_u_8.new()
	v28._bundle_slots = {}
	v28:_Init()
	return v28
end
function v_u_25.SetPage(p29, p30) -- name: SetPage
	-- upvalues: (copy) v_u_14, (copy) v_u_13
	v_u_14:ChangeSubject(nil)
	if p30 == "Weapons" then
		v_u_13:Open(true)
		p29:CloseRequest()
		return
	elseif p30 == "Gifting" then
		p29.OpenPage:Fire("Gifting")
		return
	elseif p30 == "Rewards" then
		p29.OpenPage:Fire("Rewards")
		return
	elseif p30 == "BattlePass" then
		p29.OpenPage:Fire("BattlePass")
	else
		p29.CurrentPage = p30
		p29.CurrentPageChanged:Fire(p29.CurrentPage)
	end
end
function v_u_25.InspectSkinBundle(p_u_31, p_u_32) -- name: InspectSkinBundle
	p_u_31:SetPage("Skins")
	task.delay(0.5, function()
		-- upvalues: (copy) p_u_31, (copy) p_u_32
		p_u_31.Pages.Components.Skins:Inspect(p_u_32)
	end)
end
function v_u_25.InspectShopEntry(p33, p34) -- name: InspectShopEntry
	if p34 then
		p33.PromptSystem:Open("InspectShopEntry", p34)
	end
end
function v_u_25.InspectBundle(p_u_35, p_u_36, _) -- name: InspectBundle
	if p_u_36 then
		task.defer(function()
			-- upvalues: (copy) p_u_35, (copy) p_u_36
			if not p_u_35._setup_finished then
				p_u_35._setup_finished_event_internal:Wait()
			end
			p_u_35.PromptSystem:Open("InspectBundle", p_u_36)
		end)
	end
end
function v_u_25.CreateShopSlot(p_u_37, p38, p39, p40, ...) -- name: CreateShopSlot
	-- upvalues: (copy) v_u_7, (copy) v_u_12, (copy) v_u_15, (copy) v_u_6, (copy) v_u_9, (copy) v_u_5
	local v41 = v_u_7:CloneTable(v_u_12:GetShopEntry(p40))
	local v42 = p38 or v_u_15
	if p39 then
		p39.BackgroundTransparency = 1
	end
	for _, v43 in pairs(v41.Rewards) do
		local v44 = v_u_6.Rewards[v43.Name]
		if not v44 or (v44.Type ~= "Lootbox" or not v_u_9:ArePaidRandomItemsRestricted()) then
			continue
		end
		local _ = v_u_5.SHOW_LOOTBOX_CONTENTS_TO_RESTRICTED_PLAYERS
	end
	local v_u_45 = v42.new(v41, ...)
	v_u_45.Frame.Parent = p39
	v_u_45:OnClick(function()
		-- upvalues: (copy) v_u_45, (copy) p_u_37
		if not (v_u_45.IsLocked or v_u_45.IsOwned) then
			p_u_37:InspectShopEntry(v_u_45.ShopEntry.EntryName)
		end
	end)
	return v_u_45
end
function v_u_25.CreateBundleSlot(p_u_46, p47) -- name: CreateBundleSlot
	-- upvalues: (copy) v_u_17, (copy) v_u_11
	local v_u_48 = v_u_17.new(p47)
	p_u_46._bundle_slots[p47] = v_u_48
	v_u_48.Tapped:Connect(function()
		-- upvalues: (ref) v_u_11, (copy) p_u_46, (copy) v_u_48
		if v_u_11.CurrentControls == "Touch" then
			p_u_46:InspectBundle(v_u_48.Name)
		else
			v_u_48:PurchaseRequest()
		end
	end)
	return v_u_48
end
function v_u_25.Open(p49, ...) -- name: Open
	-- upvalues: (copy) v_u_19, (copy) v_u_7
	v_u_19.Open(p49, ...)
	p49.Tabs:Open()
	p49.Pages:Open()
	p49.BottomTabs:Open()
	v_u_7:CreateSound("rbxassetid://18100002432", 1.25, 1, script, true, 5)
end
function v_u_25.Close(p50, ...) -- name: Close
	-- upvalues: (copy) v_u_19
	v_u_19.Close(p50, ...)
	p50.Tabs:Close()
	p50.Pages:Close()
	p50.BottomTabs:Close()
end
function v_u_25._CheckScrollDownToLoginRewards(p_u_51) -- name: _CheckScrollDownToLoginRewards
	-- upvalues: (copy) v_u_10, (copy) v_u_2
	if p_u_51.CurrentPage == "Daily" and not v_u_10:Get("ClaimedLoginRewardToday") then
		local v_u_52 = p_u_51.Pages.Components.Daily.LoginRewards.Frame
		task.delay(0.15, function()
			-- upvalues: (ref) v_u_2, (copy) p_u_51, (copy) v_u_52
			v_u_2:Create(p_u_51.List, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
				["CanvasPosition"] = Vector2.new(0, v_u_52.AbsolutePosition.Y - p_u_51.Container.AbsolutePosition.Y)
			}):Play()
		end)
	end
end
function v_u_25._UpdatePromptContext(p53) -- name: _UpdatePromptContext
	p53.List.Visible = not p53.PromptSystem.CurrentPrompt
end
function v_u_25._UpdateScale(p54) -- name: _UpdateScale
	local v55 = p54.CurrentPage == "Home" and 0.9 or 1
	p54.List.Size = UDim2.new(1 / v55, 18, 1, 0)
	p54.Container.Size = UDim2.new(v55 * 1, -8, v55 * 1, -8)
end
function v_u_25._UpdateCanvasSize(p56) -- name: _UpdateCanvasSize
	-- upvalues: (copy) v_u_18
	local v57 = p56.Pages:GetComponentFrame(p56.CurrentPage)
	local v58 = p56.List
	local v59 = UDim2.new
	local v60 = p56.PageFrame.AbsoluteSize.Y
	local v61 = v_u_18.MainGui.AbsolutePosition.Y + v_u_18.MainGui.AbsoluteSize.Y - p56.List.AbsolutePosition.Y - 20
	v58.Size = v59(1, 18, 0, (math.min(v60, v61)))
	p56.List.CanvasSize = v57 and UDim2.new(0, 0, 0, v57.AbsolutePosition.Y + v57.AbsoluteSize.Y - p56.Container.AbsolutePosition.Y) or UDim2.new(0, 0, 0, 0)
end
function v_u_25._UpdateSize(p62) -- name: _UpdateSize
	-- upvalues: (copy) v_u_3
	p62.PageContainer.Size = UDim2.new(1, 0, 1, -v_u_3.TopbarInset.Height)
end
function v_u_25._Setup(p_u_63) -- name: _Setup
	p_u_63.DotsFrame:AddTag("UILoadingDots")
	p_u_63.WaitingFrame.Visible = true
	p_u_63.Tabs.Frame.Visible = false
	p_u_63.Pages.Frame.Visible = false
	p_u_63.BottomTabs.Frame.Visible = false
	task.delay(0.25, function()
		-- upvalues: (copy) p_u_63
		p_u_63.DotsFrame:RemoveTag("UILoadingDots")
		p_u_63.WaitingFrame.Visible = false
		p_u_63.Tabs.Frame.Visible = true
		p_u_63.Pages.Frame.Visible = true
		p_u_63.BottomTabs.Frame.Visible = true
		p_u_63.Tabs:Setup()
		p_u_63.Pages:Setup()
		p_u_63.BottomTabs:Setup()
		p_u_63:SetPage(p_u_63.CurrentPage or "Home")
		p_u_63._setup_finished = true
		p_u_63._setup_finished_event_internal:Fire()
	end)
end
function v_u_25._Init(p_u_64) -- name: _Init
	-- upvalues: (copy) v_u_14, (copy) v_u_18, (copy) v_u_3
	p_u_64.PromptSystem.PromptAdded:Connect(function(p65)
		-- upvalues: (copy) p_u_64
		p_u_64.List.CanvasPosition = Vector2.new(0, 0)
		p_u_64:_UpdatePromptContext()
		if p65.InspectCurrencyPage then
			p65.InspectCurrencyPage:Connect(function()
				-- upvalues: (ref) p_u_64
				p_u_64:SetPage("Currency")
			end)
		end
	end)
	p_u_64.PromptSystem.PromptRemoved:Connect(function()
		-- upvalues: (copy) p_u_64
		p_u_64:_UpdatePromptContext()
	end)
	p_u_64.OpenChanged:Connect(function()
		-- upvalues: (ref) v_u_14
		v_u_14:ChangeSubject(nil)
	end)
	p_u_64.CurrentPageChanged:Connect(function()
		-- upvalues: (copy) p_u_64
		p_u_64:_CheckScrollDownToLoginRewards()
		p_u_64:_UpdateCanvasSize()
		p_u_64:_UpdateScale()
	end)
	p_u_64.List:GetPropertyChangedSignal("AbsolutePosition"):Connect(function()
		-- upvalues: (copy) p_u_64
		p_u_64:_UpdateCanvasSize()
	end)
	p_u_64.PageFrame:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
		-- upvalues: (copy) p_u_64
		p_u_64:_UpdateCanvasSize()
	end)
	p_u_64.Container:GetPropertyChangedSignal("AbsolutePosition"):Connect(function()
		-- upvalues: (copy) p_u_64
		p_u_64:_UpdateCanvasSize()
	end)
	p_u_64.Pages.UpdateCanvasSize:Connect(function()
		-- upvalues: (copy) p_u_64
		p_u_64:_UpdateCanvasSize()
	end)
	v_u_18.MainGui:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
		-- upvalues: (copy) p_u_64
		p_u_64:_UpdateCanvasSize()
	end)
	v_u_18.MainGui:GetPropertyChangedSignal("AbsolutePosition"):Connect(function()
		-- upvalues: (copy) p_u_64
		p_u_64:_UpdateCanvasSize()
	end)
	v_u_3:GetPropertyChangedSignal("TopbarInset"):Connect(function()
		-- upvalues: (copy) p_u_64
		p_u_64:_UpdateSize()
	end)
	p_u_64:_Setup()
	p_u_64:_UpdateSize()
	p_u_64:_UpdateScale()
	p_u_64:_UpdateCanvasSize()
	p_u_64:_UpdatePromptContext()
end
return v_u_25._new()