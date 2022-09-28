module SDC
  @[Anyolite::DefaultOptionalArgsToKeywordArgs]
  class Music
    SDCHelper.wrap_type(LibSDL::MixMusic)

    def initialize

    end

    def play
      LibSDL.mix_play_music(data, -1)
    end

    def free
      if @data
        LibSDL.mix_free_music(data)
        @data = nil
      end
    end

    def finalize
      free
    end

    def self.load_from_file(filename : String)
      music = SDC::Music.new
      music.load_from_file!(filename)

      return music
    end

    def load_from_file!(filename : String)
      free 

      @data = LibSDL.mix_load_mus(filename)
      SDC.error "Could not load music from file #{filename}" unless @data
    end
  end
end
