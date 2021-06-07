module SF
  @[Anyolite::ExcludeInstanceMethod("inspect")]
  @[Anyolite::SpecializeInstanceMethod("initialize", nil)]
  @[Anyolite::SpecializeInstanceMethod("move", [offset : Vector2 | Tuple], [offset : Vector2f])]
  @[Anyolite::SpecializeInstanceMethod("scale", [factors : Vector2 | Tuple], [factors : Vector2f])]
  @[Anyolite::SpecializeInstanceMethod("origin=", [origin : Vector2 | Tuple], [origin : Vector2f])]
  @[Anyolite::SpecializeInstanceMethod("scale=", [factors : Vector2 | Tuple], [factors : Vector2f])]
  @[Anyolite::SpecializeInstanceMethod("position=", [position : Vector2 | Tuple], [position : Vector2f])]
  class Transformable
  end
end

macro wrap_for_all_shapes_of_type(rb, shape_type, methods)
  {% for method in methods %}
    Anyolite.wrap_instance_method({{rb}}, {{shape_type}}, {{method}}, Anyolite::Empty, [par : SF::Vector2f], operator: "{{method.id}}")
  {% end %}
end

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

  def self.check_collision(shape_1 : CollisionShapePoint, shape_2 : CollisionShapeBox, pos_1 : SF::Vector2f, pos_2 : SF::Vector2f)
    x1 = pos_1.x
    y1 = pos_1.y
    x2 = pos_2.x
    y2 = pos_2.y
    w2 = shape_2.size.x * shape_2.scale.x 
    h2 = shape_2.size.y * shape_2.scale.y
    Collishi.collision_point_box(x1, y1, x2, y2, w2, h2)
  end

  # Box vs ...

  def self.check_collision(shape_1 : CollisionShapeBox, shape_2 : CollisionShapePoint, pos_1 : SF::Vector2f, pos_2 : SF::Vector2f)
    Collider.vice_versa
  end

  # TODO: Other shapes

  # Failsafe

  @[Anyolite::Specialize]
  def self.check_collision(shape_1 : CollisionShape, shape_2 : CollisionShape, pos_1 : SF::Vector2f, pos_2 : SF::Vector2f)
    raise "Unknown shapes: #{shape_1.class} and #{shape_2.class}"
    false
  end
end

class CollisionShape < SF::Transformable
end

class CollisionShapePoint < CollisionShape
  @[Anyolite::WrapWithoutKeywords]
  def initialize(offset : SF::Vector2f = SF::Vector2f.new)
    super()
    self.position = offset
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
end

class CollisionShapeCircle < CollisionShape
  property radius : Float32 = 0.0

  @[Anyolite::WrapWithoutKeywords]
  def initialize(offset : SF::Vector2f = SF::Vector2f.new, radius : Float32 = 0.0)
    super()
    self.position = offset
    @radius = radius
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
end

# TODO: Quadrangle

class CollisionShapeEllipse < CollisionShape
  property semiaxes : SF::Vector2f = SF::Vector2f.new

  @[Anyolite::WrapWithoutKeywords]
  def initialize(offset : SF::Vector2f = SF::Vector2f.new, semiaxes : SF::Vector2f = SF::Vector2f.new)
    super()
    self.position = offset
    @semiaxes = semiaxes
  end
end

def setup_ruby_collision_shape_class(rb)
  Anyolite.wrap(rb, SF::Transformable, under: SF, verbose: true, connect_to_superclass: false, include_ancestor_methods: false,)
  Anyolite.wrap(rb, CollisionShape, under: SF, verbose: true, connect_to_superclass: true, include_ancestor_methods: false)
  Anyolite.wrap(rb, CollisionShapePoint, under: SF, verbose: true, connect_to_superclass: true, include_ancestor_methods: false)
  Anyolite.wrap(rb, CollisionShapeLine, under: SF, verbose: true, connect_to_superclass: true, include_ancestor_methods: false)
  Anyolite.wrap(rb, CollisionShapeCircle, under: SF, verbose: true, connect_to_superclass: true, include_ancestor_methods: false)
  Anyolite.wrap(rb, CollisionShapeBox, under: SF, verbose: true, connect_to_superclass: true, include_ancestor_methods: false)
  Anyolite.wrap(rb, CollisionShapeTriangle, under: SF, verbose: true, connect_to_superclass: true, include_ancestor_methods: false)
  Anyolite.wrap(rb, CollisionShapeEllipse, under: SF, verbose: true, connect_to_superclass: true, include_ancestor_methods: false)
  Anyolite.wrap(rb, Collider, under: SF, verbose: true, connect_to_superclass: false, include_ancestor_methods: false)

  # TODO: Find a better solution or update Anyolite to include inherited methods
  wrap_for_all_shapes_of_type(rb, CollisionShape, ["origin="])
  wrap_for_all_shapes_of_type(rb, CollisionShapePoint, ["origin="])
  wrap_for_all_shapes_of_type(rb, CollisionShapeLine, ["origin="])
  wrap_for_all_shapes_of_type(rb, CollisionShapeCircle, ["origin="])
  wrap_for_all_shapes_of_type(rb, CollisionShapeBox, ["origin="])
  wrap_for_all_shapes_of_type(rb, CollisionShapeTriangle, ["origin="])
  wrap_for_all_shapes_of_type(rb, CollisionShapeEllipse, ["origin="])
end
