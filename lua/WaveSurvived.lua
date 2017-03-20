WaveSurvived = {}

WaveSurvived.modpath = ModPath
WaveSurvived.logpath = LogsPath
WaveSurvived.savepath = SavePath
WaveSurvived.savefile = SavePath .. "/WaveSurvived_options.txt"

WaveSurvived.locfile_english = ModPath .. "/loc/english.txt"
WaveSurvived.locfile_french = ModPath .. "/loc/french.txt"
WaveSurvived.locfile_russian = ModPath .. "/loc/russian.txt"
WaveSurvived.locfile_italian = ModPath .. "/loc/italian.txt"
WaveSurvived.locfile_german = ModPath .. "/loc/german.txt"
WaveSurvived.locfile_spanish = ModPath .. "/loc/spanish.txt"
WaveSurvived.locfile_hungarian = ModPath .. "/loc/hungarian.txt"
WaveSurvived.locfile_korean = ModPath .. "/loc/korean.txt"

WaveSurvived.options = {}

Hooks:Add("NetworkReceivedData", "NetworkWaveSurvived", function(sender, id, data)
	local Net = _G.LuaNetworking
	local mod_key = "WaveSurvived_Net"
    if id == mod_key then
    	log("[WaveSurvived] mod_key is ok")
    	WaveSurvived = {}
		WaveSurvived.options = {}

		function Load()
			local file = io.open( SavePath .. "/WaveSurvived_options.txt" , "r")
			if file then
				for k, v in pairs(json.decode(file:read("*all")) or {}) do
					if k then
						WaveSurvived.options[k] = v
					end
				end
				file:close()
				log("[WaveSurvived] Loaded Settings")
			end
		end

		Load()

		function get_endless_assault_strings()
			if WaveSurvived.options["WaveSurvived_endless_customtext"] then
				if managers.job:current_difficulty_stars() > 0 then
					local ids_risk = Idstring("risk")
					return {
						"WaveSurvived_endless_customtext_" .. WaveSurvived.options["WaveSurvived_endless_customtext"],
						"hud_assault_end_line",
						ids_risk,
						"hud_assault_end_line",
						"WaveSurvived_endless_customtext_" .. WaveSurvived.options["WaveSurvived_endless_customtext"],
						"hud_assault_end_line",
						ids_risk,
						"hud_assault_end_line"
					}
				else
					return {
						"WaveSurvived_endless_customtext_" .. WaveSurvived.options["WaveSurvived_endless_customtext"],
						"hud_assault_end_line",
						"WaveSurvived_endless_customtext_" .. WaveSurvived.options["WaveSurvived_endless_customtext"],
						"hud_assault_end_line",
						"WaveSurvived_endless_customtext_" .. WaveSurvived.options["WaveSurvived_endless_customtext"],
						"hud_assault_end_line"
					}
				end
			else
				if managers.job:current_difficulty_stars() > 0 then
					local ids_risk = Idstring("risk")
					return {
						"WaveSurvived_endless_customtext_1",
						"hud_assault_end_line",
						ids_risk,
						"hud_assault_end_line",
						"WaveSurvived_endless_customtext_1",
						"hud_assault_end_line",
						ids_risk,
						"hud_assault_end_line"
					}
				else
					return {
						"WaveSurvived_endless_customtext_1",
						"hud_assault_end_line",
						"WaveSurvived_endless_customtext_1",
						"hud_assault_end_line",
						"WaveSurvived_endless_customtext_1",
						"hud_assault_end_line"
					}
				end
			end
		end

		if data == "endless" then
    		log("[WaveSurvived] data is ok.")
			if WaveSurvived.options["WaveSurvived_compatibility"] == 1 then
    			log("[WaveSurvived] compatibility is ok. processing...")
				if WaveSurvived.options["WaveSurvived_custompanelcolor_endless"] == 1 then
					managers.hud._hud_assault_corner:_update_assault_hud_color(Color(255, 255, 0, 0) / 255)
    				log("[WaveSurvived] Updated assault color panel 1")
			 	elseif WaveSurvived.options["WaveSurvived_custompanelcolor_endless"] == 2 then
					managers.hud._hud_assault_corner:_update_assault_hud_color(Color(255, 255, 255, 0) / 255)
    				log("[WaveSurvived] Updated assault color panel 2")
			 	elseif WaveSurvived.options["WaveSurvived_custompanelcolor_endless"] == 3 then
					managers.hud._hud_assault_corner:_update_assault_hud_color(Color(255, 32, 230, 32) / 255)
    				log("[WaveSurvived] Updated assault color panel 3")
			 	elseif WaveSurvived.options["WaveSurvived_custompanelcolor_endless"] == 4 then
					managers.hud._hud_assault_corner:_update_assault_hud_color(Color(255, 0, 255, 255) / 255)
    				log("[WaveSurvived] Updated assault color panel 4")
			 	elseif WaveSurvived.options["WaveSurvived_custompanelcolor_endless"] == 5 then
					managers.hud._hud_assault_corner:_update_assault_hud_color(Color(255, 255, 127, 80) / 255)
    				log("[WaveSurvived] Updated assault color panel 5")
			 	elseif WaveSurvived.options["WaveSurvived_custompanelcolor_endless"] == 6 then
					managers.hud._hud_assault_corner:_update_assault_hud_color(Color(255, WaveSurvived.options["WaveSurvived_custompanelcolor_endless_customslider_red"], WaveSurvived.options["WaveSurvived_custompanelcolor_endless_customslider_green"], WaveSurvived.options["WaveSurvived_custompanelcolor_endless_customslider_blue"]) / 255)
    				log("[WaveSurvived] Updated assault color panel 6")	
			 	else	
					managers.hud._hud_assault_corner:_update_assault_hud_color(Color(1, 1, 0, 0))
    				log("[WaveSurvived] Updated assault color panel (no match)")
			 	end

			 	managers.hud._hud_assault_corner:_set_text_list(get_endless_assault_strings())
			end

			if WaveSurvived.options["WaveSurvived_compatibility"] == 3 then
				local assault_panel = managers.hud._hud_assault_corner._hud_panel:child("assault_panel")
				local control_assault_title = assault_panel:child("control_assault_title")
				local icon_assaultbox = assault_panel:child("icon_assaultbox")

				if WaveSurvived.options["WaveSurvived_custompanelcolor_endless"] == 1 then
		    		icon_assaultbox:set_color(Color(255, 255, 0, 0) / 255)
		    		control_assault_title:set_color(Color(255, 255, 0, 0) / 255)
			 	elseif WaveSurvived.options["WaveSurvived_custompanelcolor_endless"] == 2 then
			 		icon_assaultbox:set_color(Color(255, 255, 255, 0) / 255)
		    		control_assault_title:set_color(Color(255, 255, 255, 0) / 255)
			 	elseif WaveSurvived.options["WaveSurvived_custompanelcolor_endless"] == 3 then
			 		icon_assaultbox:set_color(Color(255, 32, 230, 32) / 255)
		    		control_assault_title:set_color(Color(255, 32, 230, 32) / 255)
			 	elseif WaveSurvived.options["WaveSurvived_custompanelcolor_endless"] == 4 then
			 		icon_assaultbox:set_color(Color(255, 0, 255, 255) / 255)
		    		control_assault_title:set_color(Color(255, 0, 255, 255) / 255)
			 	elseif WaveSurvived.options["WaveSurvived_custompanelcolor_endless"] == 5 then
			 		icon_assaultbox:set_color(Color(255, 255, 127, 80) / 255)
		    		control_assault_title:set_color(Color(255, 255, 127, 80) / 255)
			 	elseif WaveSurvived.options["WaveSurvived_custompanelcolor_endless"] == 6 then
			 		icon_assaultbox:set_color(Color(255, WaveSurvived.options["WaveSurvived_custompanelcolor_endless_customslider_red"], WaveSurvived.options["WaveSurvived_custompanelcolor_endless_customslider_green"], WaveSurvived.options["WaveSurvived_custompanelcolor_endless_customslider_blue"]) / 255)
		    		control_assault_title:set_color(Color(255, WaveSurvived.options["WaveSurvived_custompanelcolor_endless_customslider_red"], WaveSurvived.options["WaveSurvived_custompanelcolor_endless_customslider_green"], WaveSurvived.options["WaveSurvived_custompanelcolor_endless_customslider_blue"]) / 255)
			 	else	
					icon_assaultbox:set_color(Color.black)
		    		control_assault_title:set_color(Color.white)
			 	end

		    	control_assault_title:set_text("ENDLESS")
			end

			if WaveSurvived.options["WaveSurvived_compatibility"] == 5 then
				if WaveSurvived.options["WaveSurvived_custompanelcolor_endless"] == 1 then
					managers.hud._hud_assault_corner:_update_assault_hud_color(Color(255, 255, 0, 0) / 255)
			 	elseif WaveSurvived.options["WaveSurvived_custompanelcolor_endless"] == 2 then
					managers.hud._hud_assault_corner:_update_assault_hud_color(Color(255, 255, 255, 0) / 255)
			 	elseif WaveSurvived.options["WaveSurvived_custompanelcolor_endless"] == 3 then
					managers.hud._hud_assault_corner:_update_assault_hud_color(Color(255, 32, 230, 32) / 255)
			 	elseif WaveSurvived.options["WaveSurvived_custompanelcolor_endless"] == 4 then
					managers.hud._hud_assault_corner:_update_assault_hud_color(Color(255, 0, 255, 255) / 255)
			 	elseif WaveSurvived.options["WaveSurvived_custompanelcolor_endless"] == 5 then
					managers.hud._hud_assault_corner:_update_assault_hud_color(Color(255, 255, 127, 80) / 255)
			 	elseif WaveSurvived.options["WaveSurvived_custompanelcolor_endless"] == 6 then
					managers.hud._hud_assault_corner:_update_assault_hud_color(Color(255, WaveSurvived.options["WaveSurvived_custompanelcolor_endless_customslider_red"], WaveSurvived.options["WaveSurvived_custompanelcolor_endless_customslider_green"], WaveSurvived.options["WaveSurvived_custompanelcolor_endless_customslider_blue"]) / 255)
			 	else	
					managers.hud._hud_assault_corner:_update_assault_hud_color(Color(1, 1, 0, 0))
			 	end

			 	managers.hud._hud_assault_corner:_set_text_list(managers.hud._hud_assault_corner._get_endless_assault_strings())
			end
		end
    end
end)

function WaveSurvived:Load()
	local file = io.open( self.savefile , "r")
	if file then
		for k, v in pairs(json.decode(file:read("*all")) or {}) do
			if k then
				WaveSurvived.options[k] = v
			end
		end
		file:close()
		log("[WaveSurvived] Loaded Settings")
	end
end

function WaveSurvived:Save()
	if file.DirectoryExists( self.savepath ) then	
		local file = io.open( self.savefile , "w+")
		if file then
			file:write(json.encode(WaveSurvived.options))
			file:close()
			log("[WaveSurvived] Saved settings")
		end
	end
end

function WaveSurvived:LoadCustomScript(name)
	return dofile(ModPath .. "/custom_scripts/" .. name .. ".lua")
end

MenuCallbackHandler.WaveSurvived_enable_checks_callback = function(self, item)
	WaveSurvived.options.WaveSurvived_enable_checks_value = (item:value() == "on" and true or false)
	WaveSurvived:Save()
end

MenuCallbackHandler.WaveSurvived_compatibility_callback = function(self, item)
	
	WaveSurvived.options.WaveSurvived_compatibility = item:value()

	log("[WaveSurvived] Current HUD : " .. WaveSurvived.options.WaveSurvived_compatibility)
	WaveSurvived:Save()
	
end

MenuCallbackHandler.WaveSurvived_language_callback = function(self, item)
	
	WaveSurvived.options.WaveSurvived_language = item:value()
	log("[WaveSurvived] Current language : " .. WaveSurvived.options.WaveSurvived_language)
	WaveSurvived:Save()
end

MenuCallbackHandler.WaveSurvived_duration_callback = function(self, item)
		
	WaveSurvived.options.WaveSurvived_duration = item:value()
	log("[WaveSurvived] Duration : " .. WaveSurvived.options.WaveSurvived_duration)
	WaveSurvived:Save()
	
end

MenuCallbackHandler.WaveSurvived_customtext_callback = function(self, item)
		
	WaveSurvived.options.WaveSurvived_customtext = item:value()
	log("[WaveSurvived] Custom text : " .. WaveSurvived.options.WaveSurvived_customtext)
	WaveSurvived:Save()
end

MenuCallbackHandler.WaveSurvived_endless_customtext_callback = function(self, item)
		
	WaveSurvived.options.WaveSurvived_endless_customtext = item:value()
	log("[EndlessWave] Custom text : " .. WaveSurvived.options.WaveSurvived_endless_customtext)
	WaveSurvived:Save()
end

MenuCallbackHandler.WaveSurvived_custompanelcolor_callback = function(self, item)
		
	WaveSurvived.options.WaveSurvived_custompanelcolor = item:value()
	log("[WaveSurvived] Custom color : " .. WaveSurvived.options.WaveSurvived_custompanelcolor)
	WaveSurvived:Save()
end

MenuCallbackHandler.WaveSurvived_custompanelcolor_customslider_red_callback = function(self, item)
	
	WaveSurvived.options.WaveSurvived_custompanelcolor_customslider_red = item:value()
	WaveSurvived:Save()
end

MenuCallbackHandler.WaveSurvived_custompanelcolor_customslider_green_callback = function(self, item)
	
	WaveSurvived.options.WaveSurvived_custompanelcolor_customslider_green = item:value()
	WaveSurvived:Save()
end

MenuCallbackHandler.WaveSurvived_custompanelcolor_customslider_blue_callback = function(self, item)
	
	WaveSurvived.options.WaveSurvived_custompanelcolor_customslider_blue = item:value()
	WaveSurvived:Save()
end

MenuCallbackHandler.WaveSurvived_custompanelcolor_endless_callback = function(self, item)
		
	WaveSurvived.options.WaveSurvived_custompanelcolor_endless = item:value()
	log("[EndlessWave] Custom color : " .. WaveSurvived.options.WaveSurvived_custompanelcolor_endless)
	WaveSurvived:Save()
end

MenuCallbackHandler.WaveSurvived_custompanelcolor_endless_customslider_red_callback = function(self, item)
	
	WaveSurvived.options.WaveSurvived_custompanelcolor_endless_customslider_red = item:value()
	WaveSurvived:Save()
end

MenuCallbackHandler.WaveSurvived_custompanelcolor_endless_customslider_green_callback = function(self, item)
	
	WaveSurvived.options.WaveSurvived_custompanelcolor_endless_customslider_green = item:value()
	WaveSurvived:Save()
end

MenuCallbackHandler.WaveSurvived_custompanelcolor_endless_customslider_blue_callback = function(self, item)
	
	WaveSurvived.options.WaveSurvived_custompanelcolor_endless_customslider_blue = item:value()
	WaveSurvived:Save()
end

MenuCallbackHandler.WaveSurvived_custompanelcolor_website_callback = function(self, item)
	Steam:overlay_activate("url", "http://www.rapidtables.com/web/color/RGB_Color.htm")
end

WaveSurvived:Load()

if WaveSurvived.options["WaveSurvived_compatibility"] == 1 then

	log("[WaveSurvived] Script based on: no_hud")

	WaveSurvived:LoadCustomScript("default")

elseif WaveSurvived.options["WaveSurvived_compatibility"] == 2 then
	log("[WaveSurvived] Script based on: holoui")

	WaveSurvived:LoadCustomScript("holoui")

elseif WaveSurvived.options["WaveSurvived_compatibility"] == 3 then
	log("[WaveSurvived] Script based on : pdthhud")

	WaveSurvived:LoadCustomScript("pdth_hud")

elseif WaveSurvived.options["WaveSurvived_compatibility"] == 4 then
	log("[WaveSurvived] Script based on : lddghud")

	WaveSurvived:LoadCustomScript("lddg_hud")

elseif WaveSurvived.options["WaveSurvived_compatibility"] == 5 then
	log("[WaveSurvived] Script based on : restoration")

	WaveSurvived:LoadCustomScript("restoration")
	
else -- If nothing is matching the condition, loads the default setup
	log("[WaveSurvived] Not matching anything. Loads the default setup.")
	
	WaveSurvived:LoadCustomScript("default")

end


if WaveSurvived.options["WaveSurvived_language"] == 1 then

	Hooks:Add("LocalizationManagerPostInit", "WaveSurvived_Localization", function(loc)
		loc:load_localization_file( WaveSurvived.locfile_english )
	end)
	log("[WaveSurvived] Localization [ENGLISH] loaded")

elseif WaveSurvived.options["WaveSurvived_language"] == 2 then

	Hooks:Add("LocalizationManagerPostInit", "WaveSurvived_Localization", function(loc)
		loc:load_localization_file( WaveSurvived.locfile_french )
	end)
	log("[WaveSurvived] Localization [FRENCH] loaded")

elseif WaveSurvived.options["WaveSurvived_language"] == 3 then

	Hooks:Add("LocalizationManagerPostInit", "WaveSurvived_Localization", function(loc)
		loc:load_localization_file( WaveSurvived.locfile_russian )
	end)
	log("[WaveSurvived] Localization [RUSSIAN] loaded")

elseif WaveSurvived.options["WaveSurvived_language"] == 4 then

	Hooks:Add("LocalizationManagerPostInit", "WaveSurvived_Localization", function(loc)
		loc:load_localization_file( WaveSurvived.locfile_italian )
	end)
	log("[WaveSurvived] Localization [ITALIAN] loaded")

elseif WaveSurvived.options["WaveSurvived_language"] == 5 then

	Hooks:Add("LocalizationManagerPostInit", "WaveSurvived_Localization", function(loc)
		loc:load_localization_file( WaveSurvived.locfile_german )
	end)
	log("[WaveSurvived] Localization [GERMAN] loaded")

elseif WaveSurvived.options["WaveSurvived_language"] == 6 then

	Hooks:Add("LocalizationManagerPostInit", "WaveSurvived_Localization", function(loc)
		loc:load_localization_file( WaveSurvived.locfile_spanish )
	end)
	log("[WaveSurvived] Localization [SPANISH] loaded")

elseif WaveSurvived.options["WaveSurvived_language"] == 7 then

		Hooks:Add("LocalizationManagerPostInit", "WaveSurvived_Localization", function(loc)
			loc:load_localization_file( WaveSurvived.locfile_hungarian )
		end)
		log("[WaveSurvived] Localization [HUNGARIAN] loaded")

elseif WaveSurvived.options["WaveSurvived_language"] == 8 then

		Hooks:Add("LocalizationManagerPostInit", "WaveSurvived_Localization", function(loc)
			loc:load_localization_file( WaveSurvived.locfile_korean )
		end)
		log("[WaveSurvived] Localization [KOREAN] loaded")

else -- if nothing match, loads the default localization

	Hooks:Add("LocalizationManagerPostInit", "WaveSurvived_Localization", function(loc)
		loc:load_localization_file( WaveSurvived.locfile_english )
	end)
	log("[WaveSurvived] Localization [ENGLISH] loaded")

end

MenuHelper:LoadFromJsonFile(ModPath .. "/options/menu.json", WaveSurvived, WaveSurvived.options)