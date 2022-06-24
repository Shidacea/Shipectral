module SDC
  abstract class Shape < Drawable
    property origin : Rl::Vector2 = Rl::Vector2.new
    property color : Rl::Color = Rl::Color::BLACK
  end

  @[Anyolite::DefaultOptionalArgsToKeywordArgs]
  class ShapePoint < Shape
    @[Anyolite::Specialize]
    def initialize(origin : Rl::Vector2 = Rl::Vector2.new)
      @origin = origin
    end

    def draw
      Rl.draw_pixel(@origin.x, @origin.y, @color)
    end
  end

  @[Anyolite::DefaultOptionalArgsToKeywordArgs]
  class ShapeLine < Shape
    property direction : Rl::Vector2

    @[Anyolite::Specialize]
    def initialize(direction : Rl::Vector2, origin : Rl::Vector2 = Rl::Vector2.new)
      @direction = direction
      @origin = origin
    end

    def draw
      Rl.draw_line(@origin.x, @origin.y, @direction.x, @direction.y, @color)
    end
  end

  @[Anyolite::DefaultOptionalArgsToKeywordArgs]
  class ShapeBox < Shape
    property size : Rl::Vector2

    @[Anyolite::Specialize]
    def initialize(size : Rl::Vector2, origin : Rl::Vector2 = Rl::Vector2.new)
      @size = size
      @origin = origin
    end

    def draw
      Rl.draw_rectangle(@origin.x, @origin.y, @size.x, @size.y, @color)
    end
  end

  @[Anyolite::DefaultOptionalArgsToKeywordArgs]
  class ShapeCircle < Shape
    property radius : Float32

    @[Anyolite::Specialize]
    def initialize(radius : Float32, origin : Rl::Vector2 = Rl::Vector2.new)
      @radius = radius
      @origin = origin
    end

    def draw
      Rl.draw_circle(@origin.x, @origin.y, @radius, @color)
    end
  end

  @[Anyolite::DefaultOptionalArgsToKeywordArgs]
  class ShapeTriangle < Shape
    property side_1 : Rl::Vector2
    property side_2 : Rl::Vector2

    def self.from_vertices(vertex_0 : Rl::Vector2, vertex_1 : Rl::Vector2, vertex_2 : Rl::Vector2)
      self.new(vertex_1 - vertex_0, vertex_2 - vertex_0, origin: vertex_0)
    end

    def get_vertex(number : Int)
      case number
      when 0
        @origin
      when 1
        @origin + @side_1
      when 2
        @origin + @side_2
      else
        raise("Invalid index for vertices: #{number}")
      end
    end

    def set_vertex(number : Int, value : Rl::Vector2)
      case number
      when 0
        @origin = value
      when 1
        @side_1 = value - @origin
      when 2
        @side_2 = value - @origin
      else
        raise("Invalid index for vertices: #{number}")
      end
    end

    def vertex_0
      @origin
    end

    def vertex_1
      @origin + @side_1
    end

    def vertex_2
      @origin + @side_2
    end

    def vertex_0=(value : Rl::Vector2)
      @origin = value
    end

    def vertex_1=(value : Rl::Vector2)
      @side_1 = value - @origin
    end

    def vertex_2=(value : Rl::Vector2)
      @side_2 = value - @origin
    end

    @[Anyolite::Specialize]
    def initialize(side_1 : Rl::Vector2, side_2 : Rl::Vector2, origin : Rl::Vector2 = Rl::Vector2.new)
      @side_1 = side_1
      @side_2 = side_2
      @origin = origin
    end

    def draw
      Rl.draw_triangle(@origin, @origin + @side_1, @origin + @side_2, @color)
    end
  end

  @[Anyolite::DefaultOptionalArgsToKeywordArgs]
  class ShapeEllipse < Shape
    property semiaxes : Rl::Vector2

    @[Anyolite::Specialize]
    def initialize(semiaxes : Rl::Vector2, origin : Rl::Vector2 = Rl::Vector2.new)
      @semiaxes = semiaxes
      @origin = origin
    end

    def draw
      Rl.draw_ellipse(@origin.x, @origin.y, @semiaxes.x, @semiaxes.y, @color)
    end
  end
end