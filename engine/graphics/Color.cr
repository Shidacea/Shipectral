module SF
  @[Anyolite::SpecializeInstanceMethod("initialize", [red : Int, green : Int, blue : Int, alpha : Int = 255], [red : UInt8, green : UInt8, blue : UInt8, alpha : UInt8 = 255])]
  @[Anyolite::WrapWithoutKeywordsInstanceMethod("initialize")]
  struct Color
  end
end

def setup_ruby_color_class(rb)
  Anyolite.wrap(rb, SF::Color, under: SF, verbose: true, connect_to_superclass: false)
end
