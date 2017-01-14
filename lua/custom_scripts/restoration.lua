log("[WaveSurvived] Loaded custom script restoration.lua")
function HUDAssaultCorner:denied_escapes()
	local f = string.find(managers.job:current_level_id(), "escape")

	if f then
		return true
	end
end

function HUDAssaultCorner:_start_assault(text_list)
	if self._assault then
	return end
	text_list = text_list or {""}
	local assault_panel = self._hud_panel:child("assault_panel")
	local text_panel = assault_panel:child("text_panel")
	self:_set_text_list(text_list)
	self._assault = true
	self._hud_panel:child("assault_panel"):child("text_panel"):stop()
	self._hud_panel:child("assault_panel"):child("text_panel"):clear()
	assault_panel:set_visible(true)
	text_panel:stop()
	assault_panel:stop()
	assault_panel:animate(callback(self, self, "_animate_assault"))
	text_panel:animate(callback(self, self, "_animate_text"), nil, nil, nil)
	self:_set_feedback_color(self._assault_color)

end

function HUDAssaultCorner:_get_survived_assault_strings()
	if WaveSurvived.options["WaveSurvived_customtext"] then
		if managers.job:current_difficulty_stars() > 0 then
			local ids_risk = Idstring("risk")
			return {
				"WaveSurvived_customtext_" .. WaveSurvived.options["WaveSurvived_customtext"],
				"hud_assault_end_line",
				ids_risk,
				"hud_assault_end_line",
				"WaveSurvived_customtext_" .. WaveSurvived.options["WaveSurvived_customtext"],
				"hud_assault_end_line",
				ids_risk,
				"hud_assault_end_line"
			}
		else
			return {
				"WaveSurvived_customtext_" .. WaveSurvived.options["WaveSurvived_customtext"],
				"hud_assault_end_line",
				"WaveSurvived_customtext_" .. WaveSurvived.options["WaveSurvived_customtext"],
				"hud_assault_end_line",
				"WaveSurvived_customtext_" .. WaveSurvived.options["WaveSurvived_customtext"],
				"hud_assault_end_line"
			}
		end
	else
		if managers.job:current_difficulty_stars() > 0 then
			local ids_risk = Idstring("risk")
			return {
				"hud_assault_survived",
				"hud_assault_end_line",
				ids_risk,
				"hud_assault_end_line",
				"hud_assault_survived",
				"hud_assault_end_line",
				ids_risk,
				"hud_assault_end_line"
			}
		else
			return {
				"hud_assault_survived",
				"hud_assault_end_line",
				"hud_assault_survived",
				"hud_assault_end_line",
				"hud_assault_survived",
				"hud_assault_end_line"
			}
		end
	end
end

function HUDAssaultCorner:_end_assault()
	if not self._assault then
		self._start_assault_after_hostage_offset = nil
		return
	end
	self._remove_hostage_offset = true
	self._start_assault_after_hostage_offset = nil

	self:_set_feedback_color(nil)
	local assault_panel = self._hud_panel:child("assault_panel")
	local text_panel = assault_panel:child("text_panel")
	self._hud_panel:child("assault_panel"):child("text_panel"):stop()
	self._hud_panel:child("assault_panel"):child("text_panel"):clear()
	if self:is_safehouse_raid() then
		self._raid_finised = false
		wave_panel = self._hud_panel:child("wave_panel")
		self:_update_assault_hud_color(self._assault_survived_color)
		self:_set_text_list(self:_get_survived_assault_strings())
		text_panel:animate(callback(self, self, "_animate_text"), nil, nil, nil)
		self._completed_waves = self._completed_waves + 1
		wave_panel:animate(callback(self, self, "_animate_wave_completed"), self)
	else
		if not self:denied_escapes() then
			self:_update_assault_hud_color(self._assault_survived_color)
			self:_set_text_list(self:_get_survived_assault_strings())
			text_panel:animate(callback(self, self, "_animate_text"), nil, nil, nil)
			self._hud_panel:child("assault_panel"):animate(callback(self, self, "_animate_wave_completed"), self)
		else
			self:_close_assault_box()
		end
	end
end

function HUDAssaultCorner:_animate_wave_completed(panel, assault_hud)
	if not self.is_safehouse_raid() then
		wait(20)
		self:_close_assault_box()
	else
		local wave_text = panel:child("num_waves")
		wait(1.4)
		wave_text:set_text(tostring(self._completed_waves))
		wait(7.2)
		self:_close_assault_box()
	end
end