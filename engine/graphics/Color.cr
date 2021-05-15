module SF
  @[Anyolite::ExcludeInstanceMethod("inspect")]
  @[Anyolite::SpecializeInstanceMethod("initialize", [red : Int, green : Int, blue : Int, alpha : Int = 255])]
  @[Anyolite::WrapWithoutKeywordsInstanceMethod("initialize")]
  struct Color

  end
end

def setup_ruby_color_class(rb)
  Anyolite.wrap(rb, SF::Color, under: SF, verbose: true, wrap_superclass: false)
end
