module SDC
  @[Anyolite::DefaultOptionalArgsToKeywordArgs]
  @[Anyolite::ExcludeInstanceMethod("data")]
  class Color
    getter data : LibSDL::Color

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

    def g(value : Number)
      @data.g = value
    end
    
    def b(value : Number)
      @data.b = value
    end

    def a(value : Number)
      @data.a = value
    end
  end
end