module SDC
  @[Anyolite::DefaultOptionalArgsToKeywordArgs]
  class Rect
    getter data : LibSDL::Rect

    def initialize(x : Number = 0.0, y : Number = 0.0, width : Number = 0.0, height : Number = 0.0)
      @data = LibSDL::Rect.new(x: x, y: y, w: width, h: height)
    end

    def +(vector : SDC::Coords)
      SDC::Rect.new(x: self.x + vector.x, y: self.y + vector.y, width: self.width, height: self.height)
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

    def width
      @data.w
    end

    def width=(value : Number)
      @data.w = value
    end

    def height
      @data.h
    end

    def height=(value : Number)
      @data.h = value
    end
  end
end