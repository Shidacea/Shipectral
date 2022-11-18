puts "Dummy file"

# NOTE: This will likely still be possible in the final release, but entity data will make it less relevant
class DummyEntity < SDC::Entity
  def initialize(data, param)
    super(data, param)
  end

  def custom_update
    # if @text.position.x < 50
    #   @text_direction = 1
    # elsif @text.position.x > 250
    #   @text_direction = -1
    # end

    # @text.color.g += 1
    # @text.update!

    # @text.position += SDC.xy(@text_direction, 0)
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
    @box.color = SDC::Color.green
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

    @dummy_entity_data = SDC::EntityData.new
    @dummy_entity_data.set_property("Test", SDC::Param.new(15))

    behavior_script = SDC::AI::RubyScriptTemplate.create do |entity|
      SDC::AI.wait(60)
      puts "Hello, I am still #{entity.state["test_value"]}."
    end
    @dummy_entity_data.add_hook("behavior", behavior_script)

    init_script = SDC::AI::RubyScriptTemplate.create do |entity|
      puts "Hello, my name is #{entity.magic_number}."
      entity.state["test_value"] = entity.magic_number

      font = SDC::Font.load_from_file("demo_projects/Example_Test/assets/fonts/arial.ttf")
      entity.state["font"] = font

      text = SDC::Text.new(entity.param[0].value, font)
      text.position = SDC.xy(100 + entity.param[1].value * 5, 100 + entity.param[1].as_int * 5)
      text.color = SDC::Color.red
      entity.state["text"] = text

      entity.state["text_direction"] = 1
    end 
    @dummy_entity_data.add_hook("spawn", init_script)

    update_script = SDC::AI::RubyScriptTemplate.create do |entity|
      text = entity.state["text"]

      SDC::AI.forever do
        text_direction = entity.state["text_direction"]

        if text.position.x < 50
          entity.state["text_direction"] = 1
        elsif text.position.x > 250
          entity.state["text_direction"] = -1
        end

        text.position += SDC.xy(text_direction, 0)
        
        text.color.g += 1
        text.update!
      end
    end
    @dummy_entity_data.add_hook("update", update_script)

    draw_script = SDC::AI::RubyScriptTemplate.create do |entity|
      text = entity.state["text"]
      
      SDC::AI.forever do
        text.draw
      end
    end
    @dummy_entity_data.add_hook("draw", draw_script)

    @entities = SDC::EntityGroup.new

    5.times do |i|
      new_entity = DummyEntity.new(@dummy_entity_data, SDC::Param.new([SDC::Param.new("Hello World"), SDC::Param.new(i)]))
      new_entity.init
      @entities.add(new_entity)
    end

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

      @entities.update
    end

    SDC.for_window(@window) do
      @sprite.angle += 2.0
      @sprite.position = SDC::Mouse.position if SDC::Mouse.focused_window == @window
    end

    SDC.next_scene = nil unless @window.open? || @window2.open?

    errors = SDC.check_for_internal_errors
    puts "SDL error: #{errors}" if errors
  end

  def draw
    SDC.for_window(@window) do
      SDC.current_window.clear

      SDC.current_window.render_and_display
    end
  
    SDC.for_window(@window2) do
      SDC.current_window.clear

      SDC.with_view(@view) do
        @entities.draw
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
