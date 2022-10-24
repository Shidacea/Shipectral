module SDC
  @[Anyolite::DefaultOptionalArgsToKeywordArgs]
  module Mouse
    BUTTON_LEFT = LibSDL::BUTTON_LEFT
    BUTTON_MIDDLE = LibSDL::BUTTON_MIDDLE
    BUTTON_RIGHT = LibSDL::BUTTON_RIGHT
    BUTTON_X1 = LibSDL::BUTTON_X1
    BUTTON_X2 = LibSDL::BUTTON_X2

    def self.position_change
      LibSDL.get_relative_mouse_state(out x, out y)
      SDC::Coords.new(x, y)
    end

    def self.position
      LibSDL.get_mouse_state(out x, out y)
      SDC::Coords.new(x, y)
    end

    def self.global_position
      LibSDL.get_global_mouse_state(out x, out y)
      SDC::Coords.new(x, y)
    end

    def self.position=(pos : SDC::Coords)
      LibSDL.warp_mouse_in_window(SDC.current_window.not_nil!.data, pos.x, pos.y)
    end

    def self.global_position=(pos : SDC::Coords)
      LibSDL.warp_mouse_global(pos.x, pos.y)
    end

    def self.focused_window
      SDC.get_mouse_focused_window
    end

    def self.button_down?(button : Int)
      mouse_state = LibSDL.get_mouse_state(nil, nil).to_i
      LibSDLMacro.button(mouse_state) == button
    end

    def self.left_button_down?
      LibSDLMacro.button(LibSDL.get_mouse_state(nil, nil).to_i) == LibSDL::BUTTON_LEFT
    end

    def self.right_button_down?
      LibSDLMacro.button(LibSDL.get_mouse_state(nil, nil).to_i) == LibSDL::BUTTON_RIGHT
    end

    def self.middle_button_down?
      LibSDLMacro.button(LibSDL.get_mouse_state(nil, nil).to_i) == LibSDL::BUTTON_MIDDLE
    end

    # TODO: Buttons
  end
end