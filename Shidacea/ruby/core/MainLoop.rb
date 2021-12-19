# This file is a template for a basic game loop
# It can be used in its current form or it can be modified

module SDC

	# Main routine as an entry point for the Shidacea engine
	# @param game_class [Class] The class for the game data
	# @param title [String] Title of the window
	# @param width [Fixnum] Width of the window
	# @param height [Fixnum] Height of the window
	# @param limiter [SDC::Limiter] Can be set to an instance of {SDC::Limiter}
	def self.main_routine(scene_class, game_class: nil, title: "", width: 800, height: 600, limiter: nil)

		begin
			SDC.window = SDC::GameWindow.new(title, width, height)
			SDC.set_draw_size(width, height)
			SDC.limiter = limiter ? limiter : SDC::Limiter.new(max: 720, renders_per_second: 60, ticks_per_second: 60, gc_per_second: 60)

			GC.disable

			# Update routine, formulated as block for the limiter
			SDC.limiter.set_update_routine do
				SDC.scene.process_events
				SDC.scene.main_update

				if !SDC.next_scene then	# Terminate program
					SDC.scene.at_exit
					SDC.scene = nil
				elsif SDC.next_scene != true then	# Change scene
					SDC.scene.at_exit
					SDC.scene = SDC.next_scene.new
					SDC.next_scene = true
					SDC.scene.at_init
				end
			end

			# Drawing routine
			SDC.limiter.set_draw_routine do
				SDC.scene.main_draw
			end

			# Garbage collecting routine
			SDC.limiter.set_gc_routine do
				# Initiate garbace collector
				GC.enable
				GC.start
				GC.disable
			end

			SDC.game = game_class&.new

			SDC.scene = scene_class.new
			SDC.next_scene = true

			SDC::Debug.on_debug do

				c = 0
				ti = Time.now
				while SDC.window.is_open? do
					c += 1
					# If it returns a false value, the game scene was set to nil
					break if !SDC.limiter.tick
					if c == SDC::limiter.max then
						puts "FPS: #{SDC.limiter.renders_per_second / (Time.now - ti)}"
						c = 0
						ti = Time.now
					end
				end

			end

			SDC::Debug.on_release do

				while SDC.window.is_open? do
					break if !SDC.limiter.tick
				end

			end

			SDC.window.close

			GC.enable

		rescue Exception => exc
			f = File.open("log.txt", "a")

			f.puts "Error in main loop at #{Time.now}:"
			f.puts exc.inspect
			f.puts exc.backtrace.join("\n")
			f.puts ""

			f.close

			raise exc
		end

	end
end