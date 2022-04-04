module SDC
  @[Anyolite::DefaultOptionalArgsToKeywordArgs]
  class Tileset
    @texture : SF::Texture?
    @tiles : Array(Tile) = Array(Tile).new(initial_capacity: 1000)

    def initialize
    end

    def link_texture(texture : SF::Texture)
      @texture = texture
    end

    def texture : SF::Texture
      if texture = @texture
        texture
      else
        raise("No texture") # TODO: Raise an mruby error instead?
      end
    end

    def get_tile(identification : UInt64)
      @tiles[identification]? ? @tiles[identification] : raise "Invalid Tile"
    end

    def size
      @tiles.size
    end

    def add_tile(tile : Tile)
      @tiles.push(tile)
    end

    def tiles
      @tiles
    end
  end
end

def setup_ruby_tileset_class(rb)
  Anyolite.wrap(rb, SDC::Tileset, under: SDC, verbose: true, connect_to_superclass: false)
end
