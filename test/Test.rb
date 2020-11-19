window = SF::RenderWindow.new("Test window", 800, 600)

puts "Created a #{window.class}."

sound = SF::Sound.new
sound_buffer = SF::SoundBuffer.new
sound_buffer.load_from_file("Yeow.ogg")

puts "Sound loaded."

sound.link_sound_buffer(sound_buffer)

puts "Sound linked."

sound.play

puts "Sound played."
puts 
puts "Close window with 'ESC'."

close_all = false

while !close_all
    window.display
    ev = window.poll_event

    if ev && ev.type == 6
        puts ev.key_code
        close_all = true if ev.key_code == 36
    end
end

window.close

puts "Closed it."

a = SF::Coordinates.new(3, 4)

puts a

a.x += 5

puts a

puts a + SF::Coordinates.new(3, 8)