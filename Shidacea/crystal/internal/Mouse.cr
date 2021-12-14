module SF
  @[Anyolite::SpecializeClassMethod("position=", [position : Vector2 | Tuple], [position : Vector2i])]
  @[Anyolite::ExcludeClassMethod("set_position")]
  @[Anyolite::ExcludeClassMethod("get_position")]
  module Mouse
    @[Anyolite::Rename("set_position")]
    def self.set_position_helper(position : Vector2i, relative_to : SDC::RenderQueueWindow?)
      if relative_to
        self.set_position(position, relative_to.get_window_reference)
      else
        self.position = position
      end
    end

    @[Anyolite::Rename("get_position")]
    def self.get_position_helper(relative_to : SDC::RenderQueueWindow?)
      if relative_to
        self.get_position(relative_to.get_window_reference)
      else
        self.position
      end
    end
  end
end