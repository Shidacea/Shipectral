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
end