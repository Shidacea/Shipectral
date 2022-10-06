module SDC
  @[Anyolite::DefaultOptionalArgsToKeywordArgs]
  class Coords
    property x : Float32 = 0.0
    property y : Float32 = 0.0
    
    def initialize(x : Number = 0.0, y : Number = 0.0)
      @x = x.to_f32
      @y = y.to_f32
    end
  end

  def self.xy(x : Number = 0.0, y : Number = 0.0)
    SDC::Coords.new(x, y)
  end
end