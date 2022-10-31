puts "Dummy file"

class DummyEntity < SDC::Entity
  def initialize(param)
    super(param)
    @font = SDC::Font.load_from_file("demo_projects/Example_Test/assets/fonts/arial.ttf")
    @text = SDC::Text.new(param.as_string, @font)
    @text.position = SDC.xy(200, 300)
    @text.color = SDC::Color::RED
    @text_direction = 1
  end

  def custom_update
    if @text.position.x < 50
      @text_direction = 1
    elsif @text.position.x > 250
      @text_direction = -1
    end

    @text.position += SDC.xy(@text_direction, 0)
  end

  def custom_draw
    @text.draw
  end
end

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

    @box = SDC::ShapeBox.new(SDC.xy(200, 200), position: SDC.xy(150, 150))
    @box.color = SDC::Color::GREEN
    @box.filled = true
    @box.z = 10
    @box.pin
    
    @window2 = SDC::Window.new("Also Hi", 400, 400)

    @view = SDC::View.new(SDC::Rect.new(x: 100, y: 0, width: 400, height: 400))

    @texture2 = SDC::Texture.load_from_file("demo_projects/Example_Test/assets/graphics/test/Chishi.png")
    @texture2.pin

    @texture3 = SDC::Texture.load_from_file("demo_projects/Example_Test/assets/graphics/test/Chishi.png")
    @texture3.pin
    @texture3.z = 1

    @entity = DummyEntity.new(SDC::Param.new("Hello World!"))

    @music = SDC::Music.load_from_file("demo_projects/Example_Test/assets/music/ExampleLoop.ogg")
    @music.volume = 32

    @sound = SDC::Sound.load_from_file("demo_projects/Example_Test/assets/sounds/Yeow.ogg")
  end

  def update
    SDC.for_window(@window2) do
      @texture2.offset.y += 1 if SDC::Keyboard.key_down?(SDC::Keyboard::K_DOWN)
      @texture2.offset.y -= 1 if SDC::Keyboard.key_down?(SDC::Keyboard::K_UP)
      @texture2.offset.x += 1 if SDC::Keyboard.key_down?(SDC::Keyboard::K_RIGHT)
      @texture2.offset.x -= 1 if SDC::Keyboard.key_down?(SDC::Keyboard::K_LEFT)
    end

    SDC.for_window(@window) do
      @sprite.angle += 2.0
      @sprite.position = SDC::Mouse.position if SDC::Mouse.focused_window == @window
    end

    @entity.update

    SDC.next_scene = nil unless @window.open? || @window2.open?
  end

  def draw
    SDC.for_window(@window) do
      SDC.current_window.clear

      SDC.current_window.render_and_display
    end
  
    SDC.for_window(@window2) do
      SDC.current_window.clear

      SDC.with_view(@view) do
        @entity.draw
      end
      
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

      if event.as_key_event.key == SDC::Keyboard::K_M
        if @music.current_music?
          if @music.playing?
            @music.pause
          else
            @music.resume
          end
        else
          @music.play
        end
      end

      @music.volume += 10 if event.as_key_event.key == SDC::Keyboard::K_L

      @view.x += 1 if event.as_key_event.key == SDC::Keyboard::K_V

      if event.as_key_event.key == SDC::Keyboard::K_S
        @sound.volume = 64 + rand(64 + 1)
        @sound.pitch = 0.8 + 0.4 * rand
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
