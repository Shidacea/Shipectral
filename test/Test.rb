window = SDC::Window.new(title: "Test window", width: 800, height: 600)

puts "Created a #{window.class}."

sound = SDC::Sound.new
sound_buffer = SDC::SoundBuffer.new
sound_buffer.load_from_file(filename: "Yeow.ogg")

puts "Sound loaded."

sound.buffer = sound_buffer

puts "Sound linked."

sound.play

puts "Sound played."
puts 
puts "Close window with 'Shift'."

close_all = false

while !close_all
  window.display
  ev = window.poll_event

  if ev.is_a?(SDC::Event::KeyPressed)
    close_all = true if ev.code_to_int == 36
  end
end

window.close

puts "Closed it."
