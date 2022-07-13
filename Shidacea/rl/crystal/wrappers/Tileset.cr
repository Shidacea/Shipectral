module SDC
  @[Anyolite::DefaultOptionalArgsToKeywordArgs]
  class Tileset
    property texture : SDC::Texture

    property tile_width : UInt64
    property tile_height : UInt64

    def initialize(texture : SDC::Texture)
      @texture = texture
      @tile_width = 50
      @tile_height = 50
    end

    def self.load_from_file(filename : String)
      Tileset.new(SDC::Texture.load_from_file(filename))
    end
  end
end