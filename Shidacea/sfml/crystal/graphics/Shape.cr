module SF
  class PointShape
    def get_from(shape : SDC::CollisionShapePoint)
      @point = SF::Vector2f.new
      self.position = shape.position
      self.scale = shape.scale
      self.origin = shape.origin
      self.rotation = shape.rotation
      update
    end
  end

  class LineShape
    def get_from(shape : SDC::CollisionShapeLine)
      @points = [SF::Vector2f.new, shape.line]
      self.position = shape.position
      self.scale = shape.scale
      self.origin = shape.origin
      self.rotation = shape.rotation
      update
    end
  end

  class RectangleShape
    def get_from(shape : SDC::CollisionShapeBox)
      self.size = shape.size
      self.position = shape.position
      self.scale = shape.scale
      self.origin = shape.origin
      update
    end
  end

  class CircleShape
    def get_from(shape : SDC::CollisionShapeCircle)
      self.radius = shape.radius
      self.position = shape.position - shape.scale * shape.radius
      self.scale = shape.scale
      self.origin = shape.origin
      update
    end
  end

  class TriangleShape
    def get_from(shape : SDC::CollisionShapeTriangle)
      @points = [SF::Vector2f.new, shape.side_1, shape.side_2]
      self.position = shape.position
      self.scale = shape.scale
      self.origin = shape.origin
      self.rotation = shape.rotation
      update
    end
  end

  class EllipseShape
    def get_from(shape : SDC::CollisionShapeEllipse)
      @semiaxes = shape.semiaxes
      self.position = shape.position
      self.scale = shape.scale
      self.origin = shape.origin
      self.rotation = shape.rotation
      update
    end
  end
end
  