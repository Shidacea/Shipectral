module SDC
  abstract struct Shape
    property origin : Rl::Vector2 = Rl::Vector2.new
    property color : Rl::Color = Rl::Color::BLACK
  end

  @[Anyolite::DefaultOptionalArgsToKeywordArgs]
  struct ShapeBox < Shape
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
  struct ShapeCircle < Shape
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
  struct ShapeTriangle < Shape
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
  struct ShapeEllipse < Shape
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