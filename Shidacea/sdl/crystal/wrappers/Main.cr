@[Anyolite::DefaultOptionalArgsToKeywordArgs]
module SDC
  class_property scene : SDC::Scene?
  class_property next_scene : SDC::Scene | Bool | Nil
  class_property limiter : SDC::Limiter?

  @@current_window : SDC::Window?

  def self.main_routine(scene : SDC::Scene)
    @@limiter = SDC::Limiter.new

    @@limiter.not_nil!.set_update_routine do
      #@@scene.not_nil!.process_events
      @@scene.not_nil!.main_update 

      if !@@next_scene
        @@scene.not_nil!.at_exit
        @@scene = nil
      elsif @@next_scene != true
        @@scene.not_nil!.at_exit
        @@scene = @@next_scene.as?(SDC::Scene).not_nil!
        @@next_scene = nil
        @@scene.not_nil!.init
      end
    end

    @@limiter.not_nil!.set_draw_routine do
      @@scene.not_nil!.main_draw
    end

    @@scene = scene
    @@scene.not_nil!.init
    @@next_scene = true

    while @@next_scene
      break if !@@limiter.not_nil!.tick
    end
  end

  def self.init
    if LibSDL.init(LibSDL::INIT_EVERYTHING) != 0
      SDC.error "Could not initialize SDL"
    end
    
    if LibSDL.set_hint(LibSDL::HINT_RENDER_SCALE_QUALITY, "1") == 0
      SDC.warning "Linear texture filtering not enabled!"
    end

    img_flags = LibSDL::IMGInitFlags::IMG_INIT_PNG
    if (LibSDL.img_init(img_flags) | img_flags.to_i) == 0
      SDC.error "Could not initialize SDL_image"
    end

    if LibSDL.mix_open_audio(44100, LibSDL::MIX_DEFAULT_FORMAT, 2, 2048) < 0
      SDC.error "Could not initialize SDL_mixer"
    end
  end

  def self.current_window
    if window = @@current_window
      window
    else
      SDC.error "No current window available"
    end
  end

  def self.current_window=(window : SDC::Window?)
    @@current_window = window
  end

  def self.quit
    LibSDL.mix_quit
    LibSDL.img_quit
    LibSDL.quit
  end

  def self.error(message : String)
    sdl_error = String.new(LibSDL.get_error)
    raise "#{message}" + (sdl_error.empty? ? "" : "(SDL Error: #{sdl_error})")
  end

  def self.debug_log(message : String)
    puts "DEBUG: #{message}" if SPT::Script.debug?
  end

  def self.log(message : String)
    puts "LOG: #{message}"
  end

  def self.warning(message : String)
    puts "WARNING: #{message}"
  end

  @[Anyolite::AddBlockArg(1, Pointer(LibSDL::Event))]
  def self.poll_events
    while LibSDL.poll_event(out e) != 0
      yield e
    end
  end

  # TODO: This is just to test event polling with multiple windows
  def self.poll_event_test
    close_window, close_window_2 = false, false
    SDC.poll_events do |e|
      if e.type == LibSDL::EventType::WINDOWEVENT.to_i
        win_id = e.window.window_id
        if e.window.event == LibSDL::WindowEventID::WINDOWEVENT_CLOSE.to_i
          close_window = true if win_id == 1
          close_window_2 = true if win_id == 2
        end
      end
    end

    [close_window, close_window_2]
  end
end
