module SDC
  class CollisionShape
    property position : SDC::Coords = SDC.xy
    property scale : SDC::Coords = SDC.xy

    def dup
      CollisionShape.new
    end
  
    def inspect
      "(No shape)"
    end
  end
  
  @[Anyolite::DefaultOptionalArgsToKeywordArgs]
  class CollisionShapePoint < CollisionShape
    def initialize(position : SDC::Coords = SDC.xy)
      super()
      self.position = position
    end
  
    def dup
      return_shape = CollisionShapePoint.new(position: self.position)
      return_shape.scale = self.scale
      return_shape
    end
  
    def inspect
      "Point-#{self.position.inspect}"
    end
  end
  
  @[Anyolite::DefaultOptionalArgsToKeywordArgs]
  class CollisionShapeLine < CollisionShape
    property line : SDC::Coords = SDC.xy
  
    def initialize(position : SDC::Coords = SDC.xy, line : SDC::Coords = SDC.xy)
      super()
      self.position = position
      @line = line
    end
  
    def dup
      return_shape = CollisionShapeLine.new(position: self.position, line: @line)
      return_shape.scale = self.scale
      return_shape
    end
  
    def inspect
      "Line-#{self.position.inspect}-#{@line.inspect}"
    end
  end
  
  @[Anyolite::ExcludeInstanceMethod("scale")]
  @[Anyolite::DefaultOptionalArgsToKeywordArgs]
  class CollisionShapeCircle < CollisionShape
    property radius : Float32 = 0.0
  
    def initialize(position : SDC::Coords = SDC.xy, radius : Float32 = 0.0f32)
      super()
      self.position = position
      @radius = radius
    end
  
    def dup
      return_shape = CollisionShapeCircle.new(position: self.position, radius: @radius)
      return_shape.scale = self.scale
      return_shape
    end
  
    @[Anyolite::Rename("scale")]
    def scale_helper
      self.scale.x
    end
  
    @[Anyolite::Specialize]
    def scale=(value : Float)
      self.scale = SDC.xy(value.to_f32, value.to_f32)
    end
  
    def inspect
      "Circle-#{self.position.inspect}-#{@radius}"
    end
  end
  
  @[Anyolite::DefaultOptionalArgsToKeywordArgs]
  class CollisionShapeBox < CollisionShape
    property size : SDC::Coords = SDC.xy
  
    def initialize(position : SDC::Coords = SDC.xy, size : SDC::Coords = SDC.xy)
      super()
      self.position = position
      @size = size
    end
  
    def dup
      return_shape = CollisionShapeBox.new(position: self.position, size: @size)
      return_shape.scale = self.scale
      return_shape
    end
  
    def inspect
      "Box-#{self.position.inspect}-#{@size.inspect}"
    end
  end
  
  @[Anyolite::DefaultOptionalArgsToKeywordArgs]
  class CollisionShapeTriangle < CollisionShape
    property side_1 : SDC::Coords = SDC.xy 
    property side_2 : SDC::Coords = SDC.xy
  
    def initialize(position : SDC::Coords = SDC.xy, side_1 : SDC::Coords = SDC.xy, side_2 : SDC::Coords = SDC.xy)
      super()
      self.position = position
      @side_1 = side_1
      @side_2 = side_2
    end
  
    def dup
      return_shape = CollisionShapeTriangle.new(position: self.position, side_1: @side_1, side_2: @side_2)
      return_shape.scale = self.scale
      return_shape
    end
  
    def inspect
      "Triangle-#{self.position.inspect}-#{@side_1.inspect}-#{@side_2.inspect}"
    end
  end
  
  # TODO: Quadrangle
  # TODO: Support for ellipse drawing
  
  @[Anyolite::DefaultOptionalArgsToKeywordArgs]
  class CollisionShapeEllipse < CollisionShape
    property semiaxes : SDC::Coords = SDC.xy
  
    def initialize(position : SDC::Coords = SDC.xy, semiaxes : SDC::Coords = SDC.xy)
      super()
      self.position = position
      @semiaxes = semiaxes
    end
  
    def dup
      return_shape = CollisionShapeEllipse.new(position: self.position, semiaxes: @semiaxes)
      return_shape.scale = self.scale
      return_shape
    end
    
    def inspect
      "Ellipse-#{self.position.inspect}-#{@semiaxes.inspect}"
    end
  end

  @[Anyolite::DefaultOptionalArgsToKeywordArgs]
  module Collider
    
    # Useful macros

    macro vice_versa
      Collider.check_collision(shape_2, shape_1, pos_2, pos_1)
    end

    # General test method

    def self.test(shape_1 : SDC::CollisionShape, pos_1 : SDC::Coords, shape_2 : SDC::CollisionShape, pos_2 : SDC::Coords)
      self.check_collision(shape_1, shape_2, pos_1 + shape_1.position, pos_2 + shape_2.position)
    end

    # Point vs ...

    def self.check_collision(shape_1 : SDC::CollisionShapePoint, shape_2 : SDC::CollisionShapePoint, pos_1 : SDC::Coords, pos_2 : SDC::Coords)
      x1 = pos_1.x
      y1 = pos_1.y

      x2 = pos_2.x
      y2 = pos_2.y

      Collishi.collision_point_point(x1, y1, x2, y2)
    end

    def self.check_collision(shape_1 : SDC::CollisionShapePoint, shape_2 : SDC::CollisionShapeLine, pos_1 : SDC::Coords, pos_2 : SDC::Coords)
      x1 = pos_1.x
      y1 = pos_1.y

      x2 = pos_2.x
      y2 = pos_2.y
      dx2 = shape_2.line.x
      dy2 = shape_2.line.y

      Collishi.collision_point_line(x1, y1, x2, y2, dx2, dy2)
    end

    def self.check_collision(shape_1 : SDC::CollisionShapePoint, shape_2 : SDC::CollisionShapeCircle, pos_1 : SDC::Coords, pos_2 : SDC::Coords)
      x1 = pos_1.x
      y1 = pos_1.y

      x2 = pos_2.x
      y2 = pos_2.y
      r2 = shape_2.radius * shape_2.scale.x

      Collishi.collision_point_circle(x1, y1, x2, y2, r2)
    end

    def self.check_collision(shape_1 : SDC::CollisionShapePoint, shape_2 : SDC::CollisionShapeBox, pos_1 : SDC::Coords, pos_2 : SDC::Coords)
      x1 = pos_1.x
      y1 = pos_1.y

      x2 = pos_2.x
      y2 = pos_2.y
      w2 = shape_2.size.x * shape_2.scale.x 
      h2 = shape_2.size.y * shape_2.scale.y

      Collishi.collision_point_box(x1, y1, x2, y2, w2, h2)
    end

    def self.check_collision(shape_1 : SDC::CollisionShapePoint, shape_2 : SDC::CollisionShapeTriangle, pos_1 : SDC::Coords, pos_2 : SDC::Coords)
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

    def self.check_collision(shape_1 : SDC::CollisionShapePoint, shape_2 : SDC::CollisionShapeEllipse, pos_1 : SDC::Coords, pos_2 : SDC::Coords)
      x1 = pos_1.x
      y1 = pos_1.y

      x2 = pos_2.x
      y2 = pos_2.y
      a2 = shape_2.semiaxes.x * shape_2.scale.x
      b2 = shape_2.semiaxes.y * shape_2.scale.y

      Collishi.collision_point_ellipse(x1, y1, x2, y2, a2, b2)
    end

    # Line vs ...

    def self.check_collision(shape_1 : SDC::CollisionShapeLine, shape_2 : SDC::CollisionShapePoint, pos_1 : SDC::Coords, pos_2 : SDC::Coords)
      Collider.vice_versa
    end

    def self.check_collision(shape_1 : SDC::CollisionShapeLine, shape_2 : SDC::CollisionShapeLine, pos_1 : SDC::Coords, pos_2 : SDC::Coords)
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

    def self.check_collision(shape_1 : SDC::CollisionShapeLine, shape_2 : SDC::CollisionShapeCircle, pos_1 : SDC::Coords, pos_2 : SDC::Coords)
      x1 = pos_1.x
      y1 = pos_1.y
      dx1 = shape_1.line.x
      dy1 = shape_1.line.y

      x2 = pos_2.x
      y2 = pos_2.y
      r2 = shape_2.radius * shape_2.scale.x

      Collishi.collision_line_circle(x1, y1, dx1, dy1, x2, y2, r2)
    end

    def self.check_collision(shape_1 : SDC::CollisionShapeLine, shape_2 : SDC::CollisionShapeBox, pos_1 : SDC::Coords, pos_2 : SDC::Coords)
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

    def self.check_collision(shape_1 : SDC::CollisionShapeLine, shape_2 : SDC::CollisionShapeTriangle, pos_1 : SDC::Coords, pos_2 : SDC::Coords)
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

    def self.check_collision(shape_1 : SDC::CollisionShapeLine, shape_2 : SDC::CollisionShapeEllipse, pos_1 : SDC::Coords, pos_2 : SDC::Coords)
      x1 = pos_1.x
      y1 = pos_1.y
      dx1 = shape_1.line.x
      dy1 = shape_1.line.y

      x2 = pos_2.x
      y2 = pos_2.y
      a2 = shape_2.semiaxes.x * shape_2.scale.x
      b2 = shape_2.semiaxes.y * shape_2.scale.y

      Collishi.collision_line_ellipse(x1, y1, dx1, dy1, x2, y2, a2, b2)
    end

    # Circle vs ...

    def self.check_collision(shape_1 : SDC::CollisionShapeCircle, shape_2 : SDC::CollisionShapePoint, pos_1 : SDC::Coords, pos_2 : SDC::Coords)
      Collider.vice_versa
    end

    def self.check_collision(shape_1 : SDC::CollisionShapeCircle, shape_2 : SDC::CollisionShapeLine, pos_1 : SDC::Coords, pos_2 : SDC::Coords)
      Collider.vice_versa
    end

    def self.check_collision(shape_1 : SDC::CollisionShapeCircle, shape_2 : SDC::CollisionShapeCircle, pos_1 : SDC::Coords, pos_2 : SDC::Coords)
      x1 = pos_1.x
      y1 = pos_1.y
      r1 = shape_1.radius * shape_1.scale.x

      x2 = pos_2.x
      y2 = pos_2.y
      r2 = shape_2.radius * shape_2.scale.x

      Collishi.collision_circle_circle(x1, y1, r1, x2, y2, r2)
    end

    def self.check_collision(shape_1 : SDC::CollisionShapeCircle, shape_2 : SDC::CollisionShapeBox, pos_1 : SDC::Coords, pos_2 : SDC::Coords)
      x1 = pos_1.x
      y1 = pos_1.y
      r1 = shape_1.radius * shape_1.scale.x

      x2 = pos_2.x
      y2 = pos_2.y
      w2 = shape_2.size.x * shape_2.scale.x 
      h2 = shape_2.size.y * shape_2.scale.y

      Collishi.collision_circle_box(x1, y1, r1, x2, y2, w2, h2)
    end

    def self.check_collision(shape_1 : SDC::CollisionShapeCircle, shape_2 : SDC::CollisionShapeTriangle, pos_1 : SDC::Coords, pos_2 : SDC::Coords)
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

    def self.check_collision(shape_1 : SDC::CollisionShapeCircle, shape_2 : SDC::CollisionShapeEllipse, pos_1 : SDC::Coords, pos_2 : SDC::Coords)
      x1 = pos_1.x
      y1 = pos_1.y
      r1 = shape_1.radius * shape_1.scale.x

      x2 = pos_2.x
      y2 = pos_2.y
      a2 = shape_2.semiaxes.x * shape_2.scale.x
      b2 = shape_2.semiaxes.y * shape_2.scale.y

      Collishi.collision_circle_ellipse(x1, y1, r1, x2, y2, a2, b2)
    end

    # Box vs ...

    def self.check_collision(shape_1 : SDC::CollisionShapeBox, shape_2 : SDC::CollisionShapePoint, pos_1 : SDC::Coords, pos_2 : SDC::Coords)
      Collider.vice_versa
    end

    def self.check_collision(shape_1 : SDC::CollisionShapeBox, shape_2 : SDC::CollisionShapeLine, pos_1 : SDC::Coords, pos_2 : SDC::Coords)
      Collider.vice_versa
    end

    def self.check_collision(shape_1 : SDC::CollisionShapeBox, shape_2 : SDC::CollisionShapeCircle, pos_1 : SDC::Coords, pos_2 : SDC::Coords)
      Collider.vice_versa
    end

    def self.check_collision(shape_1 : SDC::CollisionShapeBox, shape_2 : SDC::CollisionShapeBox, pos_1 : SDC::Coords, pos_2 : SDC::Coords)
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

    def self.check_collision(shape_1 : SDC::CollisionShapeBox, shape_2 : SDC::CollisionShapeTriangle, pos_1 : SDC::Coords, pos_2 : SDC::Coords)
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

    def self.check_collision(shape_1 : SDC::CollisionShapeBox, shape_2 : SDC::CollisionShapeEllipse, pos_1 : SDC::Coords, pos_2 : SDC::Coords)
      x1 = pos_1.x
      y1 = pos_1.y
      w1 = shape_1.size.x * shape_1.scale.x 
      h1 = shape_1.size.y * shape_1.scale.y

      x2 = pos_2.x
      y2 = pos_2.y
      a2 = shape_2.semiaxes.x * shape_2.scale.x
      b2 = shape_2.semiaxes.y * shape_2.scale.y

      Collishi.collision_box_ellipse(x1, y1, w1, h1, x2, y2, a2, b2)
    end

    # Triangle vs ...

    def self.check_collision(shape_1 : SDC::CollisionShapeTriangle, shape_2 : SDC::CollisionShapePoint, pos_1 : SDC::Coords, pos_2 : SDC::Coords)
      Collider.vice_versa
    end

    def self.check_collision(shape_1 : SDC::CollisionShapeTriangle, shape_2 : SDC::CollisionShapeLine, pos_1 : SDC::Coords, pos_2 : SDC::Coords)
      Collider.vice_versa
    end

    def self.check_collision(shape_1 : SDC::CollisionShapeTriangle, shape_2 : SDC::CollisionShapeCircle, pos_1 : SDC::Coords, pos_2 : SDC::Coords)
      Collider.vice_versa
    end

    def self.check_collision(shape_1 : SDC::CollisionShapeTriangle, shape_2 : SDC::CollisionShapeBox, pos_1 : SDC::Coords, pos_2 : SDC::Coords)
      Collider.vice_versa
    end

    def self.check_collision(shape_1 : SDC::CollisionShapeTriangle, shape_2 : SDC::CollisionShapeTriangle, pos_1 : SDC::Coords, pos_2 : SDC::Coords)
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

    def self.check_collision(shape_1 : SDC::CollisionShapeTriangle, shape_2 : SDC::CollisionShapeEllipse, pos_1 : SDC::Coords, pos_2 : SDC::Coords)
      x1 = pos_1.x
      y1 = pos_1.y
      sxa1 = shape_1.side_1.x * shape_1.scale.x
      sya1 = shape_1.side_1.y * shape_1.scale.y
      sxb1 = shape_1.side_2.x * shape_1.scale.x
      syb1 = shape_1.side_2.y * shape_1.scale.y

      x2 = pos_2.x
      y2 = pos_2.y
      a2 = shape_2.semiaxes.x * shape_2.scale.x
      b2 = shape_2.semiaxes.y * shape_2.scale.y

      Collishi.collision_triangle_ellipse(x1, y1, sxa1, sya1, sxb1, syb1, x2, y2, a2, b2)
    end

    # Ellipse vs ...

    def self.check_collision(shape_1 : SDC::CollisionShapeEllipse, shape_2 : SDC::CollisionShapePoint, pos_1 : SDC::Coords, pos_2 : SDC::Coords)
      Collider.vice_versa
    end

    def self.check_collision(shape_1 : SDC::CollisionShapeEllipse, shape_2 : SDC::CollisionShapeLine, pos_1 : SDC::Coords, pos_2 : SDC::Coords)
      Collider.vice_versa
    end

    def self.check_collision(shape_1 : SDC::CollisionShapeEllipse, shape_2 : SDC::CollisionShapeCircle, pos_1 : SDC::Coords, pos_2 : SDC::Coords)
      Collider.vice_versa
    end

    def self.check_collision(shape_1 : SDC::CollisionShapeEllipse, shape_2 : SDC::CollisionShapeBox, pos_1 : SDC::Coords, pos_2 : SDC::Coords)
      Collider.vice_versa
    end

    def self.check_collision(shape_1 : SDC::CollisionShapeEllipse, shape_2 : SDC::CollisionShapeTriangle, pos_1 : SDC::Coords, pos_2 : SDC::Coords)
      Collider.vice_versa
    end

    def self.check_collision(shape_1 : SDC::CollisionShapeEllipse, shape_2 : SDC::CollisionShapeEllipse, pos_1 : SDC::Coords, pos_2 : SDC::Coords)
      x1 = pos_1.x
      y1 = pos_1.y
      a1 = shape_1.semiaxes.x * shape_1.scale.x
      b1 = shape_1.semiaxes.y * shape_1.scale.y

      x2 = pos_2.x
      y2 = pos_2.y
      a2 = shape_2.semiaxes.x * shape_2.scale.x
      b2 = shape_2.semiaxes.y * shape_2.scale.y

      Collishi.collision_ellipse_ellipse(x1, y1, a1, b1, x2, y2, a2, b2)
    end

    # Failsafe

    @[Anyolite::Specialize]
    def self.check_collision(shape_1 : SDC::CollisionShape, shape_2 : SDC::CollisionShape, pos_1 : SDC::Coords, pos_2 : SDC::Coords)
      raise "Unknown shapes: #{shape_1.class} and #{shape_2.class}"
      false
    end
  end
end
