# Framerate limiter

module SDC
	class Limiter

		attr_reader :max, :renders_per_second, :ticks_per_second, :gc_per_second

		def initialize(max: 720, renders_per_second: 60, ticks_per_second: 60, gc_per_second: 60)
			@counter = 0
			@temp_counter = 0
			@max = max

			@renders_per_second = renders_per_second
			@ticks_per_second = ticks_per_second
			@gc_per_second = gc_per_second

			# Intervals are rounded down, for now
			@render_interval = (@max / @renders_per_second).to_i
			@tick_interval = (@max / @ticks_per_second).to_i
			@gc_interval = (@max / @gc_per_second).to_i

			@update_block = nil
			@draw_block = nil
			@gc_block = nil
		end

		def set_update_routine(&block)
			@update_block = block
		end

		def set_draw_routine(&block)
			@draw_block = block
		end

		def set_gc_routine(&block)
			@gc_block = block
		end

		# Allow for changes via options, if necessary
		def change_renders_per_second(new_value)
			@renders_per_second = new_value
			@render_interval = (@max / @renders_per_second).to_i
		end

		def tick
			@timer = Time.now if !@timer

			is_update_frame = (@counter % @tick_interval == 0)
			is_draw_frame = (@counter % @render_interval == 0)
			is_gc_frame = (@counter % @gc_interval == 0)

			scheduled_frame = is_update_frame || is_draw_frame || is_gc_frame

			if is_update_frame then
				@update_block&.call
			end

			return false if !SDC.scene

			if is_draw_frame then
				@draw_block&.call
			end

			if is_gc_frame then
				@gc_block&.call
			end

			@counter += 1

			if @counter == @max then
				@counter = 0
			end

			# Check how advanced the timer is, if this is an scheduled frame
			# If the frame got executed too fast, some time can be stalled
			# The non-scheduled frames then stabilize the framerate to a fixed pace
			# A frame lasting longer than scheduled will therefore not be catched up
			# This prevents the framerate boosting beyond the schedule

			if scheduled_frame then
				while (Time.now - @timer) < (@temp_counter + 1) / @max.to_f do
				end
				@temp_counter = 0
				@timer = Time.now
			else
				@temp_counter += 1
			end

			return true
		end

	end

end