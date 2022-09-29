puts "Dummy file"

class SceneTest < SDC::Scene
  def at_init
    puts "Hello"
  end

  def update
    puts "UPDATE"
  end
end

s = SceneTest.new
s.init
s.main_update

window = SDC::Window.new("Hello World", 800, 600)
texture = SDC::Texture.load_from_file("demo_projects/Example_Test/assets/graphics/test/Chishi.png")

window2 = SDC::Window.new("Also Hi", 400, 400)
texture2 = SDC::Texture.load_from_file("demo_projects/Example_Test/assets/graphics/test/Chishi.png")

music = SDC::Music.load_from_file("demo_projects/Example_Test/assets/music/ExampleLoop.ogg")

music.play

while(window.open? || window2.open?)
  if window.open?
    SDC.current_window = window
    SDC.draw_routine do
      texture.draw
    end
  end

  if window2.open?
    SDC.current_window = window2
    SDC.draw_routine do
      texture2.draw
    end
  end

  SDC.update_routine do
    close_win, close_win_2 = SDC.poll_event_test
    window.close if close_win
    window2.close if close_win_2
  end
end
