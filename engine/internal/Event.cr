module SF
  struct Event
    @[Anyolite::SpecializeInstanceMethod("initialize", nil)]; struct Resized; end
    @[Anyolite::SpecializeInstanceMethod("initialize", nil)]; struct TextEntered; end
    @[Anyolite::SpecializeInstanceMethod("initialize", nil)]; struct KeyPressed; end
    @[Anyolite::SpecializeInstanceMethod("initialize", nil)]; struct KeyReleased; end
    @[Anyolite::SpecializeInstanceMethod("initialize", nil)]; struct MouseWheelMoved; end
    @[Anyolite::SpecializeInstanceMethod("initialize", nil)]; struct MouseWheelScrolled; end
    @[Anyolite::SpecializeInstanceMethod("initialize", nil)]; struct MouseButtonPressed; end
    @[Anyolite::SpecializeInstanceMethod("initialize", nil)]; struct MouseButtonReleased; end
    @[Anyolite::SpecializeInstanceMethod("initialize", nil)]; struct MouseMoved; end
    @[Anyolite::SpecializeInstanceMethod("initialize", nil)]; struct JoystickButtonPressed; end
    @[Anyolite::SpecializeInstanceMethod("initialize", nil)]; struct JoystickButtonReleased; end
    @[Anyolite::SpecializeInstanceMethod("initialize", nil)]; struct JoystickMoved; end
    @[Anyolite::SpecializeInstanceMethod("initialize", nil)]; struct JoystickConnected; end
    @[Anyolite::SpecializeInstanceMethod("initialize", nil)]; struct JoystickDisconnected; end
    @[Anyolite::SpecializeInstanceMethod("initialize", nil)]; struct TouchBegan; end
    @[Anyolite::SpecializeInstanceMethod("initialize", nil)]; struct TouchMoved; end
    @[Anyolite::SpecializeInstanceMethod("initialize", nil)]; struct TouchEnded; end
    @[Anyolite::SpecializeInstanceMethod("initialize", nil)]; struct SensorChanged; end
  end
end

def setup_ruby_event_class(rb)
  Anyolite.wrap(rb, SF::Event, under: SF, verbose: true)
end