module SDC
  @[Anyolite::DefaultOptionalArgsToKeywordArgs]
	class Limiter
    property max : UInt32
    property renders_per_second : UInt32
    property ticks_per_second : UInt32
    property gc_per_second : UInt32

    @counter : UInt32 = 0u32
    @temp_counter : UInt32 = 0u32

    @render_interval : UInt32
    @tick_interval : UInt32
    @gc_interval : UInt32

    @update_block : Proc(Nil) | Anyolite::RbRef | Nil = nil
    @draw_block : Proc(Nil) | Anyolite::RbRef | Nil = nil
    @gc_block : Proc(Nil) | Anyolite::RbRef | Nil = nil

    @timer : Time? = nil

    def initialize(@max : UInt32 = 720u32, @renders_per_second : UInt32 = 60u32, @ticks_per_second : UInt32 = 60u32, @gc_per_second : UInt32 = 60u32)
			@render_interval = (@max / @renders_per_second).to_u32
			@tick_interval = (@max / @ticks_per_second).to_u32
			@gc_interval = (@max / @gc_per_second).to_u32
    end

    def call_block(block : Proc(Nil) | Anyolite::RbRef | Nil)
      if !block
        nil
      elsif block.is_a?(Proc)
        block.call
      elsif block.is_a?(Anyolite::RbRef)
        Anyolite.call_rb_block(block, nil)
      end
    end

    @[Anyolite::Specialize]
    @[Anyolite::StoreBlockArg]
    def set_update_routine
      @update_block = Anyolite.obtain_given_rb_block
    end

    @[Anyolite::Specialize]
    @[Anyolite::StoreBlockArg]
    def set_draw_routine
      @draw_block = Anyolite.obtain_given_rb_block
    end

    @[Anyolite::Specialize]
    @[Anyolite::StoreBlockArg]
    def set_gc_routine
      @gc_block = Anyolite.obtain_given_rb_block
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

    def change_renders_per_second(new_value)
			@renders_per_second = new_value
			@render_interval = (@max / @renders_per_second).to_u32
		end

    def tick
      @timer = Time.utc unless @timer

      is_update_frame = (@counter % @tick_interval == 0)
			is_draw_frame = (@counter % @render_interval == 0)
			is_gc_frame = (@counter % @gc_interval == 0)

      scheduled_frame = is_update_frame || is_draw_frame || is_gc_frame

      if is_update_frame
				call_block(@update_block)
			end

			#return false if !SDC.scene

			if is_draw_frame
				call_block(@draw_block)
			end

			if is_gc_frame
				call_block(@gc_block)
			end

			@counter += 1

			if @counter == @max
				@counter = 0
			end

			if scheduled_frame
				while (Time.utc - @timer.not_nil!).total_milliseconds < (@temp_counter + 1) / @max.to_f
				end
				@temp_counter = 0
				@timer = Time.utc
			else
				@temp_counter += 1
			end

			return true
    end
  end
end