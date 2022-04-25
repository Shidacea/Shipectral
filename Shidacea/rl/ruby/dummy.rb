puts "Dummy file"

c = SDC::Vector2.new(300, 200)

c = c.add(c)

c.x += 1

puts c.x
puts c.y

test_color = SDC::Color.new(255, 255, 255)
test_color_2 = SDC::Color.new(255, 255, 255, 128)

rect = SDC::Rectangle.new(100, 200)
rect_2 = SDC::Rectangle.new(100, 200, origin: SDC::Vector2.new(100, 200))

window = SDC::Window.new("Shipectral from Ruby", 800, 450)
window.target_fps = 60

until window.close?
  window.demo_run
end

window.close