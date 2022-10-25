module SDC
  abstract class Shape < SDC::Drawable
    property origin : SDC::Coords = SDC.xy
    property color : SDC::Color = SDC::Color::BLACK

    @renderer : SDC::Renderer
  
    def initialize(@renderer : SDC::Renderer = SDC.current_window.not_nil!.renderer)
      super()
    end
  end

  @[Anyolite::DefaultOptionalArgsToKeywordArgs]
  class ShapePoint < Shape
    @[Anyolite::Specialize]
    def initialize(origin : SDC::Coords = SDC.xy, @renderer : SDC::Renderer = SDC.current_window.not_nil!.renderer)
      super(renderer)
      @origin = origin
    end

    def draw_directly
      LibSDL.set_render_draw_color(@renderer.data, @color.r, @color.g, @color.b, @color.a)
      LibSDL.render_draw_point_f(@renderer.data, @origin.x, @origin.y)
    end
  end

  @[Anyolite::DefaultOptionalArgsToKeywordArgs]
  class ShapeLine < Shape
    property direction : SDC::Coords

    @[Anyolite::Specialize]
    def initialize(direction : SDC::Coords, origin : SDC::Coords = SDC.xy, renderer : SDC::Renderer = SDC.current_window.not_nil!.renderer)
      super(renderer)
      @direction = direction
      @origin = origin
    end

    def draw_directly
      LibSDL.set_render_draw_color(@renderer.data, @color.r, @color.g, @color.b, @color.a)
      LibSDL.render_draw_line_f(@renderer.data, @origin.x, @origin.y, @origin.x + @direction.x, @origin.y + @direction.y)
    end
  end

  @[Anyolite::DefaultOptionalArgsToKeywordArgs]
  class ShapeBox < Shape
    property size : SDC::Coords
    property filled : Bool = false

    @[Anyolite::Specialize]
    def initialize(size : SDC::Coords, origin : SDC::Coords = SDC.xy, renderer : SDC::Renderer = SDC.current_window.not_nil!.renderer)
      super(renderer)
      @size = size
      @origin = origin
    end

    def draw_directly
      LibSDL.set_render_draw_color(@renderer.data, @color.r, @color.g, @color.b, @color.a)
      rect = LibSDL::FRect.new(x: @origin.x, y: @origin.y, w: @size.x, h: @size.y)
      # NOTE: A pointer is passed, but since its contents will be copied immediately, there should be no issues
      if @filled
        LibSDL.render_fill_rect_f(@renderer.data, pointerof(rect))
      else
        LibSDL.render_draw_rect_f(@renderer.data, pointerof(rect))
      end
    end
  end

  @[Anyolite::DefaultOptionalArgsToKeywordArgs]
  class ShapeCircle < Shape
    property radius : Float32

    @[Anyolite::Specialize]
    def initialize(radius : Float32, origin : SDC::Coords = SDC.xy, renderer : SDC::Renderer = SDC.current_window.not_nil!.renderer)
      super(renderer)
      @radius = radius
      @origin = origin
    end

    def draw_directly
      # TODO
    end
  end

  @[Anyolite::DefaultOptionalArgsToKeywordArgs]
  class ShapeTriangle < Shape
    property side_1 : SDC::Coords
    property side_2 : SDC::Coords

    def self.from_vertices(vertex_0 : SDC::Coords, vertex_1 : SDC::Coords, vertex_2 : SDC::Coords, renderer : SDC::Renderer = SDC.current_window.not_nil!.renderer)
      self.new(vertex_1 - vertex_0, vertex_2 - vertex_0, origin: vertex_0, renderer: renderer)
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

    def set_vertex(number : Int, value : SDC::Coords)
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

    def vertex_0=(value : SDC::Coords)
      @origin = value
    end

    def vertex_1=(value : SDC::Coords)
      @side_1 = value - @origin
    end

    def vertex_2=(value : SDC::Coords)
      @side_2 = value - @origin
    end

    @[Anyolite::Specialize]
    def initialize(side_1 : SDC::Coords, side_2 : SDC::Coords, origin : SDC::Coords = SDC.xy, renderer : SDC::Renderer = SDC.current_window.not_nil!.renderer)
      super(renderer)
      @side_1 = side_1
      @side_2 = side_2
      @origin = origin
    end

    def draw_directly
      # TODO
    end
  end

  @[Anyolite::DefaultOptionalArgsToKeywordArgs]
  class ShapeEllipse < Shape
    property semiaxes : SDC::Coords

    @[Anyolite::Specialize]
    def initialize(semiaxes : SDC::Coords, origin : SDC::Coords = SDC.xy, renderer : SDC::Renderer = SDC.current_window.not_nil!.renderer)
      super(renderer)
      @semiaxes = semiaxes
      @origin = origin
    end

    def draw_directly
      # TODO
    end
  end
end