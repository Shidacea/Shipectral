module SF
  @[Anyolite::SpecifyGenericTypes([T])]
  @[Anyolite::ExcludeInstanceMethod("each")]
  @[Anyolite::ExcludeInstanceMethod("==")]
  @[Anyolite::ExcludeInstanceMethod("+")]
  @[Anyolite::ExcludeInstanceMethod("-")]
  @[Anyolite::ExcludeInstanceMethod("*")]
  @[Anyolite::SpecializeInstanceMethod("initialize", [x : T, y : T])]
  @[Anyolite::WrapWithoutKeywordsInstanceMethod("initialize")]
  struct Vector2(T)
    @[Anyolite::Rename("+")]
    def add(other : Vector2(T))
      self + other
    end

    @[Anyolite::Rename("-")]
    def subtract(other : Vector2(T))
      self - other
    end

    @[Anyolite::Rename("*")]
    def multiply(other : T)
      self * other
    end

    def dot(other : Vector2(T))
      self * other
    end
  end

  alias Coordinates = Vector2f
end

def setup_ruby_coordinates_class(rb)
  Anyolite.wrap_class_with_methods(rb, SF::Coordinates, under: SF)
  Anyolite.wrap_class_with_methods(rb, SF::Vector2i, under: SF)
end
