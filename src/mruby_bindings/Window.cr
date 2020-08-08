def setup_ruby_window_class(mrb)
    MrbWrap.wrap_class(mrb, SF::Window, "Window")
    MrbWrap.wrap_constructor(mrb, SF::Window)
end