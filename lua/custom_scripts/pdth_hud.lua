if pdth_hud then
	log("[WaveSurvived] Loaded custom script pdth_hud.lua")

	function HUDAssaultCorner:_start_assault()
		log("[WaveSurvived] Assault Started")
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
		local color = Color(1, 0.1254902, 0.9019608, 0.1254902)
	    self._fx_color = color
		self._current_assault_color = color

		local assault_panel = self._hud_panel:child("assault_panel")
		local control_assault_title = assault_panel:child("control_assault_title")
		local icon_assaultbox = assault_panel:child("icon_assaultbox")
		local num_hostages = self._hud_panel:child("num_hostages")
		num_hostages:set_alpha(1)
		if not self._assault then
			return
		end
		self._assault = false

		log("[WaveSurvived] Condition OK")

		local const = pdth_hud.constants
		control_assault_title:set_font_size(const.assault_font_size - 3.5)
		control_assault_title:set_text("SURVIVED")
		control_assault_title:set_color(color)
	    icon_assaultbox:set_color(color)
		assault_panel:animate(callback(self, self, "flash_assault_title"), true)
		assault_panel:animate(callback(self, self, "_animate_wave_completed"), self)

	end

	function HUDAssaultCorner:_animate_wave_completed(panel, assault_hud)
		wait(20)
		local assault_panel = self._hud_panel:child("assault_panel")
		assault_panel:set_visible(false)
	end

end