module SDC
  @[Anyolite::DefaultOptionalArgsToKeywordArgs]
  class Map < Drawable
    property width : UInt64
    property height : UInt64
    property view_width : UInt64
    property view_height : UInt64

    property tileset : Tileset

    def initialize
      @width = 4
      @height = 4
      @view_width = 4
      @view_height = 4
      @tileset = Tileset.load_from_file("demo_projects/Example_Test/assets/graphics/test/Chishi.png")
    end

    def draw_directly
      texture = @tileset.texture.data

      0.upto(@view_width - 1) do |x|
        0.upto(@view_height - 1) do |y|
          Rl.draw_texture_tiled(texture, Rl::Rectangle.new(50, 0, 50, 50), Rl::Rectangle.new(x * 50, y * 50, 50, 50), Rl::Vector2.new, 0.0, 1.0, SDC::Color.new(255, 255, 255, 64))
        end
      end
    end
  end
end