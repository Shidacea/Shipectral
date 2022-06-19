module SDC
  class Text
    property content : String
    property font_size : Int32
    property font : SDC::Font
    property position : Rl::Vector2
    property color : Rl::Color

    def initialize(@content : String = "", @font_size : Int32 = 20, @font : SDC::Font = SDC::Font.default, @position : SDC::Vector2 = SDC::Vector2.new, @color : SDC::Color = SDC::Color::BLACK)
    end

    def draw
      Rl.draw_text_ex(@font.data, @content, @position, @font_size, 1.0, @color)
    end
  end
end