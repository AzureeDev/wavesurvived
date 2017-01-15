if pdth_hud then
	log("[WaveSurvived] Loaded custom script pdth_hud.lua")

	function HUDAssaultCorner:_start_assault()
		local assault_panel = self._hud_panel:child("assault_panel")
		local control_assault_title = assault_panel:child("control_assault_title")
		local icon_assaultbox = assault_panel:child("icon_assaultbox")
		local num_hostages = self._hud_panel:child("num_hostages")
		local casing_panel = self._hud_panel:child("casing_panel")
		self._assault = true
		assault_panel:set_visible(true)
		num_hostages:set_alpha(0.5)
		casing_panel:set_visible(false)
	    self._is_casing_mode = false

	    local color = self._assault_color

	    if self._assault_mode == "phalanx" then
			color = self._vip_assault_color
	        self._fx_color = self._vip_assault_color_fx
		end

	    icon_assaultbox:set_color(color)
	    control_assault_title:set_color(color)
	    control_assault_title:set_text(managers.localization:text("menu_assault"))
	    local const = pdth_hud.constants
		control_assault_title:set_font_size(const.assault_font_size)

		assault_panel:animate(callback(self, self, "flash_assault_title"), true)
	end

	function HUDAssaultCorner:_end_assault()

		
		local assault_panel = self._hud_panel:child("assault_panel")
		local control_assault_title = assault_panel:child("control_assault_title")
		local icon_assaultbox = assault_panel:child("icon_assaultbox")
		local num_hostages = self._hud_panel:child("num_hostages")
		num_hostages:set_alpha(1)
		if not self._assault then
			return
		end
		self._assault = false

		local const = pdth_hud.constants
		control_assault_title:set_font_size(const.assault_font_size - 3.5)
		control_assault_title:set_text("SURVIVED")

	    if WaveSurvived.options["WaveSurvived_custompanelcolor"] == 1 then
			control_assault_title:set_color(Color(255, 32, 230, 32) / 255)
	 		icon_assaultbox:set_color(Color(255, 32, 230, 32) / 255)
	 	elseif WaveSurvived.options["WaveSurvived_custompanelcolor"] == 2 then
			control_assault_title:set_color(Color(255, 255, 255, 0) / 255)
	 		icon_assaultbox:set_color(Color(255, 255, 255, 0) / 255)
	 	elseif WaveSurvived.options["WaveSurvived_custompanelcolor"] == 3 then
			control_assault_title:set_color(Color(255, 255, 0, 0) / 255)
	 		icon_assaultbox:set_color(Color(255, 255, 0, 0) / 255)
	 	elseif WaveSurvived.options["WaveSurvived_custompanelcolor"] == 4 then
			control_assault_title:set_color(Color(255, 0, 255, 255) / 255)
	 		icon_assaultbox:set_color(Color(255, 0, 255, 255) / 255)
	 	elseif WaveSurvived.options["WaveSurvived_custompanelcolor"] == 5 then
			control_assault_title:set_color(Color(255, 255, 127, 80) / 255)
	 		icon_assaultbox:set_color(Color(255, 255, 127, 80) / 255)
	 	elseif WaveSurvived.options["WaveSurvived_custompanelcolor"] == 6 then
	 		control_assault_title:set_color(Color(255, WaveSurvived.options["WaveSurvived_custompanelcolor_customslider_red"], WaveSurvived.options["WaveSurvived_custompanelcolor_customslider_green"], WaveSurvived.options["WaveSurvived_custompanelcolor_customslider_blue"]) / 255)
	 		icon_assaultbox:set_color(Color(255, WaveSurvived.options["WaveSurvived_custompanelcolor_customslider_red"], WaveSurvived.options["WaveSurvived_custompanelcolor_customslider_green"], WaveSurvived.options["WaveSurvived_custompanelcolor_customslider_blue"]) / 255)
	 	else	
	 		control_assault_title:set_color(Color(1, 0.1254902, 0.9019608, 0.1254902))
	 		icon_assaultbox:set_color(Color(1, 0.1254902, 0.9019608, 0.1254902))
	 	end

		assault_panel:animate(callback(self, self, "flash_assault_title"), true)
		assault_panel:animate(callback(self, self, "_animate_wave_completed"), self)

	end

	function HUDAssaultCorner:_animate_wave_completed(panel, assault_hud)
		
		if WaveSurvived.options["WaveSurvived_duration"] == 1 then
			wait(8.6)
			local assault_panel = self._hud_panel:child("assault_panel")
			assault_panel:set_visible(false)
		elseif WaveSurvived.options["WaveSurvived_duration"] == 2 then
			wait(15)
			local assault_panel = self._hud_panel:child("assault_panel")
			assault_panel:set_visible(false)
		elseif WaveSurvived.options["WaveSurvived_duration"] == 3 then
			wait(20)
			local assault_panel = self._hud_panel:child("assault_panel")
			assault_panel:set_visible(false)
		elseif WaveSurvived.options["WaveSurvived_duration"] == 4 then
			wait(25)
			local assault_panel = self._hud_panel:child("assault_panel")
			assault_panel:set_visible(false)
		elseif WaveSurvived.options["WaveSurvived_duration"] == 5 then

		else
			wait(8.6)
			local assault_panel = self._hud_panel:child("assault_panel")
			assault_panel:set_visible(false)
		end

	end

end