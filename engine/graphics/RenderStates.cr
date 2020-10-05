def setup_ruby_render_states_class(mrb, module_sdc)
    MrbWrap.wrap_class(mrb, SF::RenderStates, "RenderStates", under: module_sdc)
    MrbWrap.wrap_constructor(mrb, SF::RenderStates)
end