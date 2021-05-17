# NOTE: This will be dropped in future versions of Shidacea

module SDC
  class Event
    def type
      -1
    end

    def key_code
      code
    end
    
    def mouse_button_code
      button
    end

    def mouse_scroll_wheel
      wheel
    end

    def mouse_scroll_delta
      delta
    end

    def text_unicode
      unicode
    end

    class Closed; def type; 0; end; end
    class Rezised; def type; 1; end; end
    class LostFocus; def type; 2; end; end
    class GainedFocus; def type; 3; end; end
    class TextEntered; def type; 4; end; end
    class KeyPressed; def type; 5; end; end
    class KeyReleased; def type; 6; end; end
    class MouseWheelMoved; def type; 7; end; end
    class MouseWheelScrolled; def type; 8; end; end
    class MouseButtonPressed; def type; 9; end; end
    class MouseButtonReleased; def type; 10; end; end
    class MouseMoved; def type; 11; end; end
    class MouseEntered; def type; 12; end; end
    class MouseLeft; def type; 13; end; end
    class JoystickButtonPressed; def type; 14; end; end
    class JoystickButtonReleased; def type; 15; end; end
    class JoystickMoved; def type; 16; end; end
    class JoystickConnected; def type; 17; end; end
    class JoystickDisconnected; def type; 18; end; end
    class TouchBegan; def type; 19; end; end
    class TouchMoved; def type; 20; end; end
    class TouchEnded; def type; 21; end; end
    class SensorChanged; def type; 22; end; end
  end

  module EventMouse
    Left = SDC::Mouse::Button::Left
    Right = SDC::Mouse::Button::Right
    Middle = SDC::Mouse::Button::Middle

    VerticalWheel = SDC::Mouse::Wheel::VerticalWheel
    HorizontalWheel = SDC::Mouse::Wheel::HorizontalWheel

    def self.get_coordinates(window)
      int_coords = SDC::Mouse.get_position(relative_to: window)
		  SDC.xy(int_coords.x, int_coords.y)
    end
  end

  module EventKey
    Escape = SDC::Keyboard::Key::Escape
    Space = SDC::Keyboard::Key::Space
    Enter = SDC::Keyboard::Key::Enter
    Down = SDC::Keyboard::Key::Down
    Up = SDC::Keyboard::Key::Up
    Left = SDC::Keyboard::Key::Left
    Right = SDC::Keyboard::Key::Right
  end

  module EventType
    Closed = 0
    Rezised = 1
    LostFocus = 2
    GainedFocus = 3
    TextEntered = 4
    KeyPressed = 5
    KeyReleased = 6
    MouseWheelMoved = 7
    MouseWheelScrolled = 8
    MouseButtonPressed = 9
    MouseButtonReleased = 10
    MouseMoved = 11
    MouseEntered = 12
    MouseLeft = 13
    JoystickButtonPressed = 14
    JoystickButtonReleased = 15
    JoystickMoved = 16
    JoystickConnected = 17
    JoystickDisconnected = 18
    TouchBegan = 19
    TouchMoved = 20
    TouchEnded = 21
    SensorChanged = 22
  end
end