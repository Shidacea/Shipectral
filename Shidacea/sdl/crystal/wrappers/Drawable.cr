module SDC
  abstract class Drawable
    def draw
      SDC.current_window.draw_obj(self)
    end
  end
end