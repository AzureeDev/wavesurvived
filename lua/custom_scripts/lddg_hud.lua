log("[WaveSurvived] Loaded custom script lddg_hud.lua")

function HUDAssaultCorner:denied_escapes()
	local f = string.find(managers.job:current_level_id(), "escape")

	if f then
		return true
	end
end

function HUDAssaultCorner:_start_assault(s)
	text_list = text_list or ""
	local assault_panel = self._hud_panel:child("assault_panel")
	self:set_text("assault", s)
	assault_panel:child("text"):set_color( LDDG:GetColor("AssaultColor") )
	local icon_assaultbox = self._hud_panel:child("assault_panel"):child("icon_assaultbox")
	icon_assaultbox:set_color( LDDG:GetColor("AssaultColor") )
	self:hide_casing()
	self._assault = true
	assault_panel:animate(callback(nil, _G, "set_alpha"), 1)
	self._bg_box:stop()
	assault_panel:animate(callback(self, self, "animate_assault_in_progress"))
	self._bg_box:animate(callback(nil, _G, "hudbox_animate_open_left"), 0.75, 242, nil, Color(), icon_assaultbox)
end

function HUDAssaultCorner:_end_assault()
	if not self._assault then
		self._start_assault_after_hostage_offset = nil
		return
	end
	self:_set_feedback_color(nil)
	self._assault = false
	self._remove_hostage_offset = true
	self._start_assault_after_hostage_offset = nil
	local assault_panel = self._hud_panel:child("assault_panel")
	local icon_assaultbox = self._hud_panel:child("assault_panel"):child("icon_assaultbox")
	
	if not self:denied_escapes() then
		self._survived = true
		assault_panel:child("text"):set_text("WAVE SURVIVED")

		if WaveSurvived.options["WaveSurvived_custompanelcolor"] == 1 then
	 		assault_panel:child("text"):set_color( Color(255, 32, 230, 32) / 255 )
	 	elseif WaveSurvived.options["WaveSurvived_custompanelcolor"] == 2 then
	 		assault_panel:child("text"):set_color( Color(255, 255, 255, 0) / 255 )
	 	elseif WaveSurvived.options["WaveSurvived_custompanelcolor"] == 3 then
	 		assault_panel:child("text"):set_color( Color(255, 255, 0, 0) / 255 )
	 	elseif WaveSurvived.options["WaveSurvived_custompanelcolor"] == 4 then
	 		assault_panel:child("text"):set_color( Color(255, 0, 255, 255) / 255 )
	 	elseif WaveSurvived.options["WaveSurvived_custompanelcolor"] == 5 then
	 		assault_panel:child("text"):set_color( Color(255, 255, 127, 80) / 255 )
	 	elseif WaveSurvived.options["WaveSurvived_custompanelcolor"] == 6 then
	 		assault_panel:child("text"):set_color( Color(255, WaveSurvived.options["WaveSurvived_custompanelcolor_customslider_red"], WaveSurvived.options["WaveSurvived_custompanelcolor_customslider_green"], WaveSurvived.options["WaveSurvived_custompanelcolor_customslider_blue"]) / 255 )
	 	else	
			assault_panel:child("text"):set_color( Color(1, 0.1254902, 0.9019608, 0.1254902) )
	 	end
		assault_panel:animate(callback(self, self, "animate_assault_in_progress"))
		icon_assaultbox:stop()
		icon_assaultbox:animate(callback(self, self, "_show_icon_assaultbox"))

		if WaveSurvived.options["WaveSurvived_custompanelcolor"] == 1 then
	 		icon_assaultbox:set_color( Color(255, 32, 230, 32) / 255 )
	 	elseif WaveSurvived.options["WaveSurvived_custompanelcolor"] == 2 then
	 		icon_assaultbox:set_color( Color(255, 255, 255, 0) / 255 )
	 	elseif WaveSurvived.options["WaveSurvived_custompanelcolor"] == 3 then
	 		icon_assaultbox:set_color( Color(255, 255, 0, 0) / 255 )
	 	elseif WaveSurvived.options["WaveSurvived_custompanelcolor"] == 4 then
	 		icon_assaultbox:set_color( Color(255, 0, 255, 255) / 255 )
	 	elseif WaveSurvived.options["WaveSurvived_custompanelcolor"] == 5 then
	 		icon_assaultbox:set_color( Color(255, 255, 127, 80) / 255 )
	 	elseif WaveSurvived.options["WaveSurvived_custompanelcolor"] == 6 then
	 		icon_assaultbox:set_color( Color(255, WaveSurvived.options["WaveSurvived_custompanelcolor_customslider_red"], WaveSurvived.options["WaveSurvived_custompanelcolor_customslider_green"], WaveSurvived.options["WaveSurvived_custompanelcolor_customslider_blue"]) / 255 )
	 	else	
			icon_assaultbox:set_color( Color(1, 0.1254902, 0.9019608, 0.1254902) )
	 	end

		self._hud_panel:child("assault_panel"):animate(callback(self, self, "_animate_wave_completed"), self)
	end
end

function HUDAssaultCorner:animate_assault_in_progress(o)
	while self._assault do
		set_alpha(o, 0.6)
		set_alpha(o, 1)
	end
	while self._survived do
		set_alpha(o, 0.6)
		set_alpha(o, 1)
	end
	set_alpha(o, 0)
end

function HUDAssaultCorner:_animate_wave_completed(panel, assault_hud)
	
	if WaveSurvived.options["WaveSurvived_duration"] == 1 then
		wait(8.6)
		local function close_done()
			icon_assaultbox:stop()
			icon_assaultbox:animate(callback(self, self, "_hide_icon_assaultbox"))		
			self:sync_set_assault_mode("normal")
		end
		self._survived = false
		self._bg_box:stop()
		self._hud_panel:child("assault_panel"):animate(callback(nil, _G, "set_alpha"), 0)	
		self._bg_box:animate(callback(nil, _G, "HUDBGBox_animate_close_left"), close_done)
	elseif WaveSurvived.options["WaveSurvived_duration"] == 2 then
		wait(15)
		local function close_done()
			icon_assaultbox:stop()
			icon_assaultbox:animate(callback(self, self, "_hide_icon_assaultbox"))		
			self:sync_set_assault_mode("normal")
		end
		self._survived = false
		self._bg_box:stop()
		self._hud_panel:child("assault_panel"):animate(callback(nil, _G, "set_alpha"), 0)	
		self._bg_box:animate(callback(nil, _G, "HUDBGBox_animate_close_left"), close_done)
	elseif WaveSurvived.options["WaveSurvived_duration"] == 3 then
		wait(20)
		local function close_done()
			icon_assaultbox:stop()
			icon_assaultbox:animate(callback(self, self, "_hide_icon_assaultbox"))		
			self:sync_set_assault_mode("normal")
		end
		self._survived = false
		self._bg_box:stop()
		self._hud_panel:child("assault_panel"):animate(callback(nil, _G, "set_alpha"), 0)	
		self._bg_box:animate(callback(nil, _G, "HUDBGBox_animate_close_left"), close_done)
	elseif WaveSurvived.options["WaveSurvived_duration"] == 4 then
		wait(25)
		local function close_done()
			icon_assaultbox:stop()
			icon_assaultbox:animate(callback(self, self, "_hide_icon_assaultbox"))		
			self:sync_set_assault_mode("normal")
		end
		self._survived = false
		self._bg_box:stop()
		self._hud_panel:child("assault_panel"):animate(callback(nil, _G, "set_alpha"), 0)	
		self._bg_box:animate(callback(nil, _G, "HUDBGBox_animate_close_left"), close_done)
	elseif WaveSurvived.options["WaveSurvived_duration"] == 5 then

	else
		wait(8.6)
		local function close_done()
			icon_assaultbox:stop()
			icon_assaultbox:animate(callback(self, self, "_hide_icon_assaultbox"))		
			self:sync_set_assault_mode("normal")
		end
		self._survived = false
		self._bg_box:stop()
		self._hud_panel:child("assault_panel"):animate(callback(nil, _G, "set_alpha"), 0)	
		self._bg_box:animate(callback(nil, _G, "HUDBGBox_animate_close_left"), close_done)
	end
end