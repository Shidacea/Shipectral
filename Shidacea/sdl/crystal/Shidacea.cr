SPT::Features.ensure("sdl")
SPT::Features.ensure("sdl-image")
SPT::Features.ensure("sdl-mixer")
SPT::Features.ensure("sdl-ttf")

def load_engine_library(rb)
  # TODO: This is only a template, SDL support is currently not planned
  if LibSDL.init(LibSDL::INIT_VIDEO) != 0
    raise "SDL could not initialize! SDL Error: #{String.new(LibSDL.get_error)}"
  end
  
  if LibSDL.set_hint(LibSDL::HINT_RENDER_SCALE_QUALITY, "1") == 0
    puts "Warning: Linear texture filtering not enabled!"
  end
  
  g_window = LibSDL.create_window("SDL Tutorial", LibSDL::WINDOWPOS_UNDEFINED, LibSDL::WINDOWPOS_UNDEFINED, 800, 600, LibSDL::WindowFlags::WINDOW_SHOWN)
  raise "Window could not be created! SDL Error: #{String.new(LibSDL.get_error)}" unless g_window
  
  g_renderer = LibSDL.create_renderer(g_window, -1, LibSDL::RendererFlags::RENDERER_ACCELERATED)
  raise "Renderer could not be created! SDL Error: #{String.new(LibSDL.get_error)}" unless g_renderer
  
  LibSDL.set_render_draw_color(g_renderer, 0xFF, 0xFF, 0xFF, 0xFF)
  
  img_flags = LibSDL::IMGInitFlags::IMG_INIT_PNG
  if (LibSDL.img_init(img_flags) | img_flags.to_i) == 0
    raise "SDL_image could not initialize! SDL_image Error: #{String.new(LibSDLMacro.img_get_error)}"
  end
  
  quit = false
  
  while(!quit)
    while LibSDL.poll_event(out e) != 0
      if e.type == LibSDL::EventType::QUIT.to_i
        quit = true
      end
    end
  
    LibSDL.set_render_draw_color(g_renderer, 0xFF, 0xFF, 0xFF, 0xFF)
    LibSDL.render_clear(g_renderer)
  
    fill_rect = LibSDL::Rect.new(x: 800 // 4, y: 600 // 4, w: 800 // 2, h: 600 // 2)
    LibSDL.set_render_draw_color(g_renderer, 0xFF, 0x00, 0x00, 0xFF)
    LibSDL.render_fill_rect(g_renderer, pointerof(fill_rect))
  
    outline_rect = LibSDL::Rect.new(x: 800 // 6, y: 600 // 6, w: 800*2 // 3, h: 600*2 // 3)
    LibSDL.set_render_draw_color(g_renderer, 0x00, 0xFF, 0x00, 0xFF)
    LibSDL.render_draw_rect(g_renderer, pointerof(outline_rect))
  
    LibSDL.set_render_draw_color(g_renderer, 0x00, 0x00, 0xFF, 0xFF)
    LibSDL.render_draw_line(g_renderer, 0, 600 // 2, 800, 600 // 2)
  
    LibSDL.set_render_draw_color(g_renderer, 0xFF, 0xFF, 0x00, 0xFF)
    0.step(to: 600, by: 4) do |i|
      LibSDL.render_draw_point(g_renderer, 800 // 2, i)
    end
  
    LibSDL.render_present(g_renderer)
  end
  
  LibSDL.destroy_renderer(g_renderer)
  LibSDL.destroy_window(g_window)
  
  LibSDL.img_quit
  LibSDL.quit
end