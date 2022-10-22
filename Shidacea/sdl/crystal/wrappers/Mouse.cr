module SDC
  @[Anyolite::DefaultOptionalArgsToKeywordArgs]
  module Mouse
    def self.position_change
      LibSDL.get_relative_mouse_state(out x, out y)
      SDC::Coords.new(x, y)
    end

    def self.position
      LibSDL.get_mouse_state(out x, out y)
      SDC::Coords.new(x, y)
    end

    def self.focused_window
      SDC.get_mouse_focused_window
    end

    # TODO: Buttons
  end
end