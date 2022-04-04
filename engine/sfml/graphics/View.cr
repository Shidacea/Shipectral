module SF
  @[Anyolite::ExcludeInstanceMethod("inspect")]
  @[Anyolite::SpecializeInstanceMethod("initialize", [rectangle : FloatRect])]
  @[Anyolite::SpecializeInstanceMethod("move", [offset : Vector2 | Tuple], [offset : Vector2f])]
  @[Anyolite::SpecializeInstanceMethod("size=", [size : Vector2 | Tuple], [offset : Vector2f])]
  @[Anyolite::SpecializeInstanceMethod("center=", [center : Vector2 | Tuple], [offset : Vector2f])]
  @[Anyolite::DefaultOptionalArgsToKeywordArgs]
  @[Anyolite::ExcludeConstant("Reference")]
  class View

    def set_viewport(viewport : FloatRect)
      self.viewport = viewport
    end
  end
end

def setup_ruby_view_class(rb)
  Anyolite.wrap(rb, SF::View, under: SF, verbose: true, connect_to_superclass: false)
end
