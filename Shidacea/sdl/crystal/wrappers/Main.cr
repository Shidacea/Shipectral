module SDC
  def self.start
    if LibSDL.init(LibSDL::INIT_VIDEO) != 0
      SDC.error "Could not initialize SDL"
    end
    
    if LibSDL.set_hint(LibSDL::HINT_RENDER_SCALE_QUALITY, "1") == 0
      SDC.warning "Linear texture filtering not enabled!"
    end
  end

  def self.quit
    LibSDL.quit
  end

  def self.error(message : String)
    sdl_error = String.new(LibSDL.get_error)
    raise "#{message}" + (sdl_error.empty? ? "" : "(SDL Error: #{sdl_error})")
  end

  def self.warning(message : String)
    puts "WARNING: #{message}"
  end
end