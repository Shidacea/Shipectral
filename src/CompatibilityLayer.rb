# NOTE: This will be dropped in future versions of Shidacea

module SDC
  class Event
    def type
      -1
    end

    class Closed; def type; 0; end; end
    class KeyPressed; def type; 5; end; end
    class MouseWheelScrolled; def type; 8; end; end
    class MouseButtonReleased; def type; 10; end; end
  end

  module EventMouse
    def self.get_coordinates(window)
      int_coords = SDC::Mouse.get_position(relative_to: window)
		  SDC.xy(int_coords.x, int_coords.y)
    end
  end

  module EventType
    Closed = 0
    KeyPressed = 5
    MouseWheelScrolled = 8
    MouseButtonReleased = 10
  end
end