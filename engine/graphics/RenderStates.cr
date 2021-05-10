module SF
  @[Anyolite::ExcludeInstanceMethod("inspect")]
  @[Anyolite::SpecializeInstanceMethod("initialize", [blend_mode : BlendMode])]
  struct RenderStates
  end
end

def setup_ruby_render_states_class(rb)
  Anyolite.wrap(rb, SF::RenderStates, under: SF, verbose: true, wrap_superclass: false)
end
