module SF
  @[Anyolite::SpecializeClassMethod("position=", [position : Vector2 | Tuple], [position : Vector2i])]
  @[Anyolite::SpecializeClassMethod("set_position", [position : Vector2 | Tuple, relative_to : Window], [position : Vector2i, relative_to : Window])]
  module Mouse
  end
end

def setup_ruby_mouse_class(rb)
  Anyolite.wrap(rb, SF::Mouse, under: SF, verbose: true, connect_to_superclass: false)
end
