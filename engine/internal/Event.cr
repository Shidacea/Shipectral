module SF
  struct Event
    @[Anyolite::SpecializeInstanceMethod("initialize", nil)]; @[Anyolite::ExcludeInstanceMethod("dup")]; struct Resized; end
    @[Anyolite::SpecializeInstanceMethod("initialize", nil)]; @[Anyolite::ExcludeInstanceMethod("dup")]; struct TextEntered; end
    @[Anyolite::SpecializeInstanceMethod("initialize", nil)]; @[Anyolite::ExcludeInstanceMethod("dup")]; struct KeyPressed; end
    @[Anyolite::SpecializeInstanceMethod("initialize", nil)]; @[Anyolite::ExcludeInstanceMethod("dup")]; struct KeyReleased; end
    @[Anyolite::SpecializeInstanceMethod("initialize", nil)]; @[Anyolite::ExcludeInstanceMethod("dup")]; struct MouseWheelMoved; end
    @[Anyolite::SpecializeInstanceMethod("initialize", nil)]; @[Anyolite::ExcludeInstanceMethod("dup")]; struct MouseWheelScrolled; end
    @[Anyolite::SpecializeInstanceMethod("initialize", nil)]; @[Anyolite::ExcludeInstanceMethod("dup")]; struct MouseButtonPressed; end
    @[Anyolite::SpecializeInstanceMethod("initialize", nil)]; @[Anyolite::ExcludeInstanceMethod("dup")]; struct MouseButtonReleased; end
    @[Anyolite::SpecializeInstanceMethod("initialize", nil)]; @[Anyolite::ExcludeInstanceMethod("dup")]; struct MouseMoved; end
    @[Anyolite::SpecializeInstanceMethod("initialize", nil)]; @[Anyolite::ExcludeInstanceMethod("dup")]; struct JoystickButtonPressed; end
    @[Anyolite::SpecializeInstanceMethod("initialize", nil)]; @[Anyolite::ExcludeInstanceMethod("dup")]; struct JoystickButtonReleased; end
    @[Anyolite::SpecializeInstanceMethod("initialize", nil)]; @[Anyolite::ExcludeInstanceMethod("dup")]; struct JoystickMoved; end
    @[Anyolite::SpecializeInstanceMethod("initialize", nil)]; @[Anyolite::ExcludeInstanceMethod("dup")]; struct JoystickConnected; end
    @[Anyolite::SpecializeInstanceMethod("initialize", nil)]; @[Anyolite::ExcludeInstanceMethod("dup")]; struct JoystickDisconnected; end
    @[Anyolite::SpecializeInstanceMethod("initialize", nil)]; @[Anyolite::ExcludeInstanceMethod("dup")]; struct TouchBegan; end
    @[Anyolite::SpecializeInstanceMethod("initialize", nil)]; @[Anyolite::ExcludeInstanceMethod("dup")]; struct TouchMoved; end
    @[Anyolite::SpecializeInstanceMethod("initialize", nil)]; @[Anyolite::ExcludeInstanceMethod("dup")]; struct TouchEnded; end
    @[Anyolite::SpecializeInstanceMethod("initialize", nil)]; @[Anyolite::ExcludeInstanceMethod("dup")]; struct SensorChanged; end
  end
end

def setup_ruby_event_class(rb)
  Anyolite.wrap(rb, SF::Event, under: SF, verbose: true)
end