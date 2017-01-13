function HUDAssaultCorner:denied_escapes()
	local f = string.find(managers.job:current_level_id(), "escape")

	if f then
		return true
	end
end

function HUDAssaultCorner:_start_assault(text_list)
	text_list = text_list or {""}
	local assault_panel = self._hud_panel:child("assault_panel")
	local text_panel = assault_panel:child("text_panel")
	self:_set_text_list(text_list)
	self._assault = true
	if self._bg_box:child("text_panel") then
		self._bg_box:child("text_panel"):stop()
		self._bg_box:child("text_panel"):clear()
	else
		self._bg_box:panel({name = "text_panel"})
	end
	self._bg_box:child("bg"):stop()
	assault_panel:set_visible(true)
	local icon_assaultbox = assault_panel:child("icon_assaultbox")
	icon_assaultbox:stop()
	icon_assaultbox:animate(callback(self, self, "_show_icon_assaultbox"))
	local config = {
		attention_color = self._assault_color,
		attention_forever = true,
		attention_color_function = callback(self, self, "assault_attention_color_function")
	}
	self._bg_box:stop()
	self._bg_box:animate(callback(nil, _G, "HUDBGBox_animate_open_left"), 0.75, 242, function()
	end, config)
	local box_text_panel = self._bg_box:child("text_panel")
	box_text_panel:stop()
	box_text_panel:animate(callback(self, self, "_animate_text"), nil, nil, callback(self, self, "assault_attention_color_function"))
	self:_set_feedback_color(self._assault_color)
	if alive(self._wave_bg_box) then
		self._wave_bg_box:stop()
		self._wave_bg_box:animate(callback(self, self, "_animate_wave_started"), self)
	end
end

function HUDAssaultCorner:_end_assault()
 	if not self._assault then
 		self._start_assault_after_hostage_offset = nil
 		return             
 	end

 	self:_set_feedback_color(nil)
 	self._assault = false
 	local box_text_panel = self._bg_box:child("text_panel")
 	box_text_panel:stop()
 	box_text_panel:clear()
 	self._remove_hostage_offset = true
 	self._start_assault_after_hostage_offset = nil
 	local icon_assaultbox = self._hud_panel:child("assault_panel"):child("icon_assaultbox")
 	icon_assaultbox:stop()

 	if not self:denied_escapes() then
		self:_update_assault_hud_color(self._assault_survived_color)
		self:_set_text_list(self:_get_survived_assault_strings())
		box_text_panel:animate(callback(self, self, "_animate_text"), nil, nil, callback(self, self, "assault_attention_color_function"))
		icon_assaultbox:stop()
		icon_assaultbox:animate(callback(self, self, "_show_icon_assaultbox"))
		box_text_panel:animate(callback(self, self, "_animate_wave_completed"), self)
	else
		self:_close_assault_box()
	end
end

function HUDAssaultCorner:_animate_wave_completed(panel, assault_hud)
	if not self:is_safehouse_raid() then

		if WaveSurvived.options["WaveSurvived_duration"] == 1 then
			wait(8.6)
			self:_close_assault_box()
		elseif WaveSurvived.options["WaveSurvived_duration"] == 2 then
			wait(15)
			self:_close_assault_box()
		elseif WaveSurvived.options["WaveSurvived_duration"] == 3 then
			wait(20)
			self:_close_assault_box()
		elseif WaveSurvived.options["WaveSurvived_duration"] == 4 then
			wait(25)
			self:_close_assault_box()
		elseif WaveSurvived.options["WaveSurvived_duration"] == 5 then
		
		else
			wait(8.6)
			self:_close_assault_box()
		end

	else
		local wave_text = panel:child("num_waves")
		local bg = panel:child("bg")
		wait(1.4)
		wave_text:set_text(self:get_completed_waves_string())
		bg:stop()
		bg:animate(callback(nil, _G, "HUDBGBox_animate_bg_attention"), {})
		wait(7.2)
		assault_hud:_close_assault_box()
	end
end