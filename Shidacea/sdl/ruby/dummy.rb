puts "Dummy file"

window = SDC::Window.new("Hello World", 800, 600)
texture = SDC::Texture.load_from_file("demo_projects/Example_Test/assets/graphics/test/Chishi.png", window)

window2 = SDC::Window.new("Also Hi", 400, 400)
texture2 = SDC::Texture.load_from_file("demo_projects/Example_Test/assets/graphics/test/Chishi.png", window2)

music = SDC::Music.load_from_file("demo_projects/Example_Test/assets/music/ExampleLoop.ogg")

music.play

while(window.open? || window2.open?)
  if window.open?
    window.draw_routine {window.draw(texture)}
  end

  if window2.open?
    window2.draw_routine {window2.draw(texture2)}
  end

  close_win, close_win_2 = SDC.poll_event_test

  window.close if close_win
  window2.close if close_win_2
end
