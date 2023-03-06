puts "Dummy file"

init_procedure = SDC::AI::RubyScriptTemplatePage.create do |scene|
  scene.use_own_draw_implementation = true
  
  scene.state["window"] = SDC::Window.new("Hello World", 800, 600)

  scene.state["texture"] = SDC::Texture.load_from_file("demo_projects/Example_Test/assets/graphics/test/Chishi.png")

  scene.state["sprite"] = SDC::Sprite.new(from_texture: scene.state["texture"], source_rect: SDC::Rect.new(width: 50, height: 50))
  sprite = scene.state["sprite"]
  sprite.render_rect = SDC::Rect.new(width: 50, height: 50)
  sprite.position += SDC.xy(100.0, 50.0)
  sprite.center = SDC.xy(0.0, 0.0)
  sprite.angle = 45.0

  scene.state["box"] = SDC::ShapeBox.new(SDC.xy(200, 200), position: SDC.xy(150, 150))
  box = scene.state["box"]  
  box.color = SDC::Color.green
  box.filled = true
  box.z = 10
  box.pin

  scene.state["window2"] = SDC::Window.new("Also Hi", 400, 400)

  scene.state["view"] = SDC::View.new(SDC::Rect.new(x: 100, y: 0, width: 400, height: 400))

  scene.state["texture2"] = SDC::Texture.load_from_file("demo_projects/Example_Test/assets/graphics/test/Chishi.png")
  texture2 = scene.state["texture2"]
  texture2.pin

  scene.state["texture3"] = SDC::Texture.load_from_file("demo_projects/Example_Test/assets/graphics/test/Chishi.png")
  texture3 = scene.state["texture3"]
  texture3.pin
  texture3.z = 1

  scene.state["music"] = SDC::Music.load_from_file("demo_projects/Example_Test/assets/music/ExampleLoop.ogg")
  scene.state["music"].volume = 32

  scene.state["sound"] = SDC::Sound.load_from_file("demo_projects/Example_Test/assets/sounds/Yeow.ogg")

  dummy_entity_data = SDC::ObjectDataEntity.new
  dummy_entity_data.set_property("Test", SDC::Param.new(15))

  behavior_script = SDC::AI::RubyScriptTemplatePage.create do |entity|
    puts "Behavior called"
    SDC::AI.wait(60)
    puts "Hello, I am still #{entity.state["test_value"]}."
  end
  dummy_entity_data.add_hook("behavior", behavior_script)

  update_script = SDC::AI::RubyScriptTemplatePage.create do |entity|
    puts "Hello, my name is #{entity.magic_number}."
    entity.state["test_value"] = entity.magic_number

    font = SDC::Font.load_from_file("demo_projects/Example_Test/assets/fonts/arial.ttf")
    entity.state["font"] = font

    text = SDC::Text.new(entity.param[0].value, font)
    text.position = SDC.xy(100 + entity.param[1].value * 5, 100 + entity.param[1].as_int * 5)
    text.color = SDC::Color.red
    entity.state["text"] = text

    entity.state["text_direction"] = 1

    SDC::AI.done

    ###

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

      # TODO: Maybe create a dedicated AI class or something?
      SDC::AI.switch_entity_to_hook(entity, "behavior")
    end
  end
  dummy_entity_data.add_hook("update", update_script)

  draw_script = SDC::AI::RubyScriptTemplatePage.create do |entity|
    text = entity.state["text"]
    
    SDC::AI.forever do
      text.draw
    end
  end
  dummy_entity_data.add_hook("draw", draw_script)

  entities = SDC::EntityGroup.new

  5.times do |i|
    new_entity = SDC::Entity.new(dummy_entity_data, SDC::Param.new([SDC::Param.new("Hello World"), SDC::Param.new(i)]))
    entities.add(new_entity)
  end

  scene.add_entity_group("main", entities)

  puts "Done"
end

update_procedure = SDC::AI::RubyScriptTemplatePage.create do |scene|
  SDC::AI.forever do
    SDC.for_window(scene.state["window2"]) do
      texture2 = scene.state["texture2"]
      texture2.offset.y += 1 if SDC::Keyboard.key_down?(SDC::Keyboard::K_DOWN)
      texture2.offset.y -= 1 if SDC::Keyboard.key_down?(SDC::Keyboard::K_UP)
      texture2.offset.x += 1 if SDC::Keyboard.key_down?(SDC::Keyboard::K_RIGHT)
      texture2.offset.x -= 1 if SDC::Keyboard.key_down?(SDC::Keyboard::K_LEFT)

      scene.update_entity_group("main")
    end

    SDC.for_window(scene.state["window"]) do
      scene.state["sprite"].angle += 2.0
      scene.state["sprite"].position = SDC::Mouse.position if SDC::Mouse.focused_window == scene.state["window"]
    end

    SDC.next_scene = nil unless scene.state["window"].open? || scene.state["window2"].open?

    errors = SDC.check_for_internal_errors
    puts "SDL error: #{errors}" if errors
  end
end

draw_procedure = SDC::AI::RubyScriptTemplatePage.create do |scene|
  SDC::AI.forever do
    SDC.for_window(scene.state["window"]) do
      SDC.current_window.clear

      SDC.current_window.render_and_display
    end
  
    SDC.for_window(scene.state["window2"]) do
      SDC.current_window.clear

      SDC.with_view(scene.state["view"]) do
        scene.draw_entity_group("main")
      end
      
      SDC.current_window.render_and_display
    end
  end
end

event_procedure = SDC::AI::RubyScriptTemplatePage.create do |scene|
  SDC::AI.forever do
    event = scene.last_event

    if event.type == SDC::Event::WINDOW
      win_id = event.as_window_event.window_id
      if event.as_window_event.event == SDC::WindowEvent::CLOSE
        close_window = true if win_id == 1
        close_window_2 = true if win_id == 2
      end
    elsif event.type == SDC::Event::KEYDOWN
      puts "Key pressed: #{event.as_key_event.key_name}"

      if event.as_key_event.key == SDC::Keyboard::K_M
        if scene.state["music"].current_music?
          if scene.state["music"].playing?
            scene.state["music"].pause
          else
            scene.state["music"].resume
          end
        else
          scene.state["music"].play
        end
      end

      scene.state["music"].volume += 10 if event.as_key_event.key == SDC::Keyboard::K_L

      scene.state["view"].x += 1 if event.as_key_event.key == SDC::Keyboard::K_V

      if event.as_key_event.key == SDC::Keyboard::K_S
        scene.state["sound"].volume = 64 + rand(64 + 1)
        scene.state["sound"].pitch = 0.8 + 0.4 * rand
        scene.state["sound"].play
      end
    end

    scene.state["window"].close if close_window
    scene.state["window2"].close if close_window_2
  end
end

exit_procedure = SDC::AI::RubyScriptTemplatePage.create do |scene|
  scene.state["window2"].unpin_all
end

test_update_procedure = SDC::AI::RubyScriptTemplatePage.create do |scene|
  SDC::AI.forever do
  end
end

dummy_scene_data = SDC::ObjectDataScene.new
dummy_scene_data.add_hook("init", init_procedure)
dummy_scene_data.add_hook("update", update_procedure)
dummy_scene_data.add_hook("draw", draw_procedure)
dummy_scene_data.add_hook("handle_event", event_procedure)

SDC.scene = SDC::Scene.new(dummy_scene_data)
