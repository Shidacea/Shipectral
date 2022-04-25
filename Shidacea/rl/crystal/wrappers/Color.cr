@[Anyolite::DefaultOptionalArgsToKeywordArgs]
@[Anyolite::SpecializeInstanceMethod("initialize", [r : UInt8 = 0, g : UInt8 = 0, b : UInt8 = 0, a : UInt8 = 255])]
@[Anyolite::WrapWithoutKeywordsInstanceMethod("initialize")]
@[Anyolite::SpecializeInstanceMethod("r=", [value], [value : UInt8])]
@[Anyolite::SpecializeInstanceMethod("g=", [value], [value : UInt8])]
@[Anyolite::SpecializeInstanceMethod("b=", [value], [value : UInt8])]
@[Anyolite::SpecializeInstanceMethod("a=", [value], [value : UInt8])]
struct Rl::Color
  def initialize(r : UInt8 = 0, g : UInt8 = 0, b : UInt8 = 0, a : UInt8 = 255)
    self.r = r
    self.g = g
    self.b = b
    self.a = a
  end

  {% for color_name in ["LIGHTGRAY", "GRAY", "DARKGRAY", "YELLOW", 
                        "GOLD", "ORANGE", "PINK", "RED", "MAROON", 
                        "GREEN", "LIME", "DARKGREEN", "SKYBLUE",
                        "BLUE", "DARKBLUE", "PURPLE", "VIOLET",
                        "DARKPURPLE", "BEIGE", "BROWN", "DARKBROWN",
                        "WHITE", "BLACK", "BLANK", "MAGENTA",
                        "RAYWHITE"] %}
    {{color_name.id}} = Rl::{{color_name.id}}
  {% end %}

end
