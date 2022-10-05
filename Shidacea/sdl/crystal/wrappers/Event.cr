module SDC
  {% for potential_event_class in LibSDL.constants %}
    {% parsed_name = parse_type(potential_event_class.stringify).stringify %}
    {% if parsed_name != "Event" && parsed_name.ends_with?("Event") %}
      alias {{parsed_name.id}} = LibSDL::{{parsed_name.id}}
    {% end %}
  {% end %}

  struct WindowEvent
    {% for window_event_type in LibSDL::WindowEventID.constants %}
      {{window_event_type.stringify.gsub(/WINDOWEVENT_/, "").id}} = {{LibSDL::WindowEventID.constant(window_event_type)}}.to_i
    {% end %}
  end

  @[Anyolite::DefaultOptionalArgsToKeywordArgs]
  class Event
    @data : LibSDL::Event

    {% for event_type in LibSDL::EventType.constants %}
      {{event_type.stringify.gsub(/EVENT/, "").id}} = {{LibSDL::EventType.constant(event_type)}}.to_i
    {% end %}

    @[Anyolite::Exclude]
    def data
      @data
    end

    @[Anyolite::Specialize]
    def initialize(other_event : SDC::Event)
      @data = other_event.data
    end

    def initialize(raw_event : LibSDL::Event)
      @data = raw_event
    end

    def type
      @data.type
    end

    # TODO: There HAS to be an easier way (e.g. extracting this form LibSDL::Event, but HOW?)

    def as_display_event
      @data.display
    end

    def as_window_event
      @data.window
    end

    def as_key_event
      @data.key
    end

    def as_text_edit_event
      @data.edit
    end

    def as_text_edit_ext_event
      @data.edit_ext
    end

    def as_text_input_event
      @data.text
    end

    def as_mouse_motion_event
      @data.motion
    end

    def as_mouse_button_event
      @data.button
    end

    def as_mouse_wheel_event
      @data.wheel
    end

    def as_joy_axis_event
      @data.jaxis
    end

    def as_joy_ball_event
      @data.jball
    end

    def as_joy_hat_event
      @data.jhat
    end

    def as_joy_button_event
      @data.jbutton
    end

    def as_joy_device_event
      @data.jdevice
    end

    def as_joy_battery_event
      @data.jbattery
    end

    def as_controller_axis_event
      @data.caxis
    end

    def as_controller_button_event
      @data.cbutton
    end

    def as_controller_device_event
      @data.cdevice
    end

    def as_controller_touchpad_event
      @data.ctouchpad
    end

    def as_controller_sensor_event
      @data.csensor
    end

    def as_audio_device_event
      @data.adevice
    end

    def as_sensor_event
      @data.sensor
    end

    def as_quit_event
      @data.quit
    end

    def as_user_event
      @data.user
    end

    def as_syswm_event
      @data.syswm
    end

    def as_touch_finger_event
      @data.tfinger
    end

    def as_multi_gesture_event
      @data.mgesture
    end

    def as_dollar_gesture_event
      @data.dgesture
    end

    def as_drop_event
      @data.drop
    end
  end
end