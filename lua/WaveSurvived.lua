WaveSurvived = {}

WaveSurvived.modpath = ModPath
WaveSurvived.logpath = LogsPath
WaveSurvived.savepath = SavePath
WaveSurvived.savefile = SavePath .. "/WaveSurvived_options.txt"

WaveSurvived.locfile_english = ModPath .. "/loc/english.txt"
WaveSurvived.locfile_french = ModPath .. "/loc/french.txt"
WaveSurvived.locfile_russian = ModPath .. "/loc/russian.txt"
WaveSurvived.locfile_italian = ModPath .. "/loc/italian.txt"

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

else -- if nothing match, loads the default localization

	Hooks:Add("LocalizationManagerPostInit", "WaveSurvived_Localization", function(loc)
		loc:load_localization_file( WaveSurvived.locfile_english )
	end)
	log("[WaveSurvived] Localization [ENGLISH] loaded")

end

MenuHelper:LoadFromJsonFile(ModPath .. "/options/menu.json", WaveSurvived, WaveSurvived.options)