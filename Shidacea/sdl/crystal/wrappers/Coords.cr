module SDC
  @[Anyolite::DefaultOptionalArgsToKeywordArgs]
  class Coords
    property x : Float32 = 0.0
    property y : Float32 = 0.0
    
    def initialize(x : Number = 0.0, y : Number = 0.0)
      @x = x.to_f32
      @y = y.to_f32
    end

    def +(other : SDC::Coords)
      SDC::Coords.new(@x + other.x, @y + other.y)
    end

    def -(other : SDC::Coords)
      SDC::Coords.new(@x - other.x, @y - other.y)
    end

    def *(scalar : Number)
      SDC::Coords.new(@x * scalar, @y * scalar)
    end

    def /(scalar : Number)
      SDC::Coords.new(@x / scalar, @y / scalar)
    end

    def dot(other : SDC::Coords)
      @x * other.x + @y * other.y
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
      Math.atan2(@y, @x)
    end

    def to_s
      "(#{@x} | #{@y})"
    end
  end

  @[Anyolite::WrapWithoutKeywords]
  def self.xy(x : Number = 0.0, y : Number = 0.0)
    SDC::Coords.new(x, y)
  end
end