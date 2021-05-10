module SF
  struct Event
    struct KeyPressed
      # TODO: Remove this once Keyboard is wrapped
      # Also never try this at home
      def code_to_int
        pointerof(@code).as(UInt32*).value
      end
    end
  end
end

macro process_all_events(rb, event_class)
  {% for event_type in event_class.resolve.constants %}
    {% actual_class = event_class.resolve.constant(event_type).resolve %}
    {% if actual_class.abstract? %}
      Anyolite.wrap_class({{rb}}, {{actual_class}}, {{event_type.stringify}}, under: SF, superclass: {{event_class}})
    {% else %}
      Anyolite.wrap({{rb}}, {{actual_class}}, under: {{event_class}}, class_method_exclusions: ["<="], instance_method_exclusions: ["hash"], verbose: true)
    {% end %}
  {% end %}
end

macro wrap_for_all_events_of_type(rb, event_type, methods)
  {% for method in methods %}
    Anyolite.wrap_instance_method({{rb}}, {{event_type}}, {{method}}, {{method.id}})
  {% end %}
end

def setup_ruby_event_class(rb)
  Anyolite.wrap_class(rb, SF::Event, "Event", under: SF)
  process_all_events(rb, SF::Event)
  wrap_for_all_events_of_type(rb, SF::Event::KeyPressed, ["code", "alt", "control", "shift", "system"])
  wrap_for_all_events_of_type(rb, SF::Event::KeyReleased, ["code", "alt", "control", "shift", "system"])
end