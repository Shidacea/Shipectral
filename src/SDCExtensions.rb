# NOTE: This will be dropped in future versions of Shidacea

module SDC
  class Coordinates < SDC::Vector2f
    def initialize(x = 0.0, y = 0.0)
      super(x, y)
    end
  end
end