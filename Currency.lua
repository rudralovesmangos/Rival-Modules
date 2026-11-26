local v1 = game:GetService("ReplicatedStorage")
local v2 = game:GetService("Players")
require(v1.Modules.CurrencyLibrary)
local v_u_3 = require(v1.Modules.EventLibrary)
local v_u_4 = require(v2.LocalPlayer.PlayerScripts.Controllers.PlayerDataController)
local v_u_5 = {}
v_u_5.__index = v_u_5
function v_u_5.new(p6) -- name: new
	-- upvalues: (copy) v_u_5
	local v7 = v_u_5
	local v8 = setmetatable({}, v7)
	v8.Pages = p6
	v8.Frame = v8.Pages.Frame:WaitForChild("Currency")
	v8.Container = v8.Frame:WaitForChild("Container")
	v8.WeaponKeysFrame = v8.Container:WaitForChild("WeaponKeys")
	v8.EventCurrencyFrame = v8.Container:WaitForChild("EventCurrency")
	v8.EventCurrencyHeaderIcon = v8.EventCurrencyFrame:WaitForChild("Header"):WaitForChild("Icon")
	v8:_Init()
	return v8
end
function v_u_5.Open(_) -- name: Open end
function v_u_5.Close(_) -- name: Close end
function v_u_5.Setup(p9) -- name: Setup
	-- upvalues: (copy) v_u_3
	for v10 = 1, 5 do
		local v11 = "keybundle_" .. v10
		p9.Pages.Shop:CreateBundleSlot(v11):SetParent(p9.WeaponKeysFrame:WaitForChild(v11))
	end
	if v_u_3.IS_ACTIVE then
		for v12 = 1, 5 do
			local v13 = "eventcurrencybundle_" .. v12
			p9.Pages.Shop:CreateBundleSlot(v13):SetParent(p9.EventCurrencyFrame:WaitForChild(v13))
		end
	end
end
function v_u_5._UpdateEvent(p14) -- name: _UpdateEvent
	-- upvalues: (copy) v_u_3, (copy) v_u_4
	local v15 = v_u_3.IS_ACTIVE
	if v15 then
		v15 = v_u_4:GetStatistic("StatisticDuelsPlayed") >= v_u_3.NUM_GAMES_NEEDED_TO_PARTICIPATE
	end
	p14.EventCurrencyFrame.Visible = v15
	p14.Frame.Size = UDim2.new(1, 0, v15 and 2.35 or 1, 0)
end
function v_u_5._Setup(p16) -- name: _Setup
	-- upvalues: (copy) v_u_3
	p16.EventCurrencyHeaderIcon.Image = v_u_3.EVENT_DETAILS.CURRENCY_IMAGE_FLAT
end
function v_u_5._Init(p_u_17) -- name: _Init
	-- upvalues: (copy) v_u_4
	v_u_4:GetDataChangedSignal("StatisticDuelsPlayed"):Connect(function()
		-- upvalues: (copy) p_u_17
		p_u_17:_UpdateEvent()
	end)
	p_u_17:_Setup()
	p_u_17:_UpdateEvent()
end
return v_u_5