local nibRealUI = LibStub("AceAddon-3.0"):GetAddon("nibRealUI")

function nibRealUI:MiniPatch(ver)
	-- 7.3 r1
	if ver == "73r1" then
		if IsAddOnLoaded("nibIceHUD") and IceCoreRealUIDB then
			if IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Dru-Sunfire"] then
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Dru-Sunfire"]["barHorizontalOffset"] = -4
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Dru-Sunfire"]["barVerticalOffset"] = 33
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Dru-Sunfire"]["scale"] = 0.745
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Dru-Sunfire"]["widthModifier"] = -22
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Dru-Sunfire"]["textVerticalOffset"] = 12
			end
			if IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Dru-Sunfire"] then
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Dru-Sunfire"]["barHorizontalOffset"] = -4
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Dru-Sunfire"]["barVerticalOffset"] = 33
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Dru-Sunfire"]["scale"] = 0.745
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Dru-Sunfire"]["widthModifier"] = -22
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Dru-Sunfire"]["textVerticalOffset"] = 14
			end
		end
	elseif ver == "73r5" then
		if IsAddOnLoaded("nibRealUI") and nibRealUIDB then
			if nibRealUIDB["namespaces"]["FrameMover"]["profiles"]["RealUI"]["uiframes"]["achievementalert"] then
				nibRealUIDB["namespaces"]["FrameMover"]["profiles"]["RealUI"]["uiframes"]["achievementalert"]["move"] = false
			end
		end
	elseif ver == "73r6" then
		if IsAddOnLoaded("nibIceHUD") and IceCoreRealUIDB then
			if IceCoreRealUIDB["profiles"]["RealUI"]["modules"] then
				IceCoreRealUIDB["profiles"]["RealUI"]["modules"]["zCT-Mon-RisingSunKick"] = {
					["shouldAnimate"] = false,
					["class"] = "MONK",
					["lockLowerTextAlpha"] = false,
					["lockLowerFontAlpha"] = false,
					["hideAnimationSettings"] = true,
					["desiredLerpTime"] = 0,
					["enabled"] = true,
					["scaleManaColor"] = true,
					["barColor"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 0.3882352941176471,
						["b"] = 0,
					},
					["barHorizontalOffset"] = 3,
					["maxDuration"] = 0,
					["myUnit"] = "target",
					["reverse"] = false,
					["customBarType"] = "Bar",
					["upperText"] = "RSK",
					["lowerText"] = "",
					["buffOrDebuff"] = "debuff",
					["lowerTextColor"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["alwaysFullAlpha"] = false,
					["barFontSize"] = 8,
					["textVerticalOffset"] = 5,
					["offset"] = 2,
					["myTagVersion"] = 3,
					["exactMatch"] = true,
					["scale"] = 0.775,
					["barVerticalOffset"] = 27.5,
					["forceJustifyText"] = "RIGHT",
					["side"] = "RIGHT",
					["buffToTrack"] = "107428",
					["buffTimerDisplay"] = "seconds",
					["textHorizontalOffset"] = -1,
					["shouldUseOverride"] = false,
					["widthModifier"] = -16,
					["textVisible"] = {
						["upper"] = true,
						["lower"] = false,
					},
					["lockUpperTextAlpha"] = true,
					["lowerTextVisible"] = false,
					["lowThresholdColor"] = false,
					["auraIconXOffset"] = 40,
					["trackOnlyMine"] = true,
					["upperTextColor"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["spec"] = {
						["spec3"] = true,
						["spec1"] = false,
						["spec4"] = false,
						["spec2"] = false,
					},
				}
			end
			if IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"] then
				IceCoreRealUIDB["profiles"]["RealUI-HR"]["modules"]["zCT-Mon-RisingSunKick"] = {
					["shouldAnimate"] = false,
					["class"] = "MONK",
					["lockLowerTextAlpha"] = false,
					["lockLowerFontAlpha"] = false,
					["hideAnimationSettings"] = true,
					["desiredLerpTime"] = 0,
					["enabled"] = true,
					["scaleManaColor"] = true,
					["barColor"] = {
						["a"] = 1,
						["r"] = 1,
						["g"] = 0.3882352941176471,
						["b"] = 0,
					},
					["barHorizontalOffset"] = 3,
					["maxDuration"] = 0,
					["myUnit"] = "target",
					["reverse"] = false,
					["customBarType"] = "Bar",
					["upperText"] = "RSK",
					["lowerText"] = "",
					["buffOrDebuff"] = "debuff",
					["lowerTextColor"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["alwaysFullAlpha"] = false,
					["barFontSize"] = 8,
					["textVerticalOffset"] = 5,
					["offset"] = 2,
					["myTagVersion"] = 3,
					["exactMatch"] = true,
					["scale"] = 0.775,
					["barVerticalOffset"] = 27.5,
					["forceJustifyText"] = "RIGHT",
					["side"] = "RIGHT",
					["buffToTrack"] = "107428",
					["buffTimerDisplay"] = "seconds",
					["textHorizontalOffset"] = -6,
					["shouldUseOverride"] = false,
					["widthModifier"] = -16,
					["textVisible"] = {
						["upper"] = true,
						["lower"] = false,
					},
					["lockUpperTextAlpha"] = true,
					["lowerTextVisible"] = false,
					["lowThresholdColor"] = false,
					["auraIconXOffset"] = 40,
					["trackOnlyMine"] = true,
					["upperTextColor"] = {
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["spec"] = {
						["spec3"] = true,
						["spec1"] = false,
						["spec4"] = false,
						["spec2"] = false,
					},
				}
			end
		end
	elseif ver == "73r9" then
		if IsAddOnLoaded("nibPointDisplay_RealUI") and nibPointDisplayRUIDB then
			if nibPointDisplayRUIDB["profiles"]["RealUI"]["ROGUE"]["types"]["dp"]["bars"]["bg"] then
				nibPointDisplayRUIDB["profiles"]["RealUI"]["ROGUE"]["types"]["dp"]["bars"]["bg"]["full"] = {
					["color"] = {
						["a"] = 1,
						["r"] = 0.8235294117647058,
						["g"] = 0.8235294117647058,
						["b"] = 0,
					},
					["maxcolor"] = {
						["r"] = 0.9411764705882353,
						["g"] = 0.9411764705882353,
						["b"] = 0,
					},
					["texture"] = "Round_Small_BG",
				}
			end
			if nibPointDisplayRUIDB["profiles"]["RealUI"]["MONK"]["types"]["tp"] then
				nibPointDisplayRUIDB["profiles"]["RealUI"]["MONK"]["types"]["tp"]["position"] = {
					["y"] = -52,
					["x"] = -66,
				}
			end
			if nibPointDisplayRUIDB["profiles"]["RealUI"]["MONK"]["types"]["sz"] then
				nibPointDisplayRUIDB["profiles"]["RealUI"]["MONK"]["types"]["sz"]["position"] = {
					["y"] = -25,
					["x"] = -83,
				}
			end
			if nibPointDisplayRUIDB["profiles"]["RealUI"]["MONK"]["types"]["vm"] then
				nibPointDisplayRUIDB["profiles"]["RealUI"]["MONK"]["types"]["vm"]["position"] = {
					["y"] = -52,
					["x"] = -63,
				}
			end
			if nibPointDisplayRUIDB["profiles"]["RealUI"]["MONK"]["types"]["chi"] then
				nibPointDisplayRUIDB["profiles"]["RealUI"]["MONK"]["types"]["chi"]["position"] = {
					["y"] = -39,
					["x"] = -64,
				}
			end
			if nibPointDisplayRUIDB["profiles"]["RealUI"]["WARLOCK"]["types"]["be"] then
				nibPointDisplayRUIDB["profiles"]["RealUI"]["WARLOCK"]["types"]["be"]["position"] = {
					["y"] = -38,
					["x"] = -70,
				}
			end
			if nibPointDisplayRUIDB["profiles"]["RealUI-HR"]["ROGUE"]["types"]["dp"]["bars"]["bg"] then
				nibPointDisplayRUIDB["profiles"]["RealUI-HR"]["ROGUE"]["types"]["dp"]["bars"]["bg"]["full"] = {
					["color"] = {
						["a"] = 1,
						["r"] = 0.8235294117647058,
						["g"] = 0.8235294117647058,
						["b"] = 0,
					},
					["maxcolor"] = {
						["r"] = 0.9411764705882353,
						["g"] = 0.9411764705882353,
						["b"] = 0,
					},
					["texture"] = "Round_Small_BG",
				}
			end
			if nibPointDisplayRUIDB["profiles"]["RealUI-HR"]["ROGUE"]["types"]["dp"] then
				nibPointDisplayRUIDB["profiles"]["RealUI-HR"]["ROGUE"]["types"]["dp"]["position"] = {
					["y"] = -51,
					["x"] = -79,
				}
			end
			if nibPointDisplayRUIDB["profiles"]["RealUI-HR"]["MONK"]["types"]["tp"] then
				nibPointDisplayRUIDB["profiles"]["RealUI-HR"]["MONK"]["types"]["tp"]["position"] = {
					["y"] = -52,
					["x"] = -66,
				}
			end
			if nibPointDisplayRUIDB["profiles"]["RealUI-HR"]["MONK"]["types"]["sz"] then
				nibPointDisplayRUIDB["profiles"]["RealUI-HR"]["MONK"]["types"]["sz"]["position"] = {
					["y"] = -22,
					["x"] = -97,
				}
			end
			if nibPointDisplayRUIDB["profiles"]["RealUI-HR"]["MONK"]["types"]["vm"] then
				nibPointDisplayRUIDB["profiles"]["RealUI-HR"]["MONK"]["types"]["vm"]["position"] = {
					["y"] = -52,
					["x"] = -78,
				}
			end
			if nibPointDisplayRUIDB["profiles"]["RealUI-HR"]["MONK"]["types"]["chi"] then
				nibPointDisplayRUIDB["profiles"]["RealUI-HR"]["MONK"]["types"]["chi"]["position"] = {
					["y"] = -37,
					["x"] = -74,
				}
			end
			if nibPointDisplayRUIDB["profiles"]["RealUI-HR"]["WARLOCK"]["types"]["be"] then
				nibPointDisplayRUIDB["profiles"]["RealUI-HR"]["WARLOCK"]["types"]["be"]["position"] = {
					["y"] = -38,
					["x"] = -88,
				}
			end
		end
	end
end