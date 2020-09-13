def setup_ruby_text_class(mrb, module_sdc)
    MrbWrap.wrap_class(mrb, SF::Text, "Text", under: module_sdc)
    MrbWrap.wrap_constructor(mrb, SF::Text, [String, SF::Font, {Int32, 30}])
    MrbWrap.wrap_property(mrb, SF::Text, "character_size", character_size, Int32)
    MrbWrap.wrap_property(mrb, SF::Text, "fill_color", fill_color, SF::Color)
    MrbWrap.wrap_property(mrb, SF::Text, "outline_color", outline_color, SF::Color)
    MrbWrap.wrap_property(mrb, SF::Text, "string", string, String)  # Might need some rework to ensure full Unicode compatibility
end