module SDC
  @[Anyolite::DefaultOptionalArgsToKeywordArgs]
  class Texture < SDC::Drawable
    @data : Rl::Texture?

    @[Anyolite::Specialize]
    def initialize
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

    def draw(at : SDC::Vector2 = Rl::Vector2.new, color : SDC::Color = SDC::Color::WHITE)
      Rl.draw_texture_v(data, at, color)
    end
  end
end
