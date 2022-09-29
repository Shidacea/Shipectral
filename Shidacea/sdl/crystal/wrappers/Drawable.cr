module SDC
  abstract class Drawable
    def draw
      SDC.current_window.draw_obj(self)
    end

    abstract def draw_directly
  end
end