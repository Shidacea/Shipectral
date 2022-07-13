module SDC
  @[Anyolite::DefaultOptionalArgsToKeywordArgs]
  class Texture < SDC::Drawable
    @data : Rl::Texture?
    property origin : Rl::Vector2 = Rl::Vector2.new

    # TODO: Maybe add a sprite class?

    @[Anyolite::Specialize]
    def initialize(origin : Rl::Vector2 = Rl::Vector2.new)
      @origin = origin
    end

    def initialize(rl_texture : Rl::Texture)
      @data = rl_texture
    end

    @[Anyolite::Exclude]
    def data
      @data.not_nil!
    end

    def finalize
      Rl.unload_texture(data)
    end

    def self.load_from_file(filename : String)
      Texture.new(Rl.load_texture(filename))
    end

    def draw_directly
      Rl.draw_texture_v(data, @origin, SDC::Color::WHITE)
    end
  end
end
