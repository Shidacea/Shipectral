window = SDC::Window.new("Shipectral from Ruby", 800, 450)
window.target_fps = 60

audio_device = SDC::AudioDevice.new

test_text = SDC::Text.new(content: "Let's see what Shipectral can do so far...", position: SDC.xy(20, 20), font_size: 20, color: SDC::Color::DARKGRAY)

test_rectangle = SDC::ShapeBox.new(SDC.xy(360, 120), origin: SDC.xy(200, 100))
test_rectangle.color = SDC::Color::RED

test_circle = SDC::ShapeCircle.new(200, origin: SDC.xy(window.width/5, 300))
test_circle.color = SDC::Color::ORANGE

triangle_pos = SDC.xy(window.width / 4.0 * 3.0, 80.0)
triangle_side_1 = SDC.xy(-60.0, 70.0)
triangle_side_2 = SDC.xy(60.0, 70.0)
test_triangle = SDC::ShapeTriangle.new(triangle_side_1, triangle_side_2, origin: triangle_pos)
test_triangle.color = SDC::Color::VIOLET

test_line = SDC::ShapeLine.new(SDC.xy(window.width - 18, 42), origin: SDC.xy(17, 42))
test_line.color = SDC::Color::BLACK

test_image = SDC::Image.load_from_file("demo_projects/Example_Test/assets/graphics/test/Chishi.png")
test_texture = test_image.to_texture
test_texture.origin = SDC.xy(200, 350)

sound = SDC::Sound.load_from_file("demo_projects/Example_Test/assets/sounds/Yeow.ogg")
sound.pitch *= 0.5
once = true

window.icon = test_image

render_queue = SDC::RenderQueue.new

until window.close?
  window.draw_routine do
    window.clear(color: SDC::Color::RAYWHITE)
    
    window.draw test_text
    window.draw test_rectangle, z: 1
    window.draw test_circle

    test_text.content += "." if rand < 0.01

    window.draw test_texture, z: 3
    window.draw test_line

    window.title = "FPS: #{window.fps}"

    if once == true
      sound.play 
      once = false
    end

    draw_high = SDC::Keyboard.key_up?(SDC::Keyboard::Key::Space)

    window.draw SDC::ShapeEllipse.new(SDC.xy(60, 80), origin: SDC.xy(280, 260)), z: draw_high ? 2 : 0
  end
end

window.close
audio_device.close