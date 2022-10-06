module SDC
  abstract class Drawable
    getter z : UInt8 = 0
    getter pinned : Bool = false

    def draw
      SDC.current_window.draw(self)
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
      SDC.current_window.pin(self)
    end

    def unpin
      @pinned = false
      SDC.current_window.unpin(self)
    end

    abstract def draw_directly
  end
end