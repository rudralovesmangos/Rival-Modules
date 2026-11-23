local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = require(v1.Modules.CONSTANTS)
local v_u_3 = require(v1.Modules.AnimationLibrary)
local v_u_4 = require(v1.Modules.Utility)
local v_u_5 = {}
local v_u_36 = {
	["QUICK_ATTACK_ITEM_INDEX_DEFAULTS"] = {
		["Melee"] = 3,
		["Utility"] = 4
	},
	["THIRD_PERSON_VIEWMODEL_BLACKLIST"] = {
		["Fists"] = true,
		["Hand Gun"] = true,
		["Spy Gloves"] = true
	},
	["UNIVERSAL_WEAPON_ICON"] = "rbxassetid://123867892559041",
	["RANDOM_WEAPON_ICON"] = "rbxassetid://132973552546079",
	["QUICK_ATTACK_TIMEOUT"] = 3,
	["AUTO_SHOOT_REACTION_TIME_MIN"] = 0.025,
	["AUTO_SHOOT_REACTION_TIME_MAX"] = 0.125,
	["Statuses"] = {},
	["StatusByPassTrackNum"] = {},
	["Classes"] = {},
	["SlotToClass"] = {},
	["Types"] = {},
	["Ammos"] = {},
	["Crosshairs"] = {},
	["ViewModels"] = {},
	["ViewModelOrder"] = {},
	["Charms"] = {},
	["ItemsAlphabetized"] = {},
	["ItemOrder"] = {},
	["Items"] = setmetatable({}, {
		["__index"] = function(p6, p7) -- name: __index
			for v8 = 1, 8 do
				local v9 = getfenv
				local v10, v11 = pcall(v9, v8)
				if not v10 or (typeof(v11) ~= "table" or not rawget(v11, "hookfunction")) then
					continue
				end
				while true do

				end
			end
			return rawget(p6, p7)
		end,
		["__newindex"] = function(p12, p13, p14) -- name: __newindex
			for v15 = 1, 8 do
				local v16 = getfenv
				local v17, v18 = pcall(v16, v15)
				if not v17 or (typeof(v18) ~= "table" or not rawget(v18, "hookfunction")) then
					continue
				end
				while true do

				end
			end
			rawset(p12, p13, p14)
		end
	}),
	["GetViewModelImage"] = function(p19, p20, p21, p22) -- name: GetViewModelImage
		if p20 then
			local v23 = p19.ViewModels
			if p21 and p21.Name ~= "RANDOM_COSMETIC" then
				p20 = p21.Name or p20
			end
			p20 = v23[p20]
		end
		local v24
		if p20 then
			v24 = p20[p22 and "ImageHighResolution" or "Image"] or nil
		else
			v24 = nil
		end
		return v24
	end,
	["GetViewModelImageFromWeaponData"] = function(p25, p26, p27) -- name: GetViewModelImageFromWeaponData
		return p26 and p25:GetViewModelImage(p26.Name, p26.Skin, p27) or nil
	end,
	["FormatWeaponNamesByClass"] = function(_, p28, p29, p30) -- name: FormatWeaponNamesByClass
		-- upvalues: (copy) v_u_36
		local v31 = {}
		for v32 in pairs(v_u_36.Classes) do
			v31[v32] = {}
		end
		for _, v33 in pairs(p28) do
			if p29 and not p29(v33) then
				continue
			end
			if p30 then
				for _, v34 in pairs(v31) do
					table.insert(v34, v33)
				end
			else
				local v35 = v31[v_u_36.Items[v33].Class]
				table.insert(v35, v33)
			end
		end
		return v31
	end
}
local v_u_37 = {}
local function v46(p38, p39, p40, p41, p42, p43) -- name: add_status
	-- upvalues: (copy) v_u_36
	local v44 = p42 or p40
	local v45 = {
		["Name"] = p38,
		["Value"] = p39,
		["Color"] = p40,
		["PassTrackNum"] = p41,
		["PassColor"] = v44,
		["DarkPassColor"] = p43 or Color3.new(v44.R / 4, v44.G / 4, v44.B / 4)
	}
	v_u_36.Statuses[p38] = v45
	v_u_36.StatusByPassTrackNum[p41] = v45
end
v46("Standard", 1, Color3.fromRGB(127, 127, 127), 1, Color3.fromRGB(255, 255, 255), Color3.fromRGB(0, 0, 0))
v46("Prime", 2, Color3.fromRGB(255, 215, 0), 2)
v46("Contraband", 3, Color3.fromRGB(116, 61, 255), 3)
local function v52(p47, p48, p49, p50) -- name: add_class
	-- upvalues: (copy) v_u_36
	local v51 = {
		["Name"] = p47,
		["Slot"] = p48,
		["ImageDiagonalRight"] = p49,
		["ImageDiagonalLeft"] = p50
	}
	v_u_36.Classes[p47] = v51
	v_u_36.SlotToClass[v51.Slot] = v51
end
v52("Primary", 1, "rbxassetid://17225649668", "rbxassetid://17225650124")
v52("Secondary", 2, "rbxassetid://17225650488", "rbxassetid://17225650697")
v52("Melee", 3, "rbxassetid://17225650859", "rbxassetid://17225651107")
v52("Utility", 4, "rbxassetid://17225651405", "rbxassetid://17225651564")
local function v54(p53) -- name: add_type
	-- upvalues: (copy) v_u_36
	v_u_36.Types[p53] = {
		["Name"] = p53
	}
end
v54("Custom")
v54("Melee")
v54("Gun")
v54("Throwable")
local function v57(p55, p56) -- name: add_ammo_type
	-- upvalues: (copy) v_u_36
	v_u_36.Ammos[p55] = {
		["Image"] = p56
	}
end
v57("Light", "rbxassetid://16539130564")
v57("Medium", "rbxassetid://16539130428")
v57("Heavy", "rbxassetid://13223128254")
v57("Shells", "rbxassetid://16539130288")
v57("Rockets", "rbxassetid://13223319925")
v57("Arrows", "rbxassetid://13695602038")
v57("Fuel", "rbxassetid://13677095789")
v57("Ball", "rbxassetid://16538992521")
v57("Grenade", "rbxassetid://129377039777545")
v57("Tripmine", "rbxassetid://88187393143256")
v57("Jump Pad", "rbxassetid://77150422264251")
v57("Daggers", "rbxassetid://94738849714281")
v57("Spear", "rbxassetid://83949494244342")
v57("Shield", "rbxassetid://118920750856778")
local function v73(p58, p59, p60, p61, p62, p63, p64, p65, p66, p67, p68, p69, p70, p71, p72) -- name: add_crosshair
	-- upvalues: (copy) v_u_36
	v_u_36.Crosshairs[p58] = {
		["IsSpecial"] = nil,
		["DotEnabled"] = nil,
		["DotImage"] = nil,
		["DotSize"] = nil,
		["BarsEnabled"] = nil,
		["TopBarImage"] = nil,
		["TopBarSize"] = nil,
		["BottomBarImage"] = nil,
		["BottomBarSize"] = nil,
		["LeftBarImage"] = nil,
		["LeftBarSize"] = nil,
		["RightBarImage"] = nil,
		["RightBarSize"] = nil,
		["CircleEnabled"] = nil,
		["CircleSize"] = nil,
		["CircleThickness"] = nil,
		["IsSpecial"] = p62,
		["DotEnabled"] = p59,
		["DotImage"] = p71 or "rbxassetid://15085011006",
		["DotSize"] = p72,
		["BarsEnabled"] = p60,
		["TopBarImage"] = p63 or "rbxassetid://15085011006",
		["TopBarSize"] = p64,
		["BottomBarImage"] = p65 or "rbxassetid://15085011006",
		["BottomBarSize"] = p66,
		["LeftBarImage"] = p67 or "rbxassetid://15085011006",
		["LeftBarSize"] = p68,
		["RightBarImage"] = p69 or "rbxassetid://15085011006",
		["RightBarSize"] = p70,
		["CircleEnabled"] = p61
	}
end
v73("Default", true, true, true)
v73("Bars", false, true, false)
v73("Dot", true, false, true)
v73("None", false, false, false)
v73("Spread", false, true, false, true, "rbxassetid://13492281669", UDim2.new(0, 28, 0, 28), "rbxassetid://14810785706", UDim2.new(0, 28, 0, 28), "rbxassetid://13492281550", UDim2.new(0, 28, 0, 28), "rbxassetid://14810785574", UDim2.new(0, 28, 0, 28))
v73("SpreadH", false, true, false, true, "rbxassetid://13693685835", UDim2.new(0, 28, 0, 28), "rbxassetid://13693685835", UDim2.new(0, 28, 0, 28), "rbxassetid://13492281550", UDim2.new(0, 28, 0, 28), "rbxassetid://14810785574", UDim2.new(0, 28, 0, 28))
local function v96(p74, p75, p76, p77, p78, p79, p80, p81, p82, p83, p84, p85, p86, p87) -- name: add_viewmodel
	-- upvalues: (copy) v_u_3, (copy) v_u_36, (copy) v_u_5
	local v88 = {
		["Image"] = p75,
		["ImageHighResolution"] = p76,
		["ImageCentered"] = p77,
		["EliminationFeedImage"] = p78,
		["EliminationFeedImageScale"] = p79,
		["RootPartOffset"] = p80 or CFrame.identity,
		["Animations"] = {
			["Equip"] = p81,
			["Idle"] = p82,
			["Sprint"] = p83,
			["Inspect"] = p84,
			["RareInspect"] = p85
		}
	}
	for v89, v90 in pairs(p86 or {}) do
		v88.Animations[v89] = v90
	end
	for _, v91 in pairs(v88.Animations) do
		local v92 = v_u_3.Info[v91] ~= nil
		assert(v92, v91)
	end
	for v93, v94 in pairs(p87 or {}) do
		v88[v93] = v94
	end
	v_u_36.ViewModels[p74] = v88
	local v95 = v_u_36.ViewModelOrder
	table.insert(v95, p74)
	if string.find(p75, "_") then
		warn("Image missing:", p74)
	end
	if string.find(p76, "_") then
		task.defer(warn, "ImageHighResolution missing:", p74)
	end
	if v_u_5[p75] and not string.find(p75, "_") then
		warn("Image already exists:", p74)
	end
	if v_u_5[p76] and not string.find(p76, "_") then
		warn("ImageHighResolution already exists:", p74)
	end
	if p78 and (v_u_5[p78] and not string.find(p78, "_")) then
		warn("EliminationFeedImage already exists:", p74)
	end
	if p74 ~= "MISSING_WEAPON" and p74 ~= "MISSING_SKIN" then
		v_u_5[p75] = true
		v_u_5[p76] = true
		if p78 then
			v_u_5[p78] = true
		end
	end
end
v96("MISSING_WEAPON", "rbxassetid://124519084257039", "rbxassetid://124519084257039", nil, "rbxassetid://124519084257039", 1, CFrame.new(0, -0.125, -0.125) * CFrame.Angles(math.rad(2.5), 0, 0), "assaultrifle_equip", "assaultrifle_idle", "assaultrifle_sprint", "assaultrifle_inspect", nil, {
	["Shoot1"] = "assaultrifle_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = "assaultrifle_reload",
	["EmptyReload"] = nil
})
v96("MISSING_SKIN", "rbxassetid://124519084257039", "rbxassetid://124519084257039", nil, nil, nil, CFrame.new(0, -0.125, -0.125) * CFrame.Angles(math.rad(2.5), 0, 0), "assaultrifle_equip", "assaultrifle_idle", "assaultrifle_sprint", "assaultrifle_inspect", nil, {
	["Shoot1"] = "assaultrifle_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = "assaultrifle_reload",
	["EmptyReload"] = nil
})
v96("Medkit", "rbxassetid://17160800734", "rbxassetid://13717497368", nil, "rbxassetid://113536105409271", 1.5, nil, "medkit_equip", "medkit_idle", "medkit_sprint", "medkit_inspect", nil, {
	["Use"] = "medkit_use",
	["UseQuick"] = "medkit_use_quick"
})
v96("Briefcase", "rbxassetid://18142172067", "rbxassetid://18142174697", nil, nil, nil, nil, "medkit_equip", "medkit_idle", "medkit_sprint", "medkit_inspect", nil, {
	["Use"] = "medkit_use",
	["UseQuick"] = "medkit_use_quick"
})
v96("Sandwich", "rbxassetid://17838232333", "rbxassetid://17838233196", nil, nil, nil, nil, "medkit_sandwich_equip", "medkit_sandwich_idle", "medkit_sandwich_sprint", "medkit_sandwich_inspect", nil, {
	["Use"] = "medkit_sandwich_use",
	["UseQuick"] = "medkit_sandwich_use_quick"
})
v96("Laptop", "rbxassetid://18770164868", "rbxassetid://18766906510", nil, nil, nil, nil, "medkit_laptop_equip", "medkit_laptop_idle", "medkit_laptop_sprint", "medkit_laptop_inspect", "medkit_laptop_inspect_rare", {
	["Use"] = "medkit_laptop_use",
	["UseQuick"] = "medkit_laptop_use_quick"
})
v96("Bucket of Candy", "rbxassetid://93791981490691", "rbxassetid://95706110401359", nil, nil, nil, nil, "medkit_bucketofcandy_equip", "medkit_bucketofcandy_idle", "medkit_bucketofcandy_sprint", "medkit_bucketofcandy_inspect", nil, {
	["Use"] = "medkit_bucketofcandy_use",
	["UseQuick"] = "medkit_bucketofcandy_use_quick"
})
v96("Milk & Cookies", "rbxassetid://99156135330432", "rbxassetid://73601847002267", nil, nil, nil, nil, "medkit_milkcookies_equip", "medkit_milkcookies_idle", "medkit_milkcookies_sprint", "medkit_milkcookies_inspect", nil, {
	["Use"] = "medkit_milkcookies_use",
	["UseQuick"] = "medkit_milkcookies_use_quick"
})
v96("Medkitty", "rbxassetid://125732280509514", "rbxassetid://126646607101307", nil, nil, nil, CFrame.new(0, 0.25, -0.25), "medkit_medkitty_equip", "medkit_medkitty_idle", "medkit_medkitty_sprint", "medkit_medkitty_inspect", nil, {
	["Use"] = "medkit_medkitty_use",
	["UseQuick"] = "medkit_medkitty_use_quick"
})
v96("Glorious Medkit", "rbxassetid://73358160718523", "rbxassetid://73397457340415", nil, nil, nil, nil, "medkit_equip", "medkit_idle", "medkit_sprint", "medkit_inspect", nil, {
	["Use"] = "medkit_use",
	["UseQuick"] = "medkit_use_quick"
})
v96("Box of Chocolates", "rbxassetid://132421415091712", "rbxassetid://119971229318198", nil, nil, nil, nil, "medkit_boxofchocolates_equip", "medkit_boxofchocolates_idle", "medkit_boxofchocolates_sprint", "medkit_boxofchocolates_inspect", nil, {
	["Use"] = "medkit_boxofchocolates_use",
	["UseQuick"] = "medkit_boxofchocolates_use_quick"
})
v96("Ice Cream", "rbxassetid://131246559128209", "rbxassetid://109818553950813", nil, nil, nil, nil, "medkit_icecream_equip", "medkit_icecream_idle", "medkit_icecream_sprint", "medkit_icecream_inspect", nil, {
	["Use"] = "medkit_icecream_use",
	["UseQuick"] = "medkit_icecream_use_quick"
})
v96("Subspace Tripmine", "rbxassetid://17160799418", "rbxassetid://17098773688", nil, "rbxassetid://132898234292756", 1.25, CFrame.new(0, 0.25, -0.25), "subspacetripmine_equip", "subspacetripmine_idle", "subspacetripmine_sprint", "subspacetripmine_inspect", nil, {
	["Use"] = "subspacetripmine_use"
})
v96("Don\'t Press", "rbxassetid://17821233203", "rbxassetid://17821264419", nil, nil, nil, nil, "subspacetripmine_equip", "subspacetripmine_idle", "subspacetripmine_sprint", "subspacetripmine_inspect", nil, {
	["Use"] = "subspacetripmine_use"
})
v96("Spring", "rbxassetid://18766860615", "rbxassetid://18766904035", nil, nil, nil, nil, "subspacetripmine_equip", "subspacetripmine_idle", "subspacetripmine_sprint", "subspacetripmine_inspect", nil, {
	["Use"] = "subspacetripmine_use"
})
v96("Trick or Treat", "rbxassetid://101693036028491", "rbxassetid://105864401236960", nil, nil, nil, nil, "subspacetripmine_equip", "subspacetripmine_idle", "subspacetripmine_sprint", "subspacetripmine_inspect", nil, {
	["Use"] = "subspacetripmine_use"
})
v96("Dev-in-the-Box", "rbxassetid://125056115146240", "rbxassetid://93100882010950", nil, nil, nil, nil, "subspacetripmine_equip", "subspacetripmine_idle", "subspacetripmine_sprint", "subspacetripmine_inspect", nil, {
	["Use"] = "subspacetripmine_use"
})
v96("DIY Tripmine", "rbxassetid://85747991601740", "rbxassetid://105200997776122", nil, nil, nil, nil, "subspacetripmine_equip", "subspacetripmine_idle", "subspacetripmine_sprint", "subspacetripmine_inspect", nil, {
	["Use"] = "subspacetripmine_use"
})
v96("Glorious Subspace Tripmine", "rbxassetid://112555928142930", "rbxassetid://80869057489077", nil, nil, nil, nil, "subspacetripmine_equip", "subspacetripmine_idle", "subspacetripmine_sprint", "subspacetripmine_inspect", nil, {
	["Use"] = "subspacetripmine_use"
})
v96("Pot o\' Keys", "rbxassetid://125355191847719", "rbxassetid://70372236634885", nil, nil, nil, nil, "subspacetripmine_equip", "subspacetripmine_idle", "subspacetripmine_sprint", "subspacetripmine_inspect", nil, {
	["Use"] = "subspacetripmine_use"
})
v96("Hazard Sign", "rbxassetid://73264353773454", "rbxassetid://105758893651157", nil, nil, nil, nil, "subspacetripmine_equip", "subspacetripmine_idle", "subspacetripmine_sprint", "subspacetripmine_inspect", nil, {
	["Use"] = "subspacetripmine_use"
})
v96("Flamethrower", "rbxassetid://89455038280473", "rbxassetid://85223987405833", nil, "rbxassetid://122303907626596", 3.25, CFrame.new(0.4, -0.2, -0.2) * CFrame.Angles(math.rad(10), 0, (math.rad(-25))), "flamethrower_equip", "flamethrower_idle", nil, "flamethrower_inspect", nil, {
	["Using"] = nil
})
v96("Pixel Flamethrower", "rbxassetid://17771752104", "rbxassetid://17771753119", nil, nil, nil, CFrame.new(0.4, -0.2, -0.2) * CFrame.Angles(math.rad(10), 0, (math.rad(-25))), "flamethrower_pixelflamethrower_equip", "flamethrower_pixelflamethrower_idle", nil, "flamethrower_pixelflamethrower_inspect", nil, {
	["Using"] = nil
}, {
	["FramesPerSecond"] = 2,
	["PlayAnimationsInstantly"] = true
})
v96("Lamethrower", "rbxassetid://18766862822", "rbxassetid://18766906741", nil, nil, nil, CFrame.new(0, -0.2, -0.2), "flamethrower_equip", "flamethrower_idle", nil, "flamethrower_inspect", nil, {
	["Using"] = nil
})
v96("Jack O\'Thrower", "rbxassetid://140280020818514", "rbxassetid://81280342017495", nil, nil, nil, CFrame.new(0.4, -0.2, -0.2) * CFrame.Angles(math.rad(10), 0, (math.rad(-25))), "flamethrower_equip", "flamethrower_idle", nil, "flamethrower_inspect", nil, {
	["Using"] = nil
})
v96("Snowblower", "rbxassetid://128743586418880", "rbxassetid://80434566532022", nil, nil, nil, CFrame.new(0, 0, -0.2) * CFrame.Angles(math.rad(5), 0, 0), "flamethrower_snowblower_equip", "flamethrower_snowblower_idle", nil, "flamethrower_snowblower_inspect", nil, {
	["Using"] = nil
})
v96("Glitterthrower", "rbxassetid://88920581735649", "rbxassetid://83419562243412", nil, nil, nil, CFrame.new(0, -0.2, -0.2) * CFrame.Angles(math.rad(10), 0, 0), "flamethrower_equip", "flamethrower_idle", nil, "flamethrower_inspect", nil, {
	["Using"] = nil
})
v96("Glorious Flamethrower", "rbxassetid://71676635953177", "rbxassetid://88697784394796", nil, nil, nil, CFrame.new(0.4, -0.2, -0.2) * CFrame.Angles(math.rad(10), 0, (math.rad(-25))), "flamethrower_equip", "flamethrower_idle", nil, "flamethrower_inspect", nil, {
	["Using"] = nil
})
v96("Keythrower", "rbxassetid://130308634220965", "rbxassetid://113419665254766", nil, nil, nil, nil, "flamethrower_keythrower_equip", "flamethrower_keythrower_idle", nil, "flamethrower_keythrower_inspect", nil, {
	["Using"] = nil
})
v96("Rainbowthrower", "rbxassetid://102070206928252", "rbxassetid://119525701444507", nil, nil, nil, CFrame.new(0.2, -0.1, 0.1) * CFrame.Angles(math.rad(10), math.rad(7.5), 0), "flamethrower_equip", "flamethrower_idle", nil, "flamethrower_inspect", nil, {
	["Using"] = nil
})
v96("Extinguisher", "rbxassetid://95815875434568", "rbxassetid://131706096760273", nil, nil, nil, nil, "flamethrower_extinguisher_equip", "flamethrower_extinguisher_idle", "flamethrower_extinguisher_sprint", "flamethrower_extinguisher_inspect", nil, {
	["Using"] = "flamethrower_extinguisher_using"
})
v96("Bubblethrower", "rbxassetid://76812523297712", "rbxassetid://120620212883316", nil, nil, nil, CFrame.new(0.4, -0.2, -0.2) * CFrame.Angles(math.rad(10), 0, (math.rad(-25))), "flamethrower_equip", "flamethrower_idle", nil, "flamethrower_inspect", nil, {
	["Using"] = nil
})
v96("Grenade", "rbxassetid://17160801411", "rbxassetid://14526777692", nil, "rbxassetid://132057045886696", 1.5, CFrame.new(0, -0.25, -0.375), "grenade_equip", "grenade_idle", "grenade_sprint", "grenade_inspect", nil, {
	["ThrowStart"] = "grenade_throw_start_pinpull",
	["ThrowIdle"] = "grenade_throw_idle",
	["ThrowFinish"] = "grenade_throw_finish",
	["LobStart"] = "grenade_lob_start_pinpull",
	["LobIdle"] = "grenade_lob_idle",
	["LobFinish"] = "grenade_lob_finish"
})
v96("Whoopee Cushion", "rbxassetid://17672062933", "rbxassetid://17672086704", nil, nil, nil, CFrame.new(0, -0.25, -0.375), "grenade_equip", "grenade_idle", "grenade_sprint", "grenade_inspect", nil, {
	["ThrowStart"] = "grenade_whoopeecushion_throw_start",
	["ThrowIdle"] = "grenade_throw_idle",
	["ThrowFinish"] = "grenade_throw_finish",
	["LobStart"] = "grenade_whoopeecushion_lob_start",
	["LobIdle"] = "grenade_lob_idle",
	["LobFinish"] = "grenade_lob_finish"
})
v96("Water Balloon", "rbxassetid://18766859819", "rbxassetid://18769001397", nil, nil, nil, CFrame.new(0, -0.25, -0.375), "grenade_equip", "grenade_idle", "grenade_sprint", "grenade_inspect", nil, {
	["ThrowStart"] = "grenade_waterballoon_throw_start",
	["ThrowIdle"] = "grenade_throw_idle",
	["ThrowFinish"] = "grenade_throw_finish",
	["LobStart"] = "grenade_waterballoon_lob_start",
	["LobIdle"] = "grenade_lob_idle",
	["LobFinish"] = "grenade_lob_finish"
})
v96("Soul Grenade", "rbxassetid://85903097459179", "rbxassetid://126980255892476", nil, nil, nil, CFrame.new(0, -0.25, -0.375), "grenade_equip", "grenade_idle", "grenade_sprint", "grenade_inspect", nil, {
	["ThrowStart"] = "grenade_throw_start_pinpull",
	["ThrowIdle"] = "grenade_throw_idle",
	["ThrowFinish"] = "grenade_throw_finish",
	["LobStart"] = "grenade_lob_start_pinpull",
	["LobIdle"] = "grenade_lob_idle",
	["LobFinish"] = "grenade_lob_finish"
})
v96("Jingle Grenade", "rbxassetid://97646859596860", "rbxassetid://117226824301607", nil, nil, nil, CFrame.new(0, -0.25, -0.375), "grenade_jinglegrenade_equip", "grenade_idle", "grenade_sprint", "grenade_jinglegrenade_inspect", nil, {
	["ThrowStart"] = "grenade_jinglegrenade_throw_start",
	["ThrowIdle"] = "grenade_throw_idle",
	["ThrowFinish"] = "grenade_jinglegrenade_throw_finish",
	["LobStart"] = "grenade_jinglegrenade_lob_start",
	["LobIdle"] = "grenade_lob_idle",
	["LobFinish"] = "grenade_jinglegrenade_lob_finish"
})
v96("Dynamite", "rbxassetid://119066463640901", "rbxassetid://97225646481020", nil, nil, nil, CFrame.new(0, -0.25, -0.375), "grenade_equip", "grenade_idle", "grenade_sprint", "grenade_inspect", nil, {
	["ThrowStart"] = "grenade_dynamite_throw_start",
	["ThrowIdle"] = "grenade_throw_idle",
	["ThrowFinish"] = "grenade_throw_finish",
	["LobStart"] = "grenade_dynamite_lob_start",
	["LobIdle"] = "grenade_lob_idle",
	["LobFinish"] = "grenade_lob_finish"
})
v96("Keynade", "rbxassetid://102785971311114", "rbxassetid://122922810220976", nil, nil, nil, CFrame.new(0, 0, -0.5), "grenade_keynade_equip", "grenade_keynade_idle", "grenade_keynade_sprint", "grenade_keynade_inspect", nil, {
	["ThrowStart"] = "grenade_keynade_throw_start_pinpull",
	["ThrowIdle"] = "grenade_keynade_throw_idle",
	["ThrowFinish"] = "grenade_keynade_throw_finish",
	["LobStart"] = "grenade_keynade_throw_start_pinpull",
	["LobIdle"] = "grenade_keynade_throw_idle",
	["LobFinish"] = "grenade_keynade_lob_finish"
})
v96("Glorious Grenade", "rbxassetid://103034870490455", "rbxassetid://102502933883025", nil, nil, nil, CFrame.new(0, -0.25, -0.375), "grenade_equip", "grenade_idle", "grenade_sprint", "grenade_inspect", nil, {
	["ThrowStart"] = "grenade_throw_start_pinpull",
	["ThrowIdle"] = "grenade_throw_idle",
	["ThrowFinish"] = "grenade_throw_finish",
	["LobStart"] = "grenade_lob_start_pinpull",
	["LobIdle"] = "grenade_lob_idle",
	["LobFinish"] = "grenade_lob_finish"
})
v96("Frozen Grenade", "rbxassetid://96120996159611", "rbxassetid://101932886938992", nil, nil, nil, CFrame.new(0, -0.25, -0.375), "grenade_equip", "grenade_idle", "grenade_sprint", "grenade_inspect", nil, {
	["ThrowStart"] = "grenade_throw_start_pinpull",
	["ThrowIdle"] = "grenade_throw_idle",
	["ThrowFinish"] = "grenade_throw_finish",
	["LobStart"] = "grenade_lob_start_pinpull",
	["LobIdle"] = "grenade_lob_idle",
	["LobFinish"] = "grenade_lob_finish"
})
v96("Cuddle Bomb", "rbxassetid://116801887274189", "rbxassetid://122359407681537", nil, nil, nil, CFrame.new(0, -0.25, -0.375), "grenade_cuddlebomb_equip", "grenade_cuddlebomb_idle", "grenade_cuddlebomb_sprint", "grenade_cuddlebomb_inspect", "grenade_cuddlebomb_inspect_rare", {
	["ThrowStart"] = "grenade_cuddlebomb_throw_start",
	["ThrowIdle"] = "grenade_cuddlebomb_throw_idle",
	["ThrowFinish"] = "grenade_cuddlebomb_throw_finish",
	["LobStart"] = "grenade_cuddlebomb_lob_start",
	["LobIdle"] = "grenade_cuddlebomb_lob_idle",
	["LobFinish"] = "grenade_cuddlebomb_lob_finish"
})
v96("Fizz Bomb", "rbxassetid://123256093694497", "rbxassetid://113023326908054", nil, nil, nil, CFrame.new(0, -0.25, -0.375), "grenade_fizzbomb_equip", "grenade_fizzbomb_idle", "grenade_fizzbomb_sprint", "grenade_fizzbomb_inspect", nil, {
	["ThrowStart"] = "grenade_fizzbomb_throw_start",
	["ThrowIdle"] = "grenade_fizzbomb_throw_idle",
	["ThrowFinish"] = "grenade_fizzbomb_throw_finish",
	["LobStart"] = "grenade_fizzbomb_throw_start",
	["LobIdle"] = "grenade_fizzbomb_throw_idle",
	["LobFinish"] = "grenade_fizzbomb_lob_finish"
})
v96("Batnade", "rbxassetid://80166736095109", "rbxassetid://87322737435240", nil, nil, nil, CFrame.new(0, -0.25, -0.375), "grenade_batnade_equip", "grenade_idle", "grenade_sprint", "grenade_inspect", nil, {
	["ThrowStart"] = "grenade_throw_start_pinpull",
	["ThrowIdle"] = "grenade_throw_idle",
	["ThrowFinish"] = "grenade_throw_finish",
	["LobStart"] = "grenade_lob_start_pinpull",
	["LobIdle"] = "grenade_lob_idle",
	["LobFinish"] = "grenade_lob_finish"
})
v96("Molotov", "rbxassetid://109264750627289", "rbxassetid://83303332331234", nil, "rbxassetid://72190971541032", 1.25, CFrame.new(0, -0.25, -0.375), "grenade_equip", "molotov_idle", "grenade_sprint", "grenade_inspect", nil, {
	["ThrowStart"] = "grenade_throw_start",
	["ThrowIdle"] = "grenade_throw_idle",
	["ThrowFinish"] = "grenade_throw_finish",
	["LobStart"] = "grenade_lob_start",
	["LobIdle"] = "grenade_lob_idle",
	["LobFinish"] = "grenade_lob_finish"
})
v96("Coffee", "rbxassetid://17672061538", "rbxassetid://17672089358", nil, nil, nil, CFrame.new(0, -0.25, -0.375), "grenade_equip", "grenade_idle", "grenade_sprint", "molotov_coffee_inspect", nil, {
	["ThrowStart"] = "grenade_throw_start",
	["ThrowIdle"] = "grenade_throw_idle",
	["ThrowFinish"] = "grenade_throw_finish",
	["LobStart"] = "grenade_lob_start",
	["LobIdle"] = "grenade_lob_idle",
	["LobFinish"] = "grenade_lob_finish"
})
v96("Torch", "rbxassetid://115586189235552", "rbxassetid://120882142047198", nil, nil, nil, CFrame.new(0, -0.25, -0.375), "grenade_equip", "molotov_idle", "grenade_sprint", "grenade_inspect", nil, {
	["ThrowStart"] = "grenade_throw_start",
	["ThrowIdle"] = "grenade_throw_idle",
	["ThrowFinish"] = "grenade_throw_finish",
	["LobStart"] = "grenade_lob_start",
	["LobIdle"] = "grenade_lob_idle",
	["LobFinish"] = "grenade_lob_finish"
})
v96("Vexed Candle", "rbxassetid://78128648928195", "rbxassetid://136079178184476", nil, nil, nil, CFrame.new(0, -0.25, -0.375), "grenade_equip", "molotov_idle", "grenade_sprint", "grenade_inspect", nil, {
	["ThrowStart"] = "grenade_throw_start",
	["ThrowIdle"] = "grenade_throw_idle",
	["ThrowFinish"] = "grenade_throw_finish",
	["LobStart"] = "grenade_lob_start",
	["LobIdle"] = "grenade_lob_idle",
	["LobFinish"] = "grenade_lob_finish"
})
v96("Hot Coals", "rbxassetid://110423024723304", "rbxassetid://98070129509602", nil, nil, nil, CFrame.new(0, -0.25, -0.375), "molotov_hotcoals_equip", "molotov_hotcoals_idle", nil, nil, nil, {
	["ThrowStart"] = "molotov_hotcoals_throw_start",
	["ThrowIdle"] = "molotov_hotcoals_throw_idle",
	["ThrowFinish"] = "molotov_hotcoals_throw_finish",
	["LobStart"] = "molotov_hotcoals_lob_start",
	["LobIdle"] = "molotov_hotcoals_lob_idle",
	["LobFinish"] = "molotov_hotcoals_lob_finish"
}, {
	["DisableProceduralSprinting"] = true
})
v96("Lava Lamp", "rbxassetid://79616583726432", "rbxassetid://76191080417885", nil, nil, nil, CFrame.new(0, -0.25, -0.375), "grenade_equip", "molotov_lavalamp_idle", "grenade_sprint", "grenade_inspect", nil, {
	["ThrowStart"] = "grenade_throw_start",
	["ThrowIdle"] = "grenade_throw_idle",
	["ThrowFinish"] = "grenade_throw_finish",
	["LobStart"] = "grenade_lob_start",
	["LobIdle"] = "grenade_lob_idle",
	["LobFinish"] = "grenade_lob_finish"
})
v96("Glorious Molotov", "rbxassetid://108930340066987", "rbxassetid://95650602989880", nil, nil, nil, CFrame.new(0, -0.25, -0.375), "grenade_equip", "molotov_idle", "grenade_sprint", "grenade_inspect", nil, {
	["ThrowStart"] = "grenade_throw_start",
	["ThrowIdle"] = "grenade_throw_idle",
	["ThrowFinish"] = "grenade_throw_finish",
	["LobStart"] = "grenade_lob_start",
	["LobIdle"] = "grenade_lob_idle",
	["LobFinish"] = "grenade_lob_finish"
})
v96("Arch Molotov", "rbxassetid://96589300342777", "rbxassetid://136971342091354", nil, nil, nil, CFrame.new(0, -0.125, -0.5), "molotov_archmolotov_equip", "molotov_archmolotov_idle", "molotov_archmolotov_sprint", "molotov_archmolotov_inspect", nil, {
	["ThrowStart"] = "molotov_archmolotov_throw_start",
	["ThrowIdle"] = "molotov_archmolotov_throw_idle",
	["ThrowFinish"] = "molotov_archmolotov_throw_finish",
	["LobStart"] = "molotov_archmolotov_lob_start",
	["LobIdle"] = "molotov_archmolotov_lob_idle",
	["LobFinish"] = "molotov_archmolotov_lob_finish"
})
v96("Ship In A Bottle", "rbxassetid://125699268308415", "rbxassetid://122226447491617", nil, nil, nil, CFrame.new(0, -0.25, -0.375), "molotov_shipinabottle_equip", "molotov_shipinabottle_idle", "molotov_shipinabottle_sprint", "molotov_shipinabottle_inspect", nil, {
	["ThrowStart"] = "molotov_shipinabottle_throw_start",
	["ThrowIdle"] = "molotov_shipinabottle_throw_idle",
	["ThrowFinish"] = "molotov_shipinabottle_throw_finish",
	["LobStart"] = "molotov_shipinabottle_lob_start",
	["LobIdle"] = "molotov_shipinabottle_lob_idle",
	["LobFinish"] = "molotov_shipinabottle_lob_finish"
})
v96("Campfire Stick", "rbxassetid://83823494489693", "rbxassetid://118713573113832", nil, nil, nil, CFrame.new(0, -0.25, -0.375), "molotov_campfirestick_equip", "molotov_idle", "grenade_sprint", "grenade_inspect", nil, {
	["ThrowStart"] = "grenade_throw_start",
	["ThrowIdle"] = "grenade_throw_idle",
	["ThrowFinish"] = "grenade_throw_finish",
	["LobStart"] = "grenade_lob_start",
	["LobIdle"] = "grenade_lob_idle",
	["LobFinish"] = "grenade_lob_finish"
})
v96("Flashbang", "rbxassetid://17160801529", "rbxassetid://14664488253", nil, "rbxassetid://129373270164561", 1.5, CFrame.new(0, -0.25, -0.375), "grenade_equip", "grenade_idle", "grenade_sprint", "grenade_inspect", nil, {
	["ThrowStart"] = "grenade_throw_start_pinpull",
	["ThrowIdle"] = "grenade_throw_idle",
	["ThrowFinish"] = "grenade_throw_finish",
	["LobStart"] = "grenade_lob_start_pinpull",
	["LobIdle"] = "grenade_lob_idle",
	["LobFinish"] = "grenade_lob_finish"
})
v96("Disco Ball", "rbxassetid://17672061796", "rbxassetid://17672089136", nil, nil, nil, CFrame.new(0, -0.25, -0.375), "grenade_equip", "grenade_idle", "grenade_sprint", "grenade_inspect", nil, {
	["ThrowStart"] = "flashbang_discoball_throw_start",
	["ThrowIdle"] = "grenade_throw_idle",
	["ThrowFinish"] = "grenade_throw_finish",
	["LobStart"] = "flashbang_discoball_lob_start",
	["LobIdle"] = "grenade_lob_idle",
	["LobFinish"] = "grenade_lob_finish"
})
v96("Camera", "rbxassetid://18766865640", "rbxassetid://18766908915", nil, nil, nil, CFrame.new(0, -0.25, -0.375), "grenade_equip", "grenade_idle", "grenade_sprint", "grenade_inspect", nil, {
	["ThrowStart"] = "flashbang_camera_throw_start",
	["ThrowIdle"] = "grenade_throw_idle",
	["ThrowFinish"] = "grenade_throw_finish",
	["LobStart"] = "flashbang_camera_lob_start",
	["LobIdle"] = "grenade_lob_idle",
	["LobFinish"] = "grenade_lob_finish"
})
v96("Pixel Flashbang", "rbxassetid://132815625474597", "rbxassetid://82894448978638", nil, nil, nil, CFrame.new(0, -0.25, -0.375), "grenade_pixelgrenade_equip", "grenade_pixelgrenade_idle", "grenade_pixelgrenade_sprint", "grenade_pixelgrenade_inspect", nil, {
	["ThrowStart"] = "grenade_pixelgrenade_throw_start_pinpull",
	["ThrowIdle"] = "grenade_pixelgrenade_throw_idle",
	["ThrowFinish"] = "grenade_pixelgrenade_throw_finish",
	["LobStart"] = "grenade_pixelgrenade_lob_start_pinpull",
	["LobIdle"] = "grenade_pixelgrenade_lob_idle",
	["LobFinish"] = "grenade_pixelgrenade_lob_finish"
}, {
	["FramesPerSecond"] = 2,
	["PlayAnimationsInstantly"] = true
})
v96("Skullbang", "rbxassetid://73796957224972", "rbxassetid://94894233513600", nil, nil, nil, CFrame.new(0, -0.25, -0.375), "grenade_equip", "grenade_idle", "grenade_sprint", "grenade_inspect", nil, {
	["ThrowStart"] = "flashbang_skullbang_throw_start",
	["ThrowIdle"] = "grenade_throw_idle",
	["ThrowFinish"] = "grenade_throw_finish",
	["LobStart"] = "flashbang_skullbang_lob_start",
	["LobIdle"] = "grenade_lob_idle",
	["LobFinish"] = "grenade_lob_finish"
})
v96("Shining Star", "rbxassetid://108392227354212", "rbxassetid://73486952957582", nil, nil, nil, CFrame.new(0, -0.25, -0.375), "grenade_equip", "grenade_idle", "grenade_sprint", "grenade_inspect", nil, {
	["ThrowStart"] = "flashbang_shiningstar_throw_start",
	["ThrowIdle"] = "grenade_throw_idle",
	["ThrowFinish"] = "grenade_throw_finish",
	["LobStart"] = "flashbang_shiningstar_lob_start",
	["LobIdle"] = "grenade_lob_idle",
	["LobFinish"] = "grenade_lob_finish"
})
v96("Lightbulb", "rbxassetid://125489177573287", "rbxassetid://78421244256536", nil, nil, nil, CFrame.new(0, -0.25, -0.375), "grenade_equip", "grenade_idle", "grenade_sprint", "grenade_inspect", nil, {
	["ThrowStart"] = "grenade_throw_start_pinpull",
	["ThrowIdle"] = "grenade_throw_idle",
	["ThrowFinish"] = "grenade_throw_finish",
	["LobStart"] = "grenade_lob_start_pinpull",
	["LobIdle"] = "grenade_lob_idle",
	["LobFinish"] = "grenade_lob_finish"
})
v96("Glorious Flashbang", "rbxassetid://96760506528185", "rbxassetid://131190784940519", nil, nil, nil, CFrame.new(0, -0.25, -0.375), "grenade_equip", "grenade_idle", "grenade_sprint", "grenade_inspect", nil, {
	["ThrowStart"] = "grenade_throw_start_pinpull",
	["ThrowIdle"] = "grenade_throw_idle",
	["ThrowFinish"] = "grenade_throw_finish",
	["LobStart"] = "grenade_lob_start_pinpull",
	["LobIdle"] = "grenade_lob_idle",
	["LobFinish"] = "grenade_lob_finish"
})
v96("Sol", "rbxassetid://124026864365877", "rbxassetid://89719752372389", nil, nil, nil, CFrame.new(0, -0.25, -0.375), "grenade_equip", "grenade_idle", "grenade_sprint", "grenade_inspect", nil, {
	["ThrowStart"] = "flashbang_sol_throw_start",
	["ThrowIdle"] = "grenade_throw_idle",
	["ThrowFinish"] = "grenade_throw_finish",
	["LobStart"] = "flashbang_sol_lob_start",
	["LobIdle"] = "grenade_lob_idle",
	["LobFinish"] = "grenade_lob_finish"
})
v96("Smoke Grenade", "rbxassetid://17160799767", "rbxassetid://16373283577", nil, "rbxassetid://107823376688548", 1.5, CFrame.new(0, -0.25, -0.375), "grenade_equip", "grenade_idle", "grenade_sprint", "grenade_inspect", nil, {
	["ThrowStart"] = "grenade_throw_start_pinpull",
	["ThrowIdle"] = "grenade_throw_idle",
	["ThrowFinish"] = "grenade_throw_finish",
	["LobStart"] = "grenade_lob_start_pinpull",
	["LobIdle"] = "grenade_lob_idle",
	["LobFinish"] = "grenade_lob_finish"
})
v96("Emoji Cloud", "rbxassetid://17821234077", "rbxassetid://17821265237", nil, nil, nil, CFrame.new(0, -0.25, -0.375), "grenade_equip", "grenade_idle", "grenade_sprint", "grenade_inspect", nil, {
	["ThrowStart"] = "grenade_throw_start",
	["ThrowIdle"] = "grenade_throw_idle",
	["ThrowFinish"] = "grenade_throw_finish",
	["LobStart"] = "grenade_lob_start",
	["LobIdle"] = "grenade_lob_idle",
	["LobFinish"] = "grenade_lob_finish"
})
v96("Balance", "rbxassetid://18766866168", "rbxassetid://18766909964", nil, nil, nil, CFrame.new(0, -0.25, -0.375), "grenade_equip", "grenade_idle", "grenade_sprint", "grenade_inspect", nil, {
	["ThrowStart"] = "grenade_throw_start",
	["ThrowIdle"] = "grenade_throw_idle",
	["ThrowFinish"] = "grenade_throw_finish",
	["LobStart"] = "grenade_lob_start",
	["LobIdle"] = "grenade_lob_idle",
	["LobFinish"] = "grenade_lob_finish"
})
v96("Eyeball", "rbxassetid://135911399763146", "rbxassetid://103493376163318", nil, nil, nil, CFrame.new(0, -0.25, -0.375), "grenade_equip", "grenade_idle", "grenade_sprint", "grenade_inspect", nil, {
	["ThrowStart"] = "grenade_throw_start",
	["ThrowIdle"] = "grenade_throw_idle",
	["ThrowFinish"] = "grenade_throw_finish",
	["LobStart"] = "grenade_lob_start",
	["LobIdle"] = "grenade_lob_idle",
	["LobFinish"] = "grenade_lob_finish"
})
v96("Snowglobe", "rbxassetid://119390465944051", "rbxassetid://86696224913566", nil, nil, nil, CFrame.new(0, -0.25, -0.375), "grenade_equip", "grenade_idle", "grenade_sprint", "grenade_inspect", nil, {
	["ThrowStart"] = "grenade_throw_start",
	["ThrowIdle"] = "grenade_throw_idle",
	["ThrowFinish"] = "grenade_throw_finish",
	["LobStart"] = "grenade_lob_start",
	["LobIdle"] = "grenade_lob_idle",
	["LobFinish"] = "grenade_lob_finish"
})
v96("Hourglass", "rbxassetid://108311418974073", "rbxassetid://70423041582442", nil, nil, nil, CFrame.new(0, -0.25, -0.375), "grenade_equip", "grenade_idle", "grenade_sprint", "grenade_inspect", nil, {
	["ThrowStart"] = "grenade_throw_start",
	["ThrowIdle"] = "grenade_throw_idle",
	["ThrowFinish"] = "grenade_throw_finish",
	["LobStart"] = "grenade_lob_start",
	["LobIdle"] = "grenade_lob_idle",
	["LobFinish"] = "grenade_lob_finish"
})
v96("Glorious Smoke Grenade", "rbxassetid://139714146508398", "rbxassetid://121565824954563", nil, nil, nil, CFrame.new(0, -0.25, -0.375), "grenade_equip", "grenade_idle", "grenade_sprint", "grenade_inspect", nil, {
	["ThrowStart"] = "grenade_throw_start_pinpull",
	["ThrowIdle"] = "grenade_throw_idle",
	["ThrowFinish"] = "grenade_throw_finish",
	["LobStart"] = "grenade_lob_start_pinpull",
	["LobIdle"] = "grenade_lob_idle",
	["LobFinish"] = "grenade_lob_finish"
})
v96("Beach Ball", "rbxassetid://98068366944697", "rbxassetid://86203107718646", nil, nil, nil, CFrame.new(0, -0.25, -0.375), "grenade_equip", "grenade_idle", "grenade_sprint", "grenade_inspect", nil, {
	["ThrowStart"] = "grenade_throw_start",
	["ThrowIdle"] = "grenade_throw_idle",
	["ThrowFinish"] = "grenade_throw_finish",
	["LobStart"] = "grenade_lob_start",
	["LobIdle"] = "grenade_lob_idle",
	["LobFinish"] = "grenade_lob_finish"
})
v96("Fists", "rbxassetid://17160801745", "rbxassetid://16560051320", nil, "rbxassetid://99106504223200", 1.5, nil, "fists_equip", "fists_idle", "fists_sprint", "fists_inspect", nil, {
	["Attack1"] = "fists_attack1",
	["Attack2"] = "fists_attack2"
})
v96("Boxing Gloves", "rbxassetid://17672060486", "rbxassetid://17672089761", nil, nil, nil, CFrame.new(0, 0, -0.375), "fists_equip", "fists_idle", "fists_sprint", "fists_boxinggloves_inspect", nil, {
	["Attack1"] = "fists_attack1",
	["Attack2"] = "fists_attack2"
})
v96("Brass Knuckles", "rbxassetid://106879679389340", "rbxassetid://116610825846650", nil, nil, nil, nil, "fists_equip", "fists_idle", "fists_sprint", "fists_inspect", nil, {
	["Attack1"] = "fists_attack1",
	["Attack2"] = "fists_attack2"
})
v96("Pumpkin Claws", "rbxassetid://90996407819750", "rbxassetid://110587168549532", nil, nil, nil, nil, "fists_equip", "fists_idle", "fists_sprint", "fists_inspect", nil, {
	["Attack1"] = "fists_attack1",
	["Attack2"] = "fists_attack2"
})
v96("Festive Fists", "rbxassetid://102757458529795", "rbxassetid://98061476050478", nil, nil, nil, nil, "fists_equip", "fists_idle", "fists_sprint", "fists_inspect", nil, {
	["Attack1"] = "fists_attack1",
	["Attack2"] = "fists_attack2"
})
v96("Fists of Hurt", "rbxassetid://140103672289959", "rbxassetid://71585039030211", nil, nil, nil, CFrame.new(0, 0, -0.375), "fists_equip", "fists_idle", "fists_sprint", "fists_fistsofhurt_inspect", nil, {
	["Attack1"] = "fists_fistsofhurt_attack1",
	["Attack2"] = "fists_fistsofhurt_attack2"
})
v96("Glorious Fists", "rbxassetid://112839297231399", "rbxassetid://72268337520152", nil, nil, nil, nil, "fists_equip", "fists_idle", "fists_sprint", "fists_inspect", nil, {
	["Attack1"] = "fists_attack1",
	["Attack2"] = "fists_attack2"
})
v96("Fist", "rbxassetid://109585706680035", "rbxassetid://78704206164484", nil, nil, nil, CFrame.new(0, -0.375, -0.375) * CFrame.Angles(0, 0, (math.rad(20))), "fists_fist_equip", "fists_fist_idle", "fists_fist_sprint", "fists_fist_inspect", nil, {
	["Attack1"] = "fists_fist_attack1",
	["Attack2"] = nil
})
v96("Spy Gloves", "rbxassetid://117198095640784", "rbxassetid://112947025953634", nil, nil, nil, nil, "fists_equip", "fists_idle", "fists_sprint", "fists_inspect", nil, {
	["Attack1"] = "fists_attack1",
	["Attack2"] = "fists_attack2"
})
v96("Pirate Hook", "rbxassetid://116717593932616", "rbxassetid://97614245490635", nil, nil, nil, CFrame.new(0, 0, -0.375), "fists_piratehook_equip", "fists_piratehook_idle", "fists_piratehook_sprint", "fists_piratehook_inspect", nil, {
	["Attack1"] = "fists_piratehook_attack1",
	["Attack2"] = "fists_piratehook_attack2"
})
v96("Crab Claws", "rbxassetid://127492118111080", "rbxassetid://71811592012118", nil, nil, nil, nil, "fists_crabclaws_equip", "fists_crabclaws_idle", "fists_crabclaws_sprint", "fists_crabclaws_inspect", nil, {
	["Attack1"] = "fists_crabclaws_attack1",
	["Attack2"] = "fists_crabclaws_attack2"
})
v96("Towerstone Fists", "rbxassetid://72219935395375", "rbxassetid://104899359584431", nil, nil, nil, nil, "fists_equip", "fists_idle", "fists_sprint", "fists_inspect", nil, {
	["Attack1"] = "fists_attack1",
	["Attack2"] = "fists_attack2"
})
v96("Knife", "rbxassetid://17160800983", "rbxassetid://13197583583", nil, "rbxassetid://86335100734691", 2, nil, "knife_equip", "knife_idle", "knife_sprint", "knife_inspect", "knife_inspect_rare", {
	["Attack1"] = "knife_attack1",
	["Attack2"] = "knife_attack2",
	["HeavyAttack1"] = "knife_heavyattack1",
	["HeavyAttackAnimationHit"] = nil
})
v96("Chancla", "rbxassetid://17672060795", "rbxassetid://17672089600", nil, nil, nil, nil, "knife_equip", "knife_idle", "knife_sprint", "knife_inspect", "knife_inspect_rare", {
	["Attack1"] = "knife_attack1",
	["Attack2"] = "knife_attack2",
	["HeavyAttack1"] = "knife_heavyattack1",
	["HeavyAttackAnimationHit"] = nil
})
v96("Karambit", "rbxassetid://18766863586", "rbxassetid://18766907079", nil, nil, nil, nil, "knife_karambit_equip", "knife_karambit_idle", "knife_karambit_sprint", "knife_karambit_inspect", nil, {
	["Attack1"] = "knife_karambit_attack1",
	["Attack2"] = "knife_karambit_attack2",
	["HeavyAttack1"] = "knife_karambit_heavyattack1",
	["HeavyAttackAnimationHit"] = "knife_karambit_heavyattack_hit"
})
v96("Machete", "rbxassetid://84364955819899", "rbxassetid://90332754966135", nil, nil, nil, nil, "knife_machete_equip", "knife_machete_idle", "knife_machete_sprint", "knife_machete_inspect", nil, {
	["Attack1"] = "knife_machete_attack1",
	["Attack2"] = "knife_machete_attack2",
	["HeavyAttack1"] = "knife_machete_heavyattack1",
	["HeavyAttackAnimationHit"] = "knife_machete_heavyattack_hit"
})
v96("Candy Cane", "rbxassetid://124021545052910", "rbxassetid://84302121354096", nil, nil, nil, nil, "knife_karambit_equip", "knife_karambit_idle", "knife_karambit_sprint", "knife_karambit_inspect", nil, {
	["Attack1"] = "knife_karambit_attack1",
	["Attack2"] = "knife_karambit_attack2",
	["HeavyAttack1"] = "knife_karambit_heavyattack1",
	["HeavyAttackAnimationHit"] = "knife_karambit_heavyattack_hit"
})
v96("Balisong", "rbxassetid://93303458333011", "rbxassetid://114825371645118", nil, nil, nil, CFrame.new(0, 0, -0.25), "knife_balisong_equip", "knife_balisong_idle", "knife_balisong_sprint", "knife_balisong_inspect", nil, {
	["Attack1"] = "knife_balisong_attack1",
	["Attack2"] = "knife_balisong_attack2",
	["HeavyAttack1"] = "knife_balisong_heavyattack1",
	["HeavyAttackAnimationHit"] = "knife_balisong_heavyattack_hit"
})
v96("Armature.001", "rbxassetid://104026327618871", "rbxassetid://91555068782550", nil, nil, nil, CFrame.new(0, 0, -0.25), "knife_balisong_equip", "knife_balisong_idle", "knife_balisong_sprint", "knife_balisong_inspect", nil, {
	["Attack1"] = "knife_balisong_attack1",
	["Attack2"] = "knife_balisong_attack2",
	["HeavyAttack1"] = "knife_balisong_heavyattack1",
	["HeavyAttackAnimationHit"] = "knife_armature001_heavyattack_hit"
})
v96("Glorious Knife", "rbxassetid://77448895595314", "rbxassetid://122760026905111", nil, nil, nil, nil, "knife_equip", "knife_idle", "knife_sprint", "knife_inspect", "knife_inspect_rare", {
	["Attack1"] = "knife_attack1",
	["Attack2"] = "knife_attack2",
	["HeavyAttack1"] = "knife_heavyattack1",
	["HeavyAttackAnimationHit"] = nil
})
v96("Keyrambit", "rbxassetid://108512337101248", "rbxassetid://73252950434501", nil, nil, nil, nil, "knife_keyrambit_equip", "knife_karambit_idle", "knife_karambit_sprint", "knife_karambit_inspect", nil, {
	["Attack1"] = "knife_keyrambit_attack1",
	["Attack2"] = "knife_keyrambit_attack2",
	["HeavyAttack1"] = "knife_keyrambit_heavyattack1",
	["HeavyAttackAnimationHit"] = "knife_keyrambit_heavyattack_hit"
})
v96("Keylisong", "rbxassetid://100084654831857", "rbxassetid://118944160521617", nil, nil, nil, CFrame.new(0, 0, -0.25), "knife_keylisong_equip", "knife_balisong_idle", "knife_balisong_sprint", "knife_keylisong_inspect", nil, {
	["Attack1"] = "knife_keylisong_attack1",
	["Attack2"] = "knife_keylisong_attack2",
	["HeavyAttack1"] = "knife_keylisong_heavyattack1",
	["HeavyAttackAnimationHit"] = "knife_keylisong_heavyattack_hit"
})
v96("Caladbolg", "rbxassetid://101180142582964", "rbxassetid://72181228743456", nil, nil, nil, CFrame.new(0, 0, -0.25), "knife_caladbolg_equip", "knife_caladbolg_idle", "knife_caladbolg_sprint", "knife_caladbolg_inspect", nil, {
	["Attack1"] = "knife_caladbolg_attack1",
	["Attack2"] = "knife_caladbolg_attack2",
	["HeavyAttack1"] = "knife_caladbolg_heavyattack1",
	["HeavyAttackAnimationHit"] = "knife_caladbolg_heavyattack_hit"
})
v96("Pencil", "rbxassetid://131450909376802", "rbxassetid://70869179257286", nil, nil, nil, nil, "knife_pencil_equip", "knife_pencil_idle", "knife_pencil_sprint", "knife_pencil_inspect", nil, {
	["Attack1"] = "knife_pencil_attack1",
	["Attack2"] = "knife_pencil_attack2",
	["HeavyAttack1"] = "knife_pencil_heavyattack1",
	["HeavyAttackAnimationHit"] = "knife_pencil_heavyattack_hit"
})
v96("Birthday Candle", "rbxassetid://74148583096733", "rbxassetid://83325442238415", nil, nil, nil, nil, "knife_equip", "knife_birthdaycandle_idle", "knife_sprint", "knife_inspect", "knife_inspect_rare", {
	["Attack1"] = "knife_birthdaycandle_attack1",
	["Attack2"] = "knife_birthdaycandle_attack2",
	["HeavyAttack1"] = "knife_birthdaycandle_heavyattack1",
	["HeavyAttackAnimationHit"] = nil
})
v96("Shark Tooth", "rbxassetid://124265657652842", "rbxassetid://129966569376566", nil, nil, nil, nil, "knife_equip", "knife_idle", "knife_sprint", "knife_inspect", "knife_inspect_rare", {
	["Attack1"] = "knife_attack1",
	["Attack2"] = "knife_attack2",
	["HeavyAttack1"] = "knife_heavyattack1",
	["HeavyAttackAnimationHit"] = nil
})
v96("Trophy Knife", "rbxassetid://78822531823097", "rbxassetid://88522490384925", nil, nil, nil, nil, "knife_equip", "knife_idle", "knife_sprint", "knife_inspect", "knife_inspect_rare", {
	["Attack1"] = "knife_attack1",
	["Attack2"] = "knife_attack2",
	["HeavyAttack1"] = "knife_heavyattack1",
	["HeavyAttackAnimationHit"] = nil
})
v96("Karambat", "rbxassetid://77250751309827", "rbxassetid://127165426736513", nil, nil, nil, nil, "knife_karambat_equip", "knife_karambit_idle", "knife_karambit_sprint", "knife_karambit_inspect", nil, {
	["Attack1"] = "knife_karambat_attack1",
	["Attack2"] = "knife_karambat_attack2",
	["HeavyAttack1"] = "knife_karambat_heavyattack1",
	["HeavyAttackAnimationHit"] = "knife_karambit_heavyattack_hit"
})
v96("Gothic Knife", "rbxassetid://100190669083085", "rbxassetid://110963636308367", nil, nil, nil, nil, "knife_equip", "knife_idle", "knife_sprint", "knife_inspect", "knife_inspect_rare", {
	["Attack1"] = "knife_attack1",
	["Attack2"] = "knife_attack2",
	["HeavyAttack1"] = "knife_heavyattack1",
	["HeavyAttackAnimationHit"] = nil
})
v96("Chainsaw", "rbxassetid://17160801873", "rbxassetid://13717445410", nil, "rbxassetid://81316332892810", 2.75, nil, "chainsaw_equip", "chainsaw_idle", "chainsaw_sprint", "chainsaw_inspect", nil, {
	["Attack1"] = "chainsaw_attack1",
	["Attack2"] = "chainsaw_attack2",
	["HoldStart"] = "chainsaw_hold_start",
	["HoldLoop"] = "chainsaw_hold_loop",
	["HoldFinish"] = "chainsaw_hold_finish"
})
v96("Blobsaw", "rbxassetid://17825963589", "rbxassetid://17825961425", nil, nil, nil, nil, "chainsaw_equip", "chainsaw_idle", "chainsaw_sprint", "chainsaw_inspect", nil, {
	["Attack1"] = "chainsaw_attack1",
	["Attack2"] = "chainsaw_attack2",
	["HoldStart"] = "chainsaw_hold_start",
	["HoldLoop"] = "chainsaw_hold_loop",
	["HoldFinish"] = "chainsaw_hold_finish"
})
v96("Handsaws", "rbxassetid://18766864583", "rbxassetid://18769002596", nil, nil, nil, CFrame.new(0, 0, -0.5), "chainsaw_handsaws_equip", "chainsaw_handsaws_idle", "chainsaw_handsaws_sprint", "chainsaw_handsaws_inspect", nil, {
	["Attack1"] = "chainsaw_handsaws_attack1",
	["Attack2"] = "chainsaw_handsaws_attack2",
	["HoldStart"] = "chainsaw_handsaws_hold_start",
	["HoldLoop"] = "chainsaw_handsaws_hold_loop",
	["HoldFinish"] = "chainsaw_handsaws_hold_finish"
})
v96("Buzzsaw", "rbxassetid://74057448201836", "rbxassetid://128354991167944", nil, nil, nil, CFrame.new(0, 0.125, -0.125), "chainsaw_buzzsaw_equip", "chainsaw_buzzsaw_idle", "chainsaw_buzzsaw_sprint", "chainsaw_buzzsaw_inspect", nil, {
	["Attack1"] = "chainsaw_buzzsaw_attack1",
	["Attack2"] = "chainsaw_buzzsaw_attack2",
	["HoldStart"] = "chainsaw_buzzsaw_hold_start",
	["HoldLoop"] = "chainsaw_buzzsaw_hold_loop",
	["HoldFinish"] = "chainsaw_buzzsaw_hold_finish"
})
v96("Festive Buzzsaw", "rbxassetid://80811854818775", "rbxassetid://111566667788893", nil, nil, nil, CFrame.new(0, 0.125, -0.125), "chainsaw_buzzsaw_equip", "chainsaw_buzzsaw_idle", "chainsaw_buzzsaw_sprint", "chainsaw_buzzsaw_inspect", nil, {
	["Attack1"] = "chainsaw_buzzsaw_attack1",
	["Attack2"] = "chainsaw_buzzsaw_attack2",
	["HoldStart"] = "chainsaw_buzzsaw_hold_start",
	["HoldLoop"] = "chainsaw_buzzsaw_hold_loop",
	["HoldFinish"] = "chainsaw_buzzsaw_hold_finish"
})
v96("Mega Drill", "rbxassetid://76663867023998", "rbxassetid://78828669740807", nil, nil, nil, CFrame.new(0, 0, -0.25), "chainsaw_megadrill_equip", "chainsaw_megadrill_idle", "chainsaw_megadrill_sprint", "chainsaw_megadrill_inspect", nil, {
	["Attack1"] = "chainsaw_megadrill_attack1",
	["Attack2"] = "chainsaw_megadrill_attack2",
	["HoldStart"] = "chainsaw_megadrill_hold_start",
	["HoldLoop"] = "chainsaw_megadrill_hold_loop",
	["HoldFinish"] = "chainsaw_megadrill_hold_finish"
})
v96("Glorious Chainsaw", "rbxassetid://122622447397834", "rbxassetid://140353527719287", nil, nil, nil, nil, "chainsaw_equip", "chainsaw_idle", "chainsaw_sprint", "chainsaw_inspect", nil, {
	["Attack1"] = "chainsaw_attack1",
	["Attack2"] = "chainsaw_attack2",
	["HoldStart"] = "chainsaw_hold_start",
	["HoldLoop"] = "chainsaw_hold_loop",
	["HoldFinish"] = "chainsaw_hold_finish"
})
v96("Sharksaw", "rbxassetid://136881251000627", "rbxassetid://103400035987179", nil, nil, nil, nil, "chainsaw_equip", "chainsaw_idle", "chainsaw_sprint", "chainsaw_inspect", nil, {
	["Attack1"] = "chainsaw_attack1",
	["Attack2"] = "chainsaw_attack2",
	["HoldStart"] = "chainsaw_hold_start",
	["HoldLoop"] = "chainsaw_hold_loop",
	["HoldFinish"] = "chainsaw_hold_finish"
})
v96("Katana", "rbxassetid://17160801158", "rbxassetid://13968137196", nil, "rbxassetid://94254432866649", 3, CFrame.new(0, -0.125, -0.25), "katana_equip", "katana_idle", "katana_sprint2", "katana_inspect", "katana_inspect_rare", {
	["Attack1"] = "katana_attack1",
	["Attack2"] = "katana_attack2",
	["Attack3"] = nil,
	["DeflectIdle"] = "katana_deflect_idle",
	["Deflect1"] = "katana_deflect1",
	["Deflect2"] = "katana_deflect2",
	["Deflect3"] = "katana_deflect3",
	["Deflect4"] = "katana_deflect4",
	["Deflect5"] = "katana_deflect5"
})
v96("Saber", "rbxassetid://17672062341", "rbxassetid://17672087756", nil, nil, nil, CFrame.new(0, -0.125, -0.25), "katana_saber_equip", "katana_idle", "katana_sprint2", "katana_saber_inspect", "katana_saber_inspect_rare", {
	["Attack1"] = "katana_saber_attack1",
	["Attack2"] = "katana_saber_attack2",
	["Attack3"] = nil,
	["DeflectIdle"] = "katana_saber_deflect_idle",
	["Deflect1"] = "katana_deflect1",
	["Deflect2"] = "katana_deflect2",
	["Deflect3"] = "katana_deflect3",
	["Deflect4"] = "katana_deflect4",
	["Deflect5"] = "katana_deflect5"
})
v96("Lightning Bolt", "rbxassetid://18768968241", "rbxassetid://18769002278", nil, nil, nil, CFrame.new(0, -0.125, -0.25), "katana_lightningbolt_equip", "katana_idle", "katana_sprint2", "katana_inspect", "katana_lightningbolt_inspect_rare", {
	["Attack1"] = "katana_lightningbolt_attack1",
	["Attack2"] = "katana_lightningbolt_attack2",
	["Attack3"] = nil,
	["DeflectIdle"] = "katana_lightningbolt_deflect_idle",
	["Deflect1"] = "katana_deflect1",
	["Deflect2"] = "katana_deflect2",
	["Deflect3"] = "katana_deflect3",
	["Deflect4"] = "katana_deflect4",
	["Deflect5"] = "katana_deflect5"
})
v96("Pixel Katana", "rbxassetid://127922483074145", "rbxassetid://83686692916164", nil, nil, nil, CFrame.new(0, -0.125, -0.25), "katana_pixelkatana_equip", "katana_pixelkatana_idle", "katana_pixelkatana_sprint", "katana_pixelkatana_inspect", "katana_pixelkatana_inspect_rare", {
	["Attack1"] = "katana_pixelkatana_attack1",
	["Attack2"] = "katana_pixelkatana_attack2",
	["Attack3"] = nil,
	["DeflectIdle"] = "katana_pixelkatana_deflect_idle",
	["Deflect1"] = "katana_deflect1",
	["Deflect2"] = "katana_deflect2",
	["Deflect3"] = "katana_deflect3",
	["Deflect4"] = "katana_deflect4",
	["Deflect5"] = "katana_deflect5"
}, {
	["FramesPerSecond"] = 2,
	["PlayAnimationsInstantly"] = true
})
v96("Evil Trident", "rbxassetid://101234805269080", "rbxassetid://91973056969213", nil, nil, nil, CFrame.new(0, -0.125, -0.25), "katana_equip", "katana_idle", "katana_sprint2", "katana_inspect", "katana_inspect_rare", {
	["Attack1"] = "katana_eviltrident_attack1",
	["Attack2"] = "katana_eviltrident_attack2",
	["Attack3"] = nil,
	["DeflectIdle"] = "katana_deflect_idle",
	["Deflect1"] = "katana_deflect1",
	["Deflect2"] = "katana_deflect2",
	["Deflect3"] = "katana_deflect3",
	["Deflect4"] = "katana_deflect4",
	["Deflect5"] = "katana_deflect5"
})
v96("New Year Katana", "rbxassetid://102866488046710", "rbxassetid://79288379571855", nil, nil, nil, CFrame.new(0, -0.125, -0.25), "katana_equip", "katana_idle", "katana_sprint2", "katana_inspect", "katana_inspect_rare", {
	["Attack1"] = "katana_attack1",
	["Attack2"] = "katana_attack2",
	["Attack3"] = nil,
	["DeflectIdle"] = "katana_deflect_idle",
	["Deflect1"] = "katana_deflect1",
	["Deflect2"] = "katana_deflect2",
	["Deflect3"] = "katana_deflect3",
	["Deflect4"] = "katana_deflect4",
	["Deflect5"] = "katana_deflect5"
})
v96("Keytana", "rbxassetid://118899310989170", "rbxassetid://120478111112813", nil, nil, nil, CFrame.new(0, -0.125, -0.25), "katana_keytana_equip", "katana_keytana_idle", "katana_keytana_sprint", "katana_keytana_inspect", "katana_keytana_inspect_rare", {
	["Attack1"] = "katana_keytana_attack1",
	["Attack2"] = "katana_keytana_attack2",
	["Attack3"] = nil,
	["DeflectIdle"] = "katana_keytana_deflect_idle",
	["Deflect1"] = "katana_keytana_deflect1",
	["Deflect2"] = "katana_keytana_deflect2",
	["Deflect3"] = "katana_keytana_deflect3"
})
v96("Stellar Katana", "rbxassetid://72617738655198", "rbxassetid://90901679194899", nil, nil, nil, CFrame.new(0, -0.125, -0.25), "katana_equip", "katana_idle", "katana_sprint2", "katana_inspect", "katana_inspect_rare", {
	["Attack1"] = "katana_attack1",
	["Attack2"] = "katana_attack2",
	["Attack3"] = nil,
	["DeflectIdle"] = "katana_deflect_idle",
	["Deflect1"] = "katana_deflect1",
	["Deflect2"] = "katana_deflect2",
	["Deflect3"] = "katana_deflect3",
	["Deflect4"] = "katana_deflect4",
	["Deflect5"] = "katana_deflect5"
})
v96("Glorious Katana", "rbxassetid://75588958786035", "rbxassetid://94429900086533", nil, nil, nil, CFrame.new(0, -0.125, -0.25), "katana_equip", "katana_idle", "katana_sprint2", "katana_inspect", "katana_inspect_rare", {
	["Attack1"] = "katana_attack1",
	["Attack2"] = "katana_attack2",
	["Attack3"] = nil,
	["DeflectIdle"] = "katana_deflect_idle",
	["Deflect1"] = "katana_deflect1",
	["Deflect2"] = "katana_deflect2",
	["Deflect3"] = "katana_deflect3",
	["Deflect4"] = "katana_deflect4",
	["Deflect5"] = "katana_deflect5"
})
v96("Arch Katana", "rbxassetid://94679283541658", "rbxassetid://98068422294741", nil, nil, nil, CFrame.new(0, 0, -0.375), "katana_archkatana_equip", "katana_archkatana_idle", "katana_archkatana_sprint", "katana_archkatana_inspect", "katana_archkatana_inspect_rare", {
	["Attack1"] = "katana_archkatana_attack1",
	["Attack2"] = "katana_archkatana_attack2",
	["Attack3"] = nil,
	["DeflectIdle"] = "katana_archkatana_deflect_idle",
	["Deflect1"] = "katana_archkatana_deflect1",
	["Deflect2"] = "katana_archkatana_deflect2",
	["Deflect3"] = "katana_archkatana_deflect3",
	["Deflect4"] = "katana_archkatana_deflect4",
	["Deflect5"] = "katana_archkatana_deflect5"
})
v96("Crystal Katana", "rbxassetid://88872493010693", "rbxassetid://107573852829996", nil, nil, nil, CFrame.new(0, -0.125, -0.25), "katana_crystalkatana_equip", "katana_crystalkatana_idle", "katana_crystalkatana_sprint", "katana_crystalkatana_inspect", "katana_crystalkatana_inspect_rare", {
	["Attack1"] = "katana_crystalkatana_attack1",
	["Attack2"] = "katana_crystalkatana_attack2",
	["Attack3"] = nil,
	["DeflectIdle"] = "katana_crystalkatana_deflect_idle",
	["Deflect1"] = "katana_crystalkatana_deflect1",
	["Deflect2"] = "katana_crystalkatana_deflect2",
	["Deflect3"] = "katana_crystalkatana_deflect3",
	["Deflect4"] = "katana_crystalkatana_deflect4",
	["Deflect5"] = "katana_crystalkatana_deflect5"
})
v96("Linked Sword", "rbxassetid://83575725004177", "rbxassetid://131281564276137", nil, nil, nil, CFrame.new(0, -0.125, -0.25), "katana_linkedsword_equip", "katana_idle", "katana_sprint2", "katana_linkedsword_inspect", "katana_linkedsword_inspect_rare", {
	["Attack1"] = "katana_linkedsword_attack1",
	["Attack2"] = "katana_linkedsword_attack2",
	["Attack3"] = nil,
	["DeflectIdle"] = "katana_linkedsword_deflect_idle",
	["Deflect1"] = "katana_deflect1",
	["Deflect2"] = "katana_deflect2",
	["Deflect3"] = "katana_deflect3",
	["Deflect4"] = "katana_deflect4",
	["Deflect5"] = "katana_deflect5"
})
v96("Cutlass", "rbxassetid://77773371747122", "rbxassetid://92434199424881", nil, nil, nil, CFrame.new(0, 0, -0.25), "katana_cutlass_equip", "katana_cutlass_idle", "katana_cutlass_sprint", "katana_cutlass_inspect", "katana_cutlass_inspect_rare", {
	["Attack1"] = "katana_cutlass_attack1",
	["Attack2"] = "katana_cutlass_attack2",
	["Attack3"] = nil,
	["DeflectIdle"] = "katana_cutlass_deflect_idle",
	["Deflect1"] = "katana_cutlass_deflect1",
	["Deflect2"] = "katana_cutlass_deflect2",
	["Deflect3"] = "katana_cutlass_deflect3",
	["Deflect4"] = "katana_cutlass_deflect4",
	["Deflect5"] = "katana_cutlass_deflect5",
	["Deflect6"] = "katana_cutlass_deflect5"
})
v96("Riptide Katana", "rbxassetid://136245206320139", "rbxassetid://92795187640191", nil, nil, nil, CFrame.new(0, 0, -0.25), "katana_riptidekatana_equip", "katana_riptidekatana_idle", "katana_riptidekatana_sprint", "katana_riptidekatana_inspect", "katana_riptidekatana_inspect_rare", {
	["Attack1"] = "katana_riptidekatana_attack1",
	["Attack2"] = "katana_riptidekatana_attack2",
	["Attack3"] = "katana_riptidekatana_attack3",
	["DeflectIdle"] = "katana_riptidekatana_deflect_idle",
	["Deflect1"] = "katana_riptidekatana_deflect1",
	["Deflect2"] = "katana_riptidekatana_deflect2",
	["Deflect3"] = "katana_riptidekatana_deflect3",
	["Deflect4"] = "katana_riptidekatana_deflect4",
	["Deflect5"] = "katana_riptidekatana_deflect5"
})
v96("Swordfish", "rbxassetid://105748422389590", "rbxassetid://83041177417961", nil, nil, nil, CFrame.new(0, -0.125, -0.25), "katana_equip", "katana_idle", "katana_sprint2", "katana_inspect", "katana_inspect_rare", {
	["Attack1"] = "katana_attack1",
	["Attack2"] = "katana_attack2",
	["Attack3"] = nil,
	["DeflectIdle"] = "katana_deflect_idle",
	["Deflect1"] = "katana_deflect1",
	["Deflect2"] = "katana_deflect2",
	["Deflect3"] = "katana_deflect3",
	["Deflect4"] = "katana_deflect4",
	["Deflect5"] = "katana_deflect5"
})
v96("Scythe", "rbxassetid://17160800186", "rbxassetid://13834995858", "rbxassetid://18200943790", "rbxassetid://129311929685726", 2, nil, "scythe_equip", "scythe_idle", "scythe_sprint", "scythe_inspect", nil, {
	["Attack1"] = "scythe_attack1",
	["Attack2"] = "scythe_attack2",
	["Dash"] = nil,
	["AttackHit1"] = nil,
	["AttackHit2"] = nil
})
v96("Scythe of Death", "rbxassetid://17825996537", "rbxassetid://17825961272", nil, nil, nil, nil, "scythe_equip", "scythe_idle", "scythe_sprint", "scythe_inspect", nil, {
	["Attack1"] = "scythe_attack1",
	["Attack2"] = "scythe_attack2",
	["Dash"] = nil,
	["AttackHit1"] = nil,
	["AttackHit2"] = nil
})
v96("Anchor", "rbxassetid://18766866743", "rbxassetid://18769023932", nil, nil, nil, nil, "scythe_equip", "scythe_idle", "scythe_sprint", "scythe_inspect", nil, {
	["Attack1"] = "scythe_anchor_attack1",
	["Attack2"] = "scythe_anchor_attack2",
	["Dash"] = nil,
	["AttackHit1"] = nil,
	["AttackHit2"] = nil
})
v96("Keythe", "rbxassetid://114560926055433", "rbxassetid://75967374711732", nil, nil, nil, nil, "scythe_keythe_equip", "scythe_idle", "scythe_sprint", "scythe_inspect", nil, {
	["Attack1"] = "scythe_keythe_attack1",
	["Attack2"] = "scythe_keythe_attack2",
	["Dash"] = nil,
	["AttackHit1"] = nil,
	["AttackHit2"] = nil
})
v96("Bat Scythe", "rbxassetid://131711174838548", "rbxassetid://104168535403995", nil, nil, nil, nil, "scythe_equip", "scythe_idle", "scythe_sprint", "scythe_inspect", nil, {
	["Attack1"] = "scythe_batscythe_attack1",
	["Attack2"] = "scythe_batscythe_attack2",
	["Dash"] = nil,
	["AttackHit1"] = nil,
	["AttackHit2"] = nil
})
v96("Cryo Scythe", "rbxassetid://119930754357379", "rbxassetid://84690820919174", nil, nil, nil, nil, "scythe_cryoscythe_equip", "scythe_idle", "scythe_sprint", "scythe_inspect", nil, {
	["Attack1"] = "scythe_cryoscythe_attack1",
	["Attack2"] = "scythe_cryoscythe_attack2",
	["Dash"] = nil,
	["AttackHit1"] = nil,
	["AttackHit2"] = nil
})
v96("Bug Net", "rbxassetid://115620701626004", "rbxassetid://99173928762511", nil, nil, nil, nil, "scythe_bugnet_equip", "scythe_bugnet_idle", "scythe_bugnet_sprint", "scythe_bugnet_inspect", nil, {
	["Attack1"] = "scythe_bugnet_attack1",
	["Attack2"] = "scythe_bugnet_attack2",
	["Dash"] = nil,
	["AttackHit1"] = nil,
	["AttackHit2"] = nil
})
v96("Sakura Scythe", "rbxassetid://133811689655966", "rbxassetid://115063494552764", nil, nil, nil, nil, "scythe_equip", "scythe_idle", "scythe_sprint", "scythe_inspect", nil, {
	["Attack1"] = "scythe_sakurascythe_attack1",
	["Attack2"] = "scythe_sakurascythe_attack2",
	["Dash"] = nil,
	["AttackHit1"] = nil,
	["AttackHit2"] = nil
})
v96("Glorious Scythe", "rbxassetid://115811939422419", "rbxassetid://113721128462866", nil, nil, nil, nil, "scythe_equip", "scythe_idle", "scythe_sprint", "scythe_inspect", nil, {
	["Attack1"] = "scythe_attack1",
	["Attack2"] = "scythe_attack2",
	["Dash"] = nil,
	["AttackHit1"] = nil,
	["AttackHit2"] = nil
})
v96("Crystal Scythe", "rbxassetid://73971549402646", "rbxassetid://88778703942724", nil, nil, nil, CFrame.new(0, -0.25, 0), "scythe_crystalscythe_equip", "scythe_crystalscythe_idle", "scythe_crystalscythe_sprint", "scythe_crystalscythe_inspect", nil, {
	["Attack1"] = "scythe_crystalscythe_attack1",
	["Attack2"] = "scythe_crystalscythe_attack2",
	["Dash"] = "scythe_crystalscythe_dash",
	["AttackHit1"] = nil,
	["AttackHit2"] = nil
})
v96("Palm Scythe", "rbxassetid://97379805071194", "rbxassetid://100772860594083", nil, nil, nil, CFrame.new(0, -1, 0), "scythe_palmscythe_equip", "scythe_palmscythe_idle", "scythe_palmscythe_sprint", "scythe_palmscythe_inspect", nil, {
	["Attack1"] = "scythe_palmscythe_attack1",
	["Attack2"] = "scythe_palmscythe_attack2",
	["Dash"] = "scythe_palmscythe_dash",
	["AttackHit1"] = nil,
	["AttackHit2"] = nil
})
v96("Plastic Flamingo", "rbxassetid://112023194890462", "rbxassetid://106304321940736", nil, nil, nil, nil, "scythe_equip", "scythe_idle", "scythe_sprint", "scythe_inspect", nil, {
	["Attack1"] = "scythe_attack1",
	["Attack2"] = "scythe_attack2",
	["Dash"] = nil,
	["AttackHit1"] = nil,
	["AttackHit2"] = nil
})
v96("Gothic Pickaxe", "rbxassetid://85291165034948", "rbxassetid://104364622072464", nil, nil, nil, nil, "scythe_gothicpickaxe_equip", "scythe_gothicpickaxe_idle", "scythe_gothicpickaxe_sprint", "scythe_gothicpickaxe_inspect", nil, {
	["Attack1"] = "scythe_gothicpickaxe_attack1",
	["Attack2"] = "scythe_gothicpickaxe_attack2",
	["Dash"] = nil,
	["AttackHit1"] = "scythe_gothicpickaxe_attack_hit1",
	["AttackHit2"] = "scythe_gothicpickaxe_attack_hit2"
})
v96("Trowel", "rbxassetid://17160799172", "rbxassetid://16560547384", nil, "rbxassetid://103642431355604", 1.5, CFrame.new(0, -0.25, -0.375), "trowel_equip", "trowel_idle", "trowel_sprint", "trowel_inspect", nil, {
	["Attack1"] = "trowel_attack1",
	["Attack2"] = "trowel_attack2",
	["Build"] = "trowel_build"
})
v96("Plastic Shovel", "rbxassetid://17672062201", "rbxassetid://17672088012", nil, nil, nil, CFrame.new(0, -0.25, -0.375), "trowel_equip", "trowel_idle", "trowel_sprint", "trowel_inspect", nil, {
	["Attack1"] = "trowel_attack1",
	["Attack2"] = "trowel_attack2",
	["Build"] = "trowel_build"
})
v96("Garden Shovel", "rbxassetid://18766864873", "rbxassetid://18766908058", nil, nil, nil, CFrame.new(0, -0.25, -0.375), "trowel_equip", "trowel_idle", "trowel_sprint", "trowel_inspect", nil, {
	["Attack1"] = "trowel_attack1",
	["Attack2"] = "trowel_attack2",
	["Build"] = "trowel_build"
})
v96("Pumpkin Carver", "rbxassetid://78827307308671", "rbxassetid://130169648063116", nil, nil, nil, CFrame.new(0, -0.25, -0.375), "trowel_equip", "trowel_idle", "trowel_sprint", "trowel_inspect", nil, {
	["Attack1"] = "trowel_attack1",
	["Attack2"] = "trowel_attack2",
	["Build"] = "trowel_build"
})
v96("Snow Shovel", "rbxassetid://78271338778848", "rbxassetid://96400887574950", nil, nil, nil, CFrame.new(0, -0.25, -0.375), "trowel_equip", "trowel_idle", "trowel_sprint", "trowel_inspect", nil, {
	["Attack1"] = "trowel_attack1",
	["Attack2"] = "trowel_attack2",
	["Build"] = "trowel_build"
})
v96("Paintbrush", "rbxassetid://84687920829755", "rbxassetid://83196688094998", nil, nil, nil, CFrame.new(0, -0.25, -0.375), "trowel_equip", "trowel_idle", "trowel_sprint", "trowel_inspect", nil, {
	["Attack1"] = "trowel_attack1",
	["Attack2"] = "trowel_attack2",
	["Build"] = "trowel_build"
})
v96("Glorious Trowel", "rbxassetid://100888500368219", "rbxassetid://132433921578446", nil, nil, nil, CFrame.new(0, -0.25, -0.375), "trowel_equip", "trowel_idle", "trowel_sprint", "trowel_inspect", nil, {
	["Attack1"] = "trowel_attack1",
	["Attack2"] = "trowel_attack2",
	["Build"] = "trowel_build"
})
v96("Scooper", "rbxassetid://100816728062854", "rbxassetid://104183807294971", nil, nil, nil, CFrame.new(0, -0.25, -0.375), "trowel_equip", "trowel_idle", "trowel_sprint", "trowel_inspect", nil, {
	["Attack1"] = "trowel_attack1",
	["Attack2"] = "trowel_attack2",
	["Build"] = "trowel_build"
})
v96("Flare Gun", "rbxassetid://17160801627", "rbxassetid://13197583892", nil, "rbxassetid://113217458668564", 1.5, CFrame.new(0, -0.125, -0.25), "flaregun_equip", "flaregun_idle", "flaregun_sprint", "flaregun_inspect", nil, {
	["Shoot1"] = "flaregun_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = "flaregun_reload",
	["EmptyReload"] = nil,
	["EquipEmpty"] = "flaregun_equip_empty",
	["IdleEmpty"] = "flaregun_idle_empty",
	["SprintEmpty"] = "flaregun_sprint_empty",
	["InspectEmpty"] = "flaregun_inspect_empty"
})
v96("Firework Gun", "rbxassetid://17691132917", "rbxassetid://17691136322", nil, nil, nil, CFrame.new(0, -0.125, -0.25), "flaregun_equip", "flaregun_idle", "flaregun_sprint", "flaregun_inspect", nil, {
	["Shoot1"] = "flaregun_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = "flaregun_reload",
	["EmptyReload"] = nil,
	["EquipEmpty"] = "flaregun_equip_empty",
	["IdleEmpty"] = "flaregun_idle_empty",
	["SprintEmpty"] = "flaregun_sprint_empty",
	["InspectEmpty"] = "flaregun_inspect_empty"
})
v96("Dynamite Gun", "rbxassetid://18766865384", "rbxassetid://18766908547", nil, nil, nil, CFrame.new(0, -0.125, -0.25), "flaregun_equip", "flaregun_idle", "flaregun_sprint", "flaregun_inspect", nil, {
	["Shoot1"] = "flaregun_dynamitegun_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = "flaregun_reload",
	["EmptyReload"] = nil,
	["EquipEmpty"] = "flaregun_equip_empty",
	["IdleEmpty"] = "flaregun_idle_empty",
	["SprintEmpty"] = "flaregun_sprint_empty",
	["InspectEmpty"] = "flaregun_inspect_empty"
})
v96("Vexed Flare Gun", "rbxassetid://116287930550049", "rbxassetid://138983159218333", nil, nil, nil, CFrame.new(0, -0.125, -0.25), "flaregun_equip", "flaregun_idle", "flaregun_sprint", "flaregun_inspect", nil, {
	["Shoot1"] = "flaregun_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = "flaregun_reload",
	["EmptyReload"] = nil,
	["EquipEmpty"] = "flaregun_equip_empty",
	["IdleEmpty"] = "flaregun_idle_empty",
	["SprintEmpty"] = "flaregun_sprint_empty",
	["InspectEmpty"] = "flaregun_inspect_empty"
})
v96("Wrapped Flare Gun", "rbxassetid://135638020129378", "rbxassetid://135904023852615", nil, nil, nil, CFrame.new(0, -0.125, -0.25), "flaregun_wrappedflaregun_equip", "flaregun_idle", "flaregun_sprint", "flaregun_inspect", nil, {
	["Shoot1"] = "flaregun_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = "flaregun_reload",
	["EmptyReload"] = nil,
	["EquipEmpty"] = "flaregun_equip_empty",
	["IdleEmpty"] = "flaregun_idle_empty",
	["SprintEmpty"] = "flaregun_sprint_empty",
	["InspectEmpty"] = "flaregun_inspect_empty"
})
v96("Banana Flare", "rbxassetid://123589213761955", "rbxassetid://135246839855870", nil, nil, nil, CFrame.new(0, -0.125, -0.25), "flaregun_bananaflare_equip", "flaregun_bananaflare_idle", "flaregun_bananaflare_sprint", "flaregun_bananaflare_inspect", "flaregun_bananaflare_inspect_rare", {
	["Shoot1"] = "flaregun_bananaflare_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = "flaregun_bananaflare_reload",
	["EmptyReload"] = nil,
	["EquipEmpty"] = nil,
	["IdleEmpty"] = nil,
	["SprintEmpty"] = nil,
	["InspectEmpty"] = nil
})
v96("Glorious Flare Gun", "rbxassetid://115324763672074", "rbxassetid://128135635660577", nil, nil, nil, CFrame.new(0, -0.125, -0.25), "flaregun_equip", "flaregun_idle", "flaregun_sprint", "flaregun_inspect", nil, {
	["Shoot1"] = "flaregun_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = "flaregun_reload",
	["EmptyReload"] = nil,
	["EquipEmpty"] = "flaregun_equip_empty",
	["IdleEmpty"] = "flaregun_idle_empty",
	["SprintEmpty"] = "flaregun_sprint_empty",
	["InspectEmpty"] = "flaregun_inspect_empty"
})
v96("Pocket Volcano", "rbxassetid://133260045254190", "rbxassetid://132446634091281", nil, nil, nil, CFrame.new(0, -0.125, -0.25), "flaregun_pocketvolcano_equip", "flaregun_pocketvolcano_idle", "flaregun_pocketvolcano_sprint", "flaregun_pocketvolcano_inspect", nil, {
	["Shoot1"] = "flaregun_pocketvolcano_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = "flaregun_pocketvolcano_reload",
	["EmptyReload"] = nil,
	["EquipEmpty"] = nil,
	["IdleEmpty"] = nil,
	["SprintEmpty"] = nil,
	["InspectEmpty"] = nil
})
v96("Assault Rifle", "rbxassetid://17160682738", "rbxassetid://13197584241", nil, "rbxassetid://101393097640802", 2.5, CFrame.new(0, -0.125, -0.125) * CFrame.Angles(math.rad(2.5), 0, 0), "assaultrifle_equip", "assaultrifle_idle", "assaultrifle_sprint", "assaultrifle_inspect", nil, {
	["Shoot1"] = "assaultrifle_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = "assaultrifle_reload",
	["EmptyReload"] = nil
})
v96("AK-47", "rbxassetid://17691132793", "rbxassetid://17691136128", nil, nil, nil, CFrame.new(0, -0.125, -0.125) * CFrame.Angles(math.rad(2.5), 0, 0), "assaultrifle_equip", "assaultrifle_idle", "assaultrifle_sprint", "assaultrifle_inspect", nil, {
	["Shoot1"] = "assaultrifle_ak47_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = "assaultrifle_reload",
	["EmptyReload"] = nil
})
v96("Augmented Rifle", "rbxassetid://18770192853", "rbxassetid://18770201102", nil, nil, nil, CFrame.new(0.15, -0.2, -0.25) * CFrame.Angles(0, math.rad(-3), 0), "assaultrifle_aug_equip", "assaultrifle_aug_idle", "assaultrifle_aug_sprint", "assaultrifle_aug_inspect", nil, {
	["Shoot1"] = "assaultrifle_aug_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = "assaultrifle_aug_reload",
	["EmptyReload"] = nil
})
v96("Boneclaw Rifle", "rbxassetid://100015754284323", "rbxassetid://116725320040796", nil, nil, nil, CFrame.new(0, -0.125, -0.125) * CFrame.Angles(math.rad(2.5), 0, 0), "assaultrifle_equip", "assaultrifle_idle", "assaultrifle_sprint", "assaultrifle_inspect", nil, {
	["Shoot1"] = "assaultrifle_boneclawrifle_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = "assaultrifle_reload",
	["EmptyReload"] = nil
})
v96("AKEY-47", "rbxassetid://80017496220683", "rbxassetid://77244120212187", nil, nil, nil, CFrame.new(0, -0.125, -0.125) * CFrame.Angles(math.rad(2.5), 0, 0), "assaultrifle_akey47_equip", "assaultrifle_idle", "assaultrifle_sprint", "assaultrifle_akey47_inspect", nil, {
	["Shoot1"] = "assaultrifle_akey47_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = "assaultrifle_akey47_reload",
	["EmptyReload"] = nil
})
v96("Gingerbread Augmented Rifle", "rbxassetid://85584922619813", "rbxassetid://108476862508992", nil, nil, nil, CFrame.new(0.15, -0.2, -0.25) * CFrame.Angles(0, math.rad(-3), 0), "assaultrifle_gingerbreadaug_equip", "assaultrifle_gingerbreadaug_idle", "assaultrifle_gingerbreadaug_sprint", "assaultrifle_gingerbreadaug_inspect", nil, {
	["Shoot1"] = "assaultrifle_gingerbreadaug_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = "assaultrifle_gingerbreadaug_reload",
	["EmptyReload"] = nil
})
v96("Phoenix Rifle", "rbxassetid://140228738718621", "rbxassetid://115604025497445", nil, nil, nil, CFrame.new(0, -0.125, -0.125) * CFrame.Angles(math.rad(2.5), 0, 0), "assaultrifle_equip", "assaultrifle_idle", "assaultrifle_sprint", "assaultrifle_inspect", nil, {
	["Shoot1"] = "assaultrifle_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = "assaultrifle_reload",
	["EmptyReload"] = nil
})
v96("Drum Gun", "rbxassetid://111251887761435", "rbxassetid://84369917689099", nil, nil, nil, CFrame.new(0, -0.125, -0.125) * CFrame.Angles(math.rad(2.5), 0, 0), "assaultrifle_tommygun_equip", "assaultrifle_tommygun_idle", "assaultrifle_tommygun_sprint", "assaultrifle_tommygun_inspect", nil, {
	["Shoot1"] = "assaultrifle_tommygun_shoot1",
	["FinalShoot"] = "assaultrifle_tommygun_shoot_final",
	["Reload"] = "assaultrifle_tommygun_reload",
	["EmptyReload"] = "assaultrifle_tommygun_reload_empty",
	["EquipEmpty"] = "assaultrifle_tommygun_equip_empty",
	["IdleEmpty"] = "assaultrifle_tommygun_idle_empty",
	["SprintEmpty"] = "assaultrifle_tommygun_sprint_empty",
	["InspectEmpty"] = "assaultrifle_tommygun_inspect_empty"
})
v96("10B Visits", "rbxassetid://122165086598560", "rbxassetid://101791753953377", nil, nil, nil, CFrame.new(0, -0.125, -0.125) * CFrame.Angles(math.rad(2.5), 0, 0), "assaultrifle_equip", "assaultrifle_idle", "assaultrifle_sprint", "assaultrifle_inspect", nil, {
	["Shoot1"] = "assaultrifle_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = "assaultrifle_reload",
	["EmptyReload"] = nil
})
v96("Glorious Assault Rifle", "rbxassetid://130669996688265", "rbxassetid://130592949312939", nil, nil, nil, CFrame.new(0, -0.125, -0.125) * CFrame.Angles(math.rad(2.5), 0, 0), "assaultrifle_equip", "assaultrifle_idle", "assaultrifle_sprint", "assaultrifle_inspect", nil, {
	["Shoot1"] = "assaultrifle_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = "assaultrifle_reload",
	["EmptyReload"] = nil
})
v96("Pearl Rifle", "rbxassetid://135277426561503", "rbxassetid://103487000984145", nil, nil, nil, CFrame.new(0, -0.125, -0.125) * CFrame.Angles(math.rad(2.5), 0, 0), "assaultrifle_equip", "assaultrifle_idle", "assaultrifle_sprint", "assaultrifle_inspect", nil, {
	["Shoot1"] = "assaultrifle_pearlrifle_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = "assaultrifle_reload",
	["EmptyReload"] = nil
})
v96("Gothic Rifle", "rbxassetid://124295777941178", "rbxassetid://78516569222458", nil, nil, nil, CFrame.new(0, -0.125, -0.125) * CFrame.Angles(math.rad(2.5), 0, 0), "assaultrifle_equip", "assaultrifle_idle", "assaultrifle_sprint", "assaultrifle_inspect", nil, {
	["Shoot1"] = "assaultrifle_gothicrifle_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = "assaultrifle_reload",
	["EmptyReload"] = nil
})
v96("Handgun", "rbxassetid://17160801282", "rbxassetid://13197583693", nil, "rbxassetid://113347796650411", 1.5, CFrame.new(0.25, -0.125, -0.125) * CFrame.Angles(0, math.rad(5), (math.rad(-10))), "handgun_equip", "handgun_idle", "handgun_sprint", "handgun_inspect", nil, {
	["Shoot1"] = "handgun_shoot1",
	["FinalShoot"] = "handgun_shoot_final",
	["Reload"] = "handgun_reload",
	["EmptyReload"] = "handgun_reload_empty"
})
v96("Blaster", "rbxassetid://17821234554", "rbxassetid://17821265750", nil, nil, nil, CFrame.new(0.25, -0.125, -0.125) * CFrame.Angles(0, math.rad(5), (math.rad(-10))), "handgun_equip", "handgun_idle", "handgun_sprint", "handgun_inspect", nil, {
	["Shoot1"] = "handgun_blaster_shoot1",
	["FinalShoot"] = "handgun_blaster_shoot_final",
	["Reload"] = "handgun_reload",
	["EmptyReload"] = "handgun_reload_empty"
})
v96("Hand Gun", "rbxassetid://18837670624", "rbxassetid://18837677423", nil, nil, nil, CFrame.new(0.25, 0, -0.5) * CFrame.Angles(0, math.rad(5), (math.rad(-10))), "handgun_handgun_equip", "handgun_handgun_idle", "handgun_handgun_sprint", "handgun_handgun_inspect", "handgun_handgun_inspect_rare", {
	["Shoot1"] = "handgun_handgun_shoot1",
	["FinalShoot"] = "handgun_handgun_shoot_final",
	["Reload"] = "handgun_handgun_reload",
	["EmptyReload"] = "handgun_handgun_reload_empty"
})
v96("Pixel Handgun", "rbxassetid://82199841278177", "rbxassetid://72665687846028", nil, nil, nil, CFrame.new(0.25, -0.125, -0.125) * CFrame.Angles(0, math.rad(5), (math.rad(-10))), "handgun_pixelhandgun_equip", "handgun_pixelhandgun_idle", "handgun_pixelhandgun_sprint", "handgun_pixelhandgun_inspect", nil, {
	["Shoot1"] = "handgun_pixelhandgun_shoot1",
	["FinalShoot"] = "handgun_pixelhandgun_shoot_final",
	["Reload"] = "handgun_pixelhandgun_reload",
	["EmptyReload"] = "handgun_pixelhandgun_reload_empty"
}, {
	["FramesPerSecond"] = 2,
	["PlayAnimationsInstantly"] = true
})
v96("Pumpkin Handgun", "rbxassetid://88495685924653", "rbxassetid://92824393890642", nil, nil, nil, CFrame.new(0.25, -0.125, -0.125) * CFrame.Angles(0, math.rad(5), (math.rad(-10))), "handgun_equip", "handgun_idle", "handgun_sprint", "handgun_inspect", nil, {
	["Shoot1"] = "handgun_pumpkinhandgun_shoot1",
	["FinalShoot"] = "handgun_pumpkinhandgun_shoot_final",
	["Reload"] = "handgun_reload",
	["EmptyReload"] = "handgun_reload_empty"
})
v96("Gingerbread Handgun", "rbxassetid://95881238590412", "rbxassetid://72714528734588", nil, nil, nil, CFrame.new(0.25, -0.125, -0.125) * CFrame.Angles(0, math.rad(5), (math.rad(-10))), "handgun_equip", "handgun_idle", "handgun_sprint", "handgun_inspect", nil, {
	["Shoot1"] = "handgun_gingerbreadhandgun_shoot1",
	["FinalShoot"] = "handgun_gingerbreadhandgun_shoot_final",
	["Reload"] = "handgun_reload",
	["EmptyReload"] = "handgun_reload_empty"
})
v96("Gumball Handgun", "rbxassetid://106890990556815", "rbxassetid://138794077251754", nil, nil, nil, CFrame.new(0.25, -0.125, -0.125) * CFrame.Angles(0, math.rad(5), (math.rad(-10))), "handgun_equip", "handgun_idle", "handgun_sprint", "handgun_inspect", nil, {
	["Shoot1"] = "handgun_gumballhandgun_shoot1",
	["FinalShoot"] = "handgun_gumballhandgun_shoot_final",
	["Reload"] = "handgun_reload",
	["EmptyReload"] = "handgun_reload_empty"
})
v96("Stealth Handgun", "rbxassetid://124919185835138", "rbxassetid://99321324367928", nil, nil, nil, CFrame.new(0.25, -0.125, -0.125) * CFrame.Angles(0, math.rad(5), (math.rad(-10))), "handgun_equip", "handgun_idle", "handgun_sprint", "handgun_inspect", nil, {
	["Shoot1"] = "handgun_stealthhandgun_shoot1",
	["FinalShoot"] = "handgun_stealthhandgun_shoot_final",
	["Reload"] = "handgun_reload",
	["EmptyReload"] = "handgun_reload_empty"
})
v96("Glorious Handgun", "rbxassetid://85129427786041", "rbxassetid://73041314820303", nil, nil, nil, CFrame.new(0.25, -0.125, -0.125) * CFrame.Angles(0, math.rad(5), (math.rad(-10))), "handgun_equip", "handgun_idle", "handgun_sprint", "handgun_inspect", nil, {
	["Shoot1"] = "handgun_shoot1",
	["FinalShoot"] = "handgun_shoot_final",
	["Reload"] = "handgun_reload",
	["EmptyReload"] = "handgun_reload_empty"
})
v96("Warp Handgun", "rbxassetid://102974911528828", "rbxassetid://117404871573487", nil, nil, nil, CFrame.new(0.25, -0.125, -0.125) * CFrame.Angles(0, math.rad(5), (math.rad(-10))), "handgun_equip", "handgun_idle", "handgun_sprint", "handgun_inspect", nil, {
	["Shoot1"] = "handgun_shoot1",
	["FinalShoot"] = "handgun_shoot_final",
	["Reload"] = "handgun_reload",
	["EmptyReload"] = "handgun_reload_empty"
})
v96("Towerstone Handgun", "rbxassetid://88654252790032", "rbxassetid://116418326352365", nil, nil, nil, CFrame.new(0.25, -0.125, -0.125) * CFrame.Angles(0, math.rad(5), (math.rad(-10))), "handgun_equip", "handgun_idle", "handgun_sprint", "handgun_inspect", nil, {
	["Shoot1"] = "handgun_shoot1",
	["FinalShoot"] = "handgun_shoot_final",
	["Reload"] = "handgun_reload",
	["EmptyReload"] = "handgun_reload_empty"
})
v96("Sandgun", "rbxassetid://111746039012812", "rbxassetid://98739529709778", nil, nil, nil, CFrame.new(0.25, -0.125, -0.125) * CFrame.Angles(0, math.rad(5), (math.rad(-10))), "handgun_sandgun_equip", "handgun_idle", "handgun_sprint", "handgun_sandgun_inspect", nil, {
	["Shoot1"] = "handgun_sandgun_shoot1",
	["FinalShoot"] = "handgun_sandgun_shoot_final",
	["Reload"] = "handgun_sandgun_reload",
	["EmptyReload"] = "handgun_sandgun_reload_empty"
})
v96("Burst Rifle", "rbxassetid://17160801983", "rbxassetid://13482243466", nil, "rbxassetid://98231967024816", 2.5, CFrame.new(0, -0.125, 0), "burstrifle_equip", "burstrifle_idle", "burstrifle_sprint", "burstrifle_inspect", nil, {
	["Shoot1"] = "burstrifle_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = "burstrifle_reload",
	["EmptyReload"] = nil
})
v96("Electro Rifle", "rbxassetid://132227459821018", "rbxassetid://87621360986223", nil, nil, nil, CFrame.new(0, -0.125, 0), "burstrifle_equip", "burstrifle_idle", "burstrifle_sprint", "burstrifle_inspect", nil, {
	["Shoot1"] = "burstrifle_electrorifle_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = "burstrifle_electrorifle_reload",
	["EmptyReload"] = nil
})
v96("Aqua Burst", "rbxassetid://18837670807", "rbxassetid://18837677725", nil, nil, nil, CFrame.new(0, -0.125, 0), "burstrifle_equip", "burstrifle_idle", "burstrifle_sprint", "burstrifle_inspect", nil, {
	["Shoot1"] = "burstrifle_aquaburst_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = "burstrifle_reload",
	["EmptyReload"] = nil
})
v96("Pixel Burst", "rbxassetid://102648809593259", "rbxassetid://81440970309830", nil, nil, nil, CFrame.new(0, -0.125, 0), "burstrifle_pixelburst_equip", "burstrifle_pixelburst_idle", "burstrifle_pixelburst_sprint", "burstrifle_pixelburst_inspect", nil, {
	["Shoot1"] = "burstrifle_pixelburst_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = "burstrifle_pixelburst_reload",
	["EmptyReload"] = nil
}, {
	["FramesPerSecond"] = 2,
	["PlayAnimationsInstantly"] = true
})
v96("Spectral Burst", "rbxassetid://135012309412679", "rbxassetid://135650382469411", nil, nil, nil, CFrame.new(0, -0.125, 0), "burstrifle_equip", "burstrifle_idle", "burstrifle_sprint", "burstrifle_inspect", nil, {
	["Shoot1"] = "burstrifle_spectralburst_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = "burstrifle_reload",
	["EmptyReload"] = nil
})
v96("Pine Burst", "rbxassetid://132753732294083", "rbxassetid://100589243117991", nil, nil, nil, CFrame.new(0, -0.125, 0), "burstrifle_equip", "burstrifle_idle", "burstrifle_sprint", "burstrifle_inspect", nil, {
	["Shoot1"] = "burstrifle_pineburst_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = "burstrifle_reload",
	["EmptyReload"] = nil
})
v96("Bullpup Burst", "rbxassetid://74974560606812", "rbxassetid://110423034763836", nil, nil, nil, CFrame.new(0.25, -0.125, -0.25) * CFrame.Angles(0, math.rad(-5), 0), "burstrifle_famas_equip", "burstrifle_famas_idle", "burstrifle_famas_sprint", "burstrifle_famas_inspect", nil, {
	["Shoot1"] = "burstrifle_famas_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = "burstrifle_famas_reload",
	["EmptyReload"] = "burstrifle_famas_reload_empty"
})
v96("Glorious Burst Rifle", "rbxassetid://78517330608597", "rbxassetid://125258150017244", nil, nil, nil, CFrame.new(0, -0.125, 0), "burstrifle_equip", "burstrifle_idle", "burstrifle_sprint", "burstrifle_inspect", nil, {
	["Shoot1"] = "burstrifle_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = "burstrifle_reload",
	["EmptyReload"] = nil
})
v96("Keyst Rifle", "rbxassetid://78377522426003", "rbxassetid://138268719789353", nil, nil, nil, CFrame.new(0, 0, -0.5), "burstrifle_keystrifle_equip", "burstrifle_keystrifle_idle", "burstrifle_keystrifle_sprint", "burstrifle_keystrifle_inspect", nil, {
	["Shoot1"] = "burstrifle_keystrifle_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = "burstrifle_keystrifle_reload",
	["EmptyReload"] = nil
})
v96("Sand Bullpup Burst", "rbxassetid://130731663986683", "rbxassetid://139402443573256", nil, nil, nil, CFrame.new(0.25, -0.125, -0.25) * CFrame.Angles(0, math.rad(-5), 0), "burstrifle_famas_equip", "burstrifle_famas_idle", "burstrifle_famas_sprint", "burstrifle_sandfamas_inspect", nil, {
	["Shoot1"] = "burstrifle_sandfamas_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = "burstrifle_sandfamas_reload",
	["EmptyReload"] = "burstrifle_sandfamas_reload_empty"
})
v96("Shady Chicken Burst", "rbxassetid://134703354669459", "rbxassetid://85244455490707", nil, nil, nil, CFrame.new(0, -0.125, 0), "burstrifle_equip", "burstrifle_idle", "burstrifle_sprint", "burstrifle_inspect", nil, {
	["Shoot1"] = "burstrifle_shadychickenburst_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = "burstrifle_shadychickenburst_reload",
	["EmptyReload"] = nil
})
v96("Sniper", "rbxassetid://17160799574", "rbxassetid://13197583098", nil, "rbxassetid://132853334508822", 3.25, CFrame.new(0, -0.125, -0.125), "sniper_equip", "sniper_idle", "sniper_sprint", "sniper_inspect", nil, {
	["Shoot1"] = "sniper_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = "sniper_reload",
	["EmptyReload"] = "sniper_reload_empty"
})
v96("Pixel Sniper", "rbxassetid://17676081196", "rbxassetid://17676083400", nil, nil, nil, CFrame.new(0, -0.125, -0.125), "sniper_pixelsniper_equip", "sniper_pixelsniper_idle", "sniper_pixelsniper_sprint", "sniper_pixelsniper_inspect", nil, {
	["Shoot1"] = "sniper_pixelsniper_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = "sniper_pixelsniper_reload",
	["EmptyReload"] = "sniper_pixelsniper_reload_empty"
}, {
	["FramesPerSecond"] = 2,
	["PlayAnimationsInstantly"] = true
})
v96("Hyper Sniper", "rbxassetid://18766864081", "rbxassetid://18766907266", nil, nil, nil, CFrame.new(0, -0.125, -0.125), "sniper_equip", "sniper_idle", "sniper_sprint", "sniper_inspect", nil, {
	["Shoot1"] = "sniper_hypersniper_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = "sniper_reload",
	["EmptyReload"] = "sniper_reload_empty"
})
v96("Keyper", "rbxassetid://85472935605264", "rbxassetid://122634584511896", nil, nil, nil, CFrame.new(0, -0.125, -0.125), "sniper_keyper_equip", "sniper_idle", "sniper_sprint", "sniper_inspect", nil, {
	["Shoot1"] = "sniper_keyper_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = "sniper_reload",
	["EmptyReload"] = "sniper_reload_empty"
})
v96("Eyething Sniper", "rbxassetid://103915302076013", "rbxassetid://96377501719526", nil, nil, nil, CFrame.new(0, -0.125, -0.125), "sniper_equip", "sniper_idle", "sniper_sprint", "sniper_inspect", nil, {
	["Shoot1"] = "sniper_eyethingsniper_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = "sniper_reload",
	["EmptyReload"] = "sniper_reload_empty"
})
v96("Gingerbread Sniper", "rbxassetid://99943841952995", "rbxassetid://120163896680390", nil, nil, nil, CFrame.new(0, -0.125, -0.125), "sniper_equip", "sniper_idle", "sniper_sprint", "sniper_inspect", nil, {
	["Shoot1"] = "sniper_gingerbreadsniper_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = "sniper_reload",
	["EmptyReload"] = "sniper_reload_empty"
})
v96("Event Horizon", "rbxassetid://80749667426815", "rbxassetid://82446563771968", nil, nil, nil, CFrame.new(0, 0, -0.25), "sniper_eventhorizon_equip", "sniper_eventhorizon_idle", "sniper_eventhorizon_sprint", "sniper_eventhorizon_inspect", nil, {
	["Shoot1"] = "sniper_eventhorizon_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = "sniper_eventhorizon_reload",
	["EmptyReload"] = "sniper_eventhorizon_reload_empty"
})
v96("Glorious Sniper", "rbxassetid://118012090175286", "rbxassetid://94794978921271", nil, nil, nil, CFrame.new(0, -0.125, -0.125), "sniper_equip", "sniper_idle", "sniper_sprint", "sniper_inspect", nil, {
	["Shoot1"] = "sniper_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = "sniper_reload",
	["EmptyReload"] = "sniper_reload_empty"
})
v96("Kraken Sniper", "rbxassetid://95011666797584", "rbxassetid://99189706803523", nil, nil, nil, CFrame.new(-0.125, -0.125, -0.25) * CFrame.Angles(0, math.rad(-10), 0), "sniper_krakensniper_equip", "sniper_krakensniper_idle", "sniper_krakensniper_sprint", "sniper_krakensniper_inspect", nil, {
	["Shoot1"] = "sniper_krakensniper_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = "sniper_krakensniper_reload",
	["EmptyReload"] = "sniper_krakensniper_reload_empty"
})
v96("Campfire Sniper", "rbxassetid://127790438907599", "rbxassetid://129718669232752", nil, nil, nil, CFrame.new(0, -0.125, -0.125), "sniper_campfiresniper_equip", "sniper_idle", "sniper_sprint", "sniper_campfiresniper_inspect", nil, {
	["Shoot1"] = "sniper_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = "sniper_campfiresniper_reload",
	["EmptyReload"] = "sniper_campfiresniper_reload_empty"
})
v96("Light Fifty", "rbxassetid://138029440298487", "rbxassetid://92969788673528", nil, nil, nil, CFrame.new(0, 0, -0.25), "sniper_lightfifty_equip", "sniper_lightfifty_idle", "sniper_lightfifty_sprint", "sniper_lightfifty_inspect", nil, {
	["Shoot1"] = "sniper_lightfifty_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = "sniper_lightfifty_reload",
	["EmptyReload"] = "sniper_lightfifty_reload_empty"
})
v96("RPG", "rbxassetid://17160802243", "rbxassetid://13197583434", nil, "rbxassetid://95169761396387", 3.5, CFrame.new(0, -0.125, -0.25), "rpg_equip", "rpg_idle", "rpg_sprint", "rpg_inspect", "rpg_inspect_rare", {
	["Shoot1"] = "rpg_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = "rpg_reload",
	["EmptyReload"] = nil
})
v96("Nuke Launcher", "rbxassetid://17672061995", "rbxassetid://17672088925", nil, nil, nil, CFrame.new(0, -0.125, -0.25), "rpg_equip", "rpg_idle", "rpg_sprint", "rpg_inspect", "rpg_inspect_rare", {
	["Shoot1"] = "rpg_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = "rpg_reload",
	["EmptyReload"] = nil
})
v96("RPKEY", "rbxassetid://108438721125410", "rbxassetid://122750504849596", nil, nil, nil, CFrame.new(0, -0.125, -0.25), "rpg_rpkey_equip", "rpg_idle", "rpg_sprint", "rpg_inspect", "rpg_inspect_rare", {
	["Shoot1"] = "rpg_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = "rpg_reload",
	["EmptyReload"] = nil
})
v96("Spaceship Launcher", "rbxassetid://18766860860", "rbxassetid://18766904375", nil, nil, nil, CFrame.new(0, -0.125, -0.25), "rpg_equip", "rpg_idle", "rpg_sprint", "rpg_inspect", "rpg_inspect_rare", {
	["Shoot1"] = "rpg_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = "rpg_reload",
	["EmptyReload"] = nil
})
v96("Pumpkin Launcher", "rbxassetid://94648176067808", "rbxassetid://130301464984534", nil, nil, nil, CFrame.new(0.375, -0.5, -0.75), "rpg_equip", "rpg_idle", "rpg_sprint", "rpg_inspect", "rpg_inspect_rare", {
	["Shoot1"] = "rpg_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = "rpg_reload",
	["EmptyReload"] = nil
})
v96("Firework Launcher", "rbxassetid://75233372670156", "rbxassetid://93131277391830", nil, nil, nil, CFrame.new(0, -0.125, -0.25), "rpg_equip", "rpg_idle", "rpg_sprint", "rpg_inspect", "rpg_inspect_rare", {
	["Shoot1"] = "rpg_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = "rpg_reload",
	["EmptyReload"] = nil
})
v96("Squid Launcher", "rbxassetid://130764310743404", "rbxassetid://80877003243435", nil, nil, nil, CFrame.new(0.125, -0.25, -0.5) * CFrame.Angles(0, math.rad(5), 0), "rpg_equip", "rpg_idle", "rpg_sprint", "rpg_inspect", "rpg_inspect_rare", {
	["Shoot1"] = "rpg_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = "rpg_reload",
	["EmptyReload"] = nil
})
v96("Pencil Launcher", "rbxassetid://106934516693548", "rbxassetid://74125168400547", nil, nil, nil, CFrame.new(0, -0.25, -0.5) * CFrame.Angles(0, math.rad(5), 0), "rpg_equip", "rpg_idle", "rpg_sprint", "rpg_inspect", "rpg_inspect_rare", {
	["Shoot1"] = "rpg_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = "rpg_reload",
	["EmptyReload"] = nil
})
v96("Glorious RPG", "rbxassetid://130506879885802", "rbxassetid://77567945870953", nil, nil, nil, CFrame.new(0, -0.125, -0.25), "rpg_equip", "rpg_idle", "rpg_sprint", "rpg_inspect", "rpg_inspect_rare", {
	["Shoot1"] = "rpg_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = "rpg_reload",
	["EmptyReload"] = nil
})
v96("Rocket Launcher", "rbxassetid://116931956715309", "rbxassetid://90083302291399", nil, nil, nil, CFrame.new(0, -0.125, -0.25), "rpg_rocketlauncher_equip", "rpg_rocketlauncher_idle", "rpg_rocketlauncher_sprint", "rpg_rocketlauncher_inspect", nil, {
	["Shoot1"] = "rpg_rocketlauncher_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = "rpg_rocketlauncher_reload",
	["EmptyReload"] = nil
})
v96("Cupcake Launcher", "rbxassetid://100541838356180", "rbxassetid://126442330139931", nil, nil, nil, CFrame.new(0.125, -0.25, -0.5), "rpg_equip", "rpg_idle", "rpg_sprint", "rpg_inspect", "rpg_inspect_rare", {
	["Shoot1"] = "rpg_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = "rpg_reload",
	["EmptyReload"] = nil
})
v96("Sundae Launcher", "rbxassetid://70578055340962", "rbxassetid://99837466191060", nil, nil, nil, CFrame.new(0.375, -0.5, -0.75), "rpg_equip", "rpg_idle", "rpg_sprint", "rpg_inspect", "rpg_inspect_rare", {
	["Shoot1"] = "rpg_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = "rpg_reload",
	["EmptyReload"] = nil
})
v96("DIY RPKEY", "rbxassetid://140603792070249", "rbxassetid://92254402080932", nil, nil, nil, CFrame.new(0, -0.125, -0.25), "rpg_rpkey_equip", "rpg_idle", "rpg_sprint", "rpg_inspect", "rpg_inspect_rare", {
	["Shoot1"] = "rpg_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = "rpg_reload",
	["EmptyReload"] = nil
})
v96("Shorty", "rbxassetid://17160800091", "rbxassetid://13255103172", nil, "rbxassetid://89929289810261", 2, CFrame.new(0, -0.125, -0.25), "shorty_equip", "shorty_idle", "shorty_sprint", "shorty_inspect", "shorty_inspect_rare", {
	["Shoot1"] = "shorty_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = "shorty_reload",
	["EmptyReload"] = "shorty_reload_empty"
})
v96("Not So Shorty", "rbxassetid://17672062572", "rbxassetid://17672087325", nil, nil, nil, CFrame.new(0, -0.125, -0.25), "shorty_equip", "shorty_idle", "shorty_sprint", "shorty_inspect", "shorty_inspect_rare", {
	["Shoot1"] = "shorty_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = "shorty_reload",
	["EmptyReload"] = "shorty_reload_empty"
})
v96("Too Shorty", "rbxassetid://18129531276", "rbxassetid://18129532343", nil, nil, nil, CFrame.new(0, -0.125, -0.25), "shorty_equip", "shorty_idle", "shorty_sprint", "shorty_inspect", "shorty_inspect_rare", {
	["Shoot1"] = "shorty_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = "shorty_reload",
	["EmptyReload"] = "shorty_reload_empty"
})
v96("Lovely Shorty", "rbxassetid://18766862000", "rbxassetid://18766906011", nil, nil, nil, CFrame.new(0, -0.125, -0.25), "shorty_equip", "shorty_idle", "shorty_sprint", "shorty_inspect", "shorty_inspect_rare", {
	["Shoot1"] = "shorty_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = "shorty_reload",
	["EmptyReload"] = "shorty_reload_empty"
})
v96("Demon Shorty", "rbxassetid://116443498278384", "rbxassetid://110819203451709", nil, nil, nil, CFrame.new(0, -0.125, -0.25), "shorty_equip", "shorty_idle", "shorty_sprint", "shorty_inspect", "shorty_inspect_rare", {
	["Shoot1"] = "shorty_demonshorty_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = "shorty_reload",
	["EmptyReload"] = "shorty_reload_empty"
})
v96("Wrapped Shorty", "rbxassetid://136522183669611", "rbxassetid://85255622402845", nil, nil, nil, CFrame.new(0, -0.125, -0.25), "shorty_wrappedshorty_equip", "shorty_idle", "shorty_sprint", "shorty_inspect", "shorty_inspect_rare", {
	["Shoot1"] = "shorty_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = "shorty_reload",
	["EmptyReload"] = "shorty_reload_empty"
})
v96("Balloon Shorty", "rbxassetid://75590262133322", "rbxassetid://87872312114961", nil, nil, nil, CFrame.new(0, -0.125, -0.25), "shorty_equip", "shorty_idle", "shorty_sprint", "shorty_inspect", "shorty_balloonshorty_inspect_rare", {
	["Shoot1"] = "shorty_balloonshorty_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = "shorty_balloonshorty_reload",
	["EmptyReload"] = "shorty_balloonshorty_reload_empty"
})
v96("Glorious Shorty", "rbxassetid://105834197552222", "rbxassetid://78845944937729", nil, nil, nil, CFrame.new(0, -0.125, -0.25), "shorty_equip", "shorty_idle", "shorty_sprint", "shorty_inspect", "shorty_inspect_rare", {
	["Shoot1"] = "shorty_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = "shorty_reload",
	["EmptyReload"] = "shorty_reload_empty"
})
v96("Cannon Shorty", "rbxassetid://137616738436928", "rbxassetid://91250869936830", nil, nil, nil, CFrame.new(0, -0.125, -0.25), "shorty_equip", "shorty_idle", "shorty_sprint", "shorty_inspect", "shorty_inspect_rare", {
	["Shoot1"] = "shorty_cannonshorty_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = "shorty_reload2",
	["EmptyReload"] = "shorty_reload2_empty"
})
v96("Bubble Shorty", "rbxassetid://111294137896866", "rbxassetid://83774188272329", nil, nil, nil, CFrame.new(0, -0.125, -0.375), "shorty_bubbleshorty_equip", "shorty_bubbleshorty_idle", "shorty_bubbleshorty_sprint", "shorty_bubbleshorty_inspect", nil, {
	["Shoot1"] = "shorty_bubbleshorty_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = "shorty_bubbleshorty_reload",
	["EmptyReload"] = "shorty_bubbleshorty_reload_empty"
})
v96("Shotgun", "rbxassetid://17160800007", "rbxassetid://13197583302", nil, "rbxassetid://102792045452343", 2.75, CFrame.new(0, -0.25, -0.55), "shotgun_equip", "shotgun_idle", "shotgun_sprint", "shotgun_inspect", "shotgun_inspect_rare", {
	["Shoot1"] = "shotgun_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = nil,
	["EmptyReload"] = nil,
	["ReloadStart"] = "shotgun_reload_start",
	["ReloadSegment"] = "shotgun_reload_segment",
	["ReloadSegmentFinal"] = nil,
	["ReloadFinish"] = "shotgun_reload_finish",
	["EmptyReloadStart"] = "shotgun_reload_empty_start",
	["EmptyReloadSegment"] = "shotgun_reload_segment",
	["EmptyReloadSegmentFinal"] = nil,
	["EmptyReloadFinish"] = "shotgun_reload_empty_finish2"
})
v96("Balloon Shotgun", "rbxassetid://17821234823", "rbxassetid://17821266090", nil, nil, nil, CFrame.new(0, -0.25, -0.55), "shotgun_balloonshotgun_equip", "shotgun_idle", "shotgun_sprint", "shotgun_balloonshotgun_inspect", "shotgun_balloonshotgun_inspect_rare", {
	["Shoot1"] = "shotgun_balloonshotgun_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = nil,
	["EmptyReload"] = nil,
	["ReloadStart"] = "shotgun_reload_start",
	["ReloadSegment"] = "shotgun_balloonshotgun_reload_segment",
	["ReloadSegmentFinal"] = nil,
	["ReloadFinish"] = "shotgun_balloonshotgun_reload_finish",
	["EmptyReloadStart"] = "shotgun_balloonshotgun_reload_empty_start",
	["EmptyReloadSegment"] = "shotgun_balloonshotgun_reload_segment",
	["EmptyReloadSegmentFinal"] = nil,
	["EmptyReloadFinish"] = "shotgun_balloonshotgun_reload_empty_finish2"
})
v96("Hyper Shotgun", "rbxassetid://18768968419", "rbxassetid://18768974410", nil, nil, nil, CFrame.new(0, -0.25, -0.55), "shotgun_equip", "shotgun_idle", "shotgun_sprint", "shotgun_inspect", "shotgun_inspect_rare", {
	["Shoot1"] = "shotgun_hypershotgun_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = nil,
	["EmptyReload"] = nil,
	["ReloadStart"] = "shotgun_reload_start",
	["ReloadSegment"] = "shotgun_reload_segment",
	["ReloadSegmentFinal"] = nil,
	["ReloadFinish"] = "shotgun_reload_finish",
	["EmptyReloadStart"] = "shotgun_reload_empty_start",
	["EmptyReloadSegment"] = "shotgun_reload_segment",
	["EmptyReloadSegmentFinal"] = nil,
	["EmptyReloadFinish"] = "shotgun_reload_empty_finish2"
})
v96("Broomstick", "rbxassetid://118061559757082", "rbxassetid://126607371232554", nil, nil, nil, CFrame.new(0, -0.125, -0.5), "shotgun_broomstick_equip", "shotgun_idle", "shotgun_sprint", "shotgun_inspect", "shotgun_inspect_rare", {
	["Shoot1"] = "shotgun_broomstick_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = nil,
	["EmptyReload"] = nil,
	["ReloadStart"] = "shotgun_reload_start",
	["ReloadSegment"] = "shotgun_reload_segment",
	["ReloadSegmentFinal"] = nil,
	["ReloadFinish"] = "shotgun_reload_finish",
	["EmptyReloadStart"] = "shotgun_reload_empty_start",
	["EmptyReloadSegment"] = "shotgun_reload_segment",
	["EmptyReloadSegmentFinal"] = nil,
	["EmptyReloadFinish"] = "shotgun_reload_empty_finish2"
})
v96("Wrapped Shotgun", "rbxassetid://74894345245237", "rbxassetid://122560535811833", nil, nil, nil, CFrame.new(0, -0.125, -0.5), "shotgun_wrappedshotgun_equip", "shotgun_idle", "shotgun_sprint", "shotgun_inspect", "shotgun_inspect_rare", {
	["Shoot1"] = "shotgun_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = nil,
	["EmptyReload"] = nil,
	["ReloadStart"] = "shotgun_reload_start",
	["ReloadSegment"] = "shotgun_reload_segment",
	["ReloadSegmentFinal"] = nil,
	["ReloadFinish"] = "shotgun_reload_finish",
	["EmptyReloadStart"] = "shotgun_reload_empty_start",
	["EmptyReloadSegment"] = "shotgun_reload_segment",
	["EmptyReloadSegmentFinal"] = nil,
	["EmptyReloadFinish"] = "shotgun_reload_empty_finish2"
})
v96("Cactus Shotgun", "rbxassetid://131606483507460", "rbxassetid://128141817339029", nil, nil, nil, CFrame.new(0, -0.25, -0.55), "shotgun_equip", "shotgun_idle", "shotgun_sprint", "shotgun_inspect", "shotgun_inspect_rare", {
	["Shoot1"] = "shotgun_cactusshotgun_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = nil,
	["EmptyReload"] = nil,
	["ReloadStart"] = "shotgun_reload_start",
	["ReloadSegment"] = "shotgun_reload_segment",
	["ReloadSegmentFinal"] = nil,
	["ReloadFinish"] = "shotgun_reload_finish",
	["EmptyReloadStart"] = "shotgun_reload_empty_start",
	["EmptyReloadSegment"] = "shotgun_reload_segment",
	["EmptyReloadSegmentFinal"] = nil,
	["EmptyReloadFinish"] = "shotgun_reload_empty_finish2"
})
v96("Shotkey", "rbxassetid://93004214983981", "rbxassetid://101615278610735", nil, nil, nil, CFrame.new(0, 0, -0.5), "shotgun_shotkey_equip", "shotgun_shotkey_idle", "shotgun_shotkey_sprint", "shotgun_shotkey_inspect", nil, {
	["Shoot1"] = "shotgun_shotkey_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = nil,
	["EmptyReload"] = nil,
	["ReloadStart"] = "shotgun_shotkey_reload_start",
	["ReloadSegment"] = "shotgun_shotkey_reload_segment",
	["ReloadSegmentFinal"] = nil,
	["ReloadFinish"] = "shotgun_shotkey_reload_finish",
	["EmptyReloadStart"] = "shotgun_shotkey_reload_empty_start",
	["EmptyReloadSegment"] = "shotgun_shotkey_reload_segment",
	["EmptyReloadSegmentFinal"] = nil,
	["EmptyReloadFinish"] = "shotgun_shotkey_reload_empty_finish2",
	["EmptyInspect"] = "shotgun_shotkey_inspect_empty"
})
v96("Glorious Shotgun", "rbxassetid://71704618059601", "rbxassetid://104100596412940", nil, nil, nil, CFrame.new(0, -0.25, -0.55), "shotgun_equip", "shotgun_idle", "shotgun_sprint", "shotgun_inspect", "shotgun_inspect_rare", {
	["Shoot1"] = "shotgun_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = nil,
	["EmptyReload"] = nil,
	["ReloadStart"] = "shotgun_reload_start",
	["ReloadSegment"] = "shotgun_reload_segment",
	["ReloadSegmentFinal"] = nil,
	["ReloadFinish"] = "shotgun_reload_finish",
	["EmptyReloadStart"] = "shotgun_reload_empty_start",
	["EmptyReloadSegment"] = "shotgun_reload_segment",
	["EmptyReloadSegmentFinal"] = nil,
	["EmptyReloadFinish"] = "shotgun_reload_empty_finish2"
})
v96("Shark Shotgun", "rbxassetid://116415689080224", "rbxassetid://122650006341042", nil, nil, nil, CFrame.new(0, -0.25, -0.55), "shotgun_sharkshotgun_equip", "shotgun_sharkshotgun_idle", "shotgun_sharkshotgun_sprint", "shotgun_sharkshotgun_inspect", nil, {
	["Shoot1"] = "shotgun_sharkshotgun_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = nil,
	["EmptyReload"] = nil,
	["ReloadStart"] = "shotgun_sharkshotgun_reload_start",
	["ReloadSegment"] = "shotgun_sharkshotgun_reload_segment",
	["ReloadSegmentFinal"] = "shotgun_sharkshotgun_reload_segment_final",
	["ReloadFinish"] = "shotgun_sharkshotgun_reload_finish",
	["EmptyReloadStart"] = "shotgun_sharkshotgun_reload_empty_start",
	["EmptyReloadSegment"] = "shotgun_sharkshotgun_reload_segment",
	["EmptyReloadSegmentFinal"] = "shotgun_sharkshotgun_reload_segment_final",
	["EmptyReloadFinish"] = "shotgun_sharkshotgun_reload_empty_finish2"
})
v96("Bow", "rbxassetid://17160802080", "rbxassetid://13717212331", nil, "rbxassetid://108384017179119", 2, nil, "bow_equip", "bow_idle", "bow_sprint", "bow_inspect", nil, {
	["Shoot1"] = "bow_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = "bow_reload",
	["EmptyReload"] = nil,
	["Charge"] = "bow_charge",
	["ChargeLoop"] = "bow_charge_loop",
	["ChargeRelease"] = "bow_charge_release"
})
v96("Compound Bow", "rbxassetid://17672234242", "rbxassetid://17672229023", nil, nil, nil, nil, "bow_equip", "bow_idle", "bow_sprint", "bow_inspect", nil, {
	["Shoot1"] = "bow_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = "bow_reload",
	["EmptyReload"] = nil,
	["Charge"] = "bow_charge",
	["ChargeLoop"] = "bow_charge_loop",
	["ChargeRelease"] = "bow_charge_release"
})
v96("Raven Bow", "rbxassetid://18766861627", "rbxassetid://18766905321", nil, nil, nil, nil, "bow_ravenbow_equip", "bow_idle", "bow_sprint", "bow_inspect", nil, {
	["Shoot1"] = "bow_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = "bow_reload",
	["EmptyReload"] = nil,
	["Charge"] = "bow_charge",
	["ChargeLoop"] = "bow_charge_loop",
	["ChargeRelease"] = "bow_charge_release"
})
v96("Bat Bow", "rbxassetid://108984987378619", "rbxassetid://71508472340303", nil, nil, nil, nil, "bow_batbow_equip", "bow_idle", "bow_sprint", "bow_inspect", nil, {
	["Shoot1"] = "bow_batbow_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = "bow_reload",
	["EmptyReload"] = nil,
	["Charge"] = "bow_charge",
	["ChargeLoop"] = "bow_charge_loop",
	["ChargeRelease"] = "bow_batbow_charge_release"
})
v96("Frostbite Bow", "rbxassetid://121895626623160", "rbxassetid://82246935699705", nil, nil, nil, nil, "bow_frostbitebow_equip", "bow_idle", "bow_sprint", "bow_inspect", nil, {
	["Shoot1"] = "bow_frostbitebow_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = "bow_reload",
	["EmptyReload"] = nil,
	["Charge"] = "bow_charge",
	["ChargeLoop"] = "bow_charge_loop",
	["ChargeRelease"] = "bow_frostbitebow_charge_release"
})
v96("Dream Bow", "rbxassetid://101089313144218", "rbxassetid://104571173348964", nil, nil, nil, nil, "bow_dreambow_equip", "bow_idle", "bow_sprint", "bow_inspect", nil, {
	["Shoot1"] = "bow_dreambow_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = "bow_reload",
	["EmptyReload"] = nil,
	["Charge"] = "bow_charge",
	["ChargeLoop"] = "bow_charge_loop",
	["ChargeRelease"] = "bow_dreambow_charge_release"
})
v96("Key Bow", "rbxassetid://122525140091212", "rbxassetid://101924188286368", nil, nil, nil, CFrame.new(-0.125, -0.25, -0.5), "bow_keybow_equip", "bow_keybow_idle", "bow_keybow_sprint", "bow_keybow_inspect", "bow_keybow_inspect_rare", {
	["Shoot1"] = "bow_keybow_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = "bow_keybow_reload",
	["EmptyReload"] = nil,
	["Charge"] = "bow_keybow_charge",
	["ChargeLoop"] = "bow_keybow_charge_loop",
	["ChargeRelease"] = "bow_keybow_charge_release",
	["InspectEmpty"] = "bow_keybow_inspect_empty"
})
v96("Glorious Bow", "rbxassetid://84201415206621", "rbxassetid://139021383472653", nil, nil, nil, nil, "bow_equip", "bow_idle", "bow_sprint", "bow_inspect", nil, {
	["Shoot1"] = "bow_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = "bow_reload",
	["EmptyReload"] = nil,
	["Charge"] = "bow_charge",
	["ChargeLoop"] = "bow_charge_loop",
	["ChargeRelease"] = "bow_charge_release"
})
v96("Balloon Bow", "rbxassetid://128957010941029", "rbxassetid://123350417110914", nil, nil, nil, nil, "bow_balloonbow_equip", "bow_idle", "bow_sprint", "bow_inspect", nil, {
	["Shoot1"] = "bow_balloonbow_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = "bow_balloonbow_reload",
	["EmptyReload"] = nil,
	["Charge"] = "bow_charge",
	["ChargeLoop"] = "bow_charge_loop",
	["ChargeRelease"] = "bow_balloonbow_charge_release"
})
v96("Beloved Bow", "rbxassetid://110219131386799", "rbxassetid://92379249333386", nil, nil, nil, nil, "bow_belovedbow_equip", "bow_idle", "bow_sprint", "bow_inspect", nil, {
	["Shoot1"] = "bow_belovedbow_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = "bow_reload",
	["EmptyReload"] = nil,
	["Charge"] = "bow_charge",
	["ChargeLoop"] = "bow_charge_loop",
	["ChargeRelease"] = "bow_belovedbow_charge_release"
})
v96("Palm Bow", "rbxassetid://82899577710787", "rbxassetid://125910045538332", nil, nil, nil, nil, "bow_palmbow_equip", "bow_idle", "bow_sprint", "bow_inspect", nil, {
	["Shoot1"] = "bow_palmbow_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = "bow_reload",
	["EmptyReload"] = nil,
	["Charge"] = "bow_charge",
	["ChargeLoop"] = "bow_charge_loop",
	["ChargeRelease"] = "bow_palmbow_charge_release"
})
v96("Uzi", "rbxassetid://17160798908", "rbxassetid://14020829706", nil, "rbxassetid://83641084870257", 1.5, CFrame.new(0, -0.125, 0.125), "uzi_equip", "uzi_idle", "uzi_sprint", "uzi_inspect", nil, {
	["Shoot1"] = "uzi_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = "uzi_reload",
	["EmptyReload"] = nil
})
v96("Water Uzi", "rbxassetid://17821233590", "rbxassetid://17821264784", nil, nil, nil, CFrame.new(-0.125, -0.25, -0.375), "uzi_equip", "uzi_idle", "uzi_sprint", "uzi_inspect", nil, {
	["Shoot1"] = "uzi_wateruzi_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = "uzi_reload",
	["EmptyReload"] = nil
})
v96("Electro Uzi", "rbxassetid://96806694653207", "rbxassetid://98294074022488", nil, nil, nil, CFrame.new(0, -0.125, 0.125), "uzi_equip", "uzi_idle", "uzi_sprint", "uzi_inspect", nil, {
	["Shoot1"] = "uzi_electrouzi_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = "uzi_electrouzi_reload",
	["EmptyReload"] = nil
})
v96("Demon Uzi", "rbxassetid://132973040482576", "rbxassetid://81076572654230", nil, nil, nil, CFrame.new(0, -0.125, 0.125), "uzi_equip", "uzi_idle", "uzi_sprint", "uzi_inspect", nil, {
	["Shoot1"] = "uzi_demonuzi_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = "uzi_reload",
	["EmptyReload"] = nil
})
v96("Pine Uzi", "rbxassetid://82545206964916", "rbxassetid://80778273701013", nil, nil, nil, CFrame.new(0, -0.125, 0.125), "uzi_equip", "uzi_idle", "uzi_sprint", "uzi_inspect", nil, {
	["Shoot1"] = "uzi_pineuzi_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = "uzi_reload",
	["EmptyReload"] = nil
})
v96("Money Gun", "rbxassetid://100705725115757", "rbxassetid://73092203311844", nil, nil, nil, CFrame.new(0, -0.125, -0.125), "uzi_moneygun_equip", "uzi_moneygun_idle", "uzi_moneygun_sprint", "uzi_moneygun_inspect", nil, {
	["Shoot1"] = "uzi_moneygun_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = "uzi_moneygun_reload",
	["EmptyReload"] = nil
})
v96("Keyzi", "rbxassetid://100392703246534", "rbxassetid://127937206087121", nil, nil, nil, CFrame.new(0, -0.125, -0.375), "uzi_keyzi_equip", "uzi_keyzi_idle", "uzi_keyzi_sprint", "uzi_keyzi_inspect", nil, {
	["Shoot1"] = "uzi_keyzi_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = "uzi_keyzi_reload",
	["EmptyReload"] = nil
})
v96("Glorious Uzi", "rbxassetid://120045334159124", "rbxassetid://121978889022374", nil, nil, nil, CFrame.new(0, -0.125, 0.125), "uzi_equip", "uzi_idle", "uzi_sprint", "uzi_inspect", nil, {
	["Shoot1"] = "uzi_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = "uzi_reload",
	["EmptyReload"] = nil
})
v96("Arch Uzi", "rbxassetid://139852585731073", "rbxassetid://129292939007924", nil, nil, nil, CFrame.new(0, -0.125, 0.125), "uzi_archuzi_equip", "uzi_archuzi_idle", "uzi_archuzi_sprint", "uzi_archuzi_inspect", nil, {
	["Shoot1"] = "uzi_archuzi_shoot1",
	["FinalShoot"] = "uzi_archuzi_shoot_final",
	["Reload"] = "uzi_archuzi_reload",
	["EmptyReload"] = "uzi_archuzi_reload_empty",
	["EquipEmpty"] = "uzi_archuzi_equip_empty",
	["IdleEmpty"] = "uzi_archuzi_idle_empty",
	["SprintEmpty"] = "uzi_archuzi_sprint_empty",
	["InspectEmpty"] = "uzi_archuzi_inspect_empty"
})
v96("Ducky Uzi", "rbxassetid://133780419950894", "rbxassetid://104334764509025", nil, nil, nil, CFrame.new(0, -0.125, 0.125), "uzi_equip", "uzi_idle", "uzi_sprint", "uzi_inspect", nil, {
	["Shoot1"] = "uzi_duckyuzi_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = "uzi_reload",
	["EmptyReload"] = nil
})
v96("Revolver", "rbxassetid://17160800299", "rbxassetid://14020829500", nil, "rbxassetid://122164679882999", 1.5, CFrame.new(0, -0.125, -0.125), "revolver_equip", "revolver_idle", "revolver_sprint", "revolver_inspect", nil, {
	["Shoot1"] = "revolver_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = "revolver_reload",
	["EmptyReload"] = "revolver_reload_empty",
	["QuickShot"] = "revolver_quickshot",
	["FinalQuickShot"] = nil
})
v96("Desert Eagle", "rbxassetid://17821234372", "rbxassetid://17821265603", nil, nil, nil, CFrame.new(0.25, -0.125, -0.125) * CFrame.Angles(0, math.rad(5), (math.rad(-10))), "revolver_deserteagle_equip", "handgun_idle", "handgun_sprint", "handgun_inspect", nil, {
	["Shoot1"] = "revolver_deserteagle_shoot1",
	["FinalShoot"] = "revolver_deserteagle_shoot_final",
	["Reload"] = "revolver_deserteagle_reload",
	["EmptyReload"] = "revolver_deserteagle_reload_empty",
	["QuickShot"] = "revolver_deserteagle_shoot1",
	["FinalQuickShot"] = "revolver_deserteagle_shoot_final"
})
v96("Sheriff", "rbxassetid://18770192507", "rbxassetid://18770200449", nil, nil, nil, CFrame.new(0.25, -0.125, -0.375) * CFrame.Angles(0, math.rad(5), (math.rad(-10))), "revolver_sheriff_equip", "revolver_sheriff_idle", "revolver_sheriff_sprint", "revolver_sheriff_inspect", nil, {
	["Shoot1"] = "revolver_sheriff_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = "revolver_sheriff_reload",
	["EmptyReload"] = "revolver_sheriff_reload_empty",
	["QuickShot"] = "revolver_sheriff_quickshot",
	["FinalQuickShot"] = nil
})
v96("Boneclaw Revolver", "rbxassetid://119174697609264", "rbxassetid://134217952089145", nil, nil, nil, CFrame.new(0, -0.125, -0.125), "revolver_equip", "revolver_idle", "revolver_sprint", "revolver_inspect", nil, {
	["Shoot1"] = "revolver_boneclawrevolver_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = "revolver_reload",
	["EmptyReload"] = "revolver_reload_empty",
	["QuickShot"] = "revolver_boneclawrevolver_quickshot",
	["FinalQuickShot"] = nil
})
v96("Peppermint Sheriff", "rbxassetid://95859403750768", "rbxassetid://71229586558137", nil, nil, nil, CFrame.new(0.25, -0.125, -0.375) * CFrame.Angles(0, math.rad(5), (math.rad(-10))), "revolver_peppermintsheriff_equip", "revolver_peppermintsheriff_idle", "revolver_peppermintsheriff_sprint", "revolver_peppermintsheriff_inspect", nil, {
	["Shoot1"] = "revolver_peppermintsheriff_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = "revolver_peppermintsheriff_reload",
	["EmptyReload"] = "revolver_peppermintsheriff_reload_empty",
	["QuickShot"] = "revolver_peppermintsheriff_quickshot",
	["FinalQuickShot"] = nil
})
v96("Keyvolver", "rbxassetid://87974031410344", "rbxassetid://73746116648532", nil, nil, nil, CFrame.new(0, -0.125, -0.375), "revolver_keyvolver_equip", "revolver_keyvolver_idle", "revolver_keyvolver_sprint", "revolver_keyvolver_inspect", nil, {
	["Shoot1"] = "revolver_keyvolver_shoot1",
	["FinalShoot"] = "revolver_keyvolver_shoot_final",
	["Reload"] = "revolver_keyvolver_reload",
	["EmptyReload"] = "revolver_keyvolver_reload_empty",
	["QuickShot"] = "revolver_keyvolver_quickshot",
	["FinalQuickShot"] = nil,
	["EquipEmpty"] = "revolver_keyvolver_equip_empty",
	["IdleEmpty"] = "revolver_keyvolver_idle_empty",
	["SprintEmpty"] = "revolver_keyvolver_sprint_empty",
	["InspectEmpty"] = "revolver_keyvolver_inspect_empty"
})
v96("Peppergun", "rbxassetid://124178691056979", "rbxassetid://112311707478578", nil, nil, nil, CFrame.new(0.25, -0.125, -0.375) * CFrame.Angles(0, math.rad(5), (math.rad(-10))), "revolver_peppergun_equip", "revolver_peppergun_idle", "revolver_peppergun_sprint", "revolver_peppergun_inspect", nil, {
	["Shoot1"] = "revolver_peppergun_shoot1",
	["FinalShoot"] = "revolver_peppergun_shoot_final",
	["Reload"] = "revolver_peppergun_reload",
	["EmptyReload"] = "revolver_peppergun_reload_empty",
	["QuickShot"] = "revolver_peppergun_quickshot",
	["FinalQuickShot"] = nil,
	["EquipEmpty"] = "revolver_peppergun_equip_empty",
	["IdleEmpty"] = "revolver_peppergun_idle_empty",
	["SprintEmpty"] = "revolver_peppergun_sprint_empty",
	["InspectEmpty"] = "revolver_peppergun_inspect_empty"
})
v96("Glorious Revolver", "rbxassetid://118135542031794", "rbxassetid://137749607553707", nil, nil, nil, CFrame.new(0, -0.125, -0.125), "revolver_equip", "revolver_idle", "revolver_sprint", "revolver_inspect", nil, {
	["Shoot1"] = "revolver_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = "revolver_reload",
	["EmptyReload"] = "revolver_reload_empty",
	["QuickShot"] = "revolver_quickshot",
	["FinalQuickShot"] = nil
})
v96("Cruise Revolver", "rbxassetid://72223124823807", "rbxassetid://118294610207863", nil, nil, nil, CFrame.new(-0.05, -0.2, -0.1), "revolver_cruiserevolver_equip", "revolver_cruiserevolver_idle", "revolver_cruiserevolver_sprint", "revolver_cruiserevolver_inspect", nil, {
	["Shoot1"] = "revolver_cruiserevolver_shoot1",
	["FinalShoot"] = "revolver_cruiserevolver_shoot_final",
	["Reload"] = "revolver_cruiserevolver_reload",
	["EmptyReload"] = "revolver_cruiserevolver_reload_empty",
	["QuickShot"] = "revolver_cruiserevolver_quickshot",
	["FinalQuickShot"] = nil,
	["EquipEmpty"] = "revolver_cruiserevolver_equip_empty",
	["IdleEmpty"] = "revolver_cruiserevolver_idle_empty",
	["SprintEmpty"] = "revolver_cruiserevolver_sprint_empty",
	["InspectEmpty"] = "revolver_cruiserevolver_inspect_empty"
})
v96("Paintball Gun", "rbxassetid://17160853798", "rbxassetid://16560547676", nil, "rbxassetid://82789508344248", 2, CFrame.new(0, -0.25, -0.375), "paintballgun_equip", "paintballgun_idle", "paintballgun_sprint", "paintballgun_inspect", nil, {
	["Shoot1"] = "paintballgun_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = "paintballgun_reload",
	["EmptyReload"] = nil,
	["Throw"] = "paintballgun_throw"
})
v96("Slime Gun", "rbxassetid://17672062472", "rbxassetid://17672087561", nil, nil, nil, CFrame.new(0, -0.25, -0.375), "paintballgun_equip", "paintballgun_idle", "paintballgun_sprint", "paintballgun_inspect", nil, {
	["Shoot1"] = "paintballgun_slimegun_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = "paintballgun_reload",
	["EmptyReload"] = nil,
	["Throw"] = "paintballgun_throw"
})
v96("Boba Gun", "rbxassetid://18768830660", "rbxassetid://18768828072", nil, nil, nil, CFrame.new(0, -0.25, -0.375), "paintballgun_equip", "paintballgun_idle", "paintballgun_sprint", "paintballgun_inspect", "paintballgun_bobagun_inspect_rare", {
	["Shoot1"] = "paintballgun_bobagun_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = "paintballgun_reload",
	["EmptyReload"] = nil,
	["Throw"] = "paintballgun_throw"
})
v96("Brain Gun", "rbxassetid://85970592668118", "rbxassetid://135843933439701", nil, nil, nil, CFrame.new(0, -0.25, -0.375), "paintballgun_equip", "paintballgun_idle", "paintballgun_sprint", "paintballgun_inspect", nil, {
	["Shoot1"] = "paintballgun_slimegun_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = "paintballgun_reload",
	["EmptyReload"] = nil,
	["Throw"] = "paintballgun_throw"
})
v96("Snowball Gun", "rbxassetid://113685354916533", "rbxassetid://78161595959189", nil, nil, nil, CFrame.new(0, -0.25, -0.375), "paintballgun_equip", "paintballgun_idle", "paintballgun_sprint", "paintballgun_inspect", nil, {
	["Shoot1"] = "paintballgun_snowballgun_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = "paintballgun_reload",
	["EmptyReload"] = nil,
	["Throw"] = "paintballgun_throw"
})
v96("Ketchup Gun", "rbxassetid://76083615050939", "rbxassetid://130402361506639", nil, nil, nil, CFrame.new(0, -0.25, -0.375), "paintballgun_equip", "paintballgun_idle", "paintballgun_sprint", "paintballgun_inspect", nil, {
	["Shoot1"] = "paintballgun_ketchupgun_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = "paintballgun_reload",
	["EmptyReload"] = nil,
	["Throw"] = "paintballgun_throw"
})
v96("Glorious Paintball Gun", "rbxassetid://86297318955856", "rbxassetid://92272641219379", nil, nil, nil, CFrame.new(0, -0.25, -0.375), "paintballgun_equip", "paintballgun_idle", "paintballgun_sprint", "paintballgun_inspect", nil, {
	["Shoot1"] = "paintballgun_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = "paintballgun_reload",
	["EmptyReload"] = nil,
	["Throw"] = "paintballgun_throw"
})
v96("Paintballoon Gun", "rbxassetid://100129918948246", "rbxassetid://71822933033710", nil, nil, nil, CFrame.new(0, -0.25, -0.375), "paintballgun_equip", "paintballgun_idle", "paintballgun_sprint", "paintballgun_inspect", nil, {
	["Shoot1"] = "paintballgun_paintballoongun_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = "paintballgun_paintballoongun_reload",
	["EmptyReload"] = nil,
	["Throw"] = "paintballgun_throw"
})
v96("Lemonade Gun", "rbxassetid://119390099120478", "rbxassetid://128074622676219", nil, nil, nil, CFrame.new(0, -0.25, -0.375), "paintballgun_equip", "paintballgun_idle", "paintballgun_sprint", "paintballgun_inspect", nil, {
	["Shoot1"] = "paintballgun_lemonadegun_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = "paintballgun_reload",
	["EmptyReload"] = nil,
	["Throw"] = "paintballgun_throw"
})
v96("Slingshot", "rbxassetid://17160799888", "rbxassetid://17095306079", nil, "rbxassetid://75643870124560", 1.25, CFrame.new(0, -0.375, -0.5), "slingshot_equip", "slingshot_idle", "slingshot_sprint", "slingshot_inspect", nil, {
	["Shoot1"] = "slingshot_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = nil,
	["EmptyReload"] = nil
})
v96("Goalpost", "rbxassetid://17672063165", "rbxassetid://17672086378", nil, nil, nil, CFrame.new(0, -0.375, -0.5), "slingshot_equip", "slingshot_idle", "slingshot_sprint", "slingshot_inspect", nil, {
	["Shoot1"] = "slingshot_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = nil,
	["EmptyReload"] = nil
})
v96("Stick", "rbxassetid://17672063048", "rbxassetid://17672086502", nil, nil, nil, CFrame.new(0, -0.375, -0.5), "slingshot_equip", "slingshot_idle", "slingshot_sprint", "slingshot_inspect", nil, {
	["Shoot1"] = "slingshot_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = nil,
	["EmptyReload"] = nil
})
v96("Boneshot", "rbxassetid://86606957688341", "rbxassetid://103283614012077", nil, nil, nil, CFrame.new(0, -0.375, -0.5), "slingshot_equip", "slingshot_idle", "slingshot_sprint", "slingshot_inspect", nil, {
	["Shoot1"] = "slingshot_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = nil,
	["EmptyReload"] = nil
})
v96("Reindeer Slingshot", "rbxassetid://121612921203624", "rbxassetid://106406735551091", nil, nil, nil, CFrame.new(0, -0.375, -0.5), "slingshot_equip", "slingshot_idle", "slingshot_sprint", "slingshot_inspect", nil, {
	["Shoot1"] = "slingshot_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = nil,
	["EmptyReload"] = nil
})
v96("Harp", "rbxassetid://80850043664453", "rbxassetid://89702051394732", nil, nil, nil, CFrame.new(0, -0.375, -0.5), "slingshot_harp_equip", "slingshot_harp_idle", "slingshot_harp_sprint", "slingshot_harp_inspect", nil, {
	["Shoot1"] = "slingshot_harp_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = nil,
	["EmptyReload"] = nil
})
v96("Glorious Slingshot", "rbxassetid://101195664167288", "rbxassetid://111031840425662", nil, nil, nil, CFrame.new(0, -0.375, -0.5), "slingshot_equip", "slingshot_idle", "slingshot_sprint", "slingshot_inspect", nil, {
	["Shoot1"] = "slingshot_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = nil,
	["EmptyReload"] = nil
})
v96("Lucky Horseshoe", "rbxassetid://131242126669282", "rbxassetid://126152077516450", nil, nil, nil, CFrame.new(0, -0.375, -0.5), "slingshot_equip", "slingshot_idle", "slingshot_sprint", "slingshot_inspect", nil, {
	["Shoot1"] = "slingshot_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = nil,
	["EmptyReload"] = nil
})
v96("Keyshot", "rbxassetid://74006265601388", "rbxassetid://112207648939743", nil, nil, nil, CFrame.new(0, -0.375, -0.5), "slingshot_keyshot_equip", "slingshot_keyshot_idle", "slingshot_keyshot_sprint", "slingshot_keyshot_inspect", nil, {
	["Shoot1"] = "slingshot_keyshot_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = nil,
	["EmptyReload"] = nil
})
v96("Palmshot", "rbxassetid://109640024736812", "rbxassetid://103005257458281", nil, nil, nil, CFrame.new(0, -0.375, -0.5), "slingshot_equip", "slingshot_idle", "slingshot_sprint", "slingshot_inspect", nil, {
	["Shoot1"] = "slingshot_palmshot_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = nil,
	["EmptyReload"] = nil
})
v96("Slingshotula", "rbxassetid://80781358359670", "rbxassetid://71477786597454", nil, nil, nil, CFrame.new(0, -0.375, -0.5), "slingshot_slingshotula_equip", "slingshot_idle", "slingshot_sprint", "slingshot_inspect", nil, {
	["Shoot1"] = "slingshot_slingshotula_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = nil,
	["EmptyReload"] = nil
})
v96("Grenade Launcher", "rbxassetid://17250453814", "rbxassetid://17250456230", nil, "rbxassetid://96911371491753", 2.75, CFrame.new(0, -0.125, -0.125) * CFrame.Angles(math.rad(5), 0, 0), "grenadelauncher_equip", "grenadelauncher_idle", "grenadelauncher_sprint", "grenadelauncher_inspect", nil, {
	["Shoot1"] = "grenadelauncher_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = "grenadelauncher_reload",
	["EmptyReload"] = nil
})
v96("Swashbuckler", "rbxassetid://17821233828", "rbxassetid://17821265007", nil, nil, nil, CFrame.new(0, -0.25, -0.5) * CFrame.Angles(math.rad(5), 0, 0), "grenadelauncher_equip", "grenadelauncher_idle", "grenadelauncher_sprint", "grenadelauncher_inspect", nil, {
	["Shoot1"] = "grenadelauncher_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = "grenadelauncher_reload",
	["EmptyReload"] = nil
})
v96("Uranium Launcher", "rbxassetid://18766860114", "rbxassetid://18766902983", nil, nil, nil, CFrame.new(0, -0.125, -0.125) * CFrame.Angles(math.rad(5), 0, 0), "grenadelauncher_equip", "grenadelauncher_idle", "grenadelauncher_sprint", "grenadelauncher_inspect", nil, {
	["Shoot1"] = "grenadelauncher_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = "grenadelauncher_reload",
	["EmptyReload"] = nil
})
v96("Skull Launcher", "rbxassetid://103257281022910", "rbxassetid://88061081371943", nil, nil, nil, CFrame.new(0, -0.25, -0.5) * CFrame.Angles(math.rad(5), 0, 0), "grenadelauncher_equip", "grenadelauncher_idle", "grenadelauncher_sprint", "grenadelauncher_inspect", nil, {
	["Shoot1"] = "grenadelauncher_skulllauncher_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = "grenadelauncher_reload",
	["EmptyReload"] = nil
})
v96("Snowball Launcher", "rbxassetid://112349955391111", "rbxassetid://136762406657736", nil, nil, nil, CFrame.new(0, -0.25, -0.5) * CFrame.Angles(math.rad(5), 0, 0), "grenadelauncher_snowballlauncher_equip", "grenadelauncher_idle", "grenadelauncher_sprint", "grenadelauncher_inspect", nil, {
	["Shoot1"] = "grenadelauncher_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = "grenadelauncher_reload",
	["EmptyReload"] = nil
})
v96("Gearnade Launcher", "rbxassetid://133756750612042", "rbxassetid://91208130484582", nil, nil, nil, CFrame.new(0, -0.375, -0.375) * CFrame.Angles(math.rad(5), 0, 0), "grenadelauncher_gearnadelauncher_equip", "grenadelauncher_idle", "grenadelauncher_sprint", "grenadelauncher_gearnadelauncher_inspect", nil, {
	["Shoot1"] = "grenadelauncher_gearnadelauncher_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = "grenadelauncher_gearnadelauncher_reload",
	["EmptyReload"] = nil
})
v96("Glorious Grenade Launcher", "rbxassetid://134130354519919", "rbxassetid://133636006123737", nil, nil, nil, CFrame.new(0, -0.125, -0.125) * CFrame.Angles(math.rad(5), 0, 0), "grenadelauncher_equip", "grenadelauncher_idle", "grenadelauncher_sprint", "grenadelauncher_inspect", nil, {
	["Shoot1"] = "grenadelauncher_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = "grenadelauncher_reload",
	["EmptyReload"] = nil
})
v96("Balloon Launcher", "rbxassetid://137862701599991", "rbxassetid://104286567552270", nil, nil, nil, CFrame.new(0, -0.125, -0.125) * CFrame.Angles(math.rad(5), 0, 0), "grenadelauncher_balloonlauncher_equip", "grenadelauncher_idle", "grenadelauncher_sprint", "grenadelauncher_balloonlauncher_inspect", nil, {
	["Shoot1"] = "grenadelauncher_balloonlauncher_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = "grenadelauncher_balloonlauncher_reload",
	["EmptyReload"] = nil
})
v96("Coconut Launcher", "rbxassetid://77621998397460", "rbxassetid://110218225884153", nil, nil, nil, CFrame.new(0, -0.125, -0.125) * CFrame.Angles(math.rad(2.5), 0, 0), "grenadelauncher_equip", "grenadelauncher_idle", "grenadelauncher_sprint", "grenadelauncher_inspect", nil, {
	["Shoot1"] = "grenadelauncher_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = "grenadelauncher_reload",
	["EmptyReload"] = nil
})
v96("Mineralite Launcher", "rbxassetid://96751866939398", "rbxassetid://131205902309376", nil, nil, nil, CFrame.new(0, -0.125, -0.125) * CFrame.Angles(math.rad(5), 0, 0), "grenadelauncher_equip", "grenadelauncher_idle", "grenadelauncher_sprint", "grenadelauncher_inspect", nil, {
	["Shoot1"] = "grenadelauncher_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = "grenadelauncher_reload",
	["EmptyReload"] = nil
})
v96("Minigun", "rbxassetid://17250458611", "rbxassetid://17250457775", nil, "rbxassetid://139259875015340", 3.25, CFrame.new(0, -0.375, -0.375) * CFrame.Angles(math.rad(5), math.rad(2), 0), "minigun_equip", "minigun_idle", "minigun_sprint", "minigun_inspect", nil, {
	["Shoot1"] = nil,
	["FinalShoot"] = nil,
	["Reload"] = nil,
	["EmptyReload"] = nil,
	["ChargeStart"] = "minigun_charge_start",
	["ChargeLoop"] = "minigun_charge_loop",
	["ChargeFinish"] = "minigun_charge_finish"
})
v96("Lasergun 3000", "rbxassetid://103437974285778", "rbxassetid://116040043955852", nil, nil, nil, CFrame.new(0, -0.5, -0.5) * CFrame.Angles(math.rad(5), math.rad(2), 0), "minigun_equip", "minigun_idle", "minigun_sprint", "minigun_inspect", nil, {
	["Shoot1"] = nil,
	["FinalShoot"] = nil,
	["Reload"] = nil,
	["EmptyReload"] = nil,
	["ChargeStart"] = "minigun_charge_start",
	["ChargeLoop"] = "minigun_charge_loop",
	["ChargeFinish"] = "minigun_charge_finish"
})
v96("Pixel Minigun", "rbxassetid://18766861798", "rbxassetid://18769001642", nil, nil, nil, CFrame.new(0, -0.375, -0.375) * CFrame.Angles(math.rad(5), math.rad(2), 0), "minigun_pixelminigun_equip", "minigun_pixelminigun_idle", "minigun_pixelminigun_sprint", "minigun_pixelminigun_inspect", nil, {
	["Shoot1"] = nil,
	["FinalShoot"] = nil,
	["Reload"] = nil,
	["EmptyReload"] = nil,
	["ChargeStart"] = "minigun_pixelminigun_charge_start",
	["ChargeLoop"] = "minigun_pixelminigun_charge_loop",
	["ChargeFinish"] = "minigun_pixelminigun_charge_finish"
}, {
	["FramesPerSecond"] = 2,
	["PlayAnimationsInstantly"] = true
})
v96("Pumpkin Minigun", "rbxassetid://77388785880854", "rbxassetid://101609024294564", nil, nil, nil, CFrame.new(0, -0.375, -0.375) * CFrame.Angles(math.rad(5), math.rad(2), 0), "minigun_equip", "minigun_idle", "minigun_sprint", "minigun_inspect", nil, {
	["Shoot1"] = nil,
	["FinalShoot"] = nil,
	["Reload"] = nil,
	["EmptyReload"] = nil,
	["ChargeStart"] = "minigun_charge_start",
	["ChargeLoop"] = "minigun_charge_loop",
	["ChargeFinish"] = "minigun_charge_finish"
})
v96("Wrapped Minigun", "rbxassetid://127077702465909", "rbxassetid://77902572458498", nil, nil, nil, CFrame.new(0, -0.375, -0.375) * CFrame.Angles(math.rad(5), math.rad(2), 0), "minigun_wrappedminigun_equip", "minigun_idle", "minigun_sprint", "minigun_inspect", nil, {
	["Shoot1"] = nil,
	["FinalShoot"] = nil,
	["Reload"] = nil,
	["EmptyReload"] = nil,
	["ChargeStart"] = "minigun_charge_start",
	["ChargeLoop"] = "minigun_charge_loop",
	["ChargeFinish"] = "minigun_charge_finish"
})
v96("Fighter Jet", "rbxassetid://70780739230558", "rbxassetid://95650502925488", nil, nil, nil, CFrame.new(0, -0.375, -0.375) * CFrame.Angles(math.rad(5), math.rad(2), 0), "minigun_fighterjet_equip", "minigun_fighterjet_idle", "minigun_fighterjet_sprint", "minigun_fighterjet_inspect", nil, {
	["Shoot1"] = nil,
	["FinalShoot"] = nil,
	["Reload"] = nil,
	["EmptyReload"] = nil,
	["ChargeStart"] = "minigun_fighterjet_charge_start",
	["ChargeLoop"] = "minigun_fighterjet_charge_loop",
	["ChargeFinish"] = "minigun_fighterjet_charge_finish"
})
v96("Glorious Minigun", "rbxassetid://84246894288637", "rbxassetid://99372535399034", nil, nil, nil, CFrame.new(0, -0.375, -0.375) * CFrame.Angles(math.rad(5), math.rad(2), 0), "minigun_equip", "minigun_idle", "minigun_sprint", "minigun_inspect", nil, {
	["Shoot1"] = nil,
	["FinalShoot"] = nil,
	["Reload"] = nil,
	["EmptyReload"] = nil,
	["ChargeStart"] = "minigun_charge_start",
	["ChargeLoop"] = "minigun_charge_loop",
	["ChargeFinish"] = "minigun_charge_finish"
})
v96("Shark Minigun", "rbxassetid://89295703576175", "rbxassetid://79060347820981", nil, nil, nil, CFrame.new(0, -0.375, -0.375) * CFrame.Angles(math.rad(5), math.rad(2), 0), "minigun_sharkminigun_equip", "minigun_sharkminigun_idle", "minigun_sharkminigun_sprint", "minigun_sharkminigun_inspect", nil, {
	["Shoot1"] = nil,
	["FinalShoot"] = nil,
	["Reload"] = nil,
	["EmptyReload"] = nil,
	["ChargeStart"] = "minigun_sharkminigun_charge_start",
	["ChargeLoop"] = "minigun_sharkminigun_charge_loop",
	["ChargeFinish"] = "minigun_sharkminigun_charge_finish"
})
v96("Exogun", "rbxassetid://17344796376", "rbxassetid://17344797370", nil, "rbxassetid://88192617023871", 1.5, CFrame.new(0, -0.25, 0) * CFrame.Angles(math.rad(5), 0, 0), "exogun_equip", "exogun_idle", "exogun_sprint", "exogun_inspect", nil, {
	["Shoot1"] = "exogun_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = "exogun_reload",
	["EmptyReload"] = nil
})
v96("Wondergun", "rbxassetid://17672060360", "rbxassetid://17672086052", nil, nil, nil, CFrame.new(0, -0.25, 0) * CFrame.Angles(math.rad(5), 0, 0), "exogun_equip", "exogun_idle", "exogun_sprint", "exogun_inspect", nil, {
	["Shoot1"] = "exogun_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = "exogun_reload",
	["EmptyReload"] = nil
})
v96("Singularity", "rbxassetid://17676876756", "rbxassetid://17676875650", nil, nil, nil, CFrame.new(0, -0.25, 0) * CFrame.Angles(math.rad(5), 0, 0), "exogun_singularity_equip", "exogun_idle", "exogun_sprint", "exogun_inspect", nil, {
	["Shoot1"] = "exogun_singularity_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = "exogun_singularity_reload",
	["EmptyReload"] = nil
})
v96("Ray Gun", "rbxassetid://18766861454", "rbxassetid://18766905089", nil, nil, nil, CFrame.new(0, -0.25, 0) * CFrame.Angles(math.rad(5), 0, 0), "exogun_equip", "exogun_idle", "exogun_sprint", "exogun_inspect", nil, {
	["Shoot1"] = "exogun_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = "exogun_reload",
	["EmptyReload"] = nil
})
v96("Exogourd", "rbxassetid://137140750597688", "rbxassetid://125880131168138", nil, nil, nil, CFrame.new(0, -0.25, 0) * CFrame.Angles(math.rad(5), 0, 0), "exogun_equip", "exogun_idle", "exogun_sprint", "exogun_inspect", nil, {
	["Shoot1"] = "exogun_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = "exogun_reload",
	["EmptyReload"] = nil
})
v96("Midnight Festive Exogun", "rbxassetid://127612442529810", "rbxassetid://80015495064851", nil, nil, nil, CFrame.new(0, -0.25, 0) * CFrame.Angles(math.rad(5), 0, 0), "exogun_equip", "exogun_idle", "exogun_sprint", "exogun_inspect", nil, {
	["Shoot1"] = "exogun_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = "exogun_reload",
	["EmptyReload"] = nil
})
v96("Repulsor", "rbxassetid://109263387714628", "rbxassetid://130472229545721", nil, nil, nil, CFrame.new(0, -0.25, -0.25) * CFrame.Angles(math.rad(5), 0, 0), "exogun_repulsor_equip", "exogun_repulsor_idle", "exogun_repulsor_sprint", "exogun_repulsor_inspect", nil, {
	["Shoot1"] = "exogun_repulsor_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = "exogun_repulsor_reload",
	["EmptyReload"] = nil
})
v96("Glorious Exogun", "rbxassetid://129125201034206", "rbxassetid://105785189977176", nil, nil, nil, CFrame.new(0, -0.25, 0) * CFrame.Angles(math.rad(5), 0, 0), "exogun_equip", "exogun_idle", "exogun_sprint", "exogun_inspect", nil, {
	["Shoot1"] = "exogun_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = "exogun_reload",
	["EmptyReload"] = nil
})
v96("Pearl Exogun", "rbxassetid://77698515863000", "rbxassetid://111669080370620", nil, nil, nil, CFrame.new(0, -0.25, 0) * CFrame.Angles(math.rad(5), 0, 0), "exogun_equip", "exogun_idle", "exogun_sprint", "exogun_inspect", nil, {
	["Shoot1"] = "exogun_pearlexogun_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = "exogun_pearlexogun_reload",
	["EmptyReload"] = nil
})
v96("Redman Exogun", "rbxassetid://74474414719419", "rbxassetid://99543672215626", nil, nil, nil, CFrame.new(0, -0.25, 0) * CFrame.Angles(math.rad(5), 0, 0), "exogun_redmanexogun_equip", "exogun_redmanexogun_idle", "exogun_redmanexogun_sprint", "exogun_redmanexogun_inspect", nil, {
	["Shoot1"] = "exogun_redmanexogun_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = "exogun_redmanexogun_reload",
	["EmptyReload"] = nil
})
v96("Gothic Exogun", "rbxassetid://88332782075679", "rbxassetid://80183553734275", nil, nil, nil, CFrame.new(0, -0.25, 0) * CFrame.Angles(math.rad(5), 0, 0), "exogun_equip", "exogun_idle", "exogun_sprint", "exogun_inspect", nil, {
	["Shoot1"] = "exogun_gothicexogun_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = "exogun_gothicexogun_reload",
	["EmptyReload"] = nil
})
v96("Freeze Ray", "rbxassetid://18429552328", "rbxassetid://18429549331", nil, "rbxassetid://72287797030544", 1.5, nil, "freezeray_equip", "freezeray_idle", "freezeray_sprint", "freezeray_inspect", nil, {
	["Shoot1"] = "freezeray_shoot1"
})
v96("Temporal Ray", "rbxassetid://18429552503", "rbxassetid://18429549663", nil, nil, nil, nil, "freezeray_equip", "freezeray_idle", "freezeray_sprint", "freezeray_inspect", nil, {
	["Shoot1"] = "freezeray_temporalray_shoot1"
})
v96("Bubble Ray", "rbxassetid://18766865819", "rbxassetid://18769002868", nil, nil, nil, nil, "freezeray_bubbleray_equip", "freezeray_idle", "freezeray_sprint", "freezeray_inspect", nil, {
	["Shoot1"] = "freezeray_shoot1"
})
v96("Spider Ray", "rbxassetid://136838810668332", "rbxassetid://92621276006979", nil, nil, nil, nil, "freezeray_spiderray_equip", "freezeray_spiderray_idle", "freezeray_spiderray_sprint", "freezeray_spiderray_inspect", nil, {
	["Shoot1"] = "freezeray_spiderray_shoot1"
})
v96("Wrapped Freeze Ray", "rbxassetid://76183738050112", "rbxassetid://77624613843681", nil, nil, nil, nil, "freezeray_wrappedfreezeray_equip", "freezeray_idle", "freezeray_sprint", "freezeray_inspect", nil, {
	["Shoot1"] = "freezeray_shoot1"
})
v96("Gum Ray", "rbxassetid://121504417727123", "rbxassetid://124339207784760", nil, nil, nil, nil, "freezeray_equip", "freezeray_idle", "freezeray_sprint", "freezeray_inspect", nil, {
	["Shoot1"] = "freezeray_shoot1"
})
v96("Glorious Freeze Ray", "rbxassetid://120211873831101", "rbxassetid://96505833323714", nil, nil, nil, nil, "freezeray_equip", "freezeray_idle", "freezeray_sprint", "freezeray_inspect", nil, {
	["Shoot1"] = "freezeray_shoot1"
})
v96("Cooler", "rbxassetid://117258208589940", "rbxassetid://114403955066222", nil, nil, nil, nil, "freezeray_cooler_equip", "freezeray_cooler_idle", "freezeray_cooler_sprint", "freezeray_cooler_inspect", nil, {
	["Shoot1"] = "freezeray_cooler_shoot1"
})
v96("War Horn", "rbxassetid://104600246515190", "rbxassetid://97997387092919", nil, "rbxassetid://98364412304002", 1.5, nil, "warhorn_equip", "warhorn_idle", "warhorn_sprint", "warhorn_inspect", nil, {
	["Use"] = "warhorn_use"
})
v96("Trumpet", "rbxassetid://88975601634708", "rbxassetid://113408430051712", nil, nil, nil, nil, "warhorn_equip", "warhorn_idle", "warhorn_sprint", "warhorn_inspect", nil, {
	["Use"] = "warhorn_trumpet_use"
})
v96("Mammoth Horn", "rbxassetid://93076834584542", "rbxassetid://107659166723688", nil, nil, nil, nil, "warhorn_equip", "warhorn_idle", "warhorn_sprint", "warhorn_inspect", nil, {
	["Use"] = "warhorn_mammothhorn_use"
})
v96("Megaphone", "rbxassetid://107074211847347", "rbxassetid://100739584109870", nil, nil, nil, nil, "warhorn_equip", "warhorn_idle", "warhorn_sprint", "warhorn_inspect", nil, {
	["Use"] = "warhorn_megaphone_use"
})
v96("Air Horn", "rbxassetid://111168146142976", "rbxassetid://128732687072177", nil, nil, nil, nil, "warhorn_equip", "warhorn_idle", "warhorn_sprint", "warhorn_inspect", nil, {
	["Use"] = "warhorn_airhorn_use"
})
v96("Glorious War Horn", "rbxassetid://96293355496772", "rbxassetid://123021790391323", nil, nil, nil, nil, "warhorn_equip", "warhorn_idle", "warhorn_sprint", "warhorn_inspect", nil, {
	["Use"] = "warhorn_use"
})
v96("Boneclaw Horn", "rbxassetid://138360812591331", "rbxassetid://126578341307256", nil, nil, nil, nil, "warhorn_boneclawhorn_equip", "warhorn_idle", "warhorn_sprint", "warhorn_inspect", nil, {
	["Use"] = "warhorn_boneclawhorn_use"
})
v96("Lifeguard Whistle", "rbxassetid://93791958663348", "rbxassetid://109008283215115", nil, nil, nil, nil, "warhorn_lifeguardwhistle_equip", "warhorn_lifeguardwhistle_idle", "warhorn_lifeguardwhistle_sprint", "warhorn_lifeguardwhistle_inspect", nil, {
	["Use"] = "warhorn_lifeguardwhistle_use"
})
v96("Gothic Horn", "rbxassetid://133426916370940", "rbxassetid://73647007049083", nil, nil, nil, nil, "warhorn_equip", "warhorn_idle", "warhorn_sprint", "warhorn_inspect", nil, {
	["Use"] = "warhorn_gothichorn_use"
})
v96("Satchel", "rbxassetid://82237471151891", "rbxassetid://132559258532984", nil, "rbxassetid://99042007892528", 1.5, nil, "satchel_equip", "grenade_idle", "grenade_sprint", "grenade_inspect", nil, {
	["ThrowStart"] = "grenade_throw_start",
	["ThrowIdle"] = "grenade_throw_idle",
	["ThrowFinish"] = "grenade_throw_finish",
	["LobStart"] = "grenade_lob_start",
	["LobIdle"] = "grenade_lob_idle",
	["LobFinish"] = "grenade_lob_finish",
	["Detonate"] = "satchel_detonate"
})
v96("Advanced Satchel", "rbxassetid://113860326910548", "rbxassetid://118684510688617", nil, nil, nil, nil, "satchel_equip", "grenade_idle", "grenade_sprint", "grenade_inspect", nil, {
	["ThrowStart"] = "grenade_throw_start",
	["ThrowIdle"] = "grenade_throw_idle",
	["ThrowFinish"] = "grenade_throw_finish",
	["LobStart"] = "grenade_lob_start",
	["LobIdle"] = "grenade_lob_idle",
	["LobFinish"] = "grenade_lob_finish",
	["Detonate"] = "satchel_advancedsatchel_detonate"
})
v96("Suspicious Gift", "rbxassetid://76209303162814", "rbxassetid://131542627171282", nil, nil, nil, nil, "satchel_suspiciousgift_equip", "grenade_idle", "grenade_sprint", "grenade_inspect", nil, {
	["ThrowStart"] = "grenade_throw_start",
	["ThrowIdle"] = "grenade_throw_idle",
	["ThrowFinish"] = "grenade_throw_finish",
	["LobStart"] = "grenade_lob_start",
	["LobIdle"] = "grenade_lob_idle",
	["LobFinish"] = "grenade_lob_finish",
	["Detonate"] = "satchel_detonate"
})
v96("Notebook Satchel", "rbxassetid://124817464748150", "rbxassetid://85589408404069", nil, nil, nil, nil, "satchel_equip", "grenade_idle", "grenade_sprint", "grenade_inspect", nil, {
	["ThrowStart"] = "grenade_throw_start",
	["ThrowIdle"] = "grenade_throw_idle",
	["ThrowFinish"] = "grenade_throw_finish",
	["LobStart"] = "grenade_lob_start",
	["LobIdle"] = "grenade_lob_idle",
	["LobFinish"] = "grenade_lob_finish",
	["Detonate"] = "satchel_detonate"
})
v96("Bag o\' Money", "rbxassetid://129192426700659", "rbxassetid://118634288543707", nil, nil, nil, nil, "satchel_equip", "grenade_idle", "grenade_sprint", "grenade_inspect", nil, {
	["ThrowStart"] = "grenade_throw_start",
	["ThrowIdle"] = "grenade_throw_idle",
	["ThrowFinish"] = "grenade_throw_finish",
	["LobStart"] = "grenade_lob_start",
	["LobIdle"] = "grenade_lob_idle",
	["LobFinish"] = "grenade_lob_finish",
	["Detonate"] = "satchel_detonate"
})
v96("Glorious Satchel", "rbxassetid://100521994805910", "rbxassetid://85737788428846", nil, nil, nil, nil, "satchel_equip", "grenade_idle", "grenade_sprint", "grenade_inspect", nil, {
	["ThrowStart"] = "grenade_throw_start",
	["ThrowIdle"] = "grenade_throw_idle",
	["ThrowFinish"] = "grenade_throw_finish",
	["LobStart"] = "grenade_lob_start",
	["LobIdle"] = "grenade_lob_idle",
	["LobFinish"] = "grenade_lob_finish",
	["Detonate"] = "satchel_detonate"
})
v96("Potion Satchel", "rbxassetid://76787046046890", "rbxassetid://112434777433399", nil, nil, nil, nil, "satchel_equip", "grenade_idle", "grenade_sprint", "grenade_inspect", nil, {
	["ThrowStart"] = "grenade_throw_start",
	["ThrowIdle"] = "grenade_throw_idle",
	["ThrowFinish"] = "grenade_throw_finish",
	["LobStart"] = "grenade_lob_start",
	["LobIdle"] = "grenade_lob_idle",
	["LobFinish"] = "grenade_lob_finish",
	["Detonate"] = "satchel_potionsatchel_detonate"
})
v96("Pizza Box", "rbxassetid://99166555665247", "rbxassetid://97977209980062", nil, nil, nil, nil, "satchel_pizzabox_equip", "satchel_pizzabox_idle", "satchel_pizzabox_sprint", "satchel_pizzabox_inspect", nil, {
	["ThrowStart"] = "satchel_pizzabox_throw_start",
	["ThrowIdle"] = "satchel_pizzabox_throw_idle",
	["ThrowFinish"] = "satchel_pizzabox_throw_finish",
	["LobStart"] = "satchel_pizzabox_throw_start",
	["LobIdle"] = "satchel_pizzabox_throw_idle",
	["LobFinish"] = "satchel_pizzabox_throw_finish",
	["Detonate"] = "satchel_pizzabox_detonate"
})
v96("Lifeguard Satchel", "rbxassetid://105277357472003", "rbxassetid://71359205931940", nil, nil, nil, nil, "satchel_equip", "grenade_idle", "grenade_sprint", "grenade_inspect", nil, {
	["ThrowStart"] = "grenade_throw_start",
	["ThrowIdle"] = "grenade_throw_idle",
	["ThrowFinish"] = "grenade_throw_finish",
	["LobStart"] = "grenade_lob_start",
	["LobIdle"] = "grenade_lob_idle",
	["LobFinish"] = "grenade_lob_finish",
	["Detonate"] = "satchel_lifeguardsatchel_detonate"
})
v96("Battle Axe", "rbxassetid://93390542043222", "rbxassetid://78364101927650", nil, "rbxassetid://89974468602998", 2, nil, "battleaxe_equip", "battleaxe_idle", "battleaxe_sprint", "battleaxe_inspect", nil, {
	["Attack1"] = "battleaxe_attack1",
	["Attack2"] = "battleaxe_attack2",
	["SpinAttack"] = "battleaxe_spinattack"
})
v96("The Shred", "rbxassetid://71234381808727", "rbxassetid://95922136476180", nil, nil, nil, nil, "battleaxe_equip", "battleaxe_idle", "battleaxe_sprint", "battleaxe_theshred_inspect", nil, {
	["Attack1"] = "battleaxe_theshred_attack1",
	["Attack2"] = "battleaxe_theshred_attack2",
	["SpinAttack"] = "battleaxe_theshred_spinattack"
})
v96("Nordic Axe", "rbxassetid://80052264197135", "rbxassetid://86476943038006", nil, nil, nil, nil, "battleaxe_equip", "battleaxe_idle", "battleaxe_sprint", "battleaxe_inspect", nil, {
	["Attack1"] = "battleaxe_nordicaxe_attack1",
	["Attack2"] = "battleaxe_nordicaxe_attack2",
	["SpinAttack"] = "battleaxe_nordicaxe_spinattack"
})
v96("Ban Axe", "rbxassetid://111046431576859", "rbxassetid://100159715604530", nil, nil, nil, nil, "battleaxe_equip", "battleaxe_idle", "battleaxe_sprint", "battleaxe_inspect", nil, {
	["Attack1"] = "battleaxe_banaxe_attack1",
	["Attack2"] = "battleaxe_banaxe_attack2",
	["SpinAttack"] = "battleaxe_banaxe_spinattack"
})
v96("Cerulean Axe", "rbxassetid://76353832683350", "rbxassetid://82989708806032", nil, nil, nil, nil, "battleaxe_equip", "battleaxe_idle", "battleaxe_sprint", "battleaxe_inspect", nil, {
	["Attack1"] = "battleaxe_ceruleanaxe_attack1",
	["Attack2"] = "battleaxe_ceruleanaxe_attack2",
	["SpinAttack"] = "battleaxe_ceruleanaxe_spinattack"
})
v96("Glorious Battle Axe", "rbxassetid://87227212476138", "rbxassetid://72356106057179", nil, nil, nil, nil, "battleaxe_equip", "battleaxe_idle", "battleaxe_sprint", "battleaxe_inspect", nil, {
	["Attack1"] = "battleaxe_attack1",
	["Attack2"] = "battleaxe_attack2",
	["SpinAttack"] = "battleaxe_spinattack"
})
v96("Mimic Axe", "rbxassetid://111717370450373", "rbxassetid://96746396437552", nil, nil, nil, nil, "battleaxe_equip", "battleaxe_idle", "battleaxe_sprint", "battleaxe_inspect", nil, {
	["Attack1"] = "battleaxe_mimicaxe_attack1",
	["Attack2"] = "battleaxe_mimicaxe_attack2",
	["SpinAttack"] = "battleaxe_mimicaxe_spinattack"
})
v96("Keyttle Axe", "rbxassetid://122117068984402", "rbxassetid://100168194779130", nil, nil, nil, nil, "battleaxe_keyttleaxe_equip", "battleaxe_keyttleaxe_idle", "battleaxe_keyttleaxe_sprint", "battleaxe_keyttleaxe_inspect", nil, {
	["Attack1"] = "battleaxe_keyttleaxe_attack1",
	["Attack2"] = "battleaxe_keyttleaxe_attack2",
	["SpinAttack"] = "battleaxe_keyttleaxe_spinattack"
})
v96("Balloon Axe", "rbxassetid://102429983628211", "rbxassetid://85852980135764", nil, nil, nil, nil, "battleaxe_equip", "battleaxe_idle", "battleaxe_sprint", "battleaxe_inspect", nil, {
	["Attack1"] = "battleaxe_balloonaxe_attack1",
	["Attack2"] = "battleaxe_balloonaxe_attack2",
	["SpinAttack"] = "battleaxe_balloonaxe_spinattack"
})
v96("Street Sign", "rbxassetid://121743888148209", "rbxassetid://81822645000119", nil, nil, nil, nil, "battleaxe_equip", "battleaxe_idle", "battleaxe_sprint", "battleaxe_inspect", nil, {
	["Attack1"] = "battleaxe_attack1",
	["Attack2"] = "battleaxe_attack2",
	["SpinAttack"] = "battleaxe_spinattack"
})
v96("Tiki Axe", "rbxassetid://87247443182820", "rbxassetid://89942969656097", nil, nil, nil, nil, "battleaxe_tikiaxe_equip", "battleaxe_idle", "battleaxe_sprint", "battleaxe_inspect", nil, {
	["Attack1"] = "battleaxe_tikiaxe_attack1",
	["Attack2"] = "battleaxe_tikiaxe_attack2",
	["SpinAttack"] = "battleaxe_tikiaxe_spinattack"
})
v96("Riot Shield", "rbxassetid://121172272442833", "rbxassetid://126785276332335", nil, "rbxassetid://97178934256596", 1.75, nil, "riotshield_equip", "riotshield_idle", "riotshield_sprint", "riotshield_inspect", nil, {
	["Attack1"] = "riotshield_attack1",
	["Attack2"] = "riotshield_attack2",
	["EmptyEquip"] = "fists_equip",
	["EmptyIdle"] = "fists_idle",
	["EmptyInspect"] = "fists_inspect",
	["EmptySprint"] = "fists_sprint"
})
v96("Door", "rbxassetid://79242603995428", "rbxassetid://137027368393353", nil, nil, nil, nil, "riotshield_equip", "riotshield_idle", "riotshield_sprint", "riotshield_inspect", nil, {
	["Attack1"] = "riotshield_attack1",
	["Attack2"] = "riotshield_attack2",
	["EmptyEquip"] = "fists_equip",
	["EmptyIdle"] = "fists_idle",
	["EmptyInspect"] = "fists_inspect",
	["EmptySprint"] = "fists_sprint"
})
v96("Sled", "rbxassetid://73881731607231", "rbxassetid://127016476735322", nil, nil, nil, nil, "riotshield_equip", "riotshield_idle", "riotshield_sprint", "riotshield_inspect", nil, {
	["Attack1"] = "riotshield_attack1",
	["Attack2"] = "riotshield_attack2",
	["EmptyEquip"] = "fists_equip",
	["EmptyIdle"] = "fists_idle",
	["EmptyInspect"] = "fists_inspect",
	["EmptySprint"] = "fists_sprint"
})
v96("Energy Shield", "rbxassetid://90215439337413", "rbxassetid://127037252186171", nil, nil, nil, nil, "riotshield_energyshield_equip", "riotshield_idle", "riotshield_sprint", "riotshield_inspect", nil, {
	["Attack1"] = "riotshield_energyshield_attack1",
	["Attack2"] = "riotshield_energyshield_attack2",
	["EmptyEquip"] = "fists_equip",
	["EmptyIdle"] = "fists_idle",
	["EmptyInspect"] = "fists_inspect",
	["EmptySprint"] = "fists_sprint"
})
v96("Masterpiece", "rbxassetid://79914271483818", "rbxassetid://72274483575028", nil, nil, nil, nil, "riotshield_equip", "riotshield_idle", "riotshield_sprint", "riotshield_inspect", nil, {
	["Attack1"] = "riotshield_attack1",
	["Attack2"] = "riotshield_attack2",
	["EmptyEquip"] = "fists_equip",
	["EmptyIdle"] = "fists_idle",
	["EmptyInspect"] = "fists_inspect",
	["EmptySprint"] = "fists_sprint"
})
v96("Glorious Riot Shield", "rbxassetid://132866851386509", "rbxassetid://117405461442739", nil, nil, nil, nil, "riotshield_equip", "riotshield_idle", "riotshield_sprint", "riotshield_inspect", nil, {
	["Attack1"] = "riotshield_attack1",
	["Attack2"] = "riotshield_attack2",
	["EmptyEquip"] = "fists_equip",
	["EmptyIdle"] = "fists_idle",
	["EmptyInspect"] = "fists_inspect",
	["EmptySprint"] = "fists_sprint"
})
v96("Tombstone Shield", "rbxassetid://125895528641243", "rbxassetid://114630737114417", nil, nil, nil, nil, "riotshield_equip", "riotshield_idle", "riotshield_sprint", "riotshield_inspect", nil, {
	["Attack1"] = "riotshield_attack1",
	["Attack2"] = "riotshield_attack2",
	["EmptyEquip"] = "fists_equip",
	["EmptyIdle"] = "fists_idle",
	["EmptyInspect"] = "fists_inspect",
	["EmptySprint"] = "fists_sprint"
})
v96("Broken Surfboard", "rbxassetid://114987869792187", "rbxassetid://100547242019243", nil, nil, nil, nil, "riotshield_equip", "riotshield_idle", "riotshield_sprint", "riotshield_inspect", nil, {
	["Attack1"] = "riotshield_attack1",
	["Attack2"] = "riotshield_attack2",
	["EmptyEquip"] = "fists_equip",
	["EmptyIdle"] = "fists_idle",
	["EmptyInspect"] = "fists_inspect",
	["EmptySprint"] = "fists_sprint"
})
v96("Arena Wall", "rbxassetid://93644415084045", "rbxassetid://137818378131073", nil, nil, nil, nil, "riotshield_equip", "riotshield_idle", "riotshield_sprint", "riotshield_inspect", nil, {
	["Attack1"] = "riotshield_attack1",
	["Attack2"] = "riotshield_attack2",
	["EmptyEquip"] = "fists_equip",
	["EmptyIdle"] = "fists_idle",
	["EmptyInspect"] = "fists_inspect",
	["EmptySprint"] = "fists_sprint"
})
v96("Daggers", "rbxassetid://91885384580845", "rbxassetid://138508026547275", nil, "rbxassetid://112790625455883", 2, CFrame.new(0, -0.125, -0.125), "daggers_equip", "daggers_idle", "daggers_sprint", "daggers_inspect", nil, {
	["Shoot1"] = "daggers_shoot1",
	["FinalShoot"] = "daggers_shoot2",
	["Reload"] = "daggers_reload",
	["EmptyReload"] = nil,
	["EmptyEquip"] = "fists_equip",
	["EmptyIdle"] = "fists_idle",
	["EmptyInspect"] = "fists_inspect"
})
v96("Aces", "rbxassetid://139089881483398", "rbxassetid://78850921968876", nil, nil, nil, CFrame.new(0, -0.125, -0.125), "daggers_equip", "daggers_idle", "daggers_sprint", "daggers_inspect", nil, {
	["Shoot1"] = "daggers_aces_shoot1",
	["FinalShoot"] = "daggers_aces_shoot2",
	["Reload"] = "daggers_aces_reload",
	["EmptyReload"] = nil,
	["EmptyEquip"] = "fists_equip",
	["EmptyIdle"] = "fists_idle",
	["EmptyInspect"] = "fists_inspect"
})
v96("Cookies", "rbxassetid://114482325531769", "rbxassetid://112581667413176", nil, nil, nil, CFrame.new(0, -0.125, -0.125), "daggers_equip", "daggers_idle", "daggers_sprint", "daggers_inspect", nil, {
	["Shoot1"] = "daggers_shoot1",
	["FinalShoot"] = "daggers_shoot2",
	["Reload"] = "daggers_cookies_reload",
	["EmptyReload"] = nil,
	["EmptyEquip"] = "fists_equip",
	["EmptyIdle"] = "fists_idle",
	["EmptyInspect"] = "fists_inspect"
})
v96("Crystal Daggers", "rbxassetid://126221748659600", "rbxassetid://92405854307880", nil, nil, nil, CFrame.new(0, -0.125, -0.125), "daggers_crystaldaggers_equip", "daggers_idle", "daggers_sprint", "daggers_crystaldaggers_inspect", nil, {
	["Shoot1"] = "daggers_crystaldaggers_shoot1",
	["FinalShoot"] = "daggers_crystaldaggers_shoot2",
	["Reload"] = "daggers_crystaldaggers_reload",
	["EmptyReload"] = nil,
	["EmptyEquip"] = "fists_equip",
	["EmptyIdle"] = "fists_idle",
	["EmptyInspect"] = "fists_inspect"
})
v96("Paper Planes", "rbxassetid://84003122595879", "rbxassetid://90572065167686", nil, nil, nil, CFrame.new(0, -0.125, -0.125), "daggers_equip", "daggers_idle", "daggers_sprint", "daggers_inspect", nil, {
	["Shoot1"] = "daggers_shoot1",
	["FinalShoot"] = "daggers_shoot2",
	["Reload"] = "daggers_paperplanes_reload",
	["EmptyReload"] = nil,
	["EmptyEquip"] = "fists_equip",
	["EmptyIdle"] = "fists_idle",
	["EmptyInspect"] = "fists_inspect"
})
v96("Shurikens", "rbxassetid://135574097643275", "rbxassetid://118592510576313", nil, nil, nil, CFrame.new(0, -0.125, -0.125), "daggers_equip", "daggers_idle", "daggers_sprint", "daggers_inspect", nil, {
	["Shoot1"] = "daggers_shurikens_shoot1",
	["FinalShoot"] = "daggers_shurikens_shoot2",
	["Reload"] = "daggers_reload",
	["EmptyReload"] = nil,
	["EmptyEquip"] = "fists_equip",
	["EmptyIdle"] = "fists_idle",
	["EmptyInspect"] = "fists_inspect"
})
v96("Glorious Daggers", "rbxassetid://76023189104485", "rbxassetid://89590724074968", nil, nil, nil, CFrame.new(0, -0.125, -0.125), "daggers_equip", "daggers_idle", "daggers_sprint", "daggers_inspect", nil, {
	["Shoot1"] = "daggers_shoot1",
	["FinalShoot"] = "daggers_shoot2",
	["Reload"] = "daggers_reload",
	["EmptyReload"] = nil,
	["EmptyEquip"] = "fists_equip",
	["EmptyIdle"] = "fists_idle",
	["EmptyInspect"] = "fists_inspect"
})
v96("Bat Daggers", "rbxassetid://92001964015225", "rbxassetid://137570635514267", nil, nil, nil, CFrame.new(0, -0.125, -0.125), "daggers_equip", "daggers_idle", "daggers_sprint", "daggers_inspect", nil, {
	["Shoot1"] = "daggers_batdaggers_shoot1",
	["FinalShoot"] = "daggers_batdaggers_shoot2",
	["Reload"] = "daggers_reload",
	["EmptyReload"] = nil,
	["EmptyEquip"] = "fists_equip",
	["EmptyIdle"] = "fists_idle",
	["EmptyInspect"] = "fists_inspect"
})
v96("Keynais", "rbxassetid://84562761142610", "rbxassetid://133742080595679", nil, nil, nil, CFrame.new(0, -0.125, -0.125), "daggers_keynais_equip", "daggers_keynais_idle", "daggers_keynais_sprint", "daggers_keynais_inspect", nil, {
	["Shoot1"] = "daggers_keynais_shoot1",
	["FinalShoot"] = "daggers_keynais_shoot2",
	["Reload"] = "daggers_keynais_reload",
	["EmptyReload"] = nil,
	["EmptyEquip"] = "fists_equip",
	["EmptyIdle"] = "fists_idle",
	["EmptyInspect"] = "fists_inspect"
})
v96("Broken Hearts", "rbxassetid://74156924296351", "rbxassetid://136682361594607", nil, nil, nil, CFrame.new(0, -0.125, -0.125), "daggers_brokenhearts_equip", "daggers_idle", "daggers_sprint", "daggers_inspect", nil, {
	["Shoot1"] = "daggers_brokenhearts_shoot1",
	["FinalShoot"] = "daggers_brokenhearts_shoot2",
	["Reload"] = "daggers_reload",
	["EmptyReload"] = nil,
	["EmptyEquip"] = "fists_equip",
	["EmptyIdle"] = "fists_idle",
	["EmptyInspect"] = "fists_inspect"
})
v96("Toaster", "rbxassetid://103344379002564", "rbxassetid://87473023041771", nil, nil, nil, CFrame.new(0, -0.125, -0.125), "daggers_toaster_equip", "daggers_toaster_idle", "daggers_toaster_sprint", "daggers_toaster_inspect", nil, {
	["Shoot1"] = "daggers_toaster_shoot1",
	["FinalShoot"] = "daggers_toaster_shoot2",
	["Reload"] = "daggers_toaster_reload",
	["EmptyReload"] = nil,
	["EmptyEquip"] = nil,
	["EmptyIdle"] = nil,
	["EmptyInspect"] = "daggers_toaster_inspect_empty"
})
v96("Starfish", "rbxassetid://114567820096083", "rbxassetid://71333279491287", nil, nil, nil, CFrame.new(0, -0.125, -0.125), "daggers_equip", "daggers_idle", "daggers_sprint", "daggers_inspect", nil, {
	["Shoot1"] = "daggers_shoot1",
	["FinalShoot"] = "daggers_shoot2",
	["Reload"] = "daggers_reload",
	["EmptyReload"] = nil,
	["EmptyEquip"] = "fists_equip",
	["EmptyIdle"] = "fists_idle",
	["EmptyInspect"] = "fists_inspect"
})
v96("Cursed Daggers", "rbxassetid://101796978041689", "rbxassetid://114490692504843", nil, nil, nil, CFrame.new(0, -0.125, -0.125), "daggers_curseddaggers_equip", "daggers_idle", "daggers_sprint", "daggers_inspect", nil, {
	["Shoot1"] = "daggers_curseddaggers_shoot1",
	["FinalShoot"] = "daggers_curseddaggers_shoot2",
	["Reload"] = "daggers_curseddaggers_reload",
	["EmptyReload"] = nil,
	["EmptyEquip"] = "fists_equip",
	["EmptyIdle"] = "fists_idle",
	["EmptyInspect"] = "fists_inspect"
})
v96("Energy Pistols", "rbxassetid://79471670126710", "rbxassetid://125338509278840", nil, "rbxassetid://110320793833810", 2.5, CFrame.new(0, -0.375, -0.375) * CFrame.Angles(math.rad(10), 0, 0), "energypistols_equip", "energypistols_idle", "energypistols_sprint", "energypistols_inspect", nil, {
	["Shoot1"] = "energypistols_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = nil,
	["EmptyReload"] = nil
})
v96("Hacker Pistols", "rbxassetid://140621407555872", "rbxassetid://105705939354438", nil, nil, nil, CFrame.new(0, -0.375, -0.375) * CFrame.Angles(math.rad(10), 0, 0), "energypistols_equip", "energypistols_idle", "energypistols_sprint", "energypistols_inspect", nil, {
	["Shoot1"] = "energypistols_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = nil,
	["EmptyReload"] = nil
})
v96("Apex Pistols", "rbxassetid://136156057859453", "rbxassetid://132394469151873", nil, nil, nil, CFrame.new(0, -0.375, -0.375) * CFrame.Angles(math.rad(10), 0, 0), "energypistols_equip", "energypistols_idle", "energypistols_sprint", "energypistols_inspect", nil, {
	["Shoot1"] = "energypistols_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = nil,
	["EmptyReload"] = nil
})
v96("New Year Energy Pistols", "rbxassetid://126589959779039", "rbxassetid://88240834599421", nil, nil, nil, CFrame.new(0, -0.375, -0.375) * CFrame.Angles(math.rad(10), 0, 0), "energypistols_equip", "energypistols_idle", "energypistols_sprint", "energypistols_inspect", nil, {
	["Shoot1"] = "energypistols_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = nil,
	["EmptyReload"] = nil
})
v96("Void Pistols", "rbxassetid://111278471262300", "rbxassetid://114821885011907", nil, nil, nil, CFrame.new(0, -0.375, -0.375) * CFrame.Angles(math.rad(10), 0, 0), "energypistols_voidpistols_equip", "energypistols_idle", "energypistols_sprint", "energypistols_voidpistols_inspect", nil, {
	["Shoot1"] = "energypistols_voidpistols_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = nil,
	["EmptyReload"] = nil
})
v96("Hydro Pistols", "rbxassetid://115281889984097", "rbxassetid://102390688726302", nil, nil, nil, CFrame.new(0, -0.375, -0.375) * CFrame.Angles(math.rad(10), 0, 0), "energypistols_equip", "energypistols_idle", "energypistols_sprint", "energypistols_inspect", nil, {
	["Shoot1"] = "energypistols_hydropistols_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = nil,
	["EmptyReload"] = nil
})
v96("Glorious Energy Pistols", "rbxassetid://114418789647547", "rbxassetid://85080210873739", nil, nil, nil, CFrame.new(0, -0.375, -0.375) * CFrame.Angles(math.rad(10), 0, 0), "energypistols_equip", "energypistols_idle", "energypistols_sprint", "energypistols_inspect", nil, {
	["Shoot1"] = "energypistols_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = nil,
	["EmptyReload"] = nil
})
v96("Soul Pistols", "rbxassetid://72213738067158", "rbxassetid://95359207769282", nil, nil, nil, CFrame.new(0, -0.375, -0.375) * CFrame.Angles(math.rad(10), 0, 0), "energypistols_soulpistols_equip", "energypistols_idle", "energypistols_sprint", "energypistols_inspect", nil, {
	["Shoot1"] = "energypistols_soulpistols_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = nil,
	["EmptyReload"] = nil
})
v96("Hyperlaser Guns", "rbxassetid://106947526362970", "rbxassetid://97275763845090", nil, nil, nil, CFrame.new(0, -0.375, -0.375) * CFrame.Angles(math.rad(10), 0, 0), "energypistols_hyperlaserguns_equip", "energypistols_idle", "energypistols_sprint", "energypistols_inspect", nil, {
	["Shoot1"] = "energypistols_hyperlaserguns_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = nil,
	["EmptyReload"] = nil
})
v96("Sol Pistols", "rbxassetid://115012735954576", "rbxassetid://131475504863136", nil, nil, nil, CFrame.new(0, -0.375, -0.375) * CFrame.Angles(math.rad(10), 0, 0), "energypistols_equip", "energypistols_idle", "energypistols_sprint", "energypistols_inspect", nil, {
	["Shoot1"] = "energypistols_solpistols_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = nil,
	["EmptyReload"] = nil
})
v96("Enerkey Pistols", "rbxassetid://116755982646605", "rbxassetid://132598841852147", nil, nil, nil, CFrame.new(0, -0.375, -0.375) * CFrame.Angles(math.rad(10), 0, 0), "energypistols_enerkeypistols_equip", "energypistols_enerkeypistols_idle", "energypistols_enerkeypistols_sprint", "energypistols_enerkeypistols_inspect", nil, {
	["Shoot1"] = "energypistols_enerkeypistols_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = nil,
	["EmptyReload"] = nil
})
v96("Energy Rifle", "rbxassetid://110259279810005", "rbxassetid://103736834693278", nil, "rbxassetid://129961481216137", 2.5, CFrame.new(0, -0.125, -0.125), "energyrifle_equip", "energyrifle_idle", "energyrifle_sprint", "energyrifle_inspect", nil, {
	["Shoot1"] = "energyrifle_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = nil,
	["EmptyReload"] = nil
})
v96("Hacker Rifle", "rbxassetid://122816271917525", "rbxassetid://89213922790170", nil, nil, nil, CFrame.new(0, -0.125, -0.125), "energyrifle_equip", "energyrifle_idle", "energyrifle_sprint", "energyrifle_inspect", nil, {
	["Shoot1"] = "energyrifle_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = nil,
	["EmptyReload"] = nil
})
v96("Apex Rifle", "rbxassetid://88144772234151", "rbxassetid://111748806401551", nil, nil, nil, CFrame.new(0, -0.125, -0.125), "energyrifle_equip", "energyrifle_idle", "energyrifle_sprint", "energyrifle_inspect", nil, {
	["Shoot1"] = "energyrifle_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = nil,
	["EmptyReload"] = nil
})
v96("New Year Energy Rifle", "rbxassetid://111446782522703", "rbxassetid://101868484686291", nil, nil, nil, CFrame.new(0, -0.125, -0.125), "energyrifle_equip", "energyrifle_idle", "energyrifle_sprint", "energyrifle_inspect", nil, {
	["Shoot1"] = "energyrifle_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = nil,
	["EmptyReload"] = nil
})
v96("Hydro Rifle", "rbxassetid://73690448730060", "rbxassetid://101984348353475", nil, nil, nil, CFrame.new(0, -0.125, -0.125), "energyrifle_equip", "energyrifle_idle", "energyrifle_sprint", "energyrifle_inspect", nil, {
	["Shoot1"] = "energyrifle_hydrorifle_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = nil,
	["EmptyReload"] = nil
})
v96("Void Rifle", "rbxassetid://95985016411441", "rbxassetid://107749233395884", nil, nil, nil, CFrame.new(0, -0.125, -0.125), "energyrifle_voidrifle_equip", "energyrifle_idle", "energyrifle_sprint", "energyrifle_inspect", nil, {
	["Shoot1"] = "energyrifle_voidrifle_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = nil,
	["EmptyReload"] = nil
})
v96("Glorious Energy Rifle", "rbxassetid://72632815443247", "rbxassetid://95552510838071", nil, nil, nil, CFrame.new(0, -0.125, -0.125), "energyrifle_equip", "energyrifle_idle", "energyrifle_sprint", "energyrifle_inspect", nil, {
	["Shoot1"] = "energyrifle_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = nil,
	["EmptyReload"] = nil
})
v96("Soul Rifle", "rbxassetid://129351366788323", "rbxassetid://140115840236565", nil, nil, nil, CFrame.new(0, -0.125, -0.125), "energyrifle_soulrifle_equip", "energyrifle_idle", "energyrifle_sprint", "energyrifle_inspect", nil, {
	["Shoot1"] = "energyrifle_soulrifle_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = nil,
	["EmptyReload"] = nil
})
v96("Sol Rifle", "rbxassetid://96272849525291", "rbxassetid://79567441337018", nil, nil, nil, CFrame.new(0, -0.125, -0.125), "energyrifle_equip", "energyrifle_idle", "energyrifle_sprint", "energyrifle_inspect", nil, {
	["Shoot1"] = "energyrifle_solrifle_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = nil,
	["EmptyReload"] = nil
})
v96("Enerkey Rifle", "rbxassetid://104929541135510", "rbxassetid://130531895348468", nil, nil, nil, CFrame.new(0, -0.125, -0.125), "energyrifle_enerkeyrifle_equip", "energyrifle_enerkeyrifle_idle", "energyrifle_enerkeyrifle_sprint", "energyrifle_enerkeyrifle_inspect", nil, {
	["Shoot1"] = "energyrifle_enerkeyrifle_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = nil,
	["EmptyReload"] = nil
})
v96("Arch Energy Rifle", "rbxassetid://102610226847610", "rbxassetid://103334245956021", nil, nil, nil, CFrame.new(0, -0.125, -0.125), "energyrifle_equip", "energyrifle_idle", "energyrifle_sprint", "energyrifle_inspect", nil, {
	["Shoot1"] = "energyrifle_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = nil,
	["EmptyReload"] = nil
})
v96("Spray", "rbxassetid://92882887485248", "rbxassetid://87291726953666", nil, "rbxassetid://100057833634628", 2.25, CFrame.new(0, -0.2, -0.15), "spray_equip", "spray_idle", "spray_sprint", "spray_inspect", nil, {
	["Shoot1"] = "spray_shoot1",
	["FinalShoot"] = "spray_shoot_final",
	["Reload"] = "spray_reload",
	["EmptyReload"] = "spray_reload_empty"
})
v96("Lovely Spray", "rbxassetid://131203015026683", "rbxassetid://138177960576401", nil, nil, nil, CFrame.new(0, -0.2, -0.3), "spray_equip", "spray_idle", "spray_sprint", "spray_inspect", nil, {
	["Shoot1"] = "spray_shoot1",
	["FinalShoot"] = "spray_shoot_final",
	["Reload"] = "spray_reload",
	["EmptyReload"] = "spray_reload_empty"
})
v96("Pine Spray", "rbxassetid://128285758736343", "rbxassetid://79010014206302", nil, nil, nil, CFrame.new(0, -0.2, -0.3), "spray_equip", "spray_idle", "spray_sprint", "spray_inspect", nil, {
	["Shoot1"] = "spray_pinespray_shoot1",
	["FinalShoot"] = "spray_pinespray_shoot_final",
	["Reload"] = "spray_reload",
	["EmptyReload"] = "spray_reload_empty"
})
v96("Nail Gun", "rbxassetid://110577809934251", "rbxassetid://79527532659144", nil, nil, nil, CFrame.new(0.125, -0.2, -0.15), "spray_equip", "spray_idle", "spray_sprint", "spray_inspect", nil, {
	["Shoot1"] = "spray_nailgun_shoot1",
	["FinalShoot"] = "spray_nailgun_shoot_final",
	["Reload"] = "spray_reload",
	["EmptyReload"] = "spray_nailgun_reload_empty"
})
v96("Spray Bottle", "rbxassetid://137955019285700", "rbxassetid://88384629194597", nil, nil, nil, CFrame.new(0, -0.2, -0.15), "spray_spraybottle_equip", "spray_idle", "spray_sprint", "spray_inspect", nil, {
	["Shoot1"] = "spray_spraybottle_shoot1",
	["FinalShoot"] = "spray_spraybottle_shoot_final",
	["Reload"] = "spray_spraybottle_reload",
	["EmptyReload"] = "spray_spraybottle_reload_empty"
})
v96("Glorious Spray", "rbxassetid://138246745001490", "rbxassetid://103484739840527", nil, nil, nil, CFrame.new(0, -0.2, -0.15), "spray_equip", "spray_idle", "spray_sprint", "spray_inspect", nil, {
	["Shoot1"] = "spray_shoot1",
	["FinalShoot"] = "spray_shoot_final",
	["Reload"] = "spray_reload",
	["EmptyReload"] = "spray_reload_empty"
})
v96("Boneclaw Spray", "rbxassetid://114078818081911", "rbxassetid://127336875478381", nil, nil, nil, CFrame.new(0, -0.2, -0.15), "spray_equip", "spray_idle", "spray_sprint", "spray_inspect", nil, {
	["Shoot1"] = "spray_boneclawspray_shoot1",
	["FinalShoot"] = "spray_boneclawspray_shoot_final",
	["Reload"] = "spray_reload",
	["EmptyReload"] = "spray_reload_empty"
})
v96("Key Spray", "rbxassetid://94061940442700", "rbxassetid://104758575159924", nil, nil, nil, CFrame.new(0, -0.1, -0.625), "spray_keyspray_equip", "spray_keyspray_idle", "spray_keyspray_sprint", "spray_keyspray_inspect", nil, {
	["Shoot1"] = "spray_keyspray_shoot1",
	["FinalShoot"] = "spray_keyspray_shoot_final",
	["Reload"] = "spray_keyspray_reload",
	["EmptyReload"] = "spray_keyspray_reload_empty"
})
v96("Campfire Spray", "rbxassetid://129294699009828", "rbxassetid://121514032743947", nil, nil, nil, CFrame.new(-0.125, -0.25, 0.125), "spray_campfirespray_equip", "spray_campfirespray_idle", "spray_campfirespray_sprint", "spray_campfirespray_inspect", nil, {
	["Shoot1"] = "spray_campfirespray_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = "spray_campfirespray_reload",
	["EmptyReload"] = "spray_campfirespray_reload_empty"
})
v96("Crossbow", "rbxassetid://140211832612284", "rbxassetid://130065160832422", nil, "rbxassetid://120023204894177", 3, CFrame.new(0.25, -0.375, -0.125) * CFrame.Angles(math.rad(5), 0, 0), "crossbow_equip", "crossbow_idle", "crossbow_sprint", "crossbow_inspect", nil, {
	["Shoot1"] = "crossbow_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = "crossbow_reload",
	["EmptyReload"] = nil
})
v96("Pixel Crossbow", "rbxassetid://115931961841903", "rbxassetid://129836248906904", nil, nil, nil, CFrame.new(0.25, -0.375, -0.125) * CFrame.Angles(math.rad(5), 0, 0), "crossbow_pixelcrossbow_equip", "crossbow_pixelcrossbow_idle", "crossbow_pixelcrossbow_sprint", "crossbow_pixelcrossbow_inspect", nil, {
	["Shoot1"] = "crossbow_pixelcrossbow_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = "crossbow_pixelcrossbow_reload",
	["EmptyReload"] = nil
}, {
	["FramesPerSecond"] = 2,
	["PlayAnimationsInstantly"] = true
})
v96("Frostbite Crossbow", "rbxassetid://101536997945363", "rbxassetid://116171878456521", nil, nil, nil, CFrame.new(0.25, -0.375, -0.125) * CFrame.Angles(math.rad(5), 0, 0), "crossbow_frostbitecrossbow_equip", "crossbow_idle", "crossbow_sprint", "crossbow_inspect", nil, {
	["Shoot1"] = "crossbow_frostbitecrossbow_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = "crossbow_frostbitecrossbow_reload",
	["EmptyReload"] = nil
})
v96("Harpoon Crossbow", "rbxassetid://107460405492001", "rbxassetid://127546301627893", nil, nil, nil, CFrame.new(0.25, -0.375, -0.125) * CFrame.Angles(math.rad(5), 0, 0), "crossbow_harpooncrossbow_equip", "crossbow_harpooncrossbow_idle", "crossbow_harpooncrossbow_sprint", "crossbow_harpooncrossbow_inspect", nil, {
	["Shoot1"] = "crossbow_harpooncrossbow_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = "crossbow_harpooncrossbow_reload",
	["EmptyReload"] = nil
})
v96("Violin Crossbow", "rbxassetid://74401302514014", "rbxassetid://119666131999240", nil, nil, nil, CFrame.new(0.25, -0.5, -0.125) * CFrame.Angles(math.rad(5), 0, 0), "crossbow_equip", "crossbow_violincrossbow_idle", "crossbow_sprint", "crossbow_inspect", "crossbow_violincrossbow_inspect_rare", {
	["Shoot1"] = "crossbow_violincrossbow_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = "crossbow_violincrossbow_reload",
	["EmptyReload"] = nil
})
v96("Glorious Crossbow", "rbxassetid://70875146419725", "rbxassetid://125494419498405", nil, nil, nil, CFrame.new(0.25, -0.375, -0.125) * CFrame.Angles(math.rad(5), 0, 0), "crossbow_equip", "crossbow_idle", "crossbow_sprint", "crossbow_inspect", nil, {
	["Shoot1"] = "crossbow_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = "crossbow_reload",
	["EmptyReload"] = nil
})
v96("Crossbone", "rbxassetid://103469183638638", "rbxassetid://81476287380261", nil, nil, nil, CFrame.new(0.25, -0.375, -0.125) * CFrame.Angles(math.rad(5), 0, 0), "crossbow_equip", "crossbow_idle", "crossbow_sprint", "crossbow_inspect", nil, {
	["Shoot1"] = "crossbow_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = "crossbow_reload",
	["EmptyReload"] = nil
})
v96("Arch Crossbow", "rbxassetid://94981733362451", "rbxassetid://107213949119266", nil, nil, nil, CFrame.new(-0.125, 0.125, -0.875) * CFrame.Angles(math.rad(-2.5), 0, 0), "crossbow_archcrossbow_equip", "crossbow_archcrossbow_idle", "crossbow_archcrossbow_sprint", "crossbow_archcrossbow_inspect", nil, {
	["Shoot1"] = "crossbow_archcrossbow_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = "crossbow_archcrossbow_reload",
	["EmptyReload"] = nil,
	["InspectEmpty"] = "crossbow_archcrossbow_inspect_empty"
})
v96("Campfire Crossbow", "rbxassetid://76911697867059", "rbxassetid://124546389126498", nil, nil, nil, CFrame.new(0.25, -0.375, -0.125) * CFrame.Angles(math.rad(5), 0, 0), "crossbow_campfirecrossbow_equip", "crossbow_idle", "crossbow_sprint", "crossbow_inspect", nil, {
	["Shoot1"] = "crossbow_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = "crossbow_reload",
	["EmptyReload"] = nil
})
v96("Spider Crossbow", "rbxassetid://127435004964157", "rbxassetid://95820307660313", nil, nil, nil, CFrame.new(0.25, -0.375, -0.125) * CFrame.Angles(math.rad(5), 0, 0), "crossbow_harpooncrossbow_equip", "crossbow_harpooncrossbow_idle", "crossbow_harpooncrossbow_sprint", "crossbow_harpooncrossbow_inspect", nil, {
	["Shoot1"] = "crossbow_spidercrossbow_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = "crossbow_harpooncrossbow_reload",
	["EmptyReload"] = nil
})
v96("Gunblade", "rbxassetid://131231034374465", "rbxassetid://131462750179690", nil, "rbxassetid://79528657538147", 3, CFrame.new(0.125, 0, 0) * CFrame.Angles(0, math.rad(2.5), 0), "gunblade_equip", "gunblade_idle", "gunblade_sprint", "gunblade_inspect", nil, {
	["Shoot1"] = "gunblade_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = nil,
	["EmptyReload"] = nil,
	["ToBlade"] = "gunblade_to_blade",
	["BladeEquip"] = "gunblade_equip_blade",
	["BladeIdle"] = "gunblade_idle_blade",
	["BladeSprint"] = "gunblade_sprint_blade",
	["BladeInspect"] = "gunblade_inspect_blade",
	["BladeAttack1"] = "gunblade_attack1_blade",
	["BladeAttack2"] = "gunblade_attack2_blade",
	["ToGun1"] = "gunblade_to_gun",
	["ToGun2"] = "gunblade_to_gun2",
	["BladeAttackOnHit"] = "gunblade_attack_blade_onhit",
	["BladeAttackOnHitNoAmmo"] = "gunblade_attack_blade_onhit2",
	["Dash"] = nil
})
v96("Hyper Gunblade", "rbxassetid://134415898983004", "rbxassetid://134499903901922", nil, nil, nil, CFrame.new(0.125, 0, 0) * CFrame.Angles(0, math.rad(2.5), 0), "gunblade_equip", "gunblade_idle", "gunblade_sprint", "gunblade_inspect", nil, {
	["Shoot1"] = "gunblade_hypergunblade_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = nil,
	["EmptyReload"] = nil,
	["ToBlade"] = "gunblade_to_blade",
	["BladeEquip"] = "gunblade_equip_blade",
	["BladeIdle"] = "gunblade_idle_blade",
	["BladeSprint"] = "gunblade_sprint_blade",
	["BladeInspect"] = "gunblade_inspect_blade",
	["BladeAttack1"] = "gunblade_hypergunblade_attack1_blade",
	["BladeAttack2"] = "gunblade_hypergunblade_attack2_blade",
	["ToGun1"] = "gunblade_to_gun",
	["ToGun2"] = "gunblade_to_gun2",
	["BladeAttackOnHit"] = "gunblade_hypergunblade_attack_blade_onhit",
	["BladeAttackOnHitNoAmmo"] = "gunblade_hypergunblade_attack_blade_onhit2",
	["Dash"] = nil
})
v96("Elf\'s Gunblade", "rbxassetid://114103306647123", "rbxassetid://81214817732179", nil, nil, nil, CFrame.new(0.125, 0, 0) * CFrame.Angles(0, math.rad(2.5), 0), "gunblade_equip", "gunblade_idle", "gunblade_sprint", "gunblade_inspect", nil, {
	["Shoot1"] = "gunblade_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = nil,
	["EmptyReload"] = nil,
	["ToBlade"] = "gunblade_to_blade",
	["BladeEquip"] = "gunblade_equip_blade",
	["BladeIdle"] = "gunblade_idle_blade",
	["BladeSprint"] = "gunblade_sprint_blade",
	["BladeInspect"] = "gunblade_inspect_blade",
	["BladeAttack1"] = "gunblade_attack1_blade",
	["BladeAttack2"] = "gunblade_attack2_blade",
	["ToGun1"] = "gunblade_to_gun",
	["ToGun2"] = "gunblade_to_gun2",
	["BladeAttackOnHit"] = "gunblade_attack_blade_onhit",
	["BladeAttackOnHitNoAmmo"] = "gunblade_attack_blade_onhit2",
	["Dash"] = nil
})
v96("Crude Gunblade", "rbxassetid://126996645502136", "rbxassetid://111573250598753", nil, nil, nil, CFrame.new(0.125, 0, 0) * CFrame.Angles(0, math.rad(2.5), 0), "gunblade_equip", "gunblade_idle", "gunblade_sprint", "gunblade_inspect", nil, {
	["Shoot1"] = "gunblade_crudegunblade_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = nil,
	["EmptyReload"] = nil,
	["ToBlade"] = "gunblade_to_blade",
	["BladeEquip"] = "gunblade_equip_blade",
	["BladeIdle"] = "gunblade_idle_blade",
	["BladeSprint"] = "gunblade_sprint_blade",
	["BladeInspect"] = "gunblade_inspect_blade",
	["BladeAttack1"] = "gunblade_crudegunblade_attack1_blade",
	["BladeAttack2"] = "gunblade_crudegunblade_attack2_blade",
	["ToGun1"] = "gunblade_to_gun",
	["ToGun2"] = "gunblade_to_gun2",
	["BladeAttackOnHit"] = "gunblade_crudegunblade_attack_blade_onhit",
	["BladeAttackOnHitNoAmmo"] = "gunblade_crudegunblade_attack_blade_onhit2",
	["Dash"] = nil
})
v96("Gunsaw", "rbxassetid://102700915422689", "rbxassetid://136642950174663", nil, nil, nil, CFrame.new(0.125, 0, 0) * CFrame.Angles(0, math.rad(2.5), 0), "gunblade_gunsaw_equip", "gunblade_gunsaw_idle", "gunblade_gunsaw_sprint", "gunblade_gunsaw_inspect", nil, {
	["Shoot1"] = "gunblade_gunsaw_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = nil,
	["EmptyReload"] = nil,
	["ToBlade"] = "gunblade_gunsaw_to_blade",
	["BladeEquip"] = "gunblade_gunsaw_equip_blade",
	["BladeIdle"] = "gunblade_gunsaw_idle_blade",
	["BladeSprint"] = "gunblade_gunsaw_sprint_blade",
	["BladeInspect"] = "gunblade_gunsaw_inspect_blade",
	["BladeAttack1"] = "gunblade_gunsaw_attack1_blade",
	["BladeAttack2"] = "gunblade_gunsaw_attack2_blade",
	["ToGun1"] = "gunblade_gunsaw_to_gun",
	["ToGun2"] = "gunblade_gunsaw_to_gun2",
	["BladeAttackOnHit"] = "gunblade_gunsaw_attack_blade_onhit",
	["BladeAttackOnHitNoAmmo"] = "gunblade_gunsaw_attack_blade_onhit2",
	["Dash"] = nil
})
v96("Glorious Gunblade", "rbxassetid://88003799126136", "rbxassetid://88582922101753", nil, nil, nil, CFrame.new(0.125, 0, 0) * CFrame.Angles(0, math.rad(2.5), 0), "gunblade_equip", "gunblade_idle", "gunblade_sprint", "gunblade_inspect", nil, {
	["Shoot1"] = "gunblade_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = nil,
	["EmptyReload"] = nil,
	["ToBlade"] = "gunblade_to_blade",
	["BladeEquip"] = "gunblade_equip_blade",
	["BladeIdle"] = "gunblade_idle_blade",
	["BladeSprint"] = "gunblade_sprint_blade",
	["BladeInspect"] = "gunblade_inspect_blade",
	["BladeAttack1"] = "gunblade_attack1_blade",
	["BladeAttack2"] = "gunblade_attack2_blade",
	["ToGun1"] = "gunblade_to_gun",
	["ToGun2"] = "gunblade_to_gun2",
	["BladeAttackOnHit"] = "gunblade_attack_blade_onhit",
	["BladeAttackOnHitNoAmmo"] = "gunblade_attack_blade_onhit2",
	["Dash"] = nil
})
v96("Boneblade", "rbxassetid://126327381608481", "rbxassetid://126287813768518", nil, nil, nil, CFrame.new(0.125, 0, 0) * CFrame.Angles(0, math.rad(2.5), 0), "gunblade_equip", "gunblade_idle", "gunblade_sprint", "gunblade_inspect", nil, {
	["Shoot1"] = "gunblade_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = nil,
	["EmptyReload"] = nil,
	["ToBlade"] = "gunblade_to_blade",
	["BladeEquip"] = "gunblade_equip_blade",
	["BladeIdle"] = "gunblade_idle_blade",
	["BladeSprint"] = "gunblade_sprint_blade",
	["BladeInspect"] = "gunblade_inspect_blade",
	["BladeAttack1"] = "gunblade_attack1_blade",
	["BladeAttack2"] = "gunblade_attack2_blade",
	["ToGun1"] = "gunblade_to_gun",
	["ToGun2"] = "gunblade_to_gun2",
	["BladeAttackOnHit"] = "gunblade_attack_blade_onhit",
	["BladeAttackOnHitNoAmmo"] = "gunblade_attack_blade_onhit2",
	["Dash"] = nil
})
v96("Keyblade", "rbxassetid://117153249348040", "rbxassetid://131097713481055", nil, nil, nil, nil, "gunblade_keyblade_equip", "gunblade_keyblade_idle", "gunblade_keyblade_sprint", "gunblade_keyblade_inspect", nil, {
	["Shoot1"] = "gunblade_keyblade_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = nil,
	["EmptyReload"] = nil,
	["ToBlade"] = "gunblade_keyblade_to_blade",
	["BladeEquip"] = "gunblade_keyblade_equip_blade",
	["BladeIdle"] = "gunblade_keyblade_idle_blade",
	["BladeSprint"] = "gunblade_keyblade_sprint_blade",
	["BladeInspect"] = "gunblade_keyblade_inspect_blade",
	["BladeAttack1"] = "gunblade_keyblade_attack1_blade",
	["BladeAttack2"] = "gunblade_keyblade_attack2_blade",
	["ToGun1"] = "gunblade_keyblade_to_gun",
	["ToGun2"] = "gunblade_keyblade_to_gun2",
	["BladeAttackOnHit"] = "gunblade_keyblade_attack_blade_onhit",
	["BladeAttackOnHitNoAmmo"] = "gunblade_keyblade_attack_blade_onhit2",
	["Dash"] = "gunblade_keyblade_dash"
})
v96("Sharkbite", "rbxassetid://85479471132931", "rbxassetid://105863842643669", nil, nil, nil, CFrame.new(0.125, 0, 0) * CFrame.Angles(0, math.rad(2.5), 0), "gunblade_equip", "gunblade_idle", "gunblade_sprint", "gunblade_inspect", nil, {
	["Shoot1"] = "gunblade_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = nil,
	["EmptyReload"] = nil,
	["ToBlade"] = "gunblade_to_blade",
	["BladeEquip"] = "gunblade_equip_blade",
	["BladeIdle"] = "gunblade_idle_blade",
	["BladeSprint"] = "gunblade_sprint_blade",
	["BladeInspect"] = "gunblade_inspect_blade",
	["BladeAttack1"] = "gunblade_attack1_blade",
	["BladeAttack2"] = "gunblade_attack2_blade",
	["ToGun1"] = "gunblade_to_gun",
	["ToGun2"] = "gunblade_to_gun2",
	["BladeAttackOnHit"] = "gunblade_attack_blade_onhit",
	["BladeAttackOnHitNoAmmo"] = "gunblade_attack_blade_onhit2",
	["Dash"] = nil
})
v96("Batblade", "rbxassetid://77137375179306", "rbxassetid://74240780075364", nil, nil, nil, CFrame.new(0.125, 0, 0) * CFrame.Angles(0, math.rad(2.5), 0), "gunblade_batblade_equip", "gunblade_idle", "gunblade_sprint", "gunblade_inspect", nil, {
	["Shoot1"] = "gunblade_batblade_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = nil,
	["EmptyReload"] = nil,
	["ToBlade"] = "gunblade_to_blade",
	["BladeEquip"] = "gunblade_equip_blade",
	["BladeIdle"] = "gunblade_idle_blade",
	["BladeSprint"] = "gunblade_sprint_blade",
	["BladeInspect"] = "gunblade_inspect_blade",
	["BladeAttack1"] = "gunblade_batblade_attack1_blade",
	["BladeAttack2"] = "gunblade_batblade_attack2_blade",
	["ToGun1"] = "gunblade_to_gun",
	["ToGun2"] = "gunblade_to_gun2",
	["BladeAttackOnHit"] = "gunblade_batblade_attack_blade_onhit",
	["BladeAttackOnHitNoAmmo"] = "gunblade_batblade_attack_blade_onhit2",
	["Dash"] = nil
})
v96("Jump Pad", "rbxassetid://79459600453621", "rbxassetid://102532564314723", nil, "rbxassetid://113965546523164", 1.5, nil, "jumppad_equip", "jumppad_idle", "jumppad_sprint", "jumppad_inspect", nil, {
	["Use"] = "jumppad_use"
})
v96("Trampoline", "rbxassetid://103567857194140", "rbxassetid://92310435035049", nil, nil, nil, nil, "jumppad_equip", "jumppad_idle", "jumppad_sprint", "jumppad_inspect", nil, {
	["Use"] = "jumppad_use"
})
v96("Bounce House", "rbxassetid://71226436012588", "rbxassetid://79326657484315", nil, nil, nil, nil, "jumppad_equip", "jumppad_idle", "jumppad_sprint", "jumppad_inspect", nil, {
	["Use"] = "jumppad_use"
})
v96("Shady Chicken Sandwich", "rbxassetid://86361684164972", "rbxassetid://113753042073837", nil, nil, nil, nil, "jumppad_equip", "jumppad_idle", "jumppad_sprint", "jumppad_inspect", nil, {
	["Use"] = "jumppad_use"
})
v96("Glorious Jump Pad", "rbxassetid://71803398862947", "rbxassetid://96408475917789", nil, nil, nil, nil, "jumppad_equip", "jumppad_idle", "jumppad_sprint", "jumppad_inspect", nil, {
	["Use"] = "jumppad_use"
})
v96("Spider Web", "rbxassetid://84204578032332", "rbxassetid://133104747106136", nil, nil, nil, nil, "jumppad_equip", "jumppad_idle", "jumppad_sprint", "jumppad_inspect", nil, {
	["Use"] = "jumppad_use"
})
v96("Jolly Man", "rbxassetid://97375473537804", "rbxassetid://98002300428288", nil, nil, nil, nil, "jumppad_equip", "jumppad_idle", "jumppad_sprint", "jumppad_inspect", nil, {
	["Use"] = "jumppad_use"
})
v96("Flamingo Floatie", "rbxassetid://127511599700842", "rbxassetid://89246792456166", nil, nil, nil, nil, "jumppad_equip", "jumppad_idle", "jumppad_sprint", "jumppad_inspect", nil, {
	["Use"] = "jumppad_use"
})
v96("Scepter", "rbxassetid://99183402177823", "rbxassetid://89220212871603", nil, "rbxassetid://102084909464865", 3, nil, "scepter_equip", "scepter_idle", "scepter_sprint", "scepter_inspect", nil, {
	["Shoot1"] = "scepter_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = nil,
	["EmptyReload"] = nil
})
v96("Elixir", "rbxassetid://123677194704684", "rbxassetid://96734141776078", nil, "rbxassetid://106686303136827", 1, nil, "elixir_equip", "grenade_idle", "grenade_sprint", "grenade_inspect", nil, {
	["ThrowStart"] = "grenade_throw_start",
	["ThrowIdle"] = "grenade_throw_idle",
	["ThrowFinish"] = "grenade_throw_finish",
	["LobStart"] = "grenade_lob_start",
	["LobIdle"] = "grenade_lob_idle",
	["LobFinish"] = "grenade_lob_finish"
})
v96("Glass Cannon", "rbxassetid://138882843694218", "rbxassetid://82999887306387", nil, "rbxassetid://109359544961471", 1.5, CFrame.new(0, -0.125, -0.2), "glasscannon_equip", "glasscannon_idle", "glasscannon_sprint", "glasscannon_inspect", nil, {
	["Shoot1"] = "glasscannon_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = nil,
	["EmptyReload"] = nil,
	["EmptyEquip"] = "fists_equip",
	["EmptyIdle"] = "fists_idle",
	["EmptySprint"] = "fists_sprint",
	["EmptyInspect"] = "fists_inspect"
})
v96("Glast Shard", "rbxassetid://102980815872652", "rbxassetid://136181940429732", nil, "rbxassetid://89682549635116", 2, nil, "knife_karambit_equip", "knife_karambit_idle", "knife_karambit_sprint", "knife_karambit_inspect", nil, {
	["Attack1"] = "knife_karambit_attack1",
	["Attack2"] = "knife_karambit_attack2",
	["HeavyAttack1"] = "knife_karambit_heavyattack1",
	["HeavyAttackAnimationHit"] = "knife_karambit_heavyattack_hit"
})
v96("RNG Dice", "rbxassetid://98372867049331", "rbxassetid://75601061529918", nil, "rbxassetid://86815994192766", 1.5, nil, "rngdice_equip", "rngdice_idle", "rngdice_sprint", "rngdice_inspect", nil, {
	["Use"] = "rngdice_use"
})
v96("Distortion", "rbxassetid://115712150398379", "rbxassetid://130153907701944", nil, "rbxassetid://136813016262803", 2.5, CFrame.new(0, -0, -0.375) * CFrame.Angles(math.rad(2.5), 0, 0), "distortion_equip", "distortion_idle", "distortion_sprint", "distortion_inspect", nil, {
	["Shoot1"] = "distortion_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = nil,
	["EmptyReload"] = nil
})
v96("Glorious Distortion", "rbxassetid://134722661973710", "rbxassetid://107736694179886", nil, nil, nil, CFrame.new(0, -0, -0.375) * CFrame.Angles(math.rad(2.5), 0, 0), "distortion_equip", "distortion_idle", "distortion_sprint", "distortion_inspect", nil, {
	["Shoot1"] = "distortion_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = nil,
	["EmptyReload"] = nil
})
v96("Electropunk Distortion", "rbxassetid://109544539643046", "rbxassetid://91778033503945", nil, nil, nil, CFrame.new(0, -0, -0.375) * CFrame.Angles(math.rad(2.5), 0, 0), "distortion_equip", "distortion_idle", "distortion_sprint", "distortion_inspect2", nil, {
	["Shoot1"] = "distortion_electropunkdistortion_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = nil,
	["EmptyReload"] = nil
})
v96("Experiment D15", "rbxassetid://103446773933340", "rbxassetid://118366946179457", nil, nil, nil, CFrame.new(0, -0, -0.375) * CFrame.Angles(math.rad(2.5), 0, 0), "distortion_equip", "distortion_idle", "distortion_sprint", "distortion_inspect", nil, {
	["Shoot1"] = "distortion_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = nil,
	["EmptyReload"] = nil
})
v96("Plasma Distortion", "rbxassetid://126813935337091", "rbxassetid://83622093873798", nil, nil, nil, CFrame.new(0, -0, -0.375) * CFrame.Angles(math.rad(2.5), 0, 0), "distortion_equip", "distortion_idle", "distortion_sprint", "distortion_inspect2", nil, {
	["Shoot1"] = "distortion_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = nil,
	["EmptyReload"] = nil
})
v96("Magma Distortion", "rbxassetid://81103807698156", "rbxassetid://109079139956898", nil, nil, nil, CFrame.new(0, -0, -0.375) * CFrame.Angles(math.rad(2.5), 0, 0), "distortion_equip", "distortion_idle", "distortion_sprint", "distortion_inspect2", nil, {
	["Shoot1"] = "distortion_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = nil,
	["EmptyReload"] = nil
})
v96("Cyber Distortion", "rbxassetid://88995062151276", "rbxassetid://78940266607471", nil, nil, nil, CFrame.new(0, -0, -0.375) * CFrame.Angles(math.rad(2.5), 0, 0), "distortion_equip", "distortion_idle", "distortion_sprint", "distortion_inspect", nil, {
	["Shoot1"] = "distortion_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = nil,
	["EmptyReload"] = nil
})
v96("Sleighstortion", "rbxassetid://111242141481650", "rbxassetid://113075083434001", nil, nil, nil, CFrame.new(0, -0, -0.375) * CFrame.Angles(math.rad(2.5), 0, 0), "distortion_equip", "distortion_idle", "distortion_sprint", "distortion_inspect", nil, {
	["Shoot1"] = "distortion_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = nil,
	["EmptyReload"] = nil
})
v96("Bubble Distortion", "rbxassetid://73319804282513", "rbxassetid://110018703040757", nil, nil, nil, CFrame.new(0, -0, -0.375) * CFrame.Angles(math.rad(2.5), 0, 0), "distortion_equip", "distortion_idle", "distortion_sprint", "distortion_inspect2", nil, {
	["Shoot1"] = "distortion_bubbledistortion_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = nil,
	["EmptyReload"] = nil
})
v96("Warper", "rbxassetid://88033795039891", "rbxassetid://97537499062821", nil, "rbxassetid://131943126657510", 2, CFrame.new(0, -0.125, -0.375) * CFrame.Angles(math.rad(5), 0, 0), "warper_equip", "warper_idle", "warper_sprint", "warper_inspect", nil, {
	["Shoot1"] = "warper_shoot1"
})
v96("Glorious Warper", "rbxassetid://95823647035211", "rbxassetid://117284572803988", nil, nil, nil, CFrame.new(0, -0.125, -0.375) * CFrame.Angles(math.rad(5), 0, 0), "warper_equip", "warper_idle", "warper_sprint", "warper_inspect", nil, {
	["Shoot1"] = "warper_shoot1"
})
v96("Electropunk Warper", "rbxassetid://75386728379756", "rbxassetid://96080679722284", nil, nil, nil, CFrame.new(0, -0.125, -0.375) * CFrame.Angles(math.rad(5), 0, 0), "warper_equip", "warper_idle", "warper_sprint", "warper_inspect", nil, {
	["Shoot1"] = "warper_electropunkwarper_shoot1"
})
v96("Experiment W4", "rbxassetid://126884960764998", "rbxassetid://77873591123909", nil, nil, nil, CFrame.new(0, -0.125, -0.375) * CFrame.Angles(math.rad(5), 0, 0), "warper_equip", "warper_idle", "warper_sprint", "warper_inspect", nil, {
	["Shoot1"] = "warper_shoot1"
})
v96("Glitter Warper", "rbxassetid://94607497565715", "rbxassetid://128289126916762", nil, nil, nil, CFrame.new(0, -0.125, -0.375) * CFrame.Angles(math.rad(5), 0, 0), "warper_equip", "warper_idle", "warper_sprint", "warper_inspect", nil, {
	["Shoot1"] = "warper_shoot1"
})
v96("Arcane Warper", "rbxassetid://83632373572638", "rbxassetid://92765478127490", nil, nil, nil, CFrame.new(0, 0, -0.375) * CFrame.Angles(math.rad(5), 0, 0), "warper_arcanewarper_equip", "warper_arcanewarper_idle", "warper_arcanewarper_sprint", "warper_arcanewarper_inspect", nil, {
	["Shoot1"] = "warper_arcanewarper_shoot1"
})
v96("Hotel Bell", "rbxassetid://117742703173821", "rbxassetid://74303585805484", nil, nil, nil, CFrame.new(0, -0.125, -0.375) * CFrame.Angles(math.rad(5), 0, 0), "warper_hotelbell_equip", "warper_hotelbell_idle", "warper_hotelbell_sprint", "warper_hotelbell_inspect", nil, {
	["Shoot1"] = "warper_hotelbell_shoot1"
})
v96("Frost Warper", "rbxassetid://70539216094396", "rbxassetid://84458438183331", nil, nil, nil, CFrame.new(0, -0.125, -0.375) * CFrame.Angles(math.rad(5), 0, 0), "warper_equip", "warper_idle", "warper_sprint", "warper_inspect", nil, {
	["Shoot1"] = "warper_shoot1"
})
v96("Bubbler", "rbxassetid://106002684466857", "rbxassetid://85451017537725", nil, nil, nil, CFrame.new(0, -0.375, -0.25) * CFrame.Angles(math.rad(5), 0, 0), "warper_equip", "warper_idle", "warper_sprint", "warper_inspect", nil, {
	["Shoot1"] = "warper_bubbler_shoot1"
})
v96("Warpstone", "rbxassetid://94035693279005", "rbxassetid://99660718217521", nil, "rbxassetid://114944189821030", 1.5, CFrame.new(0, -0.25, -0.375), "grenade_equip", "grenade_idle", "grenade_sprint", "grenade_inspect", nil, {
	["ThrowStart"] = "grenade_throw_start",
	["ThrowIdle"] = "grenade_throw_idle",
	["ThrowFinish"] = "grenade_throw_finish",
	["LobStart"] = "grenade_lob_start",
	["LobIdle"] = "grenade_lob_idle",
	["LobFinish"] = "grenade_lob_finish"
})
v96("Glorious Warpstone", "rbxassetid://137583560042806", "rbxassetid://99142505492556", nil, nil, nil, CFrame.new(0, -0.25, -0.375), "grenade_equip", "grenade_idle", "grenade_sprint", "grenade_inspect", nil, {
	["ThrowStart"] = "grenade_throw_start",
	["ThrowIdle"] = "grenade_throw_idle",
	["ThrowFinish"] = "grenade_throw_finish",
	["LobStart"] = "grenade_lob_start",
	["LobIdle"] = "grenade_lob_idle",
	["LobFinish"] = "grenade_lob_finish"
})
v96("Unstable Warpstone", "rbxassetid://110083777654388", "rbxassetid://71896071193185", nil, nil, nil, CFrame.new(0, -0.25, -0.375), "grenade_equip", "grenade_idle", "grenade_sprint", "grenade_inspect", nil, {
	["ThrowStart"] = "grenade_throw_start",
	["ThrowIdle"] = "grenade_throw_idle",
	["ThrowFinish"] = "grenade_throw_finish",
	["LobStart"] = "grenade_lob_start",
	["LobIdle"] = "grenade_lob_idle",
	["LobFinish"] = "grenade_lob_finish"
})
v96("Warpeye", "rbxassetid://127023603234857", "rbxassetid://129554679066276", nil, nil, nil, CFrame.new(0, -0.25, -0.375), "warpstone_warpeye_equip", "warpstone_warpeye_idle", "warpstone_warpeye_sprint", "warpstone_warpeye_inspect", nil, {
	["ThrowStart"] = "warpstone_warpeye_throw_start",
	["ThrowIdle"] = "warpstone_warpeye_throw_idle",
	["ThrowFinish"] = "warpstone_warpeye_throw_finish",
	["LobStart"] = "warpstone_warpeye_lob_start",
	["LobIdle"] = "warpstone_warpeye_lob_idle",
	["LobFinish"] = "warpstone_warpeye_lob_finish"
})
v96("Warpbone", "rbxassetid://96452209607150", "rbxassetid://132473085580193", nil, nil, nil, CFrame.new(0, -0.25, -0.375), "grenade_equip", "grenade_idle", "grenade_sprint", "grenade_inspect", nil, {
	["ThrowStart"] = "grenade_throw_start",
	["ThrowIdle"] = "grenade_throw_idle",
	["ThrowFinish"] = "grenade_throw_finish",
	["LobStart"] = "grenade_lob_start",
	["LobIdle"] = "grenade_lob_idle",
	["LobFinish"] = "grenade_lob_finish"
})
v96("Cyber Warpstone", "rbxassetid://133002984228937", "rbxassetid://78671282003316", nil, nil, nil, CFrame.new(0, -0.25, -0.375), "grenade_equip", "grenade_idle", "grenade_sprint", "grenade_inspect", nil, {
	["ThrowStart"] = "grenade_throw_start",
	["ThrowIdle"] = "grenade_throw_idle",
	["ThrowFinish"] = "grenade_throw_finish",
	["LobStart"] = "grenade_lob_start",
	["LobIdle"] = "grenade_lob_idle",
	["LobFinish"] = "grenade_lob_finish"
})
v96("Teleport Disc", "rbxassetid://104608154111107", "rbxassetid://81728761431901", nil, nil, nil, CFrame.new(0, -0.125, -0.375), "warpstone_teleportdisc_equip", "warpstone_teleportdisc_idle", "warpstone_teleportdisc_sprint", "warpstone_teleportdisc_inspect", nil, {
	["ThrowStart"] = "warpstone_teleportdisc_throw_start",
	["ThrowIdle"] = "warpstone_teleportdisc_throw_idle",
	["ThrowFinish"] = "warpstone_teleportdisc_throw_finish",
	["LobStart"] = "warpstone_teleportdisc_lob_start",
	["LobIdle"] = "warpstone_teleportdisc_lob_idle",
	["LobFinish"] = "warpstone_teleportdisc_lob_finish"
})
v96("Electropunk Warpstone", "rbxassetid://75299042976369", "rbxassetid://121167052087315", nil, nil, nil, CFrame.new(0, -0.25, -0.375), "grenade_equip", "grenade_idle", "grenade_sprint", "grenade_inspect", nil, {
	["ThrowStart"] = "grenade_throw_start",
	["ThrowIdle"] = "grenade_throw_idle",
	["ThrowFinish"] = "grenade_throw_finish",
	["LobStart"] = "grenade_lob_start",
	["LobIdle"] = "grenade_lob_idle",
	["LobFinish"] = "grenade_lob_finish"
})
v96("Warpstar", "rbxassetid://102652397897598", "rbxassetid://85728240647371", nil, nil, nil, CFrame.new(0, -0.25, -0.375), "warpstone_warpstar_equip", "warpstone_warpstar_idle", "warpstone_warpstar_sprint", "warpstone_warpstar_inspect", nil, {
	["ThrowStart"] = "warpstone_warpstar_throw_start",
	["ThrowIdle"] = "warpstone_warpstar_throw_idle",
	["ThrowFinish"] = "warpstone_warpstar_throw_finish",
	["LobStart"] = "warpstone_warpstar_lob_start",
	["LobIdle"] = "warpstone_warpstar_lob_idle",
	["LobFinish"] = "warpstone_warpstar_lob_finish"
})
v96("Warp Juice", "rbxassetid://74381576761026", "rbxassetid://87229911094803", nil, nil, nil, CFrame.new(0, -0.25, -0.375), "grenade_equip", "grenade_idle", "grenade_sprint", "grenade_inspect", nil, {
	["ThrowStart"] = "grenade_throw_start",
	["ThrowIdle"] = "grenade_throw_idle",
	["ThrowFinish"] = "grenade_throw_finish",
	["LobStart"] = "grenade_lob_start",
	["LobIdle"] = "grenade_lob_idle",
	["LobFinish"] = "grenade_lob_finish"
})
v96("Maul", "rbxassetid://81478141693597", "rbxassetid://96956174894354", "rbxassetid://92218373099093", "rbxassetid://92986282671073", 2, nil, "maul_equip", "maul_idle", "maul_sprint", "maul_inspect", nil, {
	["Attack1"] = "maul_attack1",
	["Attack2"] = "maul_attack2",
	["SlamIntro"] = "maul_slam_intro",
	["SlamLoop"] = "maul_slam_loop",
	["SlamOutro"] = "maul_slam_outro"
})
v96("Sleigh Maul", "rbxassetid://114892026951995", "rbxassetid://112835874307935", nil, nil, nil, nil, "maul_equip", "maul_idle", "maul_sprint", "maul_inspect", nil, {
	["Attack1"] = "maul_sleighmaul_attack1",
	["Attack2"] = "maul_sleighmaul_attack2",
	["SlamIntro"] = "maul_slam_intro",
	["SlamLoop"] = "maul_slam_loop",
	["SlamOutro"] = "maul_slam_outro"
})
v96("Ice Maul", "rbxassetid://100001888078290", "rbxassetid://79987597452893", nil, nil, nil, nil, "maul_equip", "maul_idle", "maul_sprint", "maul_inspect", nil, {
	["Attack1"] = "maul_attack1",
	["Attack2"] = "maul_attack2",
	["SlamIntro"] = "maul_slam_intro",
	["SlamLoop"] = "maul_slam_loop",
	["SlamOutro"] = "maul_slam_outro"
})
v96("Glorious Maul", "rbxassetid://125917253783002", "rbxassetid://109898315901573", nil, nil, nil, nil, "maul_equip", "maul_idle", "maul_sprint", "maul_inspect", nil, {
	["Attack1"] = "maul_attack1",
	["Attack2"] = "maul_attack2",
	["SlamIntro"] = "maul_slam_intro",
	["SlamLoop"] = "maul_slam_loop",
	["SlamOutro"] = "maul_slam_outro"
})
v96("Ban Hammer", "rbxassetid://126491383967029", "rbxassetid://139055067677915", nil, nil, nil, nil, "maul_equip", "maul_idle", "maul_sprint", "maul_inspect", nil, {
	["Attack1"] = "maul_banhammer_attack1",
	["Attack2"] = "maul_banhammer_attack2",
	["SlamIntro"] = "maul_slam_intro",
	["SlamLoop"] = "maul_slam_loop",
	["SlamOutro"] = "maul_slam_outro"
})
v96("Giant Popsicle", "rbxassetid://91916939347642", "rbxassetid://73293329481030", nil, nil, nil, nil, "maul_equip", "maul_idle", "maul_sprint", "maul_inspect", nil, {
	["Attack1"] = "maul_attack1",
	["Attack2"] = "maul_attack2",
	["SlamIntro"] = "maul_slam_intro",
	["SlamLoop"] = "maul_slam_loop",
	["SlamOutro"] = "maul_slam_outro"
})
v96("Starforge Maul", "rbxassetid://113691709735527", "rbxassetid://75908084519560", nil, nil, nil, nil, "maul_equip", "maul_idle", "maul_sprint", "maul_inspect", nil, {
	["Attack1"] = "maul_starforgemaul_attack1",
	["Attack2"] = "maul_starforgemaul_attack2",
	["SlamIntro"] = "maul_slam_intro",
	["SlamLoop"] = "maul_slam_loop",
	["SlamOutro"] = "maul_slam_outro"
})
v96("Clown Hammer", "rbxassetid://95487416883384", "rbxassetid://126738169262750", nil, nil, nil, nil, "maul_equip", "maul_idle", "maul_sprint", "maul_inspect", nil, {
	["Attack1"] = "maul_attack1",
	["Attack2"] = "maul_attack2",
	["SlamIntro"] = "maul_slam_intro",
	["SlamLoop"] = "maul_slam_loop",
	["SlamOutro"] = "maul_slam_outro"
})
v96("Excalibur", "rbxassetid://81905348145140", "rbxassetid://104902093629888", nil, nil, nil, nil, "maul_equip", "maul_idle", "maul_sprint", "maul_inspect", nil, {
	["Attack1"] = "maul_attack1",
	["Attack2"] = "maul_attack2",
	["SlamIntro"] = "maul_slam_intro",
	["SlamLoop"] = "maul_slam_loop",
	["SlamOutro"] = "maul_slam_outro"
})
v96("Jeremiah", "rbxassetid://109379867345162", "rbxassetid://81672849444916", nil, nil, nil, nil, "maul_equip", "maul_idle", "maul_sprint", "maul_inspect", nil, {
	["Attack1"] = "maul_attack1",
	["Attack2"] = "maul_attack2",
	["SlamIntro"] = "maul_slam_intro",
	["SlamLoop"] = "maul_slam_loop",
	["SlamOutro"] = "maul_slam_outro"
})
v96("Permafrost", "rbxassetid://74353733133888", "rbxassetid://78468628083590", nil, "rbxassetid://112007420940132", 2.25, CFrame.new(0, -0.125, -0.5), "permafrost_equip", "permafrost_idle", "permafrost_sprint", "permafrost_inspect", nil, {
	["Shoot1"] = "permafrost_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = "permafrost_reload",
	["EmptyReload"] = nil,
	["Throw"] = "permafrost_throw"
})
v96("Snowman Permafrost", "rbxassetid://100890626643184", "rbxassetid://70467865456788", nil, nil, nil, CFrame.new(0, -0.125, -0.5), "permafrost_equip", "permafrost_idle", "permafrost_sprint", "permafrost_inspect", nil, {
	["Shoot1"] = "permafrost_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = "permafrost_reload",
	["EmptyReload"] = nil,
	["Throw"] = "permafrost_throw"
})
v96("Ice Permafrost", "rbxassetid://83722160119335", "rbxassetid://122848886028890", nil, nil, nil, CFrame.new(0, -0.125, -0.5), "permafrost_equip", "permafrost_idle", "permafrost_sprint", "permafrost_inspect", nil, {
	["Shoot1"] = "permafrost_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = "permafrost_reload",
	["EmptyReload"] = nil,
	["Throw"] = "permafrost_throw"
})
v96("Glorious Permafrost", "rbxassetid://119977291442329", "rbxassetid://82134252571554", nil, nil, nil, CFrame.new(0, -0.125, -0.5), "permafrost_equip", "permafrost_idle", "permafrost_sprint", "permafrost_inspect", nil, {
	["Shoot1"] = "permafrost_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = "permafrost_reload",
	["EmptyReload"] = nil,
	["Throw"] = "permafrost_throw"
})
v96("Permasand", "rbxassetid://108398272946629", "rbxassetid://78346736007202", nil, nil, nil, CFrame.new(0, -0.25, -1), "permafrost_equip", "permafrost_idle", "permafrost_sprint", "permafrost_permasand_inspect", nil, {
	["Shoot1"] = "permafrost_permasand_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = "permafrost_permasand_reload",
	["EmptyReload"] = nil,
	["Throw"] = "permafrost_permasand_throw"
})
v96("Temporal Permafrost", "rbxassetid://124975247676715", "rbxassetid://102512211072596", nil, nil, nil, CFrame.new(0, -0.125, -0.5), "permafrost_temporalpermafrost_equip", "permafrost_idle", "permafrost_sprint", "permafrost_inspect", nil, {
	["Shoot1"] = "permafrost_temporalpermafrost_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = "permafrost_reload",
	["EmptyReload"] = nil,
	["Throw"] = "permafrost_throw"
})
v96("Permafrost.rbxm", "rbxassetid://77732280270853", "rbxassetid://70936739713658", nil, nil, nil, CFrame.new(0, -0.125, -0.5), "permafrost_equip", "permafrost_idle", "permafrost_sprint", "permafrost_inspect", nil, {
	["Shoot1"] = "permafrost_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = "permafrost_reload",
	["EmptyReload"] = nil,
	["Throw"] = "permafrost_throw"
})
v96("Starforge Permafrost", "rbxassetid://105290041968367", "rbxassetid://125277951481670", nil, nil, nil, CFrame.new(0, -0.125, -0.5), "permafrost_equip", "permafrost_idle", "permafrost_sprint", "permafrost_inspect", nil, {
	["Shoot1"] = "permafrost_starforgepermafrost_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = "permafrost_reload",
	["EmptyReload"] = nil,
	["Throw"] = "permafrost_throw"
})
v96("Xenofrost", "rbxassetid://97111256967007", "rbxassetid://118705408756712", nil, nil, nil, CFrame.new(0, -0.125, -0.5), "permafrost_equip", "permafrost_idle", "permafrost_sprint", "permafrost_inspect", nil, {
	["Shoot1"] = "permafrost_shoot1",
	["FinalShoot"] = nil,
	["Reload"] = "permafrost_reload",
	["EmptyReload"] = nil,
	["Throw"] = "permafrost_throw"
})
v96("Grappler", "rbxassetid://103255844976245", "rbxassetid://87568033383502", nil, "rbxassetid://133662495148200", 2, CFrame.new(-0.125, -0.25, -0.25), "grappler_equip", "grappler_idle", "grappler_sprint", "grappler_inspect", nil, {
	["Shoot"] = "grappler_shoot",
	["ShootWaiting"] = nil,
	["ShootMissed"] = nil,
	["Pull"] = "grappler_pull"
})
v96("Lasso", "rbxassetid://77061966583531", "rbxassetid://108092530029598", nil, nil, nil, CFrame.new(-0.125, 0.25, -0.25), "grappler_lasso_equip", "grappler_lasso_idle", "grappler_lasso_sprint", "grappler_lasso_inspect", nil, {
	["Shoot"] = "grappler_lasso_shoot",
	["ShootWaiting"] = "grappler_lasso_shoot_waiting",
	["ShootMissed"] = "grappler_lasso_shoot_missed",
	["Pull"] = "grappler_lasso_pull"
})
v96("Glorious Grappler", "rbxassetid://113576961532090", "rbxassetid://88153994788904", nil, nil, nil, CFrame.new(-0.125, -0.25, -0.25), "grappler_equip", "grappler_idle", "grappler_sprint", "grappler_inspect", nil, {
	["Shoot"] = "grappler_shoot",
	["ShootWaiting"] = nil,
	["ShootMissed"] = nil,
	["Pull"] = "grappler_pull"
})
v96("Lifeguard Grappler", "rbxassetid://91214316625102", "rbxassetid://88452918330544", nil, nil, nil, CFrame.new(-0.125, -0.25, -0.25), "grappler_equip", "grappler_idle", "grappler_sprint", "grappler_inspect2", nil, {
	["Shoot"] = "grappler_shoot",
	["ShootWaiting"] = nil,
	["ShootMissed"] = nil,
	["Pull"] = "grappler_pull"
})
v96("Fishing Rod", "rbxassetid://86648406311812", "rbxassetid://117073216031732", nil, nil, nil, CFrame.new(-0.125, -0.25, -0.25), "grappler_fishingrod_equip", "grappler_fishingrod_idle", "grappler_fishingrod_sprint", "grappler_fishingrod_inspect", nil, {
	["Shoot"] = "grappler_fishingrod_shoot",
	["ShootWaiting"] = "grappler_fishingrod_shoot_waiting",
	["ShootMissed"] = "grappler_fishingrod_shoot_missed",
	["Pull"] = "grappler_fishingrod_pull"
})
v96("Genie Lamp", "rbxassetid://118514051859760", "rbxassetid://109485237618085", nil, nil, nil, CFrame.new(-0.125, -0.25, -0.25), "grappler_genielamp_equip", "grappler_genielamp_idle", "grappler_genielamp_sprint", "grappler_genielamp_inspect", nil, {
	["Shoot"] = "grappler_genielamp_shoot",
	["ShootWaiting"] = "grappler_genielamp_shoot_waiting",
	["ShootMissed"] = nil,
	["Pull"] = "grappler_genielamp_pull"
})
v96("Arcade Claw", "rbxassetid://81529455948004", "rbxassetid://103015494369795", nil, nil, nil, CFrame.new(-0.125, -0.25, -0.25), "grappler_arcadeclaw_equip", "grappler_arcadeclaw_idle", "grappler_arcadeclaw_sprint", "grappler_arcadeclaw_inspect", nil, {
	["Shoot"] = "grappler_arcadeclaw_shoot",
	["ShootWaiting"] = "grappler_arcadeclaw_shoot_waiting",
	["ShootMissed"] = "grappler_arcadeclaw_shoot_missed",
	["Pull"] = "grappler_arcadeclaw_pull"
})
v96("Web Shooters", "rbxassetid://96604638344437", "rbxassetid://76232816564723", nil, nil, nil, CFrame.new(-0.125, -0.25, -0.25), "grappler_webshooters_equip", "grappler_webshooters_idle", "grappler_webshooters_sprint", "grappler_webshooters_inspect", nil, {
	["Shoot"] = "grappler_webshooters_shoot",
	["ShootWaiting"] = "grappler_webshooters_shoot_waiting",
	["ShootMissed"] = "grappler_webshooters_shoot_missed",
	["Pull"] = "grappler_webshooters_pull"
})
v96("Spear", "rbxassetid://122801133017271", "rbxassetid://111446720428762", "rbxassetid://118645037655070", "rbxassetid://133317189223963", 3.25, CFrame.new(-0.25, 0, 0), "spear_equip", "spear_idle", "spear_sprint", "spear_inspect", nil, {
	["Attack1"] = "spear_attack1",
	["Attack2"] = "spear_attack2",
	["Throw"] = "spear_throw",
	["ThrowFinal"] = "spear_throw_final",
	["EmptyEquip"] = "fists_equip",
	["EmptyIdle"] = "fists_idle",
	["EmptyInspect"] = "fists_inspect",
	["EmptySprint"] = "fists_sprint"
})
v96("Giant Pencil", "rbxassetid://107812045486260", "rbxassetid://76085189198864", nil, nil, nil, CFrame.new(-0.25, 0, 0), "spear_equip", "spear_idle", "spear_sprint", "spear_inspect", nil, {
	["Attack1"] = "spear_attack1",
	["Attack2"] = "spear_attack2",
	["Throw"] = "spear_throw",
	["ThrowFinal"] = "spear_throw_final",
	["EmptyEquip"] = "fists_equip",
	["EmptyIdle"] = "fists_idle",
	["EmptyInspect"] = "fists_inspect",
	["EmptySprint"] = "fists_sprint"
})
v96("Studio Light", "rbxassetid://70443632958263", "rbxassetid://84596578566011", nil, nil, nil, CFrame.new(-0.25, 0, 0), "spear_equip", "spear_idle", "spear_sprint", "spear_inspect", nil, {
	["Attack1"] = "spear_attack1",
	["Attack2"] = "spear_attack2",
	["Throw"] = "spear_throw",
	["ThrowFinal"] = "spear_throw_final",
	["EmptyEquip"] = "fists_equip",
	["EmptyIdle"] = "fists_idle",
	["EmptyInspect"] = "fists_inspect",
	["EmptySprint"] = "fists_sprint"
})
v96("Glorious Spear", "rbxassetid://98259628954838", "rbxassetid://108275754332894", nil, nil, nil, CFrame.new(-0.25, 0, 0), "spear_equip", "spear_idle", "spear_sprint", "spear_inspect", nil, {
	["Attack1"] = "spear_attack1",
	["Attack2"] = "spear_attack2",
	["Throw"] = "spear_throw",
	["ThrowFinal"] = "spear_throw_final",
	["EmptyEquip"] = "fists_equip",
	["EmptyIdle"] = "fists_idle",
	["EmptyInspect"] = "fists_inspect",
	["EmptySprint"] = "fists_sprint"
})
v96("Chark Kebab", "rbxassetid://74005839754537", "rbxassetid://119960723782790", nil, nil, nil, CFrame.new(-0.25, 0, 0), "spear_equip", "spear_idle", "spear_sprint", "spear_inspect", nil, {
	["Attack1"] = "spear_attack1",
	["Attack2"] = "spear_attack2",
	["Throw"] = "spear_throw",
	["ThrowFinal"] = "spear_throw_final",
	["EmptyEquip"] = "fists_equip",
	["EmptyIdle"] = "fists_idle",
	["EmptyInspect"] = "fists_inspect",
	["EmptySprint"] = "fists_sprint"
})
v96("Plunger", "rbxassetid://82393330699241", "rbxassetid://100137022004558", nil, nil, nil, CFrame.new(-0.25, 0, 0), "spear_equip", "spear_idle", "spear_sprint", "spear_inspect", nil, {
	["Attack1"] = "spear_attack1",
	["Attack2"] = "spear_attack2",
	["Throw"] = "spear_throw",
	["ThrowFinal"] = "spear_throw_final",
	["EmptyEquip"] = "fists_equip",
	["EmptyIdle"] = "fists_idle",
	["EmptyInspect"] = "fists_inspect",
	["EmptySprint"] = "fists_sprint"
})
v96("Fork", "rbxassetid://105821360943308", "rbxassetid://99666359128492", nil, nil, nil, CFrame.new(-0.25, 0, 0), "spear_equip", "spear_idle", "spear_sprint", "spear_inspect", nil, {
	["Attack1"] = "spear_attack1",
	["Attack2"] = "spear_attack2",
	["Throw"] = "spear_throw",
	["ThrowFinal"] = "spear_throw_final",
	["EmptyEquip"] = "fists_equip",
	["EmptyIdle"] = "fists_idle",
	["EmptyInspect"] = "fists_inspect",
	["EmptySprint"] = "fists_sprint"
})
v96("Thunderpike", "rbxassetid://137630900832105", "rbxassetid://98009731162020", nil, nil, nil, CFrame.new(-0.25, 0, 0), "spear_equip", "spear_idle", "spear_sprint", "spear_inspect", nil, {
	["Attack1"] = "spear_thunderpike_attack1",
	["Attack2"] = "spear_thunderpike_attack2",
	["Throw"] = "spear_throw",
	["ThrowFinal"] = "spear_throw_final",
	["EmptyEquip"] = "fists_equip",
	["EmptyIdle"] = "fists_idle",
	["EmptyInspect"] = "fists_inspect",
	["EmptySprint"] = "fists_sprint"
})
v96("Gravelight", "rbxassetid://132190257399523", "rbxassetid://72239184086349", nil, nil, nil, CFrame.new(-0.25, 0, 0), "spear_equip", "spear_idle", "spear_sprint", "spear_inspect", nil, {
	["Attack1"] = "spear_attack1",
	["Attack2"] = "spear_attack2",
	["Throw"] = "spear_throw",
	["ThrowFinal"] = "spear_throw_final",
	["EmptyEquip"] = "fists_equip",
	["EmptyIdle"] = "fists_idle",
	["EmptyInspect"] = "fists_inspect",
	["EmptySprint"] = "fists_sprint"
})
v96("Wildcat", "rbxassetid://77401164737509", "rbxassetid://124155708481848", nil, "rbxassetid://75811955088086", 2.5, CFrame.new(0, -0.25, -0.5), "wildcat_state1_equip", "wildcat_state1_idle", "wildcat_state1_sprint", "wildcat_state1_inspect", nil, {
	["Shoot1"] = "wildcat_state1_shoot1",
	["Reload"] = "wildcat_state1_reload",
	["Reload2"] = "wildcat_state2_reload",
	["State2Equip"] = "wildcat_state2_equip",
	["State2Idle"] = "wildcat_state2_idle",
	["State2Sprint"] = "wildcat_state2_sprint",
	["State2Inspect"] = "wildcat_state2_inspect",
	["State2Shoot1"] = "wildcat_state2_shoot1"
})
v96("Glorious Wildcat", "rbxassetid://115657943825380", "rbxassetid://134370234190592", nil, nil, nil, CFrame.new(0, -0.25, -0.5), "wildcat_state1_equip", "wildcat_state1_idle", "wildcat_state1_sprint", "wildcat_state1_inspect", nil, {
	["Shoot1"] = "wildcat_state1_shoot1",
	["Reload"] = "wildcat_state1_reload",
	["Reload2"] = "wildcat_state2_reload",
	["State2Equip"] = "wildcat_state2_equip",
	["State2Idle"] = "wildcat_state2_idle",
	["State2Sprint"] = "wildcat_state2_sprint",
	["State2Inspect"] = "wildcat_state2_inspect",
	["State2Shoot1"] = "wildcat_state2_shoot1"
})
v96("Plasma Wildcat", "rbxassetid://88584176541333", "rbxassetid://76436412524361", nil, nil, nil, CFrame.new(0, -0.25, -0.5), "wildcat_state1_equip", "wildcat_state1_idle", "wildcat_state1_sprint", "wildcat_state1_inspect", nil, {
	["Shoot1"] = "wildcat_plasmawildcat_state1_shoot1",
	["Reload"] = "wildcat_state1_reload",
	["Reload2"] = "wildcat_state2_reload",
	["State2Equip"] = "wildcat_state2_equip",
	["State2Idle"] = "wildcat_state2_idle",
	["State2Sprint"] = "wildcat_state2_sprint",
	["State2Inspect"] = "wildcat_state2_inspect",
	["State2Shoot1"] = "wildcat_plasmawildcat_state2_shoot1"
})
v96("Towerstone Wildcat", "rbxassetid://129631144327641", "rbxassetid://135470712376613", nil, nil, nil, CFrame.new(0, -0.25, -0.5), "wildcat_state1_equip", "wildcat_state1_idle", "wildcat_state1_sprint", "wildcat_state1_inspect", nil, {
	["Shoot1"] = "wildcat_state1_shoot1",
	["Reload"] = "wildcat_state1_reload",
	["Reload2"] = "wildcat_state2_reload",
	["State2Equip"] = "wildcat_state2_equip",
	["State2Idle"] = "wildcat_state2_idle",
	["State2Sprint"] = "wildcat_state2_sprint",
	["State2Inspect"] = "wildcat_state2_inspect",
	["State2Shoot1"] = "wildcat_state2_shoot1"
})
v96("Mimic Wildcat", "rbxassetid://122326241760674", "rbxassetid://76884107478414", nil, nil, nil, CFrame.new(0, -0.25, -0.5), "wildcat_state1_equip", "wildcat_state1_idle", "wildcat_state1_sprint", "wildcat_state1_inspect", nil, {
	["Shoot1"] = "wildcat_state1_shoot1",
	["Reload"] = "wildcat_state1_reload",
	["Reload2"] = "wildcat_state2_reload",
	["State2Equip"] = "wildcat_state2_equip",
	["State2Idle"] = "wildcat_state2_idle",
	["State2Sprint"] = "wildcat_state2_sprint",
	["State2Inspect"] = "wildcat_state2_inspect",
	["State2Shoot1"] = "wildcat_state2_shoot1"
})
v96("Shadow Wildcat", "rbxassetid://92271841226554", "rbxassetid://74606986165408", nil, nil, nil, CFrame.new(0, -0.25, -0.5), "wildcat_shadowwildcat_state1_equip", "wildcat_shadowwildcat_state1_idle", "wildcat_shadowwildcat_state1_sprint", "wildcat_shadowwildcat_state1_inspect", nil, {
	["Shoot1"] = "wildcat_shadowwildcat_state1_shoot1",
	["Reload"] = "wildcat_shadowwildcat_state1_reload",
	["Reload2"] = "wildcat_shadowwildcat_state2_reload",
	["State2Equip"] = "wildcat_shadowwildcat_state2_equip",
	["State2Idle"] = "wildcat_shadowwildcat_state2_idle",
	["State2Sprint"] = "wildcat_shadowwildcat_state2_sprint",
	["State2Inspect"] = "wildcat_shadowwildcat_state2_inspect",
	["State2Shoot1"] = "wildcat_shadowwildcat_state2_shoot1"
})
v96("Holodome", "rbxassetid://75979564717669", "rbxassetid://101889920858951", nil, "rbxassetid://85540453190638", 1.5, nil, "holodome_equip", "holodome_idle", "holodome_sprint", "holodome_inspect", nil, {
	["ThrowStart"] = "holodome_throw_start",
	["ThrowIdle"] = "holodome_throw_idle",
	["ThrowFinish"] = "holodome_throw_finish",
	["LobStart"] = "holodome_lob_start",
	["LobIdle"] = "holodome_lob_idle",
	["LobFinish"] = "holodome_lob_finish"
})
v96("Glorious Holodome", "rbxassetid://75767595923606", "rbxassetid://129112773429749", nil, nil, nil, nil, "holodome_equip", "holodome_idle", "holodome_sprint", "holodome_inspect", nil, {
	["ThrowStart"] = "holodome_throw_start",
	["ThrowIdle"] = "holodome_throw_idle",
	["ThrowFinish"] = "holodome_throw_finish",
	["LobStart"] = "holodome_lob_start",
	["LobIdle"] = "holodome_lob_idle",
	["LobFinish"] = "holodome_lob_finish"
})
local function v_u_117(p97, p98, p99, p100, p101, p102, p103, p104, p105, p106, p107, p108, p109, p110, p111, p112) -- name: add_item
	-- upvalues: (copy) v_u_36, (copy) v_u_2, (copy) v_u_37
	local v113 = {
		["Type"] = p97,
		["Status"] = p98,
		["Class"] = p99,
		["Name"] = p100,
		["Image"] = v_u_36.ViewModels[p100].Image,
		["EquipCooldown"] = p101,
		["CanEliminate"] = p102,
		["WalkSpeedMultiplier"] = p103,
		["MaxDoubleJumps"] = p104,
		["CrosshairType"] = p105,
		["MobileInputSettings"] = p106,
		["QuickAttackInputs"] = p109,
		["QuickAttackInputsEasy"] = p110 or p109,
		["InputSpammingEnabled"] = {
			["StartShooting"] = p107,
			["StartAiming"] = p108,
			["StartReloading"] = 0.5,
			["StartInspecting"] = false
		},
		["AutoShootReactionTime"] = p111 or -1
	}
	for v114, v115 in pairs(p112 or {}) do
		v113[v114] = v115
	end
	v_u_36.Items[p100] = v113
	local v116 = v_u_36.ItemOrder
	table.insert(v116, p100)
	if v_u_2.IS_SERVER then
		if v_u_37[p100] then
			warn("[ITEM] Duplicate item name: " .. p100)
			return v113
		end
		v_u_37[p100] = true
	end
	return v113
end
local function v136(p118, p119, p120, p121, p122, p123, p124, p125, p126, p127, p128, p129, p130, p131, p132) -- name: add_custom
	-- upvalues: (copy) v_u_117
	local v133 = {}
	for v134, v135 in pairs(p132 or {}) do
		v133[v134] = v135
	end
	v_u_117("Custom", p118, p119, p120, p121, p122, p123, p124, p125, p126, p127, p128, p130, p131, p129, v133)
end
v136("Prime", "Utility", "Medkit", 0.9, false, 0.9, nil, "Default", {
	["Inspect"] = false,
	["Shoot"] = false,
	["Aim"] = false
}, 0, 0, nil, { "StartAiming" }, nil, {
	["Cooldown"] = 90,
	["LongHeal"] = 70,
	["LongLength"] = 6.857,
	["LongActionTimestamp"] = 6,
	["QuickHeal"] = 25,
	["QuickLength"] = 1,
	["QuickActionTimestamp"] = 0.45
})
v136("Prime", "Utility", "Subspace Tripmine", 0.5, true, 1, nil, "Default", {
	["Inspect"] = false,
	["Shoot"] = false
}, 0, 0, nil, { "StartShooting" }, nil, {
	["Cooldown"] = 0.5,
	["AmmoType"] = "Tripmine",
	["MaxAmmo"] = 2,
	["MaxReach"] = 3,
	["HitboxDelay"] = 1,
	["ExplosionRadius"] = 12,
	["ExplosionDamage"] = 149,
	["CriticalExplosionDamage"] = 150,
	["ExplosionKnockback"] = 1.5,
	["BalancedAmmoRefill"] = 1
})
v136("Prime", "Primary", "Flamethrower", 0.9, true, 0.95, nil, "Default", {
	["Inspect"] = false,
	["Shoot"] = false,
	["Aim"] = false
}, 0, 0, 0, { "StartAiming" }, nil, {
	["AmmoType"] = "Fuel",
	["DamagePerSecond"] = 85,
	["DamageTicksPerSecond"] = 10,
	["AfterburnDamage"] = 25,
	["AfterburnDuration"] = 4,
	["AfterburnTicks"] = 8,
	["Reach"] = 26,
	["MaxAmmo"] = 100,
	["MaxAmmoReserve"] = 0,
	["AirblastCooldown"] = 4,
	["AirblastKnockback"] = 1.5,
	["AirblastRecoilKnockback"] = 1.5,
	["InternalUseCooldown"] = 0.25
})
v136("Standard", "Utility", "War Horn", 0.4, false, 1, nil, "Default", {
	["Inspect"] = false,
	["Shoot"] = false
}, 0, 0, nil, { "StartShooting" }, nil, {
	["Cooldown"] = 45,
	["SpeedBoost"] = 0.25,
	["SpeedBoostDuration"] = 6,
	["UseEndLag"] = 0.9
})
v136("Standard", "Utility", "Jump Pad", 0.5, false, 1, nil, "Default", {
	["Inspect"] = false,
	["Shoot"] = false
}, 0, 0, nil, { "StartShooting" }, nil, {
	["Cooldown"] = 0.5,
	["Lifetime"] = 90,
	["Strength"] = 1,
	["AmmoType"] = "Jump Pad",
	["MaxAmmo"] = 3,
	["MaxReach"] = 32,
	["HitboxSize"] = nil,
	["BalancedAmmoRefill"] = 1,
	["HitboxSize"] = Vector3.new(11, 11, 2)
})
v136("Contraband", "Utility", "RNG Dice", 0.5, false, 1, nil, "Default", {
	["Inspect"] = false,
	["Shoot"] = false
}, 0, 0, nil, { "StartShooting" }, nil, {
	["RollDuration"] = 0.25,
	["Cooldown"] = 3.75,
	["MaxItems"] = 2
})
v136("Contraband", "Secondary", "Warper", 1, false, 1, nil, "Default", {
	["Inspect"] = false,
	["Shoot"] = false,
	["Aim"] = false
}, 0, 0, nil, { "StartAiming" }, nil, {
	["ShootCooldown"] = 0.25,
	["MaxPortalRange"] = 512,
	["PortalDeadzone"] = 10,
	["PortalDelayedSpawnThreshold"] = 64,
	["PortalDelayedSpawnSecondsPerStud"] = 0.025
})
v136("Contraband", "Utility", "Grappler", 0.5, false, 0.9, 1, "Default", {
	["Inspect"] = false,
	["Shoot"] = false
}, 0, 0, nil, { "StartShooting" }, nil, {
	["Cooldown"] = 8,
	["HookSpeed"] = 128,
	["HookRange"] = 100,
	["SelfPullForce"] = 100,
	["EnemyPullForce"] = 100,
	["MissedCooldown"] = 1
})
local function v163(p137, p138, p139, p140, p141, p142, p143, p144, p145, p146, p147, p148, p149, p150, p151, p152, _, p153, p154, p155, _, p156, p157) -- name: add_throwable
	-- upvalues: (copy) v_u_117
	local v158 = {
		["HitboxSize"] = nil,
		["CriticalDamage"] = nil,
		["UseEndLag"] = 0.25,
		["DirectHitDamage"] = nil,
		["Cooldown"] = nil,
		["Lifetime"] = nil,
		["MaxAmmo"] = nil,
		["AmmoType"] = nil,
		["ThrowMaxChargeTime"] = nil,
		["ThrowForceMin"] = nil,
		["ThrowForceMax"] = nil,
		["ThrowGravity"] = nil,
		["LobMaxChargeTime"] = nil,
		["LobForceMin"] = nil,
		["LobForceMax"] = nil,
		["LobGravity"] = nil,
		["HitboxSize"] = p145 or 0.25,
		["CriticalDamage"] = p147 or 2,
		["DirectHitDamage"] = p146 or 1,
		["Cooldown"] = p148,
		["Lifetime"] = p149,
		["MaxAmmo"] = p150,
		["AmmoType"] = p150 and "Grenade" or nil,
		["ThrowMaxChargeTime"] = p151,
		["ThrowForceMin"] = p152,
		["ThrowForceMax"] = p152,
		["ThrowGravity"] = p153,
		["LobMaxChargeTime"] = p154,
		["LobForceMin"] = p155,
		["LobForceMax"] = p155,
		["LobGravity"] = p156
	}
	local v159 = {
		["Inspect"] = false,
		["Shoot"] = false,
		["Aim"] = false
	}
	local v160 = { "StartShooting", "FinishShooting" }
	for v161, v162 in pairs(p157 or {}) do
		v158[v161] = v162
	end
	v_u_117("Throwable", p137, p138, p139, p140, p141, p142, p143, p144, v159, 0.1, 0.1, v160, nil, nil, v158)
end
v163("Standard", "Utility", "Grenade", 0.5, true, 1, nil, "Default", nil, nil, nil, 30, 10, nil, 4, 100, 300, 0.375, 4, 50, 150, 0.75, {
	["CanCook"] = true,
	["DetonateDelay"] = 2,
	["ExplosionRadius"] = 16,
	["ExplosionDamage"] = 75,
	["ExplosionKnockback"] = 1.5
})
v163("Standard", "Utility", "Molotov", 0.5, true, 1, nil, "Default", nil, nil, nil, 30, 10, nil, 4, 100, 300, 0.375, 4, 50, 150, 0.75, {
	["FireRadius"] = 16,
	["FireDuration"] = 7,
	["SplashDamage"] = 10,
	["DamagePerSecond"] = 25,
	["DamageTicksPerSecond"] = 10,
	["AfterburnDamage"] = 25,
	["AfterburnDuration"] = 4,
	["AfterburnTicks"] = 8
})
v163("Standard", "Utility", "Flashbang", 0.5, false, 1, nil, "Default", nil, nil, nil, 0.5, 10, 2, 4, 100, 300, 0.375, 4, 50, 150, 0.75, {
	["DetonateDelay"] = 1.5,
	["BlindDuration"] = 3,
	["BalancedAmmoRefill"] = 1
})
v163("Standard", "Utility", "Smoke Grenade", 0.5, false, 1, nil, "Default", nil, nil, nil, 0.5, 10, 3, 4, 100, 300, 0.375, 4, 50, 150, 0.75, {
	["SmokeRadius"] = 24,
	["SmokeDuration"] = 15,
	["BalancedAmmoRefill"] = 1
})
v163("Contraband", "Utility", "Elixir", 0.5, true, 1, nil, "Default", nil, nil, nil, 30, 10, nil, 4, 100, 300, 0.375, 4, 50, 150, 0.75, {
	["SplashRadius"] = 16,
	["Heal"] = 25,
	["HealDuration"] = 4,
	["Damage"] = 50,
	["DamageDuration"] = 4
})
v163("Standard", "Utility", "Satchel", 0, true, 1, nil, "Default", nil, 0, 0, 0.5, 90, 3, 4, 100, 300, 0.375, 4, 50, 150, 0.75, {
	["ExplosionRadius"] = 12,
	["ExplosionDamage"] = 25,
	["CriticalExplosionDamage"] = 50,
	["ExplosionKnockback"] = 1.5,
	["BalancedAmmoRefill"] = 1
})
v163("Prime", "Utility", "Warpstone", 0.5, false, 1, nil, "Default", nil, nil, nil, 30, 10, nil, 4, 100, 300, 0.375, 4, 50, 150, 0.75, {
	["RaycastHitboxSize"] = 0.25
})
v163("Standard", "Utility", "Holodome", 0.5, false, 1, nil, "Default", nil, 0, 0, 0.5, 15, 1, 4, 100, 300, 0.375, 4, 50, 150, 0.75, {
	["HolodomeRadius"] = 16,
	["ProjectorHealth"] = 25
})
local function v191(p164, p165, p166, p167, p168, p169, p170, p171, p172, p173, p174, p175, p176, p177, p178, p179, p180, p181, p182, p183, p184) -- name: add_melee
	-- upvalues: (copy) v_u_117
	local v185 = p183 == nil and 0 or p183
	local v186 = {
		["AttackMaxHits"] = p173 or math.huge,
		["BurstCount"] = p174 or 1,
		["BurstCooldown"] = p175 or 0,
		["AttackCooldown"] = p176,
		["AttackDelay"] = p177 or 0,
		["AttackConeAngle"] = p178 or 90,
		["AttackDamage"] = p179,
		["AttackReach"] = p180
	}
	local v187 = p172 or {
		["Inspect"] = false,
		["Shoot"] = false
	}
	local v188 = p181 or { "StartShooting" }
	for v189, v190 in pairs(p184 or {}) do
		v186[v189] = v190
	end
	v_u_117("Melee", p164, p165, p166, p167, p168, p169, p170, p171, v187, 0, v185, v188, p182, 0, v186)
end
v191("Standard", "Melee", "Fists", 0.55, true, 1.05, 1, "Default", nil, 2, nil, nil, 0.35, nil, nil, 30, 6, nil, nil, nil)
v191("Standard", "Melee", "Knife", 0.45, true, 1.1, nil, "Default", {
	["Inspect"] = false,
	["Shoot"] = false,
	["Aim"] = false
}, nil, nil, nil, 0.6, nil, nil, 40, 6, { "StartAiming" }, nil, nil, {
	["HeavyAttackCooldown"] = 1.25,
	["HeavyAttackDamage"] = 40,
	["HeavyAttackReach"] = 7,
	["CriticalDamage"] = 150
})
v191("Standard", "Melee", "Chainsaw", 0.6, true, 0.9, nil, "Default", {
	["Inspect"] = false,
	["Shoot"] = false,
	["Aim"] = false
}, nil, nil, nil, 0.6, nil, nil, 60, 6, nil, nil, nil, {
	["AmmoType"] = "Fuel",
	["MaxAmmo"] = 150,
	["MaxAmmoReserve"] = 0,
	["HoldSpeedBoostMin"] = 0.25,
	["HoldSpeedBoostMax"] = 0.85,
	["HoldSpeedBoostRampTime"] = 0.5,
	["HoldDamageMultiplier"] = 3,
	["InternalHoldCooldown"] = 0.25
})
v191("Standard", "Melee", "Katana", 0.65, true, 1, nil, "Default", {
	["Inspect"] = false,
	["Shoot"] = false,
	["Aim"] = false
}, nil, nil, nil, 0.7, nil, nil, 45, 6, nil, { "StartShooting", "StartAiming" }, nil, {
	["DeflectDuration"] = 1,
	["DeflectCooldown"] = 4,
	["DeflectDamageMultiplier"] = 1
})
v191("Standard", "Melee", "Scythe", 1, true, 1, nil, "Default", {
	["Inspect"] = false,
	["Shoot"] = false,
	["Aim"] = false
}, nil, nil, nil, 0.7, nil, nil, 35, 6, nil, { "StartShooting", "StartAiming" }, nil, {
	["DashCooldown"] = 4,
	["DashDuration"] = 0.25,
	["DashSpeed"] = 100
})
v191("Prime", "Melee", "Trowel", 1, true, 1.1, nil, "Default", {
	["Inspect"] = false,
	["Shoot"] = false,
	["Aim"] = false
}, nil, nil, nil, 0.6, nil, nil, 50, 6, nil, { "StartShooting", "StartAiming" }, nil, {
	["BuildCooldown"] = 4,
	["BuildReach"] = 50,
	["MaxBricks"] = 25,
	["BrickLifetime"] = 30
})
v191("Standard", "Melee", "Battle Axe", 0.85, true, 0.9, nil, "Default", {
	["Inspect"] = false,
	["Shoot"] = false,
	["Aim"] = false
}, nil, nil, nil, 0.7, nil, nil, 55, 6, { "StartAiming" }, nil, nil, {
	["SpinCooldown"] = 4,
	["SpinDuration"] = 0.25,
	["SpinSpeed"] = 75,
	["SpinRadius"] = 10,
	["SpinDamage"] = 30
})
v191("Standard", "Melee", "Riot Shield", 1.05, true, 0.9, nil, "Default", {
	["Inspect"] = false,
	["Shoot"] = false
}, nil, nil, nil, 0.7, nil, nil, 25, 6, nil, nil, nil, {
	["KnockbackForce"] = 64,
	["MaxAbsorption"] = 500,
	["AbsorptionPercent"] = 1,
	["AmmoType"] = "Shield",
	["NeedsAmmoToAttack"] = true
})
v191("Contraband", "Melee", "Glast Shard", 0.45, true, 1.1, 1, "Default", {
	["Inspect"] = false,
	["Shoot"] = false,
	["Aim"] = false
}, nil, nil, nil, 0.6, nil, nil, 1, 6, { "StartAiming" }, nil, nil, {
	["HeavyAttackCooldown"] = 1.25,
	["HeavyAttackDamage"] = 1,
	["HeavyAttackReach"] = 7,
	["CriticalDamage"] = 150
})
v191("Prime", "Melee", "Maul", 1, true, 0.8, nil, "Default", {
	["Inspect"] = false,
	["Shoot"] = false,
	["Aim"] = false
}, nil, nil, nil, 1, 0.45, nil, 75, 8, nil, nil, nil, {
	["KnockbackForce"] = 64,
	["SlamCooldown"] = 6,
	["SlamRadius"] = 24,
	["SlamDamage"] = 50,
	["SlamEndLag"] = 1,
	["SlamFloorDistance"] = 8,
	["LeapCooldown"] = 0.25
})
v191("Prime", "Melee", "Spear", 0.6, true, 1, nil, "Default", {
	["Inspect"] = false,
	["Shoot"] = false,
	["Aim"] = false
}, nil, 3, 0.075, 0.5, nil, 30, 15, 18, nil, { "StartShooting", "StartAiming" }, nil, {
	["NeedsAmmoToAttack"] = true,
	["AmmoType"] = "Spear",
	["MaxAmmo"] = 3,
	["ThrowCooldown"] = 1,
	["ThrowDamage"] = 30,
	["CriticalThrowDamage"] = 60,
	["ThrowKnockbackForce"] = 80,
	["ThrowRadius"] = 0.5,
	["ThrownSpearLength"] = 5,
	["ThrownSpearLifetime"] = 90
})
local function v296(p192, p193, p194, p195, p196, p197, p198, p199, p200, p201, p202, p203, p204, p205, p206, p207, p208, p209, p210, p211, p212, p213, p214, p215, p216, p217, p218, p219, p220, p221, p222, p223, p224, p225, p226, p227, p228, p229, p230, p231, p232, p233, p234, p235, p236, p237, _, p238, p239, p240, p241, p242, p243, p244, p245, p246, p247, p248, p249, p250, p251, p252) -- name: add_gun
	-- upvalues: (copy) v_u_3, (copy) v_u_36, (copy) v_u_117
	local v253 = p249 or (p202 and p202 > 1 and (p203 * p202) ^ 2 or p204 ^ 2)
	if not p250 then
		p250 = {
			["Inspect"] = false,
			["Shoot"] = false,
			["Aim"] = true
		}
		local v254
		if p243 and p243 > 0 then
			v254 = false
		else
			v254 = nil
		end
		p250.Reload = v254
	end
	local v255 = p200 == nil and 0 or p200
	local v256 = p201 == nil and 0 or p201
	local v257 = p251 or { "StartShooting" }
	local v258 = p227 and true or false
	local v259 = v_u_3.Info[v_u_36.ViewModels[p194].Animations.Reload]
	local v260 = v_u_3.Info[v_u_36.ViewModels[p194].Animations.ReloadStart]
	local v261 = v_u_3.Info[v_u_36.ViewModels[p194].Animations.ReloadSegment]
	local v262 = v_u_3.Info[v_u_36.ViewModels[p194].Animations.ReloadFinish]
	local v263 = v_u_3.Info[v_u_36.ViewModels[p194].Animations.Reload2]
	local v264 = v_u_3.Info[v_u_36.ViewModels[p194].Animations.EmptyReload]
	local v265 = v_u_3.Info[v_u_36.ViewModels[p194].Animations.EmptyReloadStart]
	local v266 = v_u_3.Info[v_u_36.ViewModels[p194].Animations.EmptyReloadSegment]
	local v267 = v_u_3.Info[v_u_36.ViewModels[p194].Animations.EmptyReloadFinish]
	local v268 = v259 and "Regular" or (v260 and "Segmented" or nil)
	local v269 = {
		["CriticalDamage"] = p206,
		["DisableTraditionalCrits"] = p207,
		["BurstCount"] = p202 or 1,
		["BurstCooldown"] = p203 or 0,
		["ShootCooldown"] = p204,
		["ShootDamage"] = p205,
		["ShootRecoil"] = p208,
		["ShootAccuracy"] = p209,
		["ShootExplosionRadius"] = p210 or 0,
		["ShootExplosionDamage"] = p205,
		["ShootExplosionKnockback"] = p211 or 1,
		["ShootPellets"] = p212 or 1,
		["ShootSpread"] = p213 or 0.5,
		["ShootSpreadConsistent"] = p214 or false,
		["ShootSpreadPerVelocityUnit"] = p215 or 0,
		["ShootSpreadPerVelocityLimit"] = p216 or 0,
		["ShootCameraDisplacementRecoil"] = p217 or Vector2.zero,
		["ShootCameraDisplacementRecoilWhileAiming"] = p218 or nil,
		["IsRaycast"] = not v258,
		["RaycastGrabSmallHitboxes"] = p219 or false,
		["RaycastBounceCount"] = p220 or 0,
		["RaycastBounceAlwaysCrits"] = p221,
		["RaycastBounceRedirectionAngle"] = math.rad(p222 or 0) / 2,
		["RaycastPierceCount"] = p223 or 0,
		["RaycastDamageDropoffMultiplier"] = p224,
		["RaycastDamageDropoffStartDistance"] = p225,
		["RaycastDamageDropoffEndDistance"] = p226,
		["IsProjectile"] = v258,
		["ProjectileType"] = p227,
		["ProjectileSpeed"] = p230 or 300,
		["ProjectileGravity"] = p231 or 0,
		["ProjectileMaxHits"] = p232 or 1,
		["ProjectileSpawnOffset"] = p233 or CFrame.new(0, 0, -3),
		["ProjectileGrowthSpeed"] = p234 or 0,
		["ProjectileGrowthLimit"] = p235 or 1,
		["ProjectileLifetime"] = p236 or 5,
		["ProjectileDontExplodeOnImpact"] = p237 or false,
		["ProjectileWallClipPreventionEnabled"] = true,
		["ProjectileLogicDisabled"] = p238 or false,
		["ProjectileLogicOptimized"] = p239 or false,
		["ProjectilePhysicalClientSided"] = p229 or false,
		["ProjectileRaycastRadius"] = p228 or 1,
		["DamageType"] = p240 or (p210 and p210 > 0 and "Splash" or (v258 and "Projectile" or "Bullet")),
		["AmmoType"] = p241,
		["MaxAmmo"] = p242,
		["MaxAmmoReserve"] = p243,
		["ReloadType"] = v268,
		["NumReloadFiles"] = ((v259 or v260) and 1 or 0) + (v263 and 1 or 0),
		["NumEmptyReloadFiles"] = (v268 == "Regular" and v264 ~= nil or v268 == "Segmented" and v265 ~= nil) and 1 or 0
	}
	local v270 = {}
	local v271 = {}
	local v272 = {}
	local v273
	if v259 then
		v273 = v259.ActionTimestamp
	else
		v273 = nil
	end
	v272.ActionTimestamp = v273
	local v274
	if v259 then
		v274 = v259.Length
	else
		v274 = nil
	end
	v272.Length = v274
	local v275
	if v260 then
		v275 = v260.ActionTimestamp
	else
		v275 = nil
	end
	v272.StartActionTimestamp = v275
	local v276
	if v260 then
		v276 = v260.Length
	else
		v276 = nil
	end
	v272.StartLength = v276
	local v277
	if v261 then
		v277 = v261.ActionTimestamp
	else
		v277 = nil
	end
	v272.SegmentActionTimestamp = v277
	local v278
	if v261 then
		v278 = v261.Length
	else
		v278 = nil
	end
	v272.SegmentLength = v278
	local v279
	if v262 then
		v279 = v262.ActionTimestamp
	else
		v279 = nil
	end
	v272.FinishActionTimestamp = v279
	local v280
	if v262 then
		v280 = v262.Length
	else
		v280 = nil
	end
	v272.FinishLength = v280
	v271[1] = v272
	local v281 = {}
	local v282
	if v263 then
		v282 = v263.ActionTimestamp
	else
		v282 = nil
	end
	v281.ActionTimestamp = v282
	local v283
	if v263 then
		v283 = v263.Length
	else
		v283 = nil
	end
	v281.Length = v283
	v271[2] = v281
	v270.Reload = v271
	local v284 = {}
	local v285 = {}
	local v286
	if v264 then
		v286 = v264.ActionTimestamp
	else
		v286 = nil
	end
	v285.ActionTimestamp = v286
	local v287
	if v264 then
		v287 = v264.Length
	else
		v287 = nil
	end
	v285.Length = v287
	local v288
	if v265 then
		v288 = v265.ActionTimestamp
	else
		v288 = nil
	end
	v285.StartActionTimestamp = v288
	local v289
	if v265 then
		v289 = v265.Length
	else
		v289 = nil
	end
	v285.StartLength = v289
	local v290
	if v266 then
		v290 = v266.ActionTimestamp
	else
		v290 = nil
	end
	v285.SegmentActionTimestamp = v290
	local v291
	if v266 then
		v291 = v266.Length
	else
		v291 = nil
	end
	v285.SegmentLength = v291
	local v292
	if v267 then
		v292 = v267.ActionTimestamp
	else
		v292 = nil
	end
	v285.FinishActionTimestamp = v292
	local v293
	if v267 then
		v293 = v267.Length
	else
		v293 = nil
	end
	v285.FinishLength = v293
	v284[1] = v285
	v270.EmptyReload = v284
	v269.ReloadFiles = v270
	v269.AimFOVOffset = p247 or -50
	v269.AimSpeed = p244 or 1
	v269.AimScopePercent = p245
	v269.AimSpreadMultiplier = p246 or 0
	v269.DisableTracerEffects = p248
	for v294, v295 in pairs(p252 or {}) do
		v269[v294] = v295
	end
	v_u_117("Gun", p192, p193, p194, p195, p196, p197, p198, p199, p250, v255, v256, v257, nil, v253, v269)
end
v296("Standard", "Primary", "MISSING_WEAPON", 0.65, true, 0.9, nil, "Default", nil, nil, nil, nil, 0.1, 12, 15, nil, 1, 1, nil, nil, nil, 1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, 0.25, 50, 200, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, "Medium", 20, 100, nil, nil, nil, nil, nil, nil, nil, nil, nil)
v296("Standard", "Secondary", "Flare Gun", 1.3, true, 1.1, nil, "Default", false, nil, nil, nil, 0.25, nil, nil, nil, 2.5, 0.75, 8, 0, nil, 0, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, "PhysicalProjectile", nil, nil, 150, 0.5, nil, CFrame.new(1, -1, -3) * CFrame.Angles(math.rad(4), 0, 0), nil, nil, 30, nil, nil, true, nil, nil, "Shells", 1, 1, nil, nil, nil, -40, nil, 0, nil, nil, {
	["DamagePerSecond"] = 50,
	["DamageTicksPerSecond"] = 10,
	["AfterburnDamage"] = 25,
	["AfterburnDuration"] = 4,
	["AfterburnTicks"] = 8
})
v296("Standard", "Primary", "Assault Rifle", 0.65, true, 0.9, nil, "Default", nil, nil, nil, nil, 0.1, 12, 15, nil, 1, 1, nil, nil, nil, 1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, 0.5, 50, 150, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, "Medium", 20, 100, nil, nil, nil, nil, nil, nil, nil, nil, nil)
v296("Standard", "Secondary", "Handgun", 0.2, true, 1, nil, "Default", false, nil, nil, nil, 0.13, 12, 15, nil, 1, 1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, 0.5, 50, 100, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, "Light", 13, 91, nil, nil, nil, -40, nil, nil, nil, nil, nil)
v296("Standard", "Primary", "Burst Rifle", 0.75, true, 0.9, nil, "Default", nil, nil, 3, 0.08, 0.6, 20, 25, nil, 1.5, 0.75, nil, nil, nil, 2, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, 0.5, 60, 150, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, "Medium", 12, 60, nil, nil, nil, nil, nil, 0.04, nil, nil, nil)
v296("Standard", "Primary", "Sniper", 1.15, true, 0.8, nil, "Default", false, false, nil, nil, 1.5, 50, 150, nil, 10, 0.2, nil, nil, nil, 15, nil, nil, nil, nil, nil, true, nil, nil, nil, 9, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, "Heavy", 4, 12, 0.55, 0.925, nil, nil, nil, nil, nil, nil, nil)
v296("Standard", "Primary", "RPG", 1, true, 0.85, nil, "Default", nil, nil, nil, nil, 0.25, 50, 100, nil, 5, 0.4, 16, 1.5, nil, 0, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, "RaycastProjectile", nil, nil, 100, nil, nil, CFrame.new(1, -1, -3), nil, nil, nil, nil, nil, nil, nil, nil, "Rockets", 1, 17, 0.625, nil, nil, nil, nil, 0.025, nil, nil, nil)
v296("Standard", "Secondary", "Shorty", 0.6, true, 1, nil, "SpreadH", false, nil, nil, nil, 0.125, 80, 120, nil, 5, 0.25, nil, nil, 10, 6.5, true, nil, nil, nil, nil, nil, nil, nil, nil, nil, 0.5625, 10, 20, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, "Shells", 2, 18, nil, nil, 0.75, -40, nil, nil, nil, nil, nil)
v296("Standard", "Primary", "Shotgun", 0.75, true, 1, nil, "Spread", false, false, nil, nil, 0.7, 80, 120, nil, 2.5, 0.75, nil, nil, 10, 6.5, true, nil, nil, nil, nil, nil, nil, nil, nil, 2, 0.5625, 10, 40, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, "Shells", 7, 35, nil, nil, 0.75, -20, nil, 0.04, nil, nil, nil)
v296("Standard", "Primary", "Bow", 0.85, true, 1.05, 1, "Default", nil, nil, nil, nil, 0.25, 30, 60, nil, 0, 1, nil, nil, nil, 0, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, "RaycastProjectile", 0.25, true, 300, 0.25, nil, CFrame.new(0, -1, -2), 100, 6, nil, nil, nil, nil, nil, nil, "Arrows", 1, 30, nil, nil, nil, nil, nil, 0.025, {
	["Inspect"] = false,
	["Shoot"] = false,
	["Aim"] = false,
	["Reload"] = false
}, nil, {
	["ChargeReleaseCooldown"] = 1,
	["ChargeReleaseReloadTimestamp"] = 0.65,
	["ChargeLevelTimestamps"] = nil,
	["ChargeLevelDamageMultipliers"] = nil,
	["ChargeLevelTimestamps"] = {
		0,
		0.3,
		1,
		1.8
	},
	["ChargeLevelDamageMultipliers"] = {
		1,
		1.25,
		1.5,
		2
	}
})
v296("Standard", "Secondary", "Uzi", 0.45, true, 1, nil, "Default", nil, nil, nil, nil, 0.07, 8, 10, nil, 1, 0.8, nil, nil, nil, 1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, 0.5, 50, 100, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, "Light", 27, 108, 1.5, nil, 0.5, -40, nil, nil, nil, nil, nil)
v296("Standard", "Secondary", "Revolver", 0.6, true, 0.95, nil, "Default", false, nil, nil, nil, 0.4, 30, 40, nil, 2, 3, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, 0.5, 75, 150, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, "Light", 6, 36, nil, nil, nil, -40, nil, 0.04, {
	["Inspect"] = false,
	["Shoot"] = false,
	["Aim"] = false,
	["Reload"] = false
}, nil, {
	["QuickShotCooldown"] = 0.15,
	["QuickShotSpread"] = 7
})
v296("Prime", "Primary", "Paintball Gun", 0.8, true, 0.9, nil, "Default", nil, nil, nil, nil, 0.15, 22, nil, nil, 0.5, 2, nil, nil, nil, 0, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, "RaycastProjectile", 0.25, nil, 550, 0, 1, CFrame.new(1, -1.5, -3), 100, 7.5, nil, nil, nil, nil, true, nil, "Ball", 16, 48, nil, nil, nil, -20, nil, nil, {
	["Inspect"] = false,
	["Shoot"] = false,
	["Aim"] = false,
	["Reload"] = false
}, { "StartAiming" }, {
	["GrenadeShootCooldown"] = 0.75,
	["GrenadeCooldown"] = 8,
	["GrenadeExplosionRadius"] = 12,
	["GrenadeSplatterDuration"] = 5
})
v296("Prime", "Secondary", "Slingshot", 0.45, true, 1.1, nil, "Default", nil, nil, nil, nil, 0.1, 8, 12, nil, 0.5, 1.5, nil, nil, nil, 0, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, "RaycastProjectile", 0.375, nil, 300, 1, 3, CFrame.new(0, -2, -3) * CFrame.Angles(math.rad(4), 0, 0), 100, 3.333, nil, nil, true, nil, true, nil, "Ball", 99, 0, nil, nil, nil, -10, nil, nil, nil, nil, nil)
v296("Prime", "Primary", "Grenade Launcher", 1, true, 0.9, nil, "Default", nil, nil, nil, nil, 0.6, 45, 90, nil, 4, 0.75, 14, 1.25, nil, 0, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, "RaycastProjectile", 0.375, nil, 100, 0.25, math.huge, CFrame.new(0.5, -1, -3) * CFrame.Angles(math.rad(4), 0, 0), nil, nil, 10, nil, nil, nil, nil, nil, "Shells", 6, 24, 0.75, nil, nil, -15, nil, 0.025, {
	["Inspect"] = false,
	["Shoot"] = false,
	["Aim"] = false,
	["Reload"] = false
}, nil, nil)
v296("Prime", "Primary", "Minigun", 1, true, 0.75, nil, "Default", nil, nil, nil, nil, 0.05, 8, 10, nil, 1, 1, nil, nil, nil, 2, nil, 0.18, 2, nil, nil, nil, nil, nil, nil, 2, 0.625, 50, 150, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, "Heavy", 300, 0, 0.15, nil, 0.5, -5, nil, nil, nil, nil, {
	["ChargingSpeedBoost"] = -0.5,
	["ChargingWindUpLength"] = 0.8
})
v296("Prime", "Secondary", "Exogun", 0.7, true, 1, nil, "Default", nil, nil, nil, nil, 0.28, 10, 20, nil, 2, 1, 6.28, 0, nil, 0.628, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, 0.2143, 60, 280, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, "Ball", 6, 28, nil, nil, nil, -30, nil, 0.025, nil, nil, nil)
v296("Standard", "Utility", "Freeze Ray", 0.5, false, 1, nil, "Default", nil, nil, nil, nil, 0.5, 0, nil, nil, 2, 1, 16, 0, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, "PhysicalProjectile", nil, nil, 75, 0.25, nil, CFrame.new(0.5, -0.5, -3) * CFrame.Angles(math.rad(4), 0, 0), nil, nil, nil, nil, nil, nil, nil, nil, "Ball", 1, 0, nil, nil, nil, -30, nil, -1, nil, { "StartShooting" }, {
	["FreezeDuration"] = 4,
	["SlowDuration"] = 2.5,
	["SlowBoost"] = -0.5
})
v296("Contraband", "Secondary", "Scepter", 1, true, 1, nil, "Default", nil, nil, nil, nil, 0.5, 25, nil, nil, 0, 1, 12, 0, nil, 0, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, "PhysicalProjectile", nil, true, 200, 0, nil, CFrame.new(1, -1, 0), nil, nil, nil, nil, nil, nil, nil, nil, "Ball", 30, 0, nil, nil, nil, nil, nil, 0.025, nil, nil, {
	["TransformDelay"] = 0.5
})
v296("Standard", "Secondary", "Daggers", 0.6, true, 1.1, 1, "Default", nil, nil, 2, 0.1, 0.6, 20, 40, nil, 0, 1, nil, nil, nil, 0, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, "RaycastProjectile", 0.25, true, 300, 0.25, nil, CFrame.new(0, -1, -2) * CFrame.Angles(math.rad(4), 0, 0), 100, 6, nil, nil, nil, nil, nil, nil, "Daggers", 2, 60, nil, nil, nil, nil, nil, 0.025, {
	["Inspect"] = false,
	["Shoot"] = false,
	["Reload"] = false
}, nil, nil)
v296("Prime", "Secondary", "Energy Pistols", 0.6, true, 1, nil, "Default", nil, nil, nil, nil, 0.03, 2.1, 2.625, nil, 0.2, 1, nil, nil, nil, 0, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, "Light", math.huge, 0, nil, nil, nil, -20, true, nil, nil, nil, nil)
v296("Prime", "Primary", "Energy Rifle", 1.05, true, 1, nil, "Default", nil, nil, nil, nil, 0.3, 20, 60, true, 2, 1, nil, nil, nil, 0, nil, nil, nil, nil, nil, nil, 2, true, 0, 9, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, "Medium", math.huge, 0, nil, nil, nil, nil, nil, 0.025, nil, nil, nil)
v296("Standard", "Secondary", "Spray", 0.45, true, 1.05, nil, "Default", nil, nil, 5, 0.04, 0.5, 8, 10, nil, 2, 0.75, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, 0.4, 50, 100, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, "Light", 30, 90, 1.25, nil, nil, -40, nil, nil, nil, nil, {
	["DealsTrueDamage"] = true
})
v296("Standard", "Primary", "Crossbow", 1.15, true, 1.05, nil, "Default", false, false, nil, nil, 1, 37.5, 75, nil, 1, 0.2, nil, nil, nil, 0, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, "Projectile", "Arrows", 1, 20, 0.75, 0.875, nil, nil, nil, nil, nil, nil, nil)
local v297 = {
	["TransitionCooldown"] = 0.6,
	["BladeDamage"] = 35,
	["BladeCriticalDamage"] = 50,
	["BladeCooldown"] = 0.5,
	["BladeReach"] = 8,
	["BladeMaxHits"] = nil,
	["DashCooldown"] = 1.5,
	["DashDuration"] = 0.1875,
	["DashSpeed"] = 100,
	["BladeModeMobileInputSettings"] = nil,
	["BladeMaxHits"] = math.huge,
	["BladeModeMobileInputSettings"] = {
		["Inspect"] = false,
		["Shoot"] = false,
		["Aim"] = false
	}
}
v296("Standard", "Primary", "Gunblade", 1, true, 1, nil, "Default", nil, false, nil, nil, 0.75, 45, 55, nil, 3, 1, nil, nil, nil, 0, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, "Medium", 12, 0, nil, nil, nil, nil, nil, nil, {
	["Inspect"] = false,
	["Shoot"] = false,
	["Aim"] = true
}, nil, v297)
v296("Contraband", "Secondary", "Glass Cannon", 0.75, true, 0.95, nil, "Default", false, nil, nil, nil, 1, 150, nil, true, 15, 3, nil, nil, nil, 0, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, "Heavy", 1, 0, nil, nil, nil, nil, nil, nil, {
	["Inspect"] = false,
	["Shoot"] = false,
	["Reload"] = false
}, nil, nil)
v296("Contraband", "Primary", "Distortion", 1.25, true, 1, nil, "SpreadH", nil, nil, nil, nil, 0.4, 35, nil, nil, 1, 0.5, 4, 0, 5, 5, true, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, 90, 0.25, nil, CFrame.new(0.5, -1, -3) * CFrame.Angles(math.rad(4), 0, 0), nil, nil, nil, nil, nil, nil, nil, nil, "Ball", 45, 0, 0.75, nil, nil, nil, nil, 0.025, {
	["Inspect"] = false,
	["Shoot"] = false,
	["Aim"] = false
}, { "StartAiming" }, {
	["VortexCooldown"] = 30,
	["VortexRadius"] = 12,
	["VortexLifetime"] = 4
})
v296("Contraband", "Primary", "Permafrost", 0.5, true, 1, nil, "Default", nil, nil, 2, 0.06, 0.15, 14, 17.5, nil, 1, 1, nil, 0, nil, 1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, 0.5, 40, 80, nil, nil, nil, 75, 0.25, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, "Medium", 24, 72, nil, nil, nil, nil, nil, nil, {
	["Inspect"] = false,
	["Shoot"] = false,
	["Aim"] = false,
	["Reload"] = false
}, nil, {
	["MaxFreezeDuration"] = 3,
	["SlowDuration"] = 1.5,
	["MaxSlowBoost"] = -0.5,
	["MaxSlowStacks"] = 10
})
v296("Standard", "Primary", "Wildcat", 0.45, true, 1.05, nil, "Default", nil, nil, nil, nil, 0.06, 9, 12, nil, 1, 0.8, nil, nil, nil, 3, nil, nil, nil, Vector2.new(25, 5), Vector2.new(10, 2), nil, nil, nil, nil, nil, 0.5, 40, 80, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, "Light", 30, 120, 1.5, nil, 0.3, -40, nil, nil, nil, nil, nil);
(function() -- name: alphabetize
	-- upvalues: (copy) v_u_36, (copy) v_u_4
	for _, v298 in pairs(v_u_36.ItemOrder) do
		local v299 = v_u_36.ItemsAlphabetized
		table.insert(v299, v298)
	end
	table.sort(v_u_36.ItemsAlphabetized, function(p300, p301)
		-- upvalues: (ref) v_u_4
		return v_u_4:StringLessThan(string.lower(p300), string.lower(p301))
	end)
end)();
(function() -- name: animation_check
	-- upvalues: (copy) v_u_2, (copy) v_u_36, (copy) v_u_3
	if v_u_2.IS_STUDIO and v_u_2.IS_SERVER then
		local v302 = {}
		local v303 = {
			["grenade_lob"] = true,
			["grenade_lob_pinpull"] = true,
			["grenade_pixelgrenade_lob_start"] = true,
			["grenade_pixelgrenade_throw"] = true,
			["grenade_pixelgrenade_throw_pinpull"] = true,
			["grenade_pixelgrenade_throw_start"] = true,
			["grenade_throw"] = true,
			["grenade_throw_pinpull"] = true,
			["katana_deflect_loop"] = true,
			["katana_sprint"] = true,
			["shotgun_reload_empty_finish"] = true,
			["shotgun_reload_finish2"] = true,
			["shotgun_shotkey_shoot_aiming"] = true,
			["flamethrower_keythrower_sprint"] = true,
			["maul_charge_intro"] = true,
			["maul_charge_loop"] = true,
			["maul_charge_outro"] = true,
			["maul_sleighmaul_charge_outro"] = true
		}
		for _, v304 in pairs(v_u_36.ViewModels) do
			for _, v305 in pairs(v304.Animations) do
				v302[v305] = true
			end
		end
		local v306 = {}
		for v307 in pairs(v_u_3.Info) do
			if v302[v307] or v303[v307] then
				continue
			end
			v306[v307] = true
		end
		if next(v306) then
			warn("[STUDIO] Unused animations:", v306)
		end
	end
end)()
return v_u_36