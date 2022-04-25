module SDC
  class Text
    property content : String
    property font_size : Int32
    property font : Rl::Font
    property position : Rl::Vector2
    property color : Rl::Color

    def initialize(@content : String = "", @font_size : Int32 = 20, @font : Rl::Font = Rl.get_font_default, @position : Rl::Vector2 = Rl::Vector2.new, @color : Rl::Color = Rl::BLACK)
    end

    def draw
      Rl.draw_text_ex(@font, @content, @position, @font_size, 1.0, @color)
    end
  end
end