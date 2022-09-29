puts "Dummy file"

window = SDC::Window.new("Hello World", 800, 600)
texture = SDC::Texture.load_from_file("demo_projects/Example_Test/assets/graphics/test/Chishi.png")

window2 = SDC::Window.new("Also Hi", 400, 400)
texture2 = SDC::Texture.load_from_file("demo_projects/Example_Test/assets/graphics/test/Chishi.png")

music = SDC::Music.load_from_file("demo_projects/Example_Test/assets/music/ExampleLoop.ogg")
music.play

limiter = SDC::Limiter.new

limiter.set_draw_routine do 
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
end

limiter.set_update_routine do
  close_win, close_win_2 = SDC.poll_event_test
  window.close if close_win
  window2.close if close_win_2
end

while(window.open? || window2.open?)
  limiter.tick
end
