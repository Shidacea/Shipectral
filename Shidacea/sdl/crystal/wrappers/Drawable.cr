module SDC
  abstract class Drawable
    getter z : UInt8 = 0
    getter static : Bool = false

    def draw
      SDC.current_window.draw(self)
    end

    # TODO: Find solution for multiple static copies

    def z=(value : Int)
      if value != @z
        self.static = false
        @z = value.to_u8
        self.static = true
      end
    end

    def static=(value : Bool)
      if value
        @static = true
        SDC.current_window.add_static(self)
      else
        @static = false 
        SDC.current_window.delete_static(self)
      end
    end

    abstract def draw_directly
  end
end