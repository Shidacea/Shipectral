@[Anyolite::DefaultOptionalArgsToKeywordArgs]
@[Anyolite::SpecializeInstanceMethod("initialize", [x : Number, y : Number, width : Number, height : Number])]
@[Anyolite::SpecializeInstanceMethod("x=", [value], [value : Number])]
@[Anyolite::SpecializeInstanceMethod("y=", [value], [value : Number])]
@[Anyolite::SpecializeInstanceMethod("width=", [value], [value : Number])]
@[Anyolite::SpecializeInstanceMethod("height=", [value], [value : Number])]
struct Rl::Rectangle
  def initialize(x : Number, y : Number, width : Number, height : Number)
    self.x = x
    self.y = y
    self.width = width
    self.height = height
  end

  def draw(color : Rl::Color)
    Rl.draw_rectangle_rec(self, color)
  end
end
