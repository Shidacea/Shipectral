module SDC
  @[Anyolite::DefaultOptionalArgsToKeywordArgs]
  @[Anyolite::ExcludeInstanceMethod("data")]
  class Coords
    getter data : LibSDL::FPoint
    
    def initialize(x : Number = 0.0, y : Number = 0.0)
      @data = LibSDL::FPoint.new(x: x, y: y)
    end

    def x
      @data.x
    end

    def x=(value : Number)
      @data.x = value
    end

    def y
      @data.y
    end

    def y=(value : Number)
      @data.y = value
    end

    def +(other : SDC::Coords)
      SDC::Coords.new(self.x + other.x, self.y + other.y)
    end

    def -(other : SDC::Coords)
      SDC::Coords.new(self.x - other.x, self.y - other.y)
    end

    def *(scalar : Number)
      SDC::Coords.new(self.x * scalar, self.y * scalar)
    end

    def /(scalar : Number)
      SDC::Coords.new(self.x / scalar, self.y / scalar)
    end

    def dot(other : SDC::Coords)
      self.x * other.x + self.y * other.y
    end

    def squared_norm
      self.dot(self)
    end

    # Some synonyms

    def norm
      Math.sqrt(squared_norm)
    end

    def abs
      norm
    end

    def magnitude
      norm
    end

    def angle_to(other : SDC::Coords)
      Math.acos(self.dot(other) / (self.norm * other.norm))
    end

    def angle
      Math.atan2(self.y, self.x)
    end

    def to_s
      "(#{self.x} | #{self.y})"
    end

    @[Anyolite::Exclude]
    def int_data
      LibSDL::Point.new(x: self.x, y: self.y)
    end
  end

  @[Anyolite::WrapWithoutKeywords]
  def self.xy(x : Number = 0.0, y : Number = 0.0)
    SDC::Coords.new(x, y)
  end
end