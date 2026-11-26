local v_u_1 = game:GetService("LocalizationService")
local v2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("CollectionService")
local v_u_4 = game:GetService("UserService")
local v_u_5 = game:GetService("Players")
local v_u_6 = require(v2.Modules.Utility)
local v_u_7 = require(v_u_5.LocalPlayer.PlayerScripts.Controllers:WaitForChild("PlayerDataController"))
local v_u_8 = {}
v_u_8.__index = v_u_8
function v_u_8._new() -- name: _new
	-- upvalues: (copy) v_u_8
	local v9 = v_u_8
	local v10 = setmetatable({}, v9)
	v10._is_fetching_user_info = {}
	v10._user_info_cache = {}
	v10:_Init()
	return v10
end
function v_u_8.IsChina(_, p11) -- name: IsChina
	-- upvalues: (copy) v_u_7
	local v12 = p11 or v_u_7:Get("PolicyInfo")
	return not v12 or v12.IsSubjectToChinaPolicies
end
function v_u_8.IsExternalReferencesAllowed(p13, p14) -- name: IsExternalReferencesAllowed
	-- upvalues: (copy) v_u_7
	local v15 = v_u_7:Get("PolicyInfo")
	local v16 = v15 and not p13:IsChina()
	if v16 then
		v16 = table.find(v15.AllowedExternalLinkReferences, p14 or "YouTube")
	end
	return v16
end
function v_u_8.ArePaidRandomItemsRestricted(p17, p18) -- name: ArePaidRandomItemsRestricted
	-- upvalues: (copy) v_u_7
	local v19 = p18 or v_u_7:Get("PolicyInfo")
	return not v19 or (v19.ArePaidRandomItemsRestricted or p17:IsChina(v19))
end
function v_u_8.IsPaidItemTradingAllowed(_) -- name: IsPaidItemTradingAllowed
	-- upvalues: (copy) v_u_7
	local v20 = v_u_7:Get("PolicyInfo")
	if v20 then
		v20 = v20.IsPaidItemTradingAllowed
	end
	return v20
end
function v_u_8.UserIDsAllowed(p21) -- name: UserIDsAllowed
	return not p21:IsChina()
end
function v_u_8.UsernamesAllowed(p22) -- name: UsernamesAllowed
	return not p22:IsChina()
end
function v_u_8.UseDisplayNames(_) -- name: UseDisplayNames
	return true
end
function v_u_8.GetName(p23, p24) -- name: GetName
	-- upvalues: (copy) v_u_6
	return v_u_6:GetName(p24, p23:UseDisplayNames() and p24.DisplayName or p24.Name)
end
function v_u_8.GetUserInfos(p25, p26, p27) -- name: GetUserInfos
	if not p27 then
		return p25:_GetUserInfos(p26)
	end
	local v28 = {}
	local v29 = {}
	for v30, v31 in pairs(p26) do
		if v30 <= p27 then
			table.insert(v28, v31)
		else
			table.insert(v29, v31)
		end
	end
	local v32 = {}
	for _, v33 in pairs({ v28, v29 }) do
		for v34, v35 in pairs(p25:_GetUserInfos(v33)) do
			v32[v34] = v35
		end
	end
	return v32
end
function v_u_8._GetUserInfos(p36, p37) -- name: _GetUserInfos
	-- upvalues: (copy) v_u_4
	local v38 = {}
	for _, v39 in pairs(p37) do
		if p36._user_info_cache[tostring(v39)] or p36._is_fetching_user_info[tostring(v39)] then
			continue
		end
		table.insert(v38, v39)
	end
	for _, v40 in pairs(v38) do
		p36._is_fetching_user_info[tostring(v40)] = true
	end
	local v41 = v_u_4.GetUserInfosByUserIdsAsync
	local v42 = v_u_4
	local v43, v44 = pcall(v41, v42, v38)
	for _, v45 in pairs(v38) do
		p36._is_fetching_user_info[tostring(v45)] = nil
	end
	if not v43 then
		return {}
	end
	for _, v46 in pairs(v44) do
		local v47 = p36._user_info_cache
		local v48 = v46.Id
		v47[tostring(v48)] = v46
	end
	local v49 = {}
	for _, v50 in pairs(p37) do
		v49[tostring(v50)] = p36._user_info_cache[tostring(v50)] or nil
	end
	for _, v51 in pairs(v44) do
		local v52 = v51.Id
		v49[tostring(v52)] = v51
	end
	return v49
end
function v_u_8._BlacklistedObject(p53, p54) -- name: _BlacklistedObject
	if p53._country_code == p54:GetAttribute("CountryCode") then
		task.defer(p54.Destroy, p54)
	end
end
function v_u_8._WhitelistedObject(p55, p56) -- name: _WhitelistedObject
	if p55._country_code ~= p56:GetAttribute("CountryCode") then
		task.defer(p56.Destroy, p56)
	end
end
function v_u_8._SetupLocaleObjects(p_u_57) -- name: _SetupLocaleObjects
	-- upvalues: (copy) v_u_1, (copy) v_u_5, (copy) v_u_3
	local v58 = v_u_1.GetCountryRegionForPlayerAsync
	local v59 = v_u_1
	local v60 = v_u_5.LocalPlayer
	local v61, v62 = pcall(v58, v59, v60)
	if v61 then
		p_u_57._country_code = v62
	else
		warn("Failed to fetch country code, error:", v62)
	end
	v_u_3:GetInstanceAddedSignal("RegionHideThisObject"):Connect(function(p63)
		-- upvalues: (copy) p_u_57
		p_u_57:_BlacklistedObject(p63)
	end)
	v_u_3:GetInstanceAddedSignal("RegionShowThisObject"):Connect(function(p64)
		-- upvalues: (copy) p_u_57
		p_u_57:_WhitelistedObject(p64)
	end)
	for _, v65 in pairs(v_u_3:GetTagged("RegionHideThisObject")) do
		task.defer(p_u_57._BlacklistedObject, p_u_57, v65)
	end
	for _, v66 in pairs(v_u_3:GetTagged("RegionShowThisObject")) do
		task.defer(p_u_57._WhitelistedObject, p_u_57, v66)
	end
end
function v_u_8._Init(p67) -- name: _Init
	task.defer(p67._SetupLocaleObjects, p67)
end
return v_u_8._new()