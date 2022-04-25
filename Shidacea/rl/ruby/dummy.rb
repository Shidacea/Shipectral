window = SDC::Window.new("Shipectral from Ruby", 800, 450)
window.target_fps = 60

test_text = SDC::Text.new(content: "Basic Shapes", position: SDC::Vector2.new(20, 20), font_size: 20, color: SDC::Color::DARKGRAY)
test_rectangle = SDC::ShapeBox.new(SDC::Vector2.new(120, 60), origin: SDC::Vector2.new(window.width/4*2 - 60, 100))
test_rectangle.color = SDC::Color::RED

until window.close?
  window.draw_routine do
    window.clear(color: SDC::Color::RAYWHITE)
    
    test_text.draw
    test_rectangle.draw

    a = SDC::Vector2.new(window.width / 4.0 * 3.0, 80.0)
    b = SDC::Vector2.new(window.width / 4.0 * 3.0 - 60.0, 150.0)
    c = SDC::Vector2.new(window.width / 4.0 * 3.0 + 60.0, 150.0)
  end
end

window.close