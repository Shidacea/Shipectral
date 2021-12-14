# Base class for scenes
module SDC
	class Scene

		# Methods for internal stuff, don't change these if inherited

		def initialize
			at_init
		end

		def main_update
			update
		end

		def main_draw
			SDC.window.clear
			draw

			if SDC.window.imgui_defined? then
				SDC.window.imgui_update
				draw_imgui
			end

			SDC.window.render_and_display
		end

		def process_events
			each_event do |event|
				handle_event(event)
			end
		end

		# Helper method to execute events as a block
		def each_event
			while event = SDC.window.poll_event do
				yield event
			end
		end

		# Other helper methods

		def create(entity_class)
			return entity_class.new
		end

		# Change these at will if inherited

		# This method gets called directly when the scene is created
		def at_init

		end

		# This method gets called if the scene gets replaced by another scene or nil
		def at_exit

		end

		# This method gets called once every tick, use it for game logic
		def update
		
		end

		# This method gets called once every tick, use it for drawing
		def draw

		end

		# This method draws an ImGui overlay after the initial drawing procedure
		def draw_imgui

		end

		# Use this method to handle a single event (e.g. check its type and value)
		def handle_event(event)

		end

	end
end