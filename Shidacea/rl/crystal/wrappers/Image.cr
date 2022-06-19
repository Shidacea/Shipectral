module SDC
  @[Anyolite::DefaultOptionalArgsToKeywordArgs]
  class Image
    @data : Rl::Image?

    @[Anyolite::Specialize]
    def initialize
    end

    def initialize(rl_image : Rl::Image)
      @data = rl_image
    end

    @[Anyolite::Exclude]
    def data
      @data.not_nil!
    end

    def finalize
      Rl.unload_image(data)
    end

    def self.load_from_file(filename : String)
      Image.new(Rl.load_image(filename))
    end
  end
end
