module SDC
  @[Anyolite::DefaultOptionalArgsToKeywordArgs]
  class Window
    getter render_queue : SDC::RenderQueue = SDC::RenderQueue.new

    def initialize(@title : String, @width : Int32, @height : Int32)
      Rl.init_window(width, height, title)
    end

    @[Anyolite::ReturnNil]
    def draw(obj : SDC::Drawable, z : Int = 0)
      @render_queue.add(obj, z.to_u8)
    end

    @[Anyolite::ReturnNil]
    def add_static(obj : SDC::Drawable, z : Int = 0)
      @render_queue.add_static(obj, z.to_u8)
    end

    def delete_static(obj : SDC::Drawable, z : Int = 0, all_duplicates : Bool = false)
      @render_queue.delete_static(obj, z.to_u8, all_duplicates)
    end

    def delete_static_content
      @render_queue.delete_static_content
    end

    def close
      Rl.close_window
    end

    def finalize
      close
    end

    def target_fps=(fps : Int)
      Rl.set_target_fps(fps.to_i32)
    end

    def width
      @width
    end

    def height
      @height
    end

    def close?
      Rl.close_window?
    end

    def clear(color : Rl::Color = Rl::Color::BLACK)
      Rl.clear_background(color)
    end

    def frame_time
      Rl.get_frame_time
    end

    def fps
      Rl.get_fps
    end

    @[Anyolite::AddBlockArg(1, Nil)]
    def draw_routine
      Rl.begin_drawing
      yield nil
      @render_queue.draw
      Rl.end_drawing
    end

    def resize(new_width : Int, new_height : Int)
      @width = new_width.to_i32
      @height = new_height.to_i32

      Rl.set_window_size(@width, @height)
    end

    def cursor_on_screen?
      Rl.cursor_on_screen?
    end

    def ready?
      Rl.window_ready?
    end

    def fullscreen?
      Rl.window_fullscreen?
    end

    def hidden?
      Rl.window_hidden?
    end

    def minimized?
      Rl.window_minimized?
    end

    def maximized?
      Rl.window_maximized?
    end

    def focused?
      Rl.window_focused?
    end

    def resized?
      Rl.window_resized?
    end

    def state?(flag : Int)
      Rl.window_state?(flag)
    end

    def state=(flag : Int)
      Rl.set_window_state(flag)
    end

    def clear_state(flag : Int)
      Rl.clear_window_state(flag)
    end

    def fullscreen=(value : Bool)
      if value != fullscreen?
        toggle_fullscreen
      end
    end

    def toggle_fullscreen
      Rl.toggle_fullscreen
    end

    def maximize
      Rl.maximize_window
    end

    def minimize
      Rl.minimize_window
    end

    def restore
      Rl.restore_window
    end

    def icon=(image : SDC::Image)
      Rl.set_window_icon(image.data)
    end

    def title
      @title
    end

    def title=(value : String)
      @title = value
      Rl.set_window_title(value)
    end

    def width=(value : Int)
      @width = value.to_i32
      Rl.set_window_size(value, @height)
    end

    def height=(value : Int)
      @height = value.to_i32
      Rl.set_window_size(@width, value)
    end

    def monitor=(value : Int)
      Rl.set_window_monitor(value)
    end
  end
end
