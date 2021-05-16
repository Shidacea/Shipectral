module SF
  @[Anyolite::ExcludeInstanceMethod("inspect")]
  @[Anyolite::SpecializeInstanceMethod("initialize", nil)]
  @[Anyolite::SpecializeInstanceMethod("draw", [target : RenderWindow, states : RenderStates], [target : RenderWindow, states : RenderStates = SF::RenderStates.new])]
  @[Anyolite::SpecializeInstanceMethod("position=", [position : Vector2 | Tuple], [position : Vector2f])]
  @[Anyolite::SpecializeInstanceMethod("scale=", [factors : Vector2 | Tuple], [factors : Vector2f])]
  @[Anyolite::SpecializeInstanceMethod("origin=", [origin : Vector2 | Tuple], [origin : Vector2f])]
  @[Anyolite::SpecializeInstanceMethod("scale", [factor : Vector2 | Tuple], [factor : Vector2f])]
  @[Anyolite::SpecializeInstanceMethod("move", [offset : Vector2 | Tuple], [offset : Vector2f])]
  class Sprite
    @[Anyolite::WrapWithoutKeywords]
    def link_texture(texture : Texture)
      set_texture(texture)
    end
  end
end

def setup_ruby_sprite_class(rb)
  Anyolite.wrap_class(rb, SF::Transformable, "Transformable", under: SF)
  Anyolite.wrap_class(rb, SF::Drawable, "Drawable", under: SF)
  Anyolite.wrap(rb, SF::Sprite, under: SF, verbose: true, wrap_superclass: true)
end