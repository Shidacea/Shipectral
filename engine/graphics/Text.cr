@[MrbWrap::ExcludeConstant("Vector2")]
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
end
