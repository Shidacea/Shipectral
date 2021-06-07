macro process_all_events(rb, event_class)
  {% for event_type in event_class.resolve.constants %}
    {% actual_class = event_class.resolve.constant(event_type).resolve %}
    {% if actual_class.abstract? %}
      Anyolite.wrap_class({{rb}}, {{actual_class}}, {{event_type.stringify}}, under: SF, superclass: {{event_class}})
    {% else %}
      Anyolite.wrap({{rb}}, {{actual_class}}, under: {{event_class}}, connect_to_superclass: true, include_ancestor_methods: false, instance_method_exclusions: ["hash"], verbose: true)
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

  # TODO: Add all the other event parameters
  wrap_for_all_events_of_type(rb, SF::Event::KeyPressed, ["code", "alt", "control", "shift", "system"])
  wrap_for_all_events_of_type(rb, SF::Event::KeyReleased, ["code", "alt", "control", "shift", "system"])
  wrap_for_all_events_of_type(rb, SF::Event::MouseButtonPressed, ["button", "x", "y"])
  wrap_for_all_events_of_type(rb, SF::Event::MouseButtonReleased, ["button", "x", "y"])
  wrap_for_all_events_of_type(rb, SF::Event::MouseWheelScrolled, ["delta", "wheel", "x", "y"])
  wrap_for_all_events_of_type(rb, SF::Event::MouseMoved, ["x", "y"])
  wrap_for_all_events_of_type(rb, SF::Event::TextEntered, ["unicode"])
end