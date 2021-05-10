module SF
  @[Anyolite::ExcludeInstanceMethod("inspect")]
  @[Anyolite::SpecializeInstanceMethod("initialize", nil)]
  @[Anyolite::SpecializeInstanceMethod("draw", [target : RenderWindow, states : RenderStates])]
  @[Anyolite::SpecializeInstanceMethod("position=", [position : Vector2 | Tuple], [position : Vector2f])]
  @[Anyolite::SpecializeInstanceMethod("scale=", [factors : Vector2 | Tuple], [factors : Vector2f])]
  @[Anyolite::SpecializeInstanceMethod("origin=", [origin : Vector2 | Tuple], [origin : Vector2f])]
  @[Anyolite::SpecializeInstanceMethod("scale", [factor : Vector2 | Tuple], [factor : Vector2f])]
  @[Anyolite::SpecializeInstanceMethod("move", [offset : Vector2 | Tuple], [offset : Vector2f])]
  class Text

  end
end

def setup_ruby_text_class(rb)
  Anyolite.wrap(rb, SF::Text, under: SF, verbose: true, wrap_superclass: false)
end
