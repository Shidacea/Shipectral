module SDC
  @[Anyolite::DefaultOptionalArgsToKeywordArgs]
  class Font
    @data : Rl::Font?

    @[Anyolite::Specialize]
    def initialize
    end

    def initialize(rl_font : Rl::Font)
      @data = rl_font
    end

    @[Anyolite::Exclude]
    def data
      @data.not_nil!
    end

    def finalize
      Rl.unload_font(data)
    end

    def self.load_from_file(filename : String)
      Font.new(Rl.load_font(filename))
    end

    def self.default
      Font.new(Rl.get_font_default)
    end
  end
end
