# NOTE: This is still quite hacky to ensure compatibility with the old Shidacea scripts
# This will probably change in the future

macro generate_sdc_trait_method(topic, name, default, conversion_method = nil)
    def sdc_{{topic}}_{{name}}
        return_value = self.responds_to?(:{{name}}) ? self.{{name}} : {{default}}
        {% if conversion_method %}
            return_value.{{conversion_method}}
        {% else %}
            return_value
        {% end %}
    end
end

module SF
    struct Event
        def sdc_type
            @_type.to_u32
        end

        generate_sdc_trait_method(key, code, Keyboard::Key::Unknown, to_i32)
        generate_sdc_trait_method(key, alt, false)
        generate_sdc_trait_method(key, control, false)
        generate_sdc_trait_method(key, shift, false)
        generate_sdc_trait_method(key, system, false)
        generate_sdc_trait_method(mouse_button, code, Mouse::Button::ButtonCount, to_i32)
        generate_sdc_trait_method(mouse_button, x, 0.0)
        generate_sdc_trait_method(mouse_button, y, 0.0)
    end
end

def setup_ruby_event_class(mrb, module_sdc)
    MrbWrap.wrap_class(mrb, SF::Event, "Event", under: SF)
    MrbWrap.wrap_instance_method(mrb, SF::Event, "type", sdc_type)
    MrbWrap.wrap_instance_method(mrb, SF::Event, "key_code", sdc_key_code)
    MrbWrap.wrap_instance_method(mrb, SF::Event, "key_alt?", sdc_key_alt)
    MrbWrap.wrap_instance_method(mrb, SF::Event, "key_control?", sdc_key_control)
    MrbWrap.wrap_instance_method(mrb, SF::Event, "key_shift?", sdc_key_shift)
    MrbWrap.wrap_instance_method(mrb, SF::Event, "key_system?", sdc_key_system)
    MrbWrap.wrap_instance_method(mrb, SF::Event, "mouse_button_code", sdc_mouse_button_code)
    MrbWrap.wrap_instance_method(mrb, SF::Event, "mouse_button_x", sdc_mouse_button_x)
    MrbWrap.wrap_instance_method(mrb, SF::Event, "mouse_button_y", sdc_mouse_button_y)
end