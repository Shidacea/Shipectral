# NOTE: This will be dropped in future versions of Shidacea

module SF
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
    Left = SF::Mouse::Button::Left
    Right = SF::Mouse::Button::Right
    Middle = SF::Mouse::Button::Middle

    VerticalWheel = SF::Mouse::Wheel::VerticalWheel
    HorizontalWheel = SF::Mouse::Wheel::HorizontalWheel

    def self.get_coordinates(window)
      window.map_pixel_to_coords(SF::Mouse.get_position(relative_to: window))
    end

    def self.set_position(pos, window)
      SF::Mouse.set_position(position: SF::Vector2i.new(pos[0], pos[1]), relative_to: window)
    end
  end

  module EventKey
    Escape = SF::Keyboard::Key::Escape
    Space = SF::Keyboard::Key::Space
    Enter = SF::Keyboard::Key::Enter
    Down = SF::Keyboard::Key::Down
    Up = SF::Keyboard::Key::Up
    Left = SF::Keyboard::Key::Left
    Right = SF::Keyboard::Key::Right
    Backspace = SF::Keyboard::Key::Backspace
    Tab = SF::Keyboard::Key::Tab
    LControl = SF::Keyboard::Key::LControl
    RControl = SF::Keyboard::Key::RControl
    LShift = SF::Keyboard::Key::LShift
    RShift = SF::Keyboard::Key::RShift
    Num1 = SF::Keyboard::Key::Num1
    Num2 = SF::Keyboard::Key::Num2
    Num3 = SF::Keyboard::Key::Num3
    Num4 = SF::Keyboard::Key::Num4
    Num5 = SF::Keyboard::Key::Num5
    Num6 = SF::Keyboard::Key::Num6
    Num7 = SF::Keyboard::Key::Num7
    Num8 = SF::Keyboard::Key::Num8
    Num9 = SF::Keyboard::Key::Num9
    Num0 = SF::Keyboard::Key::Num0
    F1 = SF::Keyboard::Key::F1
    F2 = SF::Keyboard::Key::F2
    F3 = SF::Keyboard::Key::F3
    F4 = SF::Keyboard::Key::F4
    F5 = SF::Keyboard::Key::F5
    F6 = SF::Keyboard::Key::F6
    F7 = SF::Keyboard::Key::F7
    F8 = SF::Keyboard::Key::F8
    F9 = SF::Keyboard::Key::F9
    F10 = SF::Keyboard::Key::F10
    F11 = SF::Keyboard::Key::F11
    F12 = SF::Keyboard::Key::F12
    A = SF::Keyboard::Key::A
    B = SF::Keyboard::Key::B
    C = SF::Keyboard::Key::C
    D = SF::Keyboard::Key::D
    E = SF::Keyboard::Key::E
    F = SF::Keyboard::Key::F
    G = SF::Keyboard::Key::G
    H = SF::Keyboard::Key::H
    I = SF::Keyboard::Key::I
    J = SF::Keyboard::Key::J
    K = SF::Keyboard::Key::K
    L = SF::Keyboard::Key::L
    M = SF::Keyboard::Key::M
    N = SF::Keyboard::Key::N
    O = SF::Keyboard::Key::O
    P = SF::Keyboard::Key::P
    Q = SF::Keyboard::Key::Q
    R = SF::Keyboard::Key::R
    S = SF::Keyboard::Key::S
    T = SF::Keyboard::Key::T
    U = SF::Keyboard::Key::U
    V = SF::Keyboard::Key::V
    W = SF::Keyboard::Key::W
    X = SF::Keyboard::Key::X
    Y = SF::Keyboard::Key::Y
    Z = SF::Keyboard::Key::Z

    def self.is_pressed?(key)
      SF::Keyboard.key_pressed?(key)
    end
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