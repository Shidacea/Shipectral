window = SDC::RenderWindow.new("Test window", 800, 600)

puts "Created a #{window.class}."

sound = SDC::Sound.new
sound_buffer = SDC::SoundBuffer.new
sound_buffer.load_from_file("Yeow.ogg")

puts "Sound loaded."

sound.link_sound_buffer(sound_buffer)

puts "Sound linked."

sound.play

puts "Sound played."

# Ensure sound playing
100000.times do |i|
    #puts i
end

window.close

puts "Closed it."