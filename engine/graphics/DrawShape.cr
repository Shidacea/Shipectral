module SF
# Sadly, Shape is an abstract class, so we need to to this for every shape

  @[Anyolite::RenameClass("DrawShapeRectangle")]
  @[Anyolite::SpecializeInstanceMethod("initialize", [size : Vector2 | Tuple = Vector2.new(0, 0)], [size : Vector2f = SF::Vector2f.new(0, 0)])]
  @[Anyolite::SpecializeInstanceMethod("size=", [size : Vector2 | Tuple], [size : SF::Vector2f])]
  @[Anyolite::SpecializeInstanceMethod("scale", nil)]
  @[Anyolite::SpecializeInstanceMethod("move", [offset : Vector2 | Tuple], [offset : SF::Vector2f])]
  @[Anyolite::SpecializeInstanceMethod("draw", [target : RenderWindow, states : RenderStates])]
  @[Anyolite::SpecializeInstanceMethod("origin=", [origin : Vector2 | Tuple], [origin : SF::Vector2f])]
  @[Anyolite::SpecializeInstanceMethod("scale=", [factors : Vector2 | Tuple], [factors : SF::Vector2f])]
  @[Anyolite::SpecializeInstanceMethod("position=", [position : Vector2 | Tuple], [position : SF::Vector2f])]
  @[Anyolite::ExcludeInstanceMethod("set_texture")] # For some reason, this does not work
  class RectangleShape
    @[Anyolite::WrapWithoutKeywords]
    def link_texture(texture : Texture)
      self.texture= texture
    end
  end

  @[Anyolite::RenameClass("DrawShapeCircle")]
  @[Anyolite::SpecializeInstanceMethod("initialize", [radius : Number = 0, point_count : Int = 30], [radius : Number = 0])]
  @[Anyolite::SpecializeInstanceMethod("scale", nil)]
  @[Anyolite::SpecializeInstanceMethod("move", [offset : Vector2 | Tuple], [offset : SF::Vector2f])]
  @[Anyolite::SpecializeInstanceMethod("draw", [target : RenderWindow, states : RenderStates])]
  @[Anyolite::SpecializeInstanceMethod("origin=", [origin : Vector2 | Tuple], [origin : SF::Vector2f])]
  @[Anyolite::SpecializeInstanceMethod("scale=", [factors : Vector2 | Tuple], [factors : SF::Vector2f])]
  @[Anyolite::SpecializeInstanceMethod("position=", [position : Vector2 | Tuple], [position : SF::Vector2f])]
  @[Anyolite::ExcludeInstanceMethod("set_texture")]
  class CircleShape
    @[Anyolite::WrapWithoutKeywords]
    def link_texture(texture : Texture)
      self.texture= texture
    end
  end
end

def setup_ruby_draw_shape_class(rb)
  Anyolite.wrap(rb, SF::RectangleShape, under: SF, verbose: true, connect_to_superclass: false)
  Anyolite.wrap(rb, SF::CircleShape, under: SF, verbose: true, connect_to_superclass: false)
end