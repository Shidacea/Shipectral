module SDC
  @[Anyolite::DefaultOptionalArgsToKeywordArgs]
  class Sound
    @data : Rl::Sound?
    @volume : Float32 = 1.0
    @pitch : Float32 = 1.0

    @[Anyolite::Specialize]
    def initialize
    end

    def initialize(rl_sound : Rl::Sound)
      @data = rl_sound
    end

    @[Anyolite::Exclude]
    def data
      @data.not_nil!
    end

    def finalize
      Rl.unload_sound(data)
    end

    # TODO: Catch nil sounds with mruby errors

    def self.load_from_file(filename : String)
      Sound.new(Rl.load_sound(filename))
    end
    
    def play
      Rl.play_sound(data)
    end

    def stop
      Rl.stop_sound(data)
    end

    def pause
      Rl.pause_sound(data)
    end

    def resume
      Rl.resume_sound(data)
    end

    def playing?
      Rl.sound_playing?(data)
    end

    def volume=(value : Number)
      @volume = value.to_f32
      Rl.set_sound_volume(data, value)
    end

    def volume
      @volume
    end

    def pitch=(value : Number)
      @pitch = value.to_f32
      Rl.set_sound_pitch(data, value)
    end

    def pitch
      @pitch
    end
  end
end