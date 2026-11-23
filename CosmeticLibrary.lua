local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("MaterialService")
local v3 = game:GetService("Players")
local v_u_4 = require(v1.Modules.CONSTANTS)
local v_u_5 = require(v1.Modules.CurrencyLibrary)
local v_u_6 = require(v1.Modules.ItemLibrary)
local v_u_7 = require(v1.Modules.ShopLibrary)
local v_u_8 = require(v1.Modules.Utility)
local v_u_64 = {
	["IGNORE_TRANSPARENCY_WHITELIST"] = {
		["Riot Shield"] = true
	},
	["RENAMED_COSMETICS"] = {
		["Hexxed"] = "Vexed",
		["Hexxed Flare Gun"] = "Vexed Flare Gun",
		["Hexxed Candle"] = "Vexed Candle",
		["Rivals"] = "RIVALS",
		["Bone Crossbow"] = "Crossbone",
		["Bonestone"] = "Warpbone",
		["2025 Energy Rifle"] = "New Year Energy Rifle",
		["2025 Energy Pistols"] = "New Year Energy Pistols",
		["2025 Katana"] = "New Year Katana",
		["New Year Rifle"] = "New Year Energy Rifle",
		["Poop"] = "Chocolate Scoop",
		["Devil\'s Trident"] = "Evil Trident",
		["Arena Diorama"] = "Diorama Arena",
		["Backrooms Diorama"] = "Diorama Backrooms",
		["Battleground Diorama"] = "Diorama Battleground",
		["Big Arena Diorama"] = "Diorama Big Arena",
		["Big Backrooms Diorama"] = "Diorama Big Backrooms",
		["Big Crossroads Diorama"] = "Diorama Big Crossroads",
		["Big Graveyard Diorama"] = "Diorama Big Graveyard",
		["Big Onyx Diorama"] = "Diorama Big Onyx",
		["Big Splash Diorama"] = "Diorama Big Splash",
		["Big Station Diorama"] = "Diorama Big Station",
		["Bridge Diorama"] = "Diorama Bridge",
		["Chess Diorama"] = "Diorama Chess",
		["Construction Diorama"] = "Diorama Construction",
		["Crossroads Diorama"] = "Diorama Crossroads",
		["Dimension Diorama"] = "Diorama Dimension",
		["Docks Diorama"] = "Diorama Docks",
		["Graveyard Diorama"] = "Diorama Graveyard",
		["Iceberg Diorama"] = "Diorama Iceberg",
		["Onyx Diorama"] = "Diorama Onyx",
		["Playground Diorama"] = "Diorama Playground",
		["Shooting Range Diorama"] = "Diorama Shooting Range",
		["Splash Diorama"] = "Diorama Splash",
		["Station Diorama"] = "Diorama Station",
		["Village Diorama"] = "Diorama Village",
		["FAMAS"] = "Bullpup Burst",
		["Sand FAMAS"] = "Sand Bullpup Burst",
		["AUG"] = "Augmented Rifle",
		["Gingerbread AUG"] = "Gingerbread Augmented Rifle",
		["Tommy Gun"] = "Drum Gun",
		["RIA25 Award"] = "RIA25 Best Shooter"
	},
	["Rarities"] = {},
	["Types"] = {},
	["Cosmetics"] = {},
	["CosmeticsAlphabetized"] = {},
	["CosmeticNameToLootbox"] = {},
	["Rewards"] = {},
	["LootboxOrder"] = {},
	["OwnsCosmeticForWeapon"] = function(_, p9, p10, p11) -- name: OwnsCosmeticForWeapon
		local v12 = p9 and p9[p10]
		if v12 then
			v12 = p9[p10][p11]
		end
		return v12
	end,
	["OwnsCosmeticUniversally"] = function(_, p13, p14) -- name: OwnsCosmeticUniversally
		local v15 = p13 and p13[p14]
		if v15 then
			v15 = p13[p14].IsUniversal
		end
		return v15
	end,
	["OwnsCosmeticNormally"] = function(_, p16, p17) -- name: OwnsCosmeticNormally
		if p16 then
			p16 = p16[p17] == true
		end
		return p16
	end,
	["OwnsCosmetic"] = function(p18, p19, p20, p21) -- name: OwnsCosmetic
		return p18:OwnsCosmeticNormally(p19, p20) or (p18:OwnsCosmeticUniversally(p19, p20) or p18:OwnsCosmeticForWeapon(p19, p20, p21))
	end,
	["OwnsCosmeticForSomething"] = function(p22, p23, p24) -- name: OwnsCosmeticForSomething
		if p22:OwnsCosmeticNormally(p23, p24) then
			return true
		end
		for _, v25 in pairs(p23 and p23[p24] or {}) do
			if not v25 then
				continue
			end
			return true
		end
	end,
	["HasNotification"] = function(_, p26, p27, p28) -- name: HasNotification
		if p26 and p26[p27] then
			return p26[p27] == true and true or p26[p27][p28]
		else
			return false
		end
	end,
	["CountNotificationsByWeapon"] = function(_, p29, p30) -- name: CountNotificationsByWeapon
		local v31 = 0
		for _, v32 in pairs(p29) do
			if typeof(v32) ~= "table" then
				continue
			end
			for v33 in pairs(v32) do
				if v33 ~= p30 then
					continue
				end
				v31 = v31 + 1
			end
		end
		return v31
	end,
	["CountNotificationsByCosmeticType"] = function(p34, p35, p36, p37, p38) -- name: CountNotificationsByCosmeticType
		local v39 = 0
		for v40, v41 in pairs(p35) do
			local v42 = p34.Cosmetics[v40]
			if not v42 or v42.Type ~= p36 then
				continue
			end
			if typeof(v41) == "table" then
				for v43 in pairs(v41) do
					if p38 and not p38[v43] or v43 ~= p37 then
						continue
					end
					v39 = v39 + 1
				end
			else
				if v41 ~= true then
					continue
				end
				v39 = v39 + 1
			end
		end
		return v39
	end,
	["CountNotifications"] = function(p44, p45, p46, p47) -- name: CountNotifications
		if not p46 then
			local v48 = 0
			for v49 in pairs(p45) do
				v48 = v48 + p44:CountNotifications(p45, v49, p47)
			end
			return v48
		end
		if not (p45 and p45[p46]) then
			return 0
		end
		if p45[p46] == true then
			return 1
		end
		local v50 = 0
		for v51 in pairs(p45[p46]) do
			if p47 and not p47[v51] then
				continue
			end
			v50 = v50 + 1
		end
		return v50
	end,
	["IsNoneSpecificCosmeticName"] = function(p52, p53) -- name: IsNoneSpecificCosmeticName
		-- upvalues: (copy) v_u_64
		for v54, v55 in pairs(v_u_64.Types) do
			if not v55.IsWeaponCosmetic or p53 ~= p52:GetNoneSpecificCosmeticName("NONE_COSMETIC", v54) then
				continue
			end
			return true
		end
		return false
	end,
	["GetNoneSpecificCosmeticName"] = function(_, p56, p57) -- name: GetNoneSpecificCosmeticName
		-- upvalues: (copy) v_u_64
		local v58 = not p57 or v_u_64.Types[p57].IsWeaponCosmetic
		assert(v58)
		if p56 == "NONE_COSMETIC" then
			return p56 .. "_" .. p57
		else
			return p56
		end
	end,
	["ExternallySetCosmeticDescription"] = function(_, p59, p60) -- name: ExternallySetCosmeticDescription
		-- upvalues: (copy) v_u_64
		if #p59 < 8 or string.sub(p59, 1, 8) ~= "MISSING_" then
			local v61 = v_u_64.Cosmetics[p59] ~= nil
			assert(v61, p59)
			local v62 = v_u_64.Cosmetics[p59].Description
			local v63 = not v62 or v62 == p60
			assert(v63, p59)
			v_u_64.Cosmetics[p59].Description = p60
		end
	end
}
local v_u_65 = {}
local v66 = {
	["Value"] = 0,
	["Color"] = nil,
	["Color"] = Color3.fromRGB(255, 255, 255)
}
v_u_64.Rarities.None = v66
local v67 = {
	["Value"] = 1,
	["Color"] = nil,
	["Color"] = Color3.fromRGB(255, 140, 0)
}
v_u_64.Rarities.Unique = v67
local v68 = {
	["Value"] = 2,
	["Color"] = nil,
	["Color"] = Color3.fromRGB(123, 255, 0)
}
v_u_64.Rarities.Common = v68
local v69 = {
	["Value"] = 3,
	["Color"] = nil,
	["Color"] = Color3.fromRGB(0, 221, 255)
}
v_u_64.Rarities.Rare = v69
local v70 = {
	["Value"] = 4,
	["Color"] = nil,
	["Color"] = Color3.fromRGB(255, 0, 0)
}
v_u_64.Rarities.Legendary = v70
local v71 = {
	["Value"] = 5,
	["Color"] = nil,
	["Color"] = Color3.fromRGB(64, 68, 186)
}
v_u_64.Rarities.Mythical = v71
local v72 = {
	["Value"] = 6,
	["Color"] = nil,
	["Color"] = Color3.fromRGB(56, 80, 33)
}
v_u_64.Rarities.Genuine = v72
local v73 = {
	["Value"] = 7,
	["Color"] = nil,
	["Color"] = Color3.fromRGB(0, 0, 0)
}
v_u_64.Rarities.Unobtainable = v73
v_u_64.Types.Reward = {
	["Name"] = "Reward",
	["Value"] = 0,
	["Image"] = nil,
	["IsWeaponCosmetic"] = nil,
	["NotCosmetic"] = true
}
v_u_64.Types.Charm = {
	["Name"] = "Charm",
	["Value"] = 1,
	["Image"] = "rbxassetid://133391928250838",
	["IsWeaponCosmetic"] = true,
	["NotCosmetic"] = nil
}
v_u_64.Types.Wrap = {
	["Name"] = "Wrap",
	["Value"] = 2,
	["Image"] = "rbxassetid://112715941288555",
	["IsWeaponCosmetic"] = true,
	["NotCosmetic"] = nil
}
v_u_64.Types.Finisher = {
	["Name"] = "Finisher",
	["Value"] = 3,
	["Image"] = "rbxassetid://77965589200390",
	["IsWeaponCosmetic"] = true,
	["NotCosmetic"] = nil
}
v_u_64.Types.Skin = {
	["Name"] = "Skin",
	["Value"] = 4,
	["Image"] = "rbxassetid://133714697763365",
	["IsWeaponCosmetic"] = true,
	["NotCosmetic"] = nil
}
v_u_64.Types.Emote = {
	["Name"] = "Emote",
	["Value"] = 5,
	["Image"] = "rbxassetid://130882808226687",
	["IsWeaponCosmetic"] = nil,
	["NotCosmetic"] = nil
}
local function v_u_90(p74, p75, p76, p77, p78, p79, p80, p81, p82) -- name: add_cosmetic
	-- upvalues: (copy) v_u_64, (copy) v_u_4, (copy) v_u_65
	local v83 = v_u_64.Rarities[p75] ~= nil
	assert(v83)
	local v84 = not v_u_64.RENAMED_COSMETICS[p76]
	assert(v84)
	local v_u_87 = {
		["Rarity"] = nil,
		["Type"] = nil,
		["Image"] = nil,
		["ImageScale"] = nil,
		["Hidden"] = nil,
		["Description"] = nil,
		["DescriptionSpecific"] = nil,
		["GetDescription"] = nil,
		["Rarity"] = p75,
		["Type"] = p74,
		["Image"] = p77 or "",
		["ImageScale"] = p78 or 1,
		["Hidden"] = p79,
		["Description"] = p80,
		["DescriptionSpecific"] = p81,
		["GetDescription"] = function(p85)
			-- upvalues: (copy) v_u_87
			local v86 = p85 and v_u_87.DescriptionSpecific or v_u_87.Description
			if v86 then
				return tostring(v86)
			else
				return nil
			end
		end
	}
	for v88, v89 in pairs(p82 or {}) do
		v_u_87[v88] = v89
	end
	v_u_64.Cosmetics[p76] = v_u_87
	if v_u_4.IS_SERVER then
		if v_u_65[p76] then
			error("[ITEM] Duplicate item name: " .. p76)
			return
		end
		v_u_65[p76] = true
	end
end
local function v100(p91, p92, p93, p94, p95, p96) -- name: add_skin
	-- upvalues: (copy) v_u_6, (copy) v_u_90
	local v97 = v_u_6.ViewModels[p93]
	local v98 = v97 ~= nil
	assert(v98, p93)
	local v99 = {
		["ItemName"] = p92,
		["ImageHighResolution"] = v97.ImageHighResolution
	}
	v_u_90("Skin", p91, p93, v97.Image, 3, p94, p95, p96, v99)
end
v100("Unique", "Assault Rifle", "10B Visits", nil, "Earned by redeeming a code when the game (RIVALS) reached 10,000,000,000 visits")
v100("Common", "Bow", "Compound Bow")
v100("Common", "Slingshot", "Goalpost")
v100("Common", "Slingshot", "Stick")
v100("Common", "Knife", "Chancla")
v100("Common", "Molotov", "Coffee")
v100("Common", "Shorty", "Too Shorty", nil, "Included in the Starter Bundle")
v100("Common", "Shorty", "Not So Shorty")
v100("Common", "Shorty", "Lovely Shorty")
v100("Common", "Flamethrower", "Lamethrower")
v100("Common", "Fists", "Brass Knuckles")
v100("Common", "Smoke Grenade", "Balance")
v100("Common", "Molotov", "Torch")
v100("Common", "Fists", "Pumpkin Claws")
v100("Common", "Sniper", "Eyething Sniper")
v100("Common", "Handgun", "Pumpkin Handgun")
v100("Common", "Burst Rifle", "Spectral Burst")
v100("Common", "Minigun", "Pumpkin Minigun")
v100("Common", "Flashbang", "Skullbang")
v100("Common", "Subspace Tripmine", "Trick or Treat")
v100("Common", "Riot Shield", "Door")
v100("Common", "Spray", "Lovely Spray")
v100("Common", "Shotgun", "Wrapped Shotgun")
v100("Common", "Shorty", "Wrapped Shorty")
v100("Common", "Flare Gun", "Wrapped Flare Gun")
v100("Common", "Minigun", "Wrapped Minigun")
v100("Common", "Freeze Ray", "Wrapped Freeze Ray")
v100("Common", "War Horn", "Mammoth Horn")
v100("Common", "Fists", "Festive Fists")
v100("Common", "Exogun", "Midnight Festive Exogun")
v100("Common", "Riot Shield", "Sled")
v100("Common", "Battle Axe", "Nordic Axe")
v100("Common", "Satchel", "Suspicious Gift")
v100("Common", "Burst Rifle", "Pine Burst")
v100("Common", "Uzi", "Pine Uzi")
v100("Common", "Spray", "Pine Spray")
v100("Common", "Gunblade", "Elf\'s Gunblade")
v100("Common", "Assault Rifle", "Phoenix Rifle")
v100("Common", "Jump Pad", "Trampoline")
v100("Common", "Battle Axe", "Ban Axe")
v100("Common", "Shotgun", "Cactus Shotgun")
v100("Common", "Gunblade", "Crude Gunblade")
v100("Common", "Subspace Tripmine", "DIY Tripmine")
v100("Common", "Grenade", "Dynamite")
v100("Common", "Handgun", "Gumball Handgun")
v100("Common", "Paintball Gun", "Ketchup Gun")
v100("Common", "Flashbang", "Lightbulb")
v100("Common", "War Horn", "Megaphone")
v100("Common", "Spray", "Nail Gun")
v100("Common", "Satchel", "Notebook Satchel")
v100("Common", "Daggers", "Paper Planes")
v100("Common", "RPG", "Pencil Launcher", nil, "Included in the RPG Bundle")
v100("Common", "Satchel", "Bag o\' Money")
v100("Common", "Daggers", "Shurikens")
v100("Common", "Assault Rifle", "Glorious Assault Rifle", nil, "Purchased from the Ranked Shop")
v100("Common", "Battle Axe", "Glorious Battle Axe", nil, "Purchased from the Ranked Shop")
v100("Common", "Bow", "Glorious Bow", nil, "Purchased from the Ranked Shop")
v100("Common", "Burst Rifle", "Glorious Burst Rifle", nil, "Purchased from the Ranked Shop")
v100("Common", "Chainsaw", "Glorious Chainsaw", nil, "Purchased from the Ranked Shop")
v100("Common", "Crossbow", "Glorious Crossbow", nil, "Purchased from the Ranked Shop")
v100("Common", "Daggers", "Glorious Daggers", nil, "Purchased from the Ranked Shop")
v100("Common", "Energy Pistols", "Glorious Energy Pistols", nil, "Purchased from the Ranked Shop")
v100("Common", "Energy Rifle", "Glorious Energy Rifle", nil, "Purchased from the Ranked Shop")
v100("Common", "Exogun", "Glorious Exogun", nil, "Purchased from the Ranked Shop")
v100("Common", "Fists", "Glorious Fists", nil, "Purchased from the Ranked Shop")
v100("Common", "Flamethrower", "Glorious Flamethrower", nil, "Purchased from the Ranked Shop")
v100("Common", "Flare Gun", "Glorious Flare Gun", nil, "Purchased from the Ranked Shop")
v100("Common", "Flashbang", "Glorious Flashbang", nil, "Purchased from the Ranked Shop")
v100("Common", "Freeze Ray", "Glorious Freeze Ray", nil, "Purchased from the Ranked Shop")
v100("Common", "Grenade", "Glorious Grenade", nil, "Purchased from the Ranked Shop")
v100("Common", "Grenade Launcher", "Glorious Grenade Launcher", nil, "Purchased from the Ranked Shop")
v100("Common", "Gunblade", "Glorious Gunblade", nil, "Purchased from the Ranked Shop")
v100("Common", "Handgun", "Glorious Handgun", nil, "Purchased from the Ranked Shop")
v100("Common", "Jump Pad", "Glorious Jump Pad", nil, "Purchased from the Ranked Shop")
v100("Common", "Katana", "Glorious Katana", nil, "Purchased from the Ranked Shop")
v100("Common", "Knife", "Glorious Knife", nil, "Purchased from the Ranked Shop")
v100("Common", "Medkit", "Glorious Medkit", nil, "Purchased from the Ranked Shop")
v100("Common", "Minigun", "Glorious Minigun", nil, "Purchased from the Ranked Shop")
v100("Common", "Molotov", "Glorious Molotov", nil, "Purchased from the Ranked Shop")
v100("Common", "Paintball Gun", "Glorious Paintball Gun", nil, "Purchased from the Ranked Shop")
v100("Common", "RPG", "Glorious RPG", nil, "Purchased from the Ranked Shop")
v100("Common", "Revolver", "Glorious Revolver", nil, "Purchased from the Ranked Shop")
v100("Common", "Riot Shield", "Glorious Riot Shield", nil, "Purchased from the Ranked Shop")
v100("Common", "Satchel", "Glorious Satchel", nil, "Purchased from the Ranked Shop")
v100("Common", "Scythe", "Glorious Scythe", nil, "Purchased from the Ranked Shop")
v100("Common", "Shorty", "Glorious Shorty", nil, "Purchased from the Ranked Shop")
v100("Common", "Shotgun", "Glorious Shotgun", nil, "Purchased from the Ranked Shop")
v100("Common", "Slingshot", "Glorious Slingshot", nil, "Purchased from the Ranked Shop")
v100("Common", "Smoke Grenade", "Glorious Smoke Grenade", nil, "Purchased from the Ranked Shop")
v100("Common", "Sniper", "Glorious Sniper", nil, "Purchased from the Ranked Shop")
v100("Common", "Spray", "Glorious Spray", nil, "Purchased from the Ranked Shop")
v100("Common", "Subspace Tripmine", "Glorious Subspace Tripmine", nil, "Purchased from the Ranked Shop")
v100("Common", "Trowel", "Glorious Trowel", nil, "Purchased from the Ranked Shop")
v100("Common", "Uzi", "Glorious Uzi", nil, "Purchased from the Ranked Shop")
v100("Common", "War Horn", "Glorious War Horn", nil, "Purchased from the Ranked Shop")
v100("Common", "Distortion", "Glorious Distortion", nil, "Purchased from the Ranked Shop")
v100("Common", "Warper", "Glorious Warper", nil, "Purchased from the Ranked Shop")
v100("Common", "Warpstone", "Glorious Warpstone", nil, "Purchased from the Ranked Shop")
v100("Common", "Maul", "Glorious Maul", nil, "Purchased from the Ranked Shop")
v100("Common", "Permafrost", "Glorious Permafrost", nil, "Purchased from the Ranked Shop")
v100("Common", "Grappler", "Glorious Grappler", nil, "Purchased from the Ranked Shop")
v100("Common", "Spear", "Glorious Spear", nil, "Purchased from the Ranked Shop")
v100("Common", "Wildcat", "Glorious Wildcat", nil, "Purchased from the Ranked Shop")
v100("Common", "Holodome", "Glorious Holodome", nil, "Purchased from the Ranked Shop")
v100("Common", "Handgun", "Warp Handgun")
v100("Common", "Jump Pad", "Spider Web")
v100("Common", "Riot Shield", "Tombstone Shield")
v100("Common", "Gunblade", "Boneblade")
v100("Common", "Crossbow", "Crossbone")
v100("Common", "Warpstone", "Warpbone")
v100("Common", "Handgun", "Towerstone Handgun", nil, "Used to be earned by escaping Zombie Tower solo")
v100("Common", "Warpstone", "Cyber Warpstone")
v100("Common", "Distortion", "Cyber Distortion")
v100("Common", "Grenade", "Frozen Grenade")
v100("Common", "Maul", "Ice Maul")
v100("Common", "Permafrost", "Ice Permafrost")
v100("Common", "Permafrost", "Snowman Permafrost")
v100("Common", "Fists", "Spy Gloves")
v100("Common", "Spear", "Giant Pencil")
v100("Common", "Spear", "Studio Light")
v100("Common", "Knife", "Birthday Candle", nil, "Earned from the 2nd RIVALS Birthday Party")
v100("Common", "Riot Shield", "Broken Surfboard")
v100("Common", "Smoke Grenade", "Beach Ball")
v100("Common", "Spear", "Chark Kebab")
v100("Common", "Jump Pad", "Flamingo Floatie")
v100("Common", "Chainsaw", "Sharksaw")
v100("Common", "Knife", "Shark Tooth")
v100("Common", "Maul", "Giant Popsicle")
v100("Common", "Slingshot", "Palmshot")
v100("Common", "Grappler", "Lifeguard Grappler")
v100("Common", "Satchel", "Lifeguard Satchel")
v100("Common", "Gunblade", "Sharkbite")
v100("Common", "Paintball Gun", "Lemonade Gun")
v100("Common", "Katana", "Swordfish")
v100("Common", "Molotov", "Campfire Stick")
v100("Common", "Crossbow", "Campfire Crossbow")
v100("Common", "Sniper", "Campfire Sniper")
v100("Common", "Uzi", "Ducky Uzi")
v100("Common", "Scythe", "Plastic Flamingo")
v100("Common", "Daggers", "Starfish")
v100("Common", "Spear", "Fork")
v100("Common", "Maul", "Excalibur")
v100("Common", "Wildcat", "Towerstone Wildcat", nil, "Used to be earned by escaping Gargoyle Tower solo")
v100("Common", "Fists", "Towerstone Fists", nil, "Used to be earned by escaping Zombie Tower solo")
v100("Common", "Spear", "Gravelight")
v100("Common", "Riot Shield", "Arena Wall")
v100("Rare", "Paintball Gun", "Slime Gun")
v100("Rare", "Chainsaw", "Blobsaw")
v100("Rare", "Trowel", "Plastic Shovel")
v100("Rare", "Exogun", "Wondergun", nil, "Included in the Exogun Bundle")
v100("Rare", "Fists", "Boxing Gloves")
v100("Rare", "Assault Rifle", "AK-47")
v100("Rare", "Medkit", "Briefcase", nil, "Included in the Medkit Bundle")
v100("Rare", "Scythe", "Scythe of Death")
v100("Rare", "Handgun", "Blaster")
v100("Rare", "Uzi", "Water Uzi")
v100("Rare", "Revolver", "Desert Eagle")
v100("Rare", "Flare Gun", "Dynamite Gun")
v100("Rare", "Bow", "Raven Bow")
v100("Rare", "Scythe", "Anchor")
v100("Rare", "Grenade", "Water Balloon")
v100("Rare", "Trowel", "Garden Shovel")
v100("Rare", "Grenade Launcher", "Uranium Launcher")
v100("Rare", "Exogun", "Ray Gun")
v100("Rare", "Subspace Tripmine", "Spring")
v100("Rare", "Freeze Ray", "Bubble Ray")
v100("Rare", "Burst Rifle", "Aqua Burst")
v100("Rare", "Katana", "Lightning Bolt")
v100("Rare", "Scythe", "Bat Scythe")
v100("Rare", "Bow", "Bat Bow")
v100("Rare", "Katana", "Evil Trident")
v100("Rare", "Slingshot", "Boneshot")
v100("Rare", "Exogun", "Exogourd")
v100("Rare", "Trowel", "Pumpkin Carver")
v100("Rare", "Shorty", "Demon Shorty")
v100("Rare", "Shotgun", "Broomstick")
v100("Rare", "Uzi", "Demon Uzi")
v100("Rare", "Paintball Gun", "Brain Gun")
v100("Rare", "Flamethrower", "Jack O\'Thrower")
v100("Rare", "Revolver", "Boneclaw Revolver")
v100("Rare", "Assault Rifle", "Boneclaw Rifle")
v100("Rare", "Energy Rifle", "Hacker Rifle")
v100("Rare", "Energy Pistols", "Hacker Pistols")
v100("Rare", "War Horn", "Trumpet")
v100("Rare", "Satchel", "Advanced Satchel")
v100("Rare", "Daggers", "Aces")
v100("Rare", "Energy Pistols", "Apex Pistols", nil, "Included in the Energy Bundle")
v100("Rare", "Energy Rifle", "Apex Rifle", nil, "Included in the Energy Bundle")
v100("Rare", "Handgun", "Gingerbread Handgun")
v100("Rare", "Sniper", "Gingerbread Sniper")
v100("Rare", "Flashbang", "Shining Star")
v100("Rare", "Smoke Grenade", "Snowglobe")
v100("Rare", "Grenade", "Jingle Grenade")
v100("Rare", "Slingshot", "Reindeer Slingshot")
v100("Rare", "Trowel", "Snow Shovel")
v100("Rare", "Paintball Gun", "Snowball Gun")
v100("Rare", "Daggers", "Cookies")
v100("Rare", "Bow", "Frostbite Bow")
v100("Rare", "Crossbow", "Frostbite Crossbow")
v100("Rare", "Energy Pistols", "New Year Energy Pistols")
v100("Rare", "Energy Rifle", "New Year Energy Rifle")
v100("Rare", "Katana", "New Year Katana")
v100("Rare", "Flamethrower", "Snowblower")
v100("Rare", "Scythe", "Cryo Scythe")
v100("Rare", "Grenade Launcher", "Snowball Launcher")
v100("Rare", "Jump Pad", "Bounce House")
v100("Rare", "Bow", "Dream Bow")
v100("Rare", "Riot Shield", "Energy Shield")
v100("Rare", "Fists", "Fists of Hurt")
v100("Rare", "Grenade Launcher", "Gearnade Launcher")
v100("Rare", "Flamethrower", "Glitterthrower")
v100("Rare", "Freeze Ray", "Gum Ray")
v100("Rare", "Crossbow", "Harpoon Crossbow")
v100("Rare", "Smoke Grenade", "Hourglass")
v100("Rare", "Energy Rifle", "Hydro Rifle")
v100("Rare", "Molotov", "Lava Lamp")
v100("Rare", "Trowel", "Paintbrush")
v100("Rare", "Scythe", "Sakura Scythe")
v100("Rare", "RPG", "Squid Launcher")
v100("Rare", "Katana", "Stellar Katana")
v100("Rare", "War Horn", "Air Horn")
v100("Rare", "Riot Shield", "Masterpiece")
v100("Rare", "Battle Axe", "Cerulean Axe")
v100("Rare", "Energy Pistols", "Hydro Pistols")
v100("Rare", "Jump Pad", "Shady Chicken Sandwich")
v100("Rare", "Crossbow", "Violin Crossbow")
v100("Rare", "Distortion", "Electropunk Distortion")
v100("Rare", "Warper", "Electropunk Warper")
v100("Rare", "Warpstone", "Unstable Warpstone")
v100("Rare", "Spray", "Boneclaw Spray")
v100("Rare", "War Horn", "Boneclaw Horn")
v100("Rare", "Daggers", "Bat Daggers")
v100("Rare", "Satchel", "Potion Satchel")
v100("Rare", "Jump Pad", "Jolly Man")
v100("Rare", "Distortion", "Plasma Distortion")
v100("Rare", "Distortion", "Magma Distortion")
v100("Rare", "Distortion", "Sleighstortion")
v100("Rare", "Warper", "Glitter Warper")
v100("Rare", "Warper", "Frost Warper")
v100("Rare", "Warpstone", "Electropunk Warpstone")
v100("Rare", "Maul", "Sleigh Maul")
v100("Rare", "Shorty", "Bubble Shorty")
v100("Rare", "Flamethrower", "Bubblethrower")
v100("Rare", "Distortion", "Bubble Distortion")
v100("Rare", "Warper", "Bubbler")
v100("Rare", "Assault Rifle", "Pearl Rifle")
v100("Rare", "Exogun", "Pearl Exogun")
v100("Rare", "Battle Axe", "Tiki Axe")
v100("Rare", "Handgun", "Sandgun")
v100("Rare", "Minigun", "Shark Minigun")
v100("Rare", "Trowel", "Scooper")
v100("Rare", "Energy Pistols", "Sol Pistols")
v100("Rare", "Energy Rifle", "Sol Rifle")
v100("Rare", "Warpstone", "Warp Juice")
v100("Rare", "Permafrost", "Permasand")
v100("Rare", "Bow", "Palm Bow")
v100("Rare", "RPG", "Sundae Launcher")
v100("Rare", "Grenade Launcher", "Coconut Launcher")
v100("Rare", "Spear", "Plunger")
v100("Rare", "Spear", "Thunderpike")
v100("Rare", "Maul", "Starforge Maul")
v100("Rare", "Maul", "Clown Hammer")
v100("Rare", "Permafrost", "Permafrost.rbxm")
v100("Rare", "Permafrost", "Starforge Permafrost")
v100("Rare", "Wildcat", "Plasma Wildcat")
v100("Rare", "Permafrost", "Xenofrost")
v100("Rare", "Wildcat", "Mimic Wildcat")
v100("Rare", "Burst Rifle", "Shady Chicken Burst")
v100("Rare", "Grenade Launcher", "Mineralite Launcher")
v100("Legendary", "Katana", "Saber")
v100("Legendary", "RPG", "Nuke Launcher")
v100("Legendary", "Grenade", "Whoopee Cushion")
v100("Legendary", "Flashbang", "Disco Ball")
v100("Legendary", "Exogun", "Singularity")
v100("Legendary", "Sniper", "Pixel Sniper")
v100("Legendary", "Subspace Tripmine", "Don\'t Press")
v100("Legendary", "Minigun", "Lasergun 3000")
v100("Legendary", "Flare Gun", "Firework Gun")
v100("Legendary", "Flamethrower", "Pixel Flamethrower")
v100("Legendary", "Grenade Launcher", "Swashbuckler")
v100("Legendary", "Burst Rifle", "Electro Rifle")
v100("Legendary", "Shotgun", "Balloon Shotgun")
v100("Legendary", "Smoke Grenade", "Emoji Cloud")
v100("Legendary", "Medkit", "Sandwich")
v100("Legendary", "Freeze Ray", "Temporal Ray")
v100("Legendary", "Uzi", "Electro Uzi")
v100("Legendary", "Handgun", "Hand Gun")
v100("Legendary", "Revolver", "Sheriff")
v100("Legendary", "Knife", "Karambit")
v100("Legendary", "RPG", "Spaceship Launcher")
v100("Legendary", "Chainsaw", "Handsaws")
v100("Legendary", "Flashbang", "Camera")
v100("Legendary", "Paintball Gun", "Boba Gun")
v100("Legendary", "Sniper", "Hyper Sniper")
v100("Legendary", "Shotgun", "Hyper Shotgun")
v100("Legendary", "Medkit", "Laptop")
v100("Legendary", "Minigun", "Pixel Minigun")
v100("Legendary", "Assault Rifle", "Augmented Rifle")
v100("Legendary", "Burst Rifle", "Pixel Burst")
v100("Legendary", "Handgun", "Pixel Handgun")
v100("Legendary", "Katana", "Pixel Katana")
v100("Legendary", "Flashbang", "Pixel Flashbang")
v100("Legendary", "Smoke Grenade", "Eyeball")
v100("Legendary", "Freeze Ray", "Spider Ray")
v100("Legendary", "Medkit", "Bucket of Candy")
v100("Legendary", "RPG", "Pumpkin Launcher")
v100("Legendary", "Flare Gun", "Vexed Flare Gun")
v100("Legendary", "Molotov", "Vexed Candle")
v100("Legendary", "Grenade", "Soul Grenade")
v100("Legendary", "Grenade Launcher", "Skull Launcher")
v100("Legendary", "Chainsaw", "Buzzsaw")
v100("Legendary", "Crossbow", "Pixel Crossbow")
v100("Legendary", "Gunblade", "Hyper Gunblade")
v100("Legendary", "Battle Axe", "The Shred")
v100("Legendary", "Assault Rifle", "Gingerbread Augmented Rifle")
v100("Legendary", "Revolver", "Peppermint Sheriff")
v100("Legendary", "RPG", "Firework Launcher")
v100("Legendary", "Chainsaw", "Festive Buzzsaw")
v100("Legendary", "Medkit", "Milk & Cookies")
v100("Legendary", "Molotov", "Hot Coals")
v100("Legendary", "Subspace Tripmine", "Dev-in-the-Box")
v100("Legendary", "Knife", "Candy Cane")
v100("Legendary", "Shorty", "Balloon Shorty")
v100("Legendary", "Energy Pistols", "Void Pistols")
v100("Legendary", "Uzi", "Money Gun")
v100("Legendary", "Medkit", "Medkitty")
v100("Legendary", "Knife", "Balisong")
v100("Legendary", "Sniper", "Event Horizon")
v100("Legendary", "Flare Gun", "Banana Flare")
v100("Legendary", "Minigun", "Fighter Jet")
v100("Legendary", "Slingshot", "Harp")
v100("Legendary", "Exogun", "Repulsor")
v100("Legendary", "Assault Rifle", "Drum Gun")
v100("Legendary", "Burst Rifle", "Bullpup Burst")
v100("Legendary", "Revolver", "Peppergun")
v100("Legendary", "Chainsaw", "Mega Drill")
v100("Legendary", "Spray", "Spray Bottle")
v100("Legendary", "Energy Rifle", "Void Rifle")
v100("Legendary", "Gunblade", "Gunsaw")
v100("Legendary", "Energy Pistols", "Soul Pistols")
v100("Legendary", "Energy Rifle", "Soul Rifle")
v100("Legendary", "Battle Axe", "Mimic Axe")
v100("Legendary", "Warper", "Experiment W4")
v100("Legendary", "Distortion", "Experiment D15")
v100("Legendary", "Warper", "Hotel Bell")
v100("Legendary", "Warpstone", "Teleport Disc")
v100("Legendary", "Warper", "Arcane Warper")
v100("Legendary", "Warpstone", "Warpstar")
v100("Legendary", "Maul", "Ban Hammer")
v100("Legendary", "RPG", "Rocket Launcher")
v100("Legendary", "Energy Pistols", "Hyperlaser Guns")
v100("Legendary", "Katana", "Linked Sword")
v100("Legendary", "Grenade Launcher", "Balloon Launcher")
v100("Legendary", "Paintball Gun", "Paintballoon Gun")
v100("Legendary", "Bow", "Balloon Bow")
v100("Legendary", "Battle Axe", "Balloon Axe")
v100("Legendary", "Bow", "Beloved Bow")
v100("Legendary", "Daggers", "Broken Hearts")
v100("Legendary", "Grenade", "Cuddle Bomb")
v100("Legendary", "Medkit", "Box of Chocolates")
v100("Legendary", "Fists", "Fist")
v100("Legendary", "Flamethrower", "Rainbowthrower")
v100("Legendary", "Slingshot", "Lucky Horseshoe")
v100("Legendary", "Knife", "Caladbolg")
v100("Legendary", "Subspace Tripmine", "Pot o\' Keys")
v100("Legendary", "Flamethrower", "Extinguisher")
v100("Legendary", "Daggers", "Toaster")
v100("Legendary", "Battle Axe", "Street Sign")
v100("Legendary", "Satchel", "Pizza Box")
v100("Legendary", "Knife", "Pencil")
v100("Legendary", "Grappler", "Lasso")
v100("Legendary", "Scythe", "Palm Scythe", nil, "Used to be purchased from the Shop")
v100("Legendary", "RPG", "Cupcake Launcher", nil, "Used to be purchased from the Shop during the 2nd RIVALS Birthday Party")
v100("Legendary", "Fists", "Pirate Hook")
v100("Legendary", "Katana", "Cutlass")
v100("Legendary", "Shorty", "Cannon Shorty")
v100("Legendary", "Sniper", "Kraken Sniper")
v100("Legendary", "Molotov", "Ship In A Bottle")
v100("Legendary", "Medkit", "Ice Cream")
v100("Legendary", "Fists", "Crab Claws")
v100("Legendary", "Shotgun", "Shark Shotgun")
v100("Legendary", "Freeze Ray", "Cooler")
v100("Legendary", "Flare Gun", "Pocket Volcano")
v100("Legendary", "Revolver", "Cruise Revolver")
v100("Legendary", "Spray", "Campfire Spray")
v100("Legendary", "War Horn", "Lifeguard Whistle")
v100("Legendary", "Burst Rifle", "Sand Bullpup Burst")
v100("Legendary", "Subspace Tripmine", "Hazard Sign")
v100("Legendary", "Flashbang", "Sol")
v100("Legendary", "Grenade", "Fizz Bomb")
v100("Legendary", "Permafrost", "Temporal Permafrost")
v100("Legendary", "Grappler", "Arcade Claw")
v100("Legendary", "Grappler", "Genie Lamp")
v100("Legendary", "Grappler", "Fishing Rod")
v100("Legendary", "Sniper", "Light Fifty")
v100("Legendary", "Knife", "Machete")
v100("Legendary", "Knife", "Karambat")
v100("Legendary", "Grenade", "Batnade")
v100("Legendary", "Slingshot", "Slingshotula")
v100("Legendary", "Gunblade", "Batblade")
v100("Legendary", "Daggers", "Cursed Daggers", nil, "Used to be purchased from the Shop")
v100("Legendary", "Maul", "Jeremiah")
v100("Legendary", "Grappler", "Web Shooters")
v100("Legendary", "Crossbow", "Spider Crossbow")
v100("Legendary", "Exogun", "Redman Exogun")
v100("Legendary", "Assault Rifle", "Gothic Rifle")
v100("Legendary", "Exogun", "Gothic Exogun")
v100("Legendary", "Knife", "Gothic Knife")
v100("Legendary", "War Horn", "Gothic Horn")
v100("Legendary", "Scythe", "Gothic Pickaxe")
v100("Legendary", "RPG", "DIY RPKEY")
v100("Mythical", "RPG", "RPKEY", nil, "Used to be included in the Legendary Key Bundle")
v100("Mythical", "Scythe", "Keythe", nil, "Used to be included in the Legendary Key Bundle")
v100("Mythical", "Sniper", "Keyper", nil, "Used to be included in the Legendary Key Bundle")
v100("Mythical", "Assault Rifle", "AKEY-47", nil, "Used to be included in the Legendary Key Bundle")
v100("Mythical", "Daggers", "Crystal Daggers", nil, "Used to be included in the Legendary Crystal Bundle")
v100("Mythical", "Katana", "Keytana", nil, "Used to be included in the Legendary Key Bundle")
v100("Mythical", "Revolver", "Keyvolver", nil, "Used to be included in the Ultra Key Bundle")
v100("Mythical", "Shotgun", "Shotkey", nil, "Used to be included in the Legendary Key Bundle")
v100("Mythical", "Uzi", "Keyzi", nil, "Used to be included in the Ultra Key Bundle")
v100("Mythical", "Bow", "Key Bow", nil, "Used to be included in the Legendary Key Bundle")
v100("Mythical", "Grenade", "Keynade", nil, "Used to be included in the Ultra Key Bundle")
v100("Mythical", "Burst Rifle", "Keyst Rifle", nil, "Used to be included in the Legendary Key Bundle")
v100("Mythical", "Battle Axe", "Keyttle Axe", nil, "Used to be included in the Ultra Key Bundle")
v100("Mythical", "Warpstone", "Warpeye", nil, "Used to be included in the Legendary Candy Bundle")
v100("Mythical", "Knife", "Keyrambit", nil, "Used to be included in the Legendary Key Bundle")
v100("Mythical", "Knife", "Keylisong", nil, "Used to be included in the Legendary Key Bundle")
v100("Mythical", "Daggers", "Keynais", nil, "Used to be included in the Ultra Key Bundle")
v100("Mythical", "Katana", "Crystal Katana", nil, "Used to be included in the Legendary Crystal Bundle")
v100("Mythical", "Spray", "Key Spray", nil, "Used to be included in the Ultra Key Bundle")
v100("Mythical", "Flamethrower", "Keythrower", nil, "Used to be included in the Legendary Key Bundle")
v100("Mythical", "Slingshot", "Keyshot", nil, "Used to be included in the Ultra Key Bundle")
v100("Mythical", "Gunblade", "Keyblade", nil, "Used to be included in the Legendary Key Bundle")
v100("Mythical", "Scythe", "Crystal Scythe", nil, "Used to be included in the 2025 Festive Flash Sale")
v100("Mythical", "Katana", "Riptide Katana", nil, "Used to be included in the Legendary Pearl Bundle")
v100("Mythical", "Katana", "Arch Katana")
v100("Mythical", "Crossbow", "Arch Crossbow")
v100("Mythical", "Molotov", "Arch Molotov")
v100("Mythical", "Uzi", "Arch Uzi")
v100("Mythical", "Energy Rifle", "Arch Energy Rifle", true)
v100("Mythical", "Energy Pistols", "Enerkey Pistols", nil, "Included in the Legendary Key Bundle")
v100("Mythical", "Energy Rifle", "Enerkey Rifle", nil, "Included in the Ultra Key Bundle")
v100("Mythical", "Wildcat", "Shadow Wildcat", nil, "Used to be included in the Legendary Candy Bundle")
v100("Genuine", "Scythe", "Bug Net", true, "Given to the best bug hunters, thank you for helping us improve the game (RIVALS)")
v100("Genuine", "Knife", "Trophy Knife", true, "Given to winners of tournaments that are officially hosted, sponsored, endorsed, or recognized by the group (Nosniy Games)")
v100("Genuine", "Knife", "Armature.001", true, "if this is leaked neko will be waterboarded and hit by a car 628 times")
v100("Unobtainable", "MISSING_WEAPON", "MISSING_SKIN", true, "-- TODO: placeholder")
v100("Unobtainable", "Handgun", "Stealth Handgun", true, "sneaky beaky like")
local function v122(p101, p102, p103, p104, p105, p106, p107, p108) -- name: add_wrap
	-- upvalues: (copy) v_u_2, (copy) v_u_90
	local v109 = {
		["WrapGroups"] = {}
	}
	for _, v110 in pairs({ p103, p104, p105 }) do
		local v111, v112, v113, v114, v115, v116 = table.unpack(v110)
		local v117 = typeof(v111) == "string"
		local v118
		if v117 then
			v118 = v_u_2.Wraps:WaitForChild(v111)
		else
			v118 = v117
		end
		local v119 = {}
		local v120 = v118 and v118.BaseMaterial
		if not v120 then
			if v117 or not v111 then
				v120 = nil
			else
				v120 = v111
			end
		end
		v119.Material = v120
		v119.MaterialVariant = v117 and v111 and v111 or ""
		v119.Color = v112 or nil
		v119.Transparency = v113 or nil
		v119.Reflectance = v114 or nil
		v119.Textures = v115 or nil
		v119.ObjectName = v116
		local v121 = v109.WrapGroups
		table.insert(v121, v119)
	end
	v_u_90("Wrap", p101, p102, nil, nil, p106, p107, p108, v109)
end
v122("Unique", "Community", {
	Enum.Material.Glass,
	Color3.fromRGB(124, 17, 255),
	0,
	0.1,
	nil
}, {
	Enum.Material.Glass,
	Color3.fromRGB(255, 213, 0),
	0,
	0.1,
	nil
}, {
	nil,
	Color3.fromRGB(112, 181, 255),
	nil,
	nil,
	nil
}, nil, "Earned by redeeming codes")
v122("Unique", "1B Visits", {
	Enum.Material.Glass,
	Color3.fromRGB(48, 38, 0),
	0,
	0.4,
	"1BVisits"
}, {
	Enum.Material.Glass,
	Color3.fromRGB(127, 100, 0),
	0,
	0.4,
	"1BVisits"
}, {
	Enum.Material.Neon,
	Color3.fromRGB(173, 155, 123),
	0,
	0,
	nil
}, nil, "Earned by redeeming a code when the game (RIVALS) reached 1,000,000,000 visits")
v122("Unique", "Cream", {
	nil,
	Color3.fromRGB(255, 209, 157),
	0,
	0,
	nil
}, {
	nil,
	Color3.fromRGB(62, 55, 48),
	0,
	0,
	nil
}, nil, nil, "Earned by inviting friends to the game (RIVALS)")
v122("Unique", "Danger", {
	Enum.Material.Neon,
	Color3.fromRGB(168, 0, 0),
	0,
	0,
	"Danger1"
}, {
	Enum.Material.Neon,
	Color3.fromRGB(17, 17, 17),
	0,
	0,
	"Danger2"
}, {
	Enum.Material.Neon,
	Color3.fromRGB(161, 47, 47),
	0,
	0,
	nil
}, nil, "Earned by completing a special challenge during the Roblox 2024 Winter Spotlight")
v122("Unique", "Glacier", {
	"Glacier",
	Color3.fromRGB(175, 221, 255),
	0,
	0,
	nil
}, {
	"Glacier",
	Color3.fromRGB(231, 231, 236),
	0,
	0,
	nil
}, {
	Enum.Material.Neon,
	Color3.fromRGB(130, 157, 166),
	0,
	0,
	nil
}, nil, "Earned from the 2024 Festive Event Advent Calendar")
v122("Unique", "Pine", {
	Enum.Material.SmoothPlastic,
	Color3.fromRGB(58, 115, 55),
	0,
	0,
	"Pine"
}, {
	"Pine",
	Color3.fromRGB(72, 51, 40),
	0,
	0,
	nil
}, {
	Enum.Material.Neon,
	Color3.fromRGB(158, 162, 121),
	0,
	0,
	nil
}, nil, "Earned from the 2024 Festive Event Advent Calendar")
v122("Unique", "Glamour", {
	Enum.Material.SmoothPlastic,
	Color3.fromRGB(86, 36, 36),
	0,
	0,
	"Glamour"
}, {
	Enum.Material.SmoothPlastic,
	Color3.fromRGB(117, 0, 0),
	0,
	0.1,
	nil
}, {
	Enum.Material.Neon,
	Color3.fromRGB(170, 128, 99),
	0,
	0,
	nil
}, nil, "Earned by watching a quick video ad in the Shop")
v122("Unique", "Brimstone", {
	Enum.Material.Glass,
	Color3.fromRGB(17, 17, 17),
	0,
	0,
	"Brimstone_1"
}, {
	Enum.Material.Glass,
	Color3.fromRGB(196, 40, 48),
	0,
	0,
	"Brimstone_2"
}, {
	Enum.Material.Neon,
	Color3.fromRGB(163, 61, 74),
	0,
	0,
	nil
}, nil, "Earned by watching a quick video ad in the Hub")
v122("Unique", "Sensite", {
	"Developore",
	Color3.fromRGB(255, 180, 30),
	0,
	0,
	nil
}, {
	"Developore",
	Color3.fromRGB(0, 0, 0),
	0,
	0,
	nil
}, {
	nil,
	Color3.fromRGB(255, 172, 99),
	nil,
	nil,
	nil
})
v122("Unique", "Nosnite", {
	"Developore",
	Color3.fromRGB(180, 128, 255),
	0,
	0,
	nil
}, {
	"Developore",
	Color3.fromRGB(0, 0, 0),
	0,
	0,
	nil
}, {
	nil,
	Color3.fromRGB(136, 114, 202),
	nil,
	nil,
	nil
})
v122("Unique", "Nekore", {
	"Developore",
	Color3.fromRGB(6, 100, 150),
	0,
	0,
	nil
}, {
	"Developore",
	Color3.fromRGB(0, 0, 0),
	0,
	0,
	nil
}, {
	nil,
	Color3.fromRGB(102, 144, 236),
	nil,
	nil,
	nil
})
v122("Unique", "Shadore", {
	"Developore",
	Color3.fromRGB(203, 51, 51),
	0,
	0,
	nil
}, {
	"Developore",
	Color3.fromRGB(0, 0, 0),
	0,
	0,
	nil
}, {
	nil,
	Color3.fromRGB(248, 108, 108),
	nil,
	nil,
	nil
})
v122("Unique", "Brianore", {
	"Developore",
	Color3.fromRGB(101, 255, 93),
	0,
	0,
	nil
}, {
	"Developore",
	Color3.fromRGB(0, 0, 0),
	0,
	0,
	nil
}, {
	nil,
	Color3.fromRGB(157, 248, 163),
	nil,
	nil,
	nil
})
v122("Unique", "Boomore", {
	"Developore",
	Color3.fromRGB(255, 255, 255),
	0,
	0,
	nil
}, {
	"Developore",
	Color3.fromRGB(0, 0, 0),
	0,
	0,
	nil
}, {
	nil,
	Color3.fromRGB(175, 175, 175),
	nil,
	nil,
	nil
})
v122("Unique", "Beggar", {
	Enum.Material.Pebble,
	Color3.fromRGB(255, 176, 0),
	0.05,
	0,
	"dude"
}, {
	Enum.Material.CorrodedMetal,
	Color3.fromRGB(255, 176, 0),
	0.1,
	0,
	"bruh"
}, {
	Enum.Material.Neon,
	Color3.fromRGB(9, 137, 207),
	0,
	1000,
	"epic"
}, nil, "Beggars can\'t be choosers")
v122("Unique", "Snowy Night", {
	Enum.Material.Neon,
	Color3.fromRGB(46, 52, 54),
	0,
	0,
	"Snowflakes_1"
}, {
	Enum.Material.Neon,
	Color3.fromRGB(150, 169, 176),
	0,
	0,
	"Snowflakes_2"
}, {
	Enum.Material.Glass,
	Color3.fromRGB(202, 246, 255),
	0.25,
	0.3,
	nil
}, nil, "Earned from the 2025 Festive Event Advent Calendar")
v122("Common", "Red", {
	nil,
	Color3.fromRGB(255, 50, 50),
	0,
	0,
	nil
})
v122("Common", "Orange", {
	nil,
	Color3.fromRGB(255, 110, 0),
	0,
	0,
	nil
})
v122("Common", "Yellow", {
	nil,
	Color3.fromRGB(255, 215, 0),
	0,
	0,
	nil
})
v122("Common", "Green", {
	nil,
	Color3.fromRGB(100, 255, 50),
	0,
	0,
	nil
})
v122("Common", "Blue", {
	nil,
	Color3.fromRGB(0, 150, 255),
	0,
	0,
	nil
})
v122("Common", "Purple", {
	nil,
	Color3.fromRGB(136, 0, 255),
	0,
	0,
	nil
})
v122("Common", "Pink", {
	nil,
	Color3.fromRGB(255, 60, 236),
	0,
	0,
	nil
})
v122("Common", "Salmon", {
	nil,
	Color3.fromRGB(255, 107, 107),
	0,
	0,
	nil
})
v122("Common", "Brown", {
	nil,
	Color3.fromRGB(91, 54, 35),
	0,
	0,
	nil
})
v122("Common", "Lemon", {
	nil,
	Color3.fromRGB(255, 230, 105),
	0,
	0,
	nil
})
v122("Common", "Mint", {
	nil,
	Color3.fromRGB(167, 255, 135),
	0,
	0,
	nil
})
v122("Common", "Sky", {
	nil,
	Color3.fromRGB(135, 207, 255),
	0,
	0,
	nil
})
v122("Common", "Olive", {
	nil,
	Color3.fromRGB(75, 79, 55),
	0,
	0,
	nil
})
v122("Common", "Blush", {
	nil,
	Color3.fromRGB(255, 164, 255),
	0,
	0,
	nil
})
v122("Common", "Maroon", {
	nil,
	Color3.fromRGB(117, 33, 69),
	0,
	0,
	nil
})
v122("Common", "Beige", {
	nil,
	Color3.fromRGB(184, 156, 110),
	0,
	0,
	nil
})
v122("Common", "Navy", {
	nil,
	Color3.fromRGB(0, 18, 76),
	0,
	0,
	nil
})
v122("Common", "Teal", {
	nil,
	Color3.fromRGB(0, 255, 225),
	0,
	0,
	nil
})
v122("Common", "Highlighter", {
	nil,
	Color3.fromRGB(192, 255, 57),
	0,
	0,
	nil
})
v122("Common", "Crimson", {
	nil,
	Color3.fromRGB(75, 14, 14),
	0,
	0,
	nil
})
v122("Common", "Cool", {
	nil,
	Color3.fromRGB(97, 200, 255),
	0,
	0,
	nil
})
v122("Common", "Gunmetal", {
	Enum.Material.SmoothPlastic,
	Color3.fromRGB(40, 40, 40),
	0,
	0.05,
	nil
}, {
	Enum.Material.SmoothPlastic,
	Color3.fromRGB(255, 255, 255),
	0,
	1,
	"Gunmetal"
}, {
	Enum.Material.Neon,
	Color3.fromRGB(182, 116, 99),
	0,
	0,
	nil
})
v122("Common", "Venom", {
	Enum.Material.Neon,
	Color3.fromRGB(136, 0, 255),
	0,
	0,
	"Venom"
}, {
	Enum.Material.Metal,
	Color3.fromRGB(0, 0, 0),
	0,
	0,
	nil
}, {
	Enum.Material.Neon,
	Color3.fromRGB(102, 0, 191),
	0.15,
	0,
	nil
})
v122("Common", "MaGGenta", {
	Enum.Material.SmoothPlastic,
	Color3.fromRGB(206, 206, 206),
	0,
	0,
	nil
}, {
	Enum.Material.SmoothPlastic,
	Color3.fromRGB(115, 40, 255),
	0,
	0,
	nil
})
v122("Common", "Bluesteel", {
	"Bluesteel",
	Color3.fromRGB(38, 96, 150),
	0,
	0,
	nil
}, {
	Enum.Material.Metal,
	Color3.fromRGB(159, 161, 172),
	0,
	0,
	nil
}, {
	Enum.Material.Neon,
	Color3.fromRGB(37, 73, 173),
	0,
	0,
	nil
})
v122("Common", "Cheese", {
	"Cheese",
	Color3.fromRGB(255, 221, 48),
	0,
	0,
	nil
}, {
	"Cheesecloth",
	Color3.fromRGB(248, 221, 194),
	0,
	0,
	nil
}, {
	Enum.Material.Neon,
	Color3.fromRGB(172, 118, 0),
	0,
	0,
	nil
})
v122("Common", "Stained", {
	"Stained",
	Color3.fromRGB(82, 126, 175),
	0,
	0,
	nil
}, {
	"Stained",
	Color3.fromRGB(120, 183, 255),
	0,
	0,
	nil
})
v122("Common", "Lumber", {
	"Lumber1",
	Color3.fromRGB(124, 92, 70),
	0,
	0,
	nil
}, {
	"Lumber2",
	Color3.fromRGB(105, 64, 40),
	0,
	0,
	nil
}, {
	Enum.Material.Neon,
	Color3.fromRGB(198, 135, 114),
	0,
	0,
	nil
})
v122("Common", "Ornate", {
	Enum.Material.SmoothPlastic,
	Color3.fromRGB(27, 42, 53),
	0,
	0,
	nil
}, {
	Enum.Material.Metal,
	Color3.fromRGB(226, 155, 64),
	0,
	0,
	nil
}, {
	Enum.Material.Neon,
	Color3.fromRGB(255, 53, 53),
	0,
	0,
	nil
})
v122("Common", "Mustard", {
	nil,
	Color3.fromRGB(136, 102, 0),
	0,
	0,
	nil
})
v122("Common", "Violet", {
	nil,
	Color3.fromRGB(85, 43, 255),
	0,
	0,
	nil
})
v122("Common", "Jean", {
	nil,
	Color3.fromRGB(0, 76, 255),
	0,
	0,
	nil
})
v122("Common", "Copper", {
	Enum.Material.Glass,
	Color3.fromRGB(213, 115, 61),
	0,
	0.3,
	nil
}, {
	Enum.Material.Glass,
	Color3.fromRGB(170, 85, 0),
	0,
	0.3,
	nil
}, {
	Enum.Material.Neon,
	Color3.fromRGB(186, 143, 135),
	0,
	0,
	nil
})
v122("Common", "Machine", {
	"BrushedMetal",
	Color3.fromRGB(202, 203, 209),
	0,
	0,
	nil
}, {
	"BrushedMetal",
	Color3.fromRGB(202, 203, 209),
	0,
	0,
	nil
}, {
	"BrushedMetal",
	Color3.fromRGB(202, 203, 209),
	0,
	0,
	nil
})
v122("Common", "Titanium", {
	Enum.Material.Glass,
	Color3.fromRGB(205, 205, 205),
	0,
	0.3,
	nil
}, {
	Enum.Material.Glass,
	Color3.fromRGB(248, 248, 248),
	0,
	0.3,
	nil
}, {
	Enum.Material.Neon,
	Color3.fromRGB(171, 171, 171),
	0,
	0,
	nil
})
v122("Common", "Tungsten", {
	Enum.Material.Glass,
	Color3.fromRGB(66, 67, 76),
	0,
	0.3,
	nil
}, {
	Enum.Material.Glass,
	Color3.fromRGB(91, 93, 105),
	0,
	0.3,
	nil
}, {
	Enum.Material.Neon,
	Color3.fromRGB(133, 141, 192),
	0,
	0,
	nil
})
v122("Common", "Haunted", {
	Enum.Material.Glass,
	Color3.fromRGB(0, 0, 0),
	0,
	0.4,
	nil
}, {
	Enum.Material.SmoothPlastic,
	Color3.fromRGB(0, 255, 238),
	0.5,
	0.2,
	nil
}, {
	Enum.Material.Neon,
	Color3.fromRGB(110, 253, 255),
	0,
	0,
	nil
})
v122("Common", "Vexed", {
	Enum.Material.Glass,
	Color3.fromRGB(0, 0, 0),
	0,
	0.4,
	nil
}, {
	Enum.Material.SmoothPlastic,
	Color3.fromRGB(105, 46, 255),
	0.5,
	0.2,
	nil
}, {
	Enum.Material.Neon,
	Color3.fromRGB(153, 133, 255),
	0,
	0,
	nil
})
v122("Common", "Cursed", {
	Enum.Material.Glass,
	Color3.fromRGB(0, 0, 0),
	0,
	0.4,
	nil
}, {
	Enum.Material.SmoothPlastic,
	Color3.fromRGB(255, 0, 0),
	0.5,
	0.2,
	nil
}, {
	Enum.Material.Neon,
	Color3.fromRGB(255, 142, 142),
	0,
	0,
	nil
})
v122("Common", "Frigid", {
	nil,
	nil,
	nil,
	nil,
	"Frigid"
}, {
	nil,
	nil,
	nil,
	nil,
	"Frigid"
})
v122("Common", "Midnight", {
	"PBRSimpleMetallic",
	Color3.fromRGB(7, 25, 67),
	0,
	0,
	nil
}, {
	"PBRSimpleMetallic",
	Color3.fromRGB(77, 77, 77),
	0,
	0,
	nil
}, {
	Enum.Material.Neon,
	Color3.fromRGB(82, 122, 255),
	0,
	0,
	nil
})
v122("Common", "Slush", {
	Enum.Material.Neon,
	Color3.fromRGB(136, 168, 161),
	0,
	0,
	"Slush1"
}, {
	Enum.Material.Neon,
	Color3.fromRGB(128, 145, 158),
	0,
	0,
	"Slush2"
}, {
	Enum.Material.Neon,
	Color3.fromRGB(100, 155, 163),
	0,
	0,
	nil
})
v122("Common", "Lavish Crystal", {
	"LavishCrystal",
	Color3.fromRGB(183, 149, 255),
	0,
	0,
	nil
}, {
	"LavishCrystal",
	Color3.fromRGB(219, 196, 236),
	0,
	0,
	nil
}, {
	Enum.Material.Neon,
	Color3.fromRGB(142, 128, 166),
	0,
	0,
	nil
})
v122("Common", "Noir", {
	Enum.Material.Neon,
	Color3.fromRGB(165, 165, 165),
	0,
	0,
	"Noir1"
}, {
	Enum.Material.Neon,
	Color3.fromRGB(17, 17, 17),
	0,
	0,
	"Noir2"
}, {
	Enum.Material.Neon,
	Color3.fromRGB(157, 157, 157),
	0,
	0,
	nil
})
v122("Common", "Normal", {
	Enum.Material.Neon,
	Color3.fromRGB(138, 0, 148),
	0,
	0,
	"Normal1"
}, {
	Enum.Material.Neon,
	Color3.fromRGB(0, 32, 96),
	0,
	0,
	"Normal2"
}, {
	Enum.Material.Neon,
	Color3.fromRGB(158, 58, 58),
	0,
	0,
	nil
})
v122("Common", "Rust", {
	Enum.Material.CorrodedMetal,
	nil,
	0,
	0,
	nil
}, {
	Enum.Material.CorrodedMetal,
	nil,
	0,
	0,
	nil
}, {
	Enum.Material.Neon,
	Color3.fromRGB(159, 159, 159),
	0,
	0.1,
	nil
})
v122("Common", "Tawny", {
	Enum.Material.Neon,
	Color3.fromRGB(255, 233, 111),
	0,
	0,
	"Tawny1"
}, {
	Enum.Material.Neon,
	Color3.fromRGB(68, 44, 7),
	0,
	0,
	"Tawny2"
}, {
	Enum.Material.Neon,
	Color3.fromRGB(167, 118, 78),
	0,
	0,
	nil
})
v122("Common", "Olo", {
	nil,
	Color3.fromRGB(0, 254, 202),
	0,
	0,
	nil
})
v122("Common", "Glorious", { "CandyGlossy" }, { "CandyGlossy" }, nil, nil, "Purchased from the Ranked Shop")
v122("Common", "Spiral", {
	"Spiral1",
	Color3.fromRGB(180, 128, 255),
	0,
	0.3,
	"Spiral1"
}, {
	"Spiral2",
	Color3.fromRGB(17, 17, 17),
	0,
	0,
	nil
}, {
	Enum.Material.Neon,
	Color3.fromRGB(110, 79, 177),
	0,
	0,
	"Spiral3"
})
v122("Common", "Pink Lemonade", {
	nil,
	Color3.fromRGB(255, 96, 152),
	0,
	0,
	nil
}, {
	Enum.Material.SmoothPlastic,
	Color3.fromRGB(255, 212, 57),
	0,
	0,
	nil
}, {
	Enum.Material.SmoothPlastic,
	Color3.fromRGB(255, 212, 57),
	0,
	0,
	nil
})
v122("Common", "Playful", {
	nil,
	Color3.fromRGB(20, 67, 176),
	0,
	0,
	nil
}, {
	Enum.Material.SmoothPlastic,
	Color3.fromRGB(234, 121, 23),
	0,
	0,
	nil
}, {
	Enum.Material.SmoothPlastic,
	Color3.fromRGB(234, 121, 23),
	0,
	0,
	nil
})
v122("Common", "Lapis", {
	nil,
	Color3.fromRGB(65, 73, 114),
	0,
	0,
	nil
}, {
	Enum.Material.SmoothPlastic,
	Color3.fromRGB(106, 255, 203),
	0,
	0,
	nil
}, {
	Enum.Material.SmoothPlastic,
	Color3.fromRGB(106, 255, 203),
	0,
	0,
	nil
})
v122("Common", "Zombie", {
	Enum.Material.Sand,
	Color3.fromRGB(101, 158, 89),
	0,
	0,
	"Zombie1"
}, {
	Enum.Material.Plastic,
	Color3.fromRGB(38, 39, 52),
	0,
	0,
	"Zombie2"
}, {
	Enum.Material.SmoothPlastic,
	Color3.fromRGB(212, 214, 196),
	0,
	0,
	nil
}, nil, "Earned by escaping Zombie Tower alive")
v122("Common", "Tusky", {
	"MammothFur",
	Color3.fromRGB(129, 86, 65),
	0,
	0,
	"Tusky_1"
}, {
	"Wooly1",
	Color3.fromRGB(255, 247, 231),
	0,
	0,
	"Tusky_2"
}, {
	Enum.Material.Neon,
	Color3.fromRGB(163, 160, 155),
	0,
	0,
	nil
})
v122("Common", "Sleet", {
	nil,
	Color3.fromRGB(83, 79, 106),
	0,
	0,
	nil
}, {
	Enum.Material.SmoothPlastic,
	Color3.fromRGB(154, 188, 236),
	0,
	0,
	nil
}, {
	Enum.Material.SmoothPlastic,
	Color3.fromRGB(154, 188, 236),
	0,
	0,
	nil
})
v122("Common", "Hot Cocoa", {
	nil,
	Color3.fromRGB(81, 57, 45),
	0,
	0,
	nil
}, {
	Enum.Material.SmoothPlastic,
	Color3.fromRGB(217, 224, 236),
	0,
	0,
	nil
}, {
	Enum.Material.SmoothPlastic,
	Color3.fromRGB(217, 224, 236),
	0,
	0,
	nil
})
v122("Common", "Cartoony Paint", {
	"CartoonPaint",
	Color3.fromRGB(225, 235, 248),
	0,
	0,
	"Cartoony_Paint_1"
}, {
	"CartoonPaint",
	Color3.fromRGB(54, 54, 68),
	0,
	0,
	"Cartoony_Paint_2"
}, {
	Enum.Material.SmoothPlastic,
	Color3.fromRGB(217, 224, 236),
	0,
	0,
	nil
})
v122("Common", "Mesa", {
	"Mesa",
	Color3.fromRGB(108, 71, 49),
	0,
	0,
	"Mesa_1"
}, {
	"CarpetNoise",
	Color3.fromRGB(218, 162, 106),
	0,
	0,
	"Mesa_2"
}, {
	Enum.Material.SmoothPlastic,
	Color3.fromRGB(213, 146, 95),
	0,
	0,
	nil
})
v122("Common", "Red Carpet", {
	"CarpetNoise",
	Color3.fromRGB(147, 24, 40),
	0,
	0,
	"Red_Carpet_1"
}, {
	"CandyGlossy",
	Color3.fromRGB(255, 178, 110),
	0,
	0,
	"Red_Carpet_2"
}, {
	Enum.Material.SmoothPlastic,
	Color3.fromRGB(255, 187, 128),
	0,
	0.1,
	nil
})
v122("Common", "Lemonade", {
	Enum.Material.Glass,
	Color3.fromRGB(248, 217, 109),
	0,
	0,
	"Lemonade_1"
}, {
	Enum.Material.SmoothPlastic,
	Color3.fromRGB(255, 243, 207),
	0,
	0,
	nil
}, {
	nil,
	Color3.fromRGB(253, 234, 141),
	0,
	0,
	nil
})
v122("Common", "Creamsicle", {
	"Popsicle",
	Color3.fromRGB(239, 119, 27),
	0,
	0,
	"Orange_Creamsicle_1"
}, {
	"IceCream",
	Color3.fromRGB(236, 212, 192),
	0,
	0,
	"Orange_Creamsicle_2"
}, {
	nil,
	Color3.fromRGB(255, 144, 70),
	0,
	0,
	nil
})
v122("Common", "Waffle Cone", {
	"WaffleCone",
	Color3.fromRGB(204, 150, 92),
	0,
	0,
	"Waffle_Cone_1"
}, {
	"WaffleConeShiny",
	Color3.fromRGB(89, 53, 44),
	0,
	0,
	"Waffle_Cone_2"
}, {
	Enum.Material.SmoothPlastic,
	Color3.fromRGB(77, 47, 39),
	0,
	0,
	nil
})
v122("Common", "Water Blaster", {
	"ToyPlastic",
	Color3.fromRGB(228, 236, 69),
	0,
	0,
	"Water_Blaster_1"
}, {
	"ToyPlastic",
	Color3.fromRGB(120, 213, 63),
	0,
	0,
	"Water_Blaster_2"
}, {
	"ToyPlastic",
	Color3.fromRGB(236, 82, 43),
	0,
	0,
	"Water_Blaster_3"
})
v122("Common", "Confetti Cake", {
	"Cake",
	Color3.fromRGB(248, 229, 207),
	0,
	0,
	"Birthday_Cake_1"
}, {
	"IceCream",
	Color3.fromRGB(248, 248, 248),
	0,
	0,
	"Birthday_Cake_2"
}, {
	Enum.Material.Neon,
	Color3.fromRGB(175, 139, 114),
	0,
	0,
	nil
}, nil, "Earned from the 2nd RIVALS Birthday Party")
v122("Common", "Toxin", {
	Enum.Material.Neon,
	Color3.fromRGB(26, 165, 26),
	0,
	0,
	"Toxin_1"
}, {
	Enum.Material.Neon,
	Color3.fromRGB(0, 0, 0),
	0,
	0,
	nil
}, {
	Enum.Material.Neon,
	Color3.fromRGB(111, 175, 54),
	0,
	0,
	nil
})
v122("Common", "Conduction", {
	"ConductionPlates",
	Color3.fromRGB(199, 201, 206),
	0,
	0,
	"Conduction_1"
}, {
	"ConductionPlates",
	Color3.fromRGB(139, 145, 156),
	0,
	0,
	"Conduction_2"
}, {
	Enum.Material.Neon,
	Color3.fromRGB(126, 146, 162),
	0,
	0,
	nil
}, nil, "Earned by escaping Gargoyle Tower alive")
v122("Common", "Holochrome", {
	"CandyGlossy",
	Color3.fromRGB(28, 243, 196),
	0,
	0.6,
	nil
}, {
	Enum.Material.SmoothPlastic,
	Color3.fromRGB(199, 255, 253),
	0,
	0.3,
	nil
}, {
	nil,
	Color3.fromRGB(154, 188, 186),
	0,
	0,
	nil
})
v122("Common", "Shady Feathers", {
	"ShadyChickenFeathers",
	Color3.fromRGB(255, 255, 255),
	0,
	0,
	"Shady_Feathers_1"
}, {
	"ShadyChickenFeathers2",
	Color3.fromRGB(255, 255, 255),
	0,
	0,
	"Shady_Feathers_2"
}, {
	Enum.Material.SmoothPlastic,
	Color3.fromRGB(220, 63, 63),
	0,
	0,
	"Shady_Feathers_3"
})
v122("Rare", "Gold", {
	Enum.Material.Glass,
	Color3.fromRGB(255, 170, 24),
	0,
	0.4,
	nil
}, {
	Enum.Material.Glass,
	Color3.fromRGB(255, 170, 24),
	0,
	0.4,
	nil
}, {
	nil,
	Color3.fromRGB(255, 165, 120),
	nil,
	nil,
	nil
}, nil, "Earned from weapon contracts", "Earned from a weapon contract for this weapon")
v122("Rare", "Forest Camo", {
	"Forest Camo",
	Color3.fromRGB(237, 234, 234),
	0,
	0,
	nil
}, {
	Enum.Material.Glass,
	Color3.fromRGB(17, 17, 17),
	0,
	0,
	nil
}, {
	nil,
	Color3.fromRGB(140, 255, 98),
	nil,
	nil,
	nil
})
v122("Rare", "Honeycomb", {
	"Honeycomb",
	Color3.fromRGB(255, 201, 74),
	0,
	0,
	nil
}, {
	Enum.Material.SmoothPlastic,
	Color3.fromRGB(0, 0, 0),
	0,
	0,
	nil
}, {
	Enum.Material.Neon,
	Color3.fromRGB(170, 121, 72),
	0,
	0,
	nil
})
v122("Rare", "Patriot", {
	"Patriot",
	Color3.fromRGB(248, 248, 248),
	0,
	0,
	nil
}, {
	Enum.Material.Glass,
	Color3.fromRGB(17, 17, 17),
	0,
	0,
	nil
}, {
	nil,
	Color3.fromRGB(168, 168, 168),
	nil,
	nil,
	nil
})
v122("Rare", "Clouds", {
	"Clouds",
	Color3.fromRGB(248, 248, 248),
	0,
	0,
	nil
}, {
	Enum.Material.Glass,
	Color3.fromRGB(17, 98, 148),
	0,
	0,
	nil
}, {
	nil,
	Color3.fromRGB(123, 150, 163),
	nil,
	nil,
	nil
})
v122("Rare", "Swirls", {
	"Swirls",
	Color3.fromRGB(248, 248, 248),
	0,
	0,
	nil
}, {
	Enum.Material.Glass,
	Color3.fromRGB(17, 17, 17),
	0,
	0,
	nil
}, {
	nil,
	Color3.fromRGB(167, 167, 167),
	nil,
	nil,
	nil
})
v122("Rare", "Brain", {
	"Brain",
	Color3.fromRGB(255, 152, 220),
	0,
	0,
	nil
}, {
	Enum.Material.Glass,
	Color3.fromRGB(0, 0, 0),
	0,
	0,
	nil
}, {
	nil,
	Color3.fromRGB(255, 106, 228),
	nil,
	nil,
	nil
})
v122("Rare", "Arctic Camo", {
	"Arctic Camo",
	Color3.fromRGB(255, 255, 255),
	0,
	0,
	nil
}, {
	Enum.Material.Glass,
	Color3.fromRGB(17, 17, 17),
	0,
	0,
	nil
}, {
	nil,
	Color3.fromRGB(154, 175, 194),
	nil,
	nil,
	nil
})
v122("Rare", "Carpet", {
	"Carpet",
	Color3.fromRGB(255, 255, 255),
	0,
	0,
	nil
}, {
	Enum.Material.Glass,
	Color3.fromRGB(0, 0, 0),
	0,
	0,
	nil
}, {
	nil,
	Color3.fromRGB(139, 139, 255),
	nil,
	nil,
	nil
})
v122("Rare", "Circuit", {
	"Circuit",
	Color3.fromRGB(255, 255, 255),
	0,
	0,
	nil
}, {
	Enum.Material.Glass,
	Color3.fromRGB(0, 0, 0),
	0,
	0,
	nil
}, {
	nil,
	Color3.fromRGB(105, 206, 105),
	nil,
	nil,
	nil
})
v122("Rare", "Desert Camo", {
	"Desert Camo",
	Color3.fromRGB(255, 255, 255),
	0,
	0,
	nil
}, {
	Enum.Material.Glass,
	Color3.fromRGB(17, 17, 17),
	0,
	0,
	nil
}, {
	nil,
	Color3.fromRGB(163, 141, 116),
	nil,
	nil,
	nil
})
v122("Rare", "Digital Camo", {
	"Digital Camo",
	Color3.fromRGB(255, 255, 255),
	0,
	0,
	nil
}, {
	Enum.Material.Glass,
	Color3.fromRGB(17, 17, 17),
	0,
	0,
	nil
}, {
	nil,
	Color3.fromRGB(161, 161, 161),
	nil,
	nil,
	nil
})
v122("Rare", "Frosted", {
	"Frosted",
	Color3.fromRGB(255, 255, 255),
	0,
	0,
	nil
}, {
	Enum.Material.Glass,
	Color3.fromRGB(161, 239, 255),
	0,
	0.4,
	nil
}, {
	nil,
	Color3.fromRGB(128, 163, 175),
	nil,
	nil,
	nil
})
v122("Rare", "Mainframe", {
	"Mainframe",
	Color3.fromRGB(255, 102, 204),
	0,
	0,
	nil
}, {
	"Mainframe",
	Color3.fromRGB(7, 14, 29),
	0,
	0,
	nil
}, {
	nil,
	Color3.fromRGB(231, 135, 255),
	nil,
	nil,
	nil
})
v122("Rare", "Ocean Camo", {
	"Ocean Camo",
	Color3.fromRGB(255, 255, 255),
	0,
	0,
	nil
}, {
	Enum.Material.Glass,
	Color3.fromRGB(17, 17, 17),
	0,
	0,
	nil
}, {
	nil,
	Color3.fromRGB(108, 130, 255),
	nil,
	nil,
	nil
})
v122("Rare", "PB & J", {
	"PB & J",
	Color3.fromRGB(212, 144, 189),
	0,
	0,
	nil
}, {
	"PB & J",
	Color3.fromRGB(212, 144, 189),
	0,
	0,
	nil
}, {
	nil,
	Color3.fromRGB(143, 120, 255),
	nil,
	nil,
	nil
})
v122("Rare", "Reptile", {
	"Reptile",
	Color3.fromRGB(103, 127, 51),
	0,
	0,
	nil
}, {
	"Reptile",
	Color3.fromRGB(0, 0, 0),
	0,
	0,
	nil
}, {
	nil,
	Color3.fromRGB(146, 255, 106),
	nil,
	nil,
	nil
})
v122("Rare", "Rug", {
	"Rug",
	Color3.fromRGB(255, 255, 255),
	0,
	0,
	nil
}, {
	Enum.Material.Glass,
	Color3.fromRGB(157, 157, 157),
	0,
	0,
	nil
}, {
	nil,
	Color3.fromRGB(163, 163, 163),
	nil,
	nil,
	nil
})
v122("Rare", "Steel", {
	"Steel",
	Color3.fromRGB(255, 255, 255),
	0,
	0,
	nil
}, {
	Enum.Material.Glass,
	Color3.fromRGB(54, 54, 54),
	0,
	0.4,
	nil
}, {
	nil,
	Color3.fromRGB(159, 159, 159),
	nil,
	nil,
	nil
})
v122("Rare", "Street Camo", {
	"Street Camo",
	Color3.fromRGB(255, 255, 255),
	0,
	0,
	nil
}, {
	Enum.Material.Glass,
	Color3.fromRGB(17, 17, 17),
	0,
	0,
	nil
}, {
	nil,
	Color3.fromRGB(180, 172, 112),
	nil,
	nil,
	nil
})
v122("Rare", "Urban Camo", {
	"Urban Camo",
	Color3.fromRGB(255, 255, 255),
	0,
	0,
	nil
}, {
	Enum.Material.Glass,
	Color3.fromRGB(17, 17, 17),
	0,
	0,
	nil
}, {
	nil,
	Color3.fromRGB(255, 131, 131),
	nil,
	nil,
	nil
})
v122("Rare", "Medium stone grey", {
	Enum.Material.SmoothPlastic,
	Color3.fromRGB(163, 162, 165),
	0,
	0,
	nil
}, {
	Enum.Material.SmoothPlastic,
	Color3.fromRGB(163, 162, 165),
	0,
	0,
	nil
}, {
	Enum.Material.SmoothPlastic,
	Color3.fromRGB(163, 162, 165),
	0,
	0,
	nil
})
v122("Rare", "Studs", {
	nil,
	nil,
	0,
	0,
	"Studs"
}, {
	nil,
	nil,
	0,
	0,
	"Studs"
})
v122("Rare", "Inlets", {
	nil,
	nil,
	0,
	0,
	"Inlets"
}, {
	nil,
	nil,
	0,
	0,
	"Inlets"
})
v122("Rare", "Universal", {
	nil,
	nil,
	0,
	0,
	"Universal"
}, {
	nil,
	nil,
	0,
	0,
	"Universal"
})
v122("Rare", "Surge", {
	nil,
	Color3.fromRGB(109, 25, 47),
	0,
	0,
	nil
}, {
	nil,
	Color3.fromRGB(23, 59, 111),
	0,
	0,
	nil
})
v122("Rare", "Vile", {
	nil,
	Color3.fromRGB(75, 35, 136),
	0,
	0,
	nil
}, {
	nil,
	Color3.fromRGB(101, 147, 49),
	0,
	0,
	nil
})
v122("Rare", "OranGG", {
	nil,
	Color3.fromRGB(206, 206, 206),
	0,
	0,
	nil
}, {
	nil,
	Color3.fromRGB(255, 106, 0),
	0,
	0,
	nil
})
v122("Rare", "Maize", {
	nil,
	Color3.fromRGB(0, 39, 76),
	0,
	0,
	nil
}, {
	nil,
	Color3.fromRGB(255, 203, 5),
	0,
	0,
	nil
})
v122("Rare", "Spartan", {
	nil,
	Color3.fromRGB(24, 69, 59),
	0,
	0,
	nil
}, {
	nil,
	Color3.fromRGB(255, 255, 255),
	0,
	0,
	nil
})
v122("Rare", "Crossed", {
	"Crossed",
	Color3.fromRGB(0, 153, 255),
	0,
	0,
	nil
}, {
	Enum.Material.Glass,
	Color3.fromRGB(0, 32, 54),
	0,
	0,
	nil
}, {
	nil,
	Color3.fromRGB(76, 94, 255),
	nil,
	nil,
	nil
})
v122("Rare", "Celtic", {
	Enum.Material.SmoothPlastic,
	Color3.fromRGB(27, 39, 22),
	0,
	0,
	nil
}, {
	Enum.Material.Neon,
	Color3.fromRGB(175, 142, 86),
	0,
	0,
	"Celtic"
}, {
	Enum.Material.Neon,
	Color3.fromRGB(175, 142, 86),
	0,
	0,
	nil
})
v122("Rare", "Dawn", {
	Enum.Material.Neon,
	Color3.fromRGB(255, 204, 0),
	0,
	0,
	"Dawn1"
}, {
	Enum.Material.Neon,
	Color3.fromRGB(28, 52, 117),
	0,
	0,
	"Dawn2"
}, {
	Enum.Material.Neon,
	Color3.fromRGB(161, 122, 90),
	0,
	0,
	nil
})
v122("Rare", "Termination", {
	Enum.Material.Metal,
	Color3.fromRGB(117, 0, 0),
	0,
	0,
	nil
}, {
	Enum.Material.Glass,
	Color3.fromRGB(255, 255, 255),
	0,
	0.05,
	nil
}, {
	Enum.Material.Neon,
	Color3.fromRGB(170, 57, 57),
	0,
	0,
	nil
})
v122("Rare", "Fiery", {
	Enum.Material.Neon,
	Color3.fromRGB(159, 29, 29),
	0,
	0,
	nil
}, {
	Enum.Material.Neon,
	Color3.fromRGB(163, 145, 91),
	0,
	0,
	nil
}, {
	Enum.Material.Neon,
	Color3.fromRGB(185, 34, 34),
	0,
	0,
	nil
})
v122("Rare", "Portal", {
	Enum.Material.Neon,
	Color3.fromRGB(255, 102, 204),
	0,
	0,
	"Portal"
}, {
	Enum.Material.SmoothPlastic,
	Color3.fromRGB(255, 152, 220),
	0,
	0.4,
	nil
}, {
	Enum.Material.Neon,
	Color3.fromRGB(255, 152, 220),
	0,
	0,
	nil
})
v122("Rare", "Voltaic", {
	"Voltaic",
	Color3.fromRGB(226, 155, 64),
	0,
	0,
	nil
}, {
	Enum.Material.Metal,
	Color3.fromRGB(226, 155, 64),
	0,
	0,
	nil
}, {
	Enum.Material.ForceField,
	Color3.fromRGB(226, 155, 64),
	0,
	0,
	nil
})
v122("Rare", "Carmine", {
	Enum.Material.Glass,
	Color3.fromRGB(117, 0, 0),
	0.15,
	0,
	nil
}, {
	"Carmine",
	Color3.fromRGB(86, 36, 36),
	0,
	0,
	nil
}, {
	Enum.Material.Neon,
	Color3.fromRGB(189, 0, 0),
	0,
	0,
	nil
})
v122("Rare", "Money", {
	Enum.Material.SmoothPlastic,
	Color3.fromRGB(255, 255, 255),
	0,
	0,
	"Money"
}, {
	Enum.Material.Plastic,
	Color3.fromRGB(0, 0, 0),
	0,
	0,
	nil
}, {
	Enum.Material.Neon,
	Color3.fromRGB(102, 255, 99),
	0,
	0,
	nil
})
v122("Rare", "Eco", {
	Enum.Material.SmoothPlastic,
	Color3.fromRGB(255, 255, 255),
	0,
	0,
	nil
}, {
	Enum.Material.Neon,
	Color3.fromRGB(0, 163, 0),
	0,
	0,
	"Eco"
}, {
	Enum.Material.Neon,
	Color3.fromRGB(0, 163, 0),
	0,
	0,
	nil
})
v122("Rare", "Igneous", {
	Enum.Material.SmoothPlastic,
	Color3.fromRGB(0, 0, 0),
	0,
	0.05,
	nil
}, {
	Enum.Material.Neon,
	Color3.fromRGB(255, 176, 111),
	0,
	0,
	"Igneous"
}, {
	Enum.Material.Neon,
	Color3.fromRGB(168, 145, 93),
	0,
	0,
	nil
})
v122("Rare", "Spellslinger", {
	Enum.Material.Neon,
	Color3.fromRGB(255, 255, 255),
	0,
	0,
	"Spellsling"
}, {
	"Spellslinger",
	Color3.fromRGB(12, 156, 127),
	0,
	0,
	nil
}, {
	Enum.Material.Neon,
	Color3.fromRGB(101, 182, 159),
	0,
	0,
	nil
})
v122("Rare", "White", {
	Enum.Material.SmoothPlastic,
	Color3.fromRGB(255, 255, 255),
	0,
	0,
	nil
}, {
	Enum.Material.SmoothPlastic,
	Color3.fromRGB(255, 255, 255),
	0,
	0,
	nil
}, {
	nil,
	Color3.fromRGB(255, 255, 255),
	nil,
	nil,
	nil
}, nil, "Earned by reaching Level 50 on a weapon", "Earned by reaching Level 50 on this weapon")
v122("Rare", "Black", {
	Enum.Material.SmoothPlastic,
	Color3.fromRGB(0, 0, 0),
	0,
	0,
	nil
}, {
	Enum.Material.SmoothPlastic,
	Color3.fromRGB(0, 0, 0),
	0,
	0,
	nil
}, {
	nil,
	Color3.fromRGB(0, 0, 0),
	nil,
	nil,
	nil
}, nil, "Earned by reaching Level 99 on a weapon", "Earned by reaching Level 99 on this weapon")
v122("Rare", "Nova", {
	"Nova",
	Color3.fromRGB(19, 255, 224),
	0,
	0,
	nil
}, {
	"Nova",
	Color3.fromRGB(0, 120, 94),
	0,
	0,
	nil
}, {
	nil,
	Color3.fromRGB(89, 255, 191),
	nil,
	nil,
	nil
}, nil, "Rare drop from Daily Tasks")
v122("Rare", "Fire", {
	Enum.Material.Neon,
	Color3.fromRGB(102, 77, 0),
	0,
	0,
	"Fire"
}, {
	Enum.Material.Glass,
	Color3.fromRGB(255, 100, 0),
	0,
	0.1,
	nil
}, {
	nil,
	Color3.fromRGB(255, 106, 69),
	nil,
	nil,
	nil
}, nil, "Earned by winning 10 duels in a row")
v122("Rare", "Trophy", {
	Enum.Material.Neon,
	Color3.fromRGB(168, 158, 66),
	0,
	0,
	"Trophy"
}, {
	Enum.Material.Glass,
	Color3.fromRGB(252, 255, 96),
	0,
	0.1,
	nil
}, {
	nil,
	Color3.fromRGB(252, 255, 96),
	nil,
	nil,
	nil
}, nil, "Earned by winning 25 duels")
v122("Rare", "Experience", {
	Enum.Material.Neon,
	Color3.fromRGB(94, 145, 157),
	0,
	0,
	"Experience"
}, {
	Enum.Material.Glass,
	Color3.fromRGB(30, 150, 255),
	0,
	0.1,
	nil
}, {
	nil,
	Color3.fromRGB(106, 166, 191),
	nil,
	nil,
	nil
}, nil, "Earned every 10 career levels")
v122("Rare", "Rage", {
	"Rage",
	Color3.fromRGB(255, 121, 248),
	0,
	0,
	nil
}, {
	Enum.Material.Glass,
	Color3.fromRGB(38, 14, 27),
	0,
	0,
	nil
}, {
	nil,
	Color3.fromRGB(190, 72, 72),
	nil,
	nil,
	nil
})
v122("Rare", "Scales", {
	"Scales",
	Color3.fromRGB(255, 202, 128),
	0,
	0,
	nil
}, {
	Enum.Material.Glass,
	Color3.fromRGB(47, 28, 7),
	0,
	0,
	nil
}, {
	nil,
	Color3.fromRGB(255, 143, 121),
	nil,
	nil,
	nil
})
v122("Rare", "Obsidian", {
	"Arabesque",
	Color3.fromRGB(0, 0, 0),
	0,
	0,
	nil
}, {
	Enum.Material.Glass,
	Color3.fromRGB(25, 24, 36),
	0,
	0,
	nil
}, {
	nil,
	Color3.fromRGB(143, 120, 255),
	nil,
	nil,
	nil
})
v122("Rare", "Toy", {
	Enum.Material.SmoothPlastic,
	Color3.fromRGB(55, 134, 37),
	0,
	0.1,
	nil
}, {
	Enum.Material.SmoothPlastic,
	Color3.fromRGB(55, 134, 37),
	0,
	0.1,
	nil
}, {
	Enum.Material.Glass,
	Color3.fromRGB(55, 134, 37),
	0,
	0.1,
	nil
})
v122("Rare", "Well Done", {
	"A5",
	Color3.fromRGB(72, 56, 40),
	0,
	0,
	nil
}, {
	Enum.Material.Concrete,
	Color3.fromRGB(0, 0, 0),
	0,
	0,
	nil
}, {
	nil,
	Color3.fromRGB(255, 163, 140),
	nil,
	nil,
	nil
})
v122("Rare", "Dunes", {
	"Dunes",
	Color3.fromRGB(255, 255, 255),
	0,
	0,
	nil
}, {
	"Dunes",
	Color3.fromRGB(0, 0, 0),
	0,
	0,
	nil
}, {
	nil,
	Color3.fromRGB(171, 157, 125),
	nil,
	nil,
	nil
})
v122("Rare", "Glisten", {
	"Glisten",
	Color3.fromRGB(4, 175, 236),
	0,
	0,
	nil
}, {
	"Glisten",
	Color3.fromRGB(0, 88, 120),
	0,
	0,
	nil
}, {
	nil,
	Color3.fromRGB(126, 154, 255),
	nil,
	nil,
	nil
})
v122("Rare", "Glossy", {
	"Glossy",
	Color3.fromRGB(255, 255, 255),
	0,
	0,
	nil
}, {
	"Glossy",
	Color3.fromRGB(255, 255, 255),
	0,
	0,
	nil
}, {
	nil,
	Color3.fromRGB(255, 169, 218),
	nil,
	nil,
	nil
})
v122("Rare", "Storm", {
	"Storm",
	Color3.fromRGB(248, 248, 248),
	0,
	0,
	nil
}, {
	"Storm",
	Color3.fromRGB(44, 41, 70),
	0,
	0,
	nil
}, {
	nil,
	Color3.fromRGB(150, 140, 255),
	nil,
	nil,
	nil
})
v122("Rare", "Bunsen", {
	"Bunsen",
	Color3.fromRGB(33, 84, 185),
	0,
	0,
	nil
}, {
	Enum.Material.Glass,
	Color3.fromRGB(5, 22, 59),
	0,
	0,
	nil
}, {
	nil,
	Color3.fromRGB(17, 61, 255),
	nil,
	nil,
	nil
})
v122("Rare", "Black Granite", {
	"Black Granite",
	Color3.fromRGB(223, 223, 222),
	0,
	0,
	nil
}, {
	"Black Granite",
	Color3.fromRGB(91, 93, 105),
	0,
	0,
	nil
}, {
	Enum.Material.Glass,
	Color3.fromRGB(17, 17, 17),
	0.75,
	0,
	nil
})
v122("Rare", "Cerulean", {
	"Resolute",
	Color3.fromRGB(0, 255, 255),
	0,
	0,
	nil
}, {
	"Resolute",
	Color3.fromRGB(0, 0, 0),
	0,
	0,
	nil
}, {
	Enum.Material.Neon,
	Color3.fromRGB(61, 255, 110),
	0,
	0,
	nil
})
v122("Rare", "Clamshell", {
	"Clamshell",
	Color3.fromRGB(255, 255, 255),
	0,
	0,
	nil
}, {
	Enum.Material.SmoothPlastic,
	Color3.fromRGB(255, 226, 212),
	0,
	0.3,
	nil
}, {
	Enum.Material.Neon,
	Color3.fromRGB(233, 182, 213),
	0,
	0,
	nil
})
v122("Rare", "Cool Crochet", {
	"Crochet",
	Color3.fromRGB(117, 127, 106),
	0,
	0,
	nil
}, {
	"Crochet",
	Color3.fromRGB(116, 134, 157),
	0,
	0,
	nil
}, {
	"Crochet",
	Color3.fromRGB(116, 134, 157),
	0,
	0,
	nil
})
v122("Rare", "Cork", {
	"Cork",
	Color3.fromRGB(248, 248, 248),
	0,
	0,
	nil
}, {
	"Cork",
	Color3.fromRGB(163, 162, 165),
	0,
	0,
	nil
}, {
	Enum.Material.Neon,
	Color3.fromRGB(203, 171, 149),
	0,
	0,
	nil
})
v122("Rare", "Hammered Copper", {
	"Hammered",
	Color3.fromRGB(140, 96, 64),
	0,
	0,
	nil
}, {
	"Hammered",
	Color3.fromRGB(140, 96, 64),
	0,
	0,
	nil
}, {
	Enum.Material.Neon,
	Color3.fromRGB(204, 117, 95),
	0,
	0,
	nil
})
v122("Rare", "Hypnotic", {
	"Hypnotic 1",
	Color3.fromRGB(248, 248, 248),
	0,
	0,
	nil
}, {
	"Hypnotic 2",
	Color3.fromRGB(248, 248, 248),
	0,
	0,
	nil
}, {
	Enum.Material.Neon,
	Color3.fromRGB(223, 143, 255),
	0,
	0,
	nil
})
v122("Rare", "Leafy Grass", {
	"Leafy Grass",
	Color3.fromRGB(223, 223, 222),
	0,
	0,
	nil
}, {
	"Leafy Grass",
	Color3.fromRGB(163, 162, 165),
	0,
	0,
	nil
}, {
	Enum.Material.Neon,
	Color3.fromRGB(132, 197, 104),
	0,
	0,
	nil
})
v122("Rare", "Liquid Chrome", {
	"Liquid Chrome",
	Color3.fromRGB(193, 193, 193),
	0,
	0,
	nil
}, {
	"Liquid Chrome",
	Color3.fromRGB(255, 255, 255),
	0,
	0,
	nil
}, {
	Enum.Material.Neon,
	Color3.fromRGB(155, 158, 193),
	0,
	0,
	nil
})
v122("Rare", "Mahogany", {
	"Mahogany Wood",
	Color3.fromRGB(194, 124, 74),
	0,
	0,
	nil
}, {
	"Mahogany Wood",
	Color3.fromRGB(117, 62, 0),
	0,
	0,
	nil
}, {
	Enum.Material.Neon,
	Color3.fromRGB(199, 141, 107),
	0,
	0,
	nil
})
v122("Rare", "Neo", {
	"Neo",
	Color3.fromRGB(4, 175, 236),
	0,
	0,
	nil
}, {
	"Neo",
	Color3.fromRGB(61, 21, 133),
	0,
	0,
	nil
}, {
	Enum.Material.Neon,
	Color3.fromRGB(82, 124, 174),
	0,
	0,
	nil
})
v122("Rare", "Pink Crochet", {
	"Crochet",
	Color3.fromRGB(255, 152, 220),
	0,
	0,
	nil
}, {
	"Crochet",
	Color3.fromRGB(172, 103, 149),
	0,
	0,
	nil
}, {
	"Crochet",
	Color3.fromRGB(255, 152, 220),
	0,
	0,
	nil
})
v122("Rare", "Pink Glitter", {
	"Pink Glitter",
	Color3.fromRGB(255, 152, 220),
	0,
	0,
	nil
}, {
	Enum.Material.SmoothPlastic,
	Color3.fromRGB(255, 152, 220),
	0,
	0.3,
	nil
}, {
	Enum.Material.Neon,
	Color3.fromRGB(183, 113, 197),
	0,
	0,
	nil
})
v122("Rare", "Studded", {
	"Studded",
	nil,
	0,
	0,
	nil
}, {
	"Studded",
	nil,
	0,
	0,
	nil
})
v122("Rare", "Tempest", {
	Enum.Material.Neon,
	Color3.fromRGB(248, 248, 248),
	0,
	0,
	"Tempest1"
}, {
	Enum.Material.Neon,
	Color3.fromRGB(167, 167, 167),
	0,
	0,
	"Tempest2"
}, {
	Enum.Material.Neon,
	Color3.fromRGB(163, 138, 149),
	0,
	0,
	nil
})
v122("Rare", "Yang", {
	"Yin Yang",
	Color3.fromRGB(248, 248, 248),
	0,
	0,
	nil
}, {
	Enum.Material.SmoothPlastic,
	Color3.fromRGB(248, 248, 248),
	0,
	0,
	nil
}, {
	Enum.Material.Neon,
	Color3.fromRGB(17, 17, 17),
	0,
	0,
	nil
})
v122("Rare", "Yin", {
	"Yin Yang",
	Color3.fromRGB(248, 248, 248),
	0,
	0,
	nil
}, {
	Enum.Material.SmoothPlastic,
	Color3.fromRGB(0, 0, 0),
	0,
	0,
	nil
}, {
	Enum.Material.Neon,
	Color3.fromRGB(255, 255, 255),
	0,
	0,
	nil
})
v122("Rare", "Ancient", {
	"Ancient2",
	Color3.fromRGB(255, 255, 255),
	0,
	0,
	nil
}, {
	"Ancient1",
	Color3.fromRGB(255, 255, 255),
	0,
	0,
	nil
}, {
	Enum.Material.Neon,
	Color3.fromRGB(164, 189, 71),
	0,
	0,
	nil
})
v122("Rare", "Grass", {
	Enum.Material.SmoothPlastic,
	Color3.fromRGB(205, 205, 205),
	0,
	0,
	nil
}, {
	"Grass1",
	Color3.fromRGB(223, 223, 222),
	0,
	0,
	nil
}, {
	Enum.Material.Neon,
	Color3.fromRGB(138, 171, 133),
	0,
	0,
	nil
})
v122("Rare", "Rustic", {
	"RusticWood",
	Color3.fromRGB(124, 92, 70),
	0,
	0,
	nil
}, {
	"BrushedMetal",
	Color3.fromRGB(202, 203, 209),
	0,
	0,
	nil
}, {
	Enum.Material.Neon,
	Color3.fromRGB(221, 177, 145),
	0,
	0,
	nil
})
v122("Rare", "Chrome Webs", {
	"Chrome Webs",
	Color3.fromRGB(0, 0, 0),
	0,
	0,
	nil
}, {
	"Chrome Webs",
	Color3.fromRGB(0, 0, 0),
	0,
	0,
	nil
}, {
	Enum.Material.Neon,
	Color3.fromRGB(0, 0, 0),
	0,
	0,
	nil
})
v122("Rare", "Green Goo", {
	Enum.Material.Neon,
	Color3.fromRGB(83, 161, 82),
	0,
	0,
	"GooWelds"
}, {
	Enum.Material.Plastic,
	Color3.fromRGB(76, 46, 29),
	0,
	0,
	"GooStudsG"
}, {
	Enum.Material.Neon,
	Color3.fromRGB(83, 161, 82),
	0,
	0,
	"GooWelds"
})
v122("Rare", "Purple Goo", {
	Enum.Material.Neon,
	Color3.fromRGB(88, 54, 163),
	0,
	0,
	"GooWelds"
}, {
	Enum.Material.Plastic,
	Color3.fromRGB(27, 42, 53),
	0,
	0,
	"GooStudsP"
}, {
	Enum.Material.Neon,
	Color3.fromRGB(88, 54, 163),
	0,
	0,
	"GooWelds"
})
v122("Rare", "Werewolf Fur", {
	"Werewolf Fur",
	Color3.fromRGB(111, 85, 34),
	0,
	0,
	nil
}, {
	"Werewolf Fur",
	Color3.fromRGB(74, 56, 23),
	0,
	0,
	nil
}, {
	Enum.Material.Neon,
	Color3.fromRGB(170, 75, 75),
	0,
	0,
	nil
})
v122("Rare", "Snowfall", {
	Enum.Material.Neon,
	Color3.fromRGB(255, 255, 255),
	0,
	0,
	"Snowfall"
}, {
	Enum.Material.SmoothPlastic,
	Color3.fromRGB(0, 0, 0),
	0,
	0,
	nil
}, {
	Enum.Material.Neon,
	Color3.fromRGB(159, 159, 159),
	0,
	0,
	nil
})
v122("Rare", "Ugly Sweater", {
	"UglySweater",
	Color3.fromRGB(255, 255, 255),
	0,
	0,
	nil
}, {
	"UglySweater2",
	Color3.fromRGB(39, 70, 45),
	0,
	0,
	nil
}, {
	Enum.Material.Neon,
	Color3.fromRGB(149, 167, 148),
	0,
	0,
	nil
})
v122("Rare", "Jolly Wrapping", {
	"WrappingPaper",
	Color3.fromRGB(20, 135, 77),
	0,
	0,
	"JollyWrapping"
}, {
	"WrappingPearlescent",
	Color3.fromRGB(247, 42, 55),
	0,
	0,
	nil
}, {
	Enum.Material.Neon,
	Color3.fromRGB(247, 71, 74),
	0,
	0,
	nil
})
v122("Rare", "Forest Wrapping", {
	"WrappingPaper",
	Color3.fromRGB(59, 93, 57),
	0,
	0,
	nil
}, {
	"WrappingPearlescent2",
	Color3.fromRGB(252, 252, 252),
	0,
	0,
	nil
}, {
	Enum.Material.Neon,
	Color3.fromRGB(129, 172, 122),
	0,
	0,
	nil
})
v122("Rare", "Peppermint Wrapping", {
	"WrappingPaper",
	Color3.fromRGB(202, 56, 59),
	0,
	0,
	nil
}, {
	"WrappingPearlescent2",
	Color3.fromRGB(252, 252, 252),
	0,
	0,
	nil
}, {
	Enum.Material.Neon,
	Color3.fromRGB(185, 95, 95),
	0,
	0,
	nil
})
v122("Rare", "Winter Wrapping", {
	"WrappingPaper",
	Color3.fromRGB(22, 78, 130),
	0,
	0,
	"WinterWrapping"
}, {
	"WrappingPearlescent",
	Color3.fromRGB(252, 252, 252),
	0,
	0,
	nil
}, {
	Enum.Material.Neon,
	Color3.fromRGB(135, 146, 177),
	0,
	0,
	nil
})
v122("Rare", "Mocha Wrapping", {
	"WrappingPaper",
	Color3.fromRGB(206, 176, 158),
	0,
	0,
	nil
}, {
	"WrappingPearlescent",
	Color3.fromRGB(116, 93, 87),
	0,
	0,
	nil
}, {
	Enum.Material.Neon,
	Color3.fromRGB(179, 157, 135),
	0,
	0,
	nil
})
v122("Rare", "Minty Wrapping", {
	"WrappingPaper",
	Color3.fromRGB(38, 150, 126),
	0,
	0,
	"MintyWrapping"
}, {
	"WrappingPearlescent",
	Color3.fromRGB(32, 144, 116),
	0,
	0,
	nil
}, {
	Enum.Material.Neon,
	Color3.fromRGB(103, 179, 160),
	0,
	0,
	nil
})
v122("Rare", "Frosty Wrapping", {
	"WrappingPaper",
	Color3.fromRGB(194, 194, 194),
	0,
	0,
	"FrostyWrapping"
}, {
	"WrappingPearlescent",
	Color3.fromRGB(217, 239, 255),
	0,
	0,
	nil
}, {
	Enum.Material.Neon,
	Color3.fromRGB(179, 179, 179),
	0,
	0,
	nil
})
v122("Rare", "Creme Wrapping", {
	"WrappingPaper",
	Color3.fromRGB(150, 47, 69),
	0,
	0,
	"CremeWrapping"
}, {
	"WrappingPearlescent",
	Color3.fromRGB(184, 58, 85),
	0,
	0,
	nil
}, {
	Enum.Material.Neon,
	Color3.fromRGB(184, 101, 119),
	0,
	0,
	nil
})
v122("Rare", "Blush Wrapping", {
	"WrappingPaper",
	Color3.fromRGB(247, 175, 218),
	0,
	0,
	"BlushWrapping"
}, {
	"WrappingPearlescent",
	Color3.fromRGB(230, 140, 152),
	0,
	0,
	nil
}, {
	Enum.Material.Neon,
	Color3.fromRGB(230, 140, 152),
	0,
	0,
	nil
})
v122("Rare", "Cashmere Wrapping", {
	"WrappingPaper",
	Color3.fromRGB(186, 135, 112),
	0,
	0,
	nil
}, {
	"WrappingPearlescent",
	Color3.fromRGB(255, 158, 128),
	0,
	0,
	nil
}, {
	Enum.Material.Neon,
	Color3.fromRGB(255, 149, 128),
	0,
	0,
	nil
})
v122("Rare", "Carbon Wrapping", {
	"WrappingPaper",
	Color3.fromRGB(56, 58, 59),
	0,
	0,
	"CarbonWrapping"
}, {
	"WrappingPearlescent",
	Color3.fromRGB(83, 97, 103),
	0,
	0,
	nil
}, {
	Enum.Material.Neon,
	Color3.fromRGB(151, 157, 179),
	0,
	0,
	nil
})
v122("Rare", "Caned Wrapping", {
	"WrappingPaper",
	Color3.fromRGB(181, 47, 65),
	0,
	0,
	"CanedWrapping"
}, {
	"WrappingPearlescent",
	Color3.fromRGB(150, 39, 56),
	0,
	0,
	nil
}, {
	Enum.Material.Neon,
	Color3.fromRGB(171, 84, 98),
	0,
	0,
	nil
})
v122("Rare", "Arbiter", {
	Enum.Material.SmoothPlastic,
	Color3.fromRGB(36, 56, 70),
	0,
	0,
	"Arbiter"
}, {
	"Arbiter",
	Color3.fromRGB(255, 255, 255),
	0,
	0,
	nil
}, {
	Enum.Material.Neon,
	Color3.fromRGB(120, 135, 171),
	0,
	0,
	nil
})
v122("Rare", "Antimatter", {
	Enum.Material.Neon,
	Color3.fromRGB(255, 0, 4),
	0,
	0,
	"Antimatter1"
}, {
	Enum.Material.SmoothPlastic,
	Color3.fromRGB(71, 0, 0),
	0,
	0,
	"Antimatter2"
}, {
	Enum.Material.Neon,
	Color3.fromRGB(157, 0, 0),
	0,
	0,
	nil
})
v122("Rare", "Crimson Art", {
	"CrimsonArt",
	Color3.fromRGB(213, 213, 213),
	0,
	0,
	"CrimsonArt1"
}, {
	"CrimsonArt",
	Color3.fromRGB(248, 248, 248),
	0,
	0,
	nil
}, {
	Enum.Material.Neon,
	Color3.fromRGB(159, 73, 73),
	0,
	0,
	nil
})
v122("Rare", "Model", {
	"RBLXPckge",
	Color3.fromRGB(248, 248, 248),
	0,
	0,
	nil
}, {
	Enum.Material.SmoothPlastic,
	Color3.fromRGB(163, 162, 165),
	0,
	0,
	nil
}, {
	Enum.Material.Neon,
	Color3.fromRGB(88, 111, 166),
	0,
	0,
	nil
})
v122("Rare", "Plasma", {
	Enum.Material.Neon,
	Color3.fromRGB(163, 137, 176),
	0,
	0,
	"Plasma1"
}, {
	Enum.Material.SmoothPlastic,
	Color3.fromRGB(81, 0, 179),
	0,
	0,
	nil
}, {
	Enum.Material.Neon,
	Color3.fromRGB(155, 130, 167),
	0,
	0,
	nil
})
v122("Rare", "Purpleize", {
	"Purpleize",
	Color3.fromRGB(224, 178, 208),
	0,
	0,
	nil
}, {
	"Purpleize",
	Color3.fromRGB(167, 94, 155),
	0,
	0.05,
	nil
}, {
	Enum.Material.Neon,
	Color3.fromRGB(163, 122, 172),
	0,
	0,
	nil
})
v122("Rare", "Regal", {
	"RegalFabric",
	Color3.fromRGB(186, 0, 0),
	0,
	0.3,
	nil
}, {
	Enum.Material.Glass,
	Color3.fromRGB(243, 182, 0),
	0,
	0.6,
	"Regal"
}, {
	Enum.Material.Neon,
	Color3.fromRGB(171, 125, 99),
	0,
	0,
	nil
})
v122("Rare", "Sentinel", {
	Enum.Material.SmoothPlastic,
	Color3.fromRGB(255, 255, 255),
	0,
	0.5,
	"Sentinel"
}, {
	Enum.Material.SmoothPlastic,
	Color3.fromRGB(255, 255, 255),
	0,
	0.5,
	nil
}, {
	Enum.Material.Neon,
	Color3.fromRGB(168, 143, 124),
	0,
	0,
	nil
})
v122("Rare", "Strobe", {
	Enum.Material.SmoothPlastic,
	Color3.fromRGB(17, 17, 17),
	0,
	0,
	"Strobe1"
}, {
	Enum.Material.Neon,
	Color3.fromRGB(17, 17, 17),
	0,
	0,
	"Strobe2"
}, {
	Enum.Material.Neon,
	Color3.fromRGB(111, 158, 166),
	0,
	0,
	nil
})
v122("Rare", "TIX", {
	Enum.Material.SmoothPlastic,
	Color3.fromRGB(19, 21, 22),
	0,
	0,
	"TIXWRAP"
}, {
	Enum.Material.Plastic,
	Color3.fromRGB(71, 44, 12),
	0,
	0,
	nil
}, {
	Enum.Material.Neon,
	Color3.fromRGB(166, 146, 85),
	0,
	0,
	nil
})
v122("Rare", "Tealur", {
	Enum.Material.Neon,
	Color3.fromRGB(73, 166, 138),
	0,
	0,
	"Tealur"
}, {
	Enum.Material.SmoothPlastic,
	Color3.fromRGB(23, 23, 23),
	0,
	0,
	nil
}, {
	Enum.Material.Neon,
	Color3.fromRGB(70, 159, 131),
	0,
	0,
	nil
})
v122("Rare", "Waste", {
	Enum.Material.Neon,
	Color3.fromRGB(0, 168, 67),
	0,
	0,
	"Waste1"
}, {
	Enum.Material.Neon,
	Color3.fromRGB(0, 0, 0),
	0,
	0,
	"Waste2"
}, {
	Enum.Material.Neon,
	Color3.fromRGB(58, 158, 58),
	0,
	0,
	nil
})
v122("Rare", "Lovely Leopard", {
	Enum.Material.SmoothPlastic,
	Color3.fromRGB(248, 248, 248),
	0,
	0,
	"LovelyLeopard1"
}, {
	Enum.Material.SmoothPlastic,
	Color3.fromRGB(17, 17, 17),
	0,
	0,
	"LovelyLeopard2"
}, {
	Enum.Material.Neon,
	Color3.fromRGB(161, 119, 162),
	0,
	0,
	nil
})
v122("Rare", "Facility", {
	Enum.Material.SmoothPlastic,
	Color3.fromRGB(57, 58, 72),
	0,
	0,
	"Facility"
}, {
	Enum.Material.SmoothPlastic,
	Color3.fromRGB(159, 163, 191),
	0,
	0,
	nil
}, {
	Enum.Material.SmoothPlastic,
	Color3.fromRGB(57, 58, 72),
	0,
	0,
	nil
})
v122("Rare", "Vigor", {
	"Vigor",
	Color3.fromRGB(255, 71, 135),
	0,
	0,
	"Vigor1"
}, {
	"Vigor",
	Color3.fromRGB(231, 64, 123),
	0,
	0,
	"Vigor2"
}, {
	Enum.Material.SmoothPlastic,
	Color3.fromRGB(255, 37, 95),
	0.33,
	0.4,
	nil
})
v122("Rare", "Bliss", {
	Enum.Material.Glass,
	Color3.fromRGB(164, 166, 255),
	0,
	0.3,
	nil
}, {
	"Bliss",
	Color3.fromRGB(132, 119, 173),
	0,
	0,
	nil
}, {
	Enum.Material.Neon,
	Color3.fromRGB(133, 126, 206),
	0,
	0,
	nil
})
v122("Rare", "Holly Wrapping", {
	"WrappingPaper_01a",
	Color3.fromRGB(135, 33, 33),
	0,
	0,
	"Holly_Wrapping_1"
}, {
	"Pearlescent_01b",
	Color3.fromRGB(61, 149, 72),
	0,
	0,
	nil
}, {
	Enum.Material.Neon,
	Color3.fromRGB(102, 180, 111),
	0,
	0,
	nil
})
v122("Rare", "Fortune Wrapping", {
	"WrappingPaper_01a",
	Color3.fromRGB(45, 85, 55),
	0,
	0,
	"Wrapped_Fortune_1"
}, {
	"Pearlescent_01a",
	Color3.fromRGB(255, 196, 93),
	0,
	0,
	nil
}, {
	Enum.Material.Neon,
	Color3.fromRGB(207, 169, 113),
	0,
	0,
	nil
})
v122("Rare", "Pearly Wrapping", {
	"WrappingPaper_01a",
	Color3.fromRGB(218, 195, 173),
	0,
	0,
	"Pearly_Wrapping_1"
}, {
	"Pearlescent_01b",
	Color3.fromRGB(255, 236, 220),
	0,
	0,
	nil
}, {
	Enum.Material.Neon,
	Color3.fromRGB(167, 154, 144),
	0,
	0,
	nil
})
v122("Rare", "Polar Wrapping", {
	"WrappingPaper_01a",
	Color3.fromRGB(15, 15, 15),
	0,
	0,
	"Polar_Wrapping_1"
}, {
	"Pearlescent_01b",
	Color3.fromRGB(233, 241, 255),
	0,
	0,
	nil
}, {
	Enum.Material.Neon,
	Color3.fromRGB(155, 161, 170),
	0,
	0,
	nil
})
v122("Rare", "Chilled Wrapping", {
	"WrappingPaper_01a",
	Color3.fromRGB(98, 221, 232),
	0,
	0,
	"Chilled_Wrapping_1"
}, {
	"Pearlescent_01b",
	Color3.fromRGB(110, 212, 255),
	0,
	0,
	nil
}, {
	Enum.Material.Neon,
	Color3.fromRGB(112, 196, 204),
	0,
	0,
	nil
})
v122("Rare", "Luxury Wrapping", {
	"WrappingPaper_01a",
	Color3.fromRGB(59, 58, 57),
	0,
	0,
	"Wrapped_Luxury_1"
}, {
	"Pearlescent_01b",
	Color3.fromRGB(255, 233, 190),
	0,
	0,
	nil
}, {
	Enum.Material.Neon,
	Color3.fromRGB(180, 170, 152),
	0,
	0,
	nil
})
v122("Rare", "Regal Wrapping", {
	"WrappingPaper_01a",
	Color3.fromRGB(149, 30, 48),
	0,
	0,
	"Regal_Wrapping_1"
}, {
	"Pearlescent_01b",
	Color3.fromRGB(255, 191, 87),
	0,
	0,
	nil
}, {
	Enum.Material.Neon,
	Color3.fromRGB(207, 154, 113),
	0,
	0,
	nil
})
v122("Rare", "Mousse Wrapping", {
	"WrappingPaper_01a",
	Color3.fromRGB(134, 98, 82),
	0,
	0,
	nil
}, {
	"Pearlescent_01b",
	Color3.fromRGB(117, 85, 72),
	0,
	0,
	nil
}, {
	Enum.Material.Neon,
	Color3.fromRGB(166, 123, 106),
	0,
	0,
	nil
})
v122("Rare", "Periwinkle Wrapping", {
	"WrappingPaper_01a",
	Color3.fromRGB(190, 187, 227),
	0,
	0,
	nil
}, {
	"Pearlescent_01a",
	Color3.fromRGB(95, 70, 107),
	0,
	0,
	nil
}, {
	Enum.Material.Neon,
	Color3.fromRGB(159, 128, 174),
	0,
	0,
	nil
})
v122("Rare", "Evergreen Wrapping", {
	"WrappingPaper_01a",
	Color3.fromRGB(59, 93, 57),
	0,
	0,
	nil
}, {
	"Pearlescent_01a",
	Color3.fromRGB(98, 153, 94),
	0,
	0,
	nil
}, {
	Enum.Material.Neon,
	Color3.fromRGB(113, 170, 107),
	0,
	0,
	nil
})
v122("Rare", "Dusky Wrapping", {
	"WrappingPaper_01a",
	Color3.fromRGB(64, 73, 107),
	0,
	0,
	nil
}, {
	"Pearlescent_01a",
	Color3.fromRGB(117, 134, 171),
	0,
	0,
	nil
}, {
	Enum.Material.Neon,
	Color3.fromRGB(129, 144, 180),
	0,
	0,
	nil
})
v122("Rare", "Merlot Wrapping", {
	"WrappingPaper_01a",
	Color3.fromRGB(143, 47, 65),
	0,
	0,
	nil
}, {
	"Pearlescent_01a",
	Color3.fromRGB(202, 67, 94),
	0,
	0,
	nil
}, {
	Enum.Material.Neon,
	Color3.fromRGB(194, 118, 136),
	0,
	0,
	nil
})
v122("Rare", "Indigo Wrapping", {
	"WrappingPaper_01a",
	Color3.fromRGB(56, 24, 161),
	0,
	0,
	"Indigo_Wrapping_1"
}, {
	"Pearlescent_01b",
	Color3.fromRGB(78, 46, 184),
	0,
	0,
	nil
}, {
	Enum.Material.Neon,
	Color3.fromRGB(135, 122, 184),
	0,
	0,
	nil
})
v122("Rare", "Cold Metal", {
	Enum.Material.Metal,
	Color3.fromRGB(81, 88, 100),
	0,
	0,
	"Cold_Metal_1"
}, {
	Enum.Material.SmoothPlastic,
	Color3.fromRGB(97, 104, 120),
	0,
	0.1,
	"Cold_Metal_2"
}, {
	Enum.Material.Glass,
	Color3.fromRGB(130, 136, 153),
	0,
	0,
	nil
})
v122("Rare", "Winter Solstice", {
	"CandyGlossy",
	Color3.fromRGB(248, 248, 248),
	0,
	0,
	"Winter_Solstice_1"
}, {
	"CandyGlossy",
	Color3.fromRGB(248, 248, 248),
	0,
	0,
	"Winter_Solstice_2"
}, {
	Enum.Material.SmoothPlastic,
	Color3.fromRGB(162, 218, 255),
	0,
	0.02,
	nil
})
v122("Rare", "Mintbread", {
	Enum.Material.Sand,
	Color3.fromRGB(111, 76, 63),
	0,
	0,
	"Mintbread_1"
}, {
	"WrappingPaper",
	Color3.fromRGB(248, 248, 248),
	0,
	0,
	"Mintbread_2"
}, {
	Enum.Material.SmoothPlastic,
	Color3.fromRGB(135, 27, 19),
	0,
	0.1,
	nil
})
v122("Rare", "Galvanized", {
	"Galvanized",
	Color3.fromRGB(102, 108, 112),
	0,
	0,
	nil
}, {
	"Galvanized",
	Color3.fromRGB(113, 124, 131),
	0,
	0,
	nil
}, {
	Enum.Material.SmoothPlastic,
	Color3.fromRGB(96, 103, 113),
	0,
	0,
	nil
})
v122("Rare", "Ruined Pillars", {
	"Pillars",
	Color3.fromRGB(202, 194, 175),
	0,
	0,
	nil
}, {
	Enum.Material.Plaster,
	Color3.fromRGB(167, 160, 145),
	0,
	0,
	"Ruined_Pillars_2"
}, {
	Enum.Material.SmoothPlastic,
	Color3.fromRGB(245, 230, 200),
	0,
	0,
	nil
})
v122("Rare", "Cactus", {
	"Cactus",
	Color3.fromRGB(117, 154, 61),
	0,
	0,
	"Cactus_1"
}, {
	"Cactus",
	Color3.fromRGB(51, 68, 26),
	0,
	0,
	nil
}, {
	Enum.Material.SmoothPlastic,
	Color3.fromRGB(229, 211, 171),
	0,
	0,
	nil
})
v122("Rare", "Lighthouse", {
	Enum.Material.SmoothPlastic,
	Color3.fromRGB(237, 244, 248),
	0,
	0,
	"Lighthouse_1"
}, {
	Enum.Material.Neon,
	Color3.fromRGB(167, 154, 105),
	0,
	0,
	"Lighthouse_2"
}, {
	Enum.Material.Neon,
	Color3.fromRGB(177, 162, 110),
	0,
	0,
	nil
})
v122("Rare", "Neapolitan", {
	"IceCream",
	Color3.fromRGB(248, 248, 248),
	0,
	0,
	"Neapolitan_1"
}, {
	"WaffleCone",
	Color3.fromRGB(204, 137, 92),
	0,
	0,
	"Neapolitan_2"
}, {
	"IceCream",
	Color3.fromRGB(230, 215, 233),
	0,
	0,
	nil
})
v122("Rare", "Shore", {
	"IceCream",
	Color3.fromRGB(238, 209, 158),
	0,
	0,
	"Shore_1"
}, {
	"IceCream",
	Color3.fromRGB(179, 147, 110),
	0,
	0,
	"Shore_2"
}, {
	Enum.Material.SmoothPlastic,
	Color3.fromRGB(128, 187, 219),
	0,
	0.2,
	nil
})
v122("Rare", "Rafflesia", {
	"NatureTest",
	Color3.fromRGB(182, 71, 75),
	0,
	0,
	"Rafflesia_1"
}, {
	"PajamaFur",
	Color3.fromRGB(68, 24, 38),
	0,
	0,
	"Rafflesia_2"
}, {
	nil,
	Color3.fromRGB(255, 106, 92),
	0,
	0,
	nil
})
v122("Rare", "DIY Sensite", {
	Enum.Material.SmoothPlastic,
	Color3.fromRGB(53, 42, 14),
	0,
	0,
	"DIY_Sensite_1"
}, {
	Enum.Material.Plaster,
	Color3.fromRGB(51, 42, 15),
	0,
	0,
	"DIY_Sensite_2"
}, {
	nil,
	Color3.fromRGB(144, 117, 54),
	0,
	0,
	nil
})
v122("Rare", "DIY Nosnite", {
	Enum.Material.SmoothPlastic,
	Color3.fromRGB(31, 24, 53),
	0,
	0,
	"DIY_Nosnite_1"
}, {
	Enum.Material.Plaster,
	Color3.fromRGB(39, 30, 63),
	0,
	0,
	"DIY_Nosnite_2"
}, {
	nil,
	Color3.fromRGB(83, 67, 129),
	0,
	0,
	nil
})
v122("Rare", "Energy Ward", {
	Enum.Material.ForceField,
	Color3.fromRGB(123, 243, 239),
	-1,
	0,
	"Energy_Forcefield_1"
}, {
	Enum.Material.Neon,
	Color3.fromRGB(51, 76, 77),
	0,
	0,
	"Energy_Forcefield_2"
}, {
	Enum.Material.Neon,
	Color3.fromRGB(111, 167, 165),
	0,
	0,
	nil
})
v122("Rare", "Arena Targets", {
	Enum.Material.SmoothPlastic,
	Color3.fromRGB(206, 216, 220),
	0,
	0,
	"Shooting_Range_1"
}, {
	Enum.Material.SmoothPlastic,
	Color3.fromRGB(111, 120, 129),
	0,
	0,
	"Shooting_Range_2"
}, {
	Enum.Material.Neon,
	Color3.fromRGB(96, 144, 176),
	0,
	0,
	nil
})
v122("Legendary", "Diamond", {
	"Diamond",
	Color3.fromRGB(255, 255, 255),
	0,
	0,
	nil
}, {
	Enum.Material.Glass,
	Color3.fromRGB(255, 170, 24),
	0,
	0.4,
	nil
}, {
	nil,
	Color3.fromRGB(255, 165, 120),
	nil,
	nil,
	nil
}, nil, "Earned from weapon contracts", "Earned from a weapon contract for this weapon")
v122("Legendary", "Scorched", {
	"Scorched",
	Color3.fromRGB(171, 171, 171),
	0,
	0,
	nil
}, {
	"Scorched",
	Color3.fromRGB(43, 43, 43),
	0,
	0,
	nil
}, {
	nil,
	Color3.fromRGB(255, 79, 25),
	nil,
	nil,
	nil
})
v122("Legendary", "Glass", {
	Enum.Material.Glass,
	Color3.fromRGB(255, 255, 255),
	0.5,
	0,
	nil
}, {
	Enum.Material.Glass,
	Color3.fromRGB(255, 255, 255),
	0.5,
	0,
	nil
}, {
	Enum.Material.Glass,
	Color3.fromRGB(255, 255, 255),
	0.5,
	0,
	nil
})
v122("Legendary", "Malevolent", {
	"Malevolent",
	Color3.fromRGB(163, 162, 165),
	0,
	0,
	nil
}, {
	Enum.Material.Glass,
	Color3.fromRGB(25, 15, 39),
	0,
	0,
	nil
}, {
	nil,
	Color3.fromRGB(78, 43, 168),
	nil,
	nil,
	nil
})
v122("Legendary", "Omnisand", {
	"Omnisand",
	Color3.fromRGB(255, 255, 255),
	0,
	0,
	nil
}, {
	"Omnisand",
	Color3.fromRGB(81, 81, 81),
	0,
	0,
	nil
}, {
	nil,
	Color3.fromRGB(166, 97, 48),
	nil,
	nil,
	nil
})
v122("Legendary", "Quasar", {
	Enum.Material.Neon,
	Color3.fromRGB(255, 72, 0),
	0,
	0,
	"Quasar"
}, {
	Enum.Material.Neon,
	Color3.fromRGB(255, 72, 0),
	0,
	0,
	"Quasar"
}, {
	nil,
	Color3.fromRGB(255, 105, 94),
	nil,
	nil,
	nil
})
v122("Legendary", "Slime", {
	"Slime",
	Color3.fromRGB(248, 248, 248),
	0,
	0,
	nil
}, {
	"Slime",
	Color3.fromRGB(70, 53, 0),
	0,
	0,
	nil
}, {
	nil,
	Color3.fromRGB(76, 255, 48),
	nil,
	nil,
	nil
})
v122("Legendary", "Water", {
	Enum.Material.Neon,
	Color3.fromRGB(170, 170, 170),
	0,
	0,
	"Water1"
}, {
	Enum.Material.Neon,
	Color3.fromRGB(46, 89, 107),
	0,
	0,
	"Water2"
}, {
	Enum.Material.Neon,
	Color3.fromRGB(77, 129, 175),
	0,
	0,
	nil
})
v122("Legendary", "Black Opal", {
	Enum.Material.Neon,
	Color3.fromRGB(96, 241, 96),
	0,
	0,
	"BlackOpal"
}, {
	"Black Opal",
	Color3.fromRGB(17, 17, 17),
	0,
	0,
	nil
}, {
	Enum.Material.Neon,
	Color3.fromRGB(92, 163, 125),
	0,
	0,
	nil
})
v122("Legendary", "Hesper", {
	"Hesper",
	Color3.fromRGB(248, 248, 248),
	0,
	0,
	nil
}, {
	"Hesper",
	Color3.fromRGB(11, 33, 48),
	0,
	0,
	nil
}, {
	nil,
	Color3.fromRGB(255, 118, 76),
	nil,
	nil,
	nil
})
v122("Legendary", "Sunset", {
	Enum.Material.SmoothPlastic,
	Color3.fromRGB(0, 0, 0),
	0,
	0,
	nil
}, {
	Enum.Material.Neon,
	Color3.fromRGB(213, 115, 61),
	0,
	0,
	"Sunset"
}, {
	Enum.Material.Neon,
	Color3.fromRGB(213, 115, 61),
	0,
	0,
	nil
})
v122("Legendary", ".exe", {
	Enum.Material.Neon,
	Color3.fromRGB(138, 225, 118),
	0,
	0,
	".exe"
}, {
	Enum.Material.Neon,
	Color3.fromRGB(0, 0, 0),
	0,
	0,
	nil
}, {
	Enum.Material.Neon,
	Color3.fromRGB(138, 225, 118),
	0,
	0,
	nil
})
v122("Legendary", "Disco", {
	Enum.Material.SmoothPlastic,
	Color3.fromRGB(255, 255, 255),
	0,
	0.5,
	"Disco"
}, {
	Enum.Material.SmoothPlastic,
	Color3.fromRGB(255, 255, 255),
	0,
	0.5,
	nil
}, {
	nil,
	Color3.fromRGB(255, 255, 255),
	nil,
	nil,
	nil
}, nil, "Included in the Standard Weapons Bundle")
v122("Legendary", "Classic", {
	Enum.Material.Plastic,
	Color3.fromRGB(27, 42, 53),
	0,
	0,
	nil
}, {
	Enum.Material.Plastic,
	Color3.fromRGB(27, 42, 53),
	0,
	0,
	nil
}, {
	Enum.Material.Plastic,
	Color3.fromRGB(27, 42, 53),
	0.5,
	0,
	nil
}, nil, "Included in the Classic Bundle")
v122("Legendary", "Magma", {
	Enum.Material.Neon,
	Color3.fromRGB(255, 141, 75),
	0,
	0,
	"Magma"
}, {
	Enum.Material.Neon,
	Color3.fromRGB(255, 141, 75),
	0,
	0,
	"Magma"
}, {
	nil,
	Color3.fromRGB(255, 141, 75),
	nil,
	nil,
	nil
}, nil, "Included in the Heavy Duty Bundle")
v122("Legendary", "Nebula", {
	Enum.Material.Neon,
	Color3.fromRGB(137, 100, 248),
	0,
	0,
	"Nebula1"
}, {
	Enum.Material.Neon,
	Color3.fromRGB(199, 171, 255),
	0,
	0,
	"Nebula2"
}, {
	nil,
	Color3.fromRGB(133, 103, 255),
	nil,
	nil,
	nil
}, nil, "Included in the Exogun Bundle")
v122("Legendary", "Aurum", {
	Enum.Material.Neon,
	Color3.fromRGB(176, 130, 74),
	0,
	0,
	"Aurum"
}, {
	"Aurum",
	Color3.fromRGB(17, 17, 17),
	0,
	0,
	nil
}, {
	Enum.Material.Neon,
	Color3.fromRGB(175, 128, 80),
	0,
	0,
	nil
}, nil, "Included in the Medkit Bundle")
v122("Legendary", "Paint", {
	"Paint",
	Color3.fromRGB(255, 255, 255),
	0,
	0,
	nil
}, {
	Enum.Material.Glass,
	Color3.fromRGB(212, 212, 212),
	0,
	0.1,
	nil
}, {
	nil,
	Color3.fromRGB(212, 212, 212),
	nil,
	nil,
	nil
}, nil, "Included in the Starter Bundle")
v122("Legendary", "Geometric", {
	"Geometric",
	nil,
	nil,
	nil,
	nil
}, {
	"Geometric",
	nil,
	nil,
	nil,
	nil
}, {
	"Geometric",
	nil,
	nil,
	nil,
	nil
})
v122("Legendary", ".dll", {
	Enum.Material.Neon,
	Color3.fromRGB(108, 134, 223),
	0,
	0,
	".dll"
}, {
	Enum.Material.SmoothPlastic,
	Color3.fromRGB(0, 0, 0),
	0,
	0.05,
	nil
}, {
	Enum.Material.Neon,
	Color3.fromRGB(97, 123, 184),
	0,
	0,
	nil
}, nil, "Included in the Energy Bundle")
v122("Legendary", "Cardboard", {
	Enum.Material.SmoothPlastic,
	Color3.fromRGB(143, 121, 89),
	0,
	0,
	"Cardboard1"
}, {
	Enum.Material.Plaster,
	Color3.fromRGB(117, 98, 72),
	0,
	0,
	"Cardboard2"
}, {
	Enum.Material.Neon,
	Color3.fromRGB(161, 130, 109),
	0,
	0,
	nil
}, nil, "Included in the RPG Bundle")
v122("Legendary", "Wealth", {
	"Wealth",
	Color3.fromRGB(0, 255, 0),
	0,
	0,
	nil
}, {
	"Wealth",
	Color3.fromRGB(0, 0, 0),
	0,
	0,
	nil
}, {
	nil,
	Color3.fromRGB(95, 252, 100),
	nil,
	nil,
	nil
}, nil, "Used to be included in Key Bundles")
v122("Legendary", "Lucre", {
	"Wealth",
	Color3.fromRGB(255, 213, 0),
	0,
	0,
	nil
}, {
	"Wealth",
	Color3.fromRGB(0, 0, 0),
	0,
	0,
	nil
}, {
	nil,
	Color3.fromRGB(255, 140, 73),
	nil,
	nil,
	nil
}, nil, "Used to be included in Key Bundles")
v122("Legendary", "Luxurious", {
	Enum.Material.Glass,
	Color3.fromRGB(255, 176, 0),
	0,
	0.6,
	"Luxurious"
}, {
	Enum.Material.Glass,
	Color3.fromRGB(255, 176, 0),
	0,
	0.6,
	nil
}, {
	Enum.Material.Neon,
	Color3.fromRGB(167, 156, 117),
	0,
	0,
	nil
}, nil, "Included in Key Bundles")
v122("Legendary", "Supernova", {
	Enum.Material.Neon,
	Color3.fromRGB(255, 255, 255),
	0,
	0,
	"Supernova"
}, {
	Enum.Material.Neon,
	Color3.fromRGB(255, 255, 255),
	0,
	0,
	"Supernova"
}, {
	nil,
	Color3.fromRGB(84, 246, 255),
	nil,
	nil,
	nil
}, nil, "Legendary drop from Daily Tasks")
v122("Legendary", "Groove", {
	"Groove",
	Color3.fromRGB(255, 255, 255),
	0,
	0,
	nil
}, {
	"Groove",
	Color3.fromRGB(0, 0, 0),
	0,
	0,
	nil
}, {
	nil,
	Color3.fromRGB(255, 99, 99),
	nil,
	nil,
	nil
}, nil, "Used to be purchased from the Shop")
v122("Legendary", "Blaze", {
	Enum.Material.Neon,
	Color3.fromRGB(255, 0, 0),
	0,
	0,
	"Blaze1"
}, {
	Enum.Material.Neon,
	Color3.fromRGB(154, 85, 32),
	0,
	0,
	"Blaze2"
}, {
	nil,
	Color3.fromRGB(255, 106, 69),
	nil,
	nil,
	nil
}, nil, "Earned by winning 100 duels in a row")
v122("Legendary", "Beach", {
	nil,
	Color3.fromRGB(42, 157, 143),
	0,
	0,
	nil
}, {
	nil,
	Color3.fromRGB(233, 196, 106),
	0,
	0,
	nil
}, {
	nil,
	Color3.fromRGB(119, 207, 255),
	nil,
	nil,
	nil
}, nil, "Used to be purchased from the Shop")
v122("Legendary", "Malachite", {
	"Malachite",
	Color3.fromRGB(255, 255, 255),
	0,
	0,
	nil
}, {
	Enum.Material.Glass,
	Color3.fromRGB(0, 0, 0),
	0,
	0,
	nil
}, {
	nil,
	Color3.fromRGB(94, 255, 148),
	nil,
	nil,
	nil
})
v122("Legendary", "Arabesque", {
	"Arabesque",
	Color3.fromRGB(98, 77, 0),
	0,
	0.2,
	nil
}, {
	Enum.Material.Glass,
	Color3.fromRGB(98, 77, 0),
	0,
	0.4,
	nil
}, {
	nil,
	Color3.fromRGB(170, 154, 115),
	nil,
	nil,
	nil
})
v122("Legendary", "Webbed", {
	"Webbed",
	Color3.fromRGB(117, 0, 0),
	0,
	0,
	nil
}, {
	Enum.Material.Glass,
	Color3.fromRGB(27, 0, 0),
	0,
	0,
	nil
}, {
	nil,
	Color3.fromRGB(255, 69, 69),
	nil,
	nil,
	nil
})
v122("Legendary", "Lightning", {
	Enum.Material.Neon,
	Color3.fromRGB(255, 125, 92),
	0,
	0,
	"Lightning"
}, {
	Enum.Material.Glass,
	Color3.fromRGB(72, 34, 14),
	0,
	0,
	nil
}, {
	Enum.Material.Neon,
	Color3.fromRGB(166, 123, 94),
	0,
	0,
	nil
})
v122("Legendary", "Plastic", {
	Enum.Material.SmoothPlastic,
	Color3.fromRGB(255, 255, 255),
	0.5,
	0.5,
	nil
}, {
	Enum.Material.SmoothPlastic,
	Color3.fromRGB(255, 255, 255),
	0.5,
	0.5,
	nil
}, {
	nil,
	Color3.fromRGB(255, 255, 255),
	nil,
	nil,
	nil
})
v122("Legendary", "Chrome", {
	Enum.Material.SmoothPlastic,
	Color3.fromRGB(255, 255, 255),
	0,
	1,
	nil
}, {
	Enum.Material.SmoothPlastic,
	Color3.fromRGB(255, 255, 255),
	0,
	1,
	nil
}, {
	Enum.Material.SmoothPlastic,
	Color3.fromRGB(255, 255, 255),
	0,
	1,
	nil
})
v122("Legendary", "A5", {
	"A5",
	Color3.fromRGB(255, 255, 255),
	0,
	0,
	nil
}, {
	Enum.Material.Concrete,
	Color3.fromRGB(255, 220, 192),
	0,
	0,
	nil
}, {
	nil,
	Color3.fromRGB(255, 139, 139),
	nil,
	nil,
	nil
})
v122("Legendary", "Amber", {
	"Amber",
	Color3.fromRGB(255, 255, 255),
	0,
	0,
	nil
}, {
	"Amber",
	Color3.fromRGB(0, 0, 0),
	0,
	0,
	nil
}, {
	nil,
	Color3.fromRGB(255, 158, 93),
	nil,
	nil,
	nil
})
v122("Legendary", "Insidious", {
	"Insidious",
	Color3.fromRGB(190, 104, 98),
	0,
	0,
	nil
}, {
	"Insidious",
	Color3.fromRGB(0, 0, 0),
	0,
	0,
	nil
}, {
	nil,
	Color3.fromRGB(255, 111, 111),
	nil,
	nil,
	nil
})
v122("Legendary", "Iridescent", {
	Enum.Material.Neon,
	Color3.fromRGB(166, 145, 211),
	0,
	0,
	"Iridescent1"
}, {
	Enum.Material.Neon,
	Color3.fromRGB(166, 145, 211),
	0,
	0,
	"Iridescent2"
}, {
	Enum.Material.Neon,
	Color3.fromRGB(156, 143, 163),
	0,
	0,
	nil
})
v122("Legendary", "Moonstone", {
	"Moonstone",
	Color3.fromRGB(255, 255, 255),
	0,
	0,
	nil
}, {
	"Moonstone",
	Color3.fromRGB(0, 0, 0),
	0,
	0,
	nil
}, {
	nil,
	Color3.fromRGB(146, 160, 190),
	nil,
	nil,
	nil
})
v122("Legendary", "Bright", {
	Enum.Material.Neon,
	Color3.fromRGB(160, 160, 160),
	0,
	0,
	nil
}, {
	Enum.Material.Neon,
	Color3.fromRGB(160, 160, 160),
	0,
	0,
	nil
}, {
	Enum.Material.Neon,
	Color3.fromRGB(160, 160, 160),
	0,
	0,
	nil
})
v122("Legendary", "Dark", {
	Enum.Material.Neon,
	Color3.fromRGB(0, 0, 0),
	0,
	0,
	nil
}, {
	Enum.Material.Neon,
	Color3.fromRGB(0, 0, 0),
	0,
	0,
	nil
}, {
	Enum.Material.Neon,
	Color3.fromRGB(0, 0, 0),
	0,
	0,
	nil
})
v122("Legendary", "Mischief", {
	Enum.Material.Neon,
	Color3.fromRGB(0, 0, 0),
	0,
	0,
	"Mischief"
}, {
	Enum.Material.Glass,
	Color3.fromRGB(53, 39, 94),
	0,
	0,
	nil
}, {
	nil,
	Color3.fromRGB(139, 131, 255),
	nil,
	nil,
	nil
})
v122("Legendary", "Carbon Fiber", {
	"Carbon Fiber",
	Color3.fromRGB(17, 17, 17),
	0,
	0,
	nil
}, {
	"Carbon Fiber",
	Color3.fromRGB(248, 248, 248),
	0,
	0,
	nil
}, {
	Enum.Material.Neon,
	Color3.fromRGB(0, 0, 0),
	0,
	0,
	nil
})
v122("Legendary", "Hyperdrive", {
	"Hyperdrive",
	Color3.fromRGB(248, 248, 248),
	0,
	0,
	nil
}, {
	Enum.Material.Neon,
	Color3.fromRGB(143, 156, 173),
	0,
	0,
	nil
}, {
	Enum.Material.Neon,
	Color3.fromRGB(159, 173, 192),
	0,
	0,
	nil
})
v122("Legendary", "Insignia", {
	"Insignia",
	Color3.fromRGB(248, 248, 248),
	0,
	0,
	nil
}, {
	"Insignia",
	Color3.fromRGB(17, 17, 17),
	0,
	0,
	nil
}, {
	Enum.Material.Neon,
	Color3.fromRGB(199, 172, 120),
	0,
	0,
	nil
})
v122("Legendary", "Liquid Gold", {
	"Liquid Gold",
	Color3.fromRGB(180, 123, 0),
	0,
	0,
	nil
}, {
	"Liquid Gold",
	Color3.fromRGB(255, 176, 0),
	0,
	0,
	nil
}, {
	Enum.Material.Neon,
	Color3.fromRGB(199, 172, 120),
	0,
	0,
	nil
})
v122("Legendary", "Cardinal", {
	"Cardinal",
	Color3.fromRGB(255, 175, 175),
	0,
	0,
	nil
}, {
	"Cardinal",
	Color3.fromRGB(17, 17, 17),
	0,
	0,
	nil
}, {
	Enum.Material.Neon,
	Color3.fromRGB(227, 74, 76),
	0,
	0,
	nil
})
v122("Legendary", "Starblaze", {
	"Starblaze 2",
	Color3.fromRGB(248, 248, 248),
	0,
	0,
	nil
}, {
	"Starblaze 1",
	Color3.fromRGB(0, 0, 0),
	0,
	0,
	nil
}, {
	Enum.Material.Neon,
	Color3.fromRGB(177, 35, 25),
	0,
	0,
	nil
})
v122("Legendary", "Starfall", {
	"Hyperdrive",
	Color3.fromRGB(9, 137, 207),
	0,
	0,
	nil
}, {
	"Starblaze 1",
	Color3.fromRGB(0, 255, 255),
	0,
	0,
	nil
}, {
	Enum.Material.Neon,
	Color3.fromRGB(24, 74, 255),
	0,
	0,
	nil
})
v122("Legendary", "Tiger", {
	"Tiger",
	Color3.fromRGB(255, 114, 14),
	0,
	0,
	nil
}, {
	"Tiger",
	Color3.fromRGB(17, 17, 17),
	0,
	0,
	nil
}, {
	Enum.Material.Neon,
	Color3.fromRGB(255, 86, 7),
	0,
	0,
	nil
})
v122("Legendary", "Watermelon", {
	"Watermelon Red",
	Color3.fromRGB(255, 131, 131),
	0,
	0,
	nil
}, {
	"Watermelon Green",
	Color3.fromRGB(204, 255, 204),
	0,
	0,
	nil
}, {
	Enum.Material.Neon,
	Color3.fromRGB(163, 75, 75),
	0,
	0,
	nil
}, nil, "Used to be purchased from the Shop")
v122("Legendary", "Damascus", {
	"Damascus",
	Color3.fromRGB(255, 255, 255),
	0,
	0,
	nil
}, {
	Enum.Material.Glass,
	Color3.fromRGB(0, 0, 0),
	0,
	0,
	nil
}, {
	Enum.Material.Neon,
	Color3.fromRGB(195, 195, 195),
	0,
	0,
	nil
}, nil, "Used to be purchased from the Shop")
v122("Legendary", "Black Damascus", {
	"BlackDamascus",
	Color3.fromRGB(0, 0, 0),
	0,
	0,
	nil
}, {
	Enum.Material.Glass,
	Color3.fromRGB(0, 0, 0),
	0,
	0,
	nil
}, {
	Enum.Material.Neon,
	Color3.fromRGB(0, 0, 0),
	0,
	0,
	nil
}, nil, "Used to be purchased from the Shop")
v122("Legendary", "Pixel Blight", {
	Enum.Material.Neon,
	nil,
	0,
	0,
	"PixelBlight",
	"Pixel Blight"
}, {
	Enum.Material.Neon,
	nil,
	0,
	0,
	"PixelBlight",
	"Pixel Blight"
}, {
	Enum.Material.Neon,
	nil,
	0,
	0,
	nil
}, nil, "Used to be purchased from the Shop")
v122("Legendary", "Empress", {
	Enum.Material.Neon,
	Color3.fromRGB(255, 255, 255),
	0,
	0,
	"Empress"
}, {
	Enum.Material.Neon,
	Color3.fromRGB(255, 255, 255),
	0,
	0,
	"Empress"
}, {
	Enum.Material.Neon,
	Color3.fromRGB(172, 150, 181),
	0,
	0,
	nil
}, nil, "Used to be purchased from the Shop")
v122("Legendary", "Arena", {
	Enum.Material.SmoothPlastic,
	Color3.fromRGB(151, 153, 163),
	0,
	0,
	"ArenaTex"
}, {
	Enum.Material.SmoothPlastic,
	Color3.fromRGB(132, 134, 143),
	0,
	0,
	"ArenaTex"
}, {
	Enum.Material.Neon,
	Color3.fromRGB(151, 153, 163),
	0,
	0,
	nil
}, nil, "Purchased from the Shop")
v122("Legendary", "Simulation", {
	Enum.Material.Neon,
	Color3.fromRGB(30, 98, 153),
	0,
	0,
	"Simulation_1"
}, {
	Enum.Material.Neon,
	Color3.fromRGB(16, 51, 81),
	0,
	0,
	"Simulation_2"
}, {
	Enum.Material.Neon,
	Color3.fromRGB(80, 122, 170),
	0,
	0,
	nil
}, nil, "Used to be purchased from the Shop")
v122("Legendary", "Sunset Sparkle", {
	Enum.Material.Neon,
	Color3.fromRGB(255, 137, 137),
	0,
	0,
	"SunsetSparkle1"
}, {
	Enum.Material.Neon,
	Color3.fromRGB(88, 0, 117),
	0,
	0,
	"SunsetSparkle2"
}, {
	Enum.Material.Neon,
	Color3.fromRGB(161, 122, 90),
	0,
	0,
	nil
}, nil, "Used to be purchased from the Shop")
v122("Legendary", "Messis", {
	Enum.Material.SmoothPlastic,
	Color3.fromRGB(17, 17, 17),
	0,
	0,
	"Messis1"
}, {
	Enum.Material.Neon,
	Color3.fromRGB(0, 0, 0),
	0,
	0,
	"Messis2"
}, {
	Enum.Material.Neon,
	Color3.fromRGB(82, 159, 72),
	0,
	0,
	nil
}, nil, "Used to be purchased from the Shop")
v122("Legendary", "Birthday Wrapping", {
	"WrappingPaper_01c",
	Color3.fromRGB(68, 117, 223),
	0,
	0,
	nil
}, {
	"Pearlescent_01c",
	Color3.fromRGB(255, 173, 32),
	0,
	0,
	nil
}, {
	Enum.Material.Neon,
	Color3.fromRGB(173, 150, 110),
	0,
	0,
	nil
}, nil, "Purchased from the Shop during the RIVALS Birthday Party")
v122("Legendary", "RIVALS Wrapping", {
	"WrappingPaper_01c",
	Color3.fromRGB(255, 148, 26),
	0,
	0,
	"RivalsWrapping"
}, {
	"Pearlescent_01d",
	Color3.fromRGB(161, 18, 166),
	0,
	0,
	nil
}, {
	Enum.Material.Neon,
	Color3.fromRGB(145, 114, 172),
	0,
	0,
	nil
}, nil, "Used to be purchased from the Shop during the 1st RIVALS Birthday Party")
v122("Legendary", "Shadow Ink", {
	Enum.Material.Neon,
	Color3.fromRGB(0, 0, 0),
	0,
	0,
	"ShadowInk1"
}, {
	Enum.Material.Neon,
	Color3.fromRGB(0, 0, 0),
	0,
	0,
	"ShadowInk2"
}, {
	Enum.Material.Neon,
	Color3.fromRGB(91, 76, 171),
	0,
	0,
	nil
}, nil, "Used to be purchased from the Shop")
v122("Legendary", "Triplaser", {
	Enum.Material.SmoothPlastic,
	Color3.fromRGB(255, 255, 255),
	0,
	0.5,
	"Tripwire1"
}, {
	Enum.Material.SmoothPlastic,
	Color3.fromRGB(199, 199, 199),
	0,
	0.5,
	nil
}, {
	Enum.Material.Neon,
	Color3.fromRGB(163, 73, 73),
	0,
	0,
	nil
}, nil, "Used to be purchased from the Shop")
v122("Legendary", "Hologram Arena", {
	Enum.Material.Glass,
	Color3.fromRGB(17, 17, 17),
	0.7,
	0,
	"HologramArena1"
}, {
	Enum.Material.Glass,
	Color3.fromRGB(17, 17, 17),
	0,
	0,
	"HologramArena2"
}, {
	Enum.Material.Neon,
	Color3.fromRGB(96, 155, 176),
	0,
	0,
	nil
}, nil, "Used to be purchased from the Shop")
v122("Legendary", "Honey", {
	"Honey",
	Color3.fromRGB(255, 159, 42),
	0,
	0,
	"Honey1"
}, {
	Enum.Material.Glass,
	Color3.fromRGB(212, 119, 19),
	0.25,
	0,
	"Honey2"
}, {
	Enum.Material.Neon,
	Color3.fromRGB(166, 110, 61),
	0,
	0,
	nil
}, nil, "Used to be purchased from the Shop")
v122("Legendary", "Ornamented", {
	Enum.Material.Glass,
	Color3.fromRGB(151, 25, 42),
	0,
	0.2,
	"Ornament_1"
}, {
	Enum.Material.Glass,
	Color3.fromRGB(190, 149, 115),
	0,
	-1.5,
	nil
}, {
	Enum.Material.Glass,
	Color3.fromRGB(173, 28, 50),
	0.2,
	0.1,
	nil
}, nil, "Used to be purchased from the Shop")
v122("Legendary", "Frostbite", {
	Enum.Material.Neon,
	Color3.fromRGB(109, 113, 172),
	0,
	0,
	"Frostbite_1"
}, {
	"WrappingPearlescent",
	Color3.fromRGB(67, 78, 95),
	0,
	0,
	"Frostbite_2"
}, {
	Enum.Material.Glass,
	Color3.fromRGB(46, 54, 65),
	0.1,
	0,
	nil
}, nil, "Used to be purchased from the Shop")
v122("Legendary", "Fire Horse", {
	Enum.Material.Neon,
	Color3.fromRGB(255, 89, 34),
	0,
	0,
	"Fire_Horse_1"
}, {
	Enum.Material.Metal,
	Color3.fromRGB(176, 0, 0),
	0,
	0,
	"Fire_Horse_2"
}, {
	Enum.Material.Metal,
	Color3.fromRGB(193, 137, 42),
	0,
	0,
	nil
}, nil, "Used to be purchased from the Shop")
v122("Legendary", "Serenity", {
	"CupidFluff",
	Color3.fromRGB(255, 143, 173),
	0,
	0,
	"Serenity_1"
}, {
	Enum.Material.Neon,
	Color3.fromRGB(162, 91, 107),
	0,
	0,
	"Serenity_2"
}, {
	Enum.Material.Glass,
	Color3.fromRGB(255, 142, 187),
	0.5,
	0,
	nil
}, nil, "Used to be purchased from the Shop")
v122("Legendary", "Ladybug", {
	Enum.Material.SmoothPlastic,
	Color3.fromRGB(117, 14, 0),
	0,
	0.05,
	"Ladybug_1"
}, {
	"Ladybug1",
	Color3.fromRGB(27, 42, 53),
	0,
	0,
	nil
}, {
	"Ladybug2",
	Color3.fromRGB(152, 194, 219),
	0.4,
	0,
	nil
}, nil, "Used to be purchased from the Shop")
v122("Legendary", "Woven", {
	Enum.Material.SmoothPlastic,
	Color3.fromRGB(238, 180, 255),
	0,
	0,
	"Easter_Basket_1"
}, {
	"Basket",
	Color3.fromRGB(147, 99, 73),
	0,
	0,
	nil
}, {
	Enum.Material.SmoothPlastic,
	Color3.fromRGB(238, 180, 255),
	0,
	0,
	nil
}, nil, "Used to be purchased from the Shop")
v122("Legendary", "Resolute", {
	"Resolute",
	Color3.fromRGB(0, 16, 176),
	0,
	0,
	nil
}, {
	"Resolute",
	Color3.fromRGB(0, 0, 0),
	0,
	0,
	nil
}, {
	Enum.Material.Neon,
	Color3.fromRGB(0, 0, 255),
	0,
	0,
	nil
})
v122("Legendary", "Thunderburst", {
	Enum.Material.Neon,
	Color3.fromRGB(253, 234, 141),
	0,
	0,
	"Thunderburst"
}, {
	Enum.Material.SmoothPlastic,
	Color3.fromRGB(0, 0, 0),
	0,
	0.05,
	nil
}, {
	Enum.Material.Neon,
	Color3.fromRGB(163, 160, 130),
	0,
	0,
	nil
})
v122("Legendary", "Encrypt", {
	"Encrypt",
	Color3.fromRGB(0, 172, 57),
	0,
	0,
	nil
}, {
	"Encrypt",
	Color3.fromRGB(0, 0, 0),
	0,
	0,
	nil
}, {
	Enum.Material.Neon,
	Color3.fromRGB(131, 255, 129),
	0,
	0,
	nil
})
v122("Legendary", "Mummy", {
	Enum.Material.Neon,
	Color3.fromRGB(121, 171, 96),
	0,
	0,
	"Mummy"
}, {
	Enum.Material.Neon,
	Color3.fromRGB(121, 171, 96),
	0,
	0,
	"MummyDark"
}, {
	Enum.Material.Neon,
	Color3.fromRGB(121, 171, 96),
	0,
	0,
	nil
})
v122("Legendary", "Scourge", {
	"Scourge",
	Color3.fromRGB(170, 85, 0),
	0,
	0,
	nil
}, {
	"Scourge",
	Color3.fromRGB(17, 17, 17),
	0,
	0,
	nil
}, {
	Enum.Material.Neon,
	Color3.fromRGB(168, 90, 0),
	0,
	0,
	nil
})
v122("Legendary", "Frankenstein", {
	"Frankenstein",
	Color3.fromRGB(83, 135, 0),
	0,
	0,
	nil
}, {
	"Frankenstein Metal",
	Color3.fromRGB(145, 161, 168),
	0,
	0,
	nil
}, {
	Enum.Material.Neon,
	Color3.fromRGB(104, 163, 109),
	0,
	0,
	nil
})
v122("Legendary", "Hallow", {
	nil,
	Color3.fromRGB(0, 0, 0),
	0,
	0.05,
	nil
}, {
	nil,
	Color3.fromRGB(255, 119, 0),
	0,
	0.1,
	nil
}, {
	Enum.Material.Neon,
	Color3.fromRGB(255, 119, 0),
	0,
	0,
	nil
}, nil, "Used to be purchased from the Shop")
v122("Legendary", "Greenflame", {
	Enum.Material.Neon,
	Color3.fromRGB(0, 255, 0),
	0,
	0,
	"Greenflame1"
}, {
	Enum.Material.Neon,
	Color3.fromRGB(117, 162, 48),
	0,
	0,
	"Greenflame2"
}, {
	nil,
	Color3.fromRGB(122, 255, 14),
	nil,
	nil,
	nil
}, nil, "Included in Candy Bundles")
v122("Legendary", "Aurora", {
	Enum.Material.Neon,
	Color3.fromRGB(129, 255, 110),
	0,
	0,
	"Aurora"
}, {
	Enum.Material.SmoothPlastic,
	Color3.fromRGB(17, 17, 17),
	0,
	0,
	nil
}, {
	Enum.Material.Neon,
	Color3.fromRGB(129, 255, 110),
	0,
	0,
	nil
})
v122("Legendary", "Wintergreen", {
	"GlossyCandyCane2",
	Color3.fromRGB(255, 255, 255),
	0,
	0,
	nil
}, {
	"GlossyGeneric",
	Color3.fromRGB(0, 134, 19),
	0,
	0,
	nil
}, {
	Enum.Material.Neon,
	Color3.fromRGB(102, 167, 104),
	0,
	0,
	nil
}, nil, "Used to be purchased from the Shop")
v122("Legendary", "Gingerbread", {
	"Gingerbread",
	Color3.fromRGB(225, 156, 107),
	0,
	0,
	"Gingerbread"
}, {
	"Gingerbread",
	Color3.fromRGB(86, 66, 54),
	0,
	0,
	nil
}, {
	Enum.Material.Neon,
	Color3.fromRGB(167, 153, 130),
	0,
	0,
	nil
})
v122("Legendary", "Peppermint", {
	"GlossyCandyCane",
	Color3.fromRGB(255, 255, 255),
	0,
	0,
	nil
}, {
	"GlossyGeneric",
	Color3.fromRGB(255, 255, 255),
	0,
	0,
	nil
}, {
	Enum.Material.Neon,
	Color3.fromRGB(161, 52, 52),
	0,
	0,
	nil
})
v122("Legendary", "Crystallized", {
	Enum.Material.Glass,
	Color3.fromRGB(18, 238, 212),
	0.85,
	0,
	"Crystallized"
}, {
	Enum.Material.Glass,
	Color3.fromRGB(18, 238, 212),
	0.85,
	0,
	"Crystallized"
}, {
	Enum.Material.Glass,
	Color3.fromRGB(175, 221, 255),
	0.5,
	0,
	nil
}, nil, "Included in Crystal Bundles")
v122("Legendary", "2025 Wrapping", {
	"WrappingPaper",
	Color3.fromRGB(59, 58, 57),
	0,
	0,
	"2025Wrapping"
}, {
	"WrappingPearlescent",
	Color3.fromRGB(255, 191, 87),
	0,
	0,
	nil
}, {
	Enum.Material.Neon,
	Color3.fromRGB(179, 173, 88),
	0,
	0,
	nil
})
v122("Legendary", "2026 Wrapping", {
	"WrappingPaper",
	Color3.fromRGB(59, 58, 57),
	0,
	0,
	"2026Wrapping"
}, {
	"WrappingPearlescent",
	Color3.fromRGB(255, 191, 87),
	0,
	0,
	nil
}, {
	Enum.Material.Neon,
	Color3.fromRGB(179, 173, 88),
	0,
	0,
	nil
})
v122("Legendary", "Bombastic", {
	Enum.Material.Neon,
	Color3.fromRGB(220, 97, 40),
	0,
	0,
	"Bombastic1"
}, {
	Enum.Material.SmoothPlastic,
	Color3.fromRGB(53, 53, 53),
	0,
	0,
	"Bombastic2"
}, {
	Enum.Material.Neon,
	Color3.fromRGB(161, 93, 47),
	0,
	0,
	nil
})
v122("Legendary", "Candy Apple", {
	"CandyGlossy",
	Color3.fromRGB(23, 152, 0),
	0,
	0,
	"CandyGlossy"
}, {
	"CandyGlossy",
	Color3.fromRGB(255, 128, 0),
	0,
	0,
	nil
}, {
	Enum.Material.Neon,
	Color3.fromRGB(133, 161, 68),
	0,
	0.1,
	nil
})
v122("Legendary", "Dark Arena", {
	Enum.Material.SmoothPlastic,
	Color3.fromRGB(35, 35, 35),
	0,
	0,
	"DarkArena1"
}, {
	Enum.Material.SmoothPlastic,
	Color3.fromRGB(0, 0, 0),
	0,
	0,
	"DarkArena2"
}, {
	Enum.Material.Neon,
	Color3.fromRGB(0, 0, 0),
	1,
	0,
	"DarkArena3"
})
v122("Legendary", "Green Sparkle", {
	Enum.Material.Neon,
	Color3.fromRGB(39, 70, 45),
	0,
	0,
	"GreenSparkle1"
}, {
	Enum.Material.Neon,
	Color3.fromRGB(0, 0, 0),
	0,
	0,
	"GreenSparkle2"
}, {
	Enum.Material.Neon,
	Color3.fromRGB(124, 161, 64),
	0,
	0,
	nil
})
v122("Legendary", "Indigo Sparkle", {
	Enum.Material.Neon,
	Color3.fromRGB(104, 35, 207),
	0,
	0,
	"IndigoSparkle1"
}, {
	Enum.Material.Neon,
	Color3.fromRGB(0, 0, 0),
	0,
	0,
	"IndigoSparkle2"
}, {
	Enum.Material.Neon,
	Color3.fromRGB(78, 60, 177),
	0,
	0,
	nil
})
v122("Legendary", "Mesh", {
	Enum.Material.ForceField,
	Color3.fromRGB(0, 0, 0),
	0,
	0,
	"DarkMesh"
}, {
	Enum.Material.ForceField,
	Color3.fromRGB(0, 0, 0),
	0,
	0,
	"DarkMesh"
}, {
	Enum.Material.ForceField,
	Color3.fromRGB(255, 255, 255),
	0,
	0,
	"LightMesh"
})
v122("Legendary", "Rift", {
	Enum.Material.Neon,
	Color3.fromRGB(17, 17, 17),
	0,
	0,
	"Rift"
}, {
	Enum.Material.Neon,
	Color3.fromRGB(0, 0, 0),
	0,
	0,
	nil
}, {
	Enum.Material.Neon,
	Color3.fromRGB(172, 99, 156),
	0,
	0,
	nil
})
v122("Legendary", "Spectral", {
	Enum.Material.Neon,
	Color3.fromRGB(55, 255, 95),
	0,
	0,
	"Spectral"
}, {
	Enum.Material.SmoothPlastic,
	Color3.fromRGB(71, 255, 203),
	0,
	0.4,
	nil
}, {
	Enum.Material.Neon,
	Color3.fromRGB(92, 158, 119),
	0,
	0,
	nil
})
v122("Legendary", "Hologram", {
	Enum.Material.Neon,
	Color3.fromRGB(84, 138, 255),
	0.6,
	0,
	nil
}, {
	Enum.Material.Neon,
	Color3.fromRGB(84, 138, 255),
	0.6,
	0,
	nil
}, {
	Enum.Material.Neon,
	Color3.fromRGB(84, 138, 255),
	0.6,
	0,
	nil
})
v122("Legendary", "Bubbles", {
	Enum.Material.ForceField,
	Color3.fromRGB(255, 255, 255),
	0.9,
	0,
	"Bubbles"
}, {
	Enum.Material.ForceField,
	Color3.fromRGB(255, 255, 255),
	0.9,
	0,
	"Bubbles"
}, {
	Enum.Material.ForceField,
	Color3.fromRGB(255, 255, 255),
	0.9,
	0,
	"Bubbles"
}, nil, "Earned by gifting other players")
v122("Legendary", "Black Glass", {
	Enum.Material.Glass,
	Color3.fromRGB(0, 0, 0),
	0.6,
	0,
	nil
}, {
	Enum.Material.Glass,
	Color3.fromRGB(0, 0, 0),
	0.6,
	0,
	nil
}, {
	Enum.Material.Glass,
	Color3.fromRGB(0, 0, 0),
	0.6,
	0,
	nil
}, nil, "Purchased from the Ranked Shop")
v122("Legendary", "Magnetite", {
	Enum.Material.Glass,
	Color3.fromRGB(130, 80, 255),
	0,
	-2,
	"Magnetite"
}, {
	Enum.Material.Glass,
	Color3.fromRGB(55, 33, 108),
	0,
	-2,
	nil
}, {
	Enum.Material.Neon,
	Color3.fromRGB(81, 21, 166),
	0,
	0,
	nil
})
v122("Legendary", "Devourer", {
	Enum.Material.SmoothPlastic,
	Color3.fromRGB(82, 84, 111),
	0,
	0,
	"Devourer1"
}, {
	Enum.Material.Neon,
	Color3.fromRGB(159, 95, 175),
	0,
	0,
	"Devourer2"
}, {
	Enum.Material.Neon,
	Color3.fromRGB(171, 108, 175),
	0,
	0,
	nil
})
v122("Legendary", "Bee", {
	"Bee",
	Color3.fromRGB(255, 217, 103),
	0,
	0,
	"Bee1"
}, {
	Enum.Material.SmoothPlastic,
	Color3.fromRGB(42, 38, 16),
	0,
	0,
	nil
}, {
	"BeeWing",
	Color3.fromRGB(152, 194, 219),
	0.4,
	0,
	nil
})
v122("Legendary", "Mint Choco Chip", {
	Enum.Material.SmoothPlastic,
	Color3.fromRGB(225, 255, 164),
	0,
	0,
	"MintChocoChip1"
}, {
	Enum.Material.SmoothPlastic,
	Color3.fromRGB(48, 40, 31),
	0,
	0,
	nil
}, {
	Enum.Material.SmoothPlastic,
	Color3.fromRGB(225, 255, 164),
	0,
	0,
	nil
})
v122("Legendary", "Necromancer", {
	Enum.Material.SmoothPlastic,
	Color3.fromRGB(27, 42, 53),
	0,
	0,
	"Necromancer1"
}, {
	"NecromancerGlossy",
	Color3.fromRGB(48, 52, 80),
	0,
	0,
	"Necromancer2"
}, {
	Enum.Material.Glass,
	Color3.fromRGB(98, 78, 151),
	0.5,
	0,
	nil
}, nil, "Used to be purchased from the Shop")
v122("Legendary", "Stocking Fur", {
	Enum.Material.Sand,
	Color3.fromRGB(151, 0, 0),
	0,
	0,
	"Stocking_1"
}, {
	"StockingFur",
	Color3.fromRGB(234, 242, 255),
	0,
	0,
	nil
}, {
	Enum.Material.Snow,
	Color3.fromRGB(31, 31, 31),
	0,
	0,
	nil
}, nil, "Used to be purchased from the Shop")
v122("Legendary", "Luxe", {
	Enum.Material.Metal,
	Color3.fromRGB(255, 211, 161),
	0,
	0,
	"Luxe_1"
}, {
	Enum.Material.Neon,
	Color3.fromRGB(184, 154, 121),
	0,
	0,
	"Luxe_2"
}, {
	Enum.Material.Neon,
	Color3.fromRGB(171, 149, 125),
	0,
	0,
	nil
})
v122("Legendary", "Peril", {
	"Peril",
	Color3.fromRGB(34, 255, 167),
	0,
	0,
	"Peril1"
}, {
	"Peril",
	Color3.fromRGB(37, 158, 116),
	0,
	0,
	"Peril2"
}, {
	Enum.Material.SmoothPlastic,
	Color3.fromRGB(66, 255, 170),
	0.33,
	0.4,
	nil
})
v122("Legendary", "Wintry", {
	Enum.Material.Glass,
	Color3.fromRGB(210, 249, 255),
	0.3,
	0,
	"Wintry_1"
}, {
	Enum.Material.Glacier,
	Color3.fromRGB(248, 248, 248),
	0,
	0,
	"Wintry_2"
}, {
	Enum.Material.Neon,
	Color3.fromRGB(138, 155, 162),
	0,
	0,
	nil
})
v122("Legendary", "Plaid Pajama", {
	"PajamaFur",
	Color3.fromRGB(180, 23, 23),
	0,
	0,
	"Plaid_Pajama_1"
}, {
	Enum.Material.Granite,
	Color3.fromRGB(17, 17, 17),
	0,
	0,
	nil
}, {
	Enum.Material.SmoothPlastic,
	Color3.fromRGB(113, 15, 15),
	0,
	0,
	nil
})
v122("Legendary", "Candlelight", {
	Enum.Material.SmoothPlastic,
	Color3.fromRGB(254, 249, 219),
	0,
	0,
	"Candle_1"
}, {
	"CandyGlossy",
	Color3.fromRGB(255, 179, 103),
	0,
	0,
	"Candle_2"
}, {
	Enum.Material.Neon,
	Color3.fromRGB(181, 149, 117),
	0,
	0,
	nil
})
v122("Legendary", "Red Rubber", {
	"Balloon",
	Color3.fromRGB(117, 0, 0),
	0,
	0,
	nil
}, {
	"Balloon",
	Color3.fromRGB(86, 0, 0),
	0,
	0,
	nil
}, {
	Enum.Material.Glass,
	Color3.fromRGB(65, 0, 0),
	0,
	-0.75,
	nil
})
v122("Legendary", "Clovers", {
	Enum.Material.Foil,
	Color3.fromRGB(107, 191, 94),
	0,
	0,
	"Clovers_1"
}, {
	"CloverWrappingPearlescent",
	Color3.fromRGB(39, 79, 32),
	0,
	0,
	"Clovers_2"
}, {
	"CloverWrappingPearlescent",
	Color3.fromRGB(91, 165, 78),
	0,
	0,
	nil
})
v122("Legendary", "Heirloom", {
	"AncientRelicBone1",
	Color3.fromRGB(255, 238, 170),
	0,
	0,
	"Ancient_Relic_1"
}, {
	Enum.Material.Metal,
	Color3.fromRGB(239, 179, 118),
	0,
	0,
	"Ancient_Relic_2"
}, {
	Enum.Material.Neon,
	Color3.fromRGB(179, 161, 119),
	0,
	0,
	nil
})
v122("Legendary", "Mossy Stone", {
	Enum.Material.Cobblestone,
	Color3.fromRGB(67, 74, 83),
	0,
	0,
	"Mossy_Stone_1"
}, {
	Enum.Material.SmoothPlastic,
	Color3.fromRGB(28, 42, 21),
	0,
	0,
	"Mossy_Stone_2"
}, {
	Enum.Material.SmoothPlastic,
	Color3.fromRGB(68, 104, 45),
	0,
	0,
	nil
})
v122("Legendary", "Quartz", {
	"Quartz",
	Color3.fromRGB(163, 157, 154),
	0,
	0,
	"Quartz_1"
}, {
	Enum.Material.Glass,
	Color3.fromRGB(163, 138, 126),
	0.2,
	0,
	nil
}, {
	Enum.Material.SmoothPlastic,
	Color3.fromRGB(163, 145, 139),
	0,
	0,
	nil
})
v122("Legendary", "Lucid Halftone", {
	Enum.Material.Neon,
	Color3.fromRGB(177, 167, 255),
	0,
	0,
	"Cool_Halftone_1"
}, {
	Enum.Material.Metal,
	Color3.fromRGB(255, 89, 89),
	0,
	0,
	"Cool_Halftone_2"
}, {
	Enum.Material.Neon,
	Color3.fromRGB(92, 82, 172),
	0,
	0,
	nil
}, nil, "Used to be purchased from the Shop")
v122("Legendary", "Shadow Halftone", {
	Enum.Material.Neon,
	Color3.fromRGB(177, 167, 255),
	0,
	0,
	"Warm_Halftone_1"
}, {
	Enum.Material.Metal,
	Color3.fromRGB(255, 89, 89),
	0,
	0,
	"Warm_Halftone_2"
}, {
	Enum.Material.Neon,
	Color3.fromRGB(197, 108, 170),
	0,
	0,
	nil
}, nil, "Used to be purchased from the Shop")
v122("Legendary", "Fame Stars", {
	"RobloxMarble",
	Color3.fromRGB(62, 62, 71),
	0,
	0,
	"Fame_Stars_1"
}, {
	Enum.Material.Metal,
	Color3.fromRGB(113, 83, 56),
	0,
	0,
	"Fame_Stars_2"
}, {
	Enum.Material.Neon,
	Color3.fromRGB(166, 135, 97),
	0,
	0,
	nil
})
v122("Legendary", "Popcorn", {
	Enum.Material.SmoothPlastic,
	Color3.fromRGB(240, 240, 240),
	0,
	0,
	"Popcorn_1"
}, {
	"Popcorn",
	Color3.fromRGB(254, 233, 155),
	0,
	0,
	"Popcorn_2"
}, {
	Enum.Material.SmoothPlastic,
	Color3.fromRGB(254, 233, 155),
	0,
	0,
	nil
})
v122("Legendary", "Popsicle", {
	"CandyGlossy",
	Color3.fromRGB(248, 138, 186),
	0,
	0,
	"Popsicle_1"
}, {
	"CandyGlossy",
	Color3.fromRGB(149, 72, 128),
	0,
	0,
	nil
}, {
	"PopsicleStick",
	Color3.fromRGB(226, 173, 136),
	0,
	0,
	nil
})
v122("Legendary", "Sea Glass", {
	Enum.Material.Glass,
	Color3.fromRGB(11, 255, 206),
	0.15,
	0,
	"Sea_Glass_1"
}, {
	Enum.Material.Glass,
	Color3.fromRGB(16, 120, 255),
	0.15,
	0,
	"Sea_Glass_2"
}, {
	Enum.Material.Glass,
	Color3.fromRGB(87, 255, 241),
	0.25,
	0,
	"Sea_Glass_3"
}, nil, "Used to be purchased from the Shop")
v122("Legendary", "Heatwave", {
	Enum.Material.Neon,
	Color3.fromRGB(165, 106, 54),
	0,
	0,
	"Heatwave_1"
}, {
	Enum.Material.Neon,
	Color3.fromRGB(150, 85, 55),
	0,
	0,
	"Heatwave_2"
}, {
	Enum.Material.Neon,
	Color3.fromRGB(173, 111, 75),
	0,
	0,
	"Heatwave_3"
}, nil, "Used to be purchased from the Shop")
v122("Legendary", "Synthwave", {
	Enum.Material.Neon,
	Color3.fromRGB(43, 0, 76),
	0,
	0,
	"Vaporwave_Sunset_1"
}, {
	Enum.Material.Neon,
	Color3.fromRGB(22, 0, 76),
	0,
	0,
	"Vaporwave_Sunset_2"
}, {
	Enum.Material.Neon,
	Color3.fromRGB(68, 28, 125),
	0,
	0,
	"Vaporwave_Sunset_3"
}, nil, "Used to be purchased from the Shop")
v122("Legendary", "Pearlescent", {
	"Pearlescent_01a",
	Color3.fromRGB(255, 233, 247),
	0,
	0,
	nil,
	"Pearlescent"
}, {
	"Pearlescent_01b",
	Color3.fromRGB(255, 215, 241),
	0,
	0,
	"Pearlescent_2",
	"Pearlescent"
}, {
	Enum.Material.Neon,
	Color3.fromRGB(163, 142, 156),
	0,
	0,
	nil,
	"Pearlescent"
}, nil, "Included in Pearl Bundles")
v122("Legendary", "Fish Scales", {
	"FishScales",
	Color3.fromRGB(50, 92, 99),
	0,
	0,
	nil,
	"Fish Scales"
}, {
	"FishScales",
	Color3.fromRGB(34, 56, 58),
	0,
	0,
	nil,
	"Fish Scales"
}, {
	nil,
	Color3.fromRGB(68, 147, 156),
	0,
	0,
	nil,
	"Fish Scales"
})
v122("Legendary", "Overseer", {
	Enum.Material.SmoothPlastic,
	Color3.fromRGB(0, 0, 0),
	0,
	0,
	"Overseer_1"
}, {
	"OverseerCrystal",
	Color3.fromRGB(0, 255, 89),
	0,
	0,
	"Overseer_2"
}, {
	Enum.Material.Neon,
	Color3.fromRGB(85, 167, 112),
	0,
	0,
	nil
}, nil, "Used to be purchased from the Shop")
v122("Legendary", "Splattered", {
	nil,
	nil,
	0,
	0,
	"Splattered_1"
}, {
	nil,
	nil,
	0,
	0,
	"Splattered_2"
}, {
	nil,
	nil,
	0,
	0,
	nil
}, nil, "Used to be purchased from the Shop")
v122("Legendary", "Nightmare", {
	"Nightmare",
	Color3.fromRGB(173, 0, 0),
	0,
	0,
	"Nightmare_1"
}, {
	"Beryl",
	Color3.fromRGB(12, 0, 0),
	0,
	0,
	"Nightmare_2"
}, {
	Enum.Material.Neon,
	Color3.fromRGB(162, 44, 44),
	0,
	0,
	nil
}, nil, "Used to be purchased from the Shop")
v122("Legendary", "Brewery", {
	Enum.Material.Neon,
	Color3.fromRGB(94, 154, 70),
	0,
	0,
	"Brewery_1"
}, {
	Enum.Material.Neon,
	Color3.fromRGB(43, 84, 70),
	0,
	0,
	"Brewery_2"
}, {
	Enum.Material.Neon,
	Color3.fromRGB(129, 163, 93),
	0,
	0,
	nil
}, nil, "Used to be purchased from the Shop")
v122("Legendary", "Ravensoul", {
	Enum.Material.SmoothPlastic,
	Color3.fromRGB(80, 66, 86),
	0,
	0,
	"Ravensoul_1"
}, {
	"Aegis",
	Color3.fromRGB(55, 49, 58),
	0,
	0,
	"Ravensoul_2"
}, {
	Enum.Material.Neon,
	Color3.fromRGB(147, 125, 166),
	0,
	0,
	nil
}, nil, "Used to be purchased from the Shop")
v122("Legendary", "Black Iron", {
	"BlackIron",
	Color3.fromRGB(33, 33, 33),
	0,
	0,
	"Black_Iron_1"
}, {
	"BlackIronMetal",
	Color3.fromRGB(255, 255, 255),
	0,
	0,
	"Black_Iron_2"
}, {
	Enum.Material.Neon,
	Color3.fromRGB(164, 164, 164),
	0,
	0,
	nil
})
v122("Legendary", "Signature Red", {
	"Aegis",
	Color3.fromRGB(97, 16, 16),
	0,
	0,
	"Signature_Red_1"
}, {
	"Aegis",
	Color3.fromRGB(154, 0, 0),
	0,
	0,
	"Signature_Red_2"
}, {
	Enum.Material.Neon,
	Color3.fromRGB(172, 62, 62),
	0,
	0,
	nil
})
v122("Legendary", "Fall Camo", {
	Enum.Material.Plaster,
	Color3.fromRGB(166, 70, 10),
	0,
	0,
	"Fall_Camo_1"
}, {
	Enum.Material.Plaster,
	Color3.fromRGB(81, 31, 10),
	0,
	0,
	"Fall_Camo_2"
}, {
	nil,
	Color3.fromRGB(165, 124, 37),
	0,
	0,
	nil
}, nil, "Purchased from the Shop")
v122("Legendary", "Nuclear Damascus", {
	Enum.Material.Glass,
	Color3.fromRGB(140, 255, 0),
	0,
	-10,
	"Nuclear_Damascus_1"
}, {
	Enum.Material.Glass,
	Color3.fromRGB(0, 0, 0),
	0,
	0,
	nil
}, {
	Enum.Material.Neon,
	Color3.fromRGB(146, 169, 64),
	0,
	0,
	nil
}, nil, "Purchased from the Shop")
v122("Legendary", "Aqua Sparkle", {
	Enum.Material.Neon,
	Color3.fromRGB(137, 251, 255),
	0,
	0,
	"Aqua_Sparkle_1"
}, {
	Enum.Material.Neon,
	Color3.fromRGB(0, 117, 84),
	0,
	0,
	"Aqua_Sparkle_2"
}, {
	Enum.Material.Neon,
	Color3.fromRGB(90, 161, 142),
	0,
	0,
	nil
})
v122("Legendary", "Starfire", {
	Enum.Material.Neon,
	Color3.fromRGB(128, 168, 182),
	0,
	0,
	"Starfire_1"
}, {
	Enum.Material.Glass,
	Color3.fromRGB(62, 21, 91),
	0,
	0,
	nil
}, {
	Enum.Material.Neon,
	Color3.fromRGB(162, 105, 166),
	0,
	0,
	nil
})
v122("Legendary", "Clashing", {
	"RainbowOil",
	Color3.fromRGB(255, 255, 255),
	0,
	0,
	nil
}, {
	"RainbowOil2",
	Color3.fromRGB(53, 47, 57),
	0,
	0,
	nil
}, {
	Enum.Material.Neon,
	Color3.fromRGB(138, 100, 165),
	0,
	0,
	nil
})
v122("Mythical", "Dark Matter", {
	"CandyGlossy",
	Color3.fromRGB(129, 107, 255),
	0,
	0,
	"DarkMatter1",
	"Dark Matter"
}, {
	"CandyGlossy",
	Color3.fromRGB(129, 107, 255),
	0,
	0,
	"DarkMatter2",
	"Dark Matter"
}, {
	Enum.Material.Neon,
	Color3.fromRGB(142, 98, 238),
	0,
	0,
	"DarkMatter3",
	"Dark Matter"
}, nil, "Earned from weapon contracts", "Earned from a weapon contract for this weapon")
v122("Mythical", "Neon Lights", {
	Enum.Material.SmoothPlastic,
	Color3.fromRGB(42, 46, 49),
	0,
	0,
	"NeonLights1",
	"Neon Lights"
}, {
	Enum.Material.Neon,
	Color3.fromRGB(21, 0, 65),
	0,
	0,
	nil
}, {
	Enum.Material.Neon,
	Color3.fromRGB(125, 111, 165),
	0,
	0,
	nil
})
v122("Mythical", "Solar", {
	Enum.Material.SmoothPlastic,
	Color3.fromRGB(98, 15, 0),
	0,
	0,
	"Solar1",
	"Solar"
}, {
	Enum.Material.SmoothPlastic,
	Color3.fromRGB(120, 52, 21),
	0,
	0,
	"Solar2",
	"Solar"
}, {
	Enum.Material.Neon,
	Color3.fromRGB(168, 116, 78),
	0,
	0,
	nil
})
v122("Mythical", "Speed", {
	Enum.Material.SmoothPlastic,
	Color3.fromRGB(255, 255, 255),
	0,
	0,
	"Speed2",
	"Speed"
}, {
	Enum.Material.SmoothPlastic,
	Color3.fromRGB(255, 255, 255),
	0,
	0,
	nil
}, {
	Enum.Material.Neon,
	Color3.fromRGB(161, 105, 73),
	0,
	0,
	nil
})
v122("Mythical", "Celestial", {
	Enum.Material.Glass,
	Color3.fromRGB(0, 32, 96),
	0.25,
	0,
	"Celestial",
	"Celestial"
}, {
	Enum.Material.Metal,
	Color3.fromRGB(110, 116, 141),
	0,
	0,
	nil
}, {
	Enum.Material.Neon,
	Color3.fromRGB(77, 114, 173),
	0,
	0,
	nil
}, nil, "Earned by completing your Daily Tasks with a 7 day Task Streak")
v122("Mythical", "Encroached", {
	Enum.Material.Neon,
	Color3.fromRGB(96, 92, 209),
	0,
	0,
	"Encroached1",
	"Encroached"
}, {
	Enum.Material.Metal,
	Color3.fromRGB(91, 93, 163),
	0,
	0,
	"Encroached2"
}, {
	Enum.Material.Neon,
	Color3.fromRGB(106, 101, 231),
	0,
	0,
	nil
})
v122("Mythical", "Fracture", {
	Enum.Material.Neon,
	Color3.fromRGB(105, 226, 161),
	0,
	0,
	"Fracture1",
	"Fracture"
}, {
	Enum.Material.Metal,
	Color3.fromRGB(0, 0, 0),
	0,
	0,
	"Fracture2"
}, {
	Enum.Material.Neon,
	Color3.fromRGB(114, 255, 180),
	0.5,
	0,
	nil
})
v122("Mythical", "Aegis", {
	"Aegis",
	Color3.fromRGB(134, 207, 255),
	0,
	0,
	"Aegis1",
	"Aegis"
}, {
	Enum.Material.Metal,
	Color3.fromRGB(239, 184, 56),
	0,
	0,
	"Aegis2"
}, {
	Enum.Material.Neon,
	Color3.fromRGB(255, 160, 116),
	0,
	0,
	nil
})
v122("Mythical", "Soul Scourge", {
	Enum.Material.Neon,
	Color3.fromRGB(93, 179, 255),
	0,
	0,
	"SoulScourge1",
	"Soul Scourge"
}, {
	Enum.Material.Metal,
	Color3.fromRGB(18, 42, 48),
	0,
	0,
	"SoulScourge2"
}, {
	Enum.Material.SmoothPlastic,
	Color3.fromRGB(84, 241, 255),
	0.5,
	0.5,
	nil
})
v122("Mythical", "Blizzard", {
	Enum.Material.SmoothPlastic,
	Color3.fromRGB(210, 234, 255),
	0,
	0.1,
	"Blizzard_1",
	"Blizzard"
}, {
	"WrappingPearlescent",
	Color3.fromRGB(179, 199, 221),
	0,
	0,
	nil
}, {
	Enum.Material.Neon,
	Color3.fromRGB(140, 153, 162),
	0,
	0,
	nil
})
v122("Mythical", "Festive Lights", {
	Enum.Material.Glass,
	Color3.fromRGB(17, 17, 17),
	0,
	0,
	"Festive_Lights_1",
	"Festive Lights"
}, {
	Enum.Material.SmoothPlastic,
	Color3.fromRGB(248, 248, 248),
	0,
	0,
	"Festive_Lights_2",
	"Festive Lights"
}, {
	Enum.Material.Glass,
	Color3.fromRGB(54, 54, 54),
	0.1,
	0,
	nil
})
v122("Mythical", "Ice Queen", {
	Enum.Material.Neon,
	Color3.fromRGB(102, 142, 162),
	0,
	0,
	"Ice_Queen_1",
	"Ice Queen"
}, {
	Enum.Material.Glass,
	Color3.fromRGB(102, 190, 203),
	0,
	-3,
	nil
}, {
	Enum.Material.Neon,
	Color3.fromRGB(123, 174, 207),
	0.2,
	0,
	nil
})
v122("Mythical", "Borealis", {
	Enum.Material.Neon,
	Color3.fromRGB(0, 0, 255),
	0,
	0,
	"Borealis_1",
	"Borealis"
}, {
	Enum.Material.SmoothPlastic,
	Color3.fromRGB(17, 17, 17),
	0,
	0.05,
	nil
}, {
	Enum.Material.Neon,
	Color3.fromRGB(75, 181, 105),
	0,
	0,
	nil
})
v122("Mythical", "Polaris", {
	Enum.Material.Neon,
	Color3.fromRGB(55, 108, 168),
	0,
	0,
	"Polaris_1",
	"Polaris"
}, {
	Enum.Material.Metal,
	Color3.fromRGB(17, 21, 52),
	0,
	0,
	"Polaris_2"
}, {
	Enum.Material.Neon,
	Color3.fromRGB(113, 101, 209),
	0.2,
	0,
	"Polaris_3"
}, nil, "Included in the 2025 Festive Flash Sale")
v122("Mythical", "Heartfelt", {
	Enum.Material.Neon,
	Color3.fromRGB(167, 90, 149),
	0,
	0,
	"Heartfelt1",
	"Heartfelt"
}, {
	"Heartfelt1",
	Color3.fromRGB(121, 25, 75),
	0,
	0,
	"Heartfelt2"
}, {
	Enum.Material.Neon,
	Color3.fromRGB(216, 97, 145),
	0,
	0,
	nil
})
v122("Mythical", "The Heights", {
	"WrappingPearlescent",
	Color3.fromRGB(106, 57, 9),
	0,
	0,
	"SFOTH_1",
	"The Heights"
}, {
	"WrappingPearlescent",
	Color3.fromRGB(196, 40, 28),
	0,
	0,
	"SFOTH_2"
}, {
	Enum.Material.Neon,
	Color3.fromRGB(172, 134, 72),
	0,
	0,
	"SFOTH_3"
})
v122("Mythical", "Orichalcum", {
	"WeirdPaint",
	Color3.fromRGB(255, 154, 53),
	0,
	0,
	"Orichalcum_1",
	"Orichalcum"
}, {
	Enum.Material.Metal,
	Color3.fromRGB(216, 150, 44),
	0,
	0,
	nil
}, {
	Enum.Material.Neon,
	Color3.fromRGB(168, 128, 73),
	0,
	0,
	nil
})
v122("Mythical", "Crime Scene", {
	"CrimeScene1",
	Color3.fromRGB(53, 56, 62),
	0,
	0,
	"Crime_Scene_1",
	"Crime Scene"
}, {
	Enum.Material.Metal,
	Color3.fromRGB(106, 114, 127),
	0,
	0,
	"Crime_Scene_2"
}, {
	Enum.Material.SmoothPlastic,
	Color3.fromRGB(232, 232, 232),
	0,
	0,
	nil,
	"Crime Scene"
})
v122("Mythical", "TV Error", {
	Enum.Material.Neon,
	Color3.fromRGB(17, 17, 17),
	0,
	0,
	"TV_Error_1"
}, {
	Enum.Material.Neon,
	Color3.fromRGB(17, 17, 17),
	0,
	0,
	"TV_Error_2",
	"TV Error"
}, {
	Enum.Material.Neon,
	Color3.fromRGB(0, 0, 0),
	0,
	0,
	nil
})
v122("Mythical", "Paparazzi", {
	"CarpetNoise",
	Color3.fromRGB(7, 9, 30),
	0,
	0,
	"Paparazzi_1",
	"Paparazzi"
}, {
	Enum.Material.Metal,
	Color3.fromRGB(24, 24, 59),
	0,
	0,
	"Paparazzi_2",
	"Paparazzi"
}, {
	Enum.Material.Neon,
	Color3.fromRGB(155, 158, 168),
	0,
	0,
	nil,
	"Paparazzi"
})
v122("Mythical", "Tidal", {
	"RobloxSand",
	Color3.fromRGB(188, 160, 103),
	0,
	0,
	"Tidal_1",
	"Tidal"
}, {
	Enum.Material.SmoothPlastic,
	Color3.fromRGB(69, 137, 161),
	0,
	0.1,
	"Tidal_2",
	"Tidal"
}, {
	Enum.Material.Neon,
	Color3.fromRGB(109, 150, 168),
	0,
	0,
	nil
})
v122("Mythical", "Dutchman", {
	Enum.Material.Neon,
	Color3.fromRGB(89, 171, 123),
	0.9,
	0,
	"Dutchman_1",
	"Dutchman"
}, {
	Enum.Material.Neon,
	Color3.fromRGB(22, 53, 36),
	0,
	0,
	"Dutchman_2",
	"Dutchman"
}, {
	Enum.Material.Neon,
	Color3.fromRGB(89, 171, 123),
	0.15,
	0,
	"Dutchman_3",
	"Dutchman"
})
v122("Mythical", "Bat Flock", {
	Enum.Material.SmoothPlastic,
	Color3.fromRGB(0, 0, 0),
	0,
	0,
	"Batwinged_1",
	"Bat Flock"
}, {
	Enum.Material.Neon,
	Color3.fromRGB(0, 0, 0),
	0,
	0,
	"Batwinged_2"
}, {
	Enum.Material.Neon,
	Color3.fromRGB(116, 86, 176),
	0,
	0,
	nil
})
v122("Mythical", "Red Moon", {
	Enum.Material.SmoothPlastic,
	Color3.fromRGB(76, 35, 35),
	0,
	0,
	"Red_Moon_1",
	"Red Moon"
}, {
	Enum.Material.Metal,
	Color3.fromRGB(129, 65, 65),
	0,
	0,
	"Red_Moon_2"
}, {
	Enum.Material.Neon,
	Color3.fromRGB(170, 125, 131),
	0,
	0,
	nil
})
v122("Mythical", "Lustrous", {
	Enum.Material.SmoothPlastic,
	Color3.fromRGB(54, 52, 74),
	0,
	0,
	"Lustrous_1",
	"Lustrous"
}, {
	Enum.Material.Neon,
	Color3.fromRGB(17, 17, 17),
	0,
	0,
	"Lustrous_2",
	"Lustrous"
}, {
	Enum.Material.Neon,
	Color3.fromRGB(143, 121, 180),
	0,
	0,
	nil
})
v122("Genuine", "Rivalry", {
	"RivalryMaterial",
	Color3.fromRGB(126, 52, 255),
	0,
	0,
	"Rivalry2",
	"Rivalry"
}, {
	"RivalryMaterial",
	Color3.fromRGB(126, 52, 255),
	0,
	0,
	"Rivalry2",
	"Rivalry"
}, {
	"RivalryMaterial",
	Color3.fromRGB(126, 52, 255),
	0,
	0,
	"Rivalry2",
	"Rivalry"
}, true, "Given to team members of the group (Nosniy Games)")
v122("Genuine", "Scribble", {
	"ScribbleWrapping",
	Color3.fromRGB(248, 248, 248),
	0,
	0,
	"Scribble1",
	"Scribble"
}, {
	"ScribbleWrapping",
	Color3.fromRGB(17, 17, 17),
	0,
	0,
	"Scribble2",
	"Scribble"
}, {
	Enum.Material.Neon,
	Color3.fromRGB(0, 0, 0),
	0,
	0,
	nil
}, true, "Obtained by submitting a concept that makes it into the game (RIVALS)")
v122("Genuine", "Net", {
	Enum.Material.SmoothPlastic,
	Color3.fromRGB(255, 255, 255),
	0.75,
	0,
	"Net1",
	nil
}, {
	Enum.Material.SmoothPlastic,
	Color3.fromRGB(165, 114, 55),
	0,
	0,
	"Net2"
}, {
	Enum.Material.SmoothPlastic,
	Color3.fromRGB(255, 255, 255),
	0.75,
	0,
	"Net3"
}, true, "Given to bug hunters, thank you for helping us improve the game (RIVALS)")
v122("Genuine", "Egg Fried Rice", {
	"EggFriedRice",
	Color3.fromRGB(216, 157, 91),
	0,
	0,
	"Egg_Fried_Rice_1"
}, {
	"EggFriedRice",
	Color3.fromRGB(165, 110, 63),
	0,
	0,
	nil
}, {
	Enum.Material.SmoothPlastic,
	Color3.fromRGB(185, 133, 78),
	0,
	0,
	nil
}, true, "are u telling me an egg fried this wrap")
v122("Genuine", "Only Six", {
	"K_Material",
	Color3.fromRGB(221, 199, 255),
	0.2,
	1,
	"K_Textures",
	"Only Six"
}, {
	Enum.Material.Glass,
	Color3.fromRGB(42, 42, 42),
	0.5,
	0,
	nil
}, {
	Enum.Material.Neon,
	Color3.fromRGB(159, 161, 172),
	0,
	0,
	nil
}, true, "Given to the winners of the tournament in the Ready, Set, Roblox Korea Event")
v122("Unobtainable", "MISSING_WRAP", {
	Enum.Material.SmoothPlastic,
	Color3.fromRGB(255, 0, 255),
	0,
	0,
	"MISSING_WRAP",
	nil
}, {
	Enum.Material.SmoothPlastic,
	Color3.fromRGB(0, 0, 0),
	0,
	0,
	nil
}, nil, true, "-- TODO: placeholder")
v122("Unobtainable", "Accretion", {
	Enum.Material.SmoothPlastic,
	Color3.fromRGB(149, 167, 248),
	0,
	0.4,
	nil,
	nil
}, {
	Enum.Material.Neon,
	Color3.fromRGB(0, 0, 0),
	0,
	0,
	"Accretion2"
}, {
	Enum.Material.Neon,
	Color3.fromRGB(0, 0, 0),
	0,
	0,
	"Accretion3"
}, true, "im like hey whats up hello")
v122("Unobtainable", "Eruption", {
	Enum.Material.Neon,
	Color3.fromRGB(255, 112, 69),
	0,
	0,
	"Eruption1",
	nil
}, {
	Enum.Material.Neon,
	Color3.fromRGB(218, 96, 9),
	0,
	0,
	"Eruption2"
}, {
	Enum.Material.Neon,
	Color3.fromRGB(168, 92, 69),
	0,
	0,
	nil
}, true, "RAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA")
v122("Unobtainable", "Ultrablue", {
	Enum.Material.SmoothPlastic,
	Color3.fromRGB(255, 213, 0),
	0,
	10,
	nil,
	nil
}, {
	Enum.Material.SmoothPlastic,
	Color3.fromRGB(255, 213, 0),
	0,
	10,
	nil
}, {
	Enum.Material.Glass,
	Color3.fromRGB(255, 255, 255),
	0.5,
	0,
	nil
}, true, "idk")
v122("Unobtainable", "Arcane", {
	Enum.Material.Neon,
	Color3.fromRGB(0, 0, 0),
	0,
	0,
	"Arcane1"
}, {
	Enum.Material.Neon,
	Color3.fromRGB(0, 0, 0),
	0,
	0,
	nil
}, {
	Enum.Material.Neon,
	Color3.fromRGB(95, 102, 176),
	0,
	0,
	nil
}, true, "i was forced to add this by a chicken")
v122("Unobtainable", "Invisible", {
	Enum.Material.Neon,
	Color3.fromRGB(0, 0, 0),
	1,
	0,
	nil
}, {
	Enum.Material.Neon,
	Color3.fromRGB(0, 0, 0),
	1,
	0,
	nil
}, {
	Enum.Material.Neon,
	Color3.fromRGB(0, 0, 0),
	1,
	0,
	nil
}, true, "i was forced to add this by a chicken")
v122("Unobtainable", "Limefire", {
	"LimefireMat",
	Color3.fromRGB(248, 248, 248),
	0,
	0,
	"Limefire1"
}, {
	"LimefireMat",
	Color3.fromRGB(248, 248, 248),
	0,
	0,
	"Limefire2"
}, {
	Enum.Material.Neon,
	Color3.fromRGB(97, 174, 81),
	0,
	0,
	nil
}, true, "i was forced to add this by a chicken")
v122("Unobtainable", "Peridot", {
	"PeridotMat",
	Color3.fromRGB(40, 127, 71),
	0,
	0,
	"Peridot1"
}, {
	"PeridotMat",
	Color3.fromRGB(40, 127, 71),
	0,
	0,
	"Peridot2"
}, {
	Enum.Material.Neon,
	Color3.fromRGB(114, 171, 90),
	0,
	0,
	nil
}, true, "i was forced to add this by a chicken")
v122("Unobtainable", "Pixel Light", {
	Enum.Material.Neon,
	Color3.fromRGB(255, 152, 220),
	0,
	1,
	"PixelLight1"
}, {
	Enum.Material.Neon,
	Color3.fromRGB(255, 152, 220),
	0,
	1,
	"PixelLight2"
}, {
	Enum.Material.Neon,
	Color3.fromRGB(217, 129, 188),
	0,
	0,
	nil
}, true, "i was forced to add this by a chicken")
v122("Unobtainable", "Ultra Zed", {
	Enum.Material.SmoothPlastic,
	Color3.fromRGB(206, 255, 255),
	0,
	10,
	nil
}, {
	Enum.Material.SmoothPlastic,
	Color3.fromRGB(206, 255, 255),
	0,
	10,
	"UltraZed2"
}, {
	Enum.Material.Glass,
	Color3.fromRGB(206, 255, 255),
	0,
	10,
	nil
}, true, "i was forced to add this by a chicken")
v122("Unobtainable", "Virus", {
	"VirusMat",
	Color3.fromRGB(204, 142, 105),
	0,
	0,
	"Virus1"
}, {
	Enum.Material.ForceField,
	Color3.fromRGB(17, 17, 17),
	0,
	0,
	"Virus2"
}, {
	Enum.Material.Neon,
	Color3.fromRGB(130, 179, 117),
	0,
	0,
	nil
}, true, "i was forced to add this by a chicken")
v122("Unobtainable", "Chromatic", {
	Enum.Material.Metal,
	Color3.fromRGB(0, 0, 0),
	0,
	0,
	"Chromatic_1",
	"Chromatic"
}, {
	Enum.Material.Neon,
	Color3.fromRGB(255, 255, 255),
	0,
	0,
	"Chromatic_2",
	"Chromatic"
}, {
	Enum.Material.Glass,
	Color3.fromRGB(248, 248, 248),
	0.25,
	0,
	nil,
	"Chromatic"
}, true, "idk")
v122("Unobtainable", "TV Static", {
	Enum.Material.Neon,
	Color3.fromRGB(17, 17, 17),
	0,
	0,
	"TV_Static_1",
	"TV Static"
}, {
	Enum.Material.Neon,
	Color3.fromRGB(17, 17, 17),
	0,
	0,
	"TV_Static_2",
	"TV Static"
}, {
	Enum.Material.Neon,
	Color3.fromRGB(0, 0, 0),
	0,
	0,
	nil
}, true, "tv error v2")
v_u_90("Charm", "Unique", "Day 1", nil, nil, nil, "Earned by redeeming a code when the game (RIVALS) released", nil, {})
v_u_90("Charm", "Unique", "100M Visits", nil, nil, nil, "Earned by redeeming a code when the game (RIVALS) reached 100,000,000 visits", nil, {})
v_u_90("Charm", "Unique", "Streamer Microphone", nil, nil, nil, "Earned by redeeming a special code", nil, {})
v_u_90("Charm", "Unique", "Frozen Gaming Chair", nil, nil, nil, "Earned by redeeming a special code", nil, {})
v_u_90("Charm", "Unique", "Gaming Headset", nil, nil, nil, "Earned by redeeming a special code", nil, {})
v_u_90("Charm", "Unique", "Nosniy Games", nil, nil, nil, "Join the group (Nosniy Games)", nil, {})
v_u_90("Charm", "Unique", "Shooting Star", nil, nil, nil, "Favorite the game (RIVALS)", nil, {})
v_u_90("Charm", "Unique", "RIVALS", nil, nil, nil, "Like the game (RIVALS)", nil, {})
v_u_90("Charm", "Unique", "Bell", nil, nil, nil, "Enable notifications for the game (RIVALS)", nil, {})
v_u_90("Charm", "Unique", "Mini Present", nil, nil, nil, "Earned during the 2024 Festive Event", nil, {})
v_u_90("Charm", "Unique", "3D Glasses", nil, nil, nil, "Earned by watching a quick video ad in the Shop", nil, {})
v_u_90("Charm", "Unique", "Bungeoppang", nil, nil, nil, "Earned by completing a special challenge during the release of the Bridge map", nil, {})
v_u_90("Charm", "Unique", "Hunt Token", nil, nil, nil, "Earned by completing the Roblox 2025 The Hunt: Mega Edition", nil, {})
v_u_90("Charm", "Unique", "Mega Token", nil, nil, nil, "Earned by finding the Mega Token in the Roblox 2025 The Hunt: Mega Edition", nil, {})
v_u_90("Charm", "Unique", "I Survived Season 0", nil, nil, nil, "Given to players affected by the 3,400+ ELO reset during Ranked Season 0", nil, {})
v_u_90("Charm", "Unique", "Season 0", nil, nil, nil, "Earned by playing Ranked Season 0", nil, {})
v_u_90("Charm", "Unique", "Season 1", nil, nil, nil, "Earned by playing Ranked Season 1", nil, {})
v_u_90("Charm", "Unique", "Season 2", nil, nil, nil, "Earned by playing Ranked Season 2", nil, {})
v_u_90("Charm", "Unique", "Season 3", nil, nil, nil, "Earned by playing Ranked Season 3", nil, {})
v_u_90("Charm", "Unique", "Season 4", nil, nil, nil, "Earned by playing Ranked Season 4", nil, {})
v_u_90("Charm", "Unique", "RIA25 Best Shooter", nil, nil, nil, "Earned by redeeming a code when the game (RIVALS) won the RIA25 Best Shooter award", nil, {})
v_u_90("Charm", "Unique", "RIA26 Best Shooter", nil, nil, nil, "Earned by redeeming a code when the game (RIVALS) won the RIA26 Best Shooter award", nil, {})
v_u_90("Charm", "Unique", "Fireplace", nil, nil, nil, "Earned from the 2025 Festive Event Advent Calendar", nil, {})
v_u_90("Charm", "Unique", "The Head of Sensei Bot", nil, nil, nil, "Earned by defeating the Sensei Bot simulation", nil, {})
v_u_90("Charm", "Unique", "The Head of Nosniy Bot", nil, nil, nil, "Earned by defeating the Nosniy Bot simulation", nil, {})
v_u_90("Charm", "Unique", "Roblox Plus", nil, nil, nil, "Earned by having an active Roblox Plus subscription", nil, {})
v_u_90("Charm", "Unique", "Nosniy", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Unique", "SenseiWarrior", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Unique", "nekoanims", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Unique", "Blizmid", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Unique", "Bandites", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Unique", "CarbonMeister", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Unique", "DV", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Unique", "oPixel", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Unique", "TanqR", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Unique", "BobbVX", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Unique", "MiniBloxia", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Unique", "enriquebruv", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Unique", "Chex", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Unique", "hoppy819", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Unique", "Hoopie", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Unique", "Kaye", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Unique", "Karful", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Unique", "Brian1KB", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Unique", "GreatGuyBoom", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Unique", "ShadowTrojan", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Unique", "Khayri", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Unique", "8sty", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Unique", "Applino", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Unique", "viecti", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Unique", "SharkTactics", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Unique", "D_reamz", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Unique", "atorix", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Unique", "philhood", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Unique", "Mud", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Unique", "KaiM", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Unique", "Darktru", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Unique", "Milo", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Unique", "elixir", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Unique", "Kashy", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Unique", "WE1RD", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Unique", "Cruz", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Unique", "Stefan", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Unique", "Mixedify", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Unique", "SlingshotBwai", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Unique", "TinyDude", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Unique", "Incublox", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Unique", "RODNY", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Common", "Hook", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Common", "Cookie", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Common", "Cupcake", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Common", "Ninja Star", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Common", "Lemon Slice", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Common", "Ship Wheel", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Common", "Star", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Common", "Heart", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Common", "Bowling Pin", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Common", "Life Buoy", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Common", "Cage", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Common", "Magnet", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Common", "Potted Cactus", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Common", "Potted Flower", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Common", "Fedora Stack", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Common", "Pawn", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Common", "Hammer", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Common", "Cog", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Common", "Dice", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Common", "Traffic Cone", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Common", "Bone", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Common", "Candy", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Common", "Candy Corn", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Common", "Cobweb", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Common", "Crystal", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Common", "Mini Candy Cane", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Common", "Ornament", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Common", "Mini Shining Star", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Common", "Snowflake", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Common", "Glory Coin", nil, nil, nil, "Purchased from the Ranked Shop", nil, {})
v_u_90("Charm", "Common", "Runes", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Common", "Rune Ring", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Common", "Armchair", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Common", "Table Lamp", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Common", "Spider", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Common", "Thorn Circle", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Common", "Witch Hat", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Common", "Chombie Head", nil, nil, nil, "Earned by escaping Zombie Tower", nil, {})
v_u_90("Charm", "Common", "Gargoyle Head", nil, nil, nil, "Earned by escaping Gargoyle Tower", nil, {})
v_u_90("Charm", "Common", "Snowflake Ring", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Common", "Firework", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Common", "Ice Cube", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Common", "Jolly Hat", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Common", "Elf Hat", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Common", "Peppermint Candy", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Common", "Snowman", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Common", "Happy Gingerbread", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Common", "Horseshoe", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Common", "Paparazzi Camera", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Common", "Ancient Stool", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Common", "Mini Beach Ball", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Common", "Flip Flop", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Common", "Snorkel Goggles", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Common", "Coconut", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Common", "Mini Starfish", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Common", "Watermelon Slice", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Common", "1st Birthday Cake", nil, nil, nil, "Earned from the 1st RIVALS Birthday Party", nil, {})
v_u_90("Charm", "Common", "2nd Birthday Cake", nil, nil, nil, "Earned from the 2nd RIVALS Birthday Party", nil, {})
v_u_90("Charm", "Common", "Season 3 Stomp", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Common", "Season 4 Stomp", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Common", "Arenabot", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Rare", "Blobfish", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Rare", "Pufferfish", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Rare", "Bitster", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Rare", "Mystery Block", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Rare", "Anvil", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Rare", "Basketball", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Rare", "Money Bag", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Rare", "Rubber Duck", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Rare", "10 Gallon Hat", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Rare", "UFO", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Rare", "Emoji: Weary", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Rare", "Chocolate Scoop", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Rare", "Rocket Ship", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Rare", "Hotdog", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Rare", "Moai", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Rare", "Golf Ball", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Rare", "Football", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Rare", "Tennis Ball", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Rare", "Rainbow", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Rare", "Potion", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Rare", "Caramel Apple", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Rare", "Devious Pumpkin", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Rare", "Gravestone", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Rare", "Festive Light", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Rare", "Hot Chocolate", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Rare", "Stocking", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Rare", "Mini Portal", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Rare", "Mini Unstable Portal", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Rare", "Melonkin", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Rare", "Candy Bucket", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Rare", "Jolly Chair", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Rare", "Snowflakes", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Rare", "Decorated Tree", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Rare", "Cactus Buddy", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Rare", "Fame Star", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Rare", "Money Duffle", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Rare", "Surfboard", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Rare", "Lemon Juice", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Rare", "Mini Flamingo Floatie", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Rare", "Sand Bucket", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Rare", "Rocket Popsicle", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Rare", "Hidden Pearl", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Rare", "Shady Fried Chicken", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Legendary", "Mini Ban Hammer", nil, nil, nil, "Included in the Classic Bundle", nil, {})
v_u_90("Charm", "Legendary", "Mini Disco Ball", nil, nil, nil, "Included in the Standard Weapons Bundle", nil, {})
v_u_90("Charm", "Legendary", "Alien Head", nil, nil, nil, "Included in the Exogun Bundle", nil, {})
v_u_90("Charm", "Legendary", "First Aid", nil, nil, nil, "Included in the Medkit Bundle", nil, {})
v_u_90("Charm", "Legendary", "Mini Key", nil, nil, nil, "Included in Key Bundles", nil, {})
v_u_90("Charm", "Legendary", "Emoji: Nauseated", nil, nil, nil, "Included in the Starter Bundle", nil, {})
v_u_90("Charm", "Legendary", "Explosion", nil, nil, nil, "Included in the Heavy Duty Bundle", nil, {})
v_u_90("Charm", "Legendary", "EZ", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Legendary", "Energy Cell", nil, nil, nil, "Included in the Energy Bundle", nil, {})
v_u_90("Charm", "Legendary", "Emoji: Nerd", nil, nil, nil, "Included in the RPG Bundle", nil, {})
v_u_90("Charm", "Legendary", "Skull", nil, nil, nil, "Used to be purchased from the Shop", nil, {})
v_u_90("Charm", "Legendary", "Cauldron", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Legendary", "Eyeclipse", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Legendary", "Frankenblob", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Legendary", "Skullgourd", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Legendary", "Dumbkin", nil, nil, nil, "Included in Candy Bundles", nil, {})
v_u_90("Charm", "Legendary", "Chillman", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Legendary", "Gingerbread Cat", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Legendary", "Wreath", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Legendary", "Jingle Bell", nil, nil, nil, "Used to be purchased from the Shop", nil, {})
v_u_90("Charm", "Legendary", "Mini Snowglobe", nil, nil, nil, "Included in Crystal Bundles", nil, {})
v_u_90("Charm", "Legendary", "Chibi Bow", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Legendary", "Chibi Burst Rifle", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Legendary", "Chibi Chainsaw", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Legendary", "Chibi Daggers", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Legendary", "Chibi Energy Pistols", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Legendary", "Chibi Exogun", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Legendary", "Chibi Fists", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Legendary", "Chibi Flamethrower", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Legendary", "Chibi Grenade", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Legendary", "Chibi Grenade Launcher", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Legendary", "Chibi Handgun", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Legendary", "Chibi Flare Gun", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Legendary", "Chibi Jump Pad", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Legendary", "Chibi Katana", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Legendary", "Chibi Knife", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Legendary", "Chibi Medkit", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Legendary", "Chibi Minigun", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Legendary", "Chibi Molotov", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Legendary", "Chibi Paintball Gun", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Legendary", "Chibi RPG", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Legendary", "Chibi Revolver", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Legendary", "Chibi Satchel", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Legendary", "Chibi Assault Rifle", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Legendary", "Chibi Scythe", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Legendary", "Chibi Shorty", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Legendary", "Chibi Shotgun", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Legendary", "Chibi Slingshot", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Legendary", "Chibi Smoke Grenade", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Legendary", "Chibi Subspace Tripmine", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Legendary", "Chibi Sniper", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Legendary", "Chibi Spray", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Legendary", "Chibi Trowel", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Legendary", "Chibi Uzi", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Legendary", "Chibi War Horn", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Legendary", "Chibi Battle Axe", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Legendary", "Chibi Crossbow", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Legendary", "Chibi Riot Shield", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Legendary", "Chibi Freeze Ray", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Legendary", "Chibi Energy Rifle", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Legendary", "Chibi Gunblade", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Legendary", "Chibi Flashbang", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Legendary", "Chibi Distortion", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Legendary", "Chibi Warper", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Legendary", "Chibi Warpstone", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Legendary", "Chibi Maul", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Legendary", "Chibi Permafrost", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Legendary", "Chibi Grappler", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Legendary", "Chibi Spear", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Legendary", "Chibi Wildcat", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Legendary", "Chibi Holodome", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Legendary", "Diorama Arena", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Legendary", "Diorama Crossroads", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Legendary", "Diorama Backrooms", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Legendary", "Diorama Battleground", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Legendary", "Diorama Big Arena", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Legendary", "Diorama Big Backrooms", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Legendary", "Diorama Big Crossroads", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Legendary", "Diorama Big Graveyard", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Legendary", "Diorama Big Onyx", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Legendary", "Diorama Big Splash", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Legendary", "Diorama Bridge", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Legendary", "Diorama Construction", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Legendary", "Diorama Docks", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Legendary", "Diorama Graveyard", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Legendary", "Diorama Onyx", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Legendary", "Diorama Playground", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Legendary", "Diorama Shooting Range", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Legendary", "Diorama Splash", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Legendary", "Diorama Station", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Legendary", "Diorama Dimension", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Legendary", "Diorama Village", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Legendary", "Diorama Iceberg", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Legendary", "Diorama Chess", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Legendary", "Diorama Big Station", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Legendary", "Diorama Westown", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Legendary", "Diorama Museum", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Legendary", "Diorama Studio", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Legendary", "Diorama Sandbox", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Legendary", "Emoji: Imp", nil, nil, nil, "Purchased from the Ranked Shop", nil, {})
v_u_90("Charm", "Legendary", "Keycard 3", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Legendary", "Warp Disc", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Legendary", "Ghost", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Legendary", "Black Cat", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Legendary", "Pumpkin Cat", nil, nil, nil, "Used to be purchased from the Shop", nil, {})
v_u_90("Charm", "Legendary", "Snowblob", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Legendary", "Gingerbread Man", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Legendary", "Yeti", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Legendary", "Cryo Capsule", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Legendary", "Penguin", nil, nil, nil, "Used to be purchased from the Shop", nil, {})
v_u_90("Charm", "Legendary", "Crystal Heart", nil, nil, nil, "Included in the 2025 Festive Flash Sale", nil, {})
v_u_90("Charm", "Legendary", "Balloon Dog", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Legendary", "Happy Home", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Legendary", "Pierced Heart", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Legendary", "Four-Leaf Clover", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Legendary", "Sneaker", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Legendary", "Box TV", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Legendary", "Duely Award", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Legendary", "Police Siren", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Legendary", "Shredding Artwork", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Legendary", "Soda Can", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Legendary", "Emoji: Hot", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Legendary", "Jellyfish", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Legendary", "Summer Cooler", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Legendary", "Sand Castle", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Legendary", "Shark", nil, nil, nil, "Used to be purchased from the Shop", nil, {})
v_u_90("Charm", "Legendary", "Shiny Pearl", nil, nil, nil, "Included in the Pearl Bundles", nil, {})
v_u_90("Charm", "Legendary", "Long Lost Treasure", nil, nil, nil, "Included in the Pirate Bundle", nil, {})
v_u_90("Charm", "Legendary", "Jerm", nil, nil, nil, "Used to be purchased from the Shop", nil, {})
v_u_90("Charm", "Legendary", "Bat Wing", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Legendary", "Redman", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Legendary", "Gothic Ring", nil, nil, nil, nil, nil, {})
v_u_90("Charm", "Genuine", "Team Crown", nil, nil, true, "Given to the winners of the tournament in the Ready, Set, Roblox Korea Event", nil, {})
v_u_90("Charm", "Genuine", "Alpha Coin", nil, nil, true, "Thanks for helping us test :3", nil, {})
v_u_90("Charm", "Genuine", "Coinbama", nil, nil, true, "Friends & Family", nil, {})
v_u_90("Charm", "Genuine", "Participation Trophy", nil, nil, true, "Given to participants of tournaments that are officially hosted, sponsored, endorsed, or recognized by the group (Nosniy Games)", nil, {})
v_u_90("Charm", "Unobtainable", "MISSING_CHARM", nil, nil, true, "-- TODO: placeholder", nil, {})
v_u_90("Finisher", "Unique", "Jolly Judgement", "rbxassetid://90321419599834", nil, nil, "Earned from the 2024 Festive Event Advent Calendar", nil, {})
v_u_90("Finisher", "Unique", "5B Visits", "rbxassetid://114699226490363", nil, nil, "Earned by redeeming a code when the game (RIVALS) reached 5,000,000,000 visits", nil, {})
v_u_90("Finisher", "Unique", "Director\'s Cut", "rbxassetid://103223520666152", nil, nil, "Earned by watching a quick video ad in the Shop", nil, {})
v_u_90("Finisher", "Unique", "Elfify", "rbxassetid://78997438310487", nil, nil, "Earned from the 2025 Festive Event Advent Calendar", nil, {})
v_u_90("Finisher", "Common", "Yoink", "rbxassetid://102829647142590", nil, nil, nil, nil, {})
v_u_90("Finisher", "Common", "Confetti", "rbxassetid://104741243211980", nil, nil, nil, nil, {})
v_u_90("Finisher", "Common", "Hacked", "rbxassetid://82426114825564", nil, nil, nil, nil, {})
v_u_90("Finisher", "Common", "Petrify", "rbxassetid://112332768984387", nil, nil, nil, nil, {})
v_u_90("Finisher", "Common", "Flop", "rbxassetid://96328091359909", nil, nil, nil, nil, {})
v_u_90("Finisher", "Common", "Toot", "rbxassetid://140560743648551", nil, nil, nil, nil, {})
v_u_90("Finisher", "Common", "Spooky Confetti", "rbxassetid://86811497624542", nil, nil, nil, nil, {})
v_u_90("Finisher", "Common", "Batsplosion", "rbxassetid://122057521256858", nil, nil, nil, nil, {})
v_u_90("Finisher", "Common", "Bite", "rbxassetid://82133383488216", nil, nil, nil, nil, {})
v_u_90("Finisher", "Common", "Festive Confetti", "rbxassetid://70544145329602", nil, nil, nil, nil, {})
v_u_90("Finisher", "Common", "Wrapped", "rbxassetid://72445331312364", nil, nil, nil, nil, {})
v_u_90("Finisher", "Common", "Delete", "rbxassetid://115854076287500", nil, nil, nil, nil, {})
v_u_90("Finisher", "Common", "Squawk", "rbxassetid://74088341062653", nil, nil, nil, nil, {})
v_u_90("Finisher", "Common", "Digitize", "rbxassetid://108813637747773", nil, nil, nil, nil, {})
v_u_90("Finisher", "Common", "Chalked", "rbxassetid://97485080586138", nil, nil, nil, nil, {})
v_u_90("Finisher", "Common", "Folded", "rbxassetid://77198370089806", nil, nil, nil, nil, {})
v_u_90("Finisher", "Common", "Very Tragic Banana Peel Accident", "rbxassetid://83991814770184", nil, nil, nil, nil, {})
v_u_90("Finisher", "Common", "For Glory", "rbxassetid://118264756096342", nil, nil, "Purchased from the Ranked Shop", nil, {})
v_u_90("Finisher", "Common", "Warped Away", "rbxassetid://77918264482510", nil, nil, nil, nil, {})
v_u_90("Finisher", "Common", "Blip", "rbxassetid://94841086478106", nil, nil, nil, nil, {})
v_u_90("Finisher", "Common", "Faceplant", "rbxassetid://88948574020907", nil, nil, nil, nil, {})
v_u_90("Finisher", "Common", "Northern Light Show", "rbxassetid://131193643081878", nil, nil, nil, nil, {})
v_u_90("Finisher", "Common", "Coalify", "rbxassetid://137288972288796", nil, nil, nil, nil, {})
v_u_90("Finisher", "Common", "Chill Out", "rbxassetid://128662396670227", nil, nil, nil, nil, {})
v_u_90("Finisher", "Common", "Paparazzi Flash", "rbxassetid://115459985337202", nil, nil, nil, nil, {})
v_u_90("Finisher", "Common", "Spotlight", "rbxassetid://115915796108003", nil, nil, nil, nil, {})
v_u_90("Finisher", "Common", "Sun Rays", "rbxassetid://83566863919981", nil, nil, nil, nil, {})
v_u_90("Finisher", "Common", "Water Balloons", "rbxassetid://125829428252147", nil, nil, nil, nil, {})
v_u_90("Finisher", "Common", "Sizzled", "rbxassetid://107854089679944", nil, nil, nil, nil, {})
v_u_90("Finisher", "Common", "Caked", "rbxassetid://131313620853228", nil, nil, "Earned from the 2nd RIVALS Birthday Party", nil, {})
v_u_90("Finisher", "Common", "Arenafy", "rbxassetid://120961180237707", nil, nil, nil, nil, {})
v_u_90("Finisher", "Rare", "Freeze", "rbxassetid://98529191510110", nil, nil, nil, nil, {})
v_u_90("Finisher", "Rare", "High Gravity", "rbxassetid://96732292347041", nil, nil, nil, nil, {})
v_u_90("Finisher", "Rare", "Collapse", "rbxassetid://73392477829194", nil, nil, nil, nil, {})
v_u_90("Finisher", "Rare", "Splatter", "rbxassetid://102973927915607", nil, nil, nil, nil, {})
v_u_90("Finisher", "Rare", "Tremble", "rbxassetid://95468028863260", nil, nil, nil, nil, {})
v_u_90("Finisher", "Rare", "Rush", "rbxassetid://126499829143959", nil, nil, nil, nil, {})
v_u_90("Finisher", "Rare", "Midas Touch", "rbxassetid://114357416172786", nil, nil, "Earned from weapon contracts", "Earned from a weapon contract for this weapon", {})
v_u_90("Finisher", "Rare", "Bonesplosion", "rbxassetid://130788066745511", nil, nil, nil, nil, {})
v_u_90("Finisher", "Rare", "Lost Soul", "rbxassetid://118248684115036", nil, nil, nil, nil, {})
v_u_90("Finisher", "Rare", "Reaper", "rbxassetid://127213865323328", nil, nil, nil, nil, {})
v_u_90("Finisher", "Rare", "Frozen", "rbxassetid://134114034173010", nil, nil, nil, nil, {})
v_u_90("Finisher", "Rare", "Gingerbreadify", "rbxassetid://139642060967648", nil, nil, nil, nil, {})
v_u_90("Finisher", "Rare", "Flick", "rbxassetid://91644072854680", nil, nil, nil, nil, {})
v_u_90("Finisher", "Rare", "Heavy Head", "rbxassetid://78860800597917", nil, nil, nil, nil, {})
v_u_90("Finisher", "Rare", "Bad Mood", "rbxassetid://99622848264737", nil, nil, nil, nil, {})
v_u_90("Finisher", "Rare", "Ascend", "rbxassetid://108671357927051", nil, nil, nil, nil, {})
v_u_90("Finisher", "Rare", "Roadrunner", "rbxassetid://123109101762106", nil, nil, nil, nil, {})
v_u_90("Finisher", "Rare", "Hooked", "rbxassetid://135161057713623", nil, nil, nil, nil, {})
v_u_90("Finisher", "Rare", "Bogey", "rbxassetid://78461567525312", nil, nil, nil, nil, {})
v_u_90("Finisher", "Rare", "Warp Sickness", "rbxassetid://95052578441962", nil, nil, nil, nil, {})
v_u_90("Finisher", "Rare", "Decorated Player", "rbxassetid://105447700906346", nil, nil, nil, nil, {})
v_u_90("Finisher", "Rare", "Snowmanify", "rbxassetid://86007852568653", nil, nil, nil, nil, {})
v_u_90("Finisher", "Rare", "Grapple Hooked", "rbxassetid://130558454147591", nil, nil, nil, nil, {})
v_u_90("Finisher", "Rare", "Curtain Call", "rbxassetid://98383652505998", nil, nil, nil, nil, {})
v_u_90("Finisher", "Rare", "Tumbleweed", "rbxassetid://107589458207197", nil, nil, nil, nil, {})
v_u_90("Finisher", "Rare", "Impact Frame", "rbxassetid://140448744575617", nil, nil, nil, nil, {})
v_u_90("Finisher", "Rare", "Rising Star", "rbxassetid://106582358983229", nil, nil, nil, nil, {})
v_u_90("Finisher", "Rare", "Swept Away", "rbxassetid://127179356644083", nil, nil, nil, nil, {})
v_u_90("Finisher", "Rare", "Kiddie Pool", "rbxassetid://118146142186862", nil, nil, nil, nil, {})
v_u_90("Finisher", "Rare", "Beach Day", "rbxassetid://135822676403654", nil, nil, nil, nil, {})
v_u_90("Finisher", "Legendary", "OOF", "rbxassetid://126776522933695", nil, nil, "Included in the Classic Bundle", nil, {})
v_u_90("Finisher", "Legendary", "Ignite", "rbxassetid://134442726960420", nil, nil, "Included in the Heavy Duty Bundle", nil, {})
v_u_90("Finisher", "Legendary", "Boogie", "rbxassetid://73791204303375", nil, nil, "Included in the Standard Weapons Bundle", nil, {})
v_u_90("Finisher", "Legendary", "Low Gravity", "rbxassetid://82935062788662", nil, nil, "Included in the Exogun Bundle", nil, {})
v_u_90("Finisher", "Legendary", "Stiff", "rbxassetid://115882469899440", nil, nil, "Included in the Starter Bundle", nil, {})
v_u_90("Finisher", "Legendary", "Heartbeat", "rbxassetid://87519063117594", nil, nil, "Included in the Medkit Bundle", nil, {})
v_u_90("Finisher", "Legendary", "Pixel Coins", "rbxassetid://92644850029616", nil, nil, nil, nil, {})
v_u_90("Finisher", "Legendary", "Beacon", "rbxassetid://98809320060817", nil, nil, "Included in the Energy Bundle", nil, {})
v_u_90("Finisher", "Legendary", "Erased", "rbxassetid://88556189232995", nil, nil, "Included in the RPG Bundle", nil, {})
v_u_90("Finisher", "Legendary", "Opulent", "rbxassetid://101696122903986", nil, nil, "Included in Key Bundles", nil, {})
v_u_90("Finisher", "Legendary", "Orbital Strike", "rbxassetid://109881673283194", nil, nil, nil, nil, {})
v_u_90("Finisher", "Legendary", "Tough Crowd", "rbxassetid://114669648248372", nil, nil, nil, nil, {})
v_u_90("Finisher", "Legendary", "BONK!", "rbxassetid://99051381910214", nil, nil, nil, nil, {})
v_u_90("Finisher", "Legendary", "Darkheart", "rbxassetid://108380782682249", nil, nil, nil, nil, {})
v_u_90("Finisher", "Legendary", "Balloons", "rbxassetid://136702616652550", nil, nil, nil, nil, {})
v_u_90("Finisher", "Legendary", "Electrocute", "rbxassetid://73752311595809", nil, nil, nil, nil, {})
v_u_90("Finisher", "Legendary", "Diamond Hands", "rbxassetid://82379000922589", nil, nil, "Earned from weapon contracts", "Earned from a weapon contract for this weapon", {})
v_u_90("Finisher", "Legendary", "RIP", "rbxassetid://125413876114976", nil, nil, "Used to be purchased from the Shop", nil, {})
v_u_90("Finisher", "Legendary", "Disintegrate", "rbxassetid://122124911858258", nil, nil, nil, nil, {})
v_u_90("Finisher", "Legendary", "Broom Ride", "rbxassetid://94004294239279", nil, nil, nil, nil, {})
v_u_90("Finisher", "Legendary", "Zombified", "rbxassetid://118642793984362", nil, nil, nil, nil, {})
v_u_90("Finisher", "Legendary", "DRIP", "rbxassetid://72617401862034", nil, nil, "Included in Candy Bundles", nil, {})
v_u_90("Finisher", "Legendary", "Snowballed", "rbxassetid://134500016062172", nil, nil, nil, nil, {})
v_u_90("Finisher", "Legendary", "David", "rbxassetid://118078924229498", nil, nil, nil, nil, {})
v_u_90("Finisher", "Legendary", "Giant Ice Spike", "rbxassetid://83215636937328", nil, nil, "Included in Crystal Bundles", nil, {})
v_u_90("Finisher", "Legendary", "Falling Icicles", "rbxassetid://110649955330233", nil, nil, "Used to be purchased from the Shop", nil, {})
v_u_90("Finisher", "Legendary", "Chark Attack", "rbxassetid://129157579936707", nil, nil, nil, nil, {})
v_u_90("Finisher", "Legendary", "GOOAAALLLL", "rbxassetid://84624379263977", nil, nil, nil, nil, {})
v_u_90("Finisher", "Legendary", "Crushed", "rbxassetid://106966455049956", nil, nil, nil, nil, {})
v_u_90("Finisher", "Legendary", "Clapped", "rbxassetid://123917282718123", nil, nil, nil, nil, {})
v_u_90("Finisher", "Legendary", "Enlightened", "rbxassetid://127327248433603", nil, nil, nil, nil, {})
v_u_90("Finisher", "Legendary", "Rainbow Barf", "rbxassetid://132045014783492", nil, nil, nil, nil, {})
v_u_90("Finisher", "Legendary", "Impaled", "rbxassetid://138149693939922", nil, nil, "Purchased from the Ranked Shop", nil, {})
v_u_90("Finisher", "Legendary", "Spaghettified", "rbxassetid://77679769061256", nil, nil, nil, nil, {})
v_u_90("Finisher", "Legendary", "Instability", "rbxassetid://106971261547575", nil, nil, nil, nil, {})
v_u_90("Finisher", "Legendary", "Those Who Know", "rbxassetid://87255165853264", nil, nil, "Used to be purchased from the Shop", nil, {})
v_u_90("Finisher", "Legendary", "Sleigh Away", "rbxassetid://77610232388349", nil, nil, "Used to be purchased from the Shop", nil, {})
v_u_90("Finisher", "Legendary", "Giant Snowball", "rbxassetid://133610440023169", nil, nil, nil, nil, {})
v_u_90("Finisher", "Legendary", "Firework Show", "rbxassetid://109941967577830", nil, nil, nil, nil, {})
v_u_90("Finisher", "Legendary", "Inflate", "rbxassetid://97761422504755", nil, nil, nil, nil, {})
v_u_90("Finisher", "Legendary", "Dematerialize", "rbxassetid://74226415965130", nil, nil, nil, nil, {})
v_u_90("Finisher", "Legendary", "Poof", "rbxassetid://113497644121357", nil, nil, nil, nil, {})
v_u_90("Finisher", "Legendary", "Leprechaunify", "rbxassetid://96845292635339", nil, nil, nil, nil, {})
v_u_90("Finisher", "Legendary", "Plushify", "rbxassetid://135472987617182", nil, nil, nil, nil, {})
v_u_90("Finisher", "Legendary", "BANG!", "rbxassetid://118036788686497", nil, nil, nil, nil, {})
v_u_90("Finisher", "Legendary", "Goofy Brawl", "rbxassetid://102633358539415", nil, nil, nil, nil, {})
v_u_90("Finisher", "Legendary", "Standing Ovation", "rbxassetid://72165736224034", nil, nil, nil, nil, {})
v_u_90("Finisher", "Legendary", "Whack A Mole", "rbxassetid://102591155581733", nil, nil, nil, nil, {})
v_u_90("Finisher", "Legendary", "Spectralized", "rbxassetid://120984959862618", nil, nil, nil, nil, {})
v_u_90("Finisher", "Legendary", "Loose Coconut", "rbxassetid://102463478300973", nil, nil, nil, nil, {})
v_u_90("Finisher", "Legendary", "Mow Them Down", "rbxassetid://99423466020720", nil, nil, nil, nil, {})
v_u_90("Finisher", "Legendary", "Bubble Ball", "rbxassetid://136356314854589", nil, nil, nil, nil, {})
v_u_90("Finisher", "Legendary", "Whirlpool", "rbxassetid://115769602518941", nil, nil, "Used to be purchased from the Shop", nil, {})
v_u_90("Finisher", "Legendary", "Clammed", "rbxassetid://125453394404112", nil, nil, "Included in Pearl Bundles", nil, {})
v_u_90("Finisher", "Legendary", "Acid Splash", "rbxassetid://89042508899765", nil, nil, "Used to be purchased from the Shop", nil, {})
v_u_90("Finisher", "Legendary", "Become Bat", "rbxassetid://99915163067284", nil, nil, nil, nil, {})
v_u_90("Finisher", "Legendary", "Redify", "rbxassetid://100958958765021", nil, nil, nil, nil, {})
v_u_90("Finisher", "Legendary", "Finial", "rbxassetid://125658198574245", nil, nil, nil, nil, {})
v_u_90("Finisher", "Unobtainable", "Ragdoll", "rbxassetid://131997354939473", nil, true, "Used internally when no finisher is equipped", nil, {})
v_u_90("Finisher", "Unobtainable", "Fall Apart", "rbxassetid://131997354939473", nil, true, "Used internally for skeleton deaths", nil, {})
v_u_90("Finisher", "Unobtainable", "Every Finisher Ever", "rbxassetid://131997354939473", nil, true, "play super golf", nil, {})
v_u_90("Finisher", "Unobtainable", "Bubblegum", "rbxassetid://95870163076585", nil, true, "data mining detected, you will be banned shortly", nil, {})
v_u_90("Finisher", "Unobtainable", "MISSING_FINISHER", "rbxassetid://112664260315062", nil, true, "-- TODO: placeholder", nil, {})
local function v132(p123, p124, p125, p126, p127, p128, p129, p130, p131) -- name: add_emote
	-- upvalues: (copy) v_u_90
	v_u_90("Emote", p123, p124, nil, nil, p128, p131, nil, {
		["IsAudioIntrusive"] = p125,
		["IsTraversal"] = p126 ~= nil,
		["TraversalWalkSpeedMultiplier"] = p126,
		["HideFootsteps"] = p127,
		["EmoteDescription"] = p130,
		["ViewportCFrameOffset"] = p129 or CFrame.identity
	})
end
v132("Unique", "RIA26 Best Studio", nil, nil, nil, nil, nil, nil, "Earned by redeeming a code when the group (Nosniy Games) won the RIA26 Best Studio award")
v132("Common", "Shoulder Brush", nil, nil, nil, nil, nil, "No big deal, man")
v132("Common", "Coo Coo", nil, nil, nil, nil, nil, "Someone\'s tilted")
v132("Common", "Denial", nil, nil, nil, nil, nil, "No, no, not me!")
v132("Common", "Facepalm", nil, nil, nil, nil, nil, "Are you serious right now?")
v132("Common", "Kneel", nil, nil, nil, nil, nil, "That was an honorable try")
v132("Common", "Agree", nil, nil, nil, nil, nil, "Yeah! Yeah!")
v132("Common", "Think", nil, nil, nil, nil, nil, "Think, " .. (v_u_4.IS_CLIENT and v3.LocalPlayer.Name or "Server") .. "!")
v132("Common", "Salty", nil, nil, nil, nil, nil, "If you weren\'t salty already, now you are!")
v132("Common", "AAAND.. CUT!")
v132("Common", "Standoff", true)
v132("Common", "Giant Camera")
v132("Common", "Yummy Cake", nil, nil, nil, nil, nil, nil, "Earned from the 2nd RIVALS Birthday Party")
v132("Common", "Knife Idle")
v132("Rare", "Superhero", true, nil, nil, nil, nil, "Nobody panic! I\'m here now")
v132("Rare", "Cream Cheese Honey", true, nil, nil, nil, nil, "It\'s cream cheese and honey sandwich time")
v132("Rare", "Smile", true, nil, nil, nil, nil, "What a joyful and whimsical day! =)")
v132("Rare", "Vegetable", true, nil)
v132("Rare", "Criss Cross", true, nil)
v132("Rare", "Side To Side", true, nil)
v132("Rare", "Off of You", true, nil)
v132("Rare", "Round & Round", true, nil)
v132("Rare", "Warpmaker", nil, nil, nil, nil, CFrame.Angles(0, 3.141592653589793, 0))
v132("Rare", "Shivering")
v132("Rare", "Horsey")
v132("Rare", "Bad Feeling", true)
v132("Legendary", "Take The L", true, nil, nil, nil, nil, "I promise not to be toxic")
v132("Legendary", "Selfie", nil, nil, nil, nil, nil, "But first..")
v132("Legendary", "Flex", nil, nil, nil, nil, nil, nil, "Purchased from the Ranked Shop")
v132("Legendary", "ROFL", nil, nil)
v132("Legendary", "Portal Glitch", nil, nil)
v132("Legendary", "Witch Waltz", nil, 0.5, true, nil, nil, nil, "Used to be purchased from the Shop")
v132("Legendary", "Sleigh Ride", nil, 0.5, true, nil, nil, nil, "Used to be purchased from the Shop")
v132("Legendary", "It\'s Time")
v132("Legendary", "New Year Sparklers")
v132("Legendary", "Whimsical", true, 0.5)
v132("Legendary", "Illumina Storm", nil, 0.5)
v132("Legendary", "Tango", true)
v132("Legendary", "Coin Block")
v132("Legendary", "Step Dancing", true)
v132("Legendary", "Busting A Move", true, 0.25)
v132("Legendary", "Tiptoe", nil, 0.5)
v132("Legendary", "Scoot", nil, 0.5)
v132("Legendary", "Police Car", nil, 0.5)
v132("Legendary", "Hollywoodin\'", true, nil)
v132("Legendary", "Bad Boy", true, nil)
v132("Legendary", "Old Timer", true, nil)
v132("Legendary", "Summer Days", true, nil)
v132("Legendary", "X Marks The Spot", nil, nil)
v132("Legendary", "Surfing", nil, 0.5, true, nil, nil, nil, "Used to be purchased from the Shop")
v132("Legendary", "Candy Dance", true, nil)
v132("Legendary", "Zombie Walk", nil, 0.5, nil, nil, nil, nil, "Used to be purchased from the Shop")
v132("Legendary", "Take Flight", nil, 0.5)
v132("Legendary", "Handgun Idle", nil, nil)
v132("Legendary", "Gothstar", true, nil)
v132("Unobtainable", "MISSING_EMOTE", nil, nil, nil, true, nil, "-- TODO: placeholder", "-- TODO: placeholder")
v132("Unobtainable", "Snow Angels", nil, nil, nil, true, nil, nil, "Environment emote")
v132("Unobtainable", "Runner", true, nil, nil, true)
v132("Unobtainable", "Stomp Stomp", true, nil, nil, true)
v132("Unobtainable", "Do That Thang", true, nil, nil, true)
local function v_u_143(p133, p134, p135, p136, p137, p138, p139) -- name: add_reward
	-- upvalues: (copy) v_u_64
	local v140 = {
		["Name"] = p134,
		["Type"] = p133,
		["Image"] = p137 or "",
		["ImageScale"] = p138 or 1,
		["DisplayName"] = p135,
		["DisplayNamePlural"] = p136
	}
	for v141, v142 in pairs(p139 or {}) do
		v140[v141] = v142
	end
	v_u_64.Rewards[p134] = v140
end
v_u_143("Custom", "Prime Season Pass", "Upgrade", "Upgrades", "rbxassetid://74965952714478", nil, {
	["PrioritizeNameOverQuantity"] = true,
	["BubbleTitle"] = "Prime Season Pass",
	["BubbleDescription"] = "Upgrades your Season Pass!",
	["NameStatus"] = nil
})
v_u_143("Custom", "Season Pass XP", "Pass XP", "Pass XP", "rbxassetid://139822751337484", nil, {
	["PrioritizeNameOverQuantity"] = false,
	["BubbleTitle"] = "Pass XP",
	["BubbleDescription"] = "Can level up your Season Pass!",
	["NameStatus"] = nil
})
v_u_143("Custom", "Season Pass Level", "Pass Level", "Pass Levels", "rbxassetid://140314292934986", nil, {
	["PrioritizeNameOverQuantity"] = false,
	["BubbleTitle"] = "Pass Levels",
	["BubbleDescription"] = "Levels up your Season Pass!",
	["NameStatus"] = nil
})
v_u_143("Custom", "Prime Nametag", "Shiny Name", "Shiny Name", "rbxassetid://100303529770645", nil, {
	["PrioritizeNameOverQuantity"] = true,
	["BubbleTitle"] = "Shiny Name",
	["BubbleDescription"] = "Makes your name shiny and gold!",
	["NameStatus"] = "Prime"
})
v_u_143("Custom", "Contraband Nametag", "Glitchy Name", "Glitchy Name", "rbxassetid://75221071226274", nil, {
	["PrioritizeNameOverQuantity"] = true,
	["BubbleTitle"] = "Glitchy Name",
	["BubbleDescription"] = "Makes your name glitchy and purple!",
	["NameStatus"] = "Contraband"
})
local function v148(p144, p145, p146) -- name: add_currency_reward
	-- upvalues: (copy) v_u_5, (copy) v_u_143
	local v147 = v_u_5.Info[p145]
	local _ = {
		["DataName"] = v147.DataName,
		["BubbleDescription"] = p146
	}
	v_u_143("Currency", p144, v147.DisplayName, v147.DisplayNamePlural, v147.Image, 1, {
		["DataName"] = v147.DataName,
		["BubbleDescription"] = p146
	})
end
v148("Key", "WeaponKeys", "Can unlock weapons!")
v148("Unlock Token", "UnlockTokens", "Can unlock weapons!")
v148("EventCurrency", "EventCurrency", "Only here for a limited time!")
v148("Glory", "Glory", "Earned by playing Ranked!")
v148("Skin Ticket", "SkinTickets", "Can purchase skin cases!")
local function v_u_173(p_u_149, p150, p151, p152, p153, p154, p_u_155, p156) -- name: add_lootbox
	-- upvalues: (copy) v_u_143, (copy) v_u_64, (copy) v_u_8, (copy) v_u_6
	v_u_143("Lootbox", p151, p151, p152, p154, nil, {
		["SmartRestrictionsEnabled"] = nil,
		["LootboxDescription"] = nil,
		["SoundProfile"] = nil,
		["GetContents"] = nil,
		["HasWeaponCosmetics"] = false,
		["SmartRestrictionsEnabled"] = not p150,
		["LootboxDescription"] = p156 or "Contains special items!",
		["SoundProfile"] = p153
	})
	local v157 = v_u_64.Rewards[p151]
	local v158 = v_u_64.LootboxOrder
	table.insert(v158, p151)
	function v157.GetContents(p159)
		-- upvalues: (ref) v_u_8, (copy) p_u_155, (copy) p_u_149, (ref) v_u_64
		local v160 = v_u_8:CloneTable(p_u_155)
		if not p_u_149 then
			v160 = {}
			for _, v161 in pairs(v160) do
				local v162 = {
					["Name"] = nil,
					["Quantity"] = 1,
					["Weapon"] = nil,
					["Name"] = v161,
					["Weapon"] = v_u_64.Cosmetics[v161] and v_u_64.Cosmetics[v161].ItemName or (v_u_64.Cosmetics[v161] and v_u_64.Types[v_u_64.Cosmetics[v161].Type].IsWeaponCosmetic and "IsRandom" or (v_u_64.Rewards[v161] and v_u_64.Rewards[v161].Type == "Lootbox" and "IsRandom" or nil))
				}
				table.insert(v160, {
					["Weight"] = 1,
					["Reward"] = nil,
					["Reward"] = v162
				})
			end
		end
		local v163 = 0
		for _, v164 in pairs(v160) do
			v163 = v163 + v164.Weight
			if not p159 or v164.Reward.Weapon ~= "IsRandom" then
				continue
			end
			v164.Reward.Weapon = p159
		end
		return v160, v163
	end
	local v165 = {}
	for _, v166 in pairs(v157.GetContents()) do
		local v167 = v166.Reward.Name
		if not p_u_149 then
			local v168 = not v165[v167]
			assert(v168, v167)
			v165[v167] = true
		end
		local v169 = v_u_64.Cosmetics[v167]
		local v170 = v_u_6.Items[v167]
		local v171 = v_u_64.Rewards[v167]
		if v169 then
			v_u_64.Cosmetics[v167].Description = "Unboxed from the " .. p151
			v_u_64.CosmeticNameToLootbox[v167] = p151
			if not v_u_64.Types[v169.Type].IsWeaponCosmetic then
				continue
			end
			v157.HasWeaponCosmetics = true
		else
			if v170 then
				continue
			end
			if v171 then
				if v171.Type ~= "Lootbox" or not v171.HasWeaponCosmetics then
					continue
				end
				v157.HasWeaponCosmetics = true
			else
				local v172 = p151 .. ", " .. v167
				assert(false, v172)
			end
		end
	end
end
v_u_173(nil, nil, "Skin Case", "Skin Cases", "Case", "rbxassetid://18185475009", {
	"Sandwich",
	"Saber",
	"Nuke Launcher",
	"Whoopee Cushion",
	"Disco Ball",
	"Singularity",
	"Pixel Sniper",
	"Don\'t Press",
	"Lasergun 3000",
	"Firework Gun",
	"Pixel Flamethrower",
	"Swashbuckler",
	"Electro Rifle",
	"Balloon Shotgun",
	"Emoji Cloud",
	"Pixel Crossbow",
	"Hyper Gunblade",
	"The Shred",
	"Temporal Ray",
	"Arcade Claw",
	"Plasma Distortion",
	"Glitter Warper",
	"Slime Gun",
	"Blobsaw",
	"Plastic Shovel",
	"Boxing Gloves",
	"AK-47",
	"Scythe of Death",
	"Blaster",
	"Water Uzi",
	"Desert Eagle",
	"Hacker Rifle",
	"Hacker Pistols",
	"Aces",
	"Trumpet",
	"Advanced Satchel",
	"Thunderpike",
	"Starforge Maul",
	"Starforge Permafrost",
	"Plasma Wildcat",
	"Cyber Warpstone",
	"Compound Bow",
	"Not So Shorty",
	"Stick",
	"Chancla",
	"Coffee",
	"Door",
	"Lovely Spray",
	"Trampoline"
})
v_u_173(nil, nil, "Skin Case 2", "Skin Case 2s", "Case", "rbxassetid://18763894913", {
	"Hyper Sniper",
	"Hyper Shotgun",
	"Karambit",
	"Augmented Rifle",
	"Hand Gun",
	"Sheriff",
	"Laptop",
	"Handsaws",
	"Teleport Disc",
	"Arcane Warper",
	"Electro Uzi",
	"Spaceship Launcher",
	"Camera",
	"Boba Gun",
	"Pixel Minigun",
	"Void Pistols",
	"Temporal Permafrost",
	"Fishing Rod",
	"Magma Distortion",
	"Aqua Burst",
	"Dynamite Gun",
	"Raven Bow",
	"Anchor",
	"Lightning Bolt",
	"Water Balloon",
	"Garden Shovel",
	"Uranium Launcher",
	"Ray Gun",
	"Bubble Ray",
	"Spring",
	"Energy Shield",
	"Harpoon Crossbow",
	"Hydro Rifle",
	"Bounce House",
	"Clown Hammer",
	"Lovely Shorty",
	"Lamethrower",
	"Brass Knuckles",
	"Balance",
	"Goalpost",
	"Torch",
	"Ban Axe",
	"Crude Gunblade",
	"Megaphone",
	"Nail Gun",
	"Notebook Satchel",
	"Paper Planes",
	"Fork"
})
v_u_173(nil, nil, "Skin Case 3", "Skin Case 3s", "Case", "rbxassetid://109359591947074", {
	"Hotel Bell",
	"Money Gun",
	"Medkitty",
	"Balisong",
	"Event Horizon",
	"Banana Flare",
	"Fighter Jet",
	"Harp",
	"Repulsor",
	"Drum Gun",
	"Bullpup Burst",
	"Peppergun",
	"Mega Drill",
	"Balloon Shorty",
	"Spray Bottle",
	"Void Rifle",
	"Gunsaw",
	"Genie Lamp",
	"Electropunk Warpstone",
	"Dream Bow",
	"Fists of Hurt",
	"Gearnade Launcher",
	"Glitterthrower",
	"Gum Ray",
	"Hourglass",
	"Lava Lamp",
	"Paintbrush",
	"Sakura Scythe",
	"Squid Launcher",
	"Stellar Katana",
	"Cerulean Axe",
	"Air Horn",
	"Masterpiece",
	"Hydro Pistols",
	"Shady Chicken Sandwich",
	"Violin Crossbow",
	"Plunger",
	"Permafrost.rbxm",
	"Cyber Distortion",
	"Cactus Shotgun",
	"DIY Tripmine",
	"Dynamite",
	"Gumball Handgun",
	"Ketchup Gun",
	"Lightbulb",
	"Bag o\' Money",
	"Shurikens",
	"Excalibur"
})
v_u_173(nil, nil, "Wrap Box", "Wrap Boxes", "Box", "rbxassetid://18185503558", {
	"Solar",
	"Malachite",
	"Lightning",
	"Arabesque",
	"Webbed",
	"Plastic",
	"Chrome",
	"A5",
	"Amber",
	"Insidious",
	"Iridescent",
	"Moonstone",
	"Bright",
	"Dark",
	"Mischief",
	"Rage",
	"Obsidian",
	"Toy",
	"Scales",
	"Well Done",
	"Dunes",
	"Glisten",
	"Glossy",
	"Bunsen",
	"Storm",
	"Mustard",
	"Violet",
	"Jean"
})
v_u_173(nil, nil, "Wrap Box 2", "Wrap Box 2s", "Box", "rbxassetid://18763894596", {
	"Speed",
	"Hologram",
	"Thunderburst",
	"Encrypt",
	"Starblaze",
	"Carbon Fiber",
	"Hyperdrive",
	"Insignia",
	"Cardinal",
	"Starfall",
	"Resolute",
	"Liquid Gold",
	"Tiger",
	"Black Granite",
	"Cerulean",
	"Clamshell",
	"Cool Crochet",
	"Cork",
	"Hammered Copper",
	"Hypnotic",
	"Leafy Grass",
	"Liquid Chrome",
	"Mahogany",
	"Neo",
	"Pink Crochet",
	"Pink Glitter",
	"Studded",
	"Tempest",
	"Yang",
	"Yin",
	"Ancient",
	"Grass",
	"Rustic",
	"Copper",
	"Machine",
	"Titanium",
	"Tungsten"
})
v_u_173(nil, nil, "Wrap Box 3", "Wrap Box 3s", "Box", "rbxassetid://77468549139941", {
	"Neon Lights",
	"Mesh",
	"Bombastic",
	"Candy Apple",
	"Dark Arena",
	"Green Sparkle",
	"Indigo Sparkle",
	"Rift",
	"Spectral",
	"Lovely Leopard",
	"Arbiter",
	"Antimatter",
	"Crimson Art",
	"Model",
	"Plasma",
	"Waste",
	"Purpleize",
	"Regal",
	"Sentinel",
	"Strobe",
	"TIX",
	"Tealur",
	"Lavish Crystal",
	"Noir",
	"Normal",
	"Rust",
	"Tawny"
})
v_u_173(nil, nil, "Charm Capsule", "Charm Capsules", "Capsule", "rbxassetid://18212803422", {
	"Blobfish",
	"Pufferfish",
	"Bitster",
	"Mystery Block",
	"Anvil",
	"Basketball",
	"Money Bag",
	"Rubber Duck",
	"10 Gallon Hat",
	"UFO",
	"Emoji: Weary",
	"Chocolate Scoop",
	"Rocket Ship",
	"Hotdog",
	"Moai",
	"Golf Ball",
	"Football",
	"Tennis Ball",
	"Rainbow",
	"Potion",
	"Hook",
	"Cookie",
	"Cupcake",
	"Ninja Star",
	"Lemon Slice",
	"Ship Wheel",
	"Star",
	"Heart",
	"Bowling Pin",
	"Life Buoy",
	"Cage",
	"Magnet",
	"Potted Cactus",
	"Potted Flower",
	"Fedora Stack",
	"Pawn",
	"Hammer",
	"Cog",
	"Dice",
	"Traffic Cone"
})
v_u_173(nil, nil, "Finisher Pack", "Finisher Packs", "Pack", "rbxassetid://106634436973187", {
	"Orbital Strike",
	"Darkheart",
	"BONK!",
	"Tough Crowd",
	"Balloons",
	"Electrocute",
	"Collapse",
	"Splatter",
	"High Gravity",
	"Freeze",
	"Tremble",
	"Rush",
	"Confetti",
	"Petrify",
	"Hacked",
	"Flop",
	"Toot",
	"Yoink"
})
v_u_173(nil, nil, "Finisher Pack 2", "Finisher Pack 2s", "Pack", "rbxassetid://80810630965566", {
	"Chark Attack",
	"GOOAAALLLL",
	"Crushed",
	"Enlightened",
	"Clapped",
	"Rainbow Barf",
	"Flick",
	"Ascend",
	"Roadrunner",
	"Heavy Head",
	"Bad Mood",
	"Hooked",
	"Delete",
	"Squawk",
	"Digitize",
	"Chalked",
	"Folded",
	"Very Tragic Banana Peel Accident"
})
v_u_173(nil, nil, "Spooky Skin Case", "Spooky Skin Cases", "CaseSpooky", "rbxassetid://89050335387917", {
	"Web Shooters",
	"Jeremiah",
	"Mimic Axe",
	"Soul Rifle",
	"Soul Pistols",
	"Experiment D15",
	"Experiment W4",
	"Pumpkin Launcher",
	"Skull Launcher",
	"Vexed Flare Gun",
	"Buzzsaw",
	"Bucket of Candy",
	"Spider Ray",
	"Vexed Candle",
	"Soul Grenade",
	"Eyeball",
	"Machete",
	"Mimic Wildcat",
	"Xenofrost",
	"Bat Daggers",
	"Potion Satchel",
	"Boneclaw Spray",
	"Boneclaw Horn",
	"Bat Scythe",
	"Bat Bow",
	"Boneclaw Rifle",
	"Boneclaw Revolver",
	"Jack O\'Thrower",
	"Brain Gun",
	"Broomstick",
	"Boneshot",
	"Exogourd",
	"Demon Uzi",
	"Demon Shorty",
	"Evil Trident",
	"Pumpkin Carver",
	"Gravelight",
	"Spider Web",
	"Tombstone Shield",
	"Boneblade",
	"Crossbone",
	"Warpbone",
	"Eyething Sniper",
	"Spectral Burst",
	"Pumpkin Minigun",
	"Pumpkin Handgun",
	"Pumpkin Claws",
	"Skullbang",
	"Trick or Treat"
})
v_u_173(nil, nil, "Haunted Chest", "Haunted Chests", "Chest", "rbxassetid://113101268671045", {
	"Soul Scourge",
	"Candy Dance",
	"Disintegrate",
	"Broom Ride",
	"Zombified",
	"Mummy",
	"Scourge",
	"Frankenstein",
	"Frankenblob",
	"Skullgourd",
	"Eyeclipse",
	"Cauldron",
	"Ghost",
	"Black Cat",
	"Reaper",
	"Bonesplosion",
	"Lost Soul",
	"Purple Goo",
	"Green Goo",
	"Chrome Webs",
	"Werewolf Fur",
	"Caramel Apple",
	"Devious Pumpkin",
	"Gravestone",
	"Melonkin",
	"Candy Bucket",
	"Spooky Confetti",
	"Batsplosion",
	"Bite",
	"Haunted",
	"Vexed",
	"Cursed",
	"Bone",
	"Candy",
	"Candy Corn",
	"Cobweb",
	"Spider",
	"Thorn Circle",
	"Witch Hat"
})
v_u_173(nil, nil, "Festive Skin Case", "Festive Skin Cases", "CaseFestive", "rbxassetid://122567993958308", {
	"Gingerbread Augmented Rifle",
	"Firework Launcher",
	"Peppermint Sheriff",
	"Candy Cane",
	"Festive Buzzsaw",
	"Milk & Cookies",
	"Hot Coals",
	"Dev-in-the-Box",
	"Warpstar",
	"Sleigh Maul",
	"Sleighstortion",
	"Frost Warper",
	"Jolly Man",
	"Gingerbread Sniper",
	"Frostbite Crossbow",
	"Frostbite Bow",
	"Snowblower",
	"Snowball Gun",
	"New Year Energy Rifle",
	"Snowball Launcher",
	"Cookies",
	"Gingerbread Handgun",
	"Reindeer Slingshot",
	"New Year Energy Pistols",
	"Cryo Scythe",
	"New Year Katana",
	"Snow Shovel",
	"Shining Star",
	"Snowglobe",
	"Jingle Grenade",
	"Snowman Permafrost",
	"Wrapped Minigun",
	"Wrapped Shotgun",
	"Pine Burst",
	"Elf\'s Gunblade",
	"Midnight Festive Exogun",
	"Pine Uzi",
	"Wrapped Shorty",
	"Pine Spray",
	"Wrapped Flare Gun",
	"Sled",
	"Nordic Axe",
	"Festive Fists",
	"Suspicious Gift",
	"Wrapped Freeze Ray",
	"Mammoth Horn"
})
v_u_173(nil, nil, "Jolly Chest", "Jolly Chests", "ChestFestive", "rbxassetid://125958746511820", {
	"Festive Lights",
	"Snowballed",
	"David",
	"Aurora",
	"Peppermint",
	"Gingerbread",
	"Yeti",
	"Gingerbread Man",
	"Gingerbread Cat",
	"Chillman",
	"Wreath",
	"Frozen",
	"Gingerbreadify",
	"Jolly Wrapping",
	"Snowfall",
	"Ugly Sweater",
	"Jolly Chair",
	"Stocking",
	"Festive Light",
	"Hot Chocolate",
	"Festive Confetti",
	"Wrapped",
	"Midnight",
	"Slush",
	"Frigid",
	"Firework",
	"Jolly Hat",
	"Elf Hat",
	"Peppermint Candy",
	"Crystal",
	"Mini Candy Cane",
	"Snowflake",
	"Mini Shining Star",
	"Ornament"
})
v_u_173(nil, nil, "Festive Wrap Box", "Festive Wrap Boxes", "Box", "rbxassetid://85450469885400", {
	"2025 Wrapping",
	"Forest Wrapping",
	"Peppermint Wrapping",
	"Winter Wrapping",
	"Mocha Wrapping",
	"Minty Wrapping",
	"Frosty Wrapping",
	"Creme Wrapping",
	"Blush Wrapping",
	"Cashmere Wrapping",
	"Carbon Wrapping",
	"Caned Wrapping"
})
v_u_173(nil, nil, "Festive Wrap Box 2", "Festive Wrap Box 2s", "Box", "rbxassetid://96554434133288", {
	"2026 Wrapping",
	"Chilled Wrapping",
	"Luxury Wrapping",
	"Regal Wrapping",
	"Holly Wrapping",
	"Fortune Wrapping",
	"Pearly Wrapping",
	"Polar Wrapping",
	"Mousse Wrapping",
	"Periwinkle Wrapping",
	"Evergreen Wrapping",
	"Dusky Wrapping",
	"Merlot Wrapping",
	"Indigo Wrapping"
})
v_u_173(nil, true, "Goodie Bag", "Goodie Bags", "GoodieBag", "rbxassetid://97975295792185", {
	"Charm Capsule",
	"Wrap Box",
	"Wrap Box 2",
	"Wrap Box 3",
	"Finisher Pack",
	"Finisher Pack 2"
})
v_u_173(true, true, "Prime Goodie Bag", "Prime Goodie Bags", "GoodieBag", "rbxassetid://123579272651325", {
	{
		["Weight"] = 15,
		["Reward"] = nil,
		["Reward"] = {
			["Name"] = "Charm Capsule",
			["Quantity"] = 1,
			["Weapon"] = "IsRandom"
		}
	},
	{
		["Weight"] = 15,
		["Reward"] = nil,
		["Reward"] = {
			["Name"] = "Wrap Box",
			["Quantity"] = 1,
			["Weapon"] = "IsRandom"
		}
	},
	{
		["Weight"] = 15,
		["Reward"] = nil,
		["Reward"] = {
			["Name"] = "Wrap Box 2",
			["Quantity"] = 1,
			["Weapon"] = "IsRandom"
		}
	},
	{
		["Weight"] = 15,
		["Reward"] = nil,
		["Reward"] = {
			["Name"] = "Wrap Box 3",
			["Quantity"] = 1,
			["Weapon"] = "IsRandom"
		}
	},
	{
		["Weight"] = 15,
		["Reward"] = nil,
		["Reward"] = {
			["Name"] = "Finisher Pack",
			["Quantity"] = 1,
			["Weapon"] = "IsRandom"
		}
	},
	{
		["Weight"] = 15,
		["Reward"] = nil,
		["Reward"] = {
			["Name"] = "Finisher Pack 2",
			["Quantity"] = 1,
			["Weapon"] = "IsRandom"
		}
	},
	{
		["Weight"] = 10,
		["Reward"] = nil,
		["Reward"] = {
			["Name"] = "Skin Ticket",
			["Quantity"] = 1
		}
	}
}, "May contain skin tickets!")
v_u_173(nil, nil, "Summer Skin Case", "Summer Skin Cases", "CaseSummer", "rbxassetid://75952684698581", {
	"Shark Shotgun",
	"Sand Bullpup Burst",
	"Ice Cream",
	"Cooler",
	"Crab Claws",
	"Fizz Bomb",
	"Pocket Volcano",
	"Cruise Revolver",
	"Campfire Spray",
	"Lifeguard Whistle",
	"Hazard Sign",
	"Sol",
	"Shark Minigun",
	"Permasand",
	"Bubblethrower",
	"Bubble Shorty",
	"Bubble Distortion",
	"Bubbler",
	"Tiki Axe",
	"Scooper",
	"Sandgun",
	"Pearl Rifle",
	"Pearl Exogun",
	"Warp Juice",
	"Palm Bow",
	"Sundae Launcher",
	"Coconut Launcher",
	"Sol Pistols",
	"Sol Rifle",
	"Chark Kebab",
	"Broken Surfboard",
	"Beach Ball",
	"Flamingo Floatie",
	"Sharksaw",
	"Giant Popsicle",
	"Lifeguard Satchel",
	"Lifeguard Grappler",
	"Palmshot",
	"Shark Tooth",
	"Sharkbite",
	"Lemonade Gun",
	"Swordfish",
	"Campfire Stick",
	"Campfire Crossbow",
	"Campfire Sniper",
	"Plastic Flamingo",
	"Ducky Uzi",
	"Starfish"
})
v_u_173(nil, nil, "Tropical Chest", "Tropical Chests", "ChestSummer", "rbxassetid://93495411534770", {
	"Tidal",
	"Summer Days",
	"Loose Coconut",
	"Mow Them Down",
	"Bubble Ball",
	"Popsicle",
	"Fish Scales",
	"Emoji: Hot",
	"Jellyfish",
	"Summer Cooler",
	"Sand Castle",
	"Soda Can",
	"Swept Away",
	"Kiddie Pool",
	"Beach Day",
	"Lighthouse",
	"Neapolitan",
	"Shore",
	"Mini Flamingo Floatie",
	"Sand Bucket",
	"Hidden Pearl",
	"Rocket Popsicle",
	"Lemon Juice",
	"Surfboard",
	"Sun Rays",
	"Water Balloons",
	"Sizzled",
	"Lemonade",
	"Creamsicle",
	"Waffle Cone",
	"Water Blaster",
	"Mini Beach Ball",
	"Flip Flop",
	"Snorkel Goggles",
	"Coconut",
	"Mini Starfish",
	"Watermelon Slice"
})
v_u_173(true, true, "Prize Wheel", "Prize Wheels", "PrizeWheel", "rbxassetid://84152087387410", {
	{
		["Weight"] = 35.5,
		["Reward"] = nil,
		["Reward"] = {
			["Name"] = "Key",
			["Quantity"] = 4
		}
	},
	{
		["Weight"] = 25,
		["Reward"] = nil,
		["Reward"] = {
			["Name"] = "Goodie Bag",
			["Quantity"] = 2,
			["Weapon"] = "IsRandom"
		}
	},
	{
		["Weight"] = 20,
		["Reward"] = nil,
		["Reward"] = {
			["Name"] = "Key",
			["Quantity"] = 10
		}
	},
	{
		["Weight"] = 15,
		["Reward"] = nil,
		["Reward"] = {
			["Name"] = "Celestial",
			["Quantity"] = 1,
			["Weapon"] = "IsRandom"
		}
	},
	{
		["Weight"] = 4,
		["Reward"] = nil,
		["Reward"] = {
			["Name"] = "Skin Ticket",
			["Quantity"] = 1
		}
	},
	{
		["Weight"] = 0.5,
		["Reward"] = nil,
		["Reward"] = {
			["Name"] = "Light Fifty",
			["Quantity"] = 1,
			["Weapon"] = "Sniper"
		}
	}
})
v_u_173(true, true, "Spooky Prize Wheel", "Spooky Prize Wheels", "PrizeWheel", "rbxassetid://124644805082412", {
	{
		["Weight"] = 27,
		["Reward"] = nil,
		["Reward"] = {
			["Name"] = "Key",
			["Quantity"] = 1
		}
	},
	{
		["Weight"] = 25,
		["Reward"] = nil,
		["Reward"] = {
			["Name"] = "Haunted Chest",
			["Quantity"] = 1,
			["Weapon"] = "IsRandom"
		}
	},
	{
		["Weight"] = 20,
		["Reward"] = nil,
		["Reward"] = {
			["Name"] = "Haunted Chest",
			["Quantity"] = 3,
			["Weapon"] = "IsRandom"
		}
	},
	{
		["Weight"] = 15,
		["Reward"] = nil,
		["Reward"] = {
			["Name"] = "Goodie Bag",
			["Quantity"] = 1,
			["Weapon"] = "IsRandom"
		}
	},
	{
		["Weight"] = 10,
		["Reward"] = nil,
		["Reward"] = {
			["Name"] = "Red Moon",
			["Quantity"] = 1,
			["Weapon"] = "IsRandom"
		}
	},
	{
		["Weight"] = 2,
		["Reward"] = nil,
		["Reward"] = {
			["Name"] = "Skin Ticket",
			["Quantity"] = 1
		}
	},
	{
		["Weight"] = 1,
		["Reward"] = nil,
		["Reward"] = {
			["Name"] = "Spider Crossbow",
			["Quantity"] = 1,
			["Weapon"] = "Crossbow"
		}
	}
});
(function() -- name: add_weapons
	-- upvalues: (copy) v_u_6, (copy) v_u_143, (copy) v_u_7, (copy) v_u_8, (copy) v_u_173
	for _, v174 in pairs(v_u_7.OwnableWeapons) do
		local v175 = {
			["ImageHighResolution"] = v_u_6.ViewModels[v174].ImageHighResolution
		}
		v_u_143("Weapon", v174, v174, v174, v_u_6.Items[v174].Image, 3, v175)
	end
	local v176 = {
		["ImageHighResolution"] = v_u_6.ViewModels.MISSING_WEAPON.ImageHighResolution
	}
	v_u_143("Weapon", "MISSING_WEAPON", "MISSING_WEAPON", "MISSING_WEAPON", v_u_6.Items.MISSING_WEAPON.Image, 3, v176)
	local v187, v188 = (function() -- name: get_contents
		-- upvalues: (ref) v_u_7, (ref) v_u_6, (ref) v_u_8
		local v177 = {}
		for _, v178 in pairs(v_u_7:GetReleasedOwnableWeapons()) do
			if not v_u_7.Weapons[v178].KeyPrice then
				continue
			end
			table.insert(v177, v178)
		end
		table.sort(v177, function(p179, p180)
			-- upvalues: (ref) v_u_6, (ref) v_u_8
			local v181 = v_u_6.Statuses[v_u_6.Items[p179].Status].Value
			local v182 = v_u_6.Statuses[v_u_6.Items[p180].Status].Value
			if v181 == v182 then
				return v_u_8:StringLessThan(p179, p180)
			else
				return v182 < v181
			end
		end)
		local v183 = {}
		for _, v184 in pairs(v177) do
			local v185 = v_u_6.Items[v184]
			v183[v185.Status] = v183[v185.Status] or {}
			local v186 = v183[v185.Status]
			table.insert(v186, v184)
		end
		return v177, v183
	end)()
	local v189 = {}
	for _, v190 in pairs(v187) do
		local v191 = {
			["Weight"] = 1,
			["Reward"] = nil,
			["Reward"] = {
				["Name"] = v190
			}
		}
		table.insert(v189, v191)
	end
	v_u_173(true, nil, "Weapon Crate", "Weapon Crates", "Crate", "rbxassetid://134795947609872", v189)
	for v192 in pairs(v_u_6.Statuses) do
		local v193 = {}
		for _, v194 in pairs(v188[v192]) do
			local v195 = {
				["Weight"] = 1,
				["Reward"] = nil,
				["Reward"] = {
					["Name"] = v194
				}
			}
			table.insert(v193, v195)
		end
		v_u_173(true, nil, v192 .. " Weapon Crate", v192 .. " Weapon Crates", "Crate", "rbxassetid://134795947609872", v193)
	end
end)();
(function() -- name: alphabetize
	-- upvalues: (copy) v_u_64, (copy) v_u_8
	for v196 in pairs(v_u_64.Cosmetics) do
		local v197 = v_u_64.CosmeticsAlphabetized
		table.insert(v197, v196)
	end
	table.sort(v_u_64.CosmeticsAlphabetized, function(p198, p199)
		-- upvalues: (ref) v_u_8
		return v_u_8:StringLessThan(string.lower(p198), string.lower(p199))
	end)
	task.delay(5, function()
		-- upvalues: (ref) v_u_64
		for v200, v201 in pairs(v_u_64.Cosmetics) do
			if v201.Description or v201.Rarity == "Unobtainable" then
				continue
			end
			warn("Missing description:", v200)
		end
	end)
end)()
return v_u_64