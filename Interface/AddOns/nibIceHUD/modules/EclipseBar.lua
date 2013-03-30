local EclipseBar = IceCore_CreateClass(IceBarElement)
local mass

if IsAddOnLoaded("Massive") then
	mass = LibStub:GetLibrary("Massive")
end

local nibIceHUD = _G.nibIceHUD

EclipseBar.prototype.barUpdateColor = "EclipseLunar"
EclipseBar.prototype.direction = "none"

local DirectionToColorMappingText = {
	["none"] = {1,1,1,1},
	["sun"] = {1,1,0.1,1},
	["moon"] = {0.4,0.4,1,1},
}

local DirectionToColorMapping = {
	none = "Text",
	sun = "EclipseSolar",
	moon = "EclipseLunar",
}

function EclipseBar.prototype:init()
	EclipseBar.super.prototype.init(self, "EclipseBar")

	self:SetDefaultColor("EclipseLunar", 35, 104, 231)
	self:SetDefaultColor("EclipseLunarActive", 35, 104, 231)
	self:SetDefaultColor("EclipseSolar", 190, 210, 31)
	self:SetDefaultColor("EclipseSolarActive", 238, 251, 31)
end

function EclipseBar.prototype:Redraw()
	EclipseBar.super.prototype.Redraw(self)
	self:MyOnUpdate()
end

function EclipseBar.prototype:GetOptions()
	local opts = EclipseBar.super.prototype.GetOptions(self)
	opts.reverse.hidden = true
	return opts
end

function EclipseBar.prototype:GetDefaultSettings()
	local defaults =  EclipseBar.super.prototype.GetDefaultSettings(self)

	defaults.textVisible.lower = false
	defaults.offset = -1
	defaults.enabled = true
	defaults.textVerticalOffset = 13
	defaults.textHorizontalOffset = 12
	defaults.lockUpperTextAlpha = false
	defaults.markers[1] = {
		position = 0,
		color = {r=1, g=0, b=0, a=1},
		height = 6,
	}
	defaults.bAllowExpand = false

	return defaults
end

function EclipseBar.prototype:Enable(core)
	EclipseBar.super.prototype.Enable(self, core)

	self:RegisterEvent("UPDATE_SHAPESHIFT_FORM", "UpdateShown")
	self:RegisterEvent("PLAYER_TALENT_UPDATE", "UpdateShown")
	self:RegisterEvent("MASTERY_UPDATE", "UpdateShown")
	self:RegisterEvent("PLAYER_TARGET_CHANGED", "UpdateShown")
	self:RegisterEvent("UNIT_AURA", "UpdateEclipseBuffs")
	self:RegisterEvent("ECLIPSE_DIRECTION_CHANGE", "UpdateEclipseDirection")

	self:UpdateEclipseDirection()
	self:UpdateEclipseBuffs()
	self:UpdateShown()
end

function EclipseBar.prototype:Disable(core)
	EclipseBar.super.prototype.Disable(self, core)
end

-- note that isNone is not passed by the ECLIPSE_DIRECTION_CHANGE event, only manually via :Enable
function EclipseBar.prototype:UpdateEclipseDirection()
	self.direction = GetEclipseDirection()
	self:UpdateEclipsePower()
end

function EclipseBar.prototype:SetBarVisibility(visible)
	EclipseBar.super.prototype.SetBarVisibility(self, visible)

	if not self.solarBar then
		return
	end
	
	if visible then
		self.solarBar:Show()
	else
		self.solarBar:Hide()
	end
end

function EclipseBar.prototype:CreateFrame()
	EclipseBar.super.prototype.CreateFrame(self)

	self:CreateSolarBar()
	self:UpdateShown()
	self:UpdateAlpha()
end

function EclipseBar.prototype:CreateSolarBar()
	self.solarBar = self:BarFactory(self.solarBar,"BACKGROUND", "ARTWORK")
	self:SetBarCoord(self.solarBar, 0.5, true)

	self.solarBar.bar:SetVertexColor(self:GetColor("EclipseSolar", 1))
	self.solarBar.bar:Show()
end

function EclipseBar.prototype:UpdateShown()
	local form = GetShapeshiftFormID()
	local Inst, InstType = IsInInstance()
	if form == MOONKIN_FORM or not form then
		if ( (GetSpecialization() == 1 and not(UnitInVehicle("player")) ) and 
			( (Inst and (InstType == "pvp" or InstType == "arena")) or 
			(UnitExists("target") and UnitCanAttack("player", "target") and not(UnitIsDeadOrGhost("target"))) ) ) then
			self:Show(true)
		else
			self:Show(false)
		end
	else
		self:Show(false)
	end
end

function EclipseBar.prototype:UseTargetAlpha(scale)
	return UnitPower("player", SPELL_POWER_ECLIPSE) ~= 0 and self.combat
end

function EclipseBar.prototype:UpdateEclipseBuffs()
	local buffStatus = nibIceHUD:HasBuffs("player", {ECLIPSE_BAR_SOLAR_BUFF_ID, ECLIPSE_BAR_LUNAR_BUFF_ID})
	local hasSolar = buffStatus[1]
	local hasLunar = buffStatus[2]

	if hasSolar then
		self.barUpdateColor = "EclipseSolarActive"
		self.solarBar.bar:SetVertexColor(self:GetColor("EclipseSolarActive", 1))
	elseif hasLunar then
		self.barUpdateColor = "EclipseLunarActive"
		self.solarBar.bar:SetVertexColor(self:GetColor("EclipseLunarActive", 1))
	else
		self.barUpdateColor = "EclipseLunar"
		self.solarBar.bar:SetVertexColor(self:GetColor("EclipseSolar", 1))
	end
end

function EclipseBar.prototype:UpdateEclipsePower()
	local power = UnitPower("player", SPELL_POWER_ECLIPSE)
	local maxPower = UnitPowerMax("player", SPELL_POWER_ECLIPSE)

	-- bad api, bad.
	if maxPower <= 0 or power > maxPower then
		return
	end

	--self:SetBottomText1(abs((power/maxPower) * 100), DirectionToColorMapping[self.direction])

-- i'm rather fond of this solution so i'm keeping it around...the correct fix was in IceBarElement to set the upper text color
-- but hey, this would have been sweet.
	
	local r,g,b
	local color = DirectionToColorMappingText[self.direction]
	r,g,b = color[1], color[2], color[3]
	self:SetBottomText1(string.format("|c%x%x%x%x%d|r",
		self.alpha * 255,
		r * 255,
		g * 255,
		b * 255,
		abs((power/maxPower) * 100))
	)
	
	local pos = ((power/maxPower) / 2) + 0.5
	self:PositionMarker(1, pos)
end

function EclipseBar.prototype:MyOnUpdate()
	self:Update()

	self:UpdateEclipsePower()
	self:UpdateBar(0.5, self.barUpdateColor, 1)
	self:UpdateAlpha()
end

local _, unitClass = UnitClass("player")
if unitClass == "DRUID" then
	nibIceHUD.EclipseBar = EclipseBar:new()
end
