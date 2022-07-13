module SDC
  @[Anyolite::DefaultOptionalArgsToKeywordArgs]
  class View < Drawable
    @camera : Rl::Camera2D = Rl::Camera2D.new

    def initialize
      @camera.zoom = 1.0
    end

    def offset
      @camera.offset
    end

    def offset=(value : Rl::Vector2)
      @camera.offset = value
    end

    def target
      @camera.target
    end

    def target=(value : Rl::Vector2)
      @camera.target = value
    end

    def rotation
      @camera.rotation
    end

    def rotation=(value : Number)
      @camera.rotation = value
    end

    def zoom
      @camera.zoom
    end

    def zoom=(value : Number)
      @camera.zoom = value
    end
    
    def draw_directly
      # This is a bit hacky, but it does the job
      # Essentially, a SDC::View draw call will simply set the camera state
      Rl.begin_mode_2d(@camera)
    end
  end
end