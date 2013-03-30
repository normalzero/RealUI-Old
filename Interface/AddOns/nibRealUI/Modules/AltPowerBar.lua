local nibRealUI = LibStub("AceAddon-3.0"):GetAddon("nibRealUI")
local LSM = LibStub("LibSharedMedia-3.0")
local db, ndbc
local mass

if IsAddOnLoaded("Massive") then
	mass = LibStub:GetLibrary("Massive")
end

local MODNAME = "AltPowerBar"
local AltPowerBar = nibRealUI:NewModule(MODNAME, "AceEvent-3.0")

local LoggedIn = false

local APBFrames = {}

local UpdateInterval = 0

-- Options
local table_AnchorPoints = {
	"BOTTOM",
	"BOTTOMLEFT",
	"BOTTOMRIGHT",
	"CENTER",
	"LEFT",
	"RIGHT",
	"TOP",
	"TOPLEFT",
	"TOPRIGHT",
}

local table_Strata = {
	"BACKGROUND",
	"LOW",
	"MEDIUM",
	"HIGH",
	"DIALOG",
}

local options
local function GetOptions()
	if not options then options = {
		type = "group",
		name = "Alt Power Bar",
		arg = MODNAME,
		childGroups = "tab",
		order = 112,
		args = {
			header = {
				type = "header",
				name = "Alt Power Bar",
				order = 10,
			},
			desc = {
				type = "description",
				name = "Replacement of the default Alternate Power Bar.",
				fontSize = "medium",
				order = 20,
			},
			enabled = {
				type = "toggle",
				name = "Enabled",
				desc = "Enable/Disable the Alt Power Bar module.",
				get = function() return nibRealUI:GetModuleEnabled(MODNAME) end,
				set = function(info, value) 
					nibRealUI:SetModuleEnabled(MODNAME, value)
				end,
				order = 30,
			},
			gap1 = {
				name = " ",
				type = "description",
				order = 31,
			},
			size = {
				name = "Size",
				type = "group",
				disabled = function() if nibRealUI:GetModuleEnabled(MODNAME) then return false else return true end end,
				inline = true,
				order = 50,
				args = {
					width = {
						type = "input",
						name = "Width",
						width = "half",
						order = 10,
						get = function(info) return tostring(db.size.width) end,
						set = function(info, value)
							value = nibRealUI:ValidateOffset(value)
							db.size.width = value
							AltPowerBar:UpdatePosition()
						end,
					},
					height = {
						type = "input",
						name = "Height",
						width = "half",
						order = 20,
						get = function(info) return tostring(db.size.height) end,
						set = function(info, value)
							value = nibRealUI:ValidateOffset(value)
							db.size.height = value
							AltPowerBar:UpdatePosition()
						end,
					},
				},							
			},
			gap2 = {
				name = " ",
				type = "description",
				order = 51,
			},
			position = {
				name = "Position",
				type = "group",
				disabled = function() if nibRealUI:GetModuleEnabled(MODNAME) then return false else return true end end,
				inline = true,
				order = 60,
				args = {
					position = {
						name = "Position",
						type = "group",
						inline = true,
						order = 10,
						args = {
							xoffset = {
								type = "input",
								name = "X Offset",
								width = "half",
								order = 10,
								get = function(info) return tostring(db.position.x) end,
								set = function(info, value)
									value = nibRealUI:ValidateOffset(value)
									db.position.x = value
									AltPowerBar:UpdatePosition()
								end,
							},
							yoffset = {
								type = "input",
								name = "Y Offset",
								width = "half",
								order = 20,
								get = function(info) return tostring(db.position.y) end,
								set = function(info, value)
									value = nibRealUI:ValidateOffset(value)
									db.position.y = value
									AltPowerBar:UpdatePosition()
								end,
							},
							anchorto = {
								type = "select",
								name = "Anchor To",
								get = function(info) 
									for k,v in pairs(table_AnchorPoints) do
										if v == db.position.anchorto then return k end
									end
								end,
								set = function(info, value)
									db.position.anchorto = table_AnchorPoints[value]
									AltPowerBar:UpdatePosition()
								end,
								style = "dropdown",
								width = nil,
								values = table_AnchorPoints,
								order = 30,
							},
							anchorfrom = {
								type = "select",
								name = "Anchor From",
								get = function(info) 
									for k,v in pairs(table_AnchorPoints) do
										if v == db.position.anchorfrom then return k end
									end
								end,
								set = function(info, value)
									db.position.anchorfrom = table_AnchorPoints[value]
									AltPowerBar:UpdatePosition()
								end,
								style = "dropdown",
								width = nil,
								values = table_AnchorPoints,
								order = 40,
							},
						},
					},
				},
			},
			gap3 = {
				name = " ",
				type = "description",
				order = 61,
			},
			colors = {
				name = "Colors",
				type = "group",
				disabled = function() if nibRealUI:GetModuleEnabled(MODNAME) then return false else return true end end,
				inline = true,
				order = 70,
				args = {
					background = {
						type = "color",
						name = "Background",
						hasAlpha = true,
						get = function(info,r,g,b,a)
							return db.colors.background.r, db.colors.background.g, db.colors.background.b, db.colors.background.a
						end,
						set = function(info,r,g,b,a)
							db.colors.background.r = r
							db.colors.background.g = g
							db.colors.background.b = b
							db.colors.background.a = a
							AltPowerBar:UpdateColors()
						end,
						order = 10,
					},
					border = {
						type = "color",
						name = "Border",
						hasAlpha = true,
						get = function(info,r,g,b,a)
							return db.colors.border.r, db.colors.border.g, db.colors.border.b, db.colors.border.a
						end,
						set = function(info,r,g,b,a)
							db.colors.border.r = r
							db.colors.border.g = g
							db.colors.border.b = b
							db.colors.border.a = a
							AltPowerBar:UpdateColors()
						end,
						order = 20,
					},
					statusbar = {
						type = "color",
						name = "Status Bar",
						hasAlpha = true,
						get = function(info,r,g,b,a)
							return db.colors.statusbar.r, db.colors.statusbar.g, db.colors.statusbar.b, db.colors.statusbar.a
						end,
						set = function(info,r,g,b,a)
							db.colors.statusbar.r = r
							db.colors.statusbar.g = g
							db.colors.statusbar.b = b
							db.colors.statusbar.a = a
							AltPowerBar:UpdateColors()
						end,
						order = 30,
					},
				},
			},
		},
	}
	end
	return options
end

-- Events
function AltPowerBar:PowerUpdate()
	if UnitAlternatePowerInfo("player") then
		APBFrames.bg:Show()
		APBFrames.bar:Show()
	else
		APBFrames.bg:Hide()
		APBFrames.bar:Hide()
	end
end

-- Colors
function AltPowerBar:UpdateColors()
	-- BG + Border
	APBFrames.bg:SetBackdropColor(db.colors.background.r, db.colors.background.g, db.colors.background.b, db.colors.background.a)
	APBFrames.bg:SetBackdropBorderColor(db.colors.border.r, db.colors.border.g, db.colors.border.b, db.colors.border.a)
	
	-- Bar
	APBFrames.bar:SetStatusBarColor(db.colors.statusbar.r, db.colors.statusbar.g, db.colors.statusbar.b, db.colors.statusbar.a)
end

-- Font
function AltPowerBar:UpdateFont()
	-- Text
	APBFrames.text:SetFont(unpack(nibRealUI.font.pixel1))
end

-- Position
function AltPowerBar:UpdatePosition()
	-- BG + Border
	APBFrames.bg:SetPoint(db.position.anchorfrom, UIParent, db.position.anchorto, db.position.x, db.position.y)
	
	APBFrames.bg:SetFrameStrata("MEDIUM")
	APBFrames.bg:SetFrameLevel(1)
	
	APBFrames.bg:SetHeight(db.size.height)
	APBFrames.bg:SetWidth(db.size.width)
end

-- Refresh
function AltPowerBar:RefreshMod()
	if not nibRealUI:GetModuleEnabled(MODNAME) then return end

	db = self.db.profile
	
	AltPowerBar:UpdatePosition()
	AltPowerBar:UpdateFont()
	AltPowerBar:UpdateColors()
end

function AltPowerBar:PLAYER_LOGIN()
	LoggedIn = true
	AltPowerBar:RefreshMod()
	AltPowerBar:PowerUpdate()
end

-- Create Frames
function AltPowerBar:CreateFrames()
	APBFrames = {
		bg = nil,
		bar = nil,
		text = nil,
	}
	
	-- BG + Border
	APBFrames.bg = CreateFrame("Frame", "nibRealUI_AltPowerBarBG", UIParent)
	APBFrames.bg:SetPoint(db.position.anchorfrom, UIParent, db.position.anchorto, db.position.x, db.position.y)	
	
	APBFrames.bg:SetBackdrop({
		bgFile = nibRealUI.media.textures.plain, 
		edgeFile = nibRealUI.media.textures.plain, 
		tile = false, tileSize = 0, edgeSize = 1, 
		insets = { left = 0, right = 0, top = 0, bottom = 0}
	})

	-- Bar + Text
	APBFrames.bar = CreateFrame("StatusBar", "nibRealUI_AltPowerBar", APBFrames.bg)
	APBFrames.bar:SetStatusBarTexture(nibRealUI.media.textures.plain)
	APBFrames.bar:SetMinMaxValues(0, 100)
	APBFrames.bar:SetPoint("TOPLEFT", APBFrames.bg, "TOPLEFT", 1, -1)
	APBFrames.bar:SetPoint("BOTTOMRIGHT", APBFrames.bg, "BOTTOMRIGHT", -1, 1)

	APBFrames.text = APBFrames.bar:CreateFontString(nil, "OVERLAY")
	APBFrames.text:SetPoint("CENTER", APBFrames.bar, "CENTER", 0, 0.5 + db.resolution[ndbc.resolution].texty)
	APBFrames.text:SetFont(unpack(nibRealUI.font.pixel1))
	APBFrames.text:SetTextColor(1, 1, 1, 1)

	-- Update Power
	UpdateInterval = 0
	APBFrames.bar:SetScript("OnUpdate", function(self, elapsed)
		UpdateInterval = UpdateInterval + elapsed 
		
		if UpdateInterval > 0.1 then
			self:SetMinMaxValues(0, UnitPowerMax("player", ALTERNATE_POWER_INDEX))
			local CurPower = UnitPower("player", ALTERNATE_POWER_INDEX)
			local MaxPower = UnitPowerMax("player", ALTERNATE_POWER_INDEX)
			self:SetValue(CurPower)
			if MaxPower > 0 then
				APBFrames.text:SetText(CurPower.."/"..MaxPower)
			else
				APBFrames.text:SetText("0")
			end
			UpdateInterval = 0
		end
	end)
	
	APBFrames.bg:Hide()
end

-- Initialize
function AltPowerBar:OnInitialize()
	self.db = nibRealUI.db:RegisterNamespace(MODNAME)
	self.db:RegisterDefaults({
		profile = {
			size = {width = 180, height = 20},
			position = {
				anchorto = "TOP",
				anchorfrom = "TOP",
				x = 0,
				y = -200,
			},
			colors = {
				background = {r = 0, g = 0, b = 0, a = 0.5},
				border = {r = 0, g = 0, b = 0, a = 1},
				statusbar = {r = 0, g = 0.7, b = 0, a = 0.85},				
			},
			resolution = {
				[1] = {
					texty = 0,
				},
				[2] = {
					texty = -1,
				},
			},
		},
	})
	db = self.db.profile
	ndbc = nibRealUI.db.char
	
	self:SetEnabledState(nibRealUI:GetModuleEnabled(MODNAME))
	nibRealUI:RegisterModuleOptions(MODNAME, GetOptions)
	
	AltPowerBar:CreateFrames()
end

function AltPowerBar:OnEnable()
	self:RegisterEvent("PLAYER_LOGIN")
	self:RegisterEvent("UNIT_POWER", "PowerUpdate")
	self:RegisterEvent("UNIT_POWER_BAR_SHOW", "PowerUpdate")
	self:RegisterEvent("UNIT_POWER_BAR_HIDE", "PowerUpdate")
	
	-- Hide Default
	PlayerPowerBarAlt:SetAlpha(0)
	
	if LoggedIn then
		AltPowerBar:RefreshMod()
		AltPowerBar:PowerUpdate()
	end
end

function AltPowerBar:OnDisable()
	self:UnregisterEvent("PLAYER_LOGIN")
	self:UnregisterEvent("UNIT_POWER")
	self:UnregisterEvent("UNIT_POWER_BAR_SHOW")
	self:UnregisterEvent("UNIT_POWER_BAR_HIDE")
	
	APBFrames.bg:Hide()
	PlayerPowerBarAlt:SetAlpha(1)
end