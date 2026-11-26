local v1 = game:GetService("ReplicatedStorage")
local v2 = game:GetService("Players")
local v_u_3 = require(v1.Modules.CurrencyLibrary)
local v_u_4 = require(v1.Modules.SeasonLibrary)
local v_u_5 = require(v1.Modules.Utility)
local v_u_6 = require(v2.LocalPlayer.PlayerScripts.Controllers.PlayerDataController)
local v_u_7 = require(v2.LocalPlayer.PlayerScripts.Modules.ButtonEffect)
local v_u_8 = require(v2.LocalPlayer.PlayerScripts.Modules.UserInterface.Pages)
local v_u_9 = {}
v_u_9.__index = v_u_9
function v_u_9.new(p10) -- name: new
	-- upvalues: (copy) v_u_9
	local v11 = v_u_9
	local v12 = setmetatable({}, v11)
	v12.Page = p10
	v12.Frame = v12.Page.Container:WaitForChild("Header")
	v12.SeasonFrame = v12.Frame:WaitForChild("Season")
	v12.SeasonText = v12.SeasonFrame:WaitForChild("Title")
	v12.DescriptionFrame = v12.Frame:WaitForChild("Description")
	v12.DescriptionButton = v12.DescriptionFrame:WaitForChild("Info")
	v12.DescriptionTitle = v12.DescriptionFrame:WaitForChild("Title")
	v12.GloryFrame = v12.Frame:WaitForChild("Glory")
	v12.GloryButton = v12.GloryFrame:WaitForChild("Button")
	v12.GloryIcon = v12.GloryButton:WaitForChild("Icon")
	v12.GloryTitle = v12.GloryButton:WaitForChild("Title")
	v12._update_description_thread = nil
	v12:_Init()
	return v12
end
function v_u_9.Open(p13) -- name: Open
	p13:_UpdateGlory()
	p13:_UpdateDescription()
end
function v_u_9.Close(p14) -- name: Close
	p14:_CancelDescriptionThread()
end
function v_u_9._CancelDescriptionThread(p15) -- name: _CancelDescriptionThread
	if p15._update_description_thread then
		task.cancel(p15._update_description_thread)
		p15._update_description_thread = nil
	end
end
function v_u_9._UpdateDescription(p_u_16) -- name: _UpdateDescription
	-- upvalues: (copy) v_u_4, (copy) v_u_6, (copy) v_u_5
	local v17 = v_u_4.CurrentSeason.Name
	local v_u_18 = v_u_4.Seasons[v17]
	local v19 = v_u_4.UNIVERSAL_ELO_NAME
	local v_u_20 = v_u_6:Get("Seasons")[v17]
	if v_u_20 then
		v_u_20 = v_u_20.RankedPerformances[v19]
	end
	if not (v_u_20.ELODecayTimeStart and v_u_20.ELODecayDuelsPlayedTimeResetProgress) or (not v_u_20.CurrentELO or v_u_20.CurrentELO <= v_u_18.ELODecayThreshold) then
		p_u_16.DescriptionTitle.Text = "Standard duel gameplay  \226\128\162  Restricted handicaps  \226\128\162  Ban maps & weapons"
	else
		p_u_16:_CancelDescriptionThread()
		p_u_16._update_description_thread = task.spawn(function()
			-- upvalues: (copy) v_u_20, (copy) v_u_18, (ref) v_u_4, (copy) p_u_16, (ref) v_u_5
			while true do
				local v21 = v_u_20.ELODecayTimeStart / 60 / 60 / 24
				local v22 = (math.ceil(v21) + v_u_18.ELODecayInactivePeriodDays) * 24 * 60 * 60 - os.time()
				local v23 = v_u_4.CurrentSeason.DuelsNeededToPreventELODecay - v_u_20.ELODecayDuelsPlayedTimeResetProgress
				if v22 <= 0 then
					p_u_16.DescriptionTitle.Text = string.format("Your ELO will continue to decay until you play %s more Ranked duels", v23)
				else
					p_u_16.DescriptionTitle.Text = string.format("Your ELO will start decaying in %s if you don\'t play %s more Ranked duels", v_u_5:TimeFormat2(v22), v23)
				end
				wait(1)
			end
		end)
	end
end
function v_u_9._UpdateGlory(p24) -- name: _UpdateGlory
	-- upvalues: (copy) v_u_5, (copy) v_u_6
	p24.GloryTitle.Text = string.format("%s <font transparency=\"0.25\" weight=\"500\" size=\"8\">Glory</font>", v_u_5:PrettyNumber(v_u_6:Get("Glory")))
end
function v_u_9._Setup(p25) -- name: _Setup
	-- upvalues: (copy) v_u_4, (copy) v_u_3
	p25.SeasonText.Text = "Season " .. v_u_4.CurrentSeason.Version
	p25.GloryIcon.Image = v_u_3.Info.Glory.Image
end
function v_u_9._Init(p_u_26) -- name: _Init
	-- upvalues: (copy) v_u_8, (copy) v_u_7
	p_u_26.DescriptionButton.MouseButton1Click:Connect(function()
		-- upvalues: (copy) p_u_26
		p_u_26.Page.PromptSystem:Open("ViewRankedDetails")
	end)
	p_u_26.GloryButton.MouseButton1Click:Connect(function()
		-- upvalues: (copy) p_u_26, (ref) v_u_8
		p_u_26.Page.OpenPage:Fire("Shop")
		v_u_8.PageSystem:WaitForPage("Shop"):SetPage("Ranked")
		v_u_8.PageSystem:WaitForPage("Shop"):RedirectTo("Ranked")
	end)
	p_u_26:_Setup()
	v_u_7:Add(p_u_26.DescriptionButton)
	v_u_7:Add(p_u_26.GloryButton, nil, {
		["ReleaseRatio"] = 1.05,
		["HoverRatio"] = 1.05
	})
end
return v_u_9