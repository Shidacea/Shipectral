module SF
  @[Anyolite::SpecializeInstanceMethod("initialize", nil)]
  struct RenderStates
  end
end

def setup_ruby_render_states_class(rb)
  Anyolite.wrap(rb, SF::RenderStates, under: SF, verbose: true, connect_to_superclass: false)
end
