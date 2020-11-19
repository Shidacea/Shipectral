module SF

  @[MrbWrap::SpecializeInstanceMethod("initialize", [string : String, font : Font, character_size : Int = 30])]
  @[MrbWrap::ExcludeInstanceMethod("scale")]
  @[MrbWrap::ExcludeInstanceMethod("move")]
  @[MrbWrap::ExcludeInstanceMethod("draw")]
  @[MrbWrap::ExcludeInstanceMethod("inspect")]
  @[MrbWrap::ExcludeInstanceMethod("position=")]
  @[MrbWrap::ExcludeInstanceMethod("scale=")]
  @[MrbWrap::ExcludeInstanceMethod("origin=")]
  @[MrbWrap::ExcludeInstanceMethod("style")]
  @[MrbWrap::ExcludeInstanceMethod("style=")]
  @[MrbWrap::ExcludeConstant("Style")]
  @[MrbWrap::ExcludeConstant("Regular")]
  @[MrbWrap::ExcludeConstant("Bold")]
  @[MrbWrap::ExcludeConstant("Italic")]
  @[MrbWrap::ExcludeConstant("Underlined")]
  @[MrbWrap::ExcludeConstant("StrikeThrough")]
  @[MrbWrap::ExcludeConstant("None")]
  @[MrbWrap::ExcludeConstant("All")]
  class Text

  end
end

def setup_ruby_text_class(mrb)
  MrbWrap.wrap_class_with_methods(mrb, SF::Text, under: SF, verbose: true)
  #MrbWrap.wrap_class(mrb, SF::Text, "Text", under: module_sdc)
  #MrbWrap.wrap_constructor(mrb, SF::Text, [String, SF::Font, {Int32, 30}])
  #MrbWrap.wrap_property(mrb, SF::Text, "character_size", character_size, Int32)
  #MrbWrap.wrap_property(mrb, SF::Text, "fill_color", fill_color, SF::Color)
  #MrbWrap.wrap_property(mrb, SF::Text, "outline_color", outline_color, SF::Color)
  #MrbWrap.wrap_property(mrb, SF::Text, "string", string, String) # Might need some rework to ensure full Unicode compatibility
end
