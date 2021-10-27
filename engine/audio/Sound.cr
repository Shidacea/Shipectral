module SF
  @[Anyolite::SpecializeInstanceMethod("initialize", nil)]
  class Sound
    @[Anyolite::WrapWithoutKeywords]
    def link_sound_buffer(buffer : SF::SoundBuffer)
      self.buffer = buffer
    end
  end
end

def setup_ruby_sound_class(rb)
  Anyolite.wrap(rb, SF::Sound, under: SF, verbose: true, connect_to_superclass: false)
end
