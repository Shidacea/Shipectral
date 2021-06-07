module SPT
  class Tile
    @solid = false
    @animation_frame = false

    @index_of_first_animation_frame : UInt32 = 0
    @index_of_first_other_animation_frame : UInt32 = 0
    @number_of_animation_frames : UInt32 = 0
    @time_per_animation_frame : UInt32 = 0

    def initialize
    end

    def is_solid?
      return @solid
    end

    def is_animation_frame?
      return @animation_frame
    end

    def set_as_solid(value : Bool = true)
      @solid = value
    end

    def get_animation_frame(frame_counter : UInt32)
      animation_cycle = @number_of_animation_frames * @time_per_animation_frame
      animation_time = frame_counter % animation_cycle
      animation_index = animation_time / @time_per_animation_frame

      if animation_index == 0
        return @index_of_first_animation_frame
      else
        return @index_of_first_other_animation_frame + animation_index - 1
      end
    end

    def set_animation(@index_of_first_animation_frame : UInt32, @index_of_first_other_animation_frame : UInt32, @number_of_animation_frames : UInt32, @time_per_animation_frame : UInt32)
      @animation_frame = true
    end
  end
end

def setup_ruby_tile_class(rb)
  Anyolite.wrap(rb, SPT::Tile, under: SF, verbose: true, connect_to_superclass: false)
end
