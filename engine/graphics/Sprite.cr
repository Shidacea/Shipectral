module SF
  @[Anyolite::SpecializeInstanceMethod("initialize", nil)]
  @[Anyolite::ExcludeInstanceMethod("draw")]
  @[Anyolite::SpecializeInstanceMethod("position=", [position : Vector2 | Tuple], [position : Vector2f])]
  @[Anyolite::SpecializeInstanceMethod("scale=", [factors : Vector2 | Tuple], [factors : Vector2f])]
  @[Anyolite::SpecializeInstanceMethod("origin=", [origin : Vector2 | Tuple], [origin : Vector2f])]
  @[Anyolite::SpecializeInstanceMethod("scale", nil)]
  @[Anyolite::SpecializeInstanceMethod("move", [offset : Vector2 | Tuple], [offset : Vector2f])]
  @[Anyolite::DefaultOptionalArgsToKeywordArgs]
  class Sprite
    def link_texture(texture : Texture)
      set_texture(texture)
    end
  end
end

def setup_ruby_sprite_class(rb)
  Anyolite.wrap_class(rb, SF::Transformable, "Transformable", under: SF)
  Anyolite.wrap_class(rb, SF::Drawable, "Drawable", under: SF)
  Anyolite.wrap(rb, SF::Sprite, under: SF, verbose: true, connect_to_superclass: true)
end