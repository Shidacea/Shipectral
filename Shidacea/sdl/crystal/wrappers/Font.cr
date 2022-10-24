module SDC
  @[Anyolite::DefaultOptionalArgsToKeywordArgs]
  class Font
    SDCHelper.wrap_type(Pointer(LibSDL::TTFFont))

    def initialize

    end

    def self.load_from_file(filename : String, size : Number = 16)
      font = SDC::Font.new
      font.load_from_file!(filename, size)

      return font
    end

    @[Anyolite::ReturnNil]
    def load_from_file!(filename : String, size : Number)
      free

      @data = LibSDL.ttf_open_font(filename, size)
      SDC.error "Could not font from file #{filename}" unless @data
    end

    def free
      if @data
        LibSDL.ttf_close_font(data)
      end
    end

    def finalize
      free
    end
  end
end