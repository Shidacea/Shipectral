puts "Dummy file"

class SceneTest < SDC::Scene
  def at_init
    self.use_own_draw_implementation = true

    @window = SDC::Window.new("Hello World", 800, 600)

    @texture = SDC::Texture.load_from_file("demo_projects/Example_Test/assets/graphics/test/Chishi.png")
    @sprite = SDC::Sprite.new(from_texture: @texture, source_rect: SDC::Rect.new(width: 50, height: 50))
    @sprite.render_rect = SDC::Rect.new(width: 50, height: 50)
    @sprite.position += SDC.xy(100.0, 50.0)
    @sprite.center = SDC.xy(0.0, 0.0)
    @sprite.angle = 45.0
    
    @window2 = SDC::Window.new("Also Hi", 400, 400)

    @texture2 = SDC::Texture.load_from_file("demo_projects/Example_Test/assets/graphics/test/Chishi.png")
    @texture2.pin

    @texture3 = SDC::Texture.load_from_file("demo_projects/Example_Test/assets/graphics/test/Chishi.png")
    @texture3.pin
    @texture3.z = 1

    SDC::Music.volume = 32
    @music = SDC::Music.load_from_file("demo_projects/Example_Test/assets/music/ExampleLoop.ogg")
    @sound = SDC::Sound.load_from_file("demo_projects/Example_Test/assets/sounds/Yeow.ogg")
  end

  def update
    @texture2.offset.y += 1 if SDC::Keyboard.key_down?(SDC::Keyboard::K_DOWN)
    @texture2.offset.y -= 1 if SDC::Keyboard.key_down?(SDC::Keyboard::K_UP)
    @texture2.offset.x += 1 if SDC::Keyboard.key_down?(SDC::Keyboard::K_RIGHT)
    @texture2.offset.x -= 1 if SDC::Keyboard.key_down?(SDC::Keyboard::K_LEFT)

    @sprite.angle += 2.0
    @sprite.position = (@window2.open? && @window.open?) ? (@window2.position - @window.position) : SDC.xy(100.0, 50.0)

    SDC.next_scene = nil unless @window.open? || @window2.open?
  end

  def draw
    if @window.open?
      SDC.current_window = @window
      SDC.current_window.clear

      @sprite.draw

      SDC.current_window.render_and_display
    end
  
    if @window2.open?
      SDC.current_window = @window2
      SDC.current_window.clear
      
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
      puts "Key pressed: #{event.as_key_event.key_name}"

      @music.play if event.as_key_event.key == SDC::Keyboard::K_M

      if event.as_key_event.key == SDC::Keyboard::K_S
        @sound.volume = rand(128 + 1)
        @sound.play
      end
    end

    @window.close if close_window
    @window2.close if close_window_2
  end

  def at_exit
    @window2.unpin_all
  end
end

SDC.main_routine(SceneTest.new)
