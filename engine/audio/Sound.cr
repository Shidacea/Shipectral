module SF
  @[Anyolite::ExcludeInstanceMethod("inspect")]
  class Sound
  end
end

def setup_ruby_sound_class(rb)
  Anyolite.wrap(rb, SF::Sound, under: SF, verbose: true, wrap_superclass: false)
end
