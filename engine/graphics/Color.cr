module SF

  @[MrbWrap::SpecializeInstanceMethod("initialize", [red : Int, green : Int, blue : Int, alpha : Int = 255])]
  @[MrbWrap::ExcludeInstanceMethod("inspect")]
  struct Color

  end
end

def setup_ruby_color_class(mrb, module_sdc)
  MrbWrap.wrap_class_with_methods(mrb, SF::Color, under: SF, verbose: true)
end
