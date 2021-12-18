module SF
# Sadly, Shape is an abstract class, so we need to to this for every shape

  @[Anyolite::SpecializeInstanceMethod("scale", nil)]
  @[Anyolite::SpecializeInstanceMethod("move", [offset : Vector2 | Tuple], [offset : SF::Vector2f])]
  @[Anyolite::ExcludeInstanceMethod("draw")]
  @[Anyolite::SpecializeInstanceMethod("origin=", [origin : Vector2 | Tuple], [origin : SF::Vector2f])]
  @[Anyolite::SpecializeInstanceMethod("scale=", [factors : Vector2 | Tuple], [factors : SF::Vector2f])]
  @[Anyolite::SpecializeInstanceMethod("position=", [position : Vector2 | Tuple], [position : SF::Vector2f])]
  @[Anyolite::ExcludeInstanceMethod("set_texture")]
  @[Anyolite::DefaultOptionalArgsToKeywordArgs]
  class PointShape < Shape
    @point : Vector2f = Vector2f.new

    def initialize(point : SF::Vector2f = SF::Vector2f.new)
      super()

      @point = point
      update
    end

    def point_count : Int32
      1
    end

    def get_point(index : Int) : Vector2f
      @point
    end

    def dup : PointShape
      return PointShape.new(@point)
    end

    def link_texture(texture : Texture)
      self.texture= texture
    end

    def get_from(shape : CollisionShapePoint)
      @point = SF::Vector2f.new
      self.position = shape.position
      self.scale = shape.scale
      self.origin = shape.origin
      self.rotation = shape.rotation
      update
    end
  end

  @[Anyolite::SpecializeInstanceMethod("scale", nil)]
  @[Anyolite::SpecializeInstanceMethod("move", [offset : Vector2 | Tuple], [offset : SF::Vector2f])]
  @[Anyolite::ExcludeInstanceMethod("draw")]
  @[Anyolite::SpecializeInstanceMethod("origin=", [origin : Vector2 | Tuple], [origin : SF::Vector2f])]
  @[Anyolite::SpecializeInstanceMethod("scale=", [factors : Vector2 | Tuple], [factors : SF::Vector2f])]
  @[Anyolite::SpecializeInstanceMethod("position=", [position : Vector2 | Tuple], [position : SF::Vector2f])]
  @[Anyolite::ExcludeInstanceMethod("set_texture")]
  class LineShape < Shape
    @points : Array(SF::Vector2f) = [SF::Vector2f.new, SF::Vector2f.new]

    def initialize(start_point : SF::Vector2f = SF::Vector2f.new, end_point : SF::Vector2f = SF::Vector2f.new)
      super()

      @points[0] = start_point
      @points[1] = end_point

      self.outline_thickness = 0.5

      update
    end

    def line=(value : SF::Vector2f)
      @points[1] = value
      update
    end

    def line
      @points[1]
    end

    def point_count : Int32
      4
    end

    def get_point(index : Int) : Vector2f
      @points[index > 1 ? 3 - index : index]
    end

    def dup : LineShape
      return LineShape.new(@points[0], @points[1])
    end

    def link_texture(texture : Texture)
      self.texture= texture
    end

    def get_from(shape : CollisionShapeLine)
      @points = [SF::Vector2f.new, shape.line]
      self.position = shape.position
      self.scale = shape.scale
      self.origin = shape.origin
      self.rotation = shape.rotation
      update
    end
  end

  @[Anyolite::SpecializeInstanceMethod("initialize", [size : Vector2 | Tuple = Vector2.new(0, 0)], [size : Vector2f = SF::Vector2f.new(0, 0)])]
  @[Anyolite::SpecializeInstanceMethod("size=", [size : Vector2 | Tuple], [size : SF::Vector2f])]
  @[Anyolite::SpecializeInstanceMethod("scale", nil)]
  @[Anyolite::SpecializeInstanceMethod("move", [offset : Vector2 | Tuple], [offset : SF::Vector2f])]
  @[Anyolite::ExcludeInstanceMethod("draw")]
  @[Anyolite::SpecializeInstanceMethod("origin=", [origin : Vector2 | Tuple], [origin : SF::Vector2f])]
  @[Anyolite::SpecializeInstanceMethod("scale=", [factors : Vector2 | Tuple], [factors : SF::Vector2f])]
  @[Anyolite::SpecializeInstanceMethod("position=", [position : Vector2 | Tuple], [position : SF::Vector2f])]
  @[Anyolite::ExcludeInstanceMethod("set_texture")] # For some reason, this does not work
  @[Anyolite::DefaultOptionalArgsToKeywordArgs]
  class RectangleShape
    def link_texture(texture : Texture)
      self.texture= texture
    end

    def get_from(shape : CollisionShapeBox)
      self.size = shape.size
      self.position = shape.position
      self.scale = shape.scale
      self.origin = shape.origin
      update
    end
  end

  @[Anyolite::SpecializeInstanceMethod("initialize", [radius : Number = 0, point_count : Int = 30], [radius : Number = 0])]
  @[Anyolite::SpecializeInstanceMethod("scale", nil)]
  @[Anyolite::SpecializeInstanceMethod("move", [offset : Vector2 | Tuple], [offset : SF::Vector2f])]
  @[Anyolite::ExcludeInstanceMethod("draw")]
  @[Anyolite::SpecializeInstanceMethod("origin=", [origin : Vector2 | Tuple], [origin : SF::Vector2f])]
  @[Anyolite::SpecializeInstanceMethod("scale=", [factors : Vector2 | Tuple], [factors : SF::Vector2f])]
  @[Anyolite::SpecializeInstanceMethod("position=", [position : Vector2 | Tuple], [position : SF::Vector2f])]
  @[Anyolite::ExcludeInstanceMethod("set_texture")]
  @[Anyolite::DefaultOptionalArgsToKeywordArgs]
  class CircleShape
    def link_texture(texture : Texture)
      self.texture= texture
    end

    def get_from(shape : CollisionShapeCircle)
      self.radius = shape.radius
      self.position = shape.position - shape.scale * shape.radius
      self.scale = shape.scale
      self.origin = shape.origin
      update
    end
  end

  @[Anyolite::SpecializeInstanceMethod("scale", nil)]
  @[Anyolite::SpecializeInstanceMethod("move", [offset : Vector2 | Tuple], [offset : SF::Vector2f])]
  @[Anyolite::ExcludeInstanceMethod("draw")]
  @[Anyolite::SpecializeInstanceMethod("origin=", [origin : Vector2 | Tuple], [origin : SF::Vector2f])]
  @[Anyolite::SpecializeInstanceMethod("scale=", [factors : Vector2 | Tuple], [factors : SF::Vector2f])]
  @[Anyolite::SpecializeInstanceMethod("position=", [position : Vector2 | Tuple], [position : SF::Vector2f])]
  @[Anyolite::ExcludeInstanceMethod("set_texture")]
  @[Anyolite::DefaultOptionalArgsToKeywordArgs]
  class TriangleShape < Shape
    @points : Array(SF::Vector2f) = [SF::Vector2f.new, SF::Vector2f.new, SF::Vector2f.new]

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
      update
    end

    def side_2=(value : SF::Vector2f)
      set_point(2, value)
      update
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

    def link_texture(texture : Texture)
      self.texture= texture
    end

    def get_from(shape : CollisionShapeTriangle)
      @points = [SF::Vector2f.new, shape.side_1, shape.side_2]
      self.position = shape.position
      self.scale = shape.scale
      self.origin = shape.origin
      self.rotation = shape.rotation
      update
    end
  end
end

def setup_ruby_draw_shape_class(rb)
  Anyolite.wrap_class(rb, SF::Shape, "Shape", under: SF)
  Anyolite.wrap(rb, SF::PointShape, under: SF, verbose: true, connect_to_superclass: true)
  Anyolite.wrap(rb, SF::LineShape, under: SF, verbose: true, connect_to_superclass: true)
  Anyolite.wrap(rb, SF::RectangleShape, under: SF, verbose: true, connect_to_superclass: true)
  Anyolite.wrap(rb, SF::CircleShape, under: SF, verbose: true, connect_to_superclass: true)
  Anyolite.wrap(rb, SF::TriangleShape, under: SF, verbose: true, connect_to_superclass: true)
end