module SDC
  abstract class Drawable
    def draw(z : Int = 0)
      SDC.current_window.draw(self, z)
    end

    abstract def draw_directly
  end
end