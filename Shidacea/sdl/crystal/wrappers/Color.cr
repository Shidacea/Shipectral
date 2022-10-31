module SDC
  @[Anyolite::DefaultOptionalArgsToKeywordArgs]
  @[Anyolite::ExcludeInstanceMethod("data")]
  class Color
    getter data : LibSDL::Color

    BLACK = SDC::Color.new(0, 0, 0)
    WHITE = SDC::Color.new(255, 255, 255)

    RED = SDC::Color.new(255, 0, 0)
    GREEN = SDC::Color.new(0, 255, 0)
    BLUE = SDC::Color.new(0, 0, 255)

    YELLOW = SDC::Color.new(255, 255, 0)
    CYAN = SDC::Color.new(0, 255, 255)
    MAGENTA = SDC::Color.new(255, 0, 255)

    GRAY = SDC::Color.new(128, 128, 128)
    GREY = GRAY

    TRANSPARENT = SDC::Color.new(0, 0, 0, 0)

    def initialize(r : Number = 0, g : Number = 0, b : Number = 0, a : Number = 255)
      @data = LibSDL::Color.new(r: r, g: g, b: b, a: a)
    end

    def r
      @data.r
    end

    def g
      @data.g
    end
    
    def b
      @data.b
    end

    def a
      @data.a
    end

    def r=(value : Number)
      @data.r = value
    end

    def g=(value : Number)
      @data.g = value
    end
    
    def b=(value : Number)
      @data.b = value
    end

    def a=(value : Number)
      @data.a = value
    end
  end
end