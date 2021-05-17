config = SDC::MapConfig.new("Test Map 001")

config.script do
	SDC::AI::once do
	
		SDC.increase_variable("map_loaded")

	end 
end

config.tileset_index = :Default

SDC::Data::add_map_config(config, index: :TestMap)