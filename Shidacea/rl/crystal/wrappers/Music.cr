module SDC
  @[Anyolite::DefaultOptionalArgsToKeywordArgs]
  class Music
    @music : Rl::Music?
    @volume : Float32 = 1.0
    @pitch : Float32 = 1.0

    @[Anyolite::Specialize]
    def initialize
    end

    def initialize(rl_music : Rl::Music)
      @music = rl_music
    end

    def finalize
      Rl.unload_music_stream(@music.not_nil!)
    end

    def self.load_from_file(filename : String)
      Music.new(Rl.load_music_stream(filename))
    end
    
    def play
      Rl.play_music_stream(@music.not_nil!)
    end

    def stop
      Rl.stop_music_stream(@music.not_nil!)
    end

    def pause
      Rl.pause_music_stream(@music.not_nil!)
    end

    def resume
      Rl.resume_music_stream(@music.not_nil!)
    end

    def update
      Rl.update_music_stream(@music.not_nil!)
    end

    def playing?
      Rl.music_stream_playing?(@music.not_nil!)
    end

    def volume=(value : Number)
      @volume = value.to_f32
      Rl.set_music_volume(@music.not_nil!, value)
    end

    def volume
      @volume
    end

    def pitch=(value : Number)
      @pitch = value.to_f32
      Rl.set_music_pitch(@music.not_nil!, value)
    end

    def pitch
      @pitch
    end

    def looping=(value : Bool)
      @music.not_nil!.looping = value
    end

    def looping
      @music.not_nil!.looping
    end
  end
end