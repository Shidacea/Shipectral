module SDC
  @[Anyolite::DefaultOptionalArgsToKeywordArgs]
  class Map < Drawable
    property width : UInt64
    property height : UInt64

    # The range of tiles which should be drawn
    property range : Rl::Rectangle = Rl::Rectangle.new(0, 0, 50, 50)

    property tileset : Tileset

    def initialize
      @width = 4
      @height = 4
      @tileset = Tileset.load_from_file("demo_projects/Example_Test/assets/graphics/test/Chishi.png")
    end

    # TODO: Add functions for adjusting the draw range (e.g. to view and window)

    def draw_directly
      texture = @tileset.texture.data

      tile_width = @tileset.tile_width
      tile_height = @tileset.tile_height

      origin = Rl::Vector2.new
      rotation = 0.0
      scale = 1.0
      tint = SDC::Color.new(255, 255, 255, 64)

      # TODO: Adjust this to the drawing range

      0.upto(@range.width.to_i - 1) do |x|
        0.upto(@range.height.to_i - 1) do |y|
          source = Rl::Rectangle.new(1 * tile_width, 0, tile_width, tile_height)
          dest = Rl::Rectangle.new(x * tile_width, y * tile_height, tile_width, tile_height)

          Rl.draw_texture_tiled(texture, source, dest, origin, rotation, scale, tint)
        end
      end
    end
  end
end