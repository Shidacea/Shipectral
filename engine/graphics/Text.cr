module SF
  @[Anyolite::SpecializeInstanceMethod("initialize", [string : String, font : Font, character_size : Int = 30])]
  @[Anyolite::SpecializeInstanceMethod("draw", [target : RenderWindow, states : RenderStates])]
  @[Anyolite::SpecializeInstanceMethod("position=", [position : Vector2 | Tuple], [position : Vector2f])]
  @[Anyolite::SpecializeInstanceMethod("scale=", [factors : Vector2 | Tuple], [factors : Vector2f])]
  @[Anyolite::SpecializeInstanceMethod("origin=", [origin : Vector2 | Tuple], [origin : Vector2f])]
  @[Anyolite::SpecializeInstanceMethod("scale", nil)]
  @[Anyolite::SpecializeInstanceMethod("move", [offset : Vector2 | Tuple], [offset : Vector2f])]
  @[Anyolite::WrapWithoutKeywordsInstanceMethod("initialize")]
  class Text

  end
end

def setup_ruby_text_class(rb)
  Anyolite.wrap(rb, SF::Text, under: SF, verbose: true, connect_to_superclass: false)
end
