module SDC
  abstract class Shape < SDC::Drawable
    property position : SDC::Coords = SDC.xy
    property color : SDC::Color = SDC::Color.black

    @renderer : SDC::Renderer
  
    def initialize(@renderer : SDC::Renderer = SDC.current_window.not_nil!.renderer)
      super()
    end
  end

  @[Anyolite::DefaultOptionalArgsToKeywordArgs]
  class ShapePoint < Shape
    @[Anyolite::Specialize]
    def initialize(position : SDC::Coords = SDC.xy, @renderer : SDC::Renderer = SDC.current_window.not_nil!.renderer)
      super(renderer)
      @position = position
    end

    def draw_directly
      LibSDL.set_render_draw_color(@renderer.data, @color.r, @color.g, @color.b, @color.a)
      LibSDL.render_draw_point_f(@renderer.data, @position.x, @position.y)
    end
  end

  @[Anyolite::DefaultOptionalArgsToKeywordArgs]
  class ShapeLine < Shape
    property direction : SDC::Coords

    @[Anyolite::Specialize]
    def initialize(direction : SDC::Coords, position : SDC::Coords = SDC.xy, renderer : SDC::Renderer = SDC.current_window.not_nil!.renderer)
      super(renderer)
      @direction = direction
      @position = position
    end

    def draw_directly
      LibSDL.set_render_draw_color(@renderer.data, @color.r, @color.g, @color.b, @color.a)
      LibSDL.render_draw_line_f(@renderer.data, @position.x, @position.y, @position.x + @direction.x, @position.y + @direction.y)
    end
  end

  @[Anyolite::DefaultOptionalArgsToKeywordArgs]
  class ShapeBox < Shape
    property size : SDC::Coords
    property filled : Bool = false

    @[Anyolite::Specialize]
    def initialize(size : SDC::Coords, position : SDC::Coords = SDC.xy, renderer : SDC::Renderer = SDC.current_window.not_nil!.renderer)
      super(renderer)
      @size = size
      @position = position
    end

    def draw_directly
      LibSDL.set_render_draw_color(@renderer.data, @color.r, @color.g, @color.b, @color.a)
      rect = LibSDL::FRect.new(x: @position.x, y: @position.y, w: @size.x, h: @size.y)
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
    def initialize(radius : Float32, position : SDC::Coords = SDC.xy, renderer : SDC::Renderer = SDC.current_window.not_nil!.renderer)
      super(renderer)
      @radius = radius
      @position = position
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
      self.new(vertex_1 - vertex_0, vertex_2 - vertex_0, position: vertex_0, renderer: renderer)
    end

    def get_vertex(number : Int)
      case number
      when 0
        @position
      when 1
        @position + @side_1
      when 2
        @position + @side_2
      else
        SDC.error "Invalid index for triangle vertices: #{number}"
      end
    end

    def set_vertex(number : Int, value : SDC::Coords)
      case number
      when 0
        @position = value
      when 1
        @side_1 = value - @position
      when 2
        @side_2 = value - @position
      else
        SDC.error "Invalid index for triangle vertices: #{number}"
      end
    end

    def vertex_0
      @position
    end

    def vertex_1
      @position + @side_1
    end

    def vertex_2
      @position + @side_2
    end

    def vertex_0=(value : SDC::Coords)
      @position = value
    end

    def vertex_1=(value : SDC::Coords)
      @side_1 = value - @position
    end

    def vertex_2=(value : SDC::Coords)
      @side_2 = value - @position
    end

    @[Anyolite::Specialize]
    def initialize(side_1 : SDC::Coords, side_2 : SDC::Coords, position : SDC::Coords = SDC.xy, renderer : SDC::Renderer = SDC.current_window.not_nil!.renderer)
      super(renderer)
      @side_1 = side_1
      @side_2 = side_2
      @position = position
    end

    def draw_directly
      # TODO
    end
  end

  @[Anyolite::DefaultOptionalArgsToKeywordArgs]
  class ShapeEllipse < Shape
    property semiaxes : SDC::Coords

    @[Anyolite::Specialize]
    def initialize(semiaxes : SDC::Coords, position : SDC::Coords = SDC.xy, renderer : SDC::Renderer = SDC.current_window.not_nil!.renderer)
      super(renderer)
      @semiaxes = semiaxes
      @position = position
    end

    def draw_directly
      # TODO
    end
  end
end