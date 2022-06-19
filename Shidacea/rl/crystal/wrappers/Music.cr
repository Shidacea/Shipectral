module SDC
  @[Anyolite::DefaultOptionalArgsToKeywordArgs]
  class Music
    @data : Rl::Music?
    @volume : Float32 = 1.0
    @pitch : Float32 = 1.0

    @[Anyolite::Specialize]
    def initialize
    end

    def initialize(rl_music : Rl::Music)
      @data = rl_music
    end

    @[Anyolite::Exclude]
    def data
      @data.not_nil!
    end

    def finalize
      Rl.unload_music_stream(data)
    end

    def self.load_from_file(filename : String)
      Music.new(Rl.load_music_stream(filename))
    end
    
    def play
      Rl.play_music_stream(data)
    end

    def stop
      Rl.stop_music_stream(data)
    end

    def pause
      Rl.pause_music_stream(data)
    end

    def resume
      Rl.resume_music_stream(data)
    end

    def update
      Rl.update_music_stream(data)
    end

    def playing?
      Rl.music_stream_playing?(data)
    end

    def volume=(value : Number)
      @volume = value.to_f32
      Rl.set_music_volume(data, value)
    end

    def volume
      @volume
    end

    def pitch=(value : Number)
      @pitch = value.to_f32
      Rl.set_music_pitch(data, value)
    end

    def pitch
      @pitch
    end

    def looping=(value : Bool)
      data.looping = value
    end

    def looping
      data.looping
    end
  end
end