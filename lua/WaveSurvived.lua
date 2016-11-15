_G.WaveSurvived = {}

WaveSurvived.modpath = ModPath
WaveSurvived.logpath = LogsPath
WaveSurvived.savepath = SavePath
WaveSurvived.savefile = SavePath .. "/WaveSurvived_options.txt"

WaveSurvived.locfile_english = ModPath .. "/loc/english.txt"
WaveSurvived.locfile_french = ModPath .. "/loc/french.txt"
WaveSurvived.locfile_russian = ModPath .. "/loc/russian.txt"

WaveSurvived.options = {}

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

if not io.file_is_readable(WaveSurvived.savefile) then

	WaveSurvived.options = {
		compatibility = "WaveSurvived_compatibility_nohud",
		language = "english"
	}

end

if MenuManager then

	MenuCallbackHandler.WaveSurvived_compatibility_callback = function(this, item)
		
		WaveSurvived.options.id_hud = tonumber(item:value()) 

		log("[WaveSurvived] Current HUD : " .. WaveSurvived.options.id_hud)

		if WaveSurvived.options.id_hud == 1 then

			WaveSurvived.options = {
			compatibility = "no_hud",
			language = WaveSurvived.options["language"]
			}

			WaveSurvived:Save()

		elseif WaveSurvived.options.id_hud == 2 then

			WaveSurvived.options = {
			compatibility = "holoui",
			language = WaveSurvived.options["language"]
			}
			
			WaveSurvived:Save()

		elseif WaveSurvived.options.id_hud == 3 then

			WaveSurvived.options = {
			compatibility = "pdthhud",
			language = WaveSurvived.options["language"]
			}
			
			WaveSurvived:Save()

		elseif WaveSurvived.options.id_hud == 4 then

			WaveSurvived.options = {
			compatibility = "lddghud",
			language = WaveSurvived.options["language"]
			}
			
			WaveSurvived:Save()

		elseif WaveSurvived.options.id_hud == 5 then

				WaveSurvived.options = {
				compatibility = "restoration",
				language = WaveSurvived.options["language"]
				}
				
				WaveSurvived:Save()
		end
	end

	MenuCallbackHandler.WaveSurvived_language_callback = function(this, item)
		
		WaveSurvived.options.language_hud = tonumber(item:value()) 
		log("[WaveSurvived] Current language : " .. WaveSurvived.options.language_hud)

		if WaveSurvived.options.language_hud == 1 then

			WaveSurvived.options = {
			compatibility = WaveSurvived.options["compatibility"],
			language = "english"
			}

			WaveSurvived:Save()
		
		elseif WaveSurvived.options.language_hud == 2 then

			WaveSurvived.options = {
			compatibility = WaveSurvived.options["compatibility"],
			language = "french"
			}

			WaveSurvived:Save()

		elseif WaveSurvived.options.language_hud == 3 then

			WaveSurvived.options = {
			compatibility = WaveSurvived.options["compatibility"],
			language = "russian"
			}

		WaveSurvived:Save()
		end
	end

	WaveSurvived:Load()
end






if WaveSurvived.options["compatibility"] == "no_hud" then

	log("[WaveSurvived] Script based on: no_hud")

	WaveSurvived:LoadCustomScript("default")

elseif WaveSurvived.options["compatibility"] == "holoui" then
	log("[WaveSurvived] Script based on: holoui")

	WaveSurvived:LoadCustomScript("holoui")

elseif WaveSurvived.options["compatibility"] == "pdthhud" then
	log("[WaveSurvived] Script based on : pdthhud")

	WaveSurvived:LoadCustomScript("pdth_hud")

elseif WaveSurvived.options["compatibility"] == "lddghud" then
	log("[WaveSurvived] Script based on : lddghud")

	WaveSurvived:LoadCustomScript("lddg_hud")

elseif WaveSurvived.options["compatibility"] == "restoration" then
	log("[WaveSurvived] Script based on : restoration")

	WaveSurvived:LoadCustomScript("restoration")
	
else -- If nothing is matching the condition, loads the default setup
	log("[WaveSurvived] Not matching anything. Loads the default setup.")
	
	WaveSurvived:LoadCustomScript("default")

end






if WaveSurvived.options["language"] == "english" then

	Hooks:Add("LocalizationManagerPostInit", "LocalizationManagerPostInit_LocExample", function(loc)
		loc:load_localization_file( WaveSurvived.locfile_english )
	end)
	log("[WaveSurvived] Localization [ENGLISH] loaded")

elseif WaveSurvived.options["language"] == "french" then

	Hooks:Add("LocalizationManagerPostInit", "LocalizationManagerPostInit_LocExample", function(loc)
		loc:load_localization_file( WaveSurvived.locfile_french )
	end)
	log("[WaveSurvived] Localization [FRENCH] loaded")

elseif WaveSurvived.options["language"] == "russian" then

	Hooks:Add("LocalizationManagerPostInit", "LocalizationManagerPostInit_LocExample", function(loc)
		loc:load_localization_file( WaveSurvived.locfile_russian )
	end)
	log("[WaveSurvived] Localization [RUSSIAN] loaded")

else -- if nothing match, loads the default localization

	Hooks:Add("LocalizationManagerPostInit", "LocalizationManagerPostInit_LocExample", function(loc)
		loc:load_localization_file( WaveSurvived.locfile_english )
	end)
	log("[WaveSurvived] Localization [ENGLISH] loaded")

end

MenuHelper:LoadFromJsonFile(ModPath .. "/options/menu.json", WaveSurvived, WaveSurvived.options)