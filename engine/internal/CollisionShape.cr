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
end

class CollisionShapeLine < CollisionShape
  property line : SF::Vector2f = SF::Vector2f.new
end

def setup_ruby_collision_shape_class(rb)
  Anyolite.wrap(rb, SF::Transformable, under: SF, verbose: true, wrap_superclass: false, class_method_exclusions: ["<="])
  Anyolite.wrap(rb, CollisionShape, under: SF, verbose: true, wrap_superclass: true, class_method_exclusions: ["<="])
  Anyolite.wrap(rb, CollisionShapePoint, under: SF, verbose: true, wrap_superclass: true, class_method_exclusions: ["<="])
  Anyolite.wrap(rb, CollisionShapeLine, under: SF, verbose: true, wrap_superclass: true, class_method_exclusions: ["<="])
end
