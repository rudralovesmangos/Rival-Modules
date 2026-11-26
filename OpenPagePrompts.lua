local v_u_1 = game:GetService("CollectionService")
local v2 = game:GetService("Players")
require(v2.LocalPlayer.PlayerScripts.Controllers:WaitForChild("SpectateController"))
local v_u_3 = require(v2.LocalPlayer.PlayerScripts.Modules:WaitForChild("UserInterface"):WaitForChild("Pages"))
local v_u_4 = {}
v_u_4.__index = v_u_4
function v_u_4._new() -- name: _new
	-- upvalues: (copy) v_u_4
	local v5 = v_u_4
	local v6 = setmetatable({}, v5)
	v6._connections = {}
	v6:_Init()
	return v6
end
function v_u_4._ObjectRemoved(p7, p8) -- name: _ObjectRemoved
	if p7._connections[p8] then
		p7._connections[p8]:Disconnect()
		p7._connections[p8] = nil
	end
end
function v_u_4._ObjectAdded(p9, p_u_10) -- name: _ObjectAdded
	-- upvalues: (copy) v_u_3
	p9:_ObjectRemoved(p_u_10)
	p9._connections[p_u_10] = p_u_10.Triggered:Connect(function()
		-- upvalues: (ref) v_u_3, (copy) p_u_10
		wait(0.06)
		v_u_3.PageSystem:OpenPage(p_u_10:GetAttribute("PageName"), true)
		local v11 = p_u_10:GetAttribute("ShopViewBundleName")
		local v12 = p_u_10:GetAttribute("ShopViewShopEntryName")
		if v11 then
			local v13
			if #v11 >= 9 and string.sub(v11, 1, 9) == "keybundle" then
				v13 = true
			elseif #v11 >= 19 then
				v13 = string.sub(v11, 1, 19) == "eventcurrencybundle"
			else
				v13 = false
			end
			v_u_3.PageSystem:WaitForPage("Shop"):SetPage(v13 and "Currency" or "Bundles")
			v_u_3.PageSystem:WaitForPage("Shop"):InspectBundle(v11)
		elseif v12 then
			v_u_3.PageSystem:WaitForPage("Shop"):SetPage("Home")
			v_u_3.PageSystem:WaitForPage("Shop"):InspectShopEntry(v12)
		end
		local v14 = p_u_10:GetAttribute("ShopViewPage")
		if v14 then
			v_u_3.PageSystem:WaitForPage("Shop"):SetPage(v14)
		end
		local v15 = p_u_10:GetAttribute("DialogLobbyNPCName")
		if v15 then
			v_u_3.PageSystem:WaitForPage("DialogLobby"):SetNPCName(v15)
		end
		local v16 = p_u_10:GetAttribute("MatchmakingScrollTo")
		if v16 then
			v_u_3.PageSystem:WaitForPage("Matchmaking"):ScrollTo(v16, 0.25)
		end
		local v17 = p_u_10:GetAttribute("InspectUGC")
		if v17 then
			v_u_3.PageSystem:WaitForPage("UGCShop"):Buy(v17)
		end
		local v18 = p_u_10:GetAttribute("TasksScrollTo")
		if v18 then
			v_u_3.PageSystem:WaitForPage("Tasks"):ScrollTo(v18, 0.25)
		end
	end)
end
function v_u_4._Init(p_u_19) -- name: _Init
	-- upvalues: (copy) v_u_1
	v_u_1:GetInstanceAddedSignal("LobbyOpenPagePrompt"):Connect(function(p20)
		-- upvalues: (copy) p_u_19
		p_u_19:_ObjectAdded(p20)
	end)
	v_u_1:GetInstanceRemovedSignal("LobbyOpenPagePrompt"):Connect(function(p21)
		-- upvalues: (copy) p_u_19
		p_u_19:_ObjectRemoved(p21)
	end)
	for _, v22 in pairs(v_u_1:GetTagged("LobbyOpenPagePrompt")) do
		task.spawn(p_u_19._ObjectAdded, p_u_19, v22)
	end
end
return v_u_4._new()