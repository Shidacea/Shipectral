module SDC
  @[Anyolite::DefaultOptionalArgsToKeywordArgs]
  class Tileset
    property texture : SDC::Texture

    def initialize(texture : SDC::Texture)
      @texture = texture
    end

    def self.load_from_file(filename : String)
      Tileset.new(SDC::Texture.load_from_file(filename))
    end
  end
end