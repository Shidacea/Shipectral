module SF
    struct RenderStates
        def object_id
            0.to_u64
        end
    end
end

def setup_ruby_render_states_class(mrb, module_sdc)
    MrbWrap.wrap_class(mrb, SF::RenderStates, "RenderStates", under: module_sdc)
    MrbWrap.wrap_constructor(mrb, SF::RenderStates)
end