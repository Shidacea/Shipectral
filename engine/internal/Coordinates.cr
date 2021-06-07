module SF
  @[Anyolite::SpecifyGenericTypes([T])]
  @[Anyolite::ExcludeInstanceMethod("each")]
  @[Anyolite::SpecializeInstanceMethod("==", [other : Vector2], [other : Vector2(T)])]
  @[Anyolite::SpecializeInstanceMethod("*", [n : Number])]
  @[Anyolite::SpecializeInstanceMethod("+", [other], [other : Vector2(T)])]
  @[Anyolite::SpecializeInstanceMethod("-", [other], [other : Vector2(T)])]
  @[Anyolite::SpecializeInstanceMethod("initialize", [x : T, y : T])]
  @[Anyolite::WrapWithoutKeywordsInstanceMethod("initialize")]
  struct Vector2(T)
    @[Anyolite::WrapWithoutKeywords]
    def dot(other : Vector2(T))
      self * other
    end
  end
end

def setup_ruby_coordinates_class(rb)
  Anyolite.wrap_class_with_methods(rb, SF::Vector2f, under: SF, include_ancestor_methods: false, verbose: true)
  Anyolite.wrap_class_with_methods(rb, SF::Vector2i, under: SF, include_ancestor_methods: false, verbose: true)
end
