def setup_ruby_keyboard_class(rb)
  Anyolite.wrap(rb, SF::Keyboard, under: SF, verbose: true, connect_to_superclass: false)
end
