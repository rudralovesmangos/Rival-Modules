local v1 = game:GetService("Players")
local v_u_2 = require(v1.LocalPlayer.PlayerScripts.Modules:WaitForChild("SettingSlot"))
local v_u_3 = setmetatable({}, v_u_2)
v_u_3.__index = v_u_3
function v_u_3.new(...) -- name: new
	-- upvalues: (copy) v_u_2, (copy) v_u_3
	local v4 = v_u_2.new(...)
	local v5 = v_u_3
	local v6 = setmetatable(v4, v5)
	v6:_Init()
	return v6
end
function v_u_3.SetDividerSpacing(p7, p8) -- name: SetDividerSpacing
	p7:ResizeYSize(p8)
	p7.Background.Size = UDim2.new(1, 0, 1 / p8, 0)
end
function v_u_3._Setup(p9) -- name: _Setup
	p9.Background.ImageTransparency = 0.25
	p9.BackgroundGradient.Enabled = false
	p9.DetailsDisplayTitleText.FontFace = Font.fromId(12187365977, Enum.FontWeight.ExtraBold)
	p9.Container.Position = UDim2.new(0, 0, 1, 0)
	p9.Container.AnchorPoint = Vector2.new(0, 1)
	p9.DetailsDisplayTitleContainer.Size = UDim2.new(p9.DetailsDisplayTitleContainer.Size.X.Scale, p9.DetailsDisplayTitleContainer.Size.X.Offset, p9.DetailsDisplayTitleContainer.Size.Y.Scale * 1.5, p9.DetailsDisplayTitleContainer.Size.Y.Offset * 1.5)
	p9.SettingFrame.Size = UDim2.new(p9.SettingFrame.Size.X.Scale, p9.SettingFrame.Size.X.Offset, p9.SettingFrame.Size.Y.Scale * 0.84, p9.SettingFrame.Size.Y.Offset * 0.84)
	p9.DetailsDisplayTitleContainer.Position = UDim2.new(0.0125, 0, 0.5, 0)
end
function v_u_3._Init(p10) -- name: _Init
	p10:_Setup()
end
return v_u_3