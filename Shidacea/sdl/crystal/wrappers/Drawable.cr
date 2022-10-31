module SDC
  abstract class Drawable
    getter z : UInt8 = 0
    getter pinned : Bool = false

    def draw
      if window = SDC.current_window
        window.draw(self)
      else
        SDC.error "Could not draw to closed or invalid window"
      end
    end

    def finalize
      unpin if @pinned
    end

    def z=(value : Int)
      if value != @z
        if @pinned
          unpin
          @z = value.to_u8
          pin
        end
      end
    end

    def pin
      @pinned = true
      if window = SDC.current_window
        window.pin(self)
      else
        SDC.error "Could not pin to closed or invalid window"
      end
    end

    def unpin
      @pinned = false
      if window = SDC.current_window
        window.unpin(self)
      else
        SDC.error "Could not unpin from closed or invalid window"
      end
    end

    abstract def draw_directly
  end
end