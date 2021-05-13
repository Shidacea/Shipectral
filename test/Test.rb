window = SDC::Window.new(title: "Test window", width: 800, height: 600)

puts "Created a #{window.class}."

sound = SDC::Sound.new
sound_buffer = SDC::SoundBuffer.new
sound_buffer.load_from_file(filename: "Yeow.ogg")

texture = SDC::Texture.new
texture.load_from_file(filename: "Shipike.png")

sprite = SDC::Sprite.new
sprite.texture = texture

puts "Sound loaded."

sound.buffer = sound_buffer

puts "Sound linked."

sound.play

a = SDC::Coordinates.new(x: 2, y: 3)

puts "Test coordinates: #{a.x} #{a.y}"
a.x = 12
a.y *= 12
puts "Test coordinates: #{a.x} #{a.y}"

puts "Sound played."
puts 
puts "Close window with 'Esc'."

close_all = false

while !close_all
  # Both work
  sprite.draw(target: window, states: SDC::RenderStates.new)
  window.draw(drawable: sprite)
  
  window.display
  ev = window.poll_event

  if ev.is_a?(SDC::Event::KeyPressed)
    close_all = true if ev.code_to_int == 36
  elsif ev.is_a?(SDC::Event::Closed)
    close_all = true
  end
end

window.close

puts "Closed it."
