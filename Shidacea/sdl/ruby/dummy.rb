puts "Dummy file"

class SceneTest < SDC::Scene
  def at_init
    self.use_own_draw_implementation = true

    @window = SDC::Window.new("Hello World", 800, 600)
    @texture = SDC::Texture.load_from_file("demo_projects/Example_Test/assets/graphics/test/Chishi.png")
    
    @window2 = SDC::Window.new("Also Hi", 400, 400)
    @texture2 = SDC::Texture.load_from_file("demo_projects/Example_Test/assets/graphics/test/Chishi.png")

    music = SDC::Music.load_from_file("demo_projects/Example_Test/assets/music/ExampleLoop.ogg")
    #music.play
  end

  def update
    SDC.next_scene = nil unless @window.open? || @window2.open?
  end

  def draw
    if @window.open?
      SDC.current_window = @window
      SDC.current_window.clear

      @texture.draw

      SDC.current_window.render_and_display
    end
  
    if @window2.open?
      SDC.current_window = @window2
      SDC.current_window.clear

      @texture2.draw
      
      SDC.current_window.render_and_display
    end
  end

  def handle_event(event)
    if event.type == SDC::Event::WINDOW
      win_id = event.as_window_event.window_id
      if event.as_window_event.event == SDC::WindowEvent::CLOSE
        close_window = true if win_id == 1
        close_window_2 = true if win_id == 2
      end
    elsif event.type == SDC::Event::KEYDOWN
      puts event.as_key_event.key_name
      puts "Up!" if event.as_key_event.key == SDC::KeyboardEvent::K_UP
    end

    @window.close if close_window
    @window2.close if close_window_2
  end
end

SDC.main_routine(SceneTest.new)
