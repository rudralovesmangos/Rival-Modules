local v1 = game:GetService("ReplicatedStorage")
local v2 = game:GetService("Players")
local v_u_3 = require(v1.Modules.Signal)
require(script:WaitForChild("Daily"))
require(script:WaitForChild("Currency"))
require(script:WaitForChild("Bundles"))
require(script:WaitForChild("Ranked"))
require(script:WaitForChild("Skins"))
require(script:WaitForChild("Home"))
local v_u_4 = v2.LocalPlayer.PlayerScripts.Assets:WaitForChild("Temp"):WaitForChild("ShopPages")
local v_u_5 = {
	"Currency",
	"Bundles",
	"Ranked",
	"Daily",
	"Skins",
	"Home"
}
local v_u_6 = {}
v_u_6.__index = v_u_6
function v_u_6.new(p7) -- name: new
	-- upvalues: (copy) v_u_6, (copy) v_u_3
	local v8 = v_u_6
	local v9 = setmetatable({}, v8)
	v9.UpdateCanvasSize = v_u_3.new()
	v9.Shop = p7
	v9.Frame = v9.Shop.Container:WaitForChild("Pages")
	v9.Components = {}
	v9._page_frames = {}
	v9:_Init()
	return v9
end
function v_u_6.GetComponentFrame(p10, p11) -- name: GetComponentFrame
	local v12 = p10.Components[p11]
	if v12 then
		v12 = p10.Components[p11].Frame
	end
	return v12
end
function v_u_6.Open(p13) -- name: Open
	for _, v14 in pairs(p13.Components) do
		v14:Open()
	end
end
function v_u_6.Close(p15) -- name: Close
	for _, v16 in pairs(p15.Components) do
		v16:Close()
	end
end
function v_u_6.Setup(p17) -- name: Setup
	for _, v18 in pairs(p17.Components) do
		v18:Setup()
	end
	p17:_Update()
end
function v_u_6._Update(p19) -- name: _Update
	-- upvalues: (copy) v_u_4
	for v20, v21 in pairs(p19._page_frames) do
		local v22 = v20 == p19.Shop.CurrentPage
		v21.Parent = v22 and p19.Frame or v_u_4
		v21.Visible = v22
	end
end
function v_u_6._Setup(p_u_23) -- name: _Setup
	-- upvalues: (copy) v_u_5, (copy) v_u_4
	for _, v24 in pairs(v_u_5) do
		local v25 = require(script:WaitForChild(v24)).new(p_u_23)
		v25.Frame:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
			-- upvalues: (copy) p_u_23
			p_u_23.UpdateCanvasSize:Fire()
		end)
		v25.Frame:GetPropertyChangedSignal("AbsolutePosition"):Connect(function()
			-- upvalues: (copy) p_u_23
			p_u_23.UpdateCanvasSize:Fire()
		end)
		p_u_23.Components[v24] = v25
	end
	for _, v26 in pairs(p_u_23.Shop.PAGE_NAMES) do
		local v27 = p_u_23.Frame:WaitForChild(v26)
		v27.Visible = false
		v27.Parent = v_u_4
		p_u_23._page_frames[v26] = v27
	end
end
function v_u_6._Init(p_u_28) -- name: _Init
	p_u_28.Shop.CurrentPageChanged:Connect(function()
		-- upvalues: (copy) p_u_28
		p_u_28:_Update()
	end)
	p_u_28:_Setup()
end
return v_u_6