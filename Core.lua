if not ModCore then
	log("[ERROR] Unable to find ModCore from BeardLib! Is BeardLib installed correctly?")
	return
end

WaveSurvivedCore = WaveSurvivedCore or class(ModCore)

function WaveSurvivedCore:init()
	--Calling the base function for init from ModCore
	--self_tbl, config path, auto load modules, auto post init modules
	self.super.init(self, ModPath .. "Config.xml", true, true)
end

if not _G.PPSaving then
	local success, err = pcall(function() WaveSurvivedCore:new() end)
	if not success then
		log("[ERROR] An error occured on the initialization of WaveSurvived. " .. tostring(err))
	end
end