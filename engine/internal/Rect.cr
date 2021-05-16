module SF
  @[Anyolite::SpecifyGenericTypes([T])]
  @[Anyolite::SpecializeInstanceMethod("initialize", [left : T, top : T, width : T, height : T])]
  @[Anyolite::SpecializeInstanceMethod("contains?", [point : Vector2 | Tuple], [point : Vector2(T)])]
  @[Anyolite::SpecializeInstanceMethod("==", [other : self], [other : Rect(T)])]
  @[Anyolite::WrapWithoutKeywordsInstanceMethod("initialize")]
  struct Rect(T)
  end
end

def setup_ruby_rect_class(rb)
  Anyolite.wrap(rb, SF::FloatRect, under: SF, verbose: true, wrap_superclass: false)
  Anyolite.wrap(rb, SF::IntRect, under: SF, verbose: true, wrap_superclass: false)
end
