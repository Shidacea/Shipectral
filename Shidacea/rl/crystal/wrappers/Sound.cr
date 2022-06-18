module SDC
  @[Anyolite::DefaultOptionalArgsToKeywordArgs]
  class Sound
    @sound : Rl::Sound?

    @[Anyolite::Specialize]
    def initialize
    end

    def initialize(rl_sound : Rl::Sound)
      @sound = rl_sound
    end

    def self.load_from_file(filename : String)
      Sound.new(Rl.load_sound(filename))
    end
    
    def play
      Rl.play_sound(@sound.not_nil!)
    end

    def stop
      Rl.stop_sound(@sound.not_nil!)
    end

    def pause
      Rl.pause_sound(@sound.not_nil!)
    end

    def resume
      Rl.resume_sound(@sound.not_nil!)
    end

    def playing?
      Rl.sound_playing?(@sound.not_nil!)
    end

    def volume=(value : Number)
      Rl.set_sound_volume(@sound.not_nil!, value)
    end

    def pitch=(value : Number)
      Rl.set_sound_pitch(@sound.not_nil!, value)
    end
  end
end