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

    def g=(value : Number)
      @data.g = value
    end
    
    def b=(value : Number)
      @data.b = value
    end

    def a=(value : Number)
      @data.a = value
    end

    def self.red
      SDC::Color.new(255, 0, 0)
    end

    def self.green
      SDC::Color.new(0, 255, 0)
    end

    def self.blue
      SDC::Color.new(0, 0, 255)
    end

    def self.black
      SDC::Color.new(0, 0, 0)
    end

    def self.white
      SDC::Color.new(255, 255, 255)
    end

    def self.gray
      SDC::Color.new(128, 128, 128)
    end

    def self.grey
      self.gray
    end

    def self.cyan
      SDC::Color.new(0, 255, 255)
    end

    def self.magenta
      SDC::Color.new(255, 0, 255)
    end

    def self.yellow
      SDC::Color.new(255, 255, 0)
    end

    def self.transparent
      SDC::Color.new(0, 0, 0, 0)
    end
  end
end