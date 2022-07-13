# Demo for SDC/Rl
# This will be removed, once SDC/Rl is tested enough

# Did you know that this code is also valid Crystal code and works exactly the same then?

window = SDC::Window.new "Shipectral from Ruby", 800, 450
window.target_fps = 60

audio_device = SDC::AudioDevice.new

test_text = SDC::Text.new(content: "Let's see what Shipectral can do so far...", position: SDC.xy(20, 20), font_size: 20, color: SDC::Color::DARKGRAY)

mouse_pos_text = SDC::Text.new(content: "  Mouse position: ---", position: SDC::Mouse.position, font_size: 20, color: SDC::Color::DARKGRAY)

test_rectangle = SDC::ShapeBox.new(SDC.xy(360, 120), origin: SDC.xy(200, 100))
test_rectangle.color = SDC::Color::RED

test_circle = SDC::ShapeCircle.new(200, origin: SDC.xy(window.width/5, 300))
test_circle.color = SDC::Color::ORANGE

triangle_pos = SDC.xy(window.width / 4.0 * 3.0, 300.0)
triangle_side_1 = SDC.xy(-60.0, 70.0)
triangle_side_2 = SDC.xy(60.0, 70.0)
test_triangle = SDC::ShapeTriangle.new(triangle_side_1, triangle_side_2, origin: triangle_pos)
test_triangle.color = SDC::Color::VIOLET

test_line = SDC::ShapeLine.new(SDC.xy(window.width - 18, 42), origin: SDC.xy(17, 42))
test_line.color = SDC::Color::BLACK

test_image = SDC::Image.load_from_file "demo_projects/Example_Test/assets/graphics/test/Chishi.png"
test_texture = test_image.to_texture
test_texture.origin = SDC.xy(200, 350)

sound = SDC::Sound.load_from_file "demo_projects/Example_Test/assets/sounds/Yeow.ogg"
sound.pitch *= 0.5
once = true

music = SDC::Music.load_from_file "demo_projects/Example_Test/assets/music/Example.ogg"
music.volume *= 0.5
music.play
music.pause

test_map = SDC::Map.new

test_view = SDC::View.new
test_view.zoom = 2.0
test_view.target = SDC.xy(100, 100)
test_view.offset = SDC.xy(200, 200)

basic_view = SDC::View.new

window.icon = test_image

# Views are valid for their z coordinate and higher
window.add_static test_view, z: 0
window.add_static test_map

# Make sure to optimize map drawing
test_map.range = SDC::Rectangle.new(0, 0, 4, 4)

# If a new view is applied, it will replace all earlier views with the same z.
# However, views with lower or higher z will still be valid.
#
# Best practice is to dedicate views to a specific range of z coordinates.
# For the rare case in which you need disjunct z ranges, just activate the view again.
window.with_view_static basic_view, z_offset: 0 do
  window.add_static test_text
  window.add_static test_line
  window.add_static test_triangle
  window.add_static test_rectangle, z: 2
  window.add_static mouse_pos_text, z: 4
end

until window.close?
  window.draw_routine do
    window.clear color: SDC::Color::RAYWHITE
    
    window.with_z_offset 1 do
      window.draw test_circle, z: 0
    end

    window.draw test_texture, z: 3

    # Since the static table has pointers, this does work perfectly
    test_text.content += "." if rand < 0.01

    mouse_pos_text.content = "  Mouse position: #{SDC::Mouse.position}"
    mouse_pos_text.position = SDC::Mouse.position
    
    window.title = "FPS: #{window.fps}"

    if once == true
      sound.play 
      once = false
    end

    music.update

    if SDC::Keyboard.key_pressed?(SDC::Keyboard::Key::M)
      if music.playing?
        music.pause
      else
        music.resume
      end
    end

    draw_high = SDC::Keyboard.key_up?(SDC::Keyboard::Key::Space)

    window.draw SDC::ShapeEllipse.new(SDC.xy(60, 80), origin: SDC.xy(280, 260)), z: draw_high ? 3 : 0

    window.delete_static(test_rectangle, z: 2) if SDC::Keyboard.key_pressed?(SDC::Keyboard::Key::D)

    test_view.rotation += 1.0 if SDC::Keyboard.key_down?(SDC::Keyboard::Key::R)
  end
end

window.close
audio_device.close