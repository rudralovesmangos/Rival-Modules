local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("UserInputService")
local v3 = game:GetService("Players")
local v_u_4 = require(v1.Modules.Signal)
local v_u_5 = require(v3.LocalPlayer.PlayerScripts.Controllers.PlayerDataController)
local v_u_6 = require(v3.LocalPlayer.PlayerScripts.Controllers.ControlsController)
local v_u_7 = require(v3.LocalPlayer.PlayerScripts.Modules.UILibrary)
local v_u_8 = {}
v_u_8.__index = v_u_8
function v_u_8.new(p9) -- name: new
	-- upvalues: (copy) v_u_8, (copy) v_u_4
	local v10 = v_u_8
	local v11 = setmetatable({}, v10)
	v11.MouseDownChanged = v_u_4.new()
	v11.Equipment = p9
	v11._connections = {}
	v11._frame = Instance.new("ImageButton")
	v11._is_mouse_down = nil
	v11._last_position = nil
	v11._velocity = Vector2.zero
	v11._rad = Vector2.zero
	v11._last_state = nil
	v11._start_resetting = nil
	v11:_Init()
	return v11
end
function v_u_8.IsMouseDown(p12) -- name: IsMouseDown
	return p12._is_mouse_down
end
function v_u_8.GetCFrame(p13) -- name: GetCFrame
	return CFrame.Angles(0, p13._rad.X, 0) * CFrame.Angles(p13._rad.Y, 0, 0)
end
function v_u_8.Update(p14, _) -- name: Update
	if p14._velocity.Magnitude <= 0.001 and not p14._is_mouse_down then
		if not p14._start_resetting or tick() > p14._start_resetting then
			if p14._rad.X < -3.141592653589793 then
				p14._rad = Vector2.new(p14._rad.X + 6.283185307179586, p14._rad.Y)
			elseif p14._rad.X > 3.141592653589793 then
				p14._rad = Vector2.new(p14._rad.X - 6.283185307179586, p14._rad.Y)
			end
			if p14._rad.Y < -3.141592653589793 then
				p14._rad = Vector2.new(p14._rad.X, p14._rad.Y + 6.283185307179586)
			elseif p14._rad.Y > 3.141592653589793 then
				p14._rad = Vector2.new(p14._rad.X, p14._rad.Y - 6.283185307179586)
			end
			local v15
			if p14._start_resetting then
				local v16 = ((tick() - p14._start_resetting) / 4) ^ 2
				v15 = math.clamp(v16, 0, 1)
			else
				v15 = 1
			end
			local v17 = 1 - v15 * 0.05
			p14._rad = p14._rad * v17
		end
	else
		p14._start_resetting = tick() + 0
		p14._velocity = p14._velocity * 0.975
		p14:_Increment(p14._velocity)
		return
	end
end
function v_u_8.OnStateChanged(p18) -- name: OnStateChanged
	p18:_CheckResetSpin()
end
function v_u_8.OnOpen(p19) -- name: OnOpen
	-- upvalues: (copy) v_u_7
	p19._frame.Parent = p19.Equipment.IsOpen and v_u_7.MainGui or nil
	p19:_VerifyControls()
end
function v_u_8._CheckResetSpin(p20) -- name: _CheckResetSpin
	local v21 = p20.Equipment:GetStateID()
	if v21 ~= p20._last_state then
		p20._last_state = v21
		p20._velocity = Vector2.zero
		p20._rad = Vector2.zero
	end
end
function v_u_8._IsDisabled(p22) -- name: _IsDisabled
	-- upvalues: (copy) v_u_5
	local v23 = p22.Equipment:GetSelectedWeapon()
	local v24 = v_u_5:GetWeaponData(v23)
	if v23 then
		v23 = not v24
	end
	return v23
end
function v_u_8._GetMouseLocation(_) -- name: _GetMouseLocation
	-- upvalues: (copy) v_u_7
	return v_u_7:GetMouseLocation()
end
function v_u_8._Increment(p25, p26) -- name: _Increment
	p25._rad = p25._rad + p26
	p25._rad = Vector2.new(p25._rad.X % 6.283185307179586, p25._rad.Y % 6.283185307179586)
end
function v_u_8._VerifyControls(p_u_27) -- name: _VerifyControls
	-- upvalues: (copy) v_u_6, (copy) v_u_2
	for _, v28 in pairs(p_u_27._connections) do
		v28:Disconnect()
	end
	p_u_27._connections = {}
	if p_u_27.Equipment.IsOpen then
		p_u_27._last_position = nil
		p_u_27._velocity = Vector2.zero
		p_u_27._is_mouse_down = nil
		p_u_27.MouseDownChanged:Fire()
		local v29 = p_u_27._connections
		local v30 = p_u_27._frame.InputBegan
		table.insert(v29, v30:Connect(function(p31)
			-- upvalues: (copy) p_u_27
			if not (p_u_27:_IsDisabled() or p_u_27._is_mouse_down) then
				if p31.UserInputType == Enum.UserInputType.MouseButton1 or (p31.UserInputType == Enum.UserInputType.MouseButton2 or p31.UserInputType == Enum.UserInputType.Touch) then
					p_u_27._last_position = nil
					p_u_27._velocity = Vector2.zero
					p_u_27._is_mouse_down = p31
					p_u_27.MouseDownChanged:Fire()
				end
			end
		end))
		local v32 = p_u_27._connections
		local v33 = v_u_2.InputEnded
		local function v36(p34)
			-- upvalues: (ref) v_u_6, (copy) p_u_27
			local v35
			if v_u_6.CurrentControls == "Touch" then
				v35 = p34 ~= p_u_27._is_mouse_down
			else
				v35 = not p_u_27._is_mouse_down
			end
			if not v35 then
				if p34.UserInputType == Enum.UserInputType.MouseButton1 or (p34.UserInputType == Enum.UserInputType.MouseButton2 or p34.UserInputType == Enum.UserInputType.Touch) then
					p_u_27._is_mouse_down = nil
					p_u_27.MouseDownChanged:Fire()
					if p_u_27._last_position then
						p_u_27._velocity = (p_u_27:_GetMouseLocation() - p_u_27._last_position) / 400
					end
				end
			end
		end
		table.insert(v32, v33:Connect(v36))
		local v37 = p_u_27._connections
		local v38 = v_u_2.InputChanged
		local function v42(p39)
			-- upvalues: (ref) v_u_6, (copy) p_u_27
			local v40
			if v_u_6.CurrentControls == "Touch" then
				v40 = p39 ~= p_u_27._is_mouse_down
			else
				v40 = not p_u_27._is_mouse_down
			end
			if not v40 then
				local v41 = p_u_27:_GetMouseLocation()
				if p_u_27._last_position then
					p_u_27:_Increment((v41 - p_u_27._last_position) / 800 * (v_u_6.CurrentControls == "Touch" and 3 or 1))
				end
				p_u_27._last_position = v41
			end
		end
		table.insert(v37, v38:Connect(v42))
	end
end
function v_u_8._Setup(p43) -- name: _Setup
	p43._frame.Name = "EquipmentSpinControls"
	p43._frame.AnchorPoint = Vector2.new(0.5, 0.5)
	p43._frame.Position = UDim2.new(0.5, 0, 0.5, 0)
	p43._frame.Size = UDim2.new(1, 0, 1, 0)
	p43._frame.Image = ""
	p43._frame.BackgroundTransparency = 1
	p43._frame.ZIndex = -1000
	p43._frame.Visible = true
end
function v_u_8._Init(p44) -- name: _Init
	p44:_Setup()
end
return v_u_8