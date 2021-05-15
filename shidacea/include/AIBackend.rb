# AI helper module
# NOTE: This module works only with the SDC::AI module from the Shidacea core

module SDCMeta
	module AIBackend

		# Use these two methods to setup and tick any class with an AI system

		def setup_ai
			@master_ai = SDC::AI::Script.new {master_ai_script}
			@ai_pages = [SDC::AI::Script.new {ai_script}]
			@ai_page = 0
		end

		def tick_ai
			@master_ai.tick if master_ai_running?
			current_ai.tick if ai_running?
		end

		# Special methods which are called and used by the AI system

		def master_ai_running?
			return @master_ai.running?
		end

		def ai_running?
			return current_ai&.running?
		end

		def current_ai
			return @ai_pages[@ai_page]
		end

		def add_ai_page(method_symbol, index)
			@ai_pages[index] = SDC::AI::Script.new {self.send(method_symbol)}
		end

		def master_ai_script
			SDC::AI::done
		end

		def ai_script
			SDC::AI::done
		end

	end
end