module SDC
  @[Anyolite::DefaultOptionalArgsToKeywordArgs]
  class Sound
    @sound : Rl::Sound?
    @volume : Float32 = 1.0
    @pitch : Float32 = 1.0

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
      @volume = value.to_f32
      Rl.set_sound_volume(@sound.not_nil!, value)
    end

    def volume
      @volume
    end

    def pitch=(value : Number)
      @pitch = value.to_f32
      Rl.set_sound_pitch(@sound.not_nil!, value)
    end

    def pitch
      @pitch
    end
  end
end