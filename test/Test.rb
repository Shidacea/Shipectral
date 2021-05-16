window = SDC::Window.new("Test window", 800, 600)

puts "Created a #{window.class}."

coll = SDC::CollisionShapeLine.new
coll.line = SDC::Coordinates.new(0.3, 0.5)
coll.line += SDC::Coordinates.new(0.34, 0.54)

puts coll.line

sound = SDC::Sound.new
sound_buffer = SDC::SoundBuffer.new
sound_buffer.load_from_file("Yeow.ogg")

texture = SDC::Texture.new
texture.load_from_file("Shipike.png")

sprite = SDC::Sprite.new
sprite.texture = texture

puts "Sound loaded."

sound.buffer = sound_buffer

puts "Sound linked."

sound.play

a = SDC::Coordinates.new(2, 3)

puts "Test coordinates: #{a.x} #{a.y}"
a.x = 12
a.y *= 12
puts "Test coordinates: #{a.x} #{a.y}"

puts "Sound played."
puts 
puts "Close window with 'Esc'."

class ErbTest
  def initialize(*items)
    @items = items
  end
end

e = ErbTest.new("Cake", "Books", "Food", "Dark badge of deathly death")

erb_test = ERB.new("Items: <%= @items.join(', ') %>")
puts erb_test.result(e)

close_all = false

while !close_all
  # Both work
  sprite.draw(target: window)
  window.draw(drawable: sprite)

  window.display
  ev = window.poll_event

  if ev.is_a?(SDC::Event::KeyPressed)
    close_all = true if ev.code == SDC::Keyboard::Key::Escape
  elsif ev.is_a?(SDC::Event::Closed)
    close_all = true
  end
end

window.close

puts "Closed it."
