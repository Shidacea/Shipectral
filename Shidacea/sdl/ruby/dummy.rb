puts "Dummy file"

window = SDC::Window.new("Hello World", 800, 600)

texture = SDC::Texture.load_from_file("demo_projects/Example_Test/assets/graphics/test/Chishi.png", window)

window.draw_routine {
  window.draw(texture)
}

10000000.times {}

window.close