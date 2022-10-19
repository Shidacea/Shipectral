module SDC
  @[Anyolite::DefaultOptionalArgsToKeywordArgs]
  class Sound
    SDCHelper.wrap_type(Pointer(LibSDL::MixChunk))

    def initialize

    end

    def play
      LibSDL.mix_play_channel(-1, data, 0)
    end

    def volume
      LibSDL.mix_volume_chunk(data, -1)
    end

    def volume=(value : Number)
      LibSDL.mix_volume_chunk(data, value)
      volume
    end

    def free
      if @data
        LibSDL.mix_free_chunk(data)
        @data = nil
      end
    end

    def finalize
      free
    end

    def self.load_from_file(filename : String)
      sound = SDC::Sound.new
      sound.load_from_file!(filename)

      return sound
    end

    def load_from_file!(filename : String)
      free 

      @data = LibSDL.mix_load_wav(filename)
      SDC.error "Could not load sound from file #{filename}" unless @data
    end
  end
end
