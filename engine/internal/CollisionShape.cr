module SF
  @[Anyolite::SpecializeInstanceMethod("initialize", nil)]
  @[Anyolite::SpecializeInstanceMethod("move", [offset : Vector2 | Tuple], [offset : SF::Vector2f])]
  @[Anyolite::SpecializeInstanceMethod("scale", nil)]
  @[Anyolite::SpecializeInstanceMethod("origin=", [origin : Vector2 | Tuple], [origin : SF::Vector2f])]
  @[Anyolite::SpecializeInstanceMethod("scale=", [factors : Vector2 | Tuple], [factors : SF::Vector2f])]
  @[Anyolite::SpecializeInstanceMethod("position=", [position : Vector2 | Tuple], [position : SF::Vector2f])]
  class Transformable
  end
end

# NOTE: These are only excluded here to avoid duplicates, since they are later on wrapped manually.
# This was only done to directly include them into the SF module instead of the Collider module.

# TODO: Fix shifted hitboxes for some objects

@[Anyolite::ExcludeConstant("CollisionShape")]
@[Anyolite::ExcludeConstant("CollisionShapePoint")]
@[Anyolite::ExcludeConstant("CollisionShapeLine")]
@[Anyolite::ExcludeConstant("CollisionShapeCircle")]
@[Anyolite::ExcludeConstant("CollisionShapeBox")]
@[Anyolite::ExcludeConstant("CollisionShapeTriangle")]
@[Anyolite::ExcludeConstant("CollisionShapeEllipse")]
module Collider
  
  # Useful macros

  macro vice_versa
    Collider.check_collision(shape_2, shape_1, pos_2, pos_1)
  end

  # General test method

  @[Anyolite::WrapWithoutKeywords]
  def self.test(shape_1 : CollisionShape, pos_1 : SF::Vector2f, shape_2 : CollisionShape, pos_2 : SF::Vector2f)
    offset_1 = shape_1.position - shape_1.origin
    offset_2 = shape_2.position - shape_2.origin
    self.check_collision(shape_1, shape_2, pos_1 + offset_1, pos_2 + offset_2)
  end

  # Point vs ...

  def self.check_collision(shape_1 : CollisionShapePoint, shape_2 : CollisionShapePoint, pos_1 : SF::Vector2f, pos_2 : SF::Vector2f)
    x1 = pos_1.x
    y1 = pos_1.y

    x2 = pos_2.x
    y2 = pos_2.y

    Collishi.collision_point_point(x1, y1, x2, y2)
  end

  def self.check_collision(shape_1 : CollisionShapePoint, shape_2 : CollisionShapeLine, pos_1 : SF::Vector2f, pos_2 : SF::Vector2f)
    x1 = pos_1.x
    y1 = pos_1.y

    x2 = pos_2.x
    y2 = pos_2.y
    dx2 = shape_2.line.x
    dy2 = shape_2.line.y

    Collishi.collision_point_line(x1, y1, x2, y2, dx2, dy2)
  end

  def self.check_collision(shape_1 : CollisionShapePoint, shape_2 : CollisionShapeCircle, pos_1 : SF::Vector2f, pos_2 : SF::Vector2f)
    x1 = pos_1.x
    y1 = pos_1.y

    x2 = pos_2.x
    y2 = pos_2.y
    r2 = shape_2.radius * shape_2.scale.x

    Collishi.collision_point_circle(x1, y1, x2, y2, r2)
  end

  def self.check_collision(shape_1 : CollisionShapePoint, shape_2 : CollisionShapeBox, pos_1 : SF::Vector2f, pos_2 : SF::Vector2f)
    x1 = pos_1.x
    y1 = pos_1.y

    x2 = pos_2.x
    y2 = pos_2.y
    w2 = shape_2.size.x * shape_2.scale.x 
    h2 = shape_2.size.y * shape_2.scale.y

    Collishi.collision_point_box(x1, y1, x2, y2, w2, h2)
  end

  def self.check_collision(shape_1 : CollisionShapePoint, shape_2 : CollisionShapeTriangle, pos_1 : SF::Vector2f, pos_2 : SF::Vector2f)
    x1 = pos_1.x
    y1 = pos_1.y

    x2 = pos_2.x
    y2 = pos_2.y
    sxa2 = shape_2.side_1.x * shape_2.scale.x
    sya2 = shape_2.side_1.y * shape_2.scale.y
    sxb2 = shape_2.side_2.x * shape_2.scale.x
    syb2 = shape_2.side_2.y * shape_2.scale.y

    Collishi.collision_point_triangle(x1, y1, x2, y2, sxa2, sya2, sxb2, syb2)
  end

  # Line vs ...

  def self.check_collision(shape_1 : CollisionShapeLine, shape_2 : CollisionShapePoint, pos_1 : SF::Vector2f, pos_2 : SF::Vector2f)
    Collider.vice_versa
  end

  def self.check_collision(shape_1 : CollisionShapeLine, shape_2 : CollisionShapeLine, pos_1 : SF::Vector2f, pos_2 : SF::Vector2f)
    x1 = pos_1.x
    y1 = pos_1.y
    dx1 = shape_1.line.x
    dy1 = shape_1.line.y

    x2 = pos_2.x
    y2 = pos_2.y
    dx2 = shape_2.line.x
    dy2 = shape_2.line.y

    Collishi.collision_line_line(x1, y1, dx1, dy1, x2, y2, dx2, dy2)
  end

  def self.check_collision(shape_1 : CollisionShapeLine, shape_2 : CollisionShapeCircle, pos_1 : SF::Vector2f, pos_2 : SF::Vector2f)
    x1 = pos_1.x
    y1 = pos_1.y
    dx1 = shape_1.line.x
    dy1 = shape_1.line.y

    x2 = pos_2.x
    y2 = pos_2.y
    r2 = shape_2.radius * shape_2.scale.x

    Collishi.collision_line_circle(x1, y1, dx1, dy1, x2, y2, r2)
  end

  def self.check_collision(shape_1 : CollisionShapeLine, shape_2 : CollisionShapeBox, pos_1 : SF::Vector2f, pos_2 : SF::Vector2f)
    x1 = pos_1.x
    y1 = pos_1.y
    dx1 = shape_1.line.x
    dy1 = shape_1.line.y

    x2 = pos_2.x
    y2 = pos_2.y
    w2 = shape_2.size.x * shape_2.scale.x 
    h2 = shape_2.size.y * shape_2.scale.y

    Collishi.collision_line_box(x1, y1, dx1, dy1, x2, y2, w2, h2)
  end

  def self.check_collision(shape_1 : CollisionShapeLine, shape_2 : CollisionShapeTriangle, pos_1 : SF::Vector2f, pos_2 : SF::Vector2f)
    x1 = pos_1.x
    y1 = pos_1.y
    dx1 = shape_1.line.x
    dy1 = shape_1.line.y

    x2 = pos_2.x
    y2 = pos_2.y
    sxa2 = shape_2.side_1.x * shape_2.scale.x
    sya2 = shape_2.side_1.y * shape_2.scale.y
    sxb2 = shape_2.side_2.x * shape_2.scale.x
    syb2 = shape_2.side_2.y * shape_2.scale.y
    
    Collishi.collision_line_triangle(x1, y1, dx1, dy1, x2, y2, sxa2, sya2, sxb2, syb2)
  end

  # Circle vs ...

  def self.check_collision(shape_1 : CollisionShapeCircle, shape_2 : CollisionShapePoint, pos_1 : SF::Vector2f, pos_2 : SF::Vector2f)
    Collider.vice_versa
  end

  def self.check_collision(shape_1 : CollisionShapeCircle, shape_2 : CollisionShapeLine, pos_1 : SF::Vector2f, pos_2 : SF::Vector2f)
    Collider.vice_versa
  end

  def self.check_collision(shape_1 : CollisionShapeCircle, shape_2 : CollisionShapeCircle, pos_1 : SF::Vector2f, pos_2 : SF::Vector2f)
    x1 = pos_1.x
    y1 = pos_1.y
    r1 = shape_1.radius * shape_1.scale.x

    x2 = pos_2.x
    y2 = pos_2.y
    r2 = shape_2.radius * shape_2.scale.x

    Collishi.collision_circle_circle(x1, y1, r1, x2, y2, r2)
  end

  def self.check_collision(shape_1 : CollisionShapeCircle, shape_2 : CollisionShapeBox, pos_1 : SF::Vector2f, pos_2 : SF::Vector2f)
    x1 = pos_1.x
    y1 = pos_1.y
    r1 = shape_1.radius * shape_1.scale.x

    x2 = pos_2.x
    y2 = pos_2.y
    w2 = shape_2.size.x * shape_2.scale.x 
    h2 = shape_2.size.y * shape_2.scale.y

    Collishi.collision_circle_box(x1, y1, r1, x2, y2, w2, h2)
  end

  def self.check_collision(shape_1 : CollisionShapeCircle, shape_2 : CollisionShapeTriangle, pos_1 : SF::Vector2f, pos_2 : SF::Vector2f)
    x1 = pos_1.x
    y1 = pos_1.y
    r1 = shape_1.radius * shape_1.scale.x

    x2 = pos_2.x
    y2 = pos_2.y
    sxa2 = shape_2.side_1.x * shape_2.scale.x
    sya2 = shape_2.side_1.y * shape_2.scale.y
    sxb2 = shape_2.side_2.x * shape_2.scale.x
    syb2 = shape_2.side_2.y * shape_2.scale.y

    Collishi.collision_circle_triangle(x1, y1, r1, x2, y2, sxa2, sya2, sxb2, syb2)
  end

  # Box vs ...

  def self.check_collision(shape_1 : CollisionShapeBox, shape_2 : CollisionShapePoint, pos_1 : SF::Vector2f, pos_2 : SF::Vector2f)
    Collider.vice_versa
  end

  def self.check_collision(shape_1 : CollisionShapeBox, shape_2 : CollisionShapeLine, pos_1 : SF::Vector2f, pos_2 : SF::Vector2f)
    Collider.vice_versa
  end

  def self.check_collision(shape_1 : CollisionShapeBox, shape_2 : CollisionShapeCircle, pos_1 : SF::Vector2f, pos_2 : SF::Vector2f)
    Collider.vice_versa
  end

  def self.check_collision(shape_1 : CollisionShapeBox, shape_2 : CollisionShapeBox, pos_1 : SF::Vector2f, pos_2 : SF::Vector2f)
    x1 = pos_1.x
    y1 = pos_1.y
    w1 = shape_1.size.x * shape_1.scale.x 
    h1 = shape_1.size.y * shape_1.scale.y

    x2 = pos_2.x
    y2 = pos_2.y
    w2 = shape_2.size.x * shape_2.scale.x 
    h2 = shape_2.size.y * shape_2.scale.y

    Collishi.collision_box_box(x1, y1, w1, h1, x2, y2, w2, h2)
  end

  def self.check_collision(shape_1 : CollisionShapeBox, shape_2 : CollisionShapeTriangle, pos_1 : SF::Vector2f, pos_2 : SF::Vector2f)
    x1 = pos_1.x
    y1 = pos_1.y
    w1 = shape_1.size.x * shape_1.scale.x 
    h1 = shape_1.size.y * shape_1.scale.y

    x2 = pos_2.x
    y2 = pos_2.y
    sxa2 = shape_2.side_1.x * shape_2.scale.x
    sya2 = shape_2.side_1.y * shape_2.scale.y
    sxb2 = shape_2.side_2.x * shape_2.scale.x
    syb2 = shape_2.side_2.y * shape_2.scale.y

    Collishi.collision_box_triangle(x1, y1, w1, h1, x2, y2, sxa2, sya2, sxb2, syb2)
  end

  # Triangle vs ...

  def self.check_collision(shape_1 : CollisionShapeTriangle, shape_2 : CollisionShapePoint, pos_1 : SF::Vector2f, pos_2 : SF::Vector2f)
    Collider.vice_versa
  end

  def self.check_collision(shape_1 : CollisionShapeTriangle, shape_2 : CollisionShapeLine, pos_1 : SF::Vector2f, pos_2 : SF::Vector2f)
    Collider.vice_versa
  end

  def self.check_collision(shape_1 : CollisionShapeTriangle, shape_2 : CollisionShapeCircle, pos_1 : SF::Vector2f, pos_2 : SF::Vector2f)
    Collider.vice_versa
  end

  def self.check_collision(shape_1 : CollisionShapeTriangle, shape_2 : CollisionShapeBox, pos_1 : SF::Vector2f, pos_2 : SF::Vector2f)
    Collider.vice_versa
  end

  def self.check_collision(shape_1 : CollisionShapeTriangle, shape_2 : CollisionShapeTriangle, pos_1 : SF::Vector2f, pos_2 : SF::Vector2f)
    x1 = pos_1.x
    y1 = pos_1.y
    sxa1 = shape_1.side_1.x * shape_1.scale.x
    sya1 = shape_1.side_1.y * shape_1.scale.y
    sxb1 = shape_1.side_2.x * shape_1.scale.x
    syb1 = shape_1.side_2.y * shape_1.scale.y

    x2 = pos_2.x
    y2 = pos_2.y
    sxa2 = shape_2.side_1.x * shape_2.scale.x
    sya2 = shape_2.side_1.y * shape_2.scale.y
    sxb2 = shape_2.side_2.x * shape_2.scale.x
    syb2 = shape_2.side_2.y * shape_2.scale.y

    Collishi.collision_triangle_triangle(x1, y1, sxa1, sya1, sxb1, syb1, x2, y2, sxa2, sya2, sxb2, syb2)
  end

  # Failsafe

  @[Anyolite::Specialize]
  def self.check_collision(shape_1 : CollisionShape, shape_2 : CollisionShape, pos_1 : SF::Vector2f, pos_2 : SF::Vector2f)
    raise "Unknown shapes: #{shape_1.class} and #{shape_2.class}"
    false
  end
end

class CollisionShape < SF::Transformable
  def dup
    CollisionShape.new
  end

  # Legacy name convention for compatibility with older Shidacea versions
  def offset=(value : SF::Vector2f)
    self.position = value
  end

  def inspect
    "(No shape)"
  end
end

class CollisionShapePoint < CollisionShape
  @[Anyolite::WrapWithoutKeywords]
  def initialize(offset : SF::Vector2f = SF::Vector2f.new)
    super()
    self.position = offset
  end

  def dup
    return_shape = CollisionShapePoint.new(offset: self.position)
    return_shape.origin = self.origin
    return_shape.scale = self.scale
    return_shape
  end

  def inspect
    "Point-#{self.position.inspect}"
  end
end

class CollisionShapeLine < CollisionShape
  property line : SF::Vector2f = SF::Vector2f.new

  @[Anyolite::WrapWithoutKeywords]
  def initialize(offset : SF::Vector2f = SF::Vector2f.new, line : SF::Vector2f = SF::Vector2f.new)
    super()
    self.position = offset
    @line = line
  end

  def dup
    return_shape = CollisionShapeLine.new(offset: self.position, line: @line)
    return_shape.origin = self.origin
    return_shape.scale = self.scale
    return_shape
  end

  def inspect
    "Line-#{self.position.inspect}-#{@line.inspect}"
  end
end

class CollisionShapeCircle < CollisionShape
  property radius : Float32 = 0.0

  @[Anyolite::WrapWithoutKeywords]
  def initialize(offset : SF::Vector2f = SF::Vector2f.new, radius : Float32 = 0.0)
    super()
    self.position = offset
    @radius = radius
  end

  def dup
    return_shape = CollisionShapeCircle.new(offset: self.position, radius: @radius)
    return_shape.origin = self.origin
    return_shape.scale = self.scale
    return_shape
  end

  def inspect
    "Circle-#{self.position.inspect}-#{@radius}"
  end
end

class CollisionShapeBox < CollisionShape
  property size : SF::Vector2f = SF::Vector2f.new

  @[Anyolite::WrapWithoutKeywords]
  def initialize(offset : SF::Vector2f = SF::Vector2f.new, size : SF::Vector2f = SF::Vector2f.new)
    super()
    self.position = offset
    @size = size
  end

  def dup
    return_shape = CollisionShapeBox.new(offset: self.position, size: @size)
    return_shape.origin = self.origin
    return_shape.scale = self.scale
    return_shape
  end

  def inspect
    "Box-#{self.position.inspect}-#{@size.inspect}"
  end
end

class CollisionShapeTriangle < CollisionShape
  property side_1 : SF::Vector2f = SF::Vector2f.new 
  property side_2 : SF::Vector2f = SF::Vector2f.new

  @[Anyolite::WrapWithoutKeywords]
  def initialize(offset : SF::Vector2f = SF::Vector2f.new, side_1 : SF::Vector2f = SF::Vector2f.new, side_2 : SF::Vector2f = SF::Vector2f.new)
    super()
    self.position = offset
    @side_1 = side_1
    @side_2 = side_2
  end

  def dup
    return_shape = CollisionShapeTriangle.new(offset: self.position, side_1: @side_1, side_2: @side_2)
    return_shape.origin = self.origin
    return_shape.scale = self.scale
    return_shape
  end

  def inspect
    "Triangle-#{self.position.inspect}-#{@side_1.inspect}-#{@side_2.inspect}"
  end
end

# TODO: Quadrangle
# TODO: Support for ellipses

class CollisionShapeEllipse < CollisionShape
  property semiaxes : SF::Vector2f = SF::Vector2f.new

  @[Anyolite::WrapWithoutKeywords]
  def initialize(offset : SF::Vector2f = SF::Vector2f.new, semiaxes : SF::Vector2f = SF::Vector2f.new)
    super()
    self.position = offset
    @semiaxes = semiaxes
  end

  def dup
    return_shape = CollisionShapeEllipse.new(offset: self.position, semiaxes: @semiaxes)
    return_shape.origin = self.origin
    return_shape.scale = self.scale
    return_shape
  end
  
  def inspect
    "Ellipse-#{self.position.inspect}-#{@semiaxes.inspect}"
  end
end

def setup_ruby_collision_shape_class(rb)
  Anyolite.wrap(rb, SF::Transformable, under: SF, verbose: true, connect_to_superclass: false)
  Anyolite.wrap(rb, CollisionShape, under: SF, verbose: true, connect_to_superclass: true)
  Anyolite.wrap(rb, CollisionShapePoint, under: SF, verbose: true, connect_to_superclass: true)
  Anyolite.wrap(rb, CollisionShapeLine, under: SF, verbose: true, connect_to_superclass: true)
  Anyolite.wrap(rb, CollisionShapeCircle, under: SF, verbose: true, connect_to_superclass: true)
  Anyolite.wrap(rb, CollisionShapeBox, under: SF, verbose: true, connect_to_superclass: true)
  Anyolite.wrap(rb, CollisionShapeTriangle, under: SF, verbose: true, connect_to_superclass: true)
  Anyolite.wrap(rb, CollisionShapeEllipse, under: SF, verbose: true, connect_to_superclass: true)
  Anyolite.wrap(rb, Collider, under: SF, verbose: true)
end
