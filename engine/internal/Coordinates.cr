module SF
  @[Anyolite::SpecifyGenericTypes([T])]
  @[Anyolite::ExcludeInstanceMethod("each")]
  @[Anyolite::ExcludeInstanceMethod("==")]
  @[Anyolite::SpecializeInstanceMethod("initialize", [x : T, y : T])]
  struct Vector2(T)
  end

  alias Coordinates = Vector2f
end

def setup_ruby_coordinates_class(rb)
  Anyolite.wrap_class_with_methods(rb, SF::Coordinates, under: SF)
  Anyolite.wrap_class_with_methods(rb, SF::Vector2i, under: SF)
end
