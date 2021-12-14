module SF
  @[Anyolite::SpecializeClassMethod("position=", [position : Vector2 | Tuple], [position : Vector2i])]
  @[Anyolite::ExcludeClassMethod("set_position")]
  @[Anyolite::ExcludeClassMethod("get_position")]
  module Mouse
  end
end

def setup_ruby_mouse_class(rb)
  Anyolite.wrap(rb, SF::Mouse, under: SF, verbose: true, connect_to_superclass: false)
end
