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
  Anyolite.wrap(rb, SF::Transformable, under: SF, verbose: true, wrap_superclass: false, class_method_exclusions: ["<="])
  Anyolite.wrap(rb, CollisionShape, under: SF, verbose: true, wrap_superclass: true, class_method_exclusions: ["<="])
  Anyolite.wrap(rb, CollisionShapePoint, under: SF, verbose: true, wrap_superclass: true, class_method_exclusions: ["<="])
  Anyolite.wrap(rb, CollisionShapeLine, under: SF, verbose: true, wrap_superclass: true, class_method_exclusions: ["<="])
  Anyolite.wrap(rb, CollisionShapeCircle, under: SF, verbose: true, wrap_superclass: true, class_method_exclusions: ["<="])
  Anyolite.wrap(rb, CollisionShapeBox, under: SF, verbose: true, wrap_superclass: true, class_method_exclusions: ["<="])
  Anyolite.wrap(rb, CollisionShapeTriangle, under: SF, verbose: true, wrap_superclass: true, class_method_exclusions: ["<="])
  Anyolite.wrap(rb, CollisionShapeEllipse, under: SF, verbose: true, wrap_superclass: true, class_method_exclusions: ["<="])
end
