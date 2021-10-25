module SF
# Sadly, Shape is an abstract class, so we need to to this for every shape

  @[Anyolite::RenameClass("DrawShapeRectangle")]
  @[Anyolite::SpecializeInstanceMethod("initialize", [size : Vector2 | Tuple = Vector2.new(0, 0)], [size : Vector2f = SF::Vector2f.new(0, 0)])]
  @[Anyolite::SpecializeInstanceMethod("size=", [size : Vector2 | Tuple], [size : SF::Vector2f])]
  @[Anyolite::SpecializeInstanceMethod("scale", nil)]
  @[Anyolite::SpecializeInstanceMethod("move", [offset : Vector2 | Tuple], [offset : SF::Vector2f])]
  @[Anyolite::ExcludeInstanceMethod("draw")]
  @[Anyolite::SpecializeInstanceMethod("origin=", [origin : Vector2 | Tuple], [origin : SF::Vector2f])]
  @[Anyolite::SpecializeInstanceMethod("scale=", [factors : Vector2 | Tuple], [factors : SF::Vector2f])]
  @[Anyolite::SpecializeInstanceMethod("position=", [position : Vector2 | Tuple], [position : SF::Vector2f])]
  @[Anyolite::ExcludeInstanceMethod("set_texture")] # For some reason, this does not work
  class RectangleShape
    @[Anyolite::WrapWithoutKeywords]
    def link_texture(texture : Texture)
      self.texture= texture
    end

    @[Anyolite::WrapWithoutKeywords]
    def get_from(shape : CollisionShapeBox)
      self.size = shape.size
      self.position = shape.position
      self.scale = shape.scale
      self.origin = shape.origin
    end
  end

  @[Anyolite::RenameClass("DrawShapeCircle")]
  @[Anyolite::SpecializeInstanceMethod("initialize", [radius : Number = 0, point_count : Int = 30], [radius : Number = 0])]
  @[Anyolite::SpecializeInstanceMethod("scale", nil)]
  @[Anyolite::SpecializeInstanceMethod("move", [offset : Vector2 | Tuple], [offset : SF::Vector2f])]
  @[Anyolite::ExcludeInstanceMethod("draw")]
  @[Anyolite::SpecializeInstanceMethod("origin=", [origin : Vector2 | Tuple], [origin : SF::Vector2f])]
  @[Anyolite::SpecializeInstanceMethod("scale=", [factors : Vector2 | Tuple], [factors : SF::Vector2f])]
  @[Anyolite::SpecializeInstanceMethod("position=", [position : Vector2 | Tuple], [position : SF::Vector2f])]
  @[Anyolite::ExcludeInstanceMethod("set_texture")]
  class CircleShape
    @[Anyolite::WrapWithoutKeywords]
    def link_texture(texture : Texture)
      self.texture= texture
    end

    @[Anyolite::WrapWithoutKeywords]
    def get_from(shape : CollisionShapeCircle)
      self.radius = shape.radius
      self.position = shape.position - shape.scale * shape.radius
      self.scale = shape.scale
      self.origin = shape.origin
    end
  end

  @[Anyolite::RenameClass("DrawShapeTriangle")]
  @[Anyolite::SpecializeInstanceMethod("scale", nil)]
  @[Anyolite::SpecializeInstanceMethod("move", [offset : Vector2 | Tuple], [offset : SF::Vector2f])]
  @[Anyolite::ExcludeInstanceMethod("draw")]
  @[Anyolite::SpecializeInstanceMethod("origin=", [origin : Vector2 | Tuple], [origin : SF::Vector2f])]
  @[Anyolite::SpecializeInstanceMethod("scale=", [factors : Vector2 | Tuple], [factors : SF::Vector2f])]
  @[Anyolite::SpecializeInstanceMethod("position=", [position : Vector2 | Tuple], [position : SF::Vector2f])]
  @[Anyolite::ExcludeInstanceMethod("set_texture")]
  class TriangleShape < Shape
    @points : Array(Vector2f) = [Vector2f.new, Vector2f.new, Vector2f.new]

    def initialize(point_0 : SF::Vector2f = SF::Vector2f.new, point_1 : SF::Vector2f = SF::Vector2f.new, point_2 : SF::Vector2f = SF::Vector2f.new)
      super()

      @points[0] = point_0
      @points[1] = point_1
      @points[2] = point_2

      update
    end

    def set_point(index : UInt64, value : SF::Vector2f)
      @points[index] = value
      update
    end

    def side_1=(value : SF::Vector2f)
      set_point(1, value)
    end

    def side_2=(value : SF::Vector2f)
      set_point(2, value)
    end

    def side_1
      @points[1]
    end

    def side_2
      @points[2]
    end

    def point_count : Int32
      3
    end

    def get_point(index : Int) : Vector2f
      @points[index]
    end

    def dup : TriangleShape
      return TriangleShape.new(@points[0], @points[1], @points[2])
    end
  end
end

def setup_ruby_draw_shape_class(rb)
  Anyolite.wrap_class(rb, SF::Shape, "DrawShape", under: SF)
  Anyolite.wrap(rb, SF::RectangleShape, under: SF, verbose: true, connect_to_superclass: true)
  Anyolite.wrap(rb, SF::CircleShape, under: SF, verbose: true, connect_to_superclass: true)
  Anyolite.wrap(rb, SF::TriangleShape, under: SF, verbose: true, connect_to_superclass: true)
end