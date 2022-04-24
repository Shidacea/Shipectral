# Base compatibility layer between SFML and SDC

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
end

module SDC
  module Graphics
		module Shapes
      Base = SF::Shape
			Point = SF::PointShape
			Line = SF::LineShape
			Circle = SF::CircleShape
			Rectangle = SF::RectangleShape
			Triangle = SF::TriangleShape
			Ellipse = SF::EllipseShape
		end

		View = SF::View
		Text = SF::Text
		Texture = SF::Texture
		Sprite = SF::Sprite
		Font = SF::Font
    Color = SF::Color
    RenderStates = SF::RenderStates
	end

  IntRect = SF::IntRect
  FloatRect = SF::FloatRect

  Vector2f = SF::Vector2f
  Vector2i = SF::Vector2i

  Mouse = SF::Mouse
  Keyboard = SF::Keyboard

	module Audio
		Sound = SF::Sound
		SoundBuffer = SF::SoundBuffer
		Music = SF::Music
	end
	
	module Network
		TcpSocket = SF::TcpSocket
    Socket = SF::Socket
		Packet = SF::Packet
		TcpListener = SF::TcpListener
		IpAddress = SF::IpAddress
	end

  module EventMouse
    Left = SDC::Mouse::Button::Left
    Right = SDC::Mouse::Button::Right
    Middle = SDC::Mouse::Button::Middle

    VerticalWheel = SDC::Mouse::Wheel::VerticalWheel
    HorizontalWheel = SDC::Mouse::Wheel::HorizontalWheel

    def self.get_coordinates(window)
      window.map_pixel_to_coords(SDC::Mouse.get_position(relative_to: window))
    end

    def self.set_position(pos, window)
      SDC::Mouse.set_position(position: SDC::Vector2i.new(pos[0], pos[1]), relative_to: window)
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
    Backspace = SDC::Keyboard::Key::Backspace
    Tab = SDC::Keyboard::Key::Tab
    LControl = SDC::Keyboard::Key::LControl
    RControl = SDC::Keyboard::Key::RControl
    LShift = SDC::Keyboard::Key::LShift
    RShift = SDC::Keyboard::Key::RShift
    Num1 = SDC::Keyboard::Key::Num1
    Num2 = SDC::Keyboard::Key::Num2
    Num3 = SDC::Keyboard::Key::Num3
    Num4 = SDC::Keyboard::Key::Num4
    Num5 = SDC::Keyboard::Key::Num5
    Num6 = SDC::Keyboard::Key::Num6
    Num7 = SDC::Keyboard::Key::Num7
    Num8 = SDC::Keyboard::Key::Num8
    Num9 = SDC::Keyboard::Key::Num9
    Num0 = SDC::Keyboard::Key::Num0
    F1 = SDC::Keyboard::Key::F1
    F2 = SDC::Keyboard::Key::F2
    F3 = SDC::Keyboard::Key::F3
    F4 = SDC::Keyboard::Key::F4
    F5 = SDC::Keyboard::Key::F5
    F6 = SDC::Keyboard::Key::F6
    F7 = SDC::Keyboard::Key::F7
    F8 = SDC::Keyboard::Key::F8
    F9 = SDC::Keyboard::Key::F9
    F10 = SDC::Keyboard::Key::F10
    F11 = SDC::Keyboard::Key::F11
    F12 = SDC::Keyboard::Key::F12
    A = SDC::Keyboard::Key::A
    B = SDC::Keyboard::Key::B
    C = SDC::Keyboard::Key::C
    D = SDC::Keyboard::Key::D
    E = SDC::Keyboard::Key::E
    F = SDC::Keyboard::Key::F
    G = SDC::Keyboard::Key::G
    H = SDC::Keyboard::Key::H
    I = SDC::Keyboard::Key::I
    J = SDC::Keyboard::Key::J
    K = SDC::Keyboard::Key::K
    L = SDC::Keyboard::Key::L
    M = SDC::Keyboard::Key::M
    N = SDC::Keyboard::Key::N
    O = SDC::Keyboard::Key::O
    P = SDC::Keyboard::Key::P
    Q = SDC::Keyboard::Key::Q
    R = SDC::Keyboard::Key::R
    S = SDC::Keyboard::Key::S
    T = SDC::Keyboard::Key::T
    U = SDC::Keyboard::Key::U
    V = SDC::Keyboard::Key::V
    W = SDC::Keyboard::Key::W
    X = SDC::Keyboard::Key::X
    Y = SDC::Keyboard::Key::Y
    Z = SDC::Keyboard::Key::Z

    def self.is_pressed?(key)
      SDC::Keyboard.key_pressed?(key)
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