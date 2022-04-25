@[Anyolite::DefaultOptionalArgsToKeywordArgs]
@[Anyolite::SpecializeInstanceMethod("initialize", [width : Number, height : Number, origin : Rl::Vector2 = Rl::Vector2.new])]
@[Anyolite::SpecializeInstanceMethod("x=", [value], [value : Number])]
@[Anyolite::SpecializeInstanceMethod("y=", [value], [value : Number])]
@[Anyolite::SpecializeInstanceMethod("width=", [value], [value : Number])]
@[Anyolite::SpecializeInstanceMethod("height=", [value], [value : Number])]
struct Rl::Rectangle
  def initialize 
  end

  def initialize(width : Number, height : Number, origin : Rl::Vector2 = Rl::Vector2.new)
    self.width = width
    self.height = height
    self.x = origin.x
    self.y = origin.y
  end

  def origin=(value : Rl::Vector2)
    self.x = value.x
    self.y = value.y
  end

  def draw(color : Rl::Color)
    Rl.draw_rectangle_rec(self, color)
  end
end